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
/*
#define CURSOR(cursor) \
    "18dcdc40-eb58-c42f-b5ef-5e37d7f5f8bd",\
    TEXTURE COORDS(\
        128 + 256 * cursor,\
        256 - 128 + 256 * (cursor/8),\
        256, 256,\
        2048., 512.\
    )

// Newer:
#define CURSOR(cursor) "18dcdc40-eb58-c42f-b5ef-5e37d7f5f8bd", SPRITESHEET2(cursor, 256, 256, 2048., 512.)

*/

/*
TEXTURE_REPEAT(NUMBER_WIDTH, NUMBER_HEIGHT, 2048., 2048.),
TEXTURE_OFFSET(
    NUMBER_WIDTH*.5 + (digit % NUMBER_COLUMNS) * NUMBER_WIDTH,
    NUMBER_HEIGHT*.5 + digit / NUMBER_COLUMNS * NUMBER_HEIGHT,
    2048., 2048.
),
*/

// Render a digit 0-999 to texture parameters; Use like: [PRIM_TEXTURE, 2, NUMBER_DIGIT(integer number)]
// Number panels are sized 75x48, texture is 2048x2048
#define NUMBER_DIGIT(digit) \
    "5a8c0878-3352-be2f-8b06-d109cfb0c04b",\
    TEXTURE_COORDS(\
        37.5 + (digit + (digit>9)) % 27 * 75.,\
        24 + (digit + (digit>9)) / 27 * 48.,\
        75., 48.,\
        2048., 2048.\
    ), 0

// Center in panel
#define NUMBER_DIGIT_CENTER(digit) \
    "5a8c0878-3352-be2f-8b06-d109cfb0c04b",\
    TEXTURE_COORDS(\
        37.5 + (digit + (digit>9)) % 27 * 75. + ((digit<10) + (digit<100)) * 12.5,\
        24 + (digit + (digit >= 10)) / 27 * 48.,\
        75., 48.,\
        2048., 2048.\
    ), 0

// Left aligned
#define NUMBER_DIGIT_LEFT(digit) \
    "5a8c0878-3352-be2f-8b06-d109cfb0c04b",\
    TEXTURE_COORDS(\
        37.5 + (digit + (digit>9)) % 27 * 75. + ((digit<10) + (digit<100)) * 25,\
        24 + (digit + (digit>9)) / 27 * 48.,\
        75., 48.,\
        2048., 2048.\
    ), 0



/*
    <75 / 2048., 48 / 2048., 0>,\
    <((37.5 + digit % 27 * 75.) - 1024) / 2048.,\
    -((24 + digit / 27 * 48.) - 10240.25) / 2048., 0>, 0
*/

/*
#define NUMBER_WIDTH 75.
#define NUMBER_HEIGHT 48.
#define NUMBER_COLUMNS 27
#define NUMBER_DIGIT(digit) \
    "11d6bf6b-1457-74b8-ab08-1dd8cdb9945c",\
    TEXTURE_REPEAT(NUMBER_WIDTH, NUMBER_HEIGHT, 2048., 2048.),\
    TEXTURE_OFFSET(NUMBER_WIDTH*.5 + digit % NUMBER_COLUMNS * NUMBER_WIDTH, NUMBER_HEIGHT*.5 + digit / NUMBER_COLUMNS * NUMBER_HEIGHT, 2048., 2048.),\
    0
*/

