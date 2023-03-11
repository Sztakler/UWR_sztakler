// #include <stdlib.h>
#include <stdio.h>

int value1 = 10, value2 = 20;
int *ptr_value1 = &value1, *ptr_value2 = &value2;

void increment(int *ptr)
{
    *ptr+=1;
    printf("Increment value: %d\n", *ptr);
}

void swap(int* val1, int* val2)
{
    int tmp = *val2;
    *val2 = *val1;
    *val1 = tmp;
}

int main()
{
    printf("%d\n", value1);
    increment(&value1);
    printf("%d\n\n", value1);

    printf("Before swap:\n   value1 = %d, value2 = %d\n", value1, value2);
    swap(&value1, &value2);
    printf("After swap:\n   value1 = %d, value2 = %d\n", value1, value2);


    return 0;
}