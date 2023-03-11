#include "functions.h"

stack* create_stack(int n)
{
    stack* s = malloc(sizeof(stack));
    s->size = n;
    s->data = malloc(sizeof(int)*s->size);
    s->index = 0;

    return s;
}

void push(stack* s, char value)
{
    if (!is_full(s))
    {
        s->data[s->index] = value;
        s->index++;
    }
}

int pop(stack* s)
{
    if(!is_empty(s))
    {
        int value = s->data[s->index-1];
        s->data[s->index-1] = 0;
        s->index--;
        return value;
    }
}

int is_empty(stack* s)
{
    if(s->index == 0) return 1;
    return 0;
}

int is_full(stack* s)
{
    if (s->index < n) return 0;
    return 1;
}

int is_digit(char character)
{
    if (character >= '0' && character <='9') return 1;
    return 0;
}

int get_digit(char character)
{
    if (is_digit(character)) return character - '0';
}

int is_operator(char character)
{
    if (character == '+' || character == '-' || character == '*') return 1;
    return 0;
}

char get_operator(char character)
{
    if (is_operator(character)) return character;
}




int evaluate(char operator, int value1, int value2)
{
    switch(operator)
    {
        case '+': return value1 + value2;
            break;
        case '-': return value1 - value2;
            break;
        case '*': return value1 * value2;
            break;
    }
}


void write_stack(stack* s)
{
    printf("Stan stosu: ");
    for (int i = 0; i < n; i++) printf("%d, ", s->data[i]);
    printf("\n");
}

void free_stack(stack* s)
{
    free(s);
}
