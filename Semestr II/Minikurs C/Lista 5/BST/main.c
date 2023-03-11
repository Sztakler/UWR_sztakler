#include "bst.h"
#include <time.h>

int main()
{

    srand(time(0));

    pnode tree;

    // Sekwencja wstawianie jednego, usuwanie go i wstawianie innego
    printf("Sekwencja wstawianie jednego, usuwanie go i wstawianie innego\n");
    tree = insert(tree, 42);
    printf("Drzewo: ");
    writeInorder(tree);
    printf("\nDrzewo: ");
    tree = removeKey(tree, 42);
    writeInorder(tree);
    printf("\nDrzewo: ");
    tree = insert(tree, 43);
    writeInorder(tree);
    printf("\nDrzewo: ");
    tree = removeKey(tree, 43);

    // Dodawanie elementów
    for (int i = 0; i < 10; i++)
    {
        tree = insert(tree, i);
    }

    writeInorder(tree);
    printf("\n");

    // Wyszukiwanie wartości
    printf("Wyszukiwanie: %d\n", search(tree, 4)->value);

    // Opróżnianie drzewa
    for (int i = 0; i < 11; i++)
    {
        tree = removeKey(tree, i);
        writeInorder(tree); 
        printf("\n"); 
    }

    // Szukanie elementu w pustym

    printf("Wyszukiwanie w pustym: %d\n", search(tree, 4));

    for (int i = 0; i < 10; i++)
    {
        tree = insert(tree, i);
    }

    writeInorder(tree);
    printf("\n");
    return 0;
}