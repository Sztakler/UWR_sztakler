import java.util.Map;

public class Adding extends Operation
{

    public Adding(Expression left, Expression right)
    {
        super(left, right);
    }

    public int evaluate(Map<String, Integer> map)
    {
        return left.evaluate(map) + right.evaluate(map);
    }

    @Override
    public String toString() 
    {
        return "(" + left.toString() + " + " + right.toString() + ")";
    }
}