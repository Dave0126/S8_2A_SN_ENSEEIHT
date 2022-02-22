public class HelloProxyStatic {

    private Hello hello;
    public void setImpl(Hello impl){
        this.hello = impl;
    }

    public void sayHello(String name) {

        System.out.println("问候之前的日志记录...");

        hello.sayHello(name);

    }

    public void sayGoodBye(String name) {

         System.out.println("问候之前的日志记录...");

         hello.sayGoodBye(name);

    }

    static public void main(String[] arg) {

         HelloImpl helloImpl = new HelloImpl();

        HelloProxyStatic staticProxy = new HelloProxyStatic();

        staticProxy.setImpl(helloImpl);

        staticProxy.sayHello("Guohao_static");

      }

}
