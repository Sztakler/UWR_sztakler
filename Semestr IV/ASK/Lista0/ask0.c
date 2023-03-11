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

uint32_t zero_bit(uint32_t x, uint32_t k)
{
    return x & ~(1<<k);
}

uint32_t set_bit(uint32_t x, uint32_t k)
{
    return x | (1 << k);
}

uint32_t negate_bit(uint32_t x, uint32_t k)
{
    return x ^ (1 << k);
}

uint32_t times_power_of_2(uint32_t x, uint32_t y)
{
    return (x << y);
}

uint32_t floor_division_by_power_of_2(uint32_t x, uint32_t y)
{
    return (x >> y);
}

uint32_t modulo_power_of_2(uint32_t x, uint32_t y)
{
    return x - ((x >> y) << y);
}

uint32_t ceiling_division_by_power_of_2(uint32_t x, uint32_t y)
{
    return (x + (1 << y) - 1) >> y;
}

uint32_t is_power_of_2(uint32_t x) //returns zero when 
{
    return x & (x-1);
}

uint32_t swap_endiannes(uint32_t x)
{
    uint32_t leftmost_byte    = (x & 0x000000FF) >> 0;
    uint32_t leftmiddle_byte  = (x & 0x0000FF00) >> 8;
    uint32_t rightmiddle_byte = (x & 0x00FF0000) >> 16;
    uint32_t rightmost_byte   = (x & 0xFF000000) >> 24;

    leftmost_byte    <<= 24;
    leftmiddle_byte  <<= 16;
    rightmost_byte   <<= 8;
    rightmiddle_byte <<= 0;

    return leftmost_byte | leftmiddle_byte | rightmiddle_byte | rightmost_byte;
}

uint32_t swap_endiannes_better(uint32_t x)
{
    uint32_t leftmost_byte    = (x & 0x000000FF) << 24;
    uint32_t leftmiddle_byte  = (x & 0x0000FF00) << 8;
    uint32_t rightmiddle_byte = (x & 0x00FF0000) >> 8;
    uint32_t rightmost_byte   = (x & 0xFF000000) >> 24;

    return leftmost_byte | leftmiddle_byte | rightmiddle_byte | rightmost_byte;
}


int main()
{
    uint32_t x = 53;
    // uint32_t k = 2;
    uint32_t y = 4;
    // uint32_t y = x & ~(1<<k);
    // int32_t y = x | (1<<4);
    // int32_t y = x ^ (1<<k);
    // uint32_t t2 = times_power_of_2(x, y);
    int32_t f2 = floor_division_by_power_of_2(x, y);
    int32_t c2 = ceiling_division_by_power_of_2(x, y);
    // int32_t m2 = modulo_power_of_2(x, y);

    // printf("x = %u  %u\n", x, decimal_to_binary(x));
    // printf("y = %u\n", y, decimal_to_binary(y));
    // printf("%u  %u\n", t2, decimal_to_binary(t2));
    // printf("%u  %u\n", d2, decimal_to_binary(d2));
    // printf("%u  %u\n", m2, decimal_to_binary(m2));
    printf("%u  %u\n", f2, decimal_to_binary(f2));
     printf("%u  %u\n", c2, decimal_to_binary(c2));

    // printf("%u  %u", x, is_power_of_2(x));

    // uint32_t big_Endian = 0x12345678;  
    // uint32_t little_Endian = 0x78563412;


    // printf("BigEndian to LittleEndian:\n0x%x\n0x%x\n\n", big_Endian, swap_endiannes(big_Endian));
    // printf("BigEndian to LittleEndian but faster:\n0x%x\n0x%x\n\n", big_Endian, swap_endiannes_better(big_Endian));

    // printf("LittleEndian to BigEndian:\n0x%x\n0x%x\n\n", little_Endian, swap_endiannes(little_Endian));
    // printf("LittleEndian to BigEndian but faster:\n0x%x\n0x%x\n\n", little_Endian, swap_endiannes_better(little_Endian));
    return 0;
}

