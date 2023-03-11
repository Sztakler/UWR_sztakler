/*
Krystian Jasionek
317806
KLO
*/

#include <stdio.h>
#include <vector>
#include <utility>
#include <algorithm>


bool sort_by_first(std::pair<unsigned int, long long unsigned int> &pair1,
                   std::pair<unsigned int, long long unsigned int> &pair2)
{
    return pair1.first < pair2.first;
}

int main()
{

    unsigned int m;

    scanf("%u", &m);

    std::vector<std::pair<unsigned int, long long unsigned int>> strings;
    std::pair<unsigned int, long long unsigned int> string_pair;          // (length, count)

    for (unsigned int i = 0; i < m; i++)
    {
        scanf("%u %llu", &string_pair.first, &string_pair.second);
        
        while (!(string_pair.first & 1))
        {
            string_pair.first = string_pair.first >> 1;
            string_pair.second = string_pair.second << 1;
        }

        strings.push_back(string_pair);
    }

    std::sort(strings.begin(), strings.end(), sort_by_first);

    unsigned int index = 0;
    unsigned int i = 0;
    long long unsigned int sum = 0;
    std::pair<unsigned int, long long unsigned int> current_pair;

    while (i < m)
    {
        current_pair = strings.at(i);
        while(strings.at(i).first == current_pair.first)
        {
            sum += strings.at(i).second;
            i++;
            if(i >= m) break;
        }

        current_pair.second = sum;
        strings.at(index) = current_pair;
        sum = 0;
        index++;
    }

    unsigned int number_of_unique_string_lengths = 0;
    for (unsigned int j = 0; j < index; j++)
    {
        while (strings.at(j).second)
        {
            if (strings.at(j).second & 1)
                number_of_unique_string_lengths++;
            strings.at(j).second = strings.at(j).second >> 1;
        }
    }

    printf("%u", number_of_unique_string_lengths);

    return 0;
}