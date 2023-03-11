import java.util.HashMap;
import java.util.Map;

public class Main 
{
    public static void main(String[] args) 
    {
        Map<String, Integer> map = new HashMap<>();
        map.put("x", 5);

        Expression dodawanko_z_mnozonkiem_i_zmienna = new Adding(new Multiplying(new Constant(2), new Multiplying(new Constant(2), new Variable("x"))), new Multiplying(new Constant(3), new Constant(2)));
        System.out.println(dodawanko_z_mnozonkiem_i_zmienna.evaluate(map));
        
        System.out.println(dodawanko_z_mnozonkiem_i_zmienna);
    
    }
}