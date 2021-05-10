def f(x):
    return x - 0.49;

a0 = a = 0
b0 = b = 1

f0 = 0.49
for i in range(6):
    middle = (a+b) / 2
    if(f(middle) > 0):
        b = middle
    else:
        a = middle

    e = abs(f0 - middle)

    print(f"e{i} = {e} dla m = {middle}, gdzie przybliżenie = {(b0-a0)/2**(i+1)}")