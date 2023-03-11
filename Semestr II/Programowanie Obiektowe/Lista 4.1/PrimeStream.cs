class PrimeStream : IStream
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