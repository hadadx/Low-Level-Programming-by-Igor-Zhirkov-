#include <stdio.h>
#include <malloc.h>
#include "node.h"
#include "funcs.h"

int main(void)
{
    Node *list;
    Node *testMap;
    Node *testIterate;
    Node *testTextLoad;
    Node *testBinLoad;
    int v;
    int flag = 0;
    puts("1. Save these integers in a linked list.");
    while (scanf("%d", &v) == 1)
    {
        if (!flag)
        {
            list = list_create(v);
            flag = 1;
        }
        else
        {
            list_add_back(v, &list);
        }
    }
    printf("\n");
    printf("\n");
    puts("2. Transfer all functions written in previous assignment into separate .h and c files. Do not forget to put an include guard!");
    printf("\n");

    puts("3. Implement foreach; using it, output the initial list to stdout twice: the first time, separate elements with spaces, the second time output each element on the new line.");
    foreach (list, print_with_space);
    printf("\n");
    foreach (list, print_with_newline);
    printf("\n");

    puts("4. Implement map; using it, output the squares and the cubes of the numbers from list");
    testMap = self_map(list, squares);
    foreach (testMap, print_with_space);
    printf("\n");
    testMap = self_map(list, cubes);
    foreach (testMap, print_with_space);
    printf("\n");
    printf("\n");

    puts("5. Implement foldl; using it, output the sum and the minimal and maximal element in the list.");
    printf("sum list = %d\n min = %d\n max = %d \n",foldl(list,sum,0),foldl(list,min,list->value),foldl(list,max,list->value));
    printf("\n");

    puts("6. Implement map_mut; using it, output the modules of the input numbers.");
    map_mut(list,abs);
    printf("\n");
    foreach (list, print_with_space);
    printf("\n");

    puts("Implement iterate; using it, create and output the list of the powers of two (first 10 values: 1, 2, 4, 8, …).");
    testIterate = iterate(1,10,power_of_two);
    foreach (testIterate, print_with_space);
    printf("\n");
    printf("\n");

    puts("10. Save the list into a text file and load it back using the two functions above. Verify that the save and load are correct.");
    puts("List save in data.txt");
    save(list,"data.txt");
    puts("Load  and print list from data2.txt");
    load(&testTextLoad, "data2.txt");
    foreach (testTextLoad, print_with_space);
    printf("\n");
    printf("\n");


    puts("Serialize the list into a binary file and load it back using two functions above. Verify that the serialization and deserialization are correct.");
    puts("List save as binary in rawData.txt");
    serialize(list,"rawData.txt");
    puts("Load and print list rawData.txt");
    deserialize(&testBinLoad, "rawData.txt");
    foreach (testBinLoad, print_with_space);
    printf("\n");
    printf("\n");
    
    puts("14. Free all allocated memory");
    free(list);
    free(testMap);
    free(testIterate);
    free(testTextLoad);
    free(testBinLoad);
    return 0;
}
