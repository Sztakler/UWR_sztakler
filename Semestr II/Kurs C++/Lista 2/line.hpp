#ifndef LINE_HPP
#define LINE_HPP
#include <iostream>
#include "vector.hpp"
#include "point.hpp"
#include "line.hpp"

class Line
{
     private:

        double a, b, c;

        void normalize();
    
    public:

    Line();

    Line(Point, Point);

    Line(Vector);

    Line(double, double, double);

    Line(Line, Vector);
    
    ~Line(){}

    double getter_a();
    double getter_b();
    double getter_c();
};

#endif