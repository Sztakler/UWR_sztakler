#!/usr/bin/env python3

import random


def unique_random_number_generator(max_d, cnt):
    # Make probability distribution non-uniform.
    classes = []
    low = 10000
    assert low < max_d
    while low < max_d:
        classes.append((low, min(max_d, 2 * low - 1)))
        low = 2 * low
    # Lazily generate at most cnt distinct numbers.
    generated = set()
    while len(generated) < cnt:
        while True:
            cl = random.randrange(len(classes))
            x = random.randint(classes[cl][0], classes[cl][1])
            if x not in generated:
                break
        generated.add(x)
        yield x


def print_input(n, max_d, max_cnt):
    print(n)
    for d in unique_random_number_generator(max_d, n):
        print(d, random.randint(1, max_cnt))

