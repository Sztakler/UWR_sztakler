#ifndef POINT_HPP
#define POINT_HPP
#include <iostream>
#include "vector.hpp"
#include "point.hpp"
#include "line.hpp"

class Point
{
    public:
        const double x = 0, y = 0;

    // Konstruktor domyślny
    Point() = default;

    // Konstruktor ze współrzędnymi
    Point(double, double);

    // Konstruktor z innymi punktem
    Point(Point, Vector);

    // Konstruktor kopiujący
    Point(const Point&);

    void operator =(const Point&)= delete;

    void info();

    ~Point(){}
};
#endif