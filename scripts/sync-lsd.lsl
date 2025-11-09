/*
Synchronised Linkset Data
-------------------------
This script helps synchronise linkset data across objects in a region.
Turning linkset data to be region-wide.
*/

///--- START OF CONFIGURATION ---
// Change per project
#define DATA_CHANNEL 123910

// To avoid conflict vs local data, recommend a unique prefix for region-wide data, these are string prefixes
list scope = [
    "TEST_",
    "Foo_",
    "Bar_"
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
#define EVENT_REQUEST_COMPLETE 7

// Source of truth is per the oldest, and widest, scope prefix
// UUID may have duplicates if an object had multiple scope entries
list sourceCandidates = [/* key object, timestamp rezzed, string scope */];

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

integer inScope(string name) {
    integer iterator = llGetListLength(scope);
    while(iterator --> 0)
    {
        string prefix = llList2String(scope, iterator);
        if(llSubStringIndex(name, prefix) == 0) return TRUE;
    }
    return FALSE;
}

default
{
    state_entry()
    {
        llListen(DATA_CHANNEL, "", "", "");
        string signature = llSignRSA(privateKey, (string)llGetKey() + " " + llGetDate(), "sha512");
        llRegionSay(DATA_CHANNEL,
            llChar(EVENT_PING) +
            llChar(llStringLength(signature)) +
            signature
        );
        llSetTimerEvent(0.5);
    }
    
    on_rez(integer param) { llResetScript(); }
    
    listen(integer channel, string name, key identifier, string message)
    {
        integer eventType = llOrd(message, 0);
        
        if(eventType == EVENT_PING || eventType == EVENT_PONG)
        {
            integer signatureLength = llOrd(message, 1);
            string signature = llGetSubString(message, 2, 1 + signatureLength);
            string expected = (string)identifier + " " + llGetDate();
            if(!llVerifyRSA(publicKey, expected, signature, "sha512")) return;
            
            integer iterator = llGetListLength(verified);
            while(iterator --> 0)
            {
                if(llKey2Name(llList2Key(verified, iterator)) == "")
                    verified = llDeleteSubList(verified, iterator, iterator);
            }
            verified += identifier;
            
            if(eventType == EVENT_PING)
            {
                signature = llSignRSA(privateKey, (string)llGetKey() + " " + llGetDate(), "sha512");
                signatureLength = llStringLength(signature);
                
                llRegionSayTo(identifier, DATA_CHANNEL,
                    llChar(EVENT_PONG) +
                    llChar(signatureLength) +
                    signature +
                    llDumpList2String(scope, llChar(1))
                );
            }
            
            else if(eventType == EVENT_PONG)
            {
                llSetTimerEvent(FALSE);
                
                // This section was AI'd and then bugfixed, sue me. My brain was hurting from trying to figure out the logic on the complexity of sorting out
                // multiple sources of truth based on scope and rez times. Like wtf is this https://i.gyazo.com/d4449e0348354c61b2ee6e3c9ee65e17.png
                list peerScope = llParseString2List(llGetSubString(message, 2 + signatureLength, -1), [llChar(1)], []);
                integer peerTimestamp = uStamp2UnixInt(llParseString2List(llList2String(llGetObjectDetails(identifier, [OBJECT_REZ_TIME]), 0), ["-", "T", ":", "."], []));
                
                integer peerScopeLen = llGetListLength(peerScope);
                integer ourScopeLen = llGetListLength(scope);
                
                integer peerIter = peerScopeLen;
                while(peerIter --> 0)
                {
                    string peerPrefix = llList2String(peerScope, peerIter);
                    
                    integer ourIter = ourScopeLen;
                    while(ourIter --> 0)
                    {
                        string ourPrefix = llList2String(scope, ourIter);
                        
                        // Check if prefixes overlap
                        if(llSubStringIndex(peerPrefix, ourPrefix) == 0 || llSubStringIndex(ourPrefix, peerPrefix) == 0)
                        {
                            // Check if this peer is older than existing candidates with overlapping scope
                            integer addCandidate = TRUE;
                            integer candIter = llGetListLength(sourceCandidates);
                            list toRemove = [];
                            
                            while(candIter > 0)
                            {
                                candIter -= 3;
                                key candKey = llList2Key(sourceCandidates, candIter);
                                integer candTime = llList2Integer(sourceCandidates, candIter + 1);
                                string candPrefix = llList2String(sourceCandidates, candIter + 2);
                                
                                // Check if this candidate has overlapping scope
                                if(llSubStringIndex(candPrefix, peerPrefix) == 0 || llSubStringIndex(peerPrefix, candPrefix) == 0)
                                {
                                    integer peerPrefixLen = llStringLength(peerPrefix);
                                    integer candPrefixLen = llStringLength(candPrefix);
                                    
                                    // Peer is older - only remove candidate if peer's scope is wider or equal
                                    if(peerTimestamp < candTime && peerPrefixLen <= candPrefixLen) toRemove += [candIter];
                                    
                                    // Peer is newer - only reject it if candidate's scope is wider or equal
                                    else if(peerTimestamp > candTime && candPrefixLen <= peerPrefixLen) addCandidate = FALSE;
                                    
                                    // Same object, same timestamp, same scope - already exists
                                    else if(identifier == candKey && candPrefix == peerPrefix) addCandidate = FALSE;
                                }
                            }
                            
                            // Remove newer candidates with narrower or equal scope (iterate backwards)
                            integer removeIter = llGetListLength(toRemove);
                            if(removeIter) toRemove = llListSort(toRemove, 1, TRUE);
                            while(removeIter --> 0)
                            {
                                integer idx = llList2Integer(toRemove, removeIter);
                                sourceCandidates = llDeleteSubList(sourceCandidates, idx, idx + 2);
                            }
                            
                            // Add this peer as a candidate if it passed all checks
                            if(addCandidate)
                            {
                                sourceCandidates += [identifier, peerTimestamp, peerPrefix];
                                
                                // Sort candidates by timestamp (oldest first)
                                sourceCandidates = llListSortStrided(sourceCandidates, 3, 1, TRUE);
                            }
                            
                            // Break out of ourScope loop since we did consider this peer
                            jump breakOurScope;
                        }
                    }
                    @breakOurScope;
                }
                
                llSetTimerEvent(0.5);
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
                if(!inScope(name)) return;
                pending += [action, name];
                llLinksetDataWrite(name, value);
            }
            
            else if(action == LINKSETDATA_DELETE)
            {
                if(!inScope(name)) return;
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
                    if(inScope(name))
                    {
                        pending += [action, name];
                        llLinksetDataDelete(name);
                    }
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
            if(!inScope(name)) return;
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
            list requestScopes;
            integer requestIterator;
            integer requestTotal;
            if(llStringLength(message) > 1)
            {
                requestScopes = llParseString2List(llGetSubString(message, 1, -1), [llChar(1)], []);
                requestTotal = llGetListLength(requestScopes);
            }
            
            integer sent = 0;
            integer iterator = llGetListLength(scope);
            while(iterator --> 0)
            {
                string pattern = "^" + llList2String(scope, iterator);
                list names = llLinksetDataFindKeys(pattern, 0, FALSE);
                integer nameIterator = llGetListLength(names);
                while(nameIterator --> 0)
                {
                    string name = llList2String(names, nameIterator);
                    if(requestTotal)
                    {
                        for(requestIterator = 0; requestIterator < requestTotal; ++requestIterator)
                        {
                            string requestScope = llList2String(requestScopes, requestIterator);
                            if(llSubStringIndex(name, requestScope) == 0) jump valid;
                        }
                        jump skip;
                    }
                    @valid;
                    string value = llLinksetDataRead(name);
                    sendData(identifier, LINKSETDATA_UPDATE, name, value);
                    if((++sent % 16) == 0) llSleep(4/45.); // Avoid flooding
                    @skip;
                }
            }
            
            llRegionSayTo(identifier, DATA_CHANNEL, llChar(EVENT_REQUEST_COMPLETE));
        }
        
        else if(eventType == EVENT_REQUEST_COMPLETE)
        {
            @retryComplete;
            if(sourceCandidates)
            {
                key peer = llList2Key(sourceCandidates, 0);
                string peerScope = llList2String(sourceCandidates, 2);
                sourceCandidates = llDeleteSubList(sourceCandidates, 0, 2);
                if(peer == llGetKey()) jump retryComplete;
                llRegionSayTo(peer, DATA_CHANNEL, llChar(EVENT_REQUEST) + peerScope);
                // TODO: Peer may be actually listed multiple times, if so: merge all prefixes of same peer and dump as llDumpList2String(peerScope, llChar(1))
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
        
        if(action == LINKSETDATA_UPDATE || action == LINKSETDATA_DELETE)
        {
            if(!inScope(name)) return;
            
            integer iterator = llGetListLength(scope);
            while(iterator --> 0)
            {
                string prefix = llList2String(scope, iterator);
                if(llSubStringIndex(name, prefix) == 0)
                    return sendData(NULL_KEY, action, name, value);
            }
        }
        
        else if(action == LINKSETDATA_RESET)
        {
            sendData(NULL_KEY, action, name, value);
        }
        
        else if(action == LINKSETDATA_MULTIDELETE)
        {
            list deleted = llParseString2List(name, [","], []);
            list known;
            integer total = llGetListLength(scope);
            do {
                name = llList2String(deleted, 0);
                deleted = llDeleteSubList(deleted, 0, 0);
                
                integer iterator = total;
                while(iterator --> 0)
                {
                    string prefix = llList2String(scope, iterator);
                    if(llSubStringIndex(name, prefix) == 0) known += name;
                }
            } while(deleted);
            
            name = llDumpList2String(known, ",");
            if(known) sendData(NULL_KEY, action, name, value);
        }
    }
    
    timer()
    {
        llSetTimerEvent(FALSE);
        
        // Clear our local data, we are going to re-request everything from the source of truth(s)
        integer index;
        integer count = llGetListLength(sourceCandidates);
        for(; index < count; index += 3)
        {
            key peer = llList2Key(sourceCandidates, 0);
            string peerScope = llList2String(sourceCandidates, 2);
            if(peer != llGetKey()) 
            {
                string pattern = "^" + peerScope;
                list results = llLinksetDataDeleteFound(pattern, "");
                if(llList2Integer(results, 0) > 0) pending += [LINKSETDATA_MULTIDELETE, pattern];
            }
        }
        
        // Reverse sort by newest first; We want to request everything from our source of truths
        // but in an order where older sources will overwrite data / be trusted more
        sourceCandidates = llListSortStrided(sourceCandidates, 3, 1, FALSE);
        
        @retrySource;
        if(sourceCandidates)
        {
            key peer = llList2Key(sourceCandidates, 0);
            string peerScope = llList2String(sourceCandidates, 2);
            sourceCandidates = llDeleteSubList(sourceCandidates, 0, 2);
            if(peer == llGetKey()) jump retrySource;
            llRegionSayTo(peer, DATA_CHANNEL, llChar(EVENT_REQUEST) + peerScope);
        }
    }
}

