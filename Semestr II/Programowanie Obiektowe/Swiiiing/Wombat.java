public class Wombat {
    public static final int numberOfNipples = 2;

    private int teeth;
    private int cecumLength;
    private String favouritePapoo;

    public Wombat()
    {
       this(0, 0, "");
    }

    public Wombat(int teeth, int cecumLength, String favouritePapoo) {
        this.setTeeth(teeth);
        this.setCecumLength(cecumLength);
        this.setFavouritePapoo(favouritePapoo);
    }

    public String getFavouritePapoo() {
        return favouritePapoo;
    }

    public void setFavouritePapoo(String favouritePapoo) {
        this.favouritePapoo = favouritePapoo;
    }

    public int getCecumLength() {
        return cecumLength;
    }

    public void setCecumLength(int cecumLength) {
        this.cecumLength = cecumLength;
    }

    public int getTeeth() {
        return teeth;
    }

    public void setTeeth(int teeth) {
        this.teeth = teeth;
    }


    
}