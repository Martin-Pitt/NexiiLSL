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
