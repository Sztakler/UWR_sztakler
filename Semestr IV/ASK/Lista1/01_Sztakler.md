# Zadanie 1

Policzone na pałę, sprawdzone w kalkurwatorze.

$42_8=34_{10}$
$42_8=100010_2$
$42_8=22_{16}$
 
$255_8=173_{10}$
$255_8=10101101_2$
$255_8=AD_{16}$
 
$3047_8=1575_{10}$
$3047_8=627_2$
$3047_8=11000100111_{16}$

$140336_8=49374_{10}$
$140336_8=C0DE_2$ (_HAHA, BARDZO ŚMIESZNE_)
$140336_8=1100000011011110_{16}$
 
# Zadanie 2

Wystarczy dodawać po kreską, jak przy dodawaniu pisemnym.

# Zadanie 3

```c-
/* Funkcja przydatna w kolejnych zadaniach */
int decimal_to_binary(int dec_num) /
{
      int rem, a = 1;
      long int bin_num = 0;
      while(dec_num > 0)
      {
            rem = dec_num%2;
            dec_num = dec_num/2;
            bin_num = bin_num + (a * rem);
            a = a * 10;
      }
      return bin_num;
}

uint32_t zero_bit(uint32_t x, uint32_t k)
{
    return x & ~(1<<k);
}

uint32_t set_bit(uint32_t x, uint32_t k)
{
    return x | (1 << k);
}

uint32_t negate_bit(uint32_t x, uint32_t k)
{
    return x ^ (1 << k);
}
```

# Zadanie 4

```c=
uint32_t times_power_of_2(uint32_t x, uint32_t y)
{
    return (x << y);
}

uint32_t divided_by_power_of_2(uint32_t x, uint32_t y)
{
    return (x >> y);
}

uint32_t modulo_power_of_2(uint32_t x, uint32_t y)
{
    return x - ((x >> y) << y);
}
```

# Zadanie 5

```c=
uint32_t is_power_of_2(uint32_t x) //returns 0 when x is a power of 2
{
    return x & (x-1);
}
```

# Zadanie 6

```c=
uint32_t swap_endiannes(uint32_t x)
{
    uint32_t leftmost_byte    = (x & 0x000000FF) >> 0;
    uint32_t leftmiddle_byte  = (x & 0x0000FF00) >> 8;
    uint32_t rightmiddle_byte = (x & 0x00FF0000) >> 16;
    uint32_t rightmost_byte   = (x & 0xFF000000) >> 24;

    leftmost_byte    <<= 24;
    leftmiddle_byte  <<= 16;
    rightmost_byte   <<= 8;
    rightmiddle_byte <<= 0;

    return leftmost_byte | leftmiddle_byte | rightmiddle_byte | rightmost_byte;
}
```

# Zadanie 7

    0x00 - 0x1F contain steering codes (e.g. CR, LF, STX, ETX, EOT, BEL, ...)
    0x20 - 0x40 contain numbers and punctuation
    0x41 - 0x7F contain mostly alphabetic characters
    0x80 - 0xFF the 8th bit = undefined.
    
Pochodzi z https://medium.com/tech-tajawal/https-medium-com-tech-tajawal-character-encoding-in-depth-6f1df87888d8.

0  - **[NUL]** - *null character* - instrukcja oznaczająca nic, w C i podobnych językach oznacza koniec napisu.
4  - **[EOT]** - *end of transmission* - używany do oznaczania końca przesyłu informacji, np. w postaci tekstu. Obecnie używany głównie do uznaczania końca pliku w terminalach systemów Unixowych.
7  - **[BEL]** - *audible bell* - dawniej używany do dzwonienia dzwonkami w urządzeniach takimi jak dalekopisy czy *ticker tape*. Obecnie to zachowanie jest emulowane przez dźwięki cyfrowe w terminalach lub bzyczki komputerowe. 
10 - **[LF]** - *line feed* - oznacza koniec linii tekstu i początek nowej. W niektórych edytorach tekstu ten znak kontrolny jest dodawany przez naciśnięcie *Enter*.
12 - **[FF]** - *form feed* - znak oznaczający koniec strony, nakazujący drukarce wysunięcie obecnej kartki i rozpoczęcie druku na kolejnej, często również powoduje powrót karetki (ang. *carriage return*).

# Zadanie 8

Głównym ograniczeniem ASCII była niewielka liczba kodowanych znaków - 128. UTF-8 jest w stanie zakodować nawet 1,112,064 znaków. 128 znaków było niewystarczające, by służyć do kodowania znaków w róznych alfabetach i systemach, co stało się koniecznością w okresie rozwoju Internetu, zatem standardem stał się UTF-8, wstecznie kompatybilny z ASCII.

Sposób kodowania https://pl.wikipedia.org/wiki/UTF-8#Spos%C3%B3b_kodowania.

Jak zakodować *Proszę zapłacić 5€!* w UTF-8?
    
```kod
'Znajdujemy kody dla konkretnych znaków i mapujemy je na ciągi bitów. Jeżeli liczba
ma zbyt mało cyfr w rozwinięciu binarnym, to dopisujemy wiodące zera.'
    
    znak  | hex/unicode |  bin
    P     |   0x50      | 0101 0000
    r     |   0x72      | 0111 0010
    o     |   0x6F      | 0110 1111
    s     |   0x73      | 0111 0011
    z     |   0x7A      | 0111 1010
    ę     |   U+0119    | 1100 0100 1001 1001 #110xxxxx 10xxxxxx, bo kod między  0x80 do 0x7FF
    space |   0x20      | 0010 0000
    a     |   0x61      | 0110 0001    
    p     |   0x70      | 0111 0000
    ł     |   U+0142    | 1100 0101 1000 0010 #110xxxxx 10xxxxxx, bo kod między  0x80 do 0x7FF
    c     |   0x63      | 0110 0011
    i     |   0x69      | 0110 1001
    ć     |   U+0107    | 1100 0100 1000 0111 #110xxxxx 10xxxxxx, bo kod między  0x80 do 0x7FF
    5     |   0x35      | 0011 0101
    €     |   U+20AC    | 1110 0010 1000 0010 1010 1100 #1110xxxx 10xxxxxx 10xxxxxx, bo kod miedzy 0x800 do 0xFFFF 
    !     |   0x21      | 0010 0001

    `Musimy zapisać ten ciąg w postaci szesnastkowej, więc wystarczy przepisać odpowiednie
    liczby z powyższej tabeli a unicode przekonwertować z postaci binarnej na
    heksadecymalną.`
    
    ę - 0xC499
    ł - 0xC582
    ć - 0xC487
    € - 0xE282AC
    
'Napis to:'
0x50 0x72 0x6F 0x73 0x7A 0xC499 0x20 0x7A 0x61 0x70 0xC582 0x61 0x63 0x69
0xC487 0x35 0xE282AC 0x21
```


