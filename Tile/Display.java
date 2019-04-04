import java.awt.*;
import java.util.*;
import javax.swing.*;
public class Display extends JPanel{
    public Display(){
        setLayout(new GridLayout(2,1));
        ArrayList<ArrayList<Block>> myBlocks = new ArrayList<ArrayList<Block>>();
        myBlocks.add(new ArrayList<Block>());
        myBlocks.get(0).add(new SolidBlock());
        myBlocks.add(new ArrayList<Block>());
        myBlocks.get(1).add(new RedstoneBlock());
        add(new JButton());
        add(new JButton());
    }
}