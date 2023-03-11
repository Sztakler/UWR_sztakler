#include <stdio.h>
#include <vector>
#include <utility>
#include <stdint.h>
#include <algorithm>

void print_string_pairs(std::vector<std::pair<uint32_t, uint32_t>> &string_pairs)
{
    for (std::pair<uint32_t, uint32_t> string_pair : string_pairs)
    {
        printf("%I32u %I32u\n", string_pair.first, string_pair.second);
    }
}

bool sort_by_first(std::pair<uint32_t, uint32_t> &pair1,
                   std::pair<uint32_t, uint32_t> &pair2)
{
    return pair1.first < pair2.first;
}

int main()
{
    unsigned int m, nd, d;

    scanf("%u", &m);

    std::vector<std::pair<uint32_t, uint32_t>> strings; // = new std::vector<std::pair<uint32_t, uint32_t>>;
    std::pair<uint32_t, uint32_t> string_pair;          // (length, count)

    for (unsigned int i = 0; i < m; i++)
    {
        scanf("%I32u %I32u", &string_pair.first, &string_pair.second);

        printf("Iteration %u\n    Pair = %I32u %I32u\n", i, string_pair.first, string_pair.second);
        while (!(string_pair.first & 1))
        {
            string_pair.first = string_pair.first >> 1;
            string_pair.second = string_pair.second << 1;
            printf("    Pair = %I32u %I32u\n", string_pair.first, string_pair.second);
        }

        strings.push_back(string_pair);
    }

    printf("\nPAIRS\n");
    print_string_pairs(strings);

    std::sort(strings.begin(), strings.end(), sort_by_first);

    printf("\nSORTED PAIRS\n");

    print_string_pairs(strings);

    unsigned int index = 0;
    unsigned int i = 0;
    std::pair<uint32_t, uint32_t> current_pair;
    unsigned int sum = 0;
    while (i < m)
    {
        printf("i=%d\n", i);
        current_pair = strings.at(i);
        while(strings.at(i).first == current_pair.first)
        {
            printf("Inside while i=%u, %d, %d\n", i, strings.at(i).first, current_pair.first);
            printf("               %u, %d, %d\n", i, strings.at(i).second, current_pair.second);
            sum += strings.at(i).second;
            i++;

            if(i >= m) break;
        }

        current_pair.second = sum;
        strings.at(index) = current_pair;
        sum = 0;
        index++;
        printf("strings[%u]=(%u, %u)\n", index - 1, current_pair.first, current_pair.second);
    }

    printf("\nSHORTENED PAIRS\n");

    for (int i = 0; i < index; i++)
    {
        std::pair<uint32_t, uint32_t> string_pair = strings.at(i);
        printf("%I32u %I32u\n", string_pair.first, string_pair.second);
    }

    int number_of_unique_string_lengths = 0;
    for (int i = 0; i < index; i++)
    {
        while (strings.at(i).second)
        {
            printf("(%u, %u)\n", strings.at(i).first, strings.at(i).second);
            if (strings.at(i).second & 1)
                number_of_unique_string_lengths++;
            strings.at(i).second = strings.at(i).second >> 1;
        }
        printf("count = %d\n", number_of_unique_string_lengths);
    }

    printf("%d", number_of_unique_string_lengths);

    return 0;
}

// TESTS
// 3 1 4 2 4 3 4
// 6 7 3 8 4 1 2 2 3 6 3 3 3
// 3 3 3 7 1 6 5
// 1 1 15