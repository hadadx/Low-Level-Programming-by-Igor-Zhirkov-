#include "mem.h"




int main()
{
    int *arry = _malloc(8 * sizeof(int));
    arry[2] = 9;
    printf("%d\n",arry[2]);
    return 0;
}
