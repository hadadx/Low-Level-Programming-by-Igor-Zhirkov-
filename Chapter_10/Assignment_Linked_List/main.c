#include <stdio.h>
#include <malloc.h>
#include "node.h"
#include "funcs.h"

int main(void)
{
    Node *list;
    int v;
    int flag = 0;
    
    while (scanf("%d", &v) == 1)
    {   
        if (!flag)
        {
            list = list_create(v);
            flag = 1;
        }

        list_add_front(v,&list);
    }

    printf("sum = %d\n",list_sum(&list));
    printf("len = %d\n",list_length(&list));
    printf("value = %d\n",list_get(3,list));
    list_free(&list);
    printf("list point on %p\n",list);
    return 0;
}
