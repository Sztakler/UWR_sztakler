import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;
import java.util.Objects;

class RingList<T> implements Serializable, Collection<T> {

    static class Element<T> implements Serializable {
        public T value;
        public Element<T> next;
        public Element<T> prev;

        public Element() {
            this.value = null;
            this.next = this;
            this.prev = this;
        }
    }

    Element<T> element;

    public RingList() {
        this.element = new Element<T>();
    }


    public void AddAtBeggining(T value) {
        Element<T> e = new Element<T>();
        e.next = this.element.next;
        e.prev = this.element;
        this.element.next.prev = e;
        this.element.next = e;
        e.value = value;
    }

    public void AddAtEnd(T value) {
        Element<T> e = new Element<T>();
        e.next = this.element;
        e.prev = this.element.prev;
        this.element.prev.next = e;
        this.element.prev = e;
        e.value = value;
    }

    public Element<T> RemoveFirst() {
        Element<T> removed = this.element.next;
        this.element.next.next.prev = this.element;
        this.element.next = this.element.next.next;
        return removed;
    }

    public Element<T> RemoveLast() {
        Element<T> removed = this.element.prev;
        this.element.prev.prev.next = this.element;
        this.element.prev = this.element.prev.prev;
        return removed;
    }

    public void WriteRingList() {
        System.out.println("Elements in a RingList:");
        Element<T> start = this.element;
        Element<T> curr = this.element;

        if (start == null) 
        {
            System.out.println(0);
            return;
        }

        while (curr.next != start)
        {
            System.out.println(curr.next.value);
            curr = curr.next;
        }
    }

    @Override
    public int size() {
        int size = 0;
        Element<T> start = this.element;
        Element<T> curr = this.element;
        while (curr.next != start) {
            size++;
            curr = curr.next;
        }

        return size;
    }

    @Override
    public boolean add(T arg0) {
        this.AddAtBeggining(arg0);
        return true;
    }

    @Override
    public boolean addAll(Collection<? extends T> arg0) {
    
        for (T element : arg0) 
        {
            this.add(element);
        }
        return true;
    }

    @Override
    public void clear() {
        this.element.next = this.element;
        this.element.prev = this.element;
    }

    @Override
    public boolean contains(Object arg0) {
        for (T value : this) {
            if (arg0 == value) return true;
        }
        return false;
    }

    @Override
    public boolean containsAll(Collection<?> arg0) {
        for (Object object : arg0) {
            if (this.contains(object) == false) return false;
        }
        return true;
    }

    @Override
    public boolean isEmpty() {
        return this.element == null;
    }

    @Override
    public Iterator<T> iterator() {
        return new RingListIterator<T>(this);
    }

    @Override
    public boolean remove(Object arg0) {
        Element<T> curr = this.element.next;
        Element<T> start = this.element;

        while (curr != start)
        {
            if(Objects.equals(curr.value, arg0))
            {
            curr.prev.next = curr.next;
            curr.next.prev = curr.prev;
            return true;
            }
 
            curr = curr.next;
        }
        
        return true;
    }

    @Override
    public boolean removeAll(Collection<?> arg0) {
        for (Object object : arg0) {
            this.remove(object);
        }
        return false;
    }

    @Override
    public boolean retainAll(Collection<?> arg0) {
        for (Object element : this) {
            if (!arg0.contains(element)) this.remove(element); 
        }
        return false;
    }

    @Override
    public Object[] toArray() {
        var arr = new Object[this.size()];
        int i = 0;

        for (T value : this) {
            arr[i] = value;
            i++;
        }
        return arr;
    }

    @Override
    public <U> U[] toArray(U[] arg0) {
        if (this.size() > arg0.length)
            {
                arg0 = Arrays.copyOf(arg0, this.size());
            }
        
        int i = 0;

        for (T value : this) {
            arg0[i] = (U)value;
            i++;
        }
        return arg0;
    }

    private static class RingListIterator<T> implements Iterator<T>
    {
        Element<T> curr;
        Element<T> start;

        public RingListIterator(RingList<T> L)
        {
            curr = L.element.next;
            start = L.element;
        }
        
        public boolean hasNext()
        {
            return start != curr;
        }

        public T next()
        {
            var value = curr.value;
            curr = curr.next;
            return value;
        }
        
    }

    
    private void writeObject(ObjectOutputStream s) throws IOException {

        
        s.writeInt(this.size());
        for (T value : this) {
            s.writeObject(value);
        }
    }

    private void readObject(ObjectInputStream s) throws IOException, ClassNotFoundException {

        this.element = new Element<T>();
        int size = s.readInt();
        for (int i = 0; i < size; i++) {
            var val = (T)s.readObject();
            this.add(val);
        }
        
    }
}

