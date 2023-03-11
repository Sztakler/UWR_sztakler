#ifndef STOS_HPP
#define STOS_HPP

#include <iostream>

class stos
{
    private:
    int pojemnosc;
    int ile;
    std::string *tablica;
    

    // Konstruktory
    public:

    stos(int); //Konstruktor zadający rozmiar stosu

    stos(); //Konstruktor bezparametrowy, delegatowy

    stos(std::initializer_list<std::string>); //Konstruktor inicjalizujący stos za pomocą listy napisów

    stos(const stos&); //Konstruktor kopiujący 

    stos(stos && other); //Konstruktor przesuwający
    
    stos & operator= (stos &&); //Przypisanie przenoszące

    stos & operator= (stos &); //Przypisanie kopiujące

    // Destruktor usuwający tablicę
    ~stos() 
    {
        delete[] tablica;
    }

    // Funkcje wykonujące operacje na stosie
    void wloz(std::string str);

    std::string sciagnij();

    std::string sprawdz();

    int rozmiar();

    int pojemn();

    void wypisz_stos();

    stos odwroc();
};

#endif