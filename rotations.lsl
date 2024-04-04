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
