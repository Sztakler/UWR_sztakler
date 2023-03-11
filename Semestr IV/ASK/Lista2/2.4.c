#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

int decimal_to_binary(int dec_num)
{
      int rem, a = 1;
      long int bin_num = 0;
      while(dec_num > 0)
      {
            rem = dec_num%2;
            dec_num = dec_num/2;
            bin_num = bin_num + (a * rem);
            a = a * 10;
      }
      return bin_num;
}

int main()
{
    int32_t x = 325; 
    int32_t y = 273;

    int32_t d = (x | 0x80808080) - (y & 0x7F7F7F7F);
    d = ~((x ^ y | 0x7f7f7f7f) ^ d);

    printf("%I32d - %I32d = %I32d\n", x, y, d);

    printf("%I32d\n%I32d\n%I32d\n", decimal_to_binary(x), decimal_to_binary(y), decimal_to_binary(d));
    return 0;
}