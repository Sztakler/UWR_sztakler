#include <stdio.h.>
#include <stdint.h>

int32_t div3(int32_t n)
{
    int64_t factorX = ((1ll << 32) + 2) / 3;
    return (n * factorX >> 32) + (n < 0); 
    // n < 0 zwróci 1, jeśli n jest ujemne,
    // eliminując błąd.
}

int main()
{
    for(int32_t i = -10; i <= 10; i++)
    {
        printf("i=%d     div3=%d     i/3=%d     equal=%d\n", i, div3(i), i / 3, div3(i) == (i / 3));
    }

    return 0;
}