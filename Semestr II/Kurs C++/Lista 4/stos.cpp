#include "stos.hpp"

//Konstruktor z zadaną pojemnością
stos::stos(int pojemnosc) : pojemnosc(pojemnosc % 100), ile(0), tablica(new std::string[this->pojemnosc])
{
    if (pojemnosc > 100) std::cerr << ("Wielkosc stosu nie moze byc wieksza niz 100! Utworzono stos o rozmiarze: ")<<
    this->pojemnosc << std::endl;
}

//Konstruktor bezparametrowy, delegatowy
stos::stos() : stos(1){}

//Konstruktor z listą stringów
stos::stos(std::initializer_list<std::string> string_list)
{
    this->pojemnosc = string_list.size();
    this->ile = this->pojemnosc;
    if (this->pojemnosc > 100) 
    {
        throw std::invalid_argument("Wielkosc stosu nie moze byc wieksza niz 100!");
    }
    this->tablica = new std::string[this->pojemnosc];
    int i = 0;
    for (std::string s : string_list)
    {
        this->tablica[i] = s;
        i++;
    }
}

// Konstruktor kopiujący
stos::stos(const stos& s) : pojemnosc(s.pojemnosc), ile(s.ile), tablica(s.tablica)
{}

//Konstruktor przesuwający
stos::stos(stos && tmp) : 
                        pojemnosc(std::move(tmp.pojemnosc)),
                        ile(std::move(tmp.ile)),
                        tablica(std::move(tmp.tablica))
{

    tmp.tablica = nullptr;
}

//Przypisanie przenoszące
stos & stos::operator= (stos &&tmp)                  
{
    pojemnosc = std::move(tmp.pojemnosc);
    ile = std::move(tmp.ile);
    tablica = std::move(tmp.tablica);
    tmp.tablica = nullptr;
    return *this;
}

stos & stos::operator= (stos &s) //Przypisanie kopiujące
{
    pojemnosc = std::move(s.pojemnosc);
    ile = std::move(s.ile);
    this->tablica = new std::string[s.pojemnosc];
    for (int i = 0; i < ile; i++)
        {
            this->tablica[i] = s.tablica[i];
        }
    return *this;
}

//Tworzenie nowego stosu poprzez odwrócenie starego
stos stos::odwroc()
{
    stos new_stack = stos(ile);

    if (ile > 0)
    {
       for(int i = 0; i < ile; i++)
        {
            new_stack.wloz(tablica[ile-i-1]);    
        } 
    }
    return new_stack;
}

void stos::wloz(std::string str)
{
    if (ile < pojemnosc)
    {
        this->tablica[this->ile] = str;
        this->ile++; 
    }
    else std::cerr << "Nie mozna dodac elementu na pelny stos!\n";
}

std::string stos::sciagnij()
{
    if (this->ile > 0)
    {
        this->ile--;
        return this->tablica[this->ile];
    }
    std::cerr << " BRAK! Nie mozna usunac elementu z pustego stosu\n";
    return "";
}

std::string stos::sprawdz()
{
    if (this->ile > 0) return this->tablica[this->ile-1];
    return this->tablica[0];
}

int stos::rozmiar()
{
    return this->ile;
}

int stos::pojemn()
{
    return this->pojemnosc;
}

void stos::wypisz_stos()
{
    if (this->tablica != nullptr) 
    {
       for (int i = this->ile; i > 0; i--)
    {
        std::cout << this->tablica[i-1] << ", ";
    }
    std::cout << "\n";
    }
    else 
    {
        throw std::invalid_argument("Stos nie istnieje!\n");
        return;  
    }
    
}
