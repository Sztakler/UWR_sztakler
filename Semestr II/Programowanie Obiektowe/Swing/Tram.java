
public class Tram extends Vehicle {
    
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