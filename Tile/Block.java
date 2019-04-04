import java.util.*;
/**
 * Abstract class Block contains basic interactions between blocks
 * 
 * @author Nathan Chen
 * @version 4.3.19
 */
public abstract class Block
{
    boolean powerable, powering;
    public Block(boolean powerable){
        this.powerable=powerable;
        this.powering=false;
    }
    
    public boolean isPowered(ArrayList<ArrayList<Block>> blocks, int x, int y){
        boolean b = false;
        if(x>0){
            b=(b|blocks.get(x-1).get(y).isPowering());
        }
        b=(b|blocks.get(x+1).get(y).isPowering());
        if(y>0){
            b=(b|blocks.get(x).get(y-1).isPowering());
        }
        b=(b|blocks.get(x).get(y+1).isPowering());
        return b;
    }
    
    public boolean isPowerable(){return powerable;}
    public boolean isPowering(){return powering;}
    public void setPowerable(boolean powerable){this.powerable=powerable;}
    public void setPowering(boolean powering){this.powering=powering;}
}
