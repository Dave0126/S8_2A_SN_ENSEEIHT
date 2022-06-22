import java.lang.reflect.*;
import java.util.*;

public class ProtectionHandler implements InvocationHandler {

	private Object recepteur;
	private Set<String> methodesInterdites;

	public ProtectionHandler(Object recepteur, String... methodesInterdites) {
		this.recepteur = recepteur;
		this.methodesInterdites = new TreeSet<>();
		Collections.addAll(this.methodesInterdites, methodesInterdites);
	}

	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable 
	{
		if (methodesInterdites.contains(method.getName())) {
			throw new UnsupportedOperationException();
		}

		return method.invoke(this.recepteur, args);
	}
	

}
