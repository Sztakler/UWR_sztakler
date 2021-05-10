from math import sin, cos, pi

t_Ht = [(0, 1.0), (2, 1.6), (4, 1.4), (6, 0.6), (8, 0.2), (10, 0.8)]

N = len(t_Ht) - 1

def sumSF():
    sum = 0
    for t, y in t_Ht:
        sum += sin(2*pi*t/12)*y
    return sum

def sumCF():
    sum = 0
    for t, y in t_Ht:
        sum += cos(2*pi*t/12)*y
    return sum

def sumS():
    sum = 0
    for t, y in t_Ht:
        sum += sin(2*pi*t/12)
    return sum

def sumF():
    sum = 0
    for t, y in t_Ht:
        sum += y
    return sum

def sumSC():
    sum = 0
    for t, y in t_Ht:
        sum += sin(2*pi*t/12) * cos(2*pi*t/12)
    return sum

def sumC():
    sum = 0
    for t, y in t_Ht:
        sum += cos(2*pi*t/12)
    return sum

def sumS2():
    sum = 0
    for t, y in t_Ht:
        sum += sin(2*pi*t/12) ** 2
    return sum

def sumC2():
    sum = 0
    for t, y in t_Ht:
        sum += cos(2*pi*t/12) ** 2
    return sum

p = sumSC() - sumS() * sumC() / (N+1)
z = sumCF() - sumC() * sumF() / (N+1)
v = sumC2() - sumC()**2 / (N+1)
l1 = sumSF() * (N+1) - sumS() * sumF()
l2 = sumSC() * (N+1) - sumS() * sumC()
m = sumS2() * (N+1) - sumS()**2

a2 = (z * l1 / m * p) / (v * l2 / m * p)

r1 = sumSF() - sumS() * sumF() / (N+1)
r2 = sumSC() - sumS() * sumC()
k = sumS2() - sumS()**2 / (N+1)

a1 = (r1 - a2 * r2) / k

h0 = (sumF() - a1 * sumS() - a2 * sumC()) / (N+1)

print(f"h0 = {h0}\na1 = {a1}\na2 = {a2}")

def H(h0, a1, a2, t):
    return h0 + a1 * sin(2*pi*t/12) + a2 * cos(2*pi*t/12)

for x, y in t_Ht:
    print(f"{H(h0, a1, a2, x)}\n{y}")
