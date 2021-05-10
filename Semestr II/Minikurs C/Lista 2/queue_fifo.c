#include<stdio.h>
#include <stdlib.h>
#include <unistd.h>

typedef enum
{
    integer,
    floatingPoint,
    string,
    intPair
}Type;

typedef struct Variable
{
    Type type; // typ zmiennej (liczby 1-4)
}variable;


/*
size - rozmiar kolejki 
head - pozycja najnowszego elementu
tail - pozycja najstarszego elementu
queue[] - tablica zawierająca kolejkę
choice - wybór opcji w switch'u
position - pozycja 
empty/full - wartości boolowskie określające czy kolejka jest pełna lub pusta
new - wartość elementu dodawanego do kolejki
*/

int size = 5;
int tail = 0, head = 0, queue[5], full = 0, empty = 1, choice, new;
// struct Variable queue[5];

void enqueue();
void dequeue();



int main()
{

    while (1)
    {
        system("clear");
        printf("What do you want to do?\n1: Enqueue a value\n2: Dequeue a value\n3: Read the queue\n");
        scanf("%d", &choice);
        system("clear");
        switch (choice)
        {
        // Wstawianie nowego elementu do kolejki
        case 1:            
            enqueue();
            system("clear");
            break;
        // Wyrzucanie najstarszego elementu kolejki
        case 2:
            dequeue();
            system("clear");
            break;
        // Wypisanie zawartości kolejki na standardowe wyjście
        case 3:
            printf("Reading... \nValues: [");
            printf("%d", queue[0]);
            for (int i = 1; i < size; i++) printf(", %d", queue[i]);
            printf("]\nFULL = %d\n", full);
            getchar();
            getchar();
            system("clear");
            break;
        default:
            break;
        }

    }

    return 0;
}

void enqueue()
{
    printf("Enter a number to enqueue: ");
    scanf("%d", &new);
    
    if (full)
    {
        printf("Queue is FULL! You cannot enqueue a new value!\n");
        getchar();
        getchar();
    }

    else
    {
        queue[head] = new;
        printf("%d enqueued successfully on a position [%d]\n", new, head);
        head = (head + 1) % size ;
        empty = 0;
        if (head == tail) full = 1;
        getchar();
        getchar();
        return;  
    }
    
}

void dequeue()
{
    if(empty)
    {
        printf("Queue is EMPTY! You cannot dequeue a value!\n");
        getchar();
        getchar();
        return;
    }
    queue[tail] = 0;
    tail = (tail + 1) % size;
    full = 0;
    if (tail == head) empty = 1;
    printf("Dequeued value %d from position [%d]\n", queue[tail], tail);
    getchar();
    getchar();
    return;
}

