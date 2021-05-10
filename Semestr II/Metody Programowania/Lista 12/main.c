#include <stdio.h>

int main()
{
    int x12[20] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    x12[18] = 42;
    int x6 = 10;
    int* p_x6 = &x6;
    int* x31 = x12 + 8 + x6;
    printf("%ld\n", x31[0]);
    return 0;
}