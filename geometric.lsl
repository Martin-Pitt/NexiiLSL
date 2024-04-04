integer gSRx(vector Sp, float Sr, vector Ro, vector Rd){
    float t;Ro = Ro - Sp;
    //vector RayOrg = llDetectedPos(x) - llGetPos();
    if(Rd == ZERO_VECTOR) return FALSE;
    
    float a = Rd * Rd;
    float b = 2 * Rd * Ro;
    float c = (Ro * Ro)  - (Sr * Sr);
    
    float disc = b * b - 4 * a * c;
    
    if(disc < 0) return FALSE;
    return TRUE;
}