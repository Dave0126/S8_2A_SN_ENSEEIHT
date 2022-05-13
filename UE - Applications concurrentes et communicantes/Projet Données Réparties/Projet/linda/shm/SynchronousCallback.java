package linda.shm;

import linda.Callback;
import linda.Tuple;

public class SynchronousCallback implements Callback {
        
    private Tuple resultat;
    
    public SynchronousCallback () {
    }
        
    public void call(final Tuple t) {
        this.resultat = t;
        // Reveil
        synchronized(this) {
            this.notify();
        }
    }

    public Tuple getResultat() {
        return this.resultat;
    }
}
