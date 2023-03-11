#ifndef ROMAN_FUNCTIONS_H
#define ROMAN_FUNCTIONS_H

#include <string>
#include <iostream>
#include <vector>
#include <utility>


std::string bin2rom(int x);

const std::vector<std::pair<int,std::string>> rzym = 
{
    {1000,"M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
};


#endif