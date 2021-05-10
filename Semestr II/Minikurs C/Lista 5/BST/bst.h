#include <stdio.h>
#include <stdlib.h>

typedef struct node *pnode;
typedef struct node{
    int value;
    struct node* left;
    struct node* right;
}snode;

pnode insert(pnode root, int nkey);

pnode removeKey(pnode root, int dkey);

pnode search(pnode root, int skey);

int height(pnode root);

void writeInorder(pnode root);