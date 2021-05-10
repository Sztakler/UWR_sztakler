using System;


namespace Dictionary
{
    public class Pair<K, V>
    {
       public K first;
       public V second;

       public Pair(){}
       public Pair(K first, V second)
       {
           this.first = first;
           this.second = second;
       }
    }

    public class Dictionary<K,V> where K: IComparable<K>
    {

        private Dictionary<K,V> next;
        private Pair<K,V> pair;

        public Dictionary(){this.next = null;}

        private Dictionary(Pair<K,V> pair)
        {
            this.pair = pair;
            this.next = null;
        }

        public void add(Pair<K,V> pair)
        {
            if (this.next == null)
            {
                next = new Dictionary<K,V>(pair);
                return;
            }
            if (this.next.pair.first.CompareTo(pair.first) == 0)
            {
                System.Console.WriteLine("Key '{0}' already has assigned value!", pair.first);
                return;
            }
            else this.next.add(pair);
        }

        public Pair<K,V> find(K key)
        {
            if (this.pair != null && this.pair.first.CompareTo(key) == 0) 
            {
                return this.pair;
            }

            else if (this.next != null) 
            {
                return this.next.find(key);
            }

            else return null;
        }

        public void remove(K key)
        {
            if (this.pair != null && this.next.pair.first.CompareTo(key) == 0)
            {
                this.next = this.next.next;
            }

            else if (this.next != null)
            {
                this.next.remove(key);
            }

            else return;
        }

        public void display()
        {
            if (this.pair != null) 
            {
                System.Console.WriteLine("{0}, {1}", this.pair.first, this.pair.second);
            }

            if (this.next != null) this.next.display();
        }
    }
}
