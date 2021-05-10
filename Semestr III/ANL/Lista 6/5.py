slowChebyshevCounter = [0]
fastChebyshevCounter = [0]
n = 26
x = 1.5

def slowChebyshev(n, x):
    slowChebyshevCounter[0] += 1
    
    if n == 0: return 1
    if n == 1: return x
    else: return 2*x*slowChebyshev(n-1, x) - slowChebyshev(n-2, x)

def getPrimeFactors(n):
    factors = []
    divisor = 2
    
    while(divisor * divisor <= n):
        while(n % divisor == 0):
            fastChebyshevCounter[0] += 1
            n /= divisor
            factors.append(divisor)

        divisor += 1
    
    if n > 1:
        fastChebyshevCounter[0] += 1
        factors.append(n)

    return factors

def fastChebyshevAuxiliary(n, x):
    fastChebyshevCounter[0] += 1

    if n == 0: return 1
    if n == 1: return x
    else: return 2*x*fastChebyshevAuxiliary(n-1, x) - fastChebyshevAuxiliary(n-2, x)

def fastChebyshev(n, x):
    fastChebyshevCounter[0] += 1

    factors = getPrimeFactors(n)
    result = x

    for factor in factors:
        fastChebyshevCounter[0] += 1
        result = fastChebyshevAuxiliary(factor, result)

    return result

fastChebyshevResult = fastChebyshev(n, x)
slowChebyshevResult = slowChebyshev(n, x)

print(f"Fast: {fastChebyshevResult}   Calls: {fastChebyshevCounter[0]}")
print(f"Slow: {slowChebyshevResult}   Calls: {slowChebyshevCounter[0]}")

if(abs(slowChebyshevResult - fastChebyshevResult) > 0.00000001):
    print("INVALID")