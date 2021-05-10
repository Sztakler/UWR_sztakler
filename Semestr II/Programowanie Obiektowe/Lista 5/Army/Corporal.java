class Corporal extends Soldier
{
    protected String name;

    public Corporal(int identifier, String name)
    {
        super(identifier, 20);
        this.name = name;
    }

    public void display()
        {
            System.out.println("<Corporal> " +identifier + ": " + name);
        }
    
    @Override
    public String toString() 
    {
        return super.toString() + ": " + name;
    }
}