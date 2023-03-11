#include <stdio.h>

int main()
{
    int a, b;

    scanf("%d", &a);
    scanf("%d", &b);

    if(b < a) //finds minimum
    {
        int temp = b;
        b = a;
        a = temp;
    }

    for(int i = a; i <= b; i++)
    {
        printf("%d\n", i);
    }

    return 0;
}