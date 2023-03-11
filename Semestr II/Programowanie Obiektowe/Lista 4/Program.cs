using System;
using Lista_2_LazyList;

namespace Lista_2
{
class IntStream
{
    protected int value;
    virtual public int next()
    {   
        if (!this.eos())
        {
            value++;
            return value-1;
        }
        return value;
    }

    public IntStream()
    {
        value = int.MaxValue-10;
    }
    virtual public bool eos()
    {

        return value > int.MaxValue;
    }

    virtual public void reset()
    {
        value = 0;
    }
}

class PrimeStream:IntStream
    {
        public PrimeStream()
        {
            value = 1;
        }

        public bool isPrime(int number)
        {
            double limit = System.Math.Sqrt(number);
            for (int i = 2; i <= limit; i++)
            {
                if (number % i == 0)
                {
                    return false;
                }
            }
            return true;
        }

        public override int next()
        {
            if (eos())
            {
                return value;
            }
        
            value++;
            while (!isPrime(value))
            {
                value++;
            }
            return value;
        }

        public override bool eos()
        {
            return value == 2147483647;
        }

        public override void reset()
        {
            value = 1;
        }
    }
        

class RandomStream:IntStream
        {
            Random random = new Random();
        
        public override int next()
        {
            return random.Next();
        }

        public override bool eos()
        {
            return false;
        }

        public override void reset()
        {

        }
        }

class RandomWordStream
        {
            PrimeStream length = new PrimeStream();
            RandomStream character = new RandomStream();
            string random_word = "";

            public RandomWordStream()
            {
                length.next();
                for (int i = 1; i <= 2; i++)
                {   
                
                random_word += Convert.ToChar(character.next()%58+65);
                }
            }
            

            public string next()
            {
                int prime_length = length.next();
                string old_stream=random_word;
                for (int i = random_word.Length; i < prime_length; i++)
                {
                    random_word += Convert.ToChar(character.next()%58+65);
                }

                return old_stream; 
            }
        }

class Program
{
    static void Main(string[] args)
    {
        IntStream newInt = new IntStream();
        PrimeStream newPrime = new PrimeStream();
        RandomStream newRandom = new RandomStream();
        
        // while (!newInt.eos())
        // {
        //     Console.WriteLine(newInt.next());
        // }   
        // newInt.reset();     
        // Console.WriteLine(newInt.next());
          
        // for (int i = 0; i < 5; i++)
        // {
        //     Console.WriteLine(newPrime.next());
        // }   
        // Console.WriteLine(newPrime.next());
        // newPrime.reset(); 
        // Console.WriteLine(newPrime.next());

        // Console.WriteLine(newRandom.next());
        // Console.WriteLine(newRandom.next());
        // Console.WriteLine(newRandom.next());
        // newRandom.reset();
        // Console.WriteLine(newRandom.next());

        RandomWordStream word = new RandomWordStream();
        for (int i = 0; i < 10; i++)
        {
        Console.WriteLine(word.next());
        }

        PrimeList newPrimeList = new PrimeList();
        for (int i = 1; i < 10; i++)
        {
            Console.WriteLine(newPrimeList.element(i));
        }

        RandomList newRandomList = new RandomList();
        for (int i = 1; i < 10; i++)
        {
            Console.WriteLine(newRandomList.element(i));
        }
        
    }
}

}