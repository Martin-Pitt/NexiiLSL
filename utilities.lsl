string nth(integer value)
{
    value = value % 10;
    if(value == 1) return "st";
    if(value == 2) return "nd";
    if(value == 3) return "rd";
    return "th";
}
