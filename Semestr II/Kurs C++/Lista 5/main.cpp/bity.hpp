#include <iostream>

using namespace std;

class tab_bit
{
    typedef uint64_t slowo; // komorka w tablicy
    static const int rozmiarSlowa = sizeof(slowo) * 8; // rozmiar slowa w bitach
    friend istream & operator >> (istream &we, tab_bit &tb);
    friend ostream & operator << (ostream &wy, const tab_bit &tb);

    class ref // klasa pomocnicza do adresowania bitów
    {
        private:
            slowo & segment;
            int index;

        public:
            ref(int index, slowo & segment);
            ref(const ref &);
            ref(ref &&);
            ref & operator = (const ref &); // przypisanie kopiujące
            ref & operator = (ref &&); // przypisanie przenoszące
            operator bool() const;
            void operator=(bool bit);
    };

    public://protected:
        int dl; // liczba bitów
        slowo *tab; // tablica bitów
    public:
        explicit tab_bit (int rozm); // wyzerowana tablica bitow [0...rozm]
        explicit tab_bit (slowo tb); // tablica bitów [0...rozmiarSlowa]
        explicit tab_bit (initializer_list<bool> init_list); // zainicjalizowana wzorcem
        tab_bit (const tab_bit &tb); // konstruktor kopiujący
        tab_bit (tab_bit &&tb); // konstruktor przenoszący
        tab_bit & operator = (const tab_bit &tb); // przypisanie kopiujące
        tab_bit & operator = (tab_bit &&tb); // przypisanie przenoszące
        ~tab_bit (); // destruktor
    public: //private:
        bool czytaj (int i) const; // metoda pomocnicza do odczytu bitu
        void pisz (int i, bool b); // metoda pomocnicza do zapisu bitu
    public:
        bool operator[] (int i) const; // indeksowanie dla stałych tablic bitowych
        ref operator[] (int i); // indeksowanie dla zwykłych tablic bitowych
        inline int rozmiar () const; // rozmiar tablicy w bitach
    public:
        // operatory bitowe: | i |=, & i &=, ^ i ^= oraz !
};

