#include <stdio.h>
#include <stdlib.h>
#include "figury.h"

int main()
{
    Figure* square = create_square(1.0, -1.0, -3.0);
    Figure* circle = create_circle(0.0, 0.0, 5.0);
    Figure* triangle = create_triangle(0.0, 0.0, 5.0, 10.0);
    Figure* figures[3] = {square, circle, triangle}; 
    print_figure(square);
    print_figure(circle);
    print_figure(triangle);
    float sum_of_areas = get_sum_of_areas(figures, 3);
    printf("Sum of areas = %f\n", sum_of_areas);
    return 0;
}