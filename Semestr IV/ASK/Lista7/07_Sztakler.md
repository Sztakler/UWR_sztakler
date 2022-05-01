
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
