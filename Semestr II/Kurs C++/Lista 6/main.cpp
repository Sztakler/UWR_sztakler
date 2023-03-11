#include "classes.hpp"

int main()
{

    Number* n = new Number(1);
    cout << n->evaluate() << endl;
    cout << n->toString() << endl;

    Constant* c = new Constant("constant", 3);
    cout << c->evaluate() << endl;
    cout << c->toString() << endl;

    Variable* v = new Variable("variable");
    v->add_variable("variable", 5);
    cout << v->evaluate() << endl;
    cout << v->toString() << endl;

    PI* pi = new PI();
    cout << pi->evaluate() << endl;
    cout << pi->toString() << endl;

    E* e = new E();
    cout << e->evaluate() << endl;
    cout << e->toString() << endl;

    PHI* phi = new PHI();
    cout << phi->evaluate() << endl;
    cout << phi->toString() << endl;

    Expression* sin = new Sin(pi);
    cout << sin->evaluate() << endl;
    cout << sin->toString() << endl;

    Expression* cos = new Cos(pi);
    cout << cos->evaluate() << endl;
    cout << cos->toString() << endl;

    Expression* exp = new Exp(n);
    cout << exp->evaluate() << endl;
    cout << exp->toString() << endl;

    Expression* ln = new Ln(e);
    cout << ln->evaluate() << endl;
    cout << ln->toString() << endl;

    Expression* absolute = new Abs(new Number(-2.5));
    cout << absolute->evaluate() << endl;
    cout << absolute->toString() << endl;

    Expression* adinv = new AddInverse(n);
    cout << adinv->evaluate() << endl;
    cout << adinv->toString() << endl;

    Expression* multinv = new MultInverse(n);
    cout << multinv->evaluate() << endl;
    cout << multinv->toString() << endl;

    Expression* add = new Add(new Number(-2.5), new Number(3.5));
    cout << add->evaluate() << endl;
    cout << add->toString() << endl;

    Expression* sub = new Subtract(new Number(-2.5), new Number(3.5));
    cout << sub->evaluate() << endl;
    cout << sub->toString() << endl;
    
    Expression* mult = new Multiply(new Number(-2.5), new Number(3.5));
    cout << mult->evaluate() << endl;
    cout << mult->toString() << endl;

    Expression* div = new Divide(new Number(-2.5), new Number(3.5));
    cout << div->evaluate() << endl;
    cout << div->toString() << endl;

    Expression* mod = new Modulo(new Number(-2.5), new Number(3.5));
    cout << mod->evaluate() << endl;
    cout << mod->toString() << endl;

    Expression* power = new Power(new Number(-2.5), new Number(3.5));
    cout << power->evaluate() << endl;
    cout << power->toString() << endl;

    Expression* log = new Logarithm(new Number(2), new Number(3.5));
    cout << log->evaluate() << endl;
    cout << log->toString() << endl;

    Expression *w = new Subtract(
        new Add(
            new PI(),
            new E()),
            new Add(
                new Number(2),
                new Multiply(
                    new Variable("x"),
                    new Number(7))));
    // cout << w -> evaluate() << endl;
    // cout << w->toString() << endl;

// ((x-1)*x)/2
// (3+5)/(2+x*7)
// 2+x*7-(y*3+5)
// cos((x+1)*x)/e^x^2

    Expression* e1 = new Divide(
        new Multiply(
            new Subtract(
                new Variable("x"),
                new Number(1)),
                new Variable("x")),
                new Number(2));
    // cout << e1 -> evaluate() << endl;
    // cout << e1->toString() << endl;


    Expression* e2 = new Divide(
        new Add(
            new Number(3),
            new Number(5)),
        new Add(
            new Number(2),
            new Multiply(
                new Variable("x"),
                new Number(7))));
    // cout << e2 -> evaluate() << endl;
    // cout << e2->toString() << endl;

    Expression* e3 = new Add(
        new Number(2),
        new Subtract(
            new Multiply(
                new Variable("x"),
                new Number(7)),
            new Add(
                new Multiply(
                    new Variable("y"),
                    new Number(3)),
                new Number(5))
                ));
    // cout << e3 -> evaluate() << endl;
    // cout << e3->toString() << endl;

    Expression* e4 = new Divide(
        new Cos(
            new Multiply(
                new Add(
                    new Variable("x"),
                    new Number(1)),
                new Variable("x"))),
        new Exp(
            new Power(
                new Variable("x"),
                 new Number(2))));
        
    // cout << e4 -> evaluate() << endl;
    // cout << e4->toString() << endl;

    cout << "Expression 1: " << e1->toString() << endl;
    cout << "Expression 2: " << e2->toString() << endl;  
    cout << "Expression 3: " << e3->toString() << endl;  
    cout << "Expression 4: " << e4->toString() << endl;  

    Variable* x = new Variable("x");
    Variable* y = new Variable("y");
    y->add_variable("y", 1);

    for (double i = 0; i <= 100; i++)
    {
        x->add_variable("x", i/100);
        cout << "Expression 1 for 'x' = " << i/100 << " = " <<  e1 -> evaluate() << endl;
        cout << "Expression 2 for 'x' = " << i/100 << " = " << e2 -> evaluate() << endl ;
        cout << "Expression 3 for 'x' = " << i/100 << " = " << e3 -> evaluate() << endl;
        cout << "Expression 4 for 'x' = " << i/100 << " = " << e4 -> evaluate() << endl;
        x->remove_variable("x");
    }

    return 0;
}