import java.util.Map;

public abstract class Expression 
{
    public abstract int evaluate(Map<String, Integer> map);

    @Override
    public String toString() 
    {
        return "";
    }
}