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
