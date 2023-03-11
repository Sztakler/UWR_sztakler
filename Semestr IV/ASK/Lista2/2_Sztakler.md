## Zadanie 1

```c=
(x > 0) || (x - 1 < 0)
// Oblicza się do fałszu dla  x = INT32_MIN
x = INT_MIN;
printf("%I32d\n", x);
printf("%I32d || %I32d = %I32d\n", (x > 0), (x - 1 < 0), (x > 0) || ((x - 1) < 0));
```
```c=
(x & 7) != 7 || (x << 29 < 0)
```
Oblicza się zawsze do prawdy, bo x & 7 zwraca 7, gdy trzy najmniej znaczące bity x to 1, ale wtedy x << 29 jest ujemne, bo najbardziej znaczący bit to 1. Jeśli x & 7 nie daje 7, wtedy x << 29 jest dodatnie.

```c=
(x * x) >= 0
```
Oblicza się do fałszu dla x = 0x3FFFFFFF. Wystarczy, żeby wynik mnożenia x*x zawierał jedynkę na najbardziej znaczącym bicie.

```c=
x < 0 || -x <= 0
```
Zawsze oblicza się do prawdy, bo każda liczba dodatnia, ma odpowiadającą sobie liczbę ujemną w U2. Wtedy gdy x jest ujemne, to lewa strona jest prawdą, gdy x jest dodatni lub jest zerem, to prawa strona jest prawdą.

```c=
x > 0 || -x >= 0
```
Zwraca fałsz dla x = INT32_MIN, ponieważ na 32 bitach nie da się reprezentować jej dodatniej wartości. Liczba przeciwna do INT32_MIN to INT32_MIN, wtedy obie strony są fałszem.

```c=
(x | -x) >> 31 == -1
```
Fałsz dla x = 0. Wtedy x | -x wynosi 0, po przesunięciu o 31 bitów dalej jest 0.

```c=
x + y == (uint32_t)y + (uint32_t)x
```
Oblicza się zawsze do prawdy, bo castowanie do unsigned jest *zaraźliwe* i castuje wszystkie inne czynniki wyrażenia do unsigned, zatem po obu stronach równania są te same wartości.

```c=
x * ~y + (uint32_t)y * (uint32_t)x == -x
```
W U2 -y = ~y + 1, a stąd ~y = -y - 1. Możemy zatem przekształcić powyższe równanie do
```c
x * (-y - 1) + (uint32_t)y * (uint32_t)x == -x
x * (-y - 1) + (uint32_t)y * (uint32_t)x == -x
-(x * y) - x + (uint32_t)y * (uint32_t)x == -x
-x == -x
```

## Zadanie 2

```c=
x = x^y
y = y^x
x = x^y
```

Kolejne kroki algorytmu

```c=
1. x1 = x0^y0
2. y1 = y0 ^ x1 = y0 ^ (x0^y0) = y0 ^ y0 ^ x0 = 0 ^ x0 = x0
3. x1 = x1 ^ y1 = (x0^y0) ^ x0 = y0 ^ x0 ^ x0 = y0 ^ 0 = y0
```

## Zadanie 3

```c=
bool condition = ((x + y) ^ x) & ((x + y) ^ y) >> 31;
```
Nadmiar występuje, gdy dodajemy do siebie dwie liczby o tym samym znaku i wynik jest znaku przeciwnego.
`((x + y) ^ x)` sprawdza, czy znak wyniku różny niż znak x, `((x + y) ^ y)` sprawdza, czy jest różny, niż znak y (XOR zwróci wtedy `1`). Informacja o tym jest przechowywana na najbardziej znaczącym bicie. Jeśli weźmiemy `&` obu tych wyrażeń sprawdzimy, czy znaki x i y były takie same. Przesunięcie wyniku o `31` miejsc w lewo daje `1`, jeśli znak `x+y` był różny niż znak `x` i `y` oraz znaki `x` i `y` były takie same, czyli wystąpił nadmiar. W przeciwnym wypadku zwraca `0`, czyli nadmiar nie wystąpił.

**Nadmiar** (ang. *overflow*) -- przekroczenie maksymalnej wartości, którą maszyna jest w stanie reprezentować na danej liczbie bitów. Występuje, gdy znaki dodawanych wyrazów są takie same, a wyniku przeciwny, np. dla `int32_t` `INT32_MAX + 1 == INT32_MIN`.

**Niedomiar** (ang. *underflow*) -- występuje, gdy liczba, którą chcemy reprezentować ma zbyt małą wartość, by dało się ją reprezentować na danej liczbie bitów. Występuje przy danych zmiennoprzecinkowych, nie występuje dla danych całkowitoliczbowych.

## Zadanie 4

$$z=\sum_{i=0}^{3}y_i 2^{8i}$$
$$z_i = x_i \oplus y_i$$
$$z=\sum_{i=0}^{3}(x_i \oplus y_i) 2^{8i}$$

#### Dodawanie
W przypadku dodawania przeniesienie będzie występować, gdy najbardziej znaczący bit w danym bajcie $x_i$ i $y_i$ to 1, wtedy nastąpi przeniesienie do kolejnego bajtu. Może sprawdzać, czy taka sytuacja zachodzi poprzez użycie XORa, który zachowuje się jak suma po pojedynczych bitach. 

