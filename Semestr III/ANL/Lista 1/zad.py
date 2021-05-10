from math import pi

def series(n):
    result = 0;

    for i in range(n):
        result += (-1)**i / (2 * i + 1)

    return 4 * result

def error(result):
    return abs(result - pi) <= 10**(-4)

print(series(1000))
print(error(series(10000)))