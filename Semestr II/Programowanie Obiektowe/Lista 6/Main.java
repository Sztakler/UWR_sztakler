import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) throws IOException, ClassNotFoundException
    {
        RingList<Integer> l1 = new RingList<>();
        
        System.out.println(l1.size());
        l1.add(1);
        l1.WriteRingList();
        
        l1.addAll(List.of(1, 2, 3, 4, 5));
        l1.WriteRingList();

        l1.clear();
        l1.WriteRingList();

        l1.addAll(List.of(1, 2, 3, 4, 5));
        System.out.println(l1.contains(4));

        System.out.println(l1.containsAll(List.of(1, 2, 3, 4, 5, 6)));

        System.out.println(l1.isEmpty());

        l1.WriteRingList();
        l1.remove(1);
        l1.WriteRingList();
        l1.removeAll(List.of(1, 2, 3));
        l1.WriteRingList();

        l1.addAll(List.of(1, 2, 3));
        l1.retainAll(List.of(1, 2, 3));
        l1.WriteRingList();
        
        System.out.println(Arrays.toString(l1.toArray())); 
        System.out.println(Arrays.toString(l1.toArray(new Object[0]))); 


        FileOutputStream fos = new FileOutputStream("RingList.bin");
        ObjectOutputStream oos = new ObjectOutputStream(fos);

        RingList<Integer> l2 = new RingList<>();
        l2.addAll(List.of(0,1,2,3,4,5,6,7));
        oos.writeObject(l2);
        
        FileInputStream fis = new FileInputStream("RingList.bin");
        ObjectInputStream ois = new ObjectInputStream(fis);
        
        RingList<Integer> newRingList = (RingList<Integer>) ois.readObject();

        newRingList.WriteRingList();
    }
}