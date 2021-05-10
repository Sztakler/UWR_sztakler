#include <iostream>
#include <stdlib.h>
#include "classes.hpp"

int main()
{
    List<int> int_list(5);
    List<int> int_list_cp(int_list);
    List<double> float_list_init = {3.14, 3.5, 4.8};

    std::cout << int_list << std::endl;
    std::cout << int_list_cp << std::endl;
    int_list.push_back(7);
    int_list.push_back(8);
    std::cout << int_list << std::endl;
    std::cout << float_list_init << std::endl;  

    float_list_init.insert(42, 5);
    std::cout << float_list_init << std::endl; 
    float_list_init.remove(42);
    std::cout << float_list_init << std::endl; 
    //float_list_init.lookup(10);
    std::cout << int_list.check<int>() << std::endl;
    std::cout << float_list_init.check<double>() << std::endl;
    float_list_init.sort<double>();
    std::cout << float_list_init.check<double>() << std::endl;
    std::cout << float_list_init << std::endl;

    std::cout << "\nNacisnij ENTER (najlepiej dwa razy), by uruchomic interaktywny program do testowania listy jednokierunkowej (typ double)...";
    getchar();
    getchar();
    system("clear");
    List<double>* test_list = new List<double>();

    while(true)
    {
        std::cout << "##LISTA##  "; 
        std::cout << *test_list << std::endl;

        std::cout << "Jaka operacje chcesz wykonać?\n"
        << "1. Wstawić element (typu double) na zadaną pozycję\n"
        << "2. Usunąć element o zadanej wartości\n"
        << "3. Wyszukać element o zadanej wartości\n"
        << "4. Wypisać zawartosc listy\n"
        << "5. Sprawdzic dlugość listy\n"
        << "Aby wyjsc, nacisnij ctrl+c\n";

        switch (getchar())
        {
            case '1': 
            {
                system("clear");
                double d;
                int i;
                std::cout << "Podaj wartość elementu (double) i pozycję (int): ";
                std::cin >> d;
                std::cin >> i;
                test_list->insert(d, i);
                getchar();
                getchar();
                system("clear");
                break;
            }
            case '2': 
            {
                system("clear");
                double d;
                std::cout << "Jaki element chcesz usunąć (double): ";
                std::cin >> d;
                test_list->remove(d);
                std::cout << "Usunięto element: " << d << std::endl;
                getchar();
                getchar();
                system("clear");
                break;
            }
            case '3': 
            {
                std::string new_str;
                system("clear");

                double d;
                std::cout << "Jaki element chcesz wyszukać: ";
                std::cin >> d;
                std::cout << "Znaleziono element na pozycji:  " << test_list->lookup(d) << std::endl;
                getchar();
                getchar();
                system("clear");
                break;
            }
            case '4': 
            {
                system("clear");
                std::cout << "Zawartość listy: " << *test_list << std::endl;
                getchar();
                getchar();
                system("clear");
                break;
            }
            case '5': 
            {
                system("clear");
                std::cout << "Długość listy: " << test_list->length() << "\n";
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

    delete test_list;
    return 0;
}