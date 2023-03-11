import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.Component;

public class Window extends JFrame
{
    private static final long serialVersionUID = -8255319694373975038L;

    public Window(Component...components)
    {
        for (Component component : components)
        {
            add(component);
        }

        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setResizable(false);
        setLocationRelativeTo(null);

       

        pack();
    }
}