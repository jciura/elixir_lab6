public class Main extends Thread{
    private static final Number num = new Number();
    public static void main(String[] args) throws InterruptedException {
        int n = 30000;
        Thread[] threads = new Thread[n];
        for (int i = 0; i < n; i++) {
            threads[i] = new Main();
            threads[i].start();

        }

        for (int i = 0; i < n; i++) {
            threads[i].join();
        }

        System.out.println(num.toString());
        num.reset();
    }

    @Override
    public void run() {
        if(Thread.currentThread().getId() % 2 == 0) {
            num.increment();
        }
        else {
            num.decrement();
        }
        //System.out.println("Thread: " + Thread.currentThread());
    }
    //Roznica miedzy Thread a Runnable
}