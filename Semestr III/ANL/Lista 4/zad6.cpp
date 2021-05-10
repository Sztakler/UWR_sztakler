#include <iostream>
#include <math.h>
#include <iomanip>

void invSquare(double x0, double a)
{
    double result = x0;
    double square = 1.0 / sqrt(a);
    double err = 0.0;

    for(int n = 0; n < 20; n++)
    {
        result = 0.5 * result * (3.0 - a * pow(result, 2));
        err = abs(result - square);

        std::cout << std::fixed << std::setprecision(30) << n << " result=" << result << " square=" << square << " error=" << err << std::endl;
    }
}
    

int main()
{
    // double square;
    // for(int i = 5; i < 100; i++)
    // {
    //     square = 1.0 / sqrt(i);
    //     invSquare(0.5 * square, i);
    // }

    invSquare(1.2, 3);
    invSquare(0.9, 4);

    // invSquare(0.9, 3);

    // invSquare(0.9, 4);
    // invSquare(0.7, 4);
        
    return 0;
}