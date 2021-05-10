using System;
using DictionaryButWithInterface;
using RingListButWithinterface;

namespace Lista_4._1
{

class Program
{
    static void Main(string[] args)
    {
        Dictionary<int, int> dict = new Dictionary<int, int>();

        // Wypełnianie słownika
        for (int i = 0; i < 10; i++)
        {
            var p = new Pair<int, int>(i + 1,2 * (i + 1));
            dict.Add(p);
        }

        // Enumarator
        foreach (Pair<int, int> p in dict)
        {
            System.Console.WriteLine(p.first + ", " + p.second);
        }

        // Zamiana słownika na string
        System.Console.WriteLine(dict.ToString());

        // Dostęp indeksowany
        for (int i = 1; i < 11; i++)
        {
            Pair<int, int> p = dict[i];
            if (p != null) System.Console.WriteLine("Para " + i + ": " + p.first + " : " + p.second);
        }

        // Właściwość Length

        System.Console.WriteLine("Długość słownika: " + dict.Length);

//////////////////////////////////////////////////////////////

        // Tworzenie listy
        List<int> l = new List<int>();

        // Wypełnianie listy
        for (int i = 0; i < 10; i++)
        {
            Element<int> e = new Element<int>(i);
            l.Add(e);
            l.Display();
        }
    }
}
}