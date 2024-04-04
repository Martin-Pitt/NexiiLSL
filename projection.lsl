//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
// P r o j e c t i o n

vector WorldToHUD(vector v) {
    float inFOV = 1 / llTan(llGetCameraFOV() / 2);
    v = (v - camPos) / camRot; // Global to Local
    if(v.x != 0.0) v = <v.x, (v.y*inFOV)/v.x/2, (v.z*inFOV)/v.x/2>; // Local to Screen
    else v = <0, (v.y*inFOV)/2, (v.z*inFOV)/2>;
}

vector HUDToWorld(vector v) {
    float FOV = llTan(llGetCameraFOV() / 2);
    v = <v.x, (2.0*v.x*v.y)*FOV, (2.0*v.x*v.z)*FOV>; // Screen to Local
    v = camPos + v * camRot; // Local to Global
    return v;
}

integer wasML;
vector camPos;
rotation camRot;
integer Camera() {
    integer isML = llGetAgentInfo(llGetOwner()) & AGENT_MOUSELOOK;
    integer deltaML = (isML == wasML);
    wasML = isML;
    
    vector oldPos = camPos;
    rotation oldRot = camRot;
    
    if(isML) {
        camPos = llGetPos();
        camRot = llGetRot();
    } else {
        camPos = llGetCameraPos();
        camRot = llGetCameraRot();
    }
    
    integer changedPos = (llVecDist(camPos, oldPos) > 0.01);
    integer changedRot = (llAngleBetween(camRot, oldRot) > .01);
    return changedPos || changedRot || deltaML;
}

list RayCast(vector start, vector end) {
    integer retries = 6;
    @retry;
    list Ray = llCastRay(start, end, [RC_MAX_HITS, 1, RC_DATA_FLAGS, RC_GET_NORMAL ]);
    integer Status = llList2Integer(Ray, -1);
    if(Status < 1 && retries--) { end.z += 0.0001; jump retry; } // Precision issues sometimes, e.g. megaprims
    if(Status < 1) return [];
    return Ray;
}

// P r o j e c t i o n
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
