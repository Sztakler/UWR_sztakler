#include "manipulators.hpp"

inline istream& clearline(istream& stream)
{
    char current = '\0';
    while (current != '\n' && current != EOF)
    {
        stream.get(current);
    }
    return stream;
}

inline ostream& comma(ostream& os)
{
    return os << ", ";
}

ostream& colon(ostream&os)
{
    return os << ": ";
}

istream& operator >> (istream & stream, const ignore &ign)
    {
        int cnt = 0;
        char current = '\0';
        while (current != '\n' && current != EOF && cnt < ign.x)
        {
            stream.get(current);
            cnt++;
        }
        return stream;
    }

ostream& operator << (ostream& stream, const Index &idx)
{
    int x = idx.x;
    int w = idx.w;
    string str_number = "[";
    w -= to_string(x).size();

    while(w > 0)
    {
        str_number += " ";
        w--;
    }
    str_number += to_string(x);
    str_number += "]";

    return stream << str_number;
}


void ignore_newline()
{
    ifstream text_stream;
    string s;
    text_stream.open("test.txt");
    text_stream >> clearline;
    while (getline(text_stream, s))
    {
        cout << s << endl;
    }

    text_stream.close();
}

void ignore_x()
{
    ifstream text_stream;
    string s;
    text_stream.open("test.txt");
    text_stream >> ignore(2);
    while (getline(text_stream, s))
    {
        cout << s << endl;
    }

    text_stream.close();
}

void print_number()
{
    cout << "testing" << colon << Index(5, 3) << comma << Index(1235, 2) << endl;
}

void test_zad1()
{
    cout << "ZADANIE 1:\n" << endl;
    
    vector<pair<int, string>> data;
    string str;
    ifstream in_data_stream;
    in_data_stream.open("data.txt");
    int idx = 1;
    while(getline(in_data_stream, str))
    {
        data.push_back(pair<int, string>(idx, str));
        idx++;
    }

    sort(data.begin(), data.end(), [](auto &left, auto &right) 
    {
    return left.second < right.second;
    });

    for(pair<int, string> p : data){cout << Index(p.first, 2) << colon << p.second << endl;}

    cout << "=============================================================" << endl;

    ignore_newline();

    cout << "=============================================================" << endl;

    ignore_x();

    in_data_stream.close();
}

void test_zad2() 
{
    cout << "\nZADANIE 2:\n" << endl;

    InputFile ifs_i("bin.txt");
    InputFile ifs_c("bin.txt");
    OutputFile ofs("bin.txt");

    srand(time(NULL));
    int random_int;
    int i_res;
    char c_res;
    for(int i = 0; i < 10; i++)
    {
        random_int = rand();
        ofs << random_int;
        ofs.flush();
    }

    for(int i = 0; i < 10; i++)
    {
        ifs_i >> i_res;
        cout << i_res << endl;
    }

    cout << "+++++++++++++++++++++++++++++++++++" << endl;

    ifs_c >> c_res;
    while(!ifs_c.eof())
    {
        cout << hex << (int)c_res << " ";
        cout << dec << (int)c_res << " ";
        if(c_res > 32 && c_res < 128)
           cout << c_res;
        cout << endl;   
        ifs_c >> c_res;
    }
}
