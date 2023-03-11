import javax.swing.JButton;

class Main
{
    public static void main(String[] args) 
    {
        Window window = new Window();
        Wombat wombat = new Wombat();
        var controller = new WombatController(wombat);
        window.setVisible(true);
    }
}
