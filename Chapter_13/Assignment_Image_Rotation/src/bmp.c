#include "libc.h"
#include "bmp.h"
#include "image.h"

enum read_status from_bmp(FILE *in, struct image *const read)
{
    struct bmp header;
    if (fread(&header, sizeof(header), 1, in) != 1)
        return READ_INVALID_HEADER;

    if (header.Signature != 0x4d42)
        return READ_INVALID_SIGNATURE;
   
    if (header.BitCount != 24)
        return READ_INVALID_BITS;
    
    if (header.Planes != 1)
        return READ_INVALID_HEADER;
    

    if (header.Compression != 0)
        return READ_INVALID_HEADER;

    if (header.Width == 0 || header.Height == 0)
        return READ_INVALID_HEADER;
    
    read->height = header.Height;
    read->width = header.Width;
    read->data = header.DataOffset;
    return READ_OK;
}


enum write_status to_bmp( FILE* out, struct image const* img )
{
    struct bmp header;
    if (fread(&header, sizeof(header), 1, out) != 1)
        return WRITE_ERROR;
    
    header.Height = img->height;
    header.Width = img->width;
    
    

}

