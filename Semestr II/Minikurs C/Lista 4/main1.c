#include "functions1.h"

/*Przepraszam, że wysłałem zadanie po terminie, ale zapomnialem że miałem czas do północy 26.03. 
Jeśli jednak zdecydowałby Pan, że mimo to przyjmie Pan to rozwiązanie, to załączam kod.*/

int main()
{

    char destination0[30] = "Ala ";
    char empty1[30] = "\0"; //pusty napis
    char empty2[30] = "\0"; //pusty napis
    char empty3[30] = "\0"; //pusty napis
    char empty4[30] = "\0"; //pusty napis
    const char* source = "ma kota";
    char destination2[30] = "Ala ";
    
    char destination5[30] = "Ala ";
    const char* source3 = "ma kota";
    // printf("%s\n", strcat(destination5, source3));

    for (int i = 0; i < 30; i++)
    {
        printf("%c, ", destination5[i]);
    }

    printf("\n");

    for (int i = 0; i < 30; i++)
    {
        printf("%c, ", source3[i]);
    }
    strcat(destination5, source3);
    printf("\n");
    for (int i = 0; i < 30; i++)
    {
        printf("%c, ", destination5[i]);
    }

    // //Doklejanie do pustego napisu
    // printf("\nDoklejanie do pustego napisu:\n");
    // printf("%s\n", strcat(empty1, source));
    // printf("%s\n", strncat(empty2, source, 4));

    // //Doklejanie pustego napisu
    // printf("\nSklejanie pustych napisów:\n");
    // printf("%s\n", strcat(destination2, empty3));
    // printf("%s\n", strncat(destination2, empty3, 4));

    // //Sklejanie dwóch pustych napisów
    // printf("\nSklejanie dwóch pustych napisów:\n");
    // printf("%s\n", strcat(empty3, source));
    // printf("%s\n", strncat(empty4, source, 4));

    // //Sklejanie dwóch napisów
    // char destination5[30] = "Ala ";
    // char destination6[30] = "Ala ";
    // const char* source3 = "ma kota";
    // printf("\nSklejaniee dwóch napisów:\n");
    // printf("%s\n", strcat(destination5, source3));
    // printf("%s\n", strncat(destination6, source3, 4));

    // //Porównywanie pustych napisów
    // char* source1 = "\0";
    // char* source2 = "\0";
    // printf("\nPorównywanie pustych napisów:\n");
    // printf("%s\n", strcmp(source1, source2));
    // printf("%s\n", strncmp(source1, source2, 4));


    // //Porównywanie napisu z pustym napisem
    // char* destination3 = "Ala ";
    // printf("\nPorównywanie napisu z pustym napisem:\n");
    // printf("%d\n", strcmp(destination3, empty3));
    // printf("%d\n", strcmp(destination3, empty3));
   
    // //Porównywanie dwóch napisów
    // const char* str1 = "aaaaac";
    // const char* str2 = "aaaaacc";
    

    // printf("\nPorównywanie dwóch napisów:\n");
    // printf("%d\n", strcmp(str1, str2));
    // printf("%d\n", strcmp(str1, str2));
    
    return 0;
}
