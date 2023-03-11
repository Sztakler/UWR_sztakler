# Wykład 3 -- Algorytmy zachłanne


### Przykład 1 -- wydawanie reszty za pomocą minimalnej liczby monet

Przykładowy algorytm to wydawanie kolejno od największego nominału do najmniejszego. Takie rozwiązanie nie zawsze prowadzi do prawidłowego rozwiązania, np. dla zbioru monet {2, 5, 9, 10} chcemy wydać resztę z 8. Wybieramy największą możliwą resztę, tj. 5 i zostaje nam do wydania 8-5=3, którego nie możemy przedstawić monetami ze zbioru.

### Przypadek ogólny

Mamy dany skończony zbiór $C$ i rozwiązaniami są pewne podzbiory $C$. Znamy kryterium porównujące jakość rozwiązań i chcemy znaleźć rozwiązanie optymalne względem tego kryterium.


### Charakterystyka

Algorytmy zachłanne czasami działają lepiej, czasami gorzej, ale zwykle są proste w implementacji i jako pierwsze przychodzą do głowy. Czasami pojawiają się też sytuacje, w których nie interesuje nas algorytm w pełni poprawny, a jedynie wynik przybliżony, wystarczająco dobry dla naszych zastosowań, wtedy algorytmy zachłanne mogą okazać się przydatne. Może być też tak, że dany problem nie ma w ogóle rozwiązania wielomianowego.

Należy udowadniać, że algorytm zachłanny działa w sposób poprawny, lub zwraca wartość niewiele różną od optymalnej.

### Przykład 2 -- algorytmy Kruskala i Prima konstrukcji minimalnych drzew rozpinających

#### Dowód optymalności rozwiązania algorytmem Kruskala

Kruskal dał zbiór krawędzi {e1, e2, ..., en}.
Mamy potencjalnie więcej niż jedno rozwiązanie optymalne, bo może istnieć więcej niż jedno MST. Wybierzmy takie rozwiązanie OPT, że ma najdłuższy wspólny prefix z Kruskalem.

KRS = {e1 <= e2 <=... <= ek <= ... <= en}.
OPT = {e1' <= e2' <=... <= ek' <= ... <= en'} -- różni się od Kruskala na k-tej pozycji. 

Mamy trzy przypadki:

1. ek < ek' -- do drzewa optymalnego dodajemy ek, powstaje wtedy cykl c. Zauważmy, że cykl c musi zawierać krawędź cięższą niż ek i ek', ponieważ KRS i OPT zawierają krawędzie te same pierwsze k-1 krawędzi i nie zawierały cykli z ek i ek', zatem cykl musiała utworzyć jakaś krawędź ej j od k+1 do n. Wtedy możemy wyrzucić tę krawędź ej i powstanie drzewo bez cyklu o wadze mniejszej od OPT, zatem OPT nie był MST, co jest sprzeczne z zał., taki przypadek nie może zajść.
2. ek > ek' -- Kruskal dodaje krawędzie w kolejności rosnących wag. Dodał krawędzie od e1 do ek-1, zatem mógłby dodać ek', bo nie zespsułoby to struktury drzewa, w końcu OPT zawiera ten sam prefix co KRS i krawędź ek'. ek > ek', zatem ten przypadek nie może zajść, Kruskal dodałby do rozwiązania ek' zamiast ek.
3. ek = ek' -- dorzucamy ek do OPT, powstał cykl. Ponownie, cykl musi byc z krawędzią ei po prawej stronie od k. Zauważmy, że krawędzie po prawej mogą mieć te wame wagi co ek=ek', zatem wyrzućmy ek'. Teraz mamy znowu drzewo o tej samej wadze co OPT, ale nowe drzewo i KRS mają dłuższy wsþólny prefix niż OPT, ale OPT miało maksymalny wspólny prefix, więc to nie zachodzi.

Zatem Kruskal musi zwracać rozwiązanie optymalne.

### Przykład 3 -- algorytm Boruvki

Po każdym kroku Boruvkarz daje las drzewek, co krok ten las zawiera coraz mniej drzew, aż w końcu otrzymamy jedno drzewo -- MST. Dowód optymalności przebiega podobnie jak u Kruskala i Prima.

Problem z tym algorytmem pojawia się, gdy istnieją krawędzie o tej samej wadze, wtedy mogą powstać cykle. W takim wypadku możemy dodać indeksy dla krawędzi o tej samej wadze i dobierać te o minimalnym indeksie.

Boruvkarz przebiega w <= log(n) fazach. Czemu? Każdy wierzchołek zostaje podłączony do jakiegoś drzewa w danej fazie, stąd liczba krawędzi maleje o połow≥ę co krok.

### Problemy NP-trudne


