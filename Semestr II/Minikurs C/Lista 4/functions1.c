#include "functions1.h"

char * strcat (char * destination, const char * source)
{
    char* destination_start = destination;
    const char* source_copy= source;

    while (*destination) 
    {
        destination++;
    }

    while (*source_copy)
    {  
        *destination = *source_copy;
        destination++;
        source_copy++; 
    }

    return destination_start;
}

char * strncat ( char * destination, const char * source, size_t num )
{
    
    char* destination_start = destination;
    const char* source_copy= source;

    while (*destination) 
    {
        destination++;
    }

    while (*source_copy && (num > 0))
    {  
        *destination = *source_copy;
        destination++;
        source_copy++;
        num--; 
    }

    *destination = '\0';

    return destination_start;
}

int strcmp ( const char * str1, const char * str2 )
{
    while ((*str1 == *str2) && *str1 && *str2)
    {
        str1++;
        str2++;
    }

    return *str1-*str2;
}

int strncmp ( const char * str1, const char * str2, size_t num )
{
    while ((*str1 == *str2) && *str1 && *str2 && (num > 0))
    {
        str1++;
        str2++;
        num--;
    }

    return *str1-*str2;
}