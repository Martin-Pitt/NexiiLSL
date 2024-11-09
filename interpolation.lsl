#define Interpolate(x, y, t) x*(1-t) + y*t
#define InterpolateLinearly(x, y, t) x*(1-t) + y*t

float fScl(float from_min, float from_max, float to_min, float to_max, float from) {
    return to_min + ((to_max-to_min) * ((from_min-from) / (from_min-from_max)));
}

float fSclFix(float from_min, float from_max, float to_min, float to_max, float from) {
    from = to_min + ((to_max-to_min) * ((from_min-from) / (from_min-from_max)));
    if(to_min < to_max) {
        if(from < to_min) from = to_min; else if(from > to_max) from = to_max;
    } else {
        if(from < to_max) from = to_max; else if(from > to_min) from = to_min;
    }
    return from;
}

vector vLin(vector v0, vector v1,float t){
    return v0*(1-t) + v1*t;
}

vector vCub(vector a, vector b, vector c, vector d, float t) {
    vector P = (c-d) - (b-a);
    return P*llPow(t,3) + ((b-a)-P)*llPow(t,2) + (d-b)*t + a;
}

vector vHem(vector a, vector b, vector c, vector d, float t, float tens, float bias){
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

rotation rLin(rotation r0,rotation r1,float t){
    float ang = llAngleBetween(r0, r1); if( ang > PI) ang -= TWO_PI;
    return r0 * llAxisAngle2Rot( llRot2Axis(r1/r0)*r0, ang*t);
}