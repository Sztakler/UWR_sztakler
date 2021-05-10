from math import cos

def f(x):
    return x**2 - 2 * cos(3 * x + 1)

intervals = [[-1, 0], [0, 1]]
for interval in intervals:
    a, b = interval
    increasing = f(a) < 0
    while True:
        mid = (a+b) / 2.
        val = f(mid)
        if b - a < 2 * 10**(-5):
            print(f"x0={mid}, [a, b]=[{a}, {b}]")
            break
        if increasing:
            if val > 0:
                b = mid
            else:
                a = mid
        else:
            if val > 0:
                a = mid
            else:
                b = mid