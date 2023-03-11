import javax.swing.JLabel;
import javax.swing.JPanel;
import java.awt.GridLayout;
import javax.swing.JSpinner;
import javax.swing.JTextField;
import javax.swing.SpinnerNumberModel;

public class TramController extends JPanel
{
    private static final long serialVersionUID = -5946322984003725410L;

    private Tram tram;

    public TramController(Tram tram)
    {
        this.tram = tram;

        var layout = new GridLayout(2, 2, 20, 20);
        setLayout(layout);

        var spinnerWheels = new JSpinner(new SpinnerNumberModel());
        var spinnerEngine = new JSpinner(new SpinnerNumberModel());
        var spinnerSeats = new JSpinner(new SpinnerNumberModel());
        var spinnerNumber = new JSpinner(new SpinnerNumberModel());

        spinnerWheels.setValue(tram.getNumberOfWheels());
        spinnerEngine.setValue(tram.getEnginePower());
        spinnerSeats.setValue(tram.getSeatingCapacity());
        spinnerNumber.setValue(tram.getNumber());

        spinnerWheels.addChangeListener((event -> tram.setNumberOfWheels((int) spinnerWheels.getValue())));
        spinnerEngine.addChangeListener((event -> tram.setEnginePower((int) spinnerEngine.getValue()))); 
        spinnerSeats.addChangeListener((event -> tram.setSeatingCapacity((int) spinnerSeats.getValue())));
        spinnerNumber.addChangeListener((event -> tram.setNumber((int) spinnerNumber.getValue())));
        
        var textFieldMotorman = new JTextField();
        var textFieldCity = new JTextField();

        textFieldMotorman.setText(tram.getMotormanName());
        textFieldCity.setText(tram.getCityName());

        textFieldMotorman.addCaretListener(event -> tram.setMotormanName(textFieldMotorman.getText()));
        textFieldCity.addCaretListener(event -> tram.setCityName(textFieldCity.getText()));

        add(new JLabel("Number of wheels"));
        add(spinnerWheels);
        add(new JLabel("Engine power"));
        add(spinnerEngine);
        add(new JLabel("Number of seats"));
        add(spinnerSeats);
        add(new JLabel("Tram number"));
        add(spinnerNumber);
        add(new JLabel("Motorman"));
        add(textFieldMotorman);
        add(new JLabel("City"));
        add(textFieldCity);
        setVisible(true);
    }

    public Tram getTram()
    {
        return tram;
    }
}