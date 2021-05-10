#include "fifo.h"

int main()
{
    FIFO* queue = make_queue();
    char str1[9] = "Hieronim";
    char str2[9] = "Leokadia";
    int arr1[4] = {1, 2, 3, 4};
    int arr2[4] = {6,7, 8, 9};

    push_int(queue, 4);
    push_int(queue, 5);
    push_float(queue, 3.14);
    push_float(queue, 2.718);
    push_string(queue, str1);
    push_string(queue, str2);
    push_array(queue, arr1, 4);
    push_array(queue, arr2, 4);

    print_queue(queue);
    printf("\n1");
    printf("\n%d\n", pop_int(queue));
    printf("%d\n", pop_int(queue));
    printf("%lf\n", pop_float(queue));
    printf("%lf\n", pop_float(queue));
    printf("%s\n", pop_string(queue));
    printf("%s\n", pop_string(queue));
    int* tab1 = pop_array(queue);
    int* tab2 = pop_array(queue);

    for (int i = 0; i < 4; i++)
    {
        printf("%d, ", tab1[i]);
    }
    printf("\n");
    for (int i = 0; i < 4; i++)
    {
        printf("%d, ", tab2[i]);
    }

     printf("\n%d\n", pop_int(queue));
    return 0;
}
