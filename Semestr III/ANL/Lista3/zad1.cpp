
#include <iostream>
#include <math.h>
#include <iomanip>

double factorial(int n)
{
    double result = 1.0;
    for(int i = 1; i <= n; i++)
    {
        result *= i;
    }

    return result;
}

double taylor_sin(double x, int n)
{
    double result = 0.0;
    for(int i = 0; i < n; i++)
    {
        result += (pow(-1.0, i) * pow(x, 1.0 + 2.0 * i)) / factorial(1 + 2 * i);
    }

    return result;
}

double a_worse(double x)
{
    return 4.0 * pow(cos(x), 2) - 3.0;
}

double a_better(double x)
{
    double sin_t = taylor_sin(x, 10);
    return 4.0 * (0.5 - sin_t) * (0.5 + sin_t);
}

double dudek(double x)
{
    return cos(3 * x) / cos(x);
}

double wuka(double x)
{
    return cos(3 * x) ;
}

int main()
{

    for(int i = 0; i <= 20; i++)
    {
        std::cout << std::fixed << std::setprecision(40) << "worse i=" << i << ": "<< a_worse(13*M_PI/6 - pow(10, -i)) << std::endl;
        std::cout << std::fixed << std::setprecision(40) << "dudek i=" << i << ": "<< dudek(13*M_PI/6 - pow(10, -i)) << std::endl;
        std::cout << std::fixed << std::setprecision(40) << "bettr i=" << i << ": "<< a_better(13*M_PI/6 - pow(10, -i)) << "\n" <<std::endl;
    }
    
    return 0;
}
