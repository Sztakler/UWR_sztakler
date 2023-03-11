#include <stdio.h>
#include <stdlib.h>
#include "ulamki.h"

int main()
{
    printf("Creating new fractions and displaying result of operations:\n");
    Fraction* frac1 = new_fraction(3, -9);
    Fraction* frac2 = new_fraction(7, 3);
    printf("Fraction1\n");
    print_fraction(frac1);
    printf("Fraction2:\n");
    print_fraction(frac2);
    printf("Addition:\n");
    print_fraction(add_fractions(frac1, frac2));
    print_fraction(add_fractions_2(frac1, frac2));
    frac2 = new_fraction(7, 3);
    printf("Subtraction:\n");
    print_fraction(substrack_fractions(frac1, frac2));
    print_fraction(substrack_fractions_2(frac1, frac2));
    frac2 = new_fraction(7, 3);
    printf("Multiplication:\n");
    print_fraction(multiply_fractions(frac1, frac2));
    print_fraction(multiply_fractions_2(frac1, frac2));
    frac2 = new_fraction(7, 3);
    printf("Division:\n");
    print_fraction(divide_fractions(frac1, frac2));
    print_fraction(divide_fractions_2(frac1, frac2));
    frac2 = new_fraction(7, 3);
    return 0;
}