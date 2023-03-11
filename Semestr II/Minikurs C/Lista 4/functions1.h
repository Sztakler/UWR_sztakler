#ifndef FUNCTIONS1_H
#define FUNCTIONS1_H

#include <stdio.h>

char * strcat ( char * destination, const char * source );

char * strncat ( char * destination, const char * source, size_t num );

int strcmp ( const char * str1, const char * str2 );

int strncmp ( const char * str1, const char * str2, size_t num);

#endif