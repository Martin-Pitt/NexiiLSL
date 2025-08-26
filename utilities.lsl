#define isSameOwner(identifier) llGetOwnerKey(identifier) == llGetOwner()
#define notSameOwner(identifier) llGetOwnerKey(identifier) != llGetOwner()

// For displaying ordinal numbers like 1st, 2nd, 3rd, 20th, 21st, 22nd, etc.
string nth(integer value)
{
    value = value % 10;
    if(value == 1) return "st";
    if(value == 2) return "nd";
    if(value == 3) return "rd";
    return "th";
}

// Returns the number of bytes a string would take up in UTF-8 encoding
integer stringBytes(string str) {
    integer bytes;
    integer length = llStringLength(str);
    integer iterator;
    for(; iterator < length; ++iterator)
    {
        integer byte = llOrd(str, iterator);
        if(byte <= 0x7F) bytes += 1;
        else if(byte <= 0x07FF) bytes += 2;
        else if(byte <= 0xFFFF) bytes += 3;
        else bytes += 4;
    }
    return bytes;
}