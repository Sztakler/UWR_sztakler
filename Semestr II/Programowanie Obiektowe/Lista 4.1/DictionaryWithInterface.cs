using System;
using System.Collections;

namespace DictionaryButWithInterface
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

       public override string ToString()
       {
           return this.first + " : " + this.second;
       }
    }

public class Dictionary<K,V> : ICollection<Pair<K,V>>, IEnumerable where K: IComparable<K> 
{
        public Dictionary<K,V> next;
        public Pair<K,V> pair;
        static int length;

       public int Length
        {
           get
           {
               return Dictionary<K,V>.length;
           }
        }
        public Dictionary(){this.next = null; length = 0;}

        private Dictionary(Pair<K,V> pair)
        {
            this.pair = pair;
            this.next = null;
        }

        public void Add(Pair<K,V> pair)
        {
            if (this.next == null)
            {
                next = new Dictionary<K,V>(pair);
                length++;
                return;
            }
            if (this.next.pair.first.CompareTo(pair.first) == 0)
            {
                System.Console.WriteLine("Key '{0}' already has assigned value!", pair.first);
                return;
            }
            else this.next.Add(pair);
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

        public Pair<K,V> Remove(Pair<K,V> but_actually_only_key)
        {
            var key = but_actually_only_key.first;
            if (this.pair != null && this.next.pair.first.CompareTo(key) == 0)
            {
                length--;
                this.next = this.next.next;
                return this.next.pair;
            }

            else if (this.next != null)
            {
                return this.next.Remove(but_actually_only_key);
            }

            else return null;
        }

        public void Display()
        {
            if (this.pair != null) 
            {
                System.Console.WriteLine("{0}, {1}", this.pair.first, this.pair.second);
            }

            if (this.next != null) this.next.Display();
        }

        public IEnumerator GetEnumerator()
        {
            return new DictionaryEnumerator<K,V>(this.next, this.pair);
        }

        public override string ToString()
        {
            string result ="";

            foreach(Pair<K,V> pair in this)
            {
                result += pair.ToString() + "\n";
            }

            return result;
        }

        public Pair<K,V> this[int indeks]
    {
        get 
        {
            if (indeks == 0) return this.pair;
            return this.next[indeks - 1];
        }
    }
    }

public class DictionaryEnumerator<K,V> : IEnumerator where K : IComparable<K>
    {
        private Dictionary<K,V> next;
        private Pair<K,V> pair;
        private Dictionary<K,V> start;

        public DictionaryEnumerator(Dictionary<K,V> next, Pair<K,V> pair)
        {
            this.next = next;
            this.pair = pair;
            this.start = next;
        }
        public object Current => this.pair;

        public bool MoveNext()
        {
            if (this.next == null) return false;
            this.pair = this.next.pair;
            this.next = this.next.next;
            return true;
        }

        public void Reset()
        {
            this.next = start;
            this.pair = start.pair;
        }
    }
}