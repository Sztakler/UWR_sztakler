#include <iostream>
#include <vector>
#include <algorithm>

std::string dzielenie(int a, int b)
{
    std::string res = "";
    std::vector<int> occured;

    while (a > b)
    {
        res += std::to_string(a/b);
        a -= (a/b)*b;
    }

    if (res.size() == 0) res += "0";
    res += ",";

    while (a > 0)
    {
        a *= 10;
        while (a < b)
        {
            occured.push_back(a);
            res += "0";
            a *= 10;
            
        }
        for (int x : occured) 
        {
          if (x == a) //wystąpił cykl! 
          {
              
                std::string cycle = "";
                for (int i = occured.size() - 2; i >= 0; i--)
                {
                    int length = 0;
                    if (occured[i] == occured.back()) 
                    {                       
                        length = occured.size() - i - 1;
                        cycle = res.substr(res.size() - length - 1,  length);
                        if (cycle.back() == '0')
                        {
                            cycle = cycle.substr(0, cycle.size() - 1);
                            res = res.substr(0, res.size() - cycle.size() - 1) + "(" + cycle + ")";
                            return res;
                        }
                        res = res.substr(0, res.size() - cycle.size() - 1) + "(" + cycle + ")";
                        return res;
                    }
                }
                break;
          }                        
        }
        
        res += std::to_string(a/b);
        occured.push_back(a);
        a -= (a/b)*b;

    } 

    return res;
}


int main()
{
    //for (int i = 1; i < 100; i++) std::cout <<"moje = " << dzielenie(1, i) << "\nsystemowe = " << (double)1/(double)i << std::endl;
    std::cout << dzielenie(5, 7) << std::endl;
    return 0;
}