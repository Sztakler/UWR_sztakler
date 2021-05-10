
public class Tram extends Vehicle {

    private static final long serialVersionUID = -5441728791396950294L;
    
    private int number;
    private String motormanName;
    private String cityName;

    public Tram()
    {
        this(0, 0, 0, 0, "", "");
    }

    public Tram(int numberOfWheels, int enginePower, int seatingCapacity, int number, String motormanName,
            String cityName) {
        super(numberOfWheels, enginePower, seatingCapacity);
        this.number = number;
        this.motormanName = motormanName;
        this.cityName = cityName;
    }

    @Override
    public String toString()
    {
        return super.toString() + ", " + number + ", " + motormanName + ", " + cityName;
    }

    public int getNumber() {
        return number;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getMotormanName() {
        return motormanName;
    }

    public void setMotormanName(String motormanName) {
        this.motormanName = motormanName;
    }

    public void setNumber(int number) {
        this.number = number;
    }

}