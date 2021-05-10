#ifndef FIGURY_H
#define FIGURY_H
#include <stdio.h>
#include <stdlib.h>

typedef enum typfig
{
    SQUARE,
    TRIANGLE,
    CIRCLE
} Typfig;

typedef struct figure
{   Typfig type;
    float coordinate_x;
    float coordinate_y;
    float size1;    
    float size2;
}Figure;

Figure* create_square(float coordinate_x, float coordinate_y, float side_length)
{
    if (side_length < 0)
    {
        return NULL;
    }
    Figure* figure = malloc(sizeof(Figure));
    figure -> type = SQUARE;
    figure -> coordinate_x = coordinate_x;
    figure -> coordinate_y = coordinate_y;
    figure -> size1 = side_length;
    figure -> size2 = -1.0;
    
    return figure;
}

Figure* create_circle(float coordinate_x, float coordinate_y, float radius)
{   
    if (radius < 0)
    {
        return NULL;
    }
    Figure* figure = malloc(sizeof(Figure));
    figure -> type = CIRCLE;
    figure -> coordinate_x = coordinate_x;
    figure -> coordinate_y = coordinate_y;
    figure -> size1 = radius;
    figure -> size2 = -1.0;
    
    return figure;
}

Figure* create_triangle(float coordinate_x, float coordinate_y, float heigth, float base_length)
{
    if(heigth < 0 || base_length < 0)
    {
        return NULL;
    }
   
    Figure* figure = malloc(sizeof(Figure));
    figure -> type = TRIANGLE;
    figure -> coordinate_x = coordinate_x;
    figure -> coordinate_y = coordinate_y;
    figure -> size1 = heigth;
    figure -> size2 = base_length;
    
    return figure;
}

float calculate_area(Figure* figure)
{
    Typfig type = figure -> type;
    if (figure != NULL)
    {
        if(type == SQUARE)
        {
            float side = figure -> size1;
            return side*side;
        }
        if(type == CIRCLE)
        {
            float radius = figure -> size1;
            return 3.141592 * radius * radius;
        }
        if(type == TRIANGLE)
        {
            float base_length = figure -> size2;
            float height = figure -> size1;
            return base_length * height / 2;
        }
        else
        {
            printf("This figure is unknown!\n");
            return 0;
        }
    }   
    return 0;
}

void print_figure(Figure* figure)
{   
    if (figure == NULL)
    {
        printf("This is not a valid figure!\n");
        return;
    }
    Typfig type = figure -> type;
    int x = figure -> coordinate_x;
    int y = figure -> coordinate_y;
    int size1 = figure -> size1;
    int size2 = figure -> size2;
    char *size1_name = "None";
    char *size2_name = "None";
    char *name = "None";
    float area = calculate_area(figure);

    switch (type)
    {
    case CIRCLE:
        name = "CIRCLE";
        size1_name = "Radius";
        break;
    case SQUARE:
        name = "SQUARE";
        size1_name = "Side";
        break;
    case TRIANGLE:
        name = "TRIANGLE";
        size1_name = "Base";
        size2_name= "Heigth";
        break;
    default:
        break;
    }
    printf("Figure: %s \nCoordinates:\n  x = %d\n  y = %d\nSize:\n  %s = %d\n  %s = %d\nArea = %f\n\n",name, x, y, size1_name, size1, size2_name, size2, area);
}

void move(Figure* figure, float vector_x, float vector_y)
{
    figure -> coordinate_x += vector_x;
    figure -> coordinate_y +=  vector_y;
}

float get_sum_of_areas(Figure* figure[], int array_size)
{   float sum_of_areas = 0;
    
    for(int i = 0; i < array_size; i++)
    {
        if (figure[i] != NULL) sum_of_areas += calculate_area(figure[i]);
    }
    
    return sum_of_areas;
}
#endif