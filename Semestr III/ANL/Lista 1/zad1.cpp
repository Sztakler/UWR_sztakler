#include <iostream>
#include <cmath>
#include <iomanip>

double f(double x)
{
    return 4040.0 * (sqrt(pow(x, 11) + 1) - 1) / pow(x, 11);
}

int main()
{   
    double x = 0.001;
    std::cout << std::setprecision(30);
    std::cout << "Result for x = " << x <<":\n" << f(x) << std::endl;
    return 0;
}