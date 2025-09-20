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


default
{
    state_entry()
    {
        // Update the turret prims every tick
        llSetTimerEvent(0.5);
    }
    
    timer()
    {
        // This is an example, so we use the owners rotation, aim in mouselook to see the prims follow your aim direction
        rotation TurretAim = llList2Rot(llGetObjectDetails(llGetOwner(), [OBJECT_ROT]), 0);
        
        // This is the local "up" direction of the turret base; change if your turret is mounted differently, e.g. if on side of a vehicle would point to the side
        vector HardpointNormal = <0,0,1>;
        
        // ~Maths~
        TurretAim /= llGetRootRotation(); // Convert to local space
        rotation TurretYaw = ConstrainYaw(TurretAim, HardpointNormal);
        rotation TurretPitch = ConstrainPitch(TurretAim, HardpointNormal);
        
        // Apply rotation to prims 2 and 3 for the yaw and pitch; substitute with your own link numbers or derive them based on link names (see NexiiLSL/linkset.lsl)
        llSetLinkPrimitiveParamsFast(2, [PRIM_ROT_LOCAL, TurretYaw,
            PRIM_LINK_TARGET, 3, PRIM_ROT_LOCAL, TurretPitch
        ]);
    }
}
