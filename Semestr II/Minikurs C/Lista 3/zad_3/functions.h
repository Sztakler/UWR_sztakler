#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <stdio.h>
#include <stdlib.h>

char expression[10000];
char *ptr;
int n;

typedef struct Stack
{
    int size;
    int top;
    int* data;
    int index;
}stack;

stack* create_stack(int n);

void push(stack* Stack, char value);

void write_stack(stack* s);

int pop();

int is_full(stack* S);

int is_empty(stack* S);

int is_digit(char character);

int get_digit(char character);

int is_operator(char character);

char get_operator(char character);

int evaluate(char operator, int value1, int value2);

void free_stack(stack* s);


#endif
