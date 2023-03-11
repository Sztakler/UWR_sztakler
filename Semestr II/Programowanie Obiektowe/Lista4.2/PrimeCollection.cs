using System.Reflection;
using System.Runtime.ConstrainedExecution;
using System.Collections;

namespace PrimeCollections
{

class PrimeNumber
{
    public int value;
    
    
    public PrimeNumber(int value)
    {
        this.value = value;
    }
}
class PrimeCollection : IEnumerable
{


    public PrimeCollection(){}



    public IEnumerator GetEnumerator()
    {
        return new PrimeCollectionEnumerable();
    }
}

class PrimeCollectionEnumerable : IEnumerator
    {
        PrimeNumber start;
        PrimeNumber number;
        public PrimeCollectionEnumerable()
        {
            this.number = new PrimeNumber(1);
            this.start = this.number;
        }
        public object Current => this.number.value;

        public bool isPrime(int number)
        {
            for (int i = 2; i*i <= number; i++)
            {
                if (number % i == 0)
                {
                    return false;
                }
            }
            return true;
        }

        public bool MoveNext()
        {
            
            if (this.number.value != int.MaxValue)
            {
                int candidate = this.number.value+1;
                while (!isPrime(candidate))
                {
                    if (candidate == int.MaxValue) 
                    {
                        number = new PrimeNumber(candidate);
                        return true;
                    }

                    candidate++;

                    if (candidate < 0) return false;
                }
                number = new PrimeNumber(candidate);
                return true;
            }
            return false;
        }

        public void Reset()
        {
            this.number = new PrimeNumber(1);
        }
    }
}