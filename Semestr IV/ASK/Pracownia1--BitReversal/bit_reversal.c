#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

uint64_t bitrev(uint64_t x)
{

    uint64_t result = x;

    result = ((result & 0xaaaaaaaaaaaaaaaa) >> 1)  | ((result & 0x5555555555555555) << 1);
    
    result = ((result & 0xcccccccccccccccc) >> 2) | ((result & 0x3333333333333333) << 2);

    result = ((result & 0xF0F0F0F0F0F0F0F0) >> 4) | ((result & 0x0F0F0F0F0F0F0F0F) << 4);

    result = ((result & 0xFF00FF00FF00FF00) >> 8) | ((result & 0x00FF00FF00FF00FF) << 8);

    result = ((result & 0xFFFF0000FFFF0000) >> 16) | ((result & 0x0000FFFF0000FFFF) << 16);

    result = (result >> 32) | (result << 32);
    
    return result;
}

int main()
{
    uint64_t x = 0x123456789abcdef;
    printf("%#16lx\n%#16lx\n", x, bitrev(x));
    printf("%I64u\n", bitrev(x));
    printf("%#" PRIx64 " ==> %#" PRIx64 "\n", x, bitrev(x));
    return 0;
}

