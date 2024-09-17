#define isSameOwner(identifier) llGetOwnerKey(identifier) == llGetOwner()
#define notSameOwner(identifier) llGetOwnerKey(identifier) != llGetOwner()

string nth(integer value)
{
    value = value % 10;
    if(value == 1) return "st";
    if(value == 2) return "nd";
    if(value == 3) return "rd";
    return "th";
}

vector hsl( float h, float s, float l ) {
    float r = l; float g = l; float b = l; float v;
    if(l <= 0.5) v = l * (1.0 + s); else v = l + s - l * s;
    if(v > 0) {
        float m = l + l - v;
        float sv = (v - m) / v;
        h = h - llFloor(h);
        integer sex = (integer)(h *= 6.0);
        if(sex == 0) { r = v; g = m + (v * sv * (h-sex)); b = m; } else
        if(sex == 1) { r = v - (v * sv * (h-sex)); g = v; b = m; } else
        if(sex == 2) { r = m; g = v; b = m + (v * sv * (h-sex)); } else
        if(sex == 3) { r = m; g = v - (v * sv * (h-sex)); b = v; } else
        if(sex == 4) { r = m + (v * sv * (h-sex)); g = m; b = v; } else
        if(sex == 5) { r = v; g = m; b = v - (v * sv * (h-sex)); }
    }
    return <r, g, b>;
}

#define TEXTURE_CURSORS "18dcdc40-eb58-c42f-b5ef-5e37d7f5f8bd"
#define CURSOR(a, b) <256/2048., 256/512., 0>, <(128 + (256*a) - 1024)/2048., (256 - 128 + (256*b))/512., 0>