Najpierw przeprowadźmy dodawanie na pierwszych siedmiu bitach każdego bajtu, unikająć w ten sposób przeniesienia. Następnie uwzględnijmy przeniesienie za pomocą XORa.
```c=
z = x & 0x7F7F7F7F + y & 0x7F7F7F7F;
z = (x ^ y) & 0x80808080 ^ z;
```
- `x^y` zwróci nam informację, na których bitach powinno wystąpić przeniesienie. 
- & 0x80808080 zwróci nam tylko najwyższe bity każdego bajtu.
- ^ z ustali wartość na najwyższym bicie w danym bajcie.

```brac
0101 1111
1001 1011
+________
1111 1010

(0101 1111 & 0x7F7F7F7F) + (1001 1011  & 0x7F7F7F7F)

0101 0111
0001 0011
+________
0110 1010

0101 1111
1001 1011
^________
1100 0100

1100 0100
0x80808080
&_________
1000 0000 - pokazuje, gdzie nastąpiło przeniesienie

1000 0000
0110 1010
^________
1110 1010
```

#### Odejmowanie
Analogicznie możemy postąpić dla odejmowania. Najpierw ustawiamy najwyższe bity w każdym bajcie x na 1 i odejmujemy od tak uzyskanych bajtów pierwsze 7 bitów bajtów z y. W ten sposób nie zajdzie pożyczka.

Następnie wykonujemy analogiczne operacje, co dla dodawania, tzn. poprawiamy wynik, jeli zachodzi pożyczka.
```c
z = x | 0x80808080 - y & 0x7F7F7F7F;
z = ~((x ^ y) | 0x7F7F7F7F ^ z);
```

```
325-273=52
0001 0100 0101
0001 0001 0001
-________
0000 0011 0100

x = 0001 0100 0101
y = 0001 0001 0001

z = x | 0x80808080 - y & 0x7F7F7F7F
0001 0100 0101
0x80808080
|_____________
0001 1100 0101

0001 0001 0001
0x7F7F7F7F
&_____________
0001 0001 0001

0001 1100 0101
0001 0001 0001
-_____________
0000 1011 0100

z = 0000 1011 0100

0001 0100 0101
0001 0001 0001
^________
0000 0101 0100

0000 0101 0100
0x7F7F7F7F
|_________
1111 0111 1111

1111 0111 1111
0000 1011 0100
^________
1111 1100 1011

~z = 0000 0011 0100
```

## Zadanie 5

```c=
w = x * 3/4
w = (3*x) / 4
w = (2*x + x) / 4
w = 2*x/4 + x / 4
w = x/2 + x/4
w = (x >> 1) + (x >> 2)
```

Zauważmy, że takie obliczenia mogą doprowadzić do wystąpienia zjawiska nadmiaru. Wynika ono stąd, że w przypadku, gdy dwa najmniejsze bity `x` to `1`, wtedy w wyniku `(x >> 1) + (x >> 2)` otrzymamy 1 na najmniej znaczącym bicie, czyli wynik będzie o 1 mniejszy od prawidłowego. 

```
x = 7 = 111

    Jak powinna przebiegać operacja?
    111>>1
    111>>2
    =___________
    011,1
    001,11
    +___________
    101,01         

    Jak przebiega operacja po przesunięciu x.
    111>>1
    111>>2
    =___________
    011
    001
    +___________
    100      

    Łatwo zauważyć, że tracimy jedynkę poprzez ucięcie cyfr po przecinku. Musimy ją w takim razie dodać do wyniku.
```
Najpierw musimy rozpoznać, czy dwie ostatnie cyfry `x` to `1`. Może to zrobić przy pomocy wyrażenia `(x & 1) & ((x >> 1) & 1) == x & (x>>1) & 1`. Wtedy zwracamy 
```c=
(x >> 1) + (x >> 2) + (x & (x>>1) & 1)
```


## Zadanie 6

```
(b)
x < y == x - y < 0
```
Chcemy sprawdzić, czy x-y<0, czyli sprawdzić znak tej liczby. Jeśli znak to 1, to x < y. Możemy to zrobić przy pomocy:
```
(x-y) >> 31
```
Zauważmy, że taka operacja może skończyć się wystąpieniem nadmiaru, np. gdy x jest ujemny, a y dodatni. Możemy łatwo uniknąć tego problemu, dzieląc stronami przez 2.
```
(x>>1) - (y>>1)
```
Przesunięcia bitowe pozbawiają nas informacji o najmniej znaczącym bicie. Zauważmy, że ta informacja mogła być dla nas istotna, np. przy porównywaniu liczb `8 < 9`, tzn. `0b1000 < 0b1001`. Zauważmy, że ominiemy w ten sposób przeniesienie, jeśli cyfra jedności x to 0 a y to 1. W takim razie możemy wydobyć informację o tych bitach:
```
(~x & y & 1)
```
i odjąć od wyniku:
```
((x>>1) - (y>>1) - (~x & y & 1)) >> 31
```
## Zadanie 7

Wiemy, że `b? x : y` możemy zapisać jako `b * x + !b * y`, jeśli `b = 0 lub 1`. Operacja mnożenia jest zabroniona, więc nie możemy użyć tego sposobu. Zauważmy jednak, że analogicznie `b` mozemy przedstawić jako:
```c=
 b = 111...1 = -1
~b = 000...0 =  0
```
Za jego pomocą możemy łatwo zapisać operację `b? x : -x` jako `b & x + ~b & x`. Możemy łatwo wyznaczyć `b` i zapisać:
```c=
b = x >> 31 // bo mamy 32 bitową liczbę
            // wtedy b = 0 lub -1, czyli znak x

x = (-b) & x + ~(-b) & -x // zwraca wartość bezwzględną z x
```
`-b` zwróci `0`, jeśli `b=0`, czyli x było dodatnie oraz `-1`, jeśli `b=1`, czyli x było ujemne.

(x>>31 & -x) zwraca x, jeśli x jest ujemny, bo wtedy x>>31 to same jedynki, a bit znaku -x będzie 0.
 (~(x >> 31) & x) zwraca x, jeśli x jest dodatni, wtedy x>>31 to same zera, więc -(x>>31) zwraca same jedynki, a bit znaku x to 0.

```c=
(x>>31 & -x) + (~(x >> 31) & x) // zwraca wartość bezwzględną z x
```

## Zadanie 8

Sprawdzić, czy liczba jest dodatnia czy ujemna możemy za pomocą
```
x >> 31
```
Jednak taki zapis zwróci 0, jeśli x >= 0.
```
(-x >> 31)
```
zwróci 1. jeśli x > 0 i 0, jeśli x <=0.

Zauważmy, że wtedy 
```c
-(x >> 31) | (-x >> 31)
``` 
daje 1, jeśli x > 0, -1, jeśli x < 0 i 0, gdy x = 0.

## Zadanie 9

Możemy wykorzystać funkcję zwracającą liczbę jedynek w wyrazie i sprawdzić, czy otrzymany wynik jest parzysty, np. w taki sposób.
```c=
x = (x & 0x33333333) + (x>>1  & 0x33333333);
x = (x & 0x55555555) + (x>>2  & 0x55555555);
x = (x & 0x0F0F0F0F) + (x>>4  & 0x0F0F0F0F);
x = (x & 0x00FF00FF) + (x>>8  & 0x00FF00FF);
x = (x & 0x0000FFFF) + (x>>16 & 0x0000FFFF);

return x & 1;
```

Możemy także skorzystać z faktu, że dla pojedynczych bitów operacja x ^ y zwraca informację o tym, czy liczba jedynek na jednobitowych liczbach x i y jest parzysta czy nie, dokładniej zwraca 0, jeśli jest parzysta i 1, jeśli nieparzysta. Wtedy możemy zapisać:

```c=
x = x ^ x>>1;
x = x ^ x>>2;
x = x ^ x>>4;
x = x ^ x>>8;
x = x ^ x>>16;

return x & 1;
```
```
0011 0010 0001 1111 1101 1010 0001 0011 = 0x321FDA13
0001 1001 0000 1111 1110 1101 0000 1001
^______________________________________
0010 1011 0001 0000 0011 0111 0001 1010

0010 1011 0001 0000 0011 0111 0001 1010
0000 1010 1100 0100 0000 1101 1100 0110
^______________________________________
0010 0001 1101 0100 0011 1010 1101 1100

0010 0001 1101 0100 0011 1010 1101 1100
0000 0010 0001 1101 0100 0011 1010 1101
^______________________________________
0010 0011 1100 1001 0111 1001 0111 0001

0010 0011 1100 1001 0111 1001 0111 0001
0000 0000 0010 0011 1100 1001 0111 1001
^______________________________________
0010 0011 1110 1010 1011 0000 0000 1000

0010 0011 1110 1010 1011 0000 0000 1000
0000 0000 0000 0000 0010 0011 1110 1010
^______________________________________
0010 0011 1110 1010 1001 0011 1110 0010
```
Jest to rozwiązanie podobnie wykorzystujące metodę *dziel i zwyciężaj*. Na każdym etapie obliczeńna najmniej znaczącym bicie w danej paczce bitów w x przechwywana jest informacja o parzystości jedynek w tej paczce. Np.
```
0011 0010 0001 1111 1101 1010 0001 0011 = 0x321FDA13
0001 1001 0000 1111 1110 1101 0000 1001
^______________________________________
0010 1011 0001 0000 0011 0111 0001 1010
Na najmniej znaczącym bicie w każdej parze bitów wyniku przechowywana jest
informacja o parzystości liczby jedynek.

0010 1011 0001 0000 0011 0111 0001 1010
0000 1010 1100 0100 0000 1101 1100 0110
^______________________________________
0010 0001 1101 0100 0011 1010 1101 1100
Na najmniej znaczącym bicie w każdej czwórce bitów wyniku przechowywana jest
informacja o parzystości liczby jedynek.

Itd.
```
