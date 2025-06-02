rotation ConstrainTopDown(rotation R, vector N) {
    vector F = N % llRot2Left(R);
    vector L = F % N;
    return llAxes2Rot(L % N, L, N);
}

rotation ConstrainYaw(rotation R, vector N){
    vector U = N;
    vector L = llRot2Fwd(R) % U;
    vector F = llVecNorm(U % L);
           L = llVecNorm(U % F);

    return llAxes2Rot(F, L, U);
}

rotation ConstrainPitch(rotation R, vector N){
    vector F = llRot2Fwd(R);
    vector L = llVecNorm(F % N);
    vector U =-llVecNorm(F % L);
           L = U % F;
    return llAxes2Rot(F, L, U);
}


/*
Example:

vector HardpointNormal = llVecNorm(<0,0,1> * llList2Rot(llGetObjectDetails(k,[OBJECT_ROT]),0));

rotation TurretYaw = ConstrainYaw(llGetCameraRot(), HardpointNormal);
rotation TurretPitch = ConstrainPitch(llGetCameraRot(), HardpointNormal);

llSetLinkPrimitiveParamsFast(2, [PRIM_ROT_LOCAL, TurretYaw,
    PRIM_LINK_TARGET, 3, PRIM_ROT_LOCAL, TurretPitch
]);

*/

/*
Updated Example:

This script allows you to create very nice rotation animations for turrets, which tend to have
separate speeds when it comes turret traversal (yaw) and barrel rotation (pitch)


rotation rootRot = llGetRootRotation();
rotation camRot = llGetCameraRot();

vector hardpointNormal = <0,0,1>;
rotation localRot = camRot / rootRot;
rotation targetYaw = ConstrainYaw(localRot, hardpointNormal);
localRot /= targetYaw;
rotation targetPitch = ConstrainPitch(localRot, hardpointNormal);

rotation yaw = stepRotation(lastYaw, targetYaw, turretTraverseSpeed * frameRate);
rotation pitch = stepRotation(lastPitch, targetPitch, turretPitchSpeed * frameRate);

lastYaw = yaw;
lastPitch = pitch;

llSetLinkPrimitiveParamsFast(LINK_THIS, [
    PRIM_LINK_TARGET, LinkTurret,
    PRIM_ROT_LOCAL, yaw,
    PRIM_LINK_TARGET, LinkBarrel,
    PRIM_ROT_LOCAL, pitch * yaw,
    PRIM_POS_LOCAL, turretBase + <.6,0,0> * pitch * yaw
]);

*/
