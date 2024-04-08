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

vector HUDToDir(vector v) {
    float FOV = llTan(llGetCameraFOV() / 2);
    v = <v.x, (2.0*v.x*v.y)*FOV, (2.0*v.x*v.z)*FOV>; // Screen to Local
    return llVecNorm(v * camRot);
}

list HUDToRayCast(vector v) {
    float FOV = llTan(llGetCameraFOV() / 2);
    v = <v.x, (2.0*v.x*v.y)*FOV, (2.0*v.x*v.z)*FOV>; // Screen to Local
    vector dir = llVecNorm(v * camRot);
    
    float scaleGuess;
    float scaleFactor = 4095.99;
    
    if(dir.x) scaleFactor = ((dir.x > 0) * 255.99 - camPos.x) / dir.x;
    
    if(dir.y)
    {
        scaleGuess = ((dir.y > 0) * 255.99 - camPos.y) / dir.y;
        if(scaleGuess < scaleFactor) scaleFactor = scaleGuess;
    }
    
    if(dir.z)
    {
        scaleGuess = ((dir.z > 0) * 4095.99 - camPos.z) / dir.z;
        if(scaleGuess < scaleFactor) scaleFactor = scaleGuess;
    }
    
    vector end = camPos + dir * scaleFactor;
    return llCastRay(camPos, end, [RC_MAX_HITS, 1, RC_DATA_FLAGS, RC_GET_NORMAL]);
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

vector RayEdge(vector start, vector dir) {
    float scaleGuess;
    float scaleFactor = 4095.99;
    
    if(dir.x) scaleFactor = ((dir.x > 0) * 255.99 - start.x) / dir.x;
    
    if(dir.y)
    {
        scaleGuess = ((dir.y > 0) * 255.99 - start.y) / dir.y;
        if(scaleGuess < scaleFactor) scaleFactor = scaleGuess;
    }
    
    if(dir.z)
    {
        scaleGuess = ((dir.z > 0) * 4095.99 - start.z) / dir.z;
        if(scaleGuess < scaleFactor) scaleFactor = scaleGuess;
    }
    
    vector end = start + dir * scaleFactor;
    return end;
}

list RayPos(vector start, vector dir) {
    float scaleGuess;
    float scaleFactor = 4095.99;
    
    if(dir.x) scaleFactor = ((dir.x > 0) * 255.99 - start.x) / dir.x;
    
    if(dir.y)
    {
        scaleGuess = ((dir.y > 0) * 255.99 - start.y) / dir.y;
        if(scaleGuess < scaleFactor) scaleFactor = scaleGuess;
    }
    
    if(dir.z)
    {
        scaleGuess = ((dir.z > 0) * 4095.99 - start.z) / dir.z;
        if(scaleGuess < scaleFactor) scaleFactor = scaleGuess;
    }
    
    vector end = start + dir * scaleFactor;
    return llCastRay(start, end, [RC_MAX_HITS, 1]);
}

list RayPosNormal(vector start, vector dir) {
    float scaleGuess;
    float scaleFactor = 4095.99;
    
    if(dir.x) scaleFactor = ((dir.x > 0) * 255.99 - start.x) / dir.x;
    
    if(dir.y)
    {
        scaleGuess = ((dir.y > 0) * 255.99 - start.y) / dir.y;
        if(scaleGuess < scaleFactor) scaleFactor = scaleGuess;
    }
    
    if(dir.z)
    {
        scaleGuess = ((dir.z > 0) * 4095.99 - start.z) / dir.z;
        if(scaleGuess < scaleFactor) scaleFactor = scaleGuess;
    }
    
    vector end = start + dir * scaleFactor;
    return llCastRay(start, end, [RC_MAX_HITS, 1, RC_DATA_FLAGS, RC_GET_NORMAL]);
}

// P r o j e c t i o n
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
