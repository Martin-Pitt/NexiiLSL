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
* The script will ignore updates that are not from the same owner as itself (per llGetOwnerKey)

*/

// Change per project
#define DATA_CHANNEL -40030025

// To avoid conflict vs local data, use a unique prefix for region-wide data
list scope = [
    "EXAMPLE_"
];

key source;
integer sourceCreation;

list pending = [/* integer action, string name */];

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


default
{
    state_entry()
    {
        llListen(DATA_CHANNEL, "", "", "");
        llRegionSay(DATA_CHANNEL, llList2Json(JSON_OBJECT, ["event", "ping"]));
    }
    
    listen(integer channel, string name, key identifier, string message)
    {
        if(llGetOwnerKey(identifier) != llGetOwner()) return;
        string eventName = llJsonGetValue(message, ["event"]);
        
        if(eventName == "data")
        {
            integer action = (integer)llJsonGetValue(message, ["action"]);
            string dataName = llJsonGetValue(message, ["name"]);
            string dataValue = llJsonGetValue(message, ["value"]);
            
            if(action == LINKSETDATA_UPDATE)
            {
                pending += [action, dataName];
                llLinksetDataWrite(dataName, dataValue);
            }
            
            else if(action == LINKSETDATA_DELETE)
            {
                pending += [action, dataName];
                llLinksetDataDelete(dataName);
            }
            
            else if(action == LINKSETDATA_MULTIDELETE)
            {
                list names = llJson2List(dataName);
                integer iterator = llGetListLength(names);
                while(iterator --> 0)
                {
                    dataName = llList2String(names, iterator);
                    pending += [action, dataName];
                    llLinksetDataDelete(dataName);
                }
            }
            
            else if(action == LINKSETDATA_RESET)
            {
                pending += [action, ""];
                llLinksetDataReset();
            }
        }
        
        else if(eventName == "ping")
        {
            llRegionSayTo(identifier, DATA_CHANNEL, llList2Json(JSON_OBJECT, ["event", "pong"]));
        }
        
        else if(eventName == "pong")
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
        
        else if(eventName == "request")
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
                    llRegionSayTo(identifier, DATA_CHANNEL, llList2Json(JSON_OBJECT, [
                        "event", "data",
                        "action", LINKSETDATA_UPDATE,
                        "name", name,
                        "value", value
                    ]));
                    
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
        
        llRegionSay(DATA_CHANNEL, llList2Json(JSON_OBJECT, [
            "event", "data",
            "action", action,
            "name", name,
            "value", value
        ]));
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
        
        llRegionSayTo(source, DATA_CHANNEL, llList2Json(JSON_OBJECT, ["event", "request"]));
    }
}
