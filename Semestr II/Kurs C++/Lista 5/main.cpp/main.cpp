#include "bity.hpp"

int main()
{
    tab_bit tb1 = tab_bit(5);
    cout << tb1 << endl;
    tb1[1] = 1;
    cout << tb1 << endl;

    // tab_bit u = tab_bit(101);
    
    tab_bit t(46);// tablica 46-bitowa (zainicjalizowana zerami)
    tab_bit u((uint64_t)45);// tablica 64-bitowa (sizeof(uint64_t)*8)
    cout << u << endl;
    tab_bit v(t);// tablica 46-bitowa (skopiowana z t)
    cout << v << endl;
    tab_bit w(tab_bit{1, 0, 1, 1, 0, 0, 0, 1}); // tablica 8-bitowa (przeniesiona)
    cout << w << endl;
    v[0] = 1;// ustawienie bitu 0-go bitu na 1
    cout << v << endl;
    t[45] = true;// ustawienie bitu 45-go bitu na 1
    cout<<t<<endl;// wysietlenie zawartości tablicy bitów na ekranie
    bool b = v[1];// odczytanie bitu 1-go
    cout<<b<<endl;// wysietlenie zawartości tablicy bitów na ekranie
    u[45] = u[46] = u[63]; // przepisanie bitu 63-go do bitow 45-go i 46-go
    cout<<u<<endl;// wysietlenie zawartości tablicy bitów na ekranie
    return 0;
}