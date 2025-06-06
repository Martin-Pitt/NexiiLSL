// Returns a list of linkset numbers from a prim name
list LinksByName(string needle) {
    list needles;
    integer link = 1;
    integer prims = llGetNumberOfPrims();
    for(; link <= prims; ++link) if(llGetLinkName(link) == needle) needles += link;
    return needles;
}

// Returns a linkset number based on the name
integer LinkByName(string needle) {
    integer prims = llGetNumberOfPrims() + 1;
    while(--prims) if(llGetLinkName(prims) == needle) return prims;
    return FALSE;
}

// Converts a list of prim names to a list of linkset numbers
list LinksetList(list needles) {
    integer prims = llGetNumberOfPrims() + 1;
    while(--prims) {
        integer pointer = llListFindList(needles, [llGetLinkName(prims)]);
        if(~pointer) needles = llListReplaceList(needles, [prims], pointer, pointer);
    }
    return needles;
}

// Roll your own loop boilerplate
#define LinksetScan(conditions) \
    integer link = llGetNumberOfPrims();\
    do {\
        string name = llGetLinkName(link);\
        conditions\
    } while(--link > 1);

/*
LinksetScan(
    if(name == "Foot") Foot = link;
    else if(name == "Leg") Leg = link;
    else if(name == "Torso") Torso = link;
    else if(name == "Head") Head = link;
);
*/


// Remote linkset scanning variants, returns keys instead of linkset numbers

// Returns a list of linkset keys from a prim name
list ObjectLinksByName(key object, string needle) {
    list needles;
    integer link = 1;
    integer prims = llGetObjectPrimCount(Object);
    for(; link <= prims; ++link)
    {
        key linkKey = llGetObjectLinkKey(object, link);
        string linkName = llKey2Name(linkKey);
        if(linkName == needle) needles += linkKey;
    }
    return needles;
}

// Returns a linkset key based on the name
key ObjectLinkByName(key object, string needle) {
    integer prims = llGetObjectPrimCount(object) + 1;
    while(--prims)
    {
        key linkKey = llGetObjectLinkKey(object, prims);
        string linkName = llKey2Name(linkKey);
        if(linkName == needle) return linkKey;
    }
    return NULL_KEY;
}

// Converts a list of prim names to a list of linkset keys
list ObjectLinksetList(key object, list needles) {
    integer prims = llGetObjectPrimCount(object) + 1;
    while(--prims) {
        key linkKey = llGetObjectLinkKey(object, prims);
        string linkName = llKey2Name(linkKey);
        integer pointer = llListFindList(meedles, [linkName]);
        if(~pointer) needles = llListReplaceList(needles, [linkKey], pointer, pointer);
    }
    return needles;
}

// Roll your own loop boilerplate
#define ObjectLinksetScan(object, conditions) \
    integer link = llGetObjectPrimCount(object);\
    do {\
        key linkKey = llGetObjectLinkKey(object, link);\
        string linkName = llKey2Name(linkKey);\
        conditions\
    } while(--link > 1);








integer LinksetResourceReserve(string kv) {
    string links = llLinksetDataRead(kv);
    if(links == "") return FALSE;
    llLinksetDataWrite(kv, llDeleteSubString(links, 0, 0));
    return 1 + llOrd(links, 0);
}

LinksetResourceRelease(string kv, integer link) {
    llLinksetDataWrite(kv, llChar(link - 1) + llLinksetDataRead(kv));
}

LinksetResourceSetup(string kv, string pattern) {
    string links;
    integer iterator = llGetNumberOfPrims();
    while(iterator --> 0)
    {
        string name = llGetLinkName(1 + iterator);
        if(name == pattern) links = llChar(iterator) + links;
    }
    llLinksetDataWrite(kv, links);
}

LinksetResourceReset(string kv, list reset) {
    list params;
    string links = llLinksetDataRead(kv);
    integer iterator = llStringLength(links);
    while(iterator --> 0)
    {
        params += [PRIM_LINK_TARGET, 1 + llOrd(links, iterator)] + reset;
        if(llGetFreeMemory() < 1500) { llSetLinkPrimitiveParamsFast(0, params); params = []; }
    }
    if(params) llSetLinkPrimitiveParamsFast(0, params);
}

// TODO: An inverse version of linkset resource, but basically a way to store used linkset numbers
// E.g. somewhere to easily dump linkset nums into a specific named LSD key

integer LinksetResourceUse(string kvPool, string kvUsed) {
    string links = llLinksetDataRead(kvPool);
    if(links == "") return FALSE;
    llLinksetDataWrite(kvPool, llDeleteSubString(links, 0, 0));
    integer link = 1 + llOrd(links, 0);
    llLinksetDataWrite(kvUsed, llChar(link - 1) + llLinksetDataRead(kvUsed));
    return link;
}

LinksetResourceFreeAll(string kvPool, string kvUsed) {
    llLinksetDataWrite(kvPool, llLinksetDataRead(kvUsed) + llLinksetDataRead(kvPool));
    llLinksetDataWrite(kvUsed, "");
}

