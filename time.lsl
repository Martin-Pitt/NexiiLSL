/*
    Compares two timestamps per ISO 8601 format "YYYY-MM-DDThh:mm:ss.ff..fZ"
    Returns -1 if a < b, else 1 if a > b else 0 if same
    
    You can comment/cut out parts of the function if you only care about
    date checks or only want fast time checks
*/
integer CompareTimestamps(string a, string b)
{
    integer aYear = (integer)llGetSubString(a, 0, 3);
    integer bYear = (integer)llGetSubString(b, 0, 3);
    if(aYear < bYear) return -1; else if(aYear > bYear) return 1;
    integer aMonth = (integer)llGetSubString(a, 5, 6);
    integer bMonth = (integer)llGetSubString(b, 5, 6);
    if(aMonth < bMonth) return -1; else if(aMonth > bMonth) return 1;
    integer aDay = (integer)llGetSubString(a, 8, 9);
    integer bDay = (integer)llGetSubString(b, 8, 9);
    if(aDay < bDay) return -1; else if(aDay > bDay) return 1;
    integer aHour = (integer)llGetSubString(a, 11, 12);
    integer bHour = (integer)llGetSubString(b, 11, 12);
    if(aHour < bHour) return -1; else if(aHour > bHour) return 1;
    integer aMinute = (integer)llGetSubString(a, 14, 15);
    integer bMinute = (integer)llGetSubString(b, 14, 15);
    if(aMinute < bMinute) return -1; else if(aMinute > bMinute) return 1;
    float aSecond = (float)llGetSubString(a, 17, -2);
    float bSecond = (float)llGetSubString(b, 17, -2);
    if(aSecond < bSecond) return -1; else if(aSecond > bSecond) return 1;
    return 0;
}
