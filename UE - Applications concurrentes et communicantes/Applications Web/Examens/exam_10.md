#### Question 3

Relation analysis:

1. at least A computer $\to$ A printer : `@OneToOne` OR `@ManyToOne`
2. A printer $\nrightarrow$ computers : `Printer` 类里不存在 `Computer` 类作为成员变量
3. Many comptuers $\to$ A printer : `@ManyToOne`
4. 单向

```java
@Entity
public class Comupter {
  @Id
  String hostname;
  Info otherinfo;
  
  @ManyToOne
  Printer printer;
  
  public Computer{}
  
  public void setHostname(String hostname){
    this.hostname = hostname;
  }
  pubilc String getHostname(){
    return this.hostname;
  }
  
  public void setInfo(Info info){
    this.otherinfo = info;
  }
  public Info getInfo(){
    return this.otherinfo;
  }
  
  public void setPrinter(Printer printer){
    this.printer = printer;
  }
  public Printer getPrinter(){
    return this.printer;
  }
}
```

```java
@Entity
public class Printer{
  @Id
  String printername;
  Info otherinfo;
  
  public Printer{}
  
  public void setPrintername(String printername){
    this.printername = printername;
  }
  pubilc String getPrintername(){
    return this.printername;
  }
  
  public void setInfo(Info info){
    this.otherinfo = info;
  }
  public Info getInfo(){
    return this.otherinfo;
  }
}
```



#### Question 4

- at least A Computer $\to$ Many Printers :  `@ManyToOne`
- A Printer $\to$ Many Computers : `@OneToMany`

```java
@Entity
public class Comupter {
  @Id
  String hostname;
  Info otherinfo;
  
  @ManyToOne
  Printer printer;
}
```

```java
@Entity
public class Printer{
  @Id
  String printername;
  Info otherinfo;
  
  @OneToMany
  List<Computer> computers; 
```



#### Question 5

- A Computer $\to$ Many Printers : un-direction `@ManyToOne`
- A Printer $\to$ A Computers && A Computer $\to$ A Printer : bi-direction `@OneToOne`



#### Question 6

`Facade.java`

```java
@Singleton
public class Facade implements PrinterManager {
  @PersistenceContext
  private EntityManager em;
  
  public void AddPrinter(String printername, Info printerinfo){
    Printer printer = new Printer();
    printer.setPrintername(printername);
    printter.setInfo(printerInfo);
    em.presist(printer);
  }
  
  public void AssociatePrinter (String printername, String hostname){
    Computer computer = em.find(Computer.class, hostname);
    Printer printer = em.find(Printer.class, printername);
    
    printer.computers.add(computer);
    em.merge(printer);
  }
  
  public ArrayList<Computer> getComputersForPrinting(String printername){
    Printer printer = em.find(Printer.class, printername);
    ArrayList<Computer> list = (ArrayList) printer.computers;
    return list;
  }
}
```

