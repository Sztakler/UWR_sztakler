from numpy import average, sqrt
import pandas

data = pandas.read_csv("data1309.txt", sep="\t")

print(data)

L = []
C = []

for e in data.itertuples():
    L.append(e[1])
    C.append(e[2])

averageL = average(L)
averageC = average(C)
n = len(L)
sl = sum(L)
sc = sum(C)
sl2 = sum([l**2 for l in L])
sc2 = sum([c**2 for c in C])

slc = 0
for i in range(n):
    slc += L[i] * C[i]

PearsonCorrelationCoefficient = (n * slc - sl * sc) / (sqrt(n * sl2 - sl**2) * sqrt(n * sc2 - sc**2))

print(PearsonCorrelationCoefficient)

# Obliczony współczynnik korelacji Pearsona wynosi
# 0.6918255553232497