#include "fifo.h"

FIFO* make_queue()
{
    FIFO* queue = (FIFO*)malloc(sizeof(FIFO));
    
    queue->fifo_start = NULL;
    queue->fifo_end = NULL;

    return queue;
}

static void push(FIFO* queue, enum dataType data_type, size_t allocated_size, void* data)
{
    struct node* new_node = (struct node*)malloc(sizeof(struct node));

    new_node->data_type = data_type;
    new_node->allocated_size = allocated_size;
    new_node->data = data;
    new_node->next_node = NULL;
    
    if (queue->fifo_start == NULL) 
    {
        queue->fifo_end = new_node;
        queue->fifo_start = new_node;
    }
    
    else
    {
        queue->fifo_end->next_node = new_node;
        queue->fifo_end = new_node;
    }
}

void push_string(FIFO* queue, char* str)
{
    char* string_copy = strdup(str);
    size_t allocated_size = strlen(string_copy);
    push(queue, STRING, allocated_size, string_copy);
}

void push_int(FIFO* queue, int val)
{
    size_t allocated_size = sizeof(int);
    int* ptr_val = (int*)malloc(allocated_size);
    *ptr_val = val;
    push(queue, INT, allocated_size, ptr_val);
}

void push_float(FIFO* queue, float val)
{
    size_t allocated_size = sizeof(float);
    float* ptr_val = (float*)malloc(allocated_size);
    *ptr_val = val;
    push(queue, FLOAT, allocated_size, ptr_val);
}

void push_array(FIFO* queue, int* array, int size)
{
    size_t allocated_size = sizeof(int)*size;
    int* array_copy = (int*)malloc(allocated_size);

    for (int i = 0; i < size; i++)
    {
        array_copy[i] = array[i];
    }

    push(queue, INT_ARRAY, allocated_size, array_copy);
}

void print_queue(FIFO* queue)
{
    struct node* current = queue->fifo_start;

    while (current != NULL)
    {
        printf("%d, ", current->data_type);
        current = current->next_node;
    }
}

int pop_int(FIFO* queue)
{
    if (queue->fifo_start == NULL) return -1;
    int result = *((int*)queue->fifo_start->data);
    free(queue->fifo_start->data);
    queue->fifo_start = queue->fifo_start->next_node;
    return result;
}

char* pop_string(FIFO* queue)
{
    if (queue->fifo_start == NULL) return NULL;
    char* result = queue->fifo_start->data;
    queue->fifo_start = queue->fifo_start->next_node;
    return result;
}

float pop_float(FIFO* queue)
{
    if (queue->fifo_start == NULL) return -1;
    float result = *((float*)queue->fifo_start->data);
    free(queue->fifo_start->data);
    queue->fifo_start = queue->fifo_start->next_node;
    return result;
}

int* pop_array(FIFO* queue)
{
    if (queue->fifo_start == NULL) return NULL;
    int* result = queue->fifo_start->data;
    queue->fifo_start = queue->fifo_start->next_node;
    return result;
}