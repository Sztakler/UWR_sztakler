#include <iostream>
#include <vector>
#include <cmath>

int64_t convert(std::string str)
{
    int64_t number = 0;
    int j = 10;
    int i = 0;
    int sign = 1;
    if (str[0] == '-')
    {
        i++;
        sign = -1;
    }
    for (i; i< str.length(); i++)
    {
        number *= j;
        if ((0 <= (int)str[i]-48) && ((int)str[i]-48  <= 9))
        {
           number += (int)str[i]-48; 
        }
        else
        {
            throw std::invalid_argument("You must enter a number!");
        }
    }

    return number * sign;
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

    int64_t divisor = 2;
    double m = sqrt(abs((double)n))+1;
    while (divisor <= m+1)
    {
        
        while (n % divisor == 0)
        {
            n /= divisor;
            prime_divisors.push_back(divisor);
        }
        divisor++;
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

int main()
    { 
        //   int64_t n = -92233720368547750;
    //     std::vector<int64_t> prime_divisors = find_prime_divisors(n);
        
    //     std::cout << n << " : ";
    //     for (int64_t divisor : prime_divisors)
    //     {
    //         std::cout << divisor << "*";
    //     }
  
    std::cout << check_if_prime(-4);
    std::cout << check_if_prime(2);
    std::cout << check_if_prime(17); 
    std::cout << check_if_prime(1);
    std::cout << check_if_prime(4);


        return 0;
    }