#include <stdio.h>

long puzzle(char* s, char* d)
{
    char* current_s = s;
   
    while(1)
    {   
        char* current_d = d;
        while(1)
        {
            if(*current_d == 0) return current_s - s;
            if(*current_d == *current_s) 
            {
                current_s++;
                break;
            } 
            current_d++;
        }
    }
}


int main()
{
    printf("%d", puzzle("aaabc", "d"));
    return 0;
}