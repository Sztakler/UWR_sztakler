
abstract public class Operation extends Expression
{
    protected Expression left;
    protected Expression right;

    protected Operation(Expression left, Expression right)
    {
        this.left = left;
        this.right = right;
    }

    @Override
    public String toString() 
    {
        return super.toString();
    }
}