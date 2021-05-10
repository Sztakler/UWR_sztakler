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

int is_full(stack* S);

int is_empty(stack* S);

void push(stack* Stack, char value);

void write_stack(stack* s);

int pop();

int is_digit(char character);

int is_operator(char character);

int main()
{
    scanf("%d%s", &n, expression);
    ptr = expression;

    stack* s = create_stack(n);

    for (int i = n-1; i >= 0; i--)
    {

        int x = expression[i];

        if (is_digit(x)) 
        {
            push(s, x-'0');
        }

        else if (is_operator(x)) 
        {
            int arg2 = pop(s);
            int arg1 = pop(s);

            switch (x)
            {
                case '+': push(s, arg1 + arg2);
                    break;
                case '-': push(s, arg2 - arg1);
                    break;
                case '*': push(s, arg1 * arg2);
                    break;
                default: break;
            } 
        }
    }
    int result = pop(s);
    printf("%d\n", result);

    return 0;
}


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

int is_digit(char character)
{
    if (character >= '0' && character <='9') return 1;
    return 0;
}

int is_operator(char character)
{
    if (character == '+' || character == '-' || character == '*') return 1;
    return 0;
}

void write_stack(stack* s)
{
    printf("Stan stosu: ");
    for (int i = 0; i < n; i++) printf("%d, ", s->data[i]);
    printf("\n");
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