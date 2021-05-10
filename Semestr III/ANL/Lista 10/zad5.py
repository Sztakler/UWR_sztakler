T = [(0, 68.0), (10, 67.1), (20, 66.4), (30, 65.6), (40, 64.6),
     (80, 61.8), (90, 61.0), (95, 60.0)]

def sumFTT():
    sum = 0
    for t, s in T:
        sum += s * t
    return sum

def sumFTsumT():
    sumFT = 0
    sumT = 0
    for t, s in T:
        sumFT += s
        sumT += t
    return 1/8 * sumFT * sumT

def sumT2():
    sum = 0
    for t, s in T:
        sum += t**2
    return sum

def sumT():
    sum = 0
    for t, s in T:
        sum += t
    
    return sum

def sumFT():
    sum = 0
    for t, s in T:
        sum += s
    return sum

a = (sumFTT() - sumFTsumT()) / (sumT2() - 1/8 * sumT()**2)

b = (sumFT() - a * sumT()) / 8

print(f"a={a}\nb={b}")