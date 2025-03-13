// Returns a list of linkset numbers from a prim name
list LinksByName(string Needle) {
    list Needles;
    integer Hay = 1;
    integer Stacks = llGetNumberOfPrims();
    for(; Hay <= Stacks; ++Hay ) if(llGetLinkName(Hay) == Needle) Needles += Hay;
    return Needles;
}

// Returns a linkset number based on the name
integer LinkByName(string Needle) {
    integer Prims = llGetNumberOfPrims()+1;
    while(--Prims) if(llGetLinkName(Prims) == Needle) return Prims;
    return FALSE;
}

// Converts a list of prim names to a list of linkset numbers
list LinksetList(list Needles) {
    integer Prims = llGetNumberOfPrims()+1;
    while(--Prims) {
        integer Ptr = llListFindList(Needles,[llGetLinkName(Prims)]);
        if(~Ptr) Needles = llListReplaceList(Needles,[Prims],Ptr,Ptr);
    }
    return Needles;
}

// Roll your own loop boilerplate
#define LinksetScan(conditions) \
    integer Prims = llGetNumberOfPrims();\
    do {\
        string Prim = llGetLinkName(Prims);\
        conditions\
    } while(--Prims > 1);

/*
LinksetScan(
    if(Prim == "Foot") Foot = Prims; else
    if(Prim == "Leg") Leg = Prims; else
    if(Prim == "Torso") Torso = Prims; else
    if(Prim == "Head") Head = Prims;
);
*/


integer LinksetResourceReserve(string kv) {
    string links = llLinksetDataRead(kv);
    if(llStringLength(links) == 0) return FALSE;
    llLinksetDataWrite(kv, llDeleteSubString(links, 0, 0));
    return 1 + llOrd(links, 0);
}

LinksetResourceRelease(string kv, integer link) {
    llLinksetDataWrite(kv, llLinksetDataRead(kv) + llChar(link - 1));
}

LinksetResourceSetup(string kv, string pattern) {
    string links;
    integer iterator = llGetNumberOfPrims();
    while(iterator --> 0)
    {
        string name = llGetLinkName(1 + iterator);
        if(name == pattern) links += llChar(iterator);
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
