// This is the heart of managing texture coordinates, by converting pixel coordinates into SL texture uv coords
#define TEXTURE_REPEAT(w, h, tw, th) <w / tw, h / th, 0>
#define TEXTURE_OFFSET(x, y, tw, th) <((x) - tw/2) / tw, -((y) - th/2) / th, 0>
#define TEXTURE_COORDS(x, y, w, h, tw, th) <w / tw, h / th, 0>, <((x) - tw/2) / tw, -((y) - th/2) / th, 0>

// #define TEXTURE_RESOLUTION 2048.
// #define TEXTURE_OFFSET(x, y) <(x - TEXTURE_RESOLUTION/2) / TEXTURE_RESOLUTION, -(y - TEXTURE_RESOLUTION/2) / TEXTURE_RESOLUTION, 0>
// #define TEXTURE_REPEAT(w, h) <w / TEXTURE_RESOLUTION, h / TEXTURE_RESOLUTION, 0>
