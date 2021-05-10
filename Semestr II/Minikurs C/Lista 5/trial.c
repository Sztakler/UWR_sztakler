#include <stdlib.h>
#include <stdio.h>

struct node
{
    int data_type;
    size_t allocated_size;
    void* data;
    struct node* next_node;
};

void print(void* data)
{
    printf("%d", *(int*)data);
}

int main()
{
    int a = 1;
    void *ptr = &a; 
    ptr = ptr; 
    printf("%d\n", *(int*)ptr); 
    return 0; 
}