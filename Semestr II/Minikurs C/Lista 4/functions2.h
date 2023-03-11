#ifndef FUNCTIONS2_H
#define FUNCTIONS2_h

#include <stdio.h>
#include <stdlib.h>

typedef struct Vector
{
    unsigned long length; //długość wektora
    long *data; //wskaźnik na pierwszy element tablicy
    long counter; //ilość zajętych miejsc

}vector;

int czytaj(vector *v, int i); //zwraca i-ty element

void dodaj_na_koniec(vector* v, int x);

void usun_z_konca(vector* v);

vector* stworz_vector();

void zwolnij_vector(vector* v);

#endif