
public class Vehicle {
    
    private int numberOfWheels;
    private int enginePower;
    private int seatingCapacity;

    public Vehicle()
    {
        this(0, 0, 0);
    }

    public Vehicle(int numberOfWheels, int enginePower, int seatingCapacity) {
        this.numberOfWheels = numberOfWheels;
        this.enginePower = enginePower;
        this.seatingCapacity = seatingCapacity;
    }

    public int getNumberOfWheels() {
        return numberOfWheels;
    }

    public int getEnginePower() {
        return enginePower;
    }

    public void setEnginePower(int enginePower) {
        this.enginePower = enginePower;
    }

    public int getSeatingCapacity() {
        return seatingCapacity;
    }

    public void setSeatingCapacity(int seatingCapacity) {
        this.seatingCapacity = seatingCapacity;
    }

    public void setNumberOfWheels(int numberOfWheels) {
        this.numberOfWheels = numberOfWheels;
    }
}