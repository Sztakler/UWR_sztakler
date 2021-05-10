#include <stdio.h>
#include <xpre.h>
int main (void)
{
    struct xpr s;
    int i, n;
    do
    {
        printf ("Give me a number, n = ? \t");
        scanf ("%d", &n);
        s = xZero;
        for (i = 0; i <= n; i++)
        s = xadd (s, xpr2(xOne, i), 0);
        printf ("The sum 2^0 + 2^1 + ... + 2^n is equal to\n");
        xprxpr (s, 30);
        putchar ('\n');
        } while (n > 0);
    return 0;
}