import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import javax.swing.JButton;
import javax.swing.*;
import java.awt.event.ActionEvent;

public class Window extends JFrame
{
    private static final long serialVersionUID = -8255319694373975038L;

    private File carFile = null;
    private File tramFile = null;
    private File vehicleFile = null;
    private CarController carController = null;
    private TramController tramController = null;
    private VehicleController vehicleController = null;

    public Window(String fileName, String className)
    {
        var topPanel = new JPanel();

        var buttonSave = new JButton("Save");

        switch (className)
        {
            case "Car":
            {   this.carFile = new File(fileName);
                var car = getCar(carFile);
                this.carController = new CarController(car);
                topPanel.add(carController);
                buttonSave.addActionListener(this::saveCar);
                System.out.println(car.toString());
                break;
            }
            case "Tram":
            {
                this.tramFile = new File(fileName);
                var tram = getTram(tramFile);
                this.tramController = new TramController(tram);
                topPanel.add(tramController);
                buttonSave.addActionListener(this::saveTram);
                System.out.println(tram.toString());
                break;
            }
            case "Vehicle":
            {
                this.vehicleFile = new File(fileName);
                var vehicle = getVehicle(vehicleFile);
                this.vehicleController = new VehicleController(vehicle);
                topPanel.add(vehicleController);
                buttonSave.addActionListener(this::saveVehicle);
                System.out.println(vehicle.toString());
                break;
            }
            default: break; 
        }

        topPanel.add(buttonSave);
        topPanel.setVisible(true);
        add(topPanel);

        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setResizable(true);
        setLocationRelativeTo(null);
        setVisible(true);
        pack();

    }

    private void saveCar(ActionEvent event) {
		try (var fos = new FileOutputStream(this.carFile); var oos = new ObjectOutputStream(fos)) {
			var car = this.carController.getCar();
			oos.writeObject(car);
		} catch (IOException exception) {
			exception.printStackTrace();
		}
    }
    
    private void saveTram(ActionEvent event) {
		try (var fos = new FileOutputStream(this.tramFile); var oos = new ObjectOutputStream(fos)) {
			var tram = this.tramController.getTram();
			oos.writeObject(tram);
		} catch (IOException exception) {
			exception.printStackTrace();
		}
    }
    
    private void saveVehicle(ActionEvent event) {
		try (var fos = new FileOutputStream(this.vehicleFile); var oos = new ObjectOutputStream(fos)) {
			var vehicle = this.vehicleController.getVehicle();
			oos.writeObject(vehicle);
		} catch (IOException exception) {
			exception.printStackTrace();
		}
    }
    

	private static Car readCar(File carFile) {
		try (var fis = new FileInputStream(carFile); var ois = new ObjectInputStream(fis)) {
			return (Car) ois.readObject();
		} catch (IOException | ClassNotFoundException exception) {
			throw new RuntimeException(exception);
		}
    }
    
    private static Car getCar(File carFile) {
		if (carFile.exists()) {
			return readCar(carFile);
		} else {
			return new Car();
		}
	}

	private static Tram readTram(File tramFile) {
		try (var fis = new FileInputStream(tramFile); var ois = new ObjectInputStream(fis)) {
			return (Tram) ois.readObject();
		} catch (IOException | ClassNotFoundException exception) {
			throw new RuntimeException(exception);
		}
    }
    
    private static Tram getTram(File tramFile) {
		if (tramFile.exists()) {
			return readTram(tramFile);
		} else {
			return new Tram();
		}
	}

	private static Vehicle readVehicle(File vehicleFile) {
		try (var fis = new FileInputStream(vehicleFile); var ois = new ObjectInputStream(fis)) {
			return (Vehicle) ois.readObject();
		} catch (IOException | ClassNotFoundException exception) {
			throw new RuntimeException(exception);
		}
    }
    
    private static Vehicle getVehicle(File vehicleFile) {
		if (vehicleFile.exists()) {
			return readVehicle(vehicleFile);
		} else {
			return new Vehicle();
		}
	}

}

