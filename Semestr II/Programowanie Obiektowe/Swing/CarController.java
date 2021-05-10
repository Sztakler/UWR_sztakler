import javax.swing.JPanel;
import java.awt.GridLayout;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;

import javax.swing.JSpinner;
import javax.swing.SpinnerNumberModel;
import javax.swing.JTextField;
import javax.swing.JLabel;

public class CarController extends JPanel
{
    private static final long serialVersionUID = -2919561412628566825L;
    
    private Car car;

    public CarController(Car car)
    {
        this.car = car;

        var layout = new GridLayout(2, 2, 20, 20);
        setLayout(layout);

        var spinnerWheels = new JSpinner(new SpinnerNumberModel());
        var spinnerEngine = new JSpinner(new SpinnerNumberModel());
        var spinnerSeats = new JSpinner(new SpinnerNumberModel());

        spinnerWheels.setValue(car.getNumberOfWheels());
        spinnerEngine.setValue(car.getEnginePower());
        spinnerSeats.setValue(car.getSeatingCapacity());

        spinnerWheels.addChangeListener((event -> car.setNumberOfWheels((int) spinnerWheels.getValue())));
        spinnerEngine.addChangeListener((event -> car.setEnginePower((int) spinnerEngine.getValue()))); 
        spinnerSeats.addChangeListener((event -> car.setSeatingCapacity((int) spinnerSeats.getValue())));
        
        var textFieldBrand = new JTextField();
        var textFieldModel = new JTextField();
        var textFieldType = new JTextField();

        textFieldBrand.setText(car.getBrand());
        textFieldModel.setText(car.getModel());
        textFieldType.setText(car.getType());

        textFieldBrand.addCaretListener(event -> car.setBrand(textFieldBrand.getText()));
        textFieldModel.addCaretListener(event -> car.setModel(textFieldModel.getText()));
        textFieldType.addCaretListener(event -> car.setType(textFieldType.getText()));

        add(new JLabel("Number of wheels"));
        add(spinnerWheels);
        add(new JLabel("Engine power"));
        add(spinnerEngine);
        add(new JLabel("Number of seats"));
        add(spinnerSeats);
        add(new JLabel("Brand"));
        add(textFieldBrand);
        add(new JLabel("Model"));
        add(textFieldModel);
        add(new JLabel("Type"));
        add(textFieldType);
        setVisible(true);
    }

    public Car getCar()
    {
        return car;
    }


	// private void save(ActionEvent event) {
	// 	try (var fos = new FileOutputStream(this.file); var oos = new ObjectOutputStream(fos)) {
	// 		var wombat = this.controller.getWombat();
	// 		oos.writeObject(wombat);
	// 	} catch (IOException exception) {
	// 		exception.printStackTrace();
	// 	}
	// }
    
}