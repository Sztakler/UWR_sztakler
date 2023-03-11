#include "classes.hpp"


// KONSTRUKTORY

namespace Calculations
{
Rational::Rational(int numerator, int denominator) //Z licznikiem i mianownikiem
{
    if (denominator == 0) throw DivisionByZero();
    if (denominator < 0)
    {
        denominator *= -1;
        numerator *= -1;
    }

    int a = numerator;
    int b = denominator;
    int divisor = gcd(a , b);
    numerator /= divisor;
    denominator /= divisor;
    this->numerator = numerator;
    this->denominator = denominator;
}

Rational::Rational() : numerator(0), denominator(1)//Domyślny
{
    if (denominator == 0) throw DivisionByZero();
}
Rational::Rational(int number) : Rational(number, 1){} //Konwertujący int

//OPERATORY I FUNKCJE POMOCNICZE

std::string divide_by_hand(int a, int b) //Do tworzenia ułamków okresowych
{
    std::string res = "";
    std::vector<int> occured; //Lista reszt z dzielenia, jakie wystąpiły
    //Dzielenie pisemne
    while (a > b)
    {
        res += std::to_string(a/b);
        a -= (a/b)*b;
    }

    if (res.size() == 0) res += "0";
    res += ",";

    //Dzielenie pisemne po przecinku
    while (a > 0)
    {
        a *= 10; //'a' to kolejne reszty z dzielenia,
                 //będziemy sprawdzać, czy jakaś się powtarza w trakcie obliczeń,
                 //jeśli tak, to mamy cykl
        while (a < b)
        {
            occured.push_back(a);
            res += "0";
            a *= 10;

        }
        for (int x : occured)
        {
          if (x == a) //wystąpił cykl!
          {

                std::string cycle = "";
                for (int i = occured.size() - 2; i >= 0; i--) //iterujemy od tyłu i sprawdzamy
                {                                             //jak długi jest cykl
                    int length = 0;
                    if (occured[i] == occured.back())
                    {
                        length = occured.size() - i - 1;
                        cycle = res.substr(res.size() - length - 1,  length); //zapisujemy do cyklu odcięty
                                                                              //odcięty fragment rozwinięcia
                        if (cycle.back() == '0') //osobny przypadek dla cyklu zakończonego zerem
                        {
                            cycle = cycle.substr(0, cycle.size() - 1);
                            res = res.substr(0, res.size() - cycle.size() - 1) + "(" + cycle + ")";
                            return res;
                        }
                        //teraz wystarczy skleić część ułamka bez okresu i okres (w nawiasach)
                        res = res.substr(0, res.size() - cycle.size() - 1) + "(" + cycle + ")";
                        return res;
                    }
                }
                break;
          }
        }
        //jeśli nie ma okresu, to po prostu dalej liczymy
        res += std::to_string(a/b);
        occured.push_back(a);
        a -= (a/b)*b;

    }
    //wypisywanie, gdy nie znaleziono okresu
    return res;
}

void Rational::normalize()
{
    if (denominator < 0)
    {
        denominator *= -1;
        numerator *= -1;
    }

    int a = this->numerator;
    int b = this->denominator;
    int divisor = gcd(a , b);
    this->numerator   /= divisor;
    this->denominator /= divisor;
}

int Rational::gcd(int a, int b)
{
    if (a < 0) a *= -1;
    if (b < 0) b *= -1;

    if (a < b)
    {
        int tmp = a;
        a = b;
        b = tmp;
    }

    if (b == 0) return a;
    else return gcd(a % b, b);
}


std::ostream& operator << (std::ostream &out, const Rational &r)
{
    if (r.numerator < 0) out << "-" + divide_by_hand(-r.numerator, r.denominator);
    else out << divide_by_hand(r.numerator, r.denominator);
    return out;
}

Rational& Rational::operator + (const Rational& other)
{
    int64_t a = this->numerator;
    int64_t c = other.numerator;
    int64_t b = this->denominator;
    int64_t d = other.denominator;
    if ((a*d+b*c)/(b*d) > INT32_MAX||
        (a*d+b*c)/(b*d) < INT32_MIN) throw OutOfRange();

    Rational* res = new Rational();
    res->numerator   = this->numerator * other.denominator + other.numerator * this->denominator;
    res->denominator = this->denominator * other.denominator;
    res->normalize();
    return *res;
}
Rational& Rational::operator - (const Rational& other)
{
    int64_t a = this->numerator;
    int64_t c = other.numerator;
    int64_t b = this->denominator;
    int64_t d = other.denominator;

    if ((a*d-b*c)/(b*d) > INT32_MAX||
        (a*d-b*c)/(b*d) < INT32_MIN) throw OutOfRange();

    Rational* res = new Rational();
    res->numerator   = numerator * other.denominator - other.numerator * denominator;
    res->denominator = denominator * other.denominator;
    res->normalize();
    return *res;
}
Rational& Rational::operator * (const Rational& other)
{
    int64_t a = this->numerator;
    int64_t c = other.numerator;
    int64_t b = this->denominator;
    int64_t d = other.denominator;

    if( (a*c)/(b*d) > INT32_MAX ||
        (a*c)/(b*d) < INT32_MIN) throw OutOfRange();

    Rational* res = new Rational();
    res->numerator   = numerator * other.numerator;
    res->denominator = denominator * other.denominator;
    res->normalize();
    return *res;
}
Rational& Rational::operator / (const Rational& other)
{
    if (other.numerator == 0) throw DivisionByZero();

    int64_t a = this->numerator;
    int64_t c = other.numerator;
    int64_t b = this->denominator;
    int64_t d = other.denominator;

    if( (a*d)/(b*c) > INT32_MAX ||
        (a*d)/(b*c) < INT32_MIN) throw OutOfRange();

    Rational* res = new Rational();
    res->numerator   = numerator   * other.denominator;
    res->denominator = denominator * other.numerator;
    res->normalize();
    return *res;
}
Rational& Rational::operator - ()
{
    this->numerator *= -1;
    return *this;
}
Rational& Rational::operator ! ()
{
    if (this->numerator == 0) throw DivisionByZero();
    Rational* res = new Rational();
    int tmp = this->numerator;
    res->numerator   = this->denominator;
    res->denominator = tmp;
    res->normalize();
    return *res;
}

Rational::operator double() const
{
    return (double)numerator / (double)denominator;
}

int Rational::get_numerator()
    {
        return numerator;
    }

int Rational::get_denominator()
{
    return denominator;
}

void Rational::print()
{
    std::cout << this->numerator << "/" << this->denominator << std::endl;
}
}