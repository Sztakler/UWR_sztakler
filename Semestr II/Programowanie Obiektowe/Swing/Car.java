
public class Car extends Vehicle {
    
    private String brand;
    private String model;
    private String type;

    public Car()
    {
        this(0, 0, 0, "", "", "");
    }

    public Car(int numberOfWheels, int enginePower, int seatingCapacity, String brand, String model, String type) {
        super(numberOfWheels, enginePower, seatingCapacity);
        this.brand = brand;
        this.model = model;
        this.type = type;
    }

    public String getBrand() {
        return brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

}