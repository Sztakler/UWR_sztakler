#include <iostream>
#include <cmath>
#include <iomanip>

double pi(int n)
{
    double x = 2.0;

    for(int k = 1; k < n; k++)
    {
        x = pow(2, k) * sqrt(2.0 * (1.0 - sqrt(1.0 - pow(x / pow(2, k), 2))));
    }

    return x;
}

double pi_better(int n)
{
    double x = 2.0;

    for(int k = 1; k < n; k++)
    {
        x = pow(2, k) * sqrt(2.0 * (pow(x, 2) / pow(2, 2 * k)) / (1.0 + sqrt(1.0 - pow(x / pow(2, k), 2))));
    }

    return x;
}

int main()
{
    double x = 10;
    for(int i = 0; i < 40; i++)
    {
        std::cout << "i = " << i << " worse:  " << std::setprecision(50) << std::fixed << pi(i) << std::endl;
        std::cout << "better:        " << std::setprecision(50) << std::fixed << pi_better(i) << std::endl;
    }
    return 0;
}