// This is the heart of managing texture coordinates, by converting pixel coordinates into SL texture uv coords
#define TEXTURE_REPEAT(w, h, tw, th) <w / tw, h / th, 0>
#define TEXTURE_OFFSET(x, y, tw, th) <((x) - tw/2) / tw, -((y) - th/2) / th, 0>
#define TEXTURE_COORDS(x, y, w, h, tw, th) <w / tw, h / th, 0>, <((x) - tw/2) / tw, -((y) - th/2) / th, 0>

// For rendering icons placed neatly into an even grid layout in a square texture resolution
#define SPRITESHEET(icon, size, resolution) \
    TEXTURE_COORDS(\
        size*.5 + size * icon % (resolution/size),\
        size*.5 - size * icon / llFloor(resolution/size),\
        size, size,\
        resolution, resolution\
    )

// For non-uniform grid layouts as well as textures with non-square aspect ratio
#define SPRITESHEET2(icon, iconWidth, iconHeight, textureWidth, textureHeight) \
    TEXTURE_COORDS(\
        iconWidth*.5 + iconWidth * digit % llFloor(textureWidth/iconWidth),\
        iconHeight*.5 - iconHeight * digit / llFloor(textureWidth/iconWidth),\
        iconWidth, iconHeight,\
        textureWidth, textureHeight\
    )



#define TEXTURE_CURSORS "18dcdc40-eb58-c42f-b5ef-5e37d7f5f8bd"
#define CURSOR(a, b) <256/2048., 256/512., 0>, <(128 + (256*a) - 1024)/2048., (256 - 128 + (256*b))/512., 0>
//#define CURSOR(a, b) TEXTURE_REPEAT(256, 256, 2048., 512.), TEXTURE_OFFSET(, , 2048., 512.)
