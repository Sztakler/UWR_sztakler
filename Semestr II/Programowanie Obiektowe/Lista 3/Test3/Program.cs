﻿using System;
using Dictionary;
using Pair;

namespace Testowanko
{
    class Program
    {
        static void Main(string[] args)
        {
            Pair<int, int> p1 = new Pair<int, int>(0,10);
            Pair<int, int> p2 = new Pair<int, int>(1,20);
            Pair<int, int> p3 = new Pair<int, int>(2,30);
            Pair<int, int> p4 = new Pair<int, int>(1,40);
            Dictionary<int, int> d1 = new Dictionary<int, int>();
            Console.WriteLine("Displaying dictionary:");
            d1.add(p1);
            d1.add(p2);
            d1.add(p3);
            d1.display();
            Console.WriteLine("Trying to assign value to existing key:");
            d1.add(p4);
            d1.display();
            
            Console.WriteLine("Finding value of key '2':");
            System.Console.WriteLine(d1.find(0).second);
            Console.WriteLine("Before removing value of key '2':");
            d1.display();
            d1.remove(2);
            // Console.WriteLine("After:");
            // d1.display();
            Console.WriteLine("Finding non-existing element:");
            Console.WriteLine(d1.find(2));
            d1.display();
 
        }
    }
}