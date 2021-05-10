#ifndef MANIPULATORS_HPP
#define MANIPULATORS_HPP

#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <cstring>
#include <ctime>

using namespace std;

inline istream& clearline(istream& stream);

inline ostream& comma(ostream& os);

ostream& colon(ostream& os);

class ignore
{
    int x;
    friend istream& operator >> (istream& stream, const ignore &ign);

    public:
        ignore(int x) : x(x){}
};

class Index
{
    int x;
    int w;
    friend ostream& operator << (ostream& stream, const Index &idx);
    
    public:
        Index(int x, int w) : x(x), w(w){}
};


class InputFile
{
    public:
    ifstream data;

    public:
    InputFile(string file_name) : data(file_name, ios::binary)
    {
        if(!this->data) 
            {
                this->data.close();
                throw "Unable to open file";
            }
    }   

    ~InputFile()
    {
        this->data.close();
    }

    bool eof()
    {
        return this->data.eof();
    }

    template<typename T>
    void operator << (const T& value)
    {
        this->data << value;
    }

    template<typename T>
    InputFile& operator >> (T& input)
    {
        input = read<T>();
        return *this;
    }

    template <typename T>
    T read() 
    {
        size_t size = sizeof(T);
        uint64_t long_result(0);
        char buffer;
        for (size_t index = 1; index <= size; index++) 
        {
            if(!this->data.good()) throw ios_base::failure("ios_base::badbit or ios_base::failbit flag occured");
            this->data.get(buffer);
            uint8_t u_buffer = buffer;
            uint64_t temp = u_buffer;
            temp <<= (size - index) * 8;
            long_result |= temp;   
        }
        T t;
        std::memcpy(&t, &long_result, size);
        return t;
    }

    void get(char& c)
    {
        this->data.get(c);
    }
};


class OutputFile
{   
    private:
    ofstream data;


    public:
    OutputFile(string file_name) : data(file_name, ios::binary)
    {
        if(!this->data) 
        {
            this->data.close();
            throw "Unable to open file";
        }
    }

    ~OutputFile()
    {
        this->data.close();
    }

    bool eof()
    {
        return (this->data.eof());
    }

    template<typename T>
    OutputFile& operator << (T& input)
    {
        write<T>(input);
        return *this;
    }

 template <typename T>
    void write(T t) 
    {      
        size_t size = sizeof(T);
        for (size_t i = 1; i <= size; i++) 
        {
            if(!this->data.good()) throw ios_base::failure("ios_base::badbit or ios_base::failbit flag occured");
            uint64_t temp;
            std::memcpy(&temp, &t, size);
            temp >>= (size - i) * 8;
            uint8_t c = temp;
            char char_c = c;
            this->data.write(&char_c, sizeof(char));
        }
    }

    void flush()
    {
        this->data.flush();
    }
};

void ignore_newline();
void ignore_x();
void print_number();
void test_zad1();
void test_zad2();

#endif