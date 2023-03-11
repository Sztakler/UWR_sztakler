#include "stos.hpp"

int main()
{
    std::cout << "Testowanie konstruktorow:\n";

    std::cout << "\nKonstruktor bezparametrowy (delegatowy) (zostal do niego wlozony jeden napis): ";
    stos stos_delegatowy = stos();
    stos_delegatowy.wloz("Lonely_String");
    stos_delegatowy.wypisz_stos();

    std::cout << "\nKonstruktor z pojemnoscia (zostaly do niego wlozone trzy napisy): ";
    stos stos_rozmiar = stos(10);
    stos_rozmiar.wloz("Napis");
    stos_rozmiar.wloz("napisik");
    stos_rozmiar.wloz("NAPISISKO");
    
    stos_rozmiar.wypisz_stos();

    std::cout << "\nKonstruktor z pojemnoscia (sprobowano utworzyc stos o rozmiarze wiekszym niz 100): \n";
    stos stosNieUdaSie = stos(105);
    std::cout << "Utworzono stos o rozmiarze:" << stosNieUdaSie.pojemn() << std::endl;
    
    std::cout << "\nKonstruktor z lista napisow: ";
    stos stos_lista = stos({"kota", "ma", "Ala"});
    stos_lista.wypisz_stos();

    std::cout << "\nKonstruktor kopiujący (kopia konstruktora z pojemnoscia): ";
    stos stos_kopia = stos(stos_rozmiar);
    stos_kopia.wypisz_stos();

    std::cout << "\nSprawdzanie czy skopiowany stos nie został zmodyfikowany: ";
    stos_rozmiar.wypisz_stos();

    std::cout << "\nKonstruktor przesuwajacy (przesuniety stos z lista napisow): ";
    stos stos_przesuniety = std::move(stos_lista);
    stos_przesuniety.wypisz_stos();

    std::cout << "\nSprawdzanie czy stos utworzony z listy napisow zostal przesuniety (powinien nie istnieć): ";
    try
    {
        stos_lista.wypisz_stos();
    }
    catch(const std::invalid_argument& e)
    {
        std::cerr << e.what() << '\n';
    }

    std::cout << "Sprawdzanie, czy zostanie utworzony stos o liczbie elementow wiekszej niz 100: ";
    try
    {
        stos({"napis", "napis", "napis", "napis", "napis", "napis","napis",
              "napis", "napis", "napis", "napis", "napis", "napis", "napis",
               "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                 "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                  "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                   "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                    "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                     "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                      "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                       "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                        "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                         "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                          "napis", "napis", "napis", "napis", "napis", "napis", "napis",
                           "napis", "napis", "napis", "napis", "napis", "napis", "napis",
            });
    }
    catch(const std::invalid_argument& e)
    {
        std::cerr << e.what() << '\n';
    }
    


    std::cout << "\nNacisnij ENTER (najlepiej dwa razy), by uruchomic interaktywny program do testowania stosu o pojemnosci 10...";
    getchar();
    getchar();
    system("clear");
    stos* stos_testy = new stos(10);

    while(true)
    {
        std::cout << "##STOS##  "; 
        stos_testy->wypisz_stos();
        std::cout << "\n";

        std::cout << "Jaka operacje chcesz wykonac?\n"
        << "1. Sprawdzic jaki element znajduje się na szczycie stosu\n"
        << "2. Zdjac element ze stosu\n"
        << "3. Dodac element na stos\n"
        << "4. Wypisać zawartosc stosu\n"
        << "5. Sprawdzic ilosc elementow na stosie\n"
        << "6. Sprawdzic rozmiar stosu\n"
        << "Aby wyjsc, nacisnij ctrl+c\n";

        switch (getchar())
        {
            case '1': 
            {
                system("clear");

                std::cout << "Element na szczycie stosu: " << stos_testy->sprawdz() << "\n";
                getchar();
                getchar();
                system("clear");
                break;
            }
            case '2': 
            {
                system("clear");

                std::cout << "Element zdjety ze stosu: " << stos_testy->sciagnij() << "\n";
                getchar();
                getchar();
                system("clear");
                break;
            }
            case '3': 
            {
                std::string new_str;
                system("clear");

                std::cout << "Podaj element, ktory chcesz umiescic na stosie: ";
                std::cin >> new_str;
                stos_testy->wloz(new_str);
                getchar();
                getchar();
                system("clear");
                break;
            }
            case '4': 
            {
                system("clear");

                std::cout << "Zawartosc stosu: ";
                stos_testy->wypisz_stos();
                getchar();
                getchar();
                system("clear");
                break;
            }
            case '5': 
            {
                system("clear");
                std::cout << "Ilosc elementow na stosie: " << stos_testy->rozmiar() << "\n";
                getchar();
                getchar();
                system("clear");
                break;
            }
            case '6': 
            {
                system("clear");
                std::cout << "Rozmiar stosu: " <<stos_testy->pojemn() << "\n";
                getchar();
                getchar();
                system("clear");
                break;
            }
            default: 
            {
                std::cout << "Nieprawidlowa opcja!\n";
                getchar();
                getchar();
                system("clear");
            }
           
        }
    }

    delete stos_testy;
    return 0;
}