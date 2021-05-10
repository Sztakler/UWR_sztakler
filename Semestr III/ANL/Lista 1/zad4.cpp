#include <iostream>
#include <cmath>

// double integral(int n)
// {
//     if(n == 0)
//     {
//         return log(2021.d / 2020.d);
//     }
//     else
//     {
//         return (1.d / n) - 2020.d * integral(n - 1); 
//     }
// }

double integral_iter(int n)
{
    double result = (double)log(2021.0 / 2020.0);
    
    for(int i = 1; i <= n; i++)
    {
        result = 1.0/i - 2020.0 * result;
    }

    return result;
}

int main()
{
    for(int n = 1; n < 21; n++)
    {
        std::cout << std::fixed << integral_iter(n) << std::endl;
    }

    return 0;
}