#include "classes.hpp"

vector<pair<string, double>> Variable::variable_list;

double Expression::evaluate() {return 0;}

string Expression::toString() {return "";}

Number::Number(double value) : value(value){}

double Number::evaluate()
{
    return this->value;
}
string Number::toString()
{
    return std::to_string(this->value);
}

Constant::Constant(string name, double value) : name(name), value(value){}

double Constant::evaluate()
{
    return this->value;
}

string Constant::toString()
{
    return this->name;
}
  
Variable::Variable(string name) : name(name){}

double Variable::evaluate()
{
    for(pair<string, double> p : variable_list) // int i = variable_list.size(); i >= 0; i--
    {
        if (p.first == this->name) return p.second; // (variable_list[i].first == this->name) return variable_list[i].second
    }
    throw invalid_argument("Variable " + name + " has no value");
}

string Variable::toString()
{
    return this->name;
}

void Variable::add_variable(string name, double value)
{
        pair<string, double> p;
        p.first = name;
        p.second = value;
        variable_list.push_back(p);
}

void Variable::remove_variable(string name)
{
    for (auto index = variable_list.begin(); index != variable_list.end();)
    {
        if (index->first == name) variable_list.erase(index);
        else index++;
    }
}

PI::PI() : Constant("pi", 3.141592){}

E::E() : Constant("e", 2.718281){}

PHI::PHI() : Constant("phi", 1.61803){}

// One argument operations

Sin::Sin(Expression* arg) : argument(arg){}

double Sin::evaluate()
{
    return sin(argument->evaluate());
}

string Sin::toString()
{
    return "sin("+ argument->toString() +")";
}

Cos::Cos(Expression* arg) : argument(arg){}

double Cos::evaluate()
{
    return cos(argument->evaluate());
}

string Cos::toString()
{
    return "cos("+ argument->toString() +")";
}

Exp::Exp(Expression* arg) : argument(arg){}

double Exp::evaluate()
{
    return exp(argument->evaluate());
}

string Exp::toString()
{
    return "exp("+ argument->toString() +")";
}

Ln::Ln(Expression* arg) : argument(arg){}

double Ln::evaluate()
{
    return log(argument->evaluate());
}

string Ln::toString()
{
    return "ln("+ argument->toString() +")";
}

Abs::Abs(Expression* arg) : argument(arg){}

double Abs::evaluate()
{
    return abs(argument->evaluate());
}

string Abs::toString()
{
    return "|"+ argument->toString() + "|";
}

AddInverse::AddInverse(Expression* arg) : argument(arg){}

double AddInverse::evaluate()
{
    return -(argument->evaluate());
}

string AddInverse::toString()
{
    return "-(" + argument->toString() + ")";
}


MultInverse::MultInverse(Expression* arg) : argument(arg){}

double MultInverse::evaluate()
{
    return 1 / (argument->evaluate());
}

string MultInverse::toString()
{
    return "1/" + argument->toString();
}


// Two arguments operations

Add::Add(Expression* l, Expression* r)
{
    this->argument_left = l;
    this->argument_right = r;
}

double Add::evaluate()
{
    return argument_left->evaluate() + argument_right->evaluate();
}

string Add::toString()
{
    return "(" + argument_left->toString() + ")" + "+" + "(" + argument_right->toString() + ")";
}

Subtract::Subtract(Expression* l, Expression* r)
{
    this->argument_left = l;
    this->argument_right = r;
}

double Subtract::evaluate()
{
    return argument_left->evaluate() - argument_right->evaluate();
}

string Subtract::toString()
{
    return "(" + argument_left->toString() + ")" + "-" + "(" + argument_right->toString() + ")";
}

Multiply::Multiply(Expression* l, Expression* r)
{
    this->argument_left = l;
    this->argument_right = r;
}

double Multiply::evaluate()
{
    return argument_left->evaluate() * argument_right->evaluate();
}

string Multiply::toString()
{
    return "(" + argument_left->toString() + ")" + "*" + "(" + argument_right->toString() + ")";;
}

Divide::Divide(Expression* l, Expression* r)
{
    this->argument_left = l;
    this->argument_right = r;
}

double Divide::evaluate()
{
    return argument_left->evaluate() / argument_right->evaluate();
}

string Divide::toString()
{
    return "(" + argument_left->toString() + ")" + "/" + "(" + argument_right->toString() + ")";
}

Logarithm::Logarithm(Expression* l, Expression* r)
{
    this->argument_left = l;
    this->argument_right = r;
}

double Logarithm::evaluate()
{
    return log(argument_left->evaluate()) / log(argument_right->evaluate());
}

string Logarithm::toString()
{
    return "log(" + argument_left->toString() + ", " + argument_right->toString() + ")";
}

Modulo::Modulo(Expression* l, Expression* r)
{
    this->argument_left = l;
    this->argument_right = r;
}

double Modulo::evaluate()
{
    return (int)argument_left->evaluate() % (int)argument_right->evaluate();
}

string Modulo::toString()
{
    return argument_left->toString() + " mod " + argument_right->toString() ;
}

Power::Power(Expression* l, Expression* r)
{
    this->argument_left = l;
    this->argument_right = r;
}

double Power::evaluate()
{
    return pow(argument_left->evaluate(), argument_right->evaluate());
}

string Power::toString()
{
    return argument_left->toString() + "^(" + argument_right->toString() + ")" ;
}
