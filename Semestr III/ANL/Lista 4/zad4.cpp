#include <iostream>
#include <iomanip>
#include <math.h>

double f(double x)
{
    return pow(x, 2) - 2.0 * cos(3.0 * x + 1.0);
}

int steps = 16;
double e = pow(10, -5);

void bisection(double a0, double b0)
{
    double a = a0;
    double b = b0;
    double middle = (a + b) / 2.0;
    bool increasing = f(b0) > 0;

    for(int i = 0; i < steps; i++)
    {
        double fm = f(middle);

        if(increasing) 
        {
            if(fm > 0) b = middle;
            else a = middle;
        }
        else
        {
            if(fm < 0) b = middle;
            else a = middle;
        }
        

        middle = (a + b) / 2.0;
    }
    std::cout << std::fixed << "x" << int(a0+1) << " = " << middle << std::endl;
}

int main()
{
    bisection(-1, 0);
    bisection(0, 1);
    return 0;
}