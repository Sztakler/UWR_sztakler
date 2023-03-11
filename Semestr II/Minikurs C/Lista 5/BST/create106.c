#include "bst.h"
#include <time.h>

int main()
{

    srand(time(0));

    pnode tree;


    for (int i = 0; i < 106; i++)
    {
        int n = rand() % 100;
        tree = insert(tree, n);  
    }
    writeInorder(tree);
    printf("\n");
    printf("\nTree height: %d\n", height(tree));
    return 0;
}