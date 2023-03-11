import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class Army<T extends Comparable<T>>
{
    private List<T> army = new ArrayList<>();

    public void add(T soldier)
    {
        army.add(soldier);
        army.sort(Comparator.reverseOrder());
    }

    public T remove()
    {
        T result = army.get(0);
        army.remove(army.get(0));
        return result;
    }

    public void writeCollection()
    {
        for(int i = 0; i < army.size(); i++)
        {
            System.out.println(army.get(i).toString());
        }
    }
}









// public class Army<T extends Comparable<T>>
// {
//     Army<T> next;
//     T value;
    
//     public Army()
//     {
//         this.next = null;
//         this.value = null;
//     }

//     private Army(T soldier)
//     {
//         this.next = null;
//         this.value = soldier;
//     }

//     void add(T soldier)
//     {   
//         if (this.next == null) this.value = soldier;
//         else if (soldier.compareTo(this.value) == -1) 
//         {
//             Army<T> s = new Army<T>(soldier);
//             s.next = this.next;
//             this.next = s;
//             System.out.println(4);
//         }
//         else 
//         {
//             this.next.add(soldier);
//             System.out.println(5);
//         }
//     }

//     T remove(T soldier)
//     {
//         T result = this.next.value;

//         this.next = this.next.next;

//         return result;
//     }

//     void writeCollection()
//     {
//         System.out.println(0);
//         if (this.next != null) 
//         {
//             System.out.println(1);
//             this.next.writeCollection();
//         }
//         else 
//         {
//             System.out.println(1);
//             return;
//         }
//     }
// }