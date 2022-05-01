from numpy import average, diff, sign, sqrt
import pandas

# Przygotowujemy dane

data = pandas.read_csv("data1304.txt", sep="\t")

F = []
M = []

for e in data.itertuples():
    F.append(e[1])
    M.append(e[2])

# Stawiamy hipotezę zerową, że nie ma różnicy w liczbie oglądania TV, tzn. różnica median jest zerowa.
# Obliczamy różnice w liczbie oglądania między kobietami a mężczyznami. Odrzucamy różnice zerowe.

differences = []

for i in range(len(F)):
    difference = F[i] - M[i]
    if difference != 0:
        differences.append(difference)

# Sortujemy otrzymane różnice. Przypisujemy im odpowiednie rangi (indeks w tablicy po posortowaniu lub średnie z indeksów, jeśli mamy kilka takich samych wartości róznic).
differences = sorted(differences, key=lambda x: abs(x))

signs = []
ranks = []
value = abs(differences[0])
rank = 0
n = 0
for i in range(len(differences)):
    signs.append(sign(differences[i]))
    if value == abs(differences[i]):
        rank += i + 1 
        n += 1
    else: 
        rank /= n
        for j in range(i-1, i-n-1, -1):
            ranks[j] = rank
        value = abs(differences[i])
        rank = i + 1
        n = 1
    ranks.append(rank)

# Zliczamy sumy rang dla dodatnich i ujemnych różnic. Statystyka W to minimum z tych dwóch wartości.

Wplus = 0
Wminus = 0

for i in range(len(ranks)):
    if signs[i] > 0:
        Wplus += ranks[i]
    else:
        Wminus += ranks[i]

Wstatistic = min(Wplus, Wminus)

# Przyjmujemy poziom istotności alfa = 0.05.
# Otrzymujemy Wstatistic=122.5. Mamy tylko 26 próbek (po odrzuceniu zer), więc nie będziemy przybliżać rozkładu rozkładem normalnym, a odczytamy wartość krytyczną z tabeli. 
# Znajdujemy, że Wcritical = 98 dla podanej liczby próbek i poziomu istotności. Skoro 122.5 > 98, to Wstatistic > Wcritical, czyli nie możem,y odrzucić hipotezy zerowej, tzn. że nie
# ma różnicy między kobietami i mężczyznami pod względem oglądania telewizji.


# Korzystano z pomocy:
# https://sphweb.bumc.bu.edu/otlt/MPH-Modules/BS/BS704_Nonparametric/BS704_Nonparametric6.html
# https://mathcracker.com/wilcoxon-signed-ranks?#results
# https://www.real-statistics.com/statistics-tables/wilcoxon-signed-ranks-table/