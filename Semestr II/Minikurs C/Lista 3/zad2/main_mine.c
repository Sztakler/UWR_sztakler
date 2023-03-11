#include <stdio.h>
#define MODULUS 4294967295

typedef unsigned char bool;

unsigned long Catalan(unsigned short n);
// unsigned long long results[100];
unsigned long CatalanMem(unsigned short n);

struct mem_entry {
    unsigned long value;
    bool valid;
};

struct mem_entry results[];

int main()
{
    // results[1] = 1;
    // results[0] = 1;
    unsigned short n, how_many = 20;
    unsigned long catalan_n;

    for (unsigned short i = 0; i < how_many; i++)
    {
        catalan_n = Catalan(i);
        printf("%d: %lu\n", i, catalan_n);
    }
}
    

unsigned long Catalan(unsigned short n)
{
    if (n <= 1) return 1;
    
    unsigned long result = 0;
    for (unsigned short i = 0; i < n; i++)
    {
        // if (results[i] && results[n-i-1]) result += results[i]*results[n-i-1];
        // else if(results[i]) result += results[i]*Catalan(n-i-1);
        // else 
        result += Catalan(i)*Catalan(n-i-1);
    }
    // results[n] = result;
    return result % MODULUS;
}

unsigned long CatalanMem(unsigned short n)
{
    if (n <= 1) return 1;
    unsigned long result = 0;
    for (unsigned short i = 0; i < n; i++)
    {
        if (results[i].valid && results[n-i-1].valid) result += results[i].value*results[n-i-1].value;
        else if(results[i].valid) result += results[i].value*Catalan(n-i-1);
        else result += Catalan(i)*Catalan(n-i-1);
    }
    results[n].value = result;
    results[n].valid = 1;
    return result % MODULUS;

}