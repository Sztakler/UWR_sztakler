#include <stdio.h>

int main()
{
    long unsigned int a, b;

    scanf("%lu %lu", &a, &b);

    if(a % 2021)
    {
        a = a + 2021 - a % 2021;
    }

    while(a <= b)
    {
        printf("%lu ", a);
        a += 2021;
    }

    return 0;
}