using System.Collections.Generic;
using Lista_2;

namespace Lista_2_LazyList
{
class LazyList
{
    public List<int> lazy_list = new List<int>();

    virtual public int element(int i)
    {
        while (size() < i)
        {
            lazy_list.Add(0);
        }

        return lazy_list[i-1];
    }

    public int size()
    {
        return lazy_list.Count;
    }
}

class PrimeList : LazyList
{
    private PrimeStream prime = new PrimeStream();
    override public int element(int i)
    {
        while (size() < i)
        {
            lazy_list.Add(prime.next());
        }
        return lazy_list[i-1];
    }
}

class RandomList : LazyList
{
    private RandomStream random = new RandomStream();
    override public int element(int i)
    {
        while (size() < i)
        {
            lazy_list.Add(random.next());
        }
        
        return lazy_list[i-1];
    }
}
}