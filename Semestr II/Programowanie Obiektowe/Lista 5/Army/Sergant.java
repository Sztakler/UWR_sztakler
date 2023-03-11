
public class Sergant extends Soldier
{   
    protected String name;
    protected String lastName;

    public Sergant(int identifier, String name, String lastName)
    {
        super(identifier, 30d);
        this.name = name;
        this.lastName = lastName;
    }

    public void display()
        {
            System.out.println("<Sergant> " +identifier + ": " + name + " " + lastName);
        }

    @Override
    public String toString() 
    {
        return super.toString() + ": " + name + " " + lastName;
    }
}