import javax.swing.JLabel;
import javax.swing.JPanel;
import java.awt.GridLayout;
import javax.swing.JSpinner;
import javax.swing.SpinnerNumberModel;

public class VehicleController extends JPanel
{
    private static final long serialVersionUID = 9115093207468414420L;

    private Vehicle vehicle;

    public VehicleController(Vehicle vehicle)
    {
        this.vehicle = vehicle;

        var layout = new GridLayout(3, 2, 20, 20);
        setLayout(layout);

        var spinnerWheels = new JSpinner(new SpinnerNumberModel());
        var spinnerEngine = new JSpinner(new SpinnerNumberModel());
        var spinnerSeats = new JSpinner(new SpinnerNumberModel());

        spinnerWheels.setValue(vehicle.getNumberOfWheels());
        spinnerEngine.setValue(vehicle.getEnginePower());
        spinnerSeats.setValue(vehicle.getSeatingCapacity());

        spinnerWheels.addChangeListener((event -> vehicle.setNumberOfWheels((int) spinnerWheels.getValue())));
        spinnerEngine.addChangeListener((event -> vehicle.setEnginePower((int) spinnerEngine.getValue()))); 
        spinnerSeats.addChangeListener((event -> vehicle.setSeatingCapacity((int) spinnerSeats.getValue())));
        

        add(new JLabel("Number of wheels"));
        add(spinnerWheels);
        add(new JLabel("Engine power"));
        add(spinnerEngine);
        add(new JLabel("Number of seats"));
        add(spinnerSeats);

        setVisible(true);
    }

    public Vehicle getVehicle()
    {
        return vehicle;
    }
}