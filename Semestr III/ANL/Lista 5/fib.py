def fib(n):
    return (1 / 5**0.5) * (((1 + 5**0.5) / 2)**n - ((1 - 5**0.5) / 2)**n)

# for n in range(100):
#     print(fib(n))


# count = 0
# for i in range(1, 801):
    # condition = ( i % 6 == 0 or i % 8 == 0 ) and i % 7 != 0
    # if condition:
        # count += 1
    # print(i, condition)
# print(count)

def fib2(n):
    return (1 / 5**0.5) * (((1 + 5**0.5) / 2)**(n + 2) - ((1 - 5**0.5) / 2)**(n + 2))

for n in range(10):
    print(fib2(n))