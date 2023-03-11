#ifndef KLASY_HPP
#define KLASY_HPP
#include <iostream>

class Vector
{
    public:
        const double dx = 0, dy = 0;

    // Konstruktor domyślny
    Vector() = default;

    // Konstruktor ze współrzędnymi
    Vector(double x, double y);
    
    // Konstruktor kopiujący
    Vector(const Vector&);

    // Wypisywanie wektora na wyjście
    void info();

    ~Vector(){}
};

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

class Line
{
     private:

        double a=-1, b=1, c=0;

        void normalize();
    
    public:
    
    // Konstruktor domyślny
    Line();

    // Konstruktor prostej przechodzącej przez dwa punkty
    Line(Point, Point);

    // Konstruktor prostej oddalonej o wektor od środka układu współrzędnych
    Line(Vector);

    // Konstruktor prostej z trzema współczynnikami
    Line(double, double, double);

    // Konstruktor prostej otrzymanej przez przesunięcie innej prostej o wektor
    Line(Line*, Vector);
    
    // Usunięty konstruktor kopiujący
    Line(const Line&) = delete;

    ~Line(){}
    
    // Wypisuje postaci normalną i ogólną prostej
    void info();

    // Wypisuje postać ogólną prostej
    void info_general();

    // Gettery
    double getter_a();
    double getter_b();
    double getter_c();

    // Blokowanie przypisania kopiującego
    
    void operator =(const Line&)= delete;

    double get_distance(Point p);

    bool is_parallel(Vector v);
    
    bool is_perpendicular(Vector v);
};





// Funkcje globalne

Vector merge_vectors(Vector v1, Vector v2);

//  Klasa Line jest niekopiowalna, więc trzeba przekazywać wskaźniki do jej pól 

bool are_parallel(Line* l1, Line* l2);

bool are_perpendicular(Line* l1, Line* l2);

Point get_intersection_point(Line* l1, Line* l2);

#endif