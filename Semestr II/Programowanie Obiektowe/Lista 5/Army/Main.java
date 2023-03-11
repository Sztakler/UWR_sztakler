import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class Main 
{
    public static void main(String[] args) 
    {
        // Trooper trooper = new Trooper(321543);
        // trooper.display();

        // Corporal corporal = new Corporal(315971, "Thomas");
        // corporal.display();

        // Sergant sergant = new Sergant(971321, "Jacob", "Hartman");
        // sergant.display();

        // List<Soldier> list = new ArrayList<>();
        
        // for (int i = 0; i < 5; i++)
        // {
        //     Corporal corporalN = new Corporal(i, "name");
        //     list.add(corporalN);

        //     Trooper trooperN = new Trooper(i);
        //     list.add(trooperN);

        //     Sergant sergantN = new Sergant(i, "name", "last name");
        //     list.add(sergantN);
        // }

        // for (int i = 0; i < 15; i++) list.get(i).display();
        // list.sort(Comparator.reverseOrder());
        // System.out.println();
        // for (int i = 0; i < 15; i++) list.get(i).display();

        Army<Soldier> army = new Army<Soldier>();

        for (int i = 0; i < 2; i++)
        {
            Corporal corporalN = new Corporal(i, "name");
            army.add(corporalN);

            Trooper trooperN = new Trooper(i);
            army.add(trooperN);

            Sergant sergantN = new Sergant(i, "name", "last name");
            army.add(sergantN);

            Lieutenant lieutenantN = new Lieutenant(i, "name", "last name", 44);
            army.add(lieutenantN);
        }

        army.writeCollection();
    }
}