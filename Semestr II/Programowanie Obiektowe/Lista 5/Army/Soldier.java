public abstract class Soldier implements Comparable<Soldier>
{
    protected int identifier;
    private double rankPower;

    public Soldier(int identifier, double rankPower)
    {
        this.identifier = identifier;
        this.rankPower = rankPower;
    }

    public void display()
    {}

    public int compareTo(Soldier soldier)
    {
        if (this.rankPower == soldier.rankPower) return 0;
        else if (this.rankPower < soldier.rankPower) return 1;
        else return -1;
    }

    @Override
    public String toString() 
    {
        return rankPower + ", " + identifier;
    }
}

