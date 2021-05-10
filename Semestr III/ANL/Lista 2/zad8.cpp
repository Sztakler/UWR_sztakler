#include <iostream>
#include <cmath>
#include <iomanip>

double f(double x)
{
    return 4040.0 * (sqrt(pow(x, 11) + 1) - 1) / pow(x, 11);
}

double f_better(double x)
{
    return 4040.0 / (sqrt(pow(x, 11) + 1.0) + 1.0);
}

int main()
{
    double x = 10;;
    for(int i = 0; i < 20; i++)
    {
        std::cout << "i = " << i << " worse:  " << std::setprecision(50) << std::fixed << f(pow(x, -i)) << std::endl;
        std::cout << "better:        " << std::setprecision(50) << std::fixed << f_better(pow(x, -i)) << std::endl;
    }
    return 0;
}