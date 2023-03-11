#include <stdio.h>
#include <stdint.h>

int decimal_to_binary(int dec_num)
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

//Zadanie 1
uint32_t copy_bit(uint32_t x, uint32_t i, uint32_t k)
{
    /*
    Krótki przykład i opis metody
    101001101 -- liczba wejściowa

    000000001<<i
    000000100 -- tworzymy maskę, która przechowa informację o bicie na i-tej pozycji
    &________
    000000100

    000000100<<(k-i) -- przesuwamy ten bit na k-tą pozycję
    000100000

    000000001<<k -- przesuwamy jedynkę na k-tą pozycję
    000100000
    ~________ -- negujemy, żeby wyzerować k-ty bit liczby wejściowej, inaczej nie będziemy mogli wkleić tam nowego bitu
    111011111

    101001101 
    111011111
    &________ -- zerujemy k-ty bit otrzymaną wyżej maską
    101001101

    000100000 -- wklejamy ten bit na ktą pozycję liczby wejściowej z wyzerowanym k-tym bitem
    101001101
    |________
    101101101 - skopiowano
    */

    return ((x & (1 << i)) << (k-i)) | (x & ~(1 << k));
}

//Zadanie 2

uint32_t count_ones(uint32_t x)
{
//     0x55555555
//     0101 0101 0101 0101 0101 0101 0101 0101 -- maska, wyciągająca co drugi bit 

//     0x33333333
//     0011 0011 0011 0011 0011 0011 0011 0011 -- maska, wyciągająca pary bitów

//     0x0F0F0F0F
//     0000 1111 0000 1111 0000 1111 0000 1111 -- maska, wyciągająca czwórki bitów

//     0x00FF00FF
//     0000 0000 1111 1111 0000 0000 1111 1111 -- maska, wyciągająca ósemki bitów

//     0x0000FFFF
//     0000 0000  0000 0000 1111 1111 1111 1111 -- maska, wyciągająca szesnastki bitów

//     Będziemy wyciągać w każdej iteracji odpowiednio wszystkie pojedyncze bity, pary bitów, czwórki, ósemki, itd.
// 
// x = 1111 0011 0010 1010 1111 1101 0011 0110
//     1111 0011 0010 1010 1111 1101 0011 0110 >>1 1111 0011 0010 1010 1111 1101 0011 0110
//                                                 0111 1001 1001 0101 0111 1110 1001 1011
//     0101 0101 0101 0101 0101 0101 0101 0101     0101 0101 0101 0101 0101 0101 0101 0101
//     &_______________________________            &_______________________________
//     0101 0001 0000 0000 0101 0101 0001 0100     0101 0001 0001 0101 0101 0100 0001 0001
//     0101 0001 0001 0101 0101 0100 0001 0001
//     +______________________________________     
// x = 1010 0010 0001 0101 1010 1001 0010 0101 -- ten wynik przekazujemy do kolejnej iteracji. 
//     Po ostatniej iteracji otrzymamy w zmiennej x liczbę jedynek w liczbie na wejściu.


    x = (x & 0x55555555) + ((x>>1) & 0x55555555); //dzieli na pojedyncze bity i dodaje je ze sobą
    x = (x & 0x33333333) + ((x>>2) & 0x33333333); //dzieli na pary bitów i dodaje je ze sobą
    x = (x & 0x0F0F0F0F) + ((x>>4) & 0x0F0F0F0F); //dzieli na czwórki bitów i dodaje je ze sobą
    x = (x & 0x00FF00FF) + ((x>>8) & 0x00FF00FF); //dzieli na ósemki bitów i dodaje je ze sobą
    x = (x & 0x0000FFFF) + ((x>>16) & 0x0000FFFF); //dzieli na szesnastki bitów i dodaje je ze sobą

    return x;
}

// void secret(uint8_t *to, uint8_t* from, size_t count)
// {
//     size_t n = (count + 7) / 8;
//     switch(count % 8)
//     {
//        case 0: do { *to++ = *from++;
//        case 7:      *to++ = *from++;
//        case 6:      *to++ = *from++;
//        case 5:      *to++ = *from++;
//        case 4:      *to++ = *from++;
//        case 3:      *to++ = *from++;
//        case 2:      *to++ = *from++;
//        case 1:      *to++ = *from++;
//                   } while (--n>0);
//     }
// }

void secret(uint8_t *to, uint8_t* from, size_t count)
{
    size_t n = (count + 7) / 8;
    static void *labels[] = {&&l0, &&l1, &&l2, &&l3, &&l4, &&l5, &&l6, &&l7};
    
    goto *labels[count % 8];

    l0:    *to++ = *from++;
    l7:    *to++ = *from++;
    l6:    *to++ = *from++;
    l5:    *to++ = *from++;
    l4:    *to++ = *from++;
    l3:    *to++ = *from++;
    l2:    *to++ = *from++;
    l1:    *to++ = *from++; 

    if (--n > 0) goto l0;
}


int main()
{
    /* Zadanie 1 */
    // uint32_t x = 333;
    // uint32_t i = 3;
    // uint32_t k = 4;

    // printf("%u\n%u\n", 
    //         decimal_to_binary(x),
    //         decimal_to_binary(copy_bit(x, i, k)));

    /* Zadanie 2 */

    // uint32_t x = 128;
    // printf("%u\n%u", decimal_to_binary(x), count_ones(x));


/*Zadanie 3*/
/*
Źródło: https://en.wikipedia.org/wiki/Data_structure_alignment#Data_structure_padding
Elementy są przechowywane w pamięci w sposób uporządkowany, muszą zajmować wielokrotność potęgi dwójki bajtów. Kompilator
próbuje ustawić elementy w pamięci w poprawny sposób, jednak gdy obok siebie znajdują się obiekty o różnym rozmiarze, musi
dodać dodatkową pustą przestrzeń w pamięci, by zachować poprawne ustawienie, jest to padding.
Problem wynika z występowania paddingu podczas reprezentowania danych w pamięci komputera. Padding jest dodawany tylko,
gdy element o mniejszym rozmiarze jest umieszczony przed elementem o większym rozmiarze.
By uniknąć tego problemu należy umieszczać elementy w kolejności malejącego rozmiaru.
*/
// // Reprezentacja w pamięci
// // a----
// // bbbbb
// // cdd-- - łącznie 24 bajty
//     struct A        
//     {
//         int8_t a;  //1 bajt
//         void *b;   //4 bajty
//         int8_t c;  //1 bajt
//         int16_t d; //2 bajty
//     };

// //Elementy ułożone w kolejności malejącego rozmiaru, więc otrzymujemy minimalny padding.
// // reprezentacja w pamięci
// // bbbb
// // ddac  - łącznie 16 bajtów i brak paddingu
//     struct A2
//     {
//         void *b;
//         int16_t d;
//         int8_t a;
//         int8_t c;
//     };

// // aa------
// // bbbbbbbb
// // cccc----
//     struct B
//     {
//         int16_t a; // 2 bajty
//         double b;  // 8 bajtów
//         void *c;   // 4 bajty
//     };


// // bbbbbbbb
// // ccccaa--  -- 16 bajtów
//     struct B2
//     {
//         double b;  // 8 bajtów
//         void *c;   // 4 bajty
//         int16_t a; // 2 bajty
//     };

//     struct A sA   = {1, &y, 1, 1};
//     struct A2 sA2 = {&y, 1, 1, 1};

//     struct B Bs = {1, 1, &y};
//     struct B2 Bs2 = {1, &y, 1};
    
//     printf("sizeof sA = %I64u\n", sizeof(sA));
//     printf("sizeof a = %I64u\n", sizeof(sA.a));
//     printf("sizeof b = %I64u\n", sizeof(sA.b));
//     printf("sizeof c = %I64u\n", sizeof(sA.c));
//     printf("sizeof d = %I64u\n", sizeof(sA.d));
//     printf("\n");
//     printf("sizeof sA2 = %I64u\n", sizeof(sA2));
//     printf("sizeof a = %I64u\n", sizeof(sA2.a));
//     printf("sizeof b = %I64u\n", sizeof(sA2.b));
//     printf("sizeof c = %I64u\n", sizeof(sA2.c));
//     printf("sizeof d = %I64u\n", sizeof(sA2.d));
//     printf("\n");
//     printf("sizeof B = %I64u\n", sizeof(Bs));
//     printf("sizeof a = %I64u\n", sizeof(Bs.a));
//     printf("sizeof b = %I64u\n", sizeof(Bs.b));
//     printf("sizeof c = %I64u\n", sizeof(Bs.c));
//     printf("\n");
//     printf("sizeof B = %I64u\n", sizeof(Bs2));
//     printf("sizeof a = %I64u\n", sizeof(Bs2.a));
//     printf("sizeof b = %I64u\n", sizeof(Bs2.b));
//     printf("sizeof c = %I64u\n", sizeof(Bs2.c));


// Zadanie 8

    uint8_t from[11]  = {1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12};
    uint8_t to[11] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};



for(size_t count = 1; count < 12; count++){
    secret(to, from, count);

    printf("count = %I64u => ", count);
    for(int i = 0; i < 11; i++){
        printf("%u ",to[i]);
        to[i] = 0;
    }
    printf("\n");
}
    


    /* Wyniki dla kolejnych wartości count i dla tablic 8-elementowych:
    count = 0 => 1 2 3 4 5 6 7 8 
    count = 1 => 1 0 0 0 0 0 0 0
    count = 2 => 1 2 0 0 0 0 0 0
    count = 3 => 1 2 3 0 0 0 0 0
    count = 4 => 1 2 3 4 0 0 0 0
    count = 5 => 1 2 3 4 5 0 0 0
    count = 6 => 1 2 3 4 5 6 0 0
    count = 7 => 1 2 3 4 5 6 7 0
    count = 8 => 1 2 3 4 5 6 7 8       
    */

   /* Wyniki dla kolejnych wartości count i dla tablic 11-elementowych:
    count = 0 =>  1 2 3 4 5 6 7 8  0  0  0 
    count = 1 =>  1 0 0 0 0 0 0 0  0  0  0
    count = 2 =>  1 2 0 0 0 0 0 0  0  0  0
    count = 3 =>  1 2 3 0 0 0 0 0  0  0  0
    count = 4 =>  1 2 3 4 0 0 0 0  0  0  0
    count = 5 =>  1 2 3 4 5 0 0 0  0  0  0
    count = 6 =>  1 2 3 4 5 6 0 0  0  0  0 
    count = 7 =>  1 2 3 4 5 6 7 0  0  0  0
    count = 8 =>  1 2 3 4 5 6 7 8  0  0  0
    count = 9 =>  1 2 3 4 5 6 7 8 10  0  0
    count = 10 => 1 2 3 4 5 6 7 8 10 11  0
    count = 11 => 1 2 3 4 5 6 7 8 10 11 12      
    */

    return 0;
}


