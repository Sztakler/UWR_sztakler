#include "functions.h"

int main()
{
    int n;
    int m;

    scanf("%d",&n);
    int** p_array = (int**)malloc(sizeof(int*)*n);
    int* array_lengths = (int*)malloc(sizeof(int)*n);

    for (int i = 0; i < n; i++)
    {   
        scanf("%d", &m);
        p_array[i] = (int*)malloc(sizeof(int)*m);
        array_lengths[i] = m;
        for (int j = 0; j < m; j++)
        { 
            scanf("%d", &p_array[i][j]);
        }

    }

   char option;
   while (option != 'k')
   {   
        scanf("%c", &option);

        switch (option)
        {
            int i, j, k, l;
            case 'z': 
            {
                scanf("%d %d", &i, &j);
                change(p_array, i, j, n, array_lengths);
                break;
            }
            
            case 'o': 
            {
                scanf("%d", &i);
                reverse(p_array, i, array_lengths[i]);
                break;
            }

            case 'p': 
            {
                scanf("%d %d %d", &i, &k, &l);
                swap(p_array, i, k, l);
                break;
            }

            case 'k': write(p_array, n, array_lengths);
            break;

            default:
            break;
        }
    }

    free(p_array);
    free(array_lengths);

    return 0;
}
