#include <iostream>
#include <cstdlib>
#include <cmath>
#include <vector>

int64_t get_maximum(long numbers[], int argc)
{
    long max = 0;
    for (int i =1; i < argc; i++)
    {
        if (numbers[i] > max)
        {
            max = numbers[i];
        }
    }

    return max;
}
std::vector<int64_t> get_primes(int64_t maximum) 
{ 
    std::vector<int64_t> primes;
    // bool primes[(long)pow(maximum, 0.5)]; 
    int i = 0;
     for (int64_t p = 2; p * p <= maximum; p++)
     {
        primes.push_back(p);
     }

     for (int i = 0; i < primes.size(); i++)
        std::cout << primes[i] << " ";


     return primes;
} 

long get_prime_factors(long numbers[], int argc)
{
    for (int i =1; i < argc; i++)
    {
        while (numbers[i] > 1)
        {

        }
    }   

    return 0;
}

int main(int argc, char* numbers[])
{   
    

    return 0;
}