#include <iostream>
#include <iomanip>

double rec_y(int i)
{
    double prev = 1.0;
    double curr = -1.0/7.0;

    if(i == 0) return prev;
    else if(i == 1) return curr;
    else
    {
        for(int j = 2; j <= i; j++)
        {
            double temp = curr;
            curr = 1.0/7.0 * (69.0 * curr + 10.0 * prev);
            prev = temp + 1.f;
        }
        return curr;
    }
}



int main()
{
    for(int i = 0; i < 51; i++)
    {
        std::cout << std::fixed << std::setprecision(20)<< i << ": " << rec_y(i) << std::endl;
    }

    return 0;
}