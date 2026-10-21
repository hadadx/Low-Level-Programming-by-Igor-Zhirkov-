#include <image.h>
#include <malloc.h>


struct image rotate( struct image const source )
{   
    struct image copy;
    
    copy.height = source.width;
    copy.width = source.height;
    copy.data = malloc(copy.width * copy.height * sizeof(struct pixel));

    for (size_t y = 0; y < source.height; y++)
    {
        for (size_t x = 0; x < source.width; x++)
        {
           
        }
        
    }
    

    return copy;
}

