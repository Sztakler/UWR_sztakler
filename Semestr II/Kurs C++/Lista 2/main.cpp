#include <iostream>
#include "klasy.hpp"

int main()
{

    try
    {
         // Testowanie klasy Vector
    std::cout << "TESTING CLASS VECTOR CONSTRUCTORS...\n\n";

    // Konstruktor domyślny
    Vector v_default;

    // Konstruktor ze wspołrzędnymi
    Vector v_coordinates(2, 3);
    
    // Konstruktor kopiujący
    Vector v_copy(v_coordinates);

    std::cout << "    Default vector: ";
    v_default.info();
    std::cout << "    Coordinates vector: ";
    v_coordinates.info();
    std::cout << "    Copied vector: ";
    v_copy.info();


// Testowanie klasy Point
    std::cout << "\nTESTING CLASS POINT CONSTRUCTORS...\n\n";

    // Konstruktor domyślny;
    Point p_default;

    // Konstruktor ze wspólrzędnymi
    Point p_coordinates(2, 4);

    // Konstruktor z innym punktem i wektorem
    Point p_moved(p_coordinates, v_coordinates);

    // Konstruktor kopiujący
    Point p_copy(p_coordinates);

    std::cout << "    Default point: ";
    p_default.info();
    std::cout << "    Coordinates point: ";
    p_coordinates.info();
    std::cout << "    Moved point: ";
    p_moved.info();
    std::cout << "    Copied point: ";
    p_copy.info();


// Testowanie klasy Line
    std::cout << "\nTESTING CLASS LINE CONSTRUCTORS...\n\n";

    // Konstruktor z parą punktów
    Line l_pair(p_moved, p_coordinates);

    // Konstruktor z wektorem
    Line l_vector(v_coordinates);
    
    // Konstruktor ze współczynnikami
    Line l_coefficients(2,5,7);

    // Konstruktor z prostą i wektorem
    Line l_moved(&l_coefficients, v_coordinates);

    // Konstruktor bezparametrowy
    Line l_default;

    std::cout << "\n    Line passing through pair of points: \n";
    l_pair.info();
    std::cout << "\n    Line perpendicular to a vector: \n";
    l_vector.info();
    std::cout << "\n    Line with coefficients: \n";
    l_coefficients.info();
    std::cout << "\n    Line moved by a vector: \n";
    l_moved.info();
    std::cout << "\n    Default line: \n";
    l_default.info();

// Testowanie funkcji klasy Line
    std::cout << "\nTESTING CLASS LINE FUNCTIONS...\n\n";
    
    Line l_parallel_1(2, 6, -3);
    Line l_parallel_2(4, 12, 10);
    Line l_perpendicular_1(-6, 2, 7);
    Line l_not_parallel_1(2, 5, 8);
    Vector v_parallel_1(3, 1);
    Vector v_not_parallel_1(1,3);
    Vector v_perpendicular_1(-1, 3);



    std::cout << "Checking if line is perpendicular to a vector: \n    Line: ";
    l_parallel_1.info_general();
    std::cout << "    Vector: ";
    v_perpendicular_1.info();
    std::cout << "    Result: ";
    std::cout << l_parallel_1.is_perpendicular(v_perpendicular_1) << std::endl;

    std::cout << "\nChecking if line is parallel to a vector: \n    Line: ";
    l_parallel_1.info_general();
    std::cout << "    Vector: ";
    v_parallel_1.info();
    std::cout << "    Result: ";
    std::cout << l_parallel_1.is_parallel(v_parallel_1) << std::endl;

    std::cout << "\nDistance from line to a point: \n    Line: ";
    l_parallel_1.info_general();
    std::cout << "    Point: ";
    p_default.info();
    std::cout << "    Result: ";
     std::cout << l_parallel_1.get_distance(p_default) << std::endl;

// Testowanie funkcji globalnych

    std::cout << "\nTESTING GLOBAL FUNCTIONS...\n\n";

    std::cout << "\nChecking if lines are perpendicular: \n    Line 1: ";
    l_parallel_1.info_general();
    std::cout << "    Line 2: ";
    l_perpendicular_1.info_general();
    std::cout << "    Result: ";
     std::cout << are_perpendicular(&l_parallel_1, &l_perpendicular_1) << std::endl;

     std::cout << "\nChecking if lines are perpendicular: \n    Line 1: ";
    l_parallel_1.info_general();
    std::cout << "    Line 2: ";
    l_parallel_2.info_general();
    std::cout << "    Result: ";
     std::cout << are_perpendicular(&l_parallel_1, &l_parallel_2) << std::endl;

    std::cout << "\nChecking if lines are parallel: \n    Line 1: ";
    l_parallel_1.info_general();
    std::cout << "    Line 2: ";
    l_parallel_2.info_general();
    std::cout << "    Result: ";
     std::cout << are_parallel(&l_parallel_1, &l_parallel_2) << std::endl;

    std::cout << "\nChecking if lines are parallel: \n    Line 1: ";
    l_parallel_1.info_general();
    std::cout << "    Line 2: ";
    l_perpendicular_1.info_general();
    std::cout << "    Result: ";
    std::cout << are_parallel(&l_parallel_1, &l_perpendicular_1) << std::endl;

    std::cout << "\nChecking where lines intersect: \n    Line 1: ";
    l_parallel_1.info_general();
    std::cout << "    Line 2: ";
    l_perpendicular_1.info_general();
    std::cout << "    Result: ";
    Point intersection_point(get_intersection_point(&l_parallel_1, &l_perpendicular_1));
    intersection_point.info();
    std::cout << "\n";

    std::cout << "\nMerging two vectors: \n    Vector 1: ";
    v_not_parallel_1.info();
    std::cout << "    Vector 2: ";
    v_parallel_1.info();
    std::cout << "    Result: ";
    Vector vector_merged(merge_vectors(v_not_parallel_1, v_parallel_1));
    vector_merged.info();
    std::cout << "\n";



    } 
    catch(const std::invalid_argument& e)
    {
        std::cerr << e.what() << '\n';
    }
    
    // Testowanie wychwytywania błędów
    
    try
    {
    
        std::cout << "\nTESTING EXCEPTIONS...\n\n";
        Point p_invalid_1(0,0);
        Point p_invalid_2(0,0);
        std::cout << "Point 1: "; p_invalid_1.info();
        std::cout << "Point 2: "; p_invalid_2.info();
        Line line_invalid(p_invalid_1, p_invalid_2);
    }
    catch(const std::invalid_argument& e)
    {
        std::cerr << e.what() << '\n';
    }

  
    return 0;
}