def invSquare(x0, a):
    result = x0
    square = 1 / a**0.5

    for n in range(50):
        result = 0.5 * result * (3 - a * result**2)
        error = abs(result - square)
        print(f"{n}: error={error}, result={result}, square={square}".format(20))

invSquare(1, 2)