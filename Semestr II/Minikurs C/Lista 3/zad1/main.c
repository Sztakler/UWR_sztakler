#include "decimalio.h"

int main()
{   
    int n;
    n = read_decimal();
    
    for (int i = 0; i < n; i++)
    {   
        int square = i*i;
        trace_decimal(square);
    }

    return 0;
}