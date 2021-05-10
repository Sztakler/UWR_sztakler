#include <iostream>
#include <math.h>
#include <iomanip>

double x_n(int n, double x0)
{
    double xn = x0;

    for(int i = 0; i < n; i++)
    {
        
        xn = xn - (pow(xn, 2) / (2.0 * xn)) - 0.5 * (2.0 / (2.0 * xn)) * pow((pow(xn, 2) / (2.0 * xn)), 2);
    }

    return xn;
}

double y_n(int n, double x0)
{
    double xn = x0;

    for(int i = 0; i < n; i++)
    {
        
        xn = xn - (pow(xn, 2) / (2.0 * xn));
    }
    std::cout << std::fixed << std::setprecision(20) <<"### xn " << xn << std::endl;

    return xn;
}

double p_(double a, double xPrev, double xCurr, double xNext)
{
    double p = log(fabs(xNext - a) / fabs(xCurr - a)) / log(fabs(xCurr - a) / fabs(xPrev - a));

    return p;
}

int main()
{
    double x_3n = y_n(7, 0.1);
    double x_2n = y_n(6, 0.1);
    double x_1n = y_n(5, 0.1);
    double x_0n = y_n(4, 0.1);
    double a = 0.0;
    double p = p_(a, x_1n, x_2n, x_3n);

    std::cout << std::fixed << std::setprecision(20) <<"### 2^3 ### p = " << p << std::endl;

    return 0;
}