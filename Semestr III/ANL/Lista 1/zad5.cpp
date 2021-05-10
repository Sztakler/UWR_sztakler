#include <iostream>
#include <cmath>
#include <iomanip>

double alternating_series(int n)
{
    double pi = 0;

    for(int k = 0; k < n; k++)
    {
        pi += pow(-1.0, (double)k) / (2.0 * (double)k + 1.0); 
    }

    return 4.0 * pi;
}

double d_abs(double a)
{
    if(a < 0) return -a;
    return a;
}

bool is_error_small_enough(double evaluated_value, double error)
{
    return std::abs(M_PI - evaluated_value) < error;
}

int main()
{
    int k = 0;
    double evaluated_value = alternating_series(k);
    
    while(!is_error_small_enough(evaluated_value, pow(10.0, -4.0)))
    {
        k++;
        evaluated_value = alternating_series(k);
    }
    
    std::cout << "Error is < 10^(-4) for k = " << k << std::endl;
    std::cout << std::setprecision(10) << evaluated_value << " = value of π for k = " << k << std::endl;
    std::cout << M_PI << " = lib value of π" << std::endl;
    std::cout << "Value of error = " << std::fixed << std::abs((double)M_PI - (double)evaluated_value) << std::endl;
    std::cout << "Value of error = " << std::fixed << std::abs((double)M_PI - (double)alternating_series(10000)) << std::endl;
    return 0;
}