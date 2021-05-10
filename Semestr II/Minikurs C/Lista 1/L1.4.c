#include <stdio.h>

int main(){

    int x = 0, xSquared = 0, a, tmpX = 0, tmpXsquared = 0, res, j, i;

    printf(u8"Podaj dolną granicę przedziału: ");
    scanf("%d", &a);

    for (i = a; i <= 10*a; i++){

        x = i;
        xSquared = x * x;
        //printf("Initial xSquared = %d\n", xSquared);
        j = 1;
        res = 0;
        //comparing last digits of xSquared with digits of x
        while (x > 0){
            res += (xSquared % 10) * j;
            tmpXsquared = xSquared % 10;
            tmpX = x % 10;
            xSquared /= 10;
            x /= 10;
            j *= 10;
            //printf("i = %d,  res = %d, x = %d, xSquared = %d \n", i, res, x, xSquared);
            if (tmpX != tmpXsquared){
                break;
            }
        }
        
        if (res == i){
            printf("i = %d,  res = %d\n", i, res);
            return 0;
        }


    }
    printf("Brak\n");
    return 0;
}

