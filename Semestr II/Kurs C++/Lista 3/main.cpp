#include <string>
#include <iostream>
#include <vector>

const std::vector<std::pair<int,std::string>> ROMAN = 
{
    {1000,"M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
};

std::string bin2rom(int x)
{   
    if (x >= 4000 || x <= 0) throw std::out_of_range("Numbers must be within 1-3999 range!");

    int count_of_same_letters = 0;
    std::string result = "";

    while (x > 0)
    {
        for (int i = 0; i < 13; i++)
        {
            while (ROMAN[i].first <= x)
            {
                x -= ROMAN[i].first;
                result = result + ROMAN[i].second;
            }
            count_of_same_letters = 0;
        }
    }
    return result;
}

void convert_arguments(int size, char *arguments[])
{
    for (int i = 1; i < size; i++)
    {
        int decimal;

        try
        {
            decimal = std::stoi(arguments[i]);
            std::cout << bin2rom(decimal) << "\n";
        }

        catch(const std::invalid_argument& e)
        {
            std::clog << "'" << arguments[i] << "'" << " is not a number!" << '\n';
            continue;
        }

        catch(const std::out_of_range& e)
        {
            std::clog << "Entered " << "'" << arguments[i] << "'" << "! " << e.what() << '\n';
        }
        
    }
}

int main(int argc, char *argv[])
{   
    convert_arguments(argc, argv);

    return 0;
}
