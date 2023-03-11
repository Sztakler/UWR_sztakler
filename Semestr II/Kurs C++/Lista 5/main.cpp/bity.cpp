#include "bity.hpp"

#include <cmath>

tab_bit::tab_bit(int rozmiar)
{
    this->dl = rozmiar;
    this->tab = new slowo[(int)(rozmiar / rozmiarSlowa) + 1];

    for (int i = 0; i <= this->dl/rozmiarSlowa; i++) tab[i] = 0;
}

tab_bit::tab_bit(slowo tb)
{
    dl = rozmiarSlowa;
    tab = new slowo[1];
    tab[0] = tb;
}

tab_bit::tab_bit(initializer_list<bool> init_list)
{
    dl = init_list.size();
    tab = new slowo[dl / 8];

    int i = 0;
    for(bool b : init_list)
    {
        pisz(i, b);
        i++;
    }
    
}

tab_bit::tab_bit(const tab_bit &tb)
{
    this->dl = tb.dl;
    this->tab = new slowo[(dl/rozmiarSlowa + 1)];
    for (int i = 0; i <= dl/rozmiarSlowa; i++) this->tab[i] = tb.tab[i];
}

tab_bit::tab_bit(tab_bit &&tb) : dl(move(tb.dl)), tab(move(tb.tab))
{
    tb.tab = nullptr;
}

//Przypisanie kopiujące
tab_bit &tab_bit::operator= (const tab_bit &tb)
{
    this->dl = tb.dl;
    this->tab = new slowo[dl / 8];
    for (int i = 0; i < dl / 8; i++)
        {
            this->tab[i] = tb.tab[i];
        }
    return *this;
}


//Przypisanie przenoszące
tab_bit &tab_bit::operator= (tab_bit &&tb)                  
{
    this->dl = move(tb.dl);
    this->tab = move(tb.tab);
    tb.tab = nullptr;
    return *this;
}

tab_bit::~tab_bit()
{
    delete[] this->tab;
    this->dl = 0;
}


istream & operator >> (istream &we, tab_bit &array_of_binary_numbers)
{
    bool new_bit;
    
    for (int i = 0; i < array_of_binary_numbers.dl; i++)
    {
        we >> new_bit;
        array_of_binary_numbers.pisz(i, new_bit);
    }

    return we;
}

ostream & operator << (ostream &wy, const tab_bit &array_of_binary_numbers)
{
    for (int i = 0; i < array_of_binary_numbers.dl; i++)
    {
       wy << array_of_binary_numbers.czytaj(i);
    }
    return wy;
}

tab_bit::ref::ref(int index, slowo & segment) : index(index), segment(segment){}

tab_bit::ref::ref(const ref &r) : index(r.index), segment(r.segment){}

tab_bit::ref & tab_bit::ref::operator = (const ref &r)
{
    bool b = (bool)r;
    *this = b;  
    return *this;
}

tab_bit::ref & tab_bit::ref::operator = (ref &&r)
{
    bool b = (bool)r;
    *this = b;
    return *this;
}

tab_bit::ref::operator bool() const 
{
    slowo mask = 1 << (rozmiarSlowa - (index % rozmiarSlowa) - 1);
    return segment & mask;
}

void tab_bit::ref::operator=(bool bit) 
{
    int position = rozmiarSlowa - (index % rozmiarSlowa) - 1;

    int mask = 1 << position;
    segment = (segment & ~mask) | (bit << position);
}




bool tab_bit::czytaj (int i) const
{
    slowo s = tab[(i / rozmiarSlowa)];
    slowo mask = 1 << (rozmiarSlowa - (i % rozmiarSlowa) - 1);
    return s & mask;
}


void tab_bit::pisz (int i, bool b)
{
    int s = i / rozmiarSlowa;
    int position = rozmiarSlowa - (i % rozmiarSlowa) - 1;

    int mask = 1 << position;
    tab[(i / rozmiarSlowa)] = (tab[(i / rozmiarSlowa)] & ~mask) | (b << position);
}

inline int tab_bit::rozmiar () const
{
    return dl;
}


bool tab_bit::operator[] (int i) const
{
    return czytaj(i);
}

tab_bit::ref tab_bit::operator[] (int i)
{
    int segment_index = i / rozmiarSlowa;
    int bit_index = i % rozmiarSlowa;
    ref result_reference = ref(bit_index, tab[segment_index]);
    return result_reference;
}