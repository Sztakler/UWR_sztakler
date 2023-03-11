using System;
using TIMENTON;

namespace Test3._2
{
    class Program
    {
        static void Main(string[] args)
        {
            TimeNTon a = TimeNTon.Instance();
            a.name = "Helium";
            Console.WriteLine(a.name);
            TimeNTon b = TimeNTon.Instance();
            b.name = "Neon";
            Console.WriteLine(b.name);
            TimeNTon c = TimeNTon.Instance();
            c.name = "Argon";
            Console.WriteLine(c.name);
            TimeNTon d = TimeNTon.Instance();
            d.name = "Krypton";
            Console.WriteLine(d.name);
            TimeNTon e = TimeNTon.Instance();
            Console.WriteLine(e.name);
            Console.WriteLine(b.name);
        }
    }
}
