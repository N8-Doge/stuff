import javax.swing.*;
public class Driver
{
    public static void main(String[] args)
    {
        JFrame frame = new JFrame("Tile");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setContentPane(new Display());
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}