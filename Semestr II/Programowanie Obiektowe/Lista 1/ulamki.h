#ifndef ULAMKI_H
#define ULAMKI_H
#include <stdio.h>
#include <stdlib.h>


typedef struct fraction_struct
{
    int numerator;
    int denominator;
}Fraction;

int gcd(int a, int b) {
    if (b == 0) 
        return a;
    return gcd(b, (a % b));
}

void set_sign(Fraction* fraction)
{
    int numerator = fraction -> numerator;
    int denominator = fraction -> denominator;

    if ((numerator > 0 && denominator < 0) || (numerator < 0 && denominator < 0))
    {
        fraction -> numerator *= -1;
        fraction -> denominator *= -1;
    }
}

void reduce_fraction(Fraction* fraction)
{
    int numerator = fraction -> numerator;
    int denominator = fraction -> denominator;
    int a = numerator;
    int b = denominator;

    if (a < 0) a *= -1;
    
    if (b < 0) b *= -1;

    int divisor = gcd(a, b);
    numerator /= divisor;
    denominator /= divisor;
    fraction -> numerator = numerator;
    fraction -> denominator = denominator;
}



Fraction* new_fraction(int numerator,int denominator)
{
    if ((numerator > 0 && denominator < 0) || (numerator < 0 && denominator < 0))
    {
        numerator *= -1;
        denominator *= -1;
    }

    else if (denominator == 0)
    {
        printf("Cannot divide by zero\n");
        return NULL;
    }

    Fraction* fraction = malloc(sizeof(Fraction));
    fraction -> numerator = numerator;
    fraction -> denominator = denominator;
    reduce_fraction(fraction);
    return fraction;
}

Fraction* add_fractions(Fraction* fraction1, Fraction* fraction2)
{  
    int a = fraction1 -> numerator;
    int b = fraction1 -> denominator;
    int c = fraction2 -> numerator;
    int d = fraction2 -> denominator;

    return new_fraction(a*d + c*b, b*d);
}

Fraction* add_fractions_2(Fraction* fraction1, Fraction* fraction2)
{
    int a = fraction1 -> numerator;
    int b = fraction1 -> denominator;
    int c = fraction2 -> numerator;
    int d = fraction2 -> denominator;

    fraction2 -> numerator = a*d + c*b;
    fraction2 -> denominator = b*d;
    reduce_fraction(fraction2);

    return fraction2;
}

Fraction* multiply_fractions(Fraction* fraction1, Fraction* fraction2)
{
    int a = fraction1 -> numerator;
    int b = fraction1 -> denominator;
    int c = fraction2 -> numerator;
    int d = fraction2 -> denominator;

    return new_fraction(a * c, b * d);
}

Fraction* multiply_fractions_2(Fraction* fraction1, Fraction* fraction2)
{
    int a = fraction1 -> numerator;
    int b = fraction1 -> denominator;
    int c = fraction2 -> numerator;
    int d = fraction2 -> denominator;

    fraction2 -> numerator = a*c;
    fraction2 -> denominator = b*d;
    reduce_fraction(fraction2);

    return fraction2;
}

Fraction* substrack_fractions(Fraction* fraction1, Fraction* fraction2)
{
    int a = fraction1 -> numerator;
    int b = fraction1 -> denominator;
    int c = fraction2 -> numerator;
    int d = fraction2 -> denominator;
//     fraction2 = multiply_fractions(new_fraction(-1,1), fraction2);
//     return add_fractions(fraction1, fraction2);
    return new_fraction(a * d - b * c, b * d);
}

Fraction* substrack_fractions_2(Fraction* fraction1, Fraction* fraction2)
{
    int a = fraction1 -> numerator;
    int b = fraction1 -> denominator;
    int c = fraction2 -> numerator;
    int d = fraction2 -> denominator;
//     fraction2 = multiply_fractions(new_fraction(-1,1), fraction2);
//     return add_fractions(fraction1, fraction2);
    fraction2 -> numerator = a*d - c*b;
    fraction2 -> denominator = b * d;
    reduce_fraction(fraction2);
    return fraction2;
}

Fraction* divide_fractions(Fraction* fraction1, Fraction* fraction2)
{
    // reverse(fraction2);
    int a = fraction1 -> numerator; 
    int c = fraction2 -> numerator;
    int b = fraction1 -> denominator;
    int d = fraction2 -> denominator;

    return new_fraction(a*d, b*c);
}

Fraction* divide_fractions_2(Fraction* fraction1, Fraction* fraction2)
{
    // reverse(fraction2);
    int a = fraction1 -> numerator; 
    int c = fraction2 -> numerator;
    int b = fraction1 -> denominator;
    int d = fraction2 -> denominator;

    fraction2 -> numerator = a*d; 
    fraction2 -> denominator = b*c;
    reduce_fraction(fraction2);
    set_sign(fraction2);

    return fraction2;
}

void reverse(Fraction* fraction)
{
    int a = fraction -> numerator;
    int b = fraction -> denominator;
    fraction -> numerator = b;
    fraction -> denominator = a;
    set_sign(fraction);
}

void print_fraction(Fraction* fraction)
{
    int a = fraction -> numerator;
    int b = fraction -> denominator;
    printf("%d/%d\n",a, b);
}
#endif