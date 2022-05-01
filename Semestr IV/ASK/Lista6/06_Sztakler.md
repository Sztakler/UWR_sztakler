# Zadanie 6

```c=
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
```
