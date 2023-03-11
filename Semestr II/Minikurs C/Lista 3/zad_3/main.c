#include "functions.h"


int main()
{
    scanf("%d%s", &n, expression);
    ptr = expression;

    stack* s = create_stack(n);

    for (int i = n-1; i >= 0; i--)
    {
        write_stack(s);
        int x = expression[i];

        if (is_digit(x)) 
        {
            push(s, x-'0');
            printf("Liczba %d=%d\n", i, x-'0');
            printf("Na stos wrzucono %d\n", s->data[s->index-1]);
        }

        else if (is_operator(x)) 
        {
            int arg2 = pop(s);
            int arg1 = pop(s);

            printf("Operacja dla i=%d:%d%c%d\n", i, arg1, x, arg2);
            switch (x)
            {
                case '+': 
                push(s, arg1 + arg2);
                printf("Na stos wrzucono: %d\n", arg1 + arg2);
                write_stack(s);
                break;
                case '-': 
                push(s, arg1 - arg2);
                printf("Na stos wrzucono: %d\n", arg1 + arg2);
                write_stack(s);
                break;
                case '*': 
                push(s, arg1 * arg2);
                printf("Na stos wrzucono: %d\n", arg1 + arg2);
                write_stack(s);
                break;
                default: break;
            } 
        }
    }
    int result = pop(s);
    printf("Wynik=%d\n", result);
    write_stack(s);
    write_stack(s);
    free_stack(s);
    push(s, 2);
    push(s, 3);
    write_stack(s);
    return 0;
}