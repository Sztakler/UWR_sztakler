#include <iostream>
#include <math.h>
#include <iomanip>

double log(double base, double x)
{
    return log(x) / log(base);
}

double factorial(int n)
{
    double result = 1;

    for(int i = 1; i <= n; i++)
    {
        result *= i;
    }

    return result;
    
}

double b_taylor(int n, double x)
{
    double result = 0;
    int j = 0;
    for(int i = 4; i < n + 4; i+=2)
    {
        result += pow(-1, j) * pow(x, i - 4) / factorial(i);
        j++;
    }

    return result;
}

double c_taylor(int n, double x)
{
    double result = 0;

    for(int i = 1; i < n; i++)
    {
        result += pow(-1, i + 1) * pow(x - 1, i) / i;
    }

    return log(5^6) + result;
}

double a(double x)
{
    return pow(x, 3) - sqrt(pow(x, 6) + 2020.0);
}

double a_better(double x)
{
    return -2020.0 / (pow(x, 3) + sqrt(pow(x, 6) + 2020));
}

double b(double x)
{
    return pow(x, -4) * (cos(x) - 1 + pow(x, 2) / 2);
}
double b_better(double x)
{
    return b_taylor(10, x);
}

double c(double x)
{
    return log(5, x) - 6;
}

double c_better(double x)
{
    // return log(5, x / pow(5, 6));
    return log(x) / log(5);
}

int main()
{   
    double x = 10;;
    for(int i = 0; i < 20; i++)
    {
        // Przykład a
        // std::cout << "i = " << i << " worse:  " << std::setprecision(50) << std::fixed << a(pow(x, i)) << std::endl;
        // std::cout << "better:       " << std::setprecision(50) << std::fixed << a_better(pow(x, i)) << std::endl;

        // Przykład b
        // std::cout << "i = " << i << " worse:  " << std::setprecision(50) << std::fixed << b(pow(x, -i)) << std::endl;
        // std::cout << "better:       " << std::setprecision(50) << std::fixed << b_better(pow(x, -i)) << std::endl;

        // Przykład c
        std::cout << "i = " << i << " worse:  " << std::setprecision(50) << std::fixed << c(pow(5.0 + pow(10, -(i+10)), 6)) << std::endl;
        std::cout << "better:        " << std::setprecision(50) << std::fixed << c_better(pow(5.0 + pow(10, -(i+10)), 6)) << std::endl;
        std::cout << "log:        " << std::setprecision(50) << std::fixed << log(5, pow(5.0 + pow(10, -(i+10)), 6)) << std::endl;
    }
    return 0;
}