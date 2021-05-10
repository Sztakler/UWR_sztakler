#include <stdio.h>
#include <stdlib.h>

 struct kot
    {
        char *imie;
        int wiek;
        char *rasa;
    };

int main()
{
    struct kot burek, cezary;

    burek.imie = "Felix";
    burek.wiek = 5;
    burek.rasa = "Dachowiec";

    cezary.imie = "Cezary";
    cezary.wiek = 20;
    cezary.rasa = "Perski";


    printf("Imie:%s\nWiek:%d\nRasa:%s\n\n", burek.imie, burek.wiek, burek.rasa);
    printf("Imie:%s\nWiek:%d\nRasa:%s\n\n", cezary.imie, cezary.wiek, cezary.rasa);

    return 0;
}