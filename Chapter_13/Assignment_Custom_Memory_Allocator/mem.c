#include "mem.h"

const size_t MEM_SIZE = sizeof(struct mem);
/*
void *mmap(
    void *addr,
    size_t length,
    int prot,
    int flags,
    int fd,
    off_t offset
);
*/

void *heap_init(size_t initial_size)
{
    void *region = mmap(HEAP_START, initial_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    return region;
}

void *_malloc(size_t query)
{
    static struct mem *heap = NULL;
    struct mem *free_block =NULL;
    if (heap == NULL)
    {
        heap = heap_init(4096);

        if (heap == NULL)
        {
            return NULL;
        }

        heap->next = NULL;
        heap->capacity = query;
        heap->is_free = BLOCK_IS_NOT_FREE;

        return heap + MEM_SIZE;
    }

    free_block = there_is_aval_block(heap,query);

    if (free_block == NULL)
    {
        create_new_block;
    }

    if (free_block->capacity == query)
    {
        /* code */
    }
       

    if (free_block->capacity > query)
    {
        /* code */
    }

    
    
    

}


struct mem *there_is_aval_block(struct mem *heap, size_t query)
{
    while (heap)
    {
        if (heap->is_free == BLOCK_IS_FREE)
        {
            return heap;
        }
        else
        {
            heap = heap->next;
        } 
    }
    
    return NULL;
};
