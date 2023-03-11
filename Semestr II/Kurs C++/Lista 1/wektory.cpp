#include <iostream>
#include <cstdlib>
#include <vector>
#include <cmath>

// to check -9223372036854775808 9223372036854775783
int64_t convert(std::string str)
{
    int64_t number = 0;
    int64_t i = 0;
    int64_t sign = 1;
    int64_t j = pow(10, str.length() -1 );
    if (str[0] == '-')
    {
        i++;
        sign = -1;
    }
    for (i; i < str.length(); i++)
    {
        if(((sign==1)&&(number*10-INT64_MAX>0)||((sign==-1)&&(number*10-INT64_MIN>0))))throw std::invalid_argument("Argumentnt out of range");
        number *= (int64_t)10;
        
        if ((0 <= (int64_t)str[i]-48) && ((int64_t)str[i]-48  <= 9))
        {
            if(((sign==1)&&(number+(int64_t)str[i]-48-INT64_MAX>0)||((sign==-1)&&(number+(int64_t)str[i]-48-INT64_MIN>0))))throw std::invalid_argument("Argument out of range");
            number += (int64_t)str[i]-48; 
        }
        else
        {
            throw std::invalid_argument("You must enter a number!");
        }
    }
    return number*sign;
}

std::vector<int64_t> find_prime_divisors(int64_t n)
{
    std::vector<int64_t> prime_divisors;

    if (n == 0 || n == 1 || n == -1)
    {
        prime_divisors.push_back(n);
        return prime_divisors;
    }

    if (n < 0)
    {
        prime_divisors.push_back(-1);
    }
    u_int64_t m = sqrt((u_int64_t)n);

   for (int64_t divisor = 2; divisor <= m; divisor++)
    {
        while (n % divisor == 0)
        {
            n /= divisor;
            prime_divisors.push_back(divisor);
        }
        if (n == 1 || n == -1)
        {
            break;
        }
    }
    if (n != 1 && n != -1)
    {
        prime_divisors.push_back(n);
    }
    return prime_divisors;
}

bool check_if_prime(int64_t number)
    {
        if (number < 2)
        {
            return false;
        }
        int64_t divisor = 2;
        while (divisor <= sqrt(number))
        {
            if (number % divisor == 0)
            {
                return false;
            }
            divisor++;
        }
        return true;
    }

int main(int size, char* numbers[])
{
    // Jeśli użytkownik nie poda argumentów
    
    if(size <= 1)
    {
        std::cerr << "Usage: " << numbers[0] << " number..." << std::endl;
        return 0;
    }

    std::string str_numbers[size-1];

    // Converting char array to string

    for (int64_t i = 1; i < size; i++)
    {
        str_numbers[i-1] = numbers[i];
    }

    /* Converting string number to int64_t, calculating prime divisors of this number and returning them to vector<int64_t>,
       then writing them to standard output*/

    int64_t n = 0;
    for (std::string &str_number : str_numbers)
    {   
        try
        {  
            n = convert(str_number);
            std::vector<int64_t> prime_divisors = find_prime_divisors(n);
            std::cout << n << " = ";
            bool first = true;
            for (int64_t divisor : prime_divisors)
            {
                if (first)
                {
                    std::cout << divisor;
                    first = false;
                }
                else
                {
                    std::cout << "*" << divisor;
                }
            }
            std::cout << std::endl;
        }
        catch(const std::invalid_argument& e)
        {
            std::cerr << e.what() << '\n';
        }
    }
    return 0;
}
