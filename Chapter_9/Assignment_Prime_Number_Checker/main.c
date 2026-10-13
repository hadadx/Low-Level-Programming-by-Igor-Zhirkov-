#include <stdio.h>

unsigned long is_prime(unsigned long n);




int main(void)
{
    unsigned long input = 0;
    puts("Enter number to check if his prim number:");
    
    scanf("%lu",&input);

    printf("%lu\n",is_prime(input));

    return 0;
}


unsigned long is_prime(unsigned long n)
{
    if (n < 1){return 0 ;}
    
    for (size_t i = 2; i < n; i++)
    {
        if (i == n){continue;}
        
        if (n % i == 0){return 0 ;}
    }
    return 1;
}