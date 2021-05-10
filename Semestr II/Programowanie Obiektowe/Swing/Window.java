import java.io.File;
import javax.swing.*;
import java.awt.event.ActionEvent;

public class Window extends JFrame
{
    private static final long serialVersionUID = -8255319694373975038L;

    // private File file;



    public Window()
    {
        //this.controller = controller;
        // var buttonSave = new JButton("Save");
        var buttonCar = new JButton("Edit car");
        var buttonTram = new JButton("Edit tram");
        var buttonVehicle = new JButton("Edit vehicle");
		//button.addActionListener(this::save);
		var panel = new JPanel();
		//panel.add(controller);
        panel.add(buttonCar);
        panel.add(buttonTram);
        panel.add(buttonVehicle);
        
		add(panel);
		setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		setResizable(false);
        setLocationRelativeTo(null);
        setVisible(true);
		pack();

    }

}

