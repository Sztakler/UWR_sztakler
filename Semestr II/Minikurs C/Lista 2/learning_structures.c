#include <stdio.h>

typedef struct Rectangle
{
    int length;
    int width;
} rectangle;

typedef struct Position
{
    int x;
    int y;
} position;

typedef struct BuildingPlan
{
    char owner[40];
    rectangle rec;
    position pos;
} buildingPlan;

int main()
{
    // system("clear");
    
    buildingPlan house = {"Krystian", {10, 5}, {23, 57}};

    printf("%s's house is of size of %d by %d meters and stands at position %d, %d\n",
    house.owner,
    house.rec.length,
    house.rec.width,
    house.pos.x,
    house.pos.y
    );
    return 0;
}