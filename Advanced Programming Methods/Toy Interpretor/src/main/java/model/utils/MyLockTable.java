package model.utils;
import exceptions.InterpreterException;
import java.util.Set;
import java.util.HashMap;

public class MyLockTable implements MyILockTable{

    private HashMap<Integer, Integer> lockTable;

    private int freeLocation = 0;

    public MyLockTable() {
        this.lockTable = new HashMap<>();
    }

    @Override
    public int getFreeValue(){
        synchronized (this) {
            freeLocation++;
            return freeLocation;
        }
    }

    @Override
    public void put(int key, int value) throws InterpreterException{
        synchronized (this) {
            if (!lockTable.containsKey(key)) {
                lockTable.put(key, value);
            }
            else{
                throw new InterpreterException(String.format("Lock table already has key %d", key));

            }
        }
    }

    @Override
    public HashMap<Integer, Integer> getContent(){
        synchronized (this) {
            return lockTable;
        }
    }

    @Override
    public boolean containsKey(int position){
        synchronized (this) {
            return lockTable.containsKey(position);
        }
    }

    @Override
    public int get(int position) throws InterpreterException{
        synchronized (this) {
            if (!lockTable.containsKey(position))
                throw new InterpreterException(String.format("%d is not present in the table!", position));
            return lockTable.get(position);
        }
    }

    @Override
    public void update(int position, int value) throws InterpreterException{
        synchronized (this){
            if (lockTable.containsKey(position)){
                lockTable.replace(position, value);
            }else{
                throw new InterpreterException(String.format("%d can't be found in the table", position));

            }
        }
    }

    @Override
    public void setContent(HashMap<Integer, Integer> newContent){
        synchronized (this) {
            this.lockTable = newContent;
        }
    }

    @Override
    public Set<Integer> keySet(){
        synchronized (this) {
            return lockTable.keySet();
        }
    }

    @Override
    public String toString(){
        return lockTable.toString();
    }
}
