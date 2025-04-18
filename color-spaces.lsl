// Converts HSL to RGB color space
vector hsl(float h, float s, float l) {
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