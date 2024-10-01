public class Number {
    private int number = 0;

    public void increment() {
        this.number++;
    }

    public void decrement() {
        this.number--;
    }

    public void reset() {
        this.number = 0;
    }

    @Override
    public String toString() {
        return "" + number;
    }
}
