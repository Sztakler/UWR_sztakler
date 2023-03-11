#ifndef VECTOR_HPP
#define VECTOR_HPP
#include <iostream>
#include "point.hpp"
#include "line.hpp"
#include "vector.hpp"

class Vector
{
    public:
        const double dx = 0, dy = 0;

    // Konstruktor domyślny
    Vector() = default;

    // Konstruktor ze współrzędnymi
    Vector(double, double);
    
    // Konstruktor kopiujący
    Vector(const Vector&);

    // Wypisywanie wektora na wyjście
    void info();

    ~Vector(){}
};

Vector merge_vectors(Vector v1, Vector v2);

#endif