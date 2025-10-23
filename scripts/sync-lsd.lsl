/*
Synchronised Linkset Data
-------------------------
This script helps synchronise linkset data across objects in a region.
Turning linkset data to be region-wide.

* On initialisation, the script will try to read existing data from the region
    * Otherwise it will act as the initial source of data for the region
    * The source of truth is always the object that has survived the longest (OBJECT_CREATION_TIME)
    * Will delete local data first that matches the scope to avoid stale data
* Only data names that match the scope will be synchronised
* When data is updated, it will write the new value to the region
* When data is deleted, it will delete the value from the region
* When data is multi-deleted, it will delete all matching values from the region
* When the linkset is reset, it will delete all values from the region
* The script will ignore updates that it has made itself to prevent loops (via pending)
* The script will ignore updates that are not verified via RSA signatures
    * This prevents unauthorised objects from injecting data into the region
    * Each object must have the correct public/private key pair configured in the script
* Alternatively you can replace the listener security mechanism with simpler llGetOwnerKey checks if suitable
* Although the script has been upgraded to handle larger data values (where name+value meets the chat message limit of 1024 bytes),
  it is still recommended to keep data values small for performance reasons as the logic for splitting and reassembling
  can be costly (>200ms) due to not being able to count bytes of strings directly. Alternatively you can synchronise larger
  values manually outside of this script if performance is critical where you have better domain specific knowledge of the data.
*/

///--- START OF CONFIGURATION ---
// Change per project
#define DATA_CHANNEL 123910

// To avoid conflict vs local data, recommend a unique prefix for region-wide data, these are regexes
list scope = [
    "^TEST_"
];

// Generate a RSA key and add the private and public strings here
string privateKey = "-----BEGIN RSA PRIVATE KEY-----
generate RSA key pair and put private key here
-----END RSA PRIVATE KEY-----";
string publicKey = "-----BEGIN PUBLIC KEY-----
generate RSA key pair and put public key here
-----END PUBLIC KEY-----";
///--- END OF CONFIGURATION ---


#define EVENT_PING 1
#define EVENT_PONG 2
#define EVENT_REQUEST 3
#define EVENT_DATA 4
#define EVENT_DATA_FRAGMENT 5
#define EVENT_DATA_END 6

key source;
integer sourceCreation;

list pending = [/* integer action, string name */];
list verified;
list buffer = [/* string name, string value */];

// From https://wiki.secondlife.com/wiki/Stamp2UnixInt
integer uStamp2UnixInt(list vLstStp) { // CC0 by Void Singer
    integer vIntYear = llList2Integer(vLstStp, 0) - 1902;
    integer vIntRtn;
    if (vIntYear >> 31 | vIntYear / 136)
    {
        vIntRtn = 2145916800 * (1 | vIntYear >> 31);
    }
    else
    {
        integer vIntMnth = ~-llList2Integer(vLstStp, 1);
        vIntRtn = 86400 * ((integer)(vIntYear * 365.25 + 0.25) - 24837 +
          vIntMnth * 30 + (vIntMnth - (vIntMnth < 7) >> 1) + (vIntMnth < 2) -
          (((vIntYear + 2) & 3) > 0) * (vIntMnth > 1) +
          (~-llList2Integer(vLstStp, 2)) ) +
          llList2Integer(vLstStp, 3) * 3600 +
          llList2Integer(vLstStp, 4) * 60 +
          llList2Integer(vLstStp, 5);
    }
    return vIntRtn;
}

// From https://wiki.secondlife.com/wiki/LlStringToBase64
integer getStringBytes(string msg) {
    return (llStringLength((string)llParseString2List(llStringToBase64(msg), ["="], [])) * 3) >> 2;
}

// Sends linkset data as packed chat message(s) to target or broadcast
sendData(key target, integer action, string name, string value) {
    integer nameLength = llStringLength(name);
    if(action == LINKSETDATA_UPDATE)
    {
        integer available = 1024 - (5 + nameLength);
        integer total = getStringBytes(value);
        integer isASCII = (total == llStringLength(value)); // Prefer llStringLength as its fastest
        if(total > available)
        {
            while(value)
            {
                string fragment = "";
                integer width = 0;
                while(total > 0) {
                    string part = llGetSubString(value, 0, 250);
                    integer bytes;
                    if(isASCII) bytes = llStringLength(part);
                    else bytes = getStringBytes(part);
                    
                    if(width + bytes <= available)
                    {
                        value = llDeleteSubString(value, 0, 250);
                        width += bytes;
                        total -= bytes;
                        fragment += part;
                    }
                    else jump breakFragment;
                }
                @breakFragment;
                
                integer eventType = EVENT_DATA_FRAGMENT;
                if(value == "") eventType = EVENT_DATA_END;
                
                string message = llChar(eventType) + llChar(nameLength) + name + fragment;
                if(target) llRegionSayTo(target, DATA_CHANNEL, message);
                else llRegionSay(DATA_CHANNEL, message);
            }
        }
        else
        {
            string message = llChar(EVENT_DATA) + llChar(action + 1) + llChar(nameLength) + name + value;
            if(target) llRegionSayTo(target, DATA_CHANNEL, message);
            else llRegionSay(DATA_CHANNEL, message);
        }
    }
    
    else
    {
        string message = llChar(EVENT_DATA) + llChar(action + 1) + llChar(nameLength) + name + value;
        if(target) llRegionSayTo(target, DATA_CHANNEL, message);
        else llRegionSay(DATA_CHANNEL, message);
    }
}

default
{
    state_entry()
    {
        llListen(DATA_CHANNEL, "", "", "");
        llRegionSay(DATA_CHANNEL,
            llChar(EVENT_PING) +
            llSignRSA(privateKey, (string)llGetKey() + " " + llGetDate(), "sha512")
        );
    }
    
    on_rez(integer param)
    {
        llRegionSay(DATA_CHANNEL,
            llChar(EVENT_PING) +
            llSignRSA(privateKey, (string)llGetKey() + " " + llGetDate(), "sha512")
        );
    }
    
    listen(integer channel, string name, key identifier, string message)
    {
        integer eventType = llOrd(message, 0);
        
        if(eventType == EVENT_PING || eventType == EVENT_PONG)
        {
            string signature = llGetSubString(message, 1, -1);
            string expected = (string)identifier + " " + llGetDate();
            if(!llVerifyRSA(publicKey, expected, signature, "sha512")) return;
            
            integer iterator = llGetListLength(verified);
            while(iterator)
            {
                if(llKey2Name(llList2Key(verified, iterator)) == "")
                    verified = llDeleteSubList(verified, iterator, iterator);
            }
            verified += identifier;
            
            if(eventType == EVENT_PING)
            {
                llRegionSayTo(identifier, DATA_CHANNEL,
                    llChar(EVENT_PONG) +
                    llSignRSA(privateKey, (string)llGetKey() + " " + llGetDate(), "sha512")
                );
            }
            
            else if(eventType == EVENT_PONG)
            {
                llSetTimerEvent(FALSE);
                llSetTimerEvent(0.5);
                
                integer creation = uStamp2UnixInt(llParseString2List(llList2String(llGetObjectDetails(identifier, [OBJECT_CREATION_TIME]), 0), ["-", "T", ":", "."], []));
                if(creation < sourceCreation || source == "")
                {
                    source = identifier;
                    sourceCreation = creation;
                }
            }
        }
        
        else if(llListFindList(verified, [identifier]) == -1) return;
        
        
        if(eventType == EVENT_DATA)
        {
            integer action = llOrd(message, 1) - 1;
            integer nameLength = llOrd(message, 2);
            string name = llGetSubString(message, 3, 2 + nameLength);
            string value = llGetSubString(message, 3 + nameLength, -1);
            
            if(action == LINKSETDATA_UPDATE)
            {
                pending += [action, name];
                llLinksetDataWrite(name, value);
            }
            
            else if(action == LINKSETDATA_DELETE)
            {
                pending += [action, name];
                llLinksetDataDelete(name);
            }
            
            else if(action == LINKSETDATA_MULTIDELETE)
            {
                list names = llJson2List(name);
                integer iterator = llGetListLength(names);
                while(iterator --> 0)
                {
                    name = llList2String(names, iterator);
                    pending += [action, name];
                    llLinksetDataDelete(name);
                }
            }
            
            else if(action == LINKSETDATA_RESET)
            {
                pending += [action, ""];
                llLinksetDataReset();
            }
        }
        
        else if(eventType == EVENT_DATA_FRAGMENT || eventType == EVENT_DATA_END)
        {
            integer nameLength = llOrd(message, 1);
            string name = llGetSubString(message, 2, 1 + nameLength);
            string value = llGetSubString(message, 2 + nameLength, -1);
            
            integer pointer = llListFindStrided(buffer, [name], 0, -1, 2);
            if(eventType == EVENT_DATA_FRAGMENT)
            {
                string prev = llList2String(buffer, pointer + 1);
                buffer = llListReplaceList(buffer, [prev + value], pointer + 1, pointer + 1);
            }
            
            else // if(eventType == EVENT_DATA_END)
            {
                string prev = llList2String(buffer, pointer + 1);
                buffer = llDeleteSubList(buffer, pointer, pointer + 1);
                value = prev + value;
                
                pending += [LINKSETDATA_UPDATE, name];
                llLinksetDataWrite(name, value);
            }
        }
        
        else if(eventType == EVENT_REQUEST)
        {
            integer sent = 0;
            integer iterator = llGetListLength(scope);
            while(iterator --> 0)
            {
                string pattern = llList2String(scope, iterator);
                list names = llLinksetDataFindKeys(pattern, 0, FALSE);
                integer nameIterator = llGetListLength(names);
                while(nameIterator --> 0)
                {
                    string name = llList2String(names, nameIterator);
                    string value = llLinksetDataRead(name);
                    sendData(identifier, LINKSETDATA_UPDATE, name, value);
                    if((++sent % 16) == 0) llSleep(4/45.); // Avoid flooding
                }
            }
        }
    }
    
    linkset_data(integer action, string name, string value)
    {
        if(pending)
        {
            integer pendingAction = llList2Integer(pending, 0);
            string pendingName = llList2String(pending, 1);
            if(action == pendingAction)
            {
                if((action == LINKSETDATA_UPDATE || action == LINKSETDATA_DELETE) && name == pendingName)
                {
                    pending = llDeleteSubList(pending, 0, 1);
                    return;
                }
                
                else // MULTIDELETE or RESET
                {
                    pending = llDeleteSubList(pending, 0, 1);
                    return;
                }
            }
        }
        
        sendData(NULL_KEY, action, name, value);
    }
    
    timer()
    {
        llSetTimerEvent(FALSE);
        
        // Clear our local data, we are going to re-request everything from the source
        integer iterator = llGetListLength(scope);
        while(iterator --> 0)
        {
            string pattern = llList2String(scope, iterator);
            pending += [LINKSETDATA_MULTIDELETE, pattern];
            llLinksetDataDeleteFound(pattern, "");
        }
        
        llRegionSayTo(source, DATA_CHANNEL, llChar(EVENT_REQUEST));
    }
}
