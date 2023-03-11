#include <iostream>
#include <math.h>
#include <vector>
#include <algorithm>

namespace Calculations
{
    class Rational
    {
        public:
        int numerator;
        int denominator;

        friend std::ostream& operator << (std::ostream &out, const Rational &rational);

        private:
        void normalize();
        int gcd(int a, int b);

        public:
        Rational();
        Rational(int numerator, int denominator);
        Rational(int number);

        // Rational(Rational& rational);
        // Rational& operator = (Rational& rational);
        // nie jest potrzebny, kompilator poradzi sobie sam,
        // a semantyka przenoszenia jest zbyteczna, liczby wymierne
        // nie zajmują dużej ilości pamięci

        Rational& operator + (const Rational&);
        Rational& operator - (const Rational&);
        Rational& operator * (const Rational&);
        Rational& operator / (const Rational&);
        Rational& operator - ();
        Rational& operator ! ();

        operator double() const;
        explicit operator int() const {return floor(numerator / denominator);}

        int get_numerator();
        int get_denominator();
        void print();

    };


    class RationalException: public std::exception
    {
        protected:
            std::string m_error;

        public:
            virtual const char* what() const throw()
            {
                return "that's irrational!";
            }
    };

    class DivisionByZero : public RationalException
    {
        public:
            const char* what() const throw() 
            {
                return "cannot divide by zero";
            }
    };

    class OutOfRange : public RationalException
    {
        public:
            const char* what() const throw()
            {
                return "input out of range";
            }
    };

    std::string divide_by_hand(int a, int b);
}
