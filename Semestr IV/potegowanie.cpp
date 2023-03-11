/*
Krystian Jasionek
317806
KLO
*/

#include <stdio.h>
#include <limits.h>
#include <stdint.h>

/*
    Wykorzystujemy własność, że 
    A^B mod C = ((A mod C)^B)mod C
*/

// uint64_t slower_fast_mod_power(uint64_t a, uint64_t b, uint64_t m)
// {
//     uint64_t result = 1;
//     int steps = 0;
//     while(b > 0)
//     {
//         if(b & 1)
//         {
//             result = (result * a) % m;
//         }    
    
//         b = b >> 1;
//         a = (a * a) % m;
//         steps++;
//     }
//     // printf("Fast steps = %d\n", steps);
//     return result;
// }

unsigned int russian_peasant_multiplication(unsigned int a, unsigned int b, unsigned int m)
{
    unsigned int result = 0;

    while(b > 0)
    {
        if (b & 1)
        {
            result = (result + a) % m;
        }
        
        a = (a << 1) % m;
        b = b >> 1;
    }

    return result;
}

unsigned int fast_mod_power(unsigned int a, unsigned int b, unsigned int m)
{
    unsigned int result = 1;
    unsigned int previous = a % m;
    while(b)
    {
        if(b & 1)
        {
            result = (russian_peasant_multiplication(result, previous, m)) % m;
        }
        previous = (russian_peasant_multiplication(previous, previous, m)) % m;
        b = b >> 1;
    };
    return result % m;
}

int main()
{

    unsigned int t, a, b, m;

    scanf("%u", &t);

    unsigned int* A = new unsigned int[t];
    unsigned int* B = new unsigned int[t];
    unsigned int* M = new unsigned int[t];

    for(unsigned int i = 0; i < t; i++)
    {
        scanf("%u %u %u", &A[i], &B[i], &M[i]);
    }

    printf("\n");
    for(unsigned int j = 0; j < t; j++)
    {
        a = A[j];
        b = B[j];
        m = M[j];
        printf("%u\n", fast_mod_power(a, b, m));
        
    }
    
    delete[] A;
    delete[] B;
    delete[] M;
    return 0;
}