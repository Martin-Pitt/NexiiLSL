// From NexiiLSL/rotations.lsl
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

// From NexiiLSL/interpolation.lsl
rotation stepRotation(rotation a, rotation b, float speed) {
    float ang = llAngleBetween(a, b);
    if(ang > PI) ang -= TWO_PI;
    if(ang > speed) ang = speed;
    else if(ang < speed) return b;
    return a * llAxisAngle2Rot( llRot2Axis(b/a)*a, ang);
}

float FrameRate = 0.2; // How often to update the prims at
float TurretTraverseSpeed = 0.7; // Radians per second
float TurretPitchSpeed = 1.1; // Radians per second

// Apply rotation to prims 2 and 3 for the yaw and pitch; substitute with your own link numbers or derive them based on link names (see NexiiLSL/linkset.lsl)
integer LinkTurret = 2;
integer LinkBarrel = 3;

rotation LastTurretYaw;
rotation LastTurretPitch;


default
{
    state_entry()
    {
        // Update the turret prims every tick
        llSetTimerEvent(FrameRate);
    }
    
    timer()
    {
        // This is an example, so we use the owners rotation, aim in mouselook to see the prims follow your aim direction
        rotation TurretAim = llList2Rot(llGetObjectDetails(llGetOwner(), [OBJECT_ROT]), 0);
        
        // This is the local "up" direction of the turret base; change if your turret is mounted differently, e.g. if on side of a vehicle would point to the side
        vector HardpointNormal = <0,0,1>;
        
        // ~Maths~
        TurretAim /= llGetRootRotation(); // Convert to local space
        rotation TargetYaw = ConstrainYaw(TurretAim, HardpointNormal);
        TurretAim /= TargetYaw; // Remove yaw from aim to get pure pitch that allows us to interpolate pitch more nicely, but does mean having to re-add yaw later for final rotation
        rotation TargetPitch = ConstrainPitch(TurretAim, HardpointNormal);
        rotation TurretYaw = stepRotation(LastTurretYaw, TargetYaw, TurretTraverseSpeed * FrameRate);
        rotation TurretPitch = stepRotation(LastTurretPitch, TargetPitch, TurretPitchSpeed * FrameRate);
        LastTurretYaw = TurretYaw;
        LastTurretPitch = TurretPitch;
        
        
        llSetLinkPrimitiveParamsFast(LINK_THIS, [
            PRIM_LINK_TARGET, LinkTurret,
            PRIM_ROT_LOCAL, TurretYaw,
            PRIM_LINK_TARGET, LinkBarrel,
            PRIM_ROT_LOCAL, TurretPitch * TurretYaw
            // PRIM_POS_LOCAL, TurretPosition + <.6,0,0> * pitch * yaw // If you want to add a position offset to the barrel from the turret
        ]);

    }
}
