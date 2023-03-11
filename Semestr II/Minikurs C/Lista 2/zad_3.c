#include <stdio.h>
#include <stdlib.h>

int main()
{
    long m=0, n=0;
    char text_A[1000000];
    char text_B[1000000];
    // Czytanie pierwszej linii
    scanf("%ld %s", &m, text_A);
    
    // scanf("%s", text_A);

    // Czytanie drugiej linii
    scanf("%ld %s", &n, text_B);
    
    // scanf("%s", text_B);

    // Sprawdzamy czy poprawny input

    // if (m < 1) m = 1;
    // if (n < 1) n = 1;

    // Bierzemy krótszy ciąg

    if (m > n) 
    {
        int tmp = m;
        m = n;
        n = tmp;
    }
    // Iterujemy po kolejnych znakach,
    // gdy spotkamy różne znaki to sprawdzamy,
    // który jest większy i wypisujemy odpowiedni ciąg.
    // Jeśli krótszy ciąg jest prefiksem dłuższego,
    // to wypisujemy krótszy
    // printf("%s %s\n", text_A, text_B);
    for (long i = 0; i < m; i++)
    {
        // printf("%d %d\n", text_A[i], text_B[i]);
        if(text_A[i] < text_B[i])
        {
            printf("%s\n", text_A);
            return 0;
        } 
        if(text_A[i] > text_B[i])
        {
            printf("%s\n", text_B);
            return 0;
        }
    }
    printf("%s\n", text_A);   
    return 0;
}