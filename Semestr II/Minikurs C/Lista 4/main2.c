#include "functions2.h"

int main()
{
    //Testy

    // Tworzenie wektora
    vector* v = stworz_vector();
    vector* v1 = stworz_vector();
    vector* v2 = stworz_vector();
    
    
    // Dodawanie elementów do wektora (z poszerzeniem tablicy)
    for (int i = 0; i < 7; i++)
    {
        dodaj_na_koniec(v, i+1);
    }

    //
    printf("Czytanie wartości wektora v:\n");

    for (int i = 0; i < v->length+5; i++)
    {
        printf("%ld ", czytaj(v, i));
    }

    // Usuwanie wartości z końca wektora (usuwamy o 5 elementów więcej niż znajduje się w wektorze)
    printf("\nUsuwanie wartości wektora v:\n");

    for (int i = 0; i < v->length+5; i++)
    {
        usun_z_konca(v);
    }

    for (int i = 0; i < 7; i++)
    {
        printf("%ld ", czytaj(v, i));
    }

    printf("\nZwalnianie wektora:\n");
    zwolnij_vector(v);

    // dodaj_na_koniec(v, 1);
    printf("%ld \n", czytaj(v, 0)); //Zwraca NULL, odkomentowanie powyższej linii poskutkuje naruszeniem ochrony pamięci

    //Kilkukrotne zwiększenie rozmiaru tablicy

    printf("Kilkukrotne zwiększenie rozmiaru tablicy\n");

    for (int i = 0; i < 45; i++)
    {
        dodaj_na_koniec(v1, i+1);
    }

    //Na końcu powinny pojawić się trzy zera,
    //bo nie przypisaliśmy wartości do ostatnich trzech komórek
    for (int i = 0; i < v1->length; i++) printf("%ld ", v1->data[i]); 

    //Wypisanie pustego wektora (powinniśmy zobaczyć trzy zera)
    // i próba wypisania komórki data[3] spoza wektora (nie powinna zostać wypisana)
    printf("\nWypisanie pustego wektora:\n%ld %ld %ld\n", v2->data[0], v2->data[1], v2->data[2], v2->data[3]);



    return 0;
}