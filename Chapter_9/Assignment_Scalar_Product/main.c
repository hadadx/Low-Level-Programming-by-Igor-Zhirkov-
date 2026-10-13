#include <stdio.h>

int scalar(int *arr1, int *arr2, int size);

int arry1[] = {1, 2, 3};
int arry2[] = {4, 5, 6};

int main(void)
{
    int res = scalar(arry1, arry2, 3);

    printf("sum = %d\n", res);

    return 0;
}

int scalar(int *arr1, int *arr2, int size)
{
    int sum = 0;

    for (int i = 0; i < size; i++)
    {
        sum += arr1[i] * arr2[i];
    }

    return sum;
}