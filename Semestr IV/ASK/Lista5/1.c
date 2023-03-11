#include <stdio.h>

int puzzle(long x, unsigned int n)
{
    int result = 0;

    for(unsigned int i = 0; i < n; i++)
    {
        result += x & 1;
        x = x >> 1;
    }

    return result;
}

int main()
{
    printf("%d\n", puzzle(7, 3));

    return 0;
}