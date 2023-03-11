#include <stdio.h>
#include <stdint.h>
#include <limits.h>

int main()
{
    // volatile int32_t x, y;

    // x = INT_MIN;
    // y = 0b101101;

    // x = INT32_MAX / 2;
    // printf("%I32d %I32d\n", (x * x) >= 0, x);

    // printf("%I32d\n", x);
    // printf("%I32d || %I32d = %I32d\n", (x > 0), (x - 1 < 0), (x > 0) || ((x - 1) < 0));

    // x = 1;
    // y = -1;
    // printf("%I32d %I32d\n%I32u %I32u\n", x, y, (uint32_t)x, (uint32_t)y);
    // printf("%I32d  %I32d = %I32d\n", x + y, (uint32_t)y + (uint32_t)x, x + y == (uint32_t)y + (uint32_t)x);

    // x = INT32_MAX;
    // y = INT32_MAX;
    // printf("%I32d %I32d\n", x, y);
    // printf("%I32d  %I32d = %I32d\n", x * ~y + (uint32_t)y * (uint32_t)x, -x, x * ~y + (uint32_t)y * (uint32_t)x == -x);

    // int32_t x;
    // x = -432153;
    // y = 2;

    // printf("%u\n", x + (-1) * y);
    // printf("%d", x + (-1) * y);
    // x = 7;
    // int32_t c = x & (x>>1) & 1;

    // printf("%I32d %I32d", (x >> 1) + (x >> 2) + (x & (x>>1) & 1), (x >> 1) + (x >> 2));

    // printf("%I32d", (-(x >> 31) & x) + (~(-(x >> 31)) & -x));
    int32_t x = 245;
    printf("%I32d", (x >> 31 & -x) + (~(x >> 31) & x));

    return 0;
}
