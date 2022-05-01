
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
