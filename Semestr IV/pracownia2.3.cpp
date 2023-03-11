#include <stdio.h>
#include <vector>
#include <algorithm>
// #include <chrono>
// using namespace std::chrono;

int max(int a, int b){ return a>b? a : b; }



int calculate_new_max_height(int new_block_height,
                             int new_difference,
                             int old_difference,
                             int old_max_height)
{
    if (old_max_height < old_difference)
        return 0;
    if (new_block_height + old_difference == new_difference)
    {
        return old_max_height + new_block_height;
    }
    if (new_block_height - old_difference == new_difference)
    {
        return old_max_height - old_difference + new_block_height;
    }
    return old_max_height;
}

int highest_tower(int new_difference,
                  int new_block_height,
                  std::vector<int> &previous_row,
                  int row_size)
{
    int old_difference1 = abs(new_block_height - new_difference);
    int old_difference2 = new_block_height + new_difference;

    int old_max_height1 = previous_row[old_difference1];
    int old_max_height2 = 0;

    if (old_difference2 < row_size)
    {
        old_max_height2 = previous_row[old_difference2];
    }

    if (old_max_height1 < old_difference1 && old_max_height2 < old_difference2)
        return 0;

    int new_max_height11 = old_max_height1 + new_block_height;
    int new_max_height12 = old_max_height1 - old_difference1 + new_block_height;
    int new_max_height21 = old_max_height2 + new_block_height;
    int new_max_height22 = old_max_height2 - old_difference2 + new_block_height;
    int new_max_height3 = previous_row[new_difference];

    
    return max(0, max(new_max_height11, max(new_max_height12, max(new_max_height21, new_max_height22))));
}

int main()
{
    // auto start = high_resolution_clock::now();

    int n = 0;
    int max_difference = 0;

    scanf("%d", &n);
    std::vector<int> blocks(n, 0);

    for (int i = 0; i < n; i++)
    {
        scanf("%d", &blocks[i]);
        max_difference += blocks[i];
    }

    std::sort(blocks.begin(), blocks.end());

    int min_difference = max_difference;
    std::vector<int> previous(max_difference + 1, 0);
    std::vector<int> current(max_difference + 1, 0);

    previous[blocks[0]] = blocks[0];
    int blocks_height_sum = blocks[0];

    for (int i = 1; i < n; i++)
    {
        blocks_height_sum += blocks[i];

        for (int difference = 0; difference <= blocks_height_sum; difference++)
        {
            current[difference] = highest_tower(difference, blocks[i], previous, max_difference);
        }

        current.swap(previous);
    }

    
    if (previous[0] > 0)
    {
        printf("TAK\n%d", previous[0]);
        // auto stop = high_resolution_clock::now();

        // auto duration = duration_cast<microseconds>(stop - start);

        // printf("\nExecution time = %f s\n", (double)duration.count() / 1000000);
        return 0;
    }

    for (int difference = 0; difference <= max_difference; difference++)
    {
        if (difference < min_difference && 
            previous[difference] > 0 && 
            previous[difference] != difference)
        {
            min_difference = difference;
        }
    }

    // auto stop = high_resolution_clock::now();

    // auto duration = duration_cast<microseconds>(stop - start);

    // printf("\nExecution time = %f s\n", (double)duration.count() / 1000000);
    printf("NIE\n%d", min_difference);

    return 0;
}