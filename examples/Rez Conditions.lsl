default
{
    state_entry()
    {
        llOwnerSay("state_entry()");
        
        string now = llGetTimestamp();
        string rezzed = (string)llGetObjectDetails(llGetKey(), [OBJECT_REZ_TIME]);
        if(llGetSubString(now, 0, 15) == llGetSubString(rezzed, 0, 15) && ((float)llGetSubString(now, 17, -1) - (float)llGetSubString(rezzed, 17, -1) < 3.0))
        {
            // Script startup & rez closely match, we were duplicated
            llOwnerSay("Duplicated");
            llSensor(llGetObjectName(), NULL_KEY, PASSIVE|ACTIVE, 2.0, PI);
        }
    }
    
    sensor(integer detected)
    {
        key original = llDetectedKey(0);
        llOwnerSay("Original: " + (string)original);
    }
    
    on_rez(integer param)
    {
        if(param == 0)
        {
            // Rezzed from inventory
            llOwnerSay("Rezzed from inventory");
        }
        
        else
        {
            // Rezzed from object
            llOwnerSay("Rezzed from object");
        }
    }
}
