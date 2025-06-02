// Allows efficient raycasting against a sphere
integer sphereRaycast(vector spherePos, float sphereRadius, vector rayOrigin, vector rayDir)
{
    rayOrigin -= spherePos;
    float a = rayDir * rayDir;
    float b = 2 * rayDir * rayOrigin;
    float c = (rayOrigin * rayOrigin)  - (sphereRadius * sphereRadius);
    if((b * b - 4 * a * c) < 0) return FALSE;
    return TRUE;
}

// Checks if a point is contained within a polygon
// Well known algorithm whereby you check how many edges it crosses
integer pointInPolygon(vector point, list poly /* = [x0,y0, x1,y1, ...*/)
{
    integer oddNodes = FALSE;
    integer iterator = 0;
    integer total = llGetListLength(poly);
    float x2 = llList2Float(poly, -2);
    float y2 = llList2Float(poly, -1);
    for(; iterator < total; iterator += 2)
    {
        float x1 = llList2Float(poly, iterator);
        float y1 = llList2Float(poly, iterator + 1);
        
        if((y1 < point.y && y2 >= point.y) || (y2 < point.y && y1 >= point.y))
            if((x1 + (point.y  - y1) / (y2 - y1) * (x2 - x1)) < point.x)
                oddNodes = !oddNodes;
        
        x2 = x1;
        y2 = y1;
    }
    
    return oddNodes;
}
