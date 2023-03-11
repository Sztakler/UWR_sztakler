using System;


namespace Program
{
    class Vehicle : IDisplay 
    {
        private string name;

        public Vehicle(string n)
        {
            name = n;
        }
        public void display()
        {
            System.Console.WriteLine(name);
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
           Vehicle car_1 = new Vehicle("Opel Astra");
           car_1.display();
        }
    }




}