import java.util.Map;

public class Constant extends Expression
{
    int value;

    public Constant(int value)
    {
        this.value = value;
    } 

    public int evaluate(Map<String, Integer> map)
    {
        return this.value;
    }

    @Override
    public String toString() 
    {
        return String.valueOf(value);
    }
}