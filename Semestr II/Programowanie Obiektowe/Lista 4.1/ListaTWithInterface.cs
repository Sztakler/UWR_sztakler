namespace RingListButWithinterface
{
class Element<T>
{
    public T value;
    public Element<T> next;
    public Element<T> prev;

    public Element()
    {
        this.value = default(T);
        this.next = this;
        this.prev = this;
    }

    public Element(T value)
    {
        this.value = value;
        this.next = this;
        this.prev = this;
    }
}

class List<T> : ICollection<Element<T>>
{
    Element<T> element;

    public List()
    {
      this.element = new Element<T>();  
    }

    public void Add(Element<T> element)
    {
        Element<T> e = new Element<T>();
        e.next = this.element.next;
        e.prev = this.element;
        this.element.next.prev = e;
        this.element.next = e;
        e.value = element.value;
    }

    public void AddAtEnd(T value)
    {
        Element<T> e = new Element<T>();
        e.next = this.element;
        e.prev = this.element.prev;
        this.element.prev.next = e;
        this.element.prev = e;
        e.value = value;
    }

    public Element<T> Remove(Element<T> doNotTouchThis)
    {   
        Element<T> removed = this.element.next;
        this.element.next.next.prev = this.element;
        this.element.next = this.element.next.next;
        return removed;
    }

    public Element<T> RemoveLast()
    {
        Element<T> removed = this.element.prev;
        this.element.prev.prev.next = this.element;
        this.element.prev = this.element.prev.prev;
        return removed;
    }

    public void Display()
    {
        System.Console.WriteLine("Elements in a list:");
        System.Console.WriteLine(this.element.next.value);
        System.Console.WriteLine(this.element.prev.value);
    }
}
}