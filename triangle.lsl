// Vertex
// by Sanderman Cyclone
// also incorporates work by Seifert Surface
// Jan 2007
//
// Use this as you want but don't resell it as is.
//
// The triangle creation part is actually the biggest part of the system and Seifert Surface recieves
// full credit for that. He gave permission on the forums for people to use his script in third party
// tools.

// Nexii 2024: amended for #include use, triangle(a, b, c) returns a list of [center, rot, scale, y_shear] or an empty list if invalid


// Function for triangle between vectors a, b and c.
// Credit for this goes to Seifert Surface.
list triangle(vector a, vector b, vector c)
{
    // Check for 2 vertices in the same place
    if(llVecDist(a,b) < .01 || llVecDist(b,c) < .01 || llVecDist(c,a) < .01) return []; // Invalid triangle
    
    float cosA = (b - a) * (c - a);
    float cosB = (c - b) * (a - b);
    float cosC = (a - c) * (b - c); //signs -ve means obtuse angle
    
    //so the angle at a is obtuse, meaning the opposite edge must be the base of the prim
    if(cosA < 0.0) return triangleCoords(a, b, c, 0);
    if(cosB < 0.0) return triangleCoords(b, c, a, 1);
    if(cosC < 0.0) return triangleCoords(c, a, b, 2);
    
    //all acute angles... so we can choose which way to base the prim, so as to minimise the error introduced by the shear value having a resolution of only 0.01
    float error1 = triangleError(a, b, c);
    float error2 = triangleError(b, c, a);
    float error3 = triangleError(c, a, b);
    if(error1 < error2)
    {
        if(error1 < error3) return triangleCoords(a, b, c, 0);
        return triangleCoords(c, a, b, 2);
    }
    
    if(error2 < error3) return triangleCoords(b, c, a, 1);
    return triangleCoords(c, a, b, 2);
}


// Error between where the vertex of the triangle should be and would be...
float triangleError(vector a, vector b, vector c)
{
    float width = llVecDist(b, c);
    vector left = llVecNorm(b - c);
    vector fwd = llVecNorm(left % (a - c));
    vector up = fwd % left;
    float height = (a - c) * up;
    float y_shear = 0.5 - ((b-a) * left) / width;
    y_shear = (float)llRound(y_shear * 100.0) / 100.0;
    return llVecDist(a, 0.5 * (b + c) + height * up + y_shear * width * left);
}

list triangleCoords(vector a, vector b, vector c, integer i)
{
    float width = llVecDist(b, c);
    vector left = llVecNorm(b - c);
    vector fwd = llVecNorm(left % (a - c));
    vector up = fwd % left;
    float height = (a - c) * up;
    float y_shear = 0.5 - ((b-a) * left) / width;
    
    vector center = 0.5 * ( (b+c) + (height * up)  );
    vector scale = <.01, width, height>;
    rotation rot = llAxes2Rot(fwd, left, up);
    
    return [
        center, rot, scale, y_shear,
        i, 0.5 * (b + c) + height * up + ((float)llRound(y_shear * 100.0) / 100.0) * width * left
    ];
    //     PRIM_POS_LOCAL, center,
    //     PRIM_ROT_LOCAL, rot,
    //     PRIM_SIZE, scale,
    //     PRIM_TYPE, PRIM_TYPE_BOX, PRIM_HOLE_DEFAULT, <0, 1, 0>, 0, <0, 0, 0>, <1, 0, 0>, <0, y_shear, 0>
    // ];
}
