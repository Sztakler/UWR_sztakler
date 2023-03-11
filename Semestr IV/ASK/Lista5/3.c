#include <stdio.h>
#include <stdint.h>

// uint32_t puzzle3(uint32_t n, uint32_t d)
// {   
//     uint64_t numerator = n;                 // movl %edi, %edi
//     uint64_t denominator = (uint64_t)d << 32;   // salq $32, %rsi
//     uint32_t i = 32;               // movl $32, %edx
//     uint32_t mask = 0x80000000;       // movl $0x80000000, %ecx
//     uint32_t result = 0;             // xorl %eax, %eax 

//     for(i; i > 0; i--)
//     {
//         numerator += numerator;                  // addq %rdi, %rdi
//         if(numerator >= denominator)
//         {
//             result = result | mask;
//             numerator = numerator - denominator;
//         }
//         mask = mask >> 1;
//     }

//     return result; 
// }

// uint32_t puzzle3(uint32_t n, uint32_t d)
// {
//     uint64_t numerator = n;                 // movl %edi, %edi
//     uint64_t denominator = (uint64_t)d << 32;   // salq $32, %rsi
//     uint32_t i = 32;               // movl $32, %edx
//     uint32_t mask = 0x80000000;       // movl $0x80000000, %ecx
//     uint32_t result = 0;             // xorl %eax, %eax

//     for(i; i > 0; i--)
//     {
//         numerator += numerator;                  // addq %rdi, %rdi
//         if(numerator >= denominator)
//         {
//             result = result | mask;
//             numerator = numerator - denominator;
//         }
//         mask = mask >> 1;
//     }

//     return result;
// }

int main() 
{
    printf("%u\n", puzzle3(12, 4));
    printf("%u\n", puzzle3(12, 3));
    printf("%u\n", puzzle3(8, 2));
    printf("%u\n", puzzle3(1, 2));
    printf("%u\n", puzzle3(4, 1));
    printf("%u\n", puzzle3(6, 5));
    printf("%u\n", puzzle3(6, 0));

    return 0;
}
