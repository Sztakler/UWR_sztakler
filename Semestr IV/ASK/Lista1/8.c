#include <stdio.h>
#include <stdint.h>

void secret(uint8_t *to, uint8_t* from, size_t count)
{
    size_t n = (count+7) / 8;
    switch(count % 8)
    {
       case 0: do { *to++ = *from++;
       case 7:      *to++ = *from++;
       case 6:      *to++ = *from++;
       case 5:      *to++ = *from++;
       case 4:      *to++ = *from++;
       case 3:      *to++ = *from++;
       case 2:      *to++ = *from++;
       case 1:      *to++ = *from++;
                  } while (--n>0);
    }
}

/* 
Funkcja za pomocą instrukcji goto. Na podstawie 
-- https://gcc.gnu.org/onlinedocs/gcc/Labels-as-Values.html,
-- https://stackoverflow.com/questions/8019849/labels-as-values-vs-switch-statement
*/

void secretGOTO(uint8_t *to, uint8_t* from, size_t count)
{
    size_t n = (count + 7) / 8;
    static void *labels[] = {&&l0, &&l1, &&l2, &&l3, &&l4, &&l5, &&l6, &&l7};
    
    goto *labels[count % 8];

    l0:    *to++ = *from++;
    l7:    *to++ = *from++;
    l6:    *to++ = *from++;
    l5:    *to++ = *from++;
    l4:    *to++ = *from++;
    l3:    *to++ = *from++;
    l2:    *to++ = *from++;
    l1:    *to++ = *from++; 

    if (--n > 0) goto l0;
}

int main(){
   
    uint8_t from[11]  = {1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12};
    uint8_t to[11]    = {0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0};

    for(size_t count = 1; count < 12; count++){
        secret(to, from, count);

        printf("count = %I64u => ", count);
        for(int i = 0; i < 11; i++){
            printf("%u ",to[i]);
            to[i] = 0;
        }
        printf("\n");
    }

     printf("\nWyniki dla wersji z goto\n\n");


    for(size_t count = 1; count < 12; count++){
        secretGOTO(to, from, count);

        printf("count = %I64u => ", count);
        for(int i = 0; i < 11; i++){
            printf("%u ",to[i]);
            to[i] = 0;
        }
        printf("\n");
    }

    return 0;
}