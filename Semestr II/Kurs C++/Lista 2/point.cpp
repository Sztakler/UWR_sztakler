#include <iostream>
#include "vector.hpp"
#include "point.hpp"
#include "line.hpp"


Point::Point(double x, double y) : x(x) , y(y)
{}

Point::Point(Point p, Vector v) : x(p.x+v.dx) , y(p.y+v.dy) 
{}

Point::Point(const Point& p) : x(p.x) , y(p.y)
{}

void Point::info()
{
    std::cout << "Coordinates: " << x << " " << y << std::endl;
}
