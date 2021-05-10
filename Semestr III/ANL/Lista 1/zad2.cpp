#include <iostream>
#include <cmath>

float f_float(float x)
{
    return (float)12120 * ((x - (float)sin(x)) / (float)pow(x, 3));
}

double f_double(double x)
{
    return (double)12120 * (double)((x - sin(x)) / (double)pow(x, 3));
}


int main()
{
    int a = 1;
    int b = 0;

    for(int i = 11; i < 21; i++)
    {
        std::cout << "For 10^(" << -i << ")\n\tfloat: ";
        std::cout << f_float(float(pow(10, -i))) << "\n\tdouble: ";
        std::cout << f_double(double(pow(10, -i))) << std::endl;
    }

    return 0;
}