#include <iostream>
#include <math.h>
#include "klasy.hpp"

// Point

Point::Point(double x, double y) : x(x) , y(y)
{}

Point::Point(Point p, Vector v) : x(p.x+v.dx) , y(p.y+v.dy) 
{}

Point::Point(const Point& p) : x(p.x) , y(p.y)
{}

void Point::info()
{
    std::cout << "x=" << x << ", y=" << y << std::endl;
}




// Vector

Vector::Vector(double dx, double dy) : dx(dx) , dy(dy)
{}

Vector::Vector(const Vector& v) : dx(v.dx) , dy(v.dy)
{}

void Vector::info()
{
    std::cout << "x=" << dx << ", y=" << dy << std::endl;
}






// Line

Line::Line() = default;

Line::Line(Point p1, Point p2)
{   
    if (p1.x == p2.x && p1.y == p2.y) throw std::invalid_argument("Arguments cannot be identical!\n");
    normalize();
    if(p1.x == p2.x)
    {
        this->a = 1;
        this->b = 0;
        this->c = p1.x;
    }
    else
    {
        this->a = (p1.y - p2.y)/(p1.x - p2.x);
        this->b = -1;
        this->c = p1.y - (p1.y - p2.y)/(p1.x - p2.x)*p1.x;
    }
    normalize();
}

Line::Line(Vector v)
{
    // if (v.dy == 0 || v.dx == 0) throw std::invalid_argument("Vector cannot have a zero coordinate!\n");
    double alpha = -1/(v.dy/v.dx);
    this->a = alpha;
    this->c = v.dy - this->a*v.dx;
    this->b = -1;
    normalize();
}

Line::Line(double a, double b, double c) : a(a) , b(b), c(c)
{
    if (this->a == 0 && this->b == 0) throw std::invalid_argument("'A' and 'B' cannot be both zero!\n");
    normalize();
}

Line::Line(Line *l, Vector v)
{   
    this->a = l->getter_a();
    this->b = l->getter_b();
    this->c = l->getter_c() + v.dy - l->getter_a()*v.dx;
}

double Line::getter_a()
{
    double norm_fact = this->b;
    return this->a/norm_fact;
}
double Line::getter_b()
{
    double norm_fact = this->b;
    return this->b/norm_fact;
}

double Line::getter_c()
{
    double norm_fact = this->b;
    return this->c/norm_fact;
}

void Line::info()
{
    double a = this->getter_a();
    double b = this->getter_b();
    double c = this->getter_c();

    std::cout << "Line in NORMAL (x Cos(ø) + y Sin(ø) - p = 0) form: " << this->a << "x + " << this->b << "y + " << this->c << " = 0\nor in GENERAL (Ax + By + C = 0) form: " << 
    a << "x + " << b << "y + " << c << " = 0" << std::endl;
}

void Line::info_general()
{
    double a = this->getter_a();
    double b = this->getter_b();
    double c = this->getter_c();

    std::cout << "(Ax + By + C = 0) " << a << "x + " << b << "y + " << c << " = 0" << std::endl;
}

void Line::normalize()
{   double sign = 1;
    if(this->c >= 0) sign=-1;    

    double norm_factor = sign/sqrt(pow(this->a, 2) + pow(this->b, 2));

    this->a *= norm_factor;
    this->b *= norm_factor;
    this->c *= norm_factor;
}

double Line::get_distance(Point p)
{
    double a = this->getter_a();
    double b = this->getter_b();
    double c = this->getter_c();
    return std::abs(a*p.x + b*p.y + c)/std::sqrt(std::pow(a, 2)+std::pow(b, 2));
}

bool Line::is_parallel(Vector v)
{
    double epsilon = 0.000001;
    double a = this->getter_a();
    double b = this->getter_b();
    if (std::abs(-a/b - v.dy/v.dx) < epsilon) return true;
    return false;
}
    
bool Line::is_perpendicular(Vector v)
{   
    double epsilon = 0.000001;
    double a = this->getter_a();
    double b = this->getter_b();
    if (std::abs(-a/b * v.dy/v.dx + 1) < epsilon) return true;
    return false;
}




// Global

bool are_parallel(Line* l1, Line* l2)
{
    double epsilon = 0.000001;
    double a1 = l1->getter_a();
    double a2 = l2->getter_a();
    double b1 = l1->getter_b();
    double b2 = l2->getter_b();
    

    if (std::abs(-a1/b1 + a2/b2) < epsilon) return true;
    return false;
}

bool are_perpendicular(Line* l1, Line* l2)
{
    double epsilon = 0.000001;
    double a1 = l1->getter_a();
    double a2 = l2->getter_a();
    double b1 = l1->getter_b();
    double b2 = l2->getter_b();

    if (std::abs(-a1/b1 * (-a2/b2) + 1) < epsilon) return true;
    return false;
}

Point get_intersection_point(Line* l1, Line* l2)
{
    double a1 = l1->getter_a();
    double a2 = l2->getter_a();
    double b1 = l1->getter_b();
    double b2 = l2->getter_b();
    double c1 = l1->getter_c();
    double c2 = l2->getter_c();

    
    double x = (b1*c2-b2*c1)/(a1*b2-a2*b1);
    double y = (a2*c1-a1*c2)/(a1*b2-a2*b1);

    return Point(x, y);
}

Vector merge_vectors(Vector v1, Vector v2)
{
    Vector v3(v1.dx+v2.dx, v1.dy+v2.dy);
    return v3;
}
