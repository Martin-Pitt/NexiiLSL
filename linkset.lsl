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
