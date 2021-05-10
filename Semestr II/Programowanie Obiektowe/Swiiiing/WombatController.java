import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSpinner;
import javax.swing.JTextField;

public class WombatController extends JPanel
{

    private static final long serialVersionUID = 2745592196198361921L;

    private Wombat wombat;

    public WombatController(Wombat wombat)
    {
        this.wombat = wombat;
        var spinner = new JSpinner();
        spinner.addChangeListener(event -> wombat.setCecumLength((int)spinner.getValue()));
        spinner.setValue(wombat.getCecumLength());
        var textField = new JTextField(42);
        textField.setText(wombat.getFavouritePapoo());
        textField.addCaretListener(event -> {wombat.setFavouritePapoo(textField.getText());});
        add(new JLabel("Favourite food"));
        add(textField);
    }
    
}