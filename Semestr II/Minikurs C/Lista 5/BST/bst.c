#include "bst.h"

pnode makeNode(int nkey)
{
    pnode newNode = (pnode)malloc(sizeof(snode));
    newNode->value = nkey;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

pnode insert(pnode root, int nkey)
{
    if (root == NULL) return makeNode(nkey);
    else if (nkey <= root->value) root->left = insert(root->left, nkey);
    else if (nkey > root->value) root->right = insert(root->right, nkey);
    return root;
}

void removeKeyAux(pnode root)
{
    pnode curr = root->right;
    pnode prev = root;

    while (curr->left != NULL)
    {
        prev = curr;
        curr = curr->left;
    }

    root->value = curr->value;

    if (prev != root) prev->left = curr->right;
    else root->right = curr->right;

    free(curr);
}

pnode removeKey(pnode root, int dkey)
{
    pnode tmpRoot;
    if (root != NULL)
    if (dkey < root->value) root->left = removeKey(root->left, dkey);
    else if (dkey > root->value) root->right = removeKey(root->right, dkey);
    else //dkey == root->value
    {
        if (root->left == NULL) 
        {
            tmpRoot = root->right;
            free(root);
            root = tmpRoot;
        }
        else if (root->right == NULL)
        {
            tmpRoot = root->left;
            free(root);
            root = tmpRoot;
        } 
        else removeKeyAux(root);
    }
    return root;
}

pnode search(pnode root, int skey)
{
    if (root == NULL || root->value == skey) return root;
    else if (root->value > skey) return search(root->left, skey);
    else return search(root->right, skey);
}

void writeInorder(pnode root)
{
    if (root != NULL)
    {
        writeInorder(root->left);
        printf("%d, ", root->value);
        writeInorder(root->right);
    }
}

int max(int a, int b)
{
    if (a > b) return a;
    return b;
}

int height(pnode root)
{
    if (root == NULL) return 0;
    else return 1 + max(height(root->left), height(root->right));
}