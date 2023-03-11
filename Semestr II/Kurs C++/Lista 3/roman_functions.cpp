#include "roman_functions.h"

std::string bin2rom(int x)
{   
    if (x >= 4000 || x <= 0) throw std::invalid_argument("Numbers must be within 1-3999 range!");

    int count_of_same_letters = 0;
    std::string result = "";
    while (x > 0)
    {
        for (int i = 0; i < 13; i++)
        {
            while (rzym[i].first <= x && count_of_same_letters < 4)
            {
                x -= rzym[i].first;
                result = result + rzym[i].second;
                // std::cout << i << ", " << count_of_same_letters << ", " << result << ", " << x << "\n";
            }
            count_of_same_letters = 0;
        }
    }
    return result;
}