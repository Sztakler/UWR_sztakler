
public class Marsupial 
{
    private Marsupial pouchContent;
    private String name;
    private int age;

    public Marsupial()
    {
       this(null, "", 0);
    }

    public Marsupial(Marsupial pouchContent, String name, int age)
    {
        this.pouchContent = pouchContent;
        this.name = name;
        this.age = age;
    }
}