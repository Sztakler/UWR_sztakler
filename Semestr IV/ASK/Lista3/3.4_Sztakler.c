#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

int main()
{
    int32_t x, y, z;
    double dx, dy, dz;
    
    x = INT32_MAX; y = 1; z = 1;

    x = 6;
    y = 8388611;
    z = 1073741825;

    dx = (double)x; dy = (double)y; dz = (double)z;

    printf("%u\n", (float)x == (float)dx);              // prawda, bo rzutowanie z int do float oraz z int do double, a potem
                                                        //  do float generuje taką samą utratę precyzji
    printf("%u\n", dx - dy == (double)(x - y));         // fałsz dla x = INT32_MIN
    printf("%u\n", (dx + dy) + dz == dx + (dy + dz));   // fałsz, gdy weźmiemy x = 6; y = 8388611 = 2^23+3; z = 1073741825 = 2^30+1;
    printf("%d %lf\n%lf\n %u\n", x, (dx * dy) * dz, dx * (dy * dz), (dx * dy) * dz == dx * (dy * dz));    // prawda, jak wyżej
    printf("%u\n", dx / dx == dz / dz);                 // fałsz dla x = 0, wtedy dx/dx = NaN  

    // printf("%f %f %f %f %d %d\n", (double)(x-y), dx - dy, dx, dy, x, y);
    // for(int32_t x = INT32_MAX; x > INT32_MAX - 1000; x--)
    // {   
    //     dx = (double)x;
    //     printf("%.30f %.30f %.30f %u\n", (float)x, dx, (float)dx, (float)x == (float)dx);
    // }

    return 0;
}