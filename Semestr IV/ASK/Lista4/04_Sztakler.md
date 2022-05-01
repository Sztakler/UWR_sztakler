
# Zadanie 4

```c=
uint32_t times_power_of_2(uint32_t x, uint32_t y)
{
    return (x << y);
}

uint32_t divided_by_power_of_2(uint32_t x, uint32_t y)
{
    return (x >> y);
}

uint32_t modulo_power_of_2(uint32_t x, uint32_t y)
{
    return x - ((x >> y) << y);
}
```



