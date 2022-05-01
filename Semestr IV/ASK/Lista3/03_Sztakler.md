# Zadanie 3

```c-
/* Funkcja przydatna w kolejnych zadaniach */
int decimal_to_binary(int dec_num) /
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
```
