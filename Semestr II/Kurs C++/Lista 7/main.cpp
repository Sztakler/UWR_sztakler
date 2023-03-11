#include "classes.hpp"

using namespace Calculations;

int main()
{

    Rational a(3, 21); 
    Rational b(3, -8); 
    Rational c(a); 
    Rational d = b;

    std::cout << "Tworzenie liczb wymiernych\na = ";
    a.print();
    std::cout << "b = ";
    b.print();
    std::cout << "Kopiowanie liczby 'a' bez zmiany a\nc = ";
    c.print();
    std::cout << "a = ";
    a.print();
    std::cout << "Kopiowanie liczby 'b' bez zmiany b\nd = ";
    d.print();
    std::cout << "b = ";
    b.print(); 
    std::cout << "Uzycie konstruktora konwertującego z int\n5 = ";
    Rational from_int(5);
    from_int.print();

    std::cout << "----------------------------------------------\n";
    std::cout << "Testowanie operacji arytmetycznych\n";

    // Test obsługi wyjątku przekroczenia zakresu
    // std::cout << "Powinno wyskoczyć poza zakres: INT32_MAX = " << INT32_MAX << " a to suma = " << (int64_t)INT32_MAX + (int64_t)INT32_MAX << std::endl;
    // Rational p(INT32_MAX, 1);
    // Rational q(1,1);
    // std:: cout << "p + q = ";
    // (p+q).print();

    std::cout << "a + b + c= ";
    Rational add_abc = (a+b+c);
    add_abc.print();


    std::cout << "a - b = ";
    (a - b).print();

    std::cout << "a * b = ";
    Rational amb = a * b;
    (a*b).print();

    std::cout << "a / b = ";
    (a / b).print();
    
    std::cout << "----------------------------------------------\n";
    std::cout << "Operatory liczby odwrotnej i przeciwnej do 1/3:\nodwrotna = ";
    Rational r(1, 3);
    (!r).print();
    std::cout << "przeciwna = ";
    (-r).print();
    std::cout << "----------------------------------------------\n";
    std::cout << "Castowanie -3/8\ndo int: ";
    int number_int = b;
    double number_double = b;
    std::cout << number_int << std::endl;
    std::cout << "do double: ";
    std::cout << number_double << std::endl;

    std::cout << "----------------------------------------------\n";
    std::cout << "Testowanie operatora strumienia\n1/3 = ";
    Rational repeating1(1, 3);
    std::cout << repeating1 << std::endl;
    Rational repeating2(-1, 81);
    std::cout << "-1/81 = ";
    std::cout << repeating2 << std::endl;
    Rational repeating3(7, 12);
    std::cout << "7/12 = ";
    std::cout << repeating3 << std::endl;
    Rational repeating4(22, 7);
    std::cout << "22/7 = ";
    std::cout << repeating4 << std::endl;


    std::cout << "----------------------------------------------\n";
    std::cout << "Testowanie getterów i setterów\n";
    std::cout << "1/7: licznik = " << a.get_numerator() << ", mianownik = " << a.get_denominator() <<std::endl;
    // std::cout << "----------------------------------------------\n";
    // std::cout << "Testowanie wyjątków\n";
    // Rational excpt(22, 0);
    // std::cout << "22/0 = ";
    // try
    // {
    // std::cout << excpt << std::endl;
    // }
    // catch(const std::exception& e)
    // {
    //     std::cerr << e.what() << '\n';
    // }
    return 0;
}