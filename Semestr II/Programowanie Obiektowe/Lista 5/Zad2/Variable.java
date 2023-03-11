import java.util.Map;

public class Variable extends Expression
{
    String name;

    public Variable(String name)
    {
        this.name = name;
    }

    public int evaluate(Map<String, Integer> map)
    {
        return map.get(this.name);
    }

    @Override
    public String toString() 
    {
        return this.name;
    }
}