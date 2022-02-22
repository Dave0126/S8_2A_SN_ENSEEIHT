import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public class liste_Dynamic_Proxy {
    private Object delegate;

    public Object bind(Object delegate){
        this.delegate = delegate;
        return Proxy.newProxyInstance(
                this.delegate.getClass().getClassLoader(), this.delegate.getClass().getInterfaces(), (InvocationHandler) this
        );
    }

}
