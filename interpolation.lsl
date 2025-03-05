// Interpolating between two ranges
float rescale(float from_min, float from, float from_max, float to_min, float to_max) {
    return to_min + ((to_max-to_min) * ((from_min-from) / (from_min-from_max)));
}

// with clamping
float rescaleClamped(float from_min, float from, float from_max, float to_min, float to_max) {
    from = to_min + ((to_max-to_min) * ((from_min-from) / (from_min-from_max)));
    if(to_min < to_max) {
        if(from < to_min) from = to_min; else if(from > to_max) from = to_max;
    } else {
        if(from < to_max) from = to_max; else if(from > to_min) from = to_min;
    }
    return from;
}


// Float Interpolation
float interpolateFloat(float a, float b, float t) {
    return a*(1-t) + b*t;
}

float interpolateFloatCosine(float a, float b, float t) {
    t = (1-llCos(t*PI))/2;
    return a*(1-t) + b*t;
}

float interpolateFloatCubic(float a, float b, float c, float d, float t) {
    float P = (d-c)-(a-b);
    return P*llPow(t,3) + ((a-b)-P)*llPow(t,2) + (c-a)*t + b;
}

float interpolateFloatCatmullRom(rotation H, float t) {
    rotation ABCD = <
        (H.x *-0.5) + (H.y * 1.5) + (H.z *-1.5) + (H.s * 0.5),
        (H.x * 1.0) + (H.y *-2.5) + (H.z * 2.0) + (H.s *-0.5),
        (H.x *-0.5) + (H.z * 0.5), (H.y * 1.0)
    >;
    rotation T; T.s = 1.0; T.z = t; T.y = T.z*T.z; T.x = T.y*T.z;
    return T.x*ABCD.x + T.y*ABCD.y + T.z*ABCD.z + T.s*ABCD.s;
}

float interpolateFloatHermite(float a, float b, float c, float d, float t, float tens, float bias) {
    float t2 = t*t;float t3 = t2*t;
    float a0 =  (b-a)*(1+bias)*(1-tens)/2;
          a0 += (c-b)*(1-bias)*(1-tens)/2;
    float a1 =  (c-b)*(1+bias)*(1-tens)/2;
          a1 += (d-c)*(1-bias)*(1-tens)/2;
    float b0 =  2*t3 - 3*t2 + 1;
    float b1 =    t3 - 2*t2 + t;
    float b2 =    t3 -   t2;
    float b3 = -2*t3 + 3*t2;
    return b0 * b + b1 * a0 + b2 * a1 + b3 * c;
}


// Vector Interpolation
vector interpolateVector(vector a, vector b, float t) {
    return a*(1-t) + b*t;
}

vector interpolateVectorCosine(float a, float b, float t) {
    t = (1-llCos(t*PI))/2;
    return a*(1-t) + b*t;
}

vector interpolateVectorCubic(vector a, vector b, vector c, vector d, float t) {
    vector P = (c-d) - (b-a);
    return P*llPow(t,3) + ((b-a)-P)*llPow(t,2) + (d-b)*t + a;
}

vector interpolateVectorHermite(vector a, vector b, vector c, vector d, float t, float tens, float bias) {
    float t2 = t*t;float t3 = t2*t;
    vector a0 =  (b-a)*(1+bias)*(1-tens)/2;
           a0 += (c-b)*(1-bias)*(1-tens)/2;
    vector a1 =  (c-b)*(1+bias)*(1-tens)/2;
           a1 += (d-c)*(1-bias)*(1-tens)/2;
    float b0 =  2*t3 - 3*t2 + 1;
    float b1 =    t3 - 2*t2 + t;
    float b2 =    t3 -   t2;
    float b3 = -2*t3 + 3*t2;
    return b0 * b + b1 * a0 + b2 * a1 + b3 * c;
}


// Rotation Interpolation
rotation interpolateRotation(rotation a,rotation b,float t) {
    float ang = llAngleBetween(a, b);
    if(ang > PI) ang -= TWO_PI;
    return a * llAxisAngle2Rot( llRot2Axis(b/a)*a, ang*t);
}

rotation interpolateRotationCosine(rotation a, rotation b, float t) {
    t = (1-llCos(t*PI))/2;
    float ang = llAngleBetween(a, b);
    if(ang > PI) ang -= TWO_PI;
    return a * llAxisAngle2Rot(llRot2Axis(b/a)*a, ang*t);
}

rotation interpolateRotationCubic(rotation a, rotation b, rotation c, rotation d, float t) {
    return rLin(
        rLin(a,b,t),
        rLin(c,d,t),
        2*t*(1-t)
    );
}


// Target
// Increments a float value towards a target number by stepping towards with the given speed
// If it's close enough it returns the target value; Also includes min/max clamping
// This can be useful when dynamically driving values, such as vehicle engine power, etc.
float targetStep(float current, float target, float min, float max, float speed) {
    if(llFabs(target-current) < speed) {
        if(target < min) return min;
        if(target > max) return max;
        return target;
    }
    if(current < target) current += speed; else current -= speed;
    if(current < min) current = min; else if(current > max) current = max;
    return current;
}

// Allows you to target a rotation by incrementing towards it by speed, see example in rotation.lsl
rotation stepRotation(rotation a, rotation b, float speed) {
    float ang = llAngleBetween(a, b);
    if(ang > PI) ang -= TWO_PI;
    if(ang > speed) ang = speed;
    else if(ang < speed) return b;
    return a * llAxisAngle2Rot( llRot2Axis(b/a)*a, ang);
}