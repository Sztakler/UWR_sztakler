#include <stdlib.h>
#include <stdio.h>
#include <string.h>

enum dataType {STRING, INT, FLOAT, INT_ARRAY };

struct node
{
    int data_type;
    size_t allocated_size;
    void* data;
    struct node* next_node;
};

typedef struct fifo{
	struct node* fifo_start;
	struct node* fifo_end;
} FIFO;


FIFO* make_queue();

static void push(FIFO* queue, enum dataType data_type, size_t allocated_size, void* data);
struct node* pop(FIFO* queue);

void push_string(FIFO* queue, char* str);

void push_int(FIFO* queue, int val);

void push_float(FIFO* queue, float val);

void push_array(FIFO* queue, int* array, int size);

void print_queue(FIFO* queue);

int pop_int(FIFO* queue);

char* pop_string(FIFO* queue);

float pop_float(FIFO* queue);

int* pop_array(FIFO* queue);
