#include "functions2.h"


int czytaj(vector *v, int i)
{
    if (i >= v->length) return 0; //Próba wypisania wartości dla komórki spoza zakresu skutkuje zakończeniem funkcji
    return v->data[i];
}

void dodaj_na_koniec(vector* v, int x)
{
    if (v->counter < v->length) 
    {
        v->data[v->counter] = x;
        v->counter++;
        return;
    }
    else //Zwiększamy dwukrotnie rozmiar tablicy
    {
    // Wersja z realloc
        v->length *= 2;
        v->data = realloc(v->data, sizeof(long)*v->length);
        v->data[v->counter] = x;
        v->counter++;
        v->data[v->counter] = 0;
        return;

    // Wersja z free i malloc
        // long* new = malloc(sizeof(long)*v->length*2);

        // for (int i = 0; i < v->length; i++) // Przepisywanie wartości ze starej tablicy do nowej
        // {
        //     new[i] = v->data[i];
        // }

        // free(v->data); //Usuwanie starej tablicy
        // v->data = new;
        // v->data[v->counter] = x;

        // v->length *= 2;
        // v->counter++;

        // return;
    }
}

void usun_z_konca(vector* v)
{
    if (v->counter > 0) //Próba usunięcia elementu z pustego wektora poskutkuje zakończeniem funkcji
    {
    
        v->data[v->counter-1] = 0;
        v->counter--;
        return;
    }
    return;

}

vector* stworz_vector()
{
    vector * v = malloc(sizeof(vector));

    v->length = 3;
    v->data = malloc(sizeof(long)*v->length);
    v->counter = 0;

    return v;
}

void zwolnij_vector(vector* v)
{
    free(v);
}


