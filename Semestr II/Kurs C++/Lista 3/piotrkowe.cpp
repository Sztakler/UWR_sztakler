#include <iostream>
#include <string>
#include <vector>

using std::string;
using std::vector;
using std::pair;
using std::invalid_argument;
using std::out_of_range;

const vector<pair<int, string>> ROMAN_NUMBERS = {
	{1000, "M"},
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

auto binary_to_roman(const int number) -> string {
	int residue = number;
	string result;
	for (const pair<int, string>& pair : ROMAN_NUMBERS) {
		int arabic_number = pair.first;
		string roman_number = pair.second;
		while (residue / arabic_number > 0) {
			residue -= arabic_number;
			result += roman_number;
		}
	}
	return result;
}

void convert_arguments(const int size, const char** arguments) {
	for (int index = 1; index < size; index++) {
		string argument = arguments[index];
		try {
			int number = std::stoi(argument);
			if (number >= 1 && number <= 3999) {
				string roman_number = binary_to_roman(number);
				std::cout << roman_number << std::endl;
			}
		} catch (invalid_argument& ignored) {
			std::clog << "Cannot convert argument to a number." << std::endl;
		} catch (out_of_range& ignored) {
			std::clog << "Argument out of range." << std::endl;
		}
	}
}

auto main(int argc, const char** argv) -> int {
	convert_arguments(argc, argv);
	return 0;
}