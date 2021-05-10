
public class Lieutenant extends Soldier
{   
    protected String name;
    protected String lastName;
    protected int bootSize;

    public Lieutenant(int identifier, String name, String lastName, int bootSize)
    {
        super(identifier, 40d);
        this.name = name;
        this.lastName = lastName;
        this.bootSize = bootSize;
    }

    public void display()
        {
            System.out.println("<Lieutenant> " +identifier + ": " + name + " " + lastName + " Size of boot: " + bootSize);
        }

    @Override
    public String toString() 
    {
        return super.toString() + ": " + name + " " + lastName + " " + bootSize;
    }
}