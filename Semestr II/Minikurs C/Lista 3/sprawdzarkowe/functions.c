#include "functions.h"

void change(int** p_array, int i, int j, int n, int* array_lengths)
{
    int* tmp_ptr = p_array[i];
    p_array[i] = p_array[j];
    p_array[j] = tmp_ptr;

    int tmp = array_lengths[i];
    array_lengths[i] = array_lengths[j];
    array_lengths[j] = tmp;
}

void reverse(int** p_array, int i, int m)
{
    int tmp;
    for (int j = 0; j < m / 2; j++)
    {
        tmp = p_array[i][j];
        p_array[i][j] = p_array[i][m-j-1];
        p_array[i][m-j-1] = tmp;
    }
}

void swap(int** p_array, int i, int k, int l)
{
    int tmp;

    tmp = p_array[i][k];
    p_array[i][k] = p_array[i][l];
    p_array[i][l] = tmp;
}

void write(int** p_array, int n, int* array_lengths)
{
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < array_lengths[i]; j++)
        {
            printf("%d ", p_array[i][j]);
        }
        printf("\n");
    }
}