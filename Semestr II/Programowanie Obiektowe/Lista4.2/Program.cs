using System;
using PrimeCollections;

namespace Lista4._2
{
    class Program
    {
        static void Main(string[] args)
        {
            PrimeCollection pc = new PrimeCollection();
            foreach (int p in pc) 
            {
               Console.WriteLine(p);
            }
        }
    }
}
