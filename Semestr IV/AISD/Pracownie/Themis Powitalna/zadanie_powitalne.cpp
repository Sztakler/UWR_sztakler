/*
Krystian Jasionek
317806
KLO
*/

#include <stdio.h>
#include <stdint.h>

int main()
{
    uint64_t a, b, x;

    scanf("%I64u %I64u", &a, &b);

    x = 0;
    while(x < a)
    {
        x += 2021;
    }

    while(x <= b)
    {
        printf("%I64u ", x);
        x += 2021;
    }

    return 0;
}