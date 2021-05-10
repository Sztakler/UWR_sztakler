#include <iostream>
#include <iomanip>
#include <string>
#include <cmath>

using namespace std;

double cardano_worse(double r, double q)
{
    double x =pow(r - sqrt(pow(q, 3.0) + pow(r, 2.0)), 1.0 / 3.0);
    return x;
}

double cardano_better(double r, double q)
{
    double c = r + sqrt(pow(q, 3) + pow(r, 2)); 
    double cbrt_c2 = pow(pow(c, 2), 1.0 / 3.0);
    double x = (2 * r) / (cbrt_c2 + q + (pow(q, 2) / cbrt_c2));
    return x;
}


int main()
{
    cout << fixed << setprecision(30) << cardano_worse(pow(10.0,4.0), pow(10.0,-4.0))  << endl;
    cout << fixed << setprecision(30) << cardano_better(pow(10.0,4.0), pow(10.0,-4.0)) << endl;

    return 0;
}