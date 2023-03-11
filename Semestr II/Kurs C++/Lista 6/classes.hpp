#include <cstdlib>
#include <string>
#include <vector>
#include <iostream>
#include <math.h>

using namespace std;

class Expression
{
    public:
    virtual double evaluate();
    virtual string toString();
};

class Number : public Expression
{
    public:
    double value;

    Number(double value);
    double evaluate();
    string toString();
};

class Constant : public Expression
{
    public:
    string name;
    const double value;

    Constant(string name, double value);
    double evaluate();
    string toString();
};

class Variable : public Expression
{
    public:
    string name;
    static vector<pair<string, double>> variable_list;

    public:
    Variable(string name);
    double evaluate();
    string toString();
    static void add_variable(string name, double value);
    static void remove_variable(string name);
};

class Operator1Arg : public Expression
{
    public:
    Expression* argument;
};

class PI : public Constant
{
    public:
    PI();
};

class E : public Constant
{
    public:
    E();
};

class PHI : public Constant
{
    public:
    PHI();
};

class Sin : public Operator1Arg
{
    public:
    Expression* argument;

    Sin(Expression* argument);
    string toString();
    double evaluate();
};

class Cos : public Operator1Arg
{
    public:
    Expression* argument;

    Cos(Expression* argument);
    string toString();
    double evaluate();
};

class Exp : public Operator1Arg
{
    public:
    Expression* argument;

    Exp(Expression* argument);
    string toString();
    double evaluate();
};

class Ln : public Operator1Arg
{
    public:
    Expression* argument;

    Ln(Expression* argument);
    string toString();
    double evaluate();
};

class Abs : public Operator1Arg
{
    public:
    Expression* argument;

    Abs(Expression* argument);
    string toString();
    double evaluate();
};

class AddInverse : public Operator1Arg
{
    public:
    Expression* argument;

    AddInverse(Expression* argument);
    string toString();
    double evaluate();
};

class MultInverse : public Operator1Arg
{
    public:
    Expression* argument;

    MultInverse(Expression* argument);
    string toString();
    double evaluate();
};

class Operator2Arg : public Operator1Arg
{
    public:
    Expression* argument_left;
    Expression* argument_right;
};

class Add : public Operator2Arg
{
    public:
    Expression* argument_left;
    Expression* argument_right;

    public:
    Add(Expression* l, Expression* r);
    string toString();
    double evaluate();
};

class Subtract : public Operator2Arg
{
    public:
    Expression* argument_left;
    Expression* argument_right;

    public:
    Subtract(Expression* l, Expression* r);
    string toString();
    double evaluate();
};

class Multiply : public  Operator2Arg
{
    public:
    Expression* argument_left;
    Expression* argument_right;

    public:
    Multiply(Expression* l, Expression* r);
    string toString();
    double evaluate();
};

class Divide : public Operator2Arg
{
    public:
    Expression* argument_left;
    Expression* argument_right;

    public:
    Divide(Expression* l, Expression* r);
    string toString();
    double evaluate();
};

class Logarithm : public Operator2Arg
{
    public:
    Expression* argument_left;
    Expression* argument_right;

    public:
    Logarithm(Expression* l, Expression* r);
    string toString();
    double evaluate();
};

class Modulo : public  Operator2Arg
{
    public:
    Expression* argument_left;
    Expression* argument_right;

    public:
    Modulo(Expression* l, Expression* r);
    string toString();
    double evaluate();
};

class Power : public Operator2Arg
{
    public:
    Expression* argument_left;
    Expression* argument_right;

    public:
    Power(Expression* l, Expression* r);
    string toString();
    double evaluate();
};
