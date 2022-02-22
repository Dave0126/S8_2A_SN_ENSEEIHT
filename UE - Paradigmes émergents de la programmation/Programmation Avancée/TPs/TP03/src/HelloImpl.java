public class HelloImpl implements Hello {
    @Override
    public void sayHello(String name) {
        System.out.println("Hello " + name);
    }

    @Override
    public void sayGoodBye(String name) {
        System.out.println(name+" GoodBye!");
    }
}
