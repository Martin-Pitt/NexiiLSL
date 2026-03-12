// Implementation of a public Remote Linkset Data storage system, similar in practice to llLinksetDataRead but on a remote object
// Gotcha is that this works entirely through prim params (names, descriptions and/or hover text to store data)
// This does mean that this is mostly suitable for a server object that is not seen by users
// Storage capacity for values is roughly 254 bytes per child prim, but not guaranteed as data is reserved in 254 byte chunks per prim

// PRIM_NAME -- 63 bytes, restricted UTF-8 range, 32-126 except 124 ("|")
// PRIM_DESC -- 127 bytes, restricted UTF-8 range, 32-126 except 124 ("|")
// PRIM_TEXT -- 254 bytes, full UTF-8 range -- best for storing the raw values chunked across multiple prims
// -- Warning: Any PRIM_TEXT with unicode in range 0x1-0x1F via llChar corrupts the object from being rezzed from inventory

string llRemoteLinksetDataRead(key object, string name)
{
    // TODO: Lookup table on root prim?
    integer link = 1;
    @remoteReadSearch;
    key prim = llGetObjectLinkKey(object, ++link);
    if(prim == NULL_KEY) return "";
    string primName = llKey2Name(prim);
    if(primName != name) jump remoteReadSearch;
    
    string value;
    @remoteReadLoop;
    value += (string)llGetObjectDetails(prim, [OBJECT_TEXT]);
    prim = llGetObjectLinkKey(object, ++link);
    primName = llKey2Name(prim);
    if(primName == name) jump remoteReadLoop;
    
    return value;
}

integer llRemoteLinksetDataWrite(key object, string name, string value)
{
    if(object != llGetKey()) return 6; // Currently only allow writing from own object to keep the implementation straightforward
    
    // TODO: Check many prims we have left available for writing (any prims free at all + chunk/prim for full value)
    
    // We mirror the data locally for rebuilds
    integer result = llLinksetDataWrite("Remote." + name, value);
    if(result) return result;
    
    RebuildRemoteLinksetData();
    
    return LINKSETDATA_OK;
}

RebuildRemoteLinksetData()
{
    // Rebuild entire remote dataset, this is not efficient but it keeps the implementation robust, avoiding defragmentation issues
    list params;
    list names = llLinksetDataFindKeys("^Remote.", 0, 0);
    integer link = 2;
    integer index;
    integer count = llGetListLength(names);
    for(; index < count; ++index)
    {
        string name = llList2String(names, index);
        string value = llLinksetDataRead(name);
        name = llDeleteSubString(name, 0, 6);
        
        integer chunks = llCeil(llStringLength(value) / 254.);
        // vector color = llVecNorm(<llFrand(1), llFrand(1), llFrand(1)>);
        while(chunks --> 0)
        {
            string chunk = llGetSubString(value, 0, 253);
            value = llDeleteSubString(value, 0, 253);
            params += [
                PRIM_LINK_TARGET, link++,
                PRIM_NAME, name,
                PRIM_TEXT, chunk, <0, 0, 0>, 0
                
                // Debug
                // PRIM_COLOR, 0, color, 1,
                // PRIM_TEXTURE, 0, TEXTURE_BLANK, <1,1,0>, <0,0,0>, 0,
                // PRIM_FULLBRIGHT, 0, TRUE
            ];
        }
    }
    
    // Clear out any old data that is no longer used
    integer prims = llGetNumberOfPrims();
    while(link <= prims) params += [
        PRIM_LINK_TARGET, link++,
        PRIM_NAME, "-",
        PRIM_TEXT, "", <0, 0, 0>, 0
        
        // Debug
        // PRIM_COLOR, 0, <0, 0, 0>, 1,
        // PRIM_FULLBRIGHT, 0, 0
    ];
    
    // TODO: Lookup table on root prim?
    
    llSetLinkPrimitiveParamsFast(0, params);
}
