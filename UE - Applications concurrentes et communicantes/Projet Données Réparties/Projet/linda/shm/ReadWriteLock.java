package linda.shm;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ReadWriteLock {
    private Lock monitor;
    private Condition readingAccess;
    private Condition writingAccess;
    private int nbReader;
    private int nbWriterWaiting;
    private int nbReaderWaiting;
    private boolean isWriting;
    private boolean isWriterTurn;

    public ReadWriteLock()
    {
        this.monitor = new ReentrantLock();
        this.readingAccess = monitor.newCondition();
        this.writingAccess = monitor.newCondition();
        this.nbReader = 0;
        this.nbWriterWaiting = 0;
        this.nbReaderWaiting = 0;
        this.isWriting = false;
        this.isWriterTurn = false;
    }

    public void lockRead() throws InterruptedException
    {
        monitor.lock();
        while (isWriting || isWriterTurn) {
            nbReaderWaiting++;
            readingAccess.await();
            nbReaderWaiting--;
        }

        nbReader++;
        readingAccess.signal();
        monitor.unlock();
    }

    public void unlockRead() throws InterruptedException
    {
        monitor.lock();
        nbReader--;

        // Si redacteur en attente on bloque les nouvelles lectures
        if(nbWriterWaiting != 0) {
            isWriterTurn = true;

            // Dernier lecteur libere le redacteur
            if(nbReader == 0) {
                writingAccess.signal();
            }
        }
        monitor.unlock();
    }

    public void lockWrite() throws InterruptedException
    {
        monitor.lock();
        while (isWriting || nbReader != 0) {
            nbWriterWaiting++;
            writingAccess.await();
            nbWriterWaiting--;
        }
        isWriting = true;
        monitor.unlock();
    }

    public void unlockWrite() throws InterruptedException
    {
        monitor.lock();
        isWriting = false;
        isWriterTurn = false;

        // Priorite aux lecteurs
        if(nbReaderWaiting > 0) {
            readingAccess.signal();
        } else {
            writingAccess.signal();
        }
        monitor.unlock();
    }
}
