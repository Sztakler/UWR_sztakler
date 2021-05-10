#include <iostream>
#include "vector.hpp"
#include "point.hpp"
#include "line.hpp"


Vector::Vector(double dx, double dy) : dx(dx) , dy(dy)
{}

Vector::Vector(const Vector& v) : dx(v.dx) , dy(v.dy)
{}

void Vector::info()
{
    std::cout << "Coordinates: " << dx << " " << dy << std::endl;
}

Vector merge_vectors(Vector v1, Vector v2)
{
    Vector v3(v1.dx+v2.dx, v1.dy+v2.dy);
    return v3;
}
