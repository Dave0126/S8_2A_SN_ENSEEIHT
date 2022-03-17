### Applications Web : TP - L'application Web minimale

#### 1. L'application web

[Person] 1-----n [Address]

person table:

| id   | Nom  | Prénom |
| ---- | ---- | ------ |
| 0    | 姓   | 名     |

address table:

| id   | Rue  | Ville | FK   |
| ---- | ---- | ----- | ---- |
| 0    | 路   | 城市  | 0/1  |

person - address table

| Person | Address |
| ------ | ------- |
| 0 (id) | 0 (id)  |

一个人可以有多个地址（1:N），但是一个地址只能对应一个人（1:1）



```java
public class Person{
  int id;
  String nom, prenom;
  Collection<Address> address = new ... ();
  
  // code of "set" or "get"
}
```

```java
public class Facade{
  HashMap<int, Personne> personne = new ...();
  int idP = 0;
  int idA = 0;
}
```

```java
public void ajoutPersonne(String n, String p){
  Personne person = new Personne();
  person.setNom(n);
  person.setPreNom(p);
  person.setId(idP);
  personne.put(idP++, person);
}
```

```java
Collection<Personne> listePersonnes() {
  return personne.values();
}
```

```java
void associer (int idP, int idA){
  Personne p = personnne.get(idP);
  Address a = addresses.get(idA);
  p.getAddress().add(a);
}
```

index.html

```html
<a href="ajoutPersonne.html"> ajout personne</a> <br/>
<a href="ajoutAddress.html"> ajout adresse</a> <br/>
<a href="serv?op=associer"> associer</a>
<a herf="serv?op=liste">liste</a>
```

ajoutPersonne.html

```html
<form action="serv" method="get">
  Nom: <input type="text" name="nom"/> <br/>
  Prenom: <input type="text" name="Prenom"/> <br/>
  <input type="submit" value="on">
  <input type="hidden" name="op" value="ajoutP"
</form>
```

servlet

```java
request.setAttritude("lp", lp);
request.setAttritude("la", la);
```

Choix.jsp

```jsp
<form method="get" action="serv">
  Choisir la personne:
  <%
  	collect<Personne> lp = (Collection<Personne>)request.getAttritude("lp");
  	for (Personne p:lp){
  %>
  <input type="radio" name="idP" value="<%=p.getId()%>"> <%=p.getNom()%><br>
  <% } %>
  // idem avec adresse
  <input type="submit" value="OK"/>
  <input type="hidden" name="op" value="valider"/>
</form>
```

```java
public class Serv extends HttpServlet {
  @EJB
  Facade f;
  doGet(request, response) {
    String op = request.getParameter("op"); // nom de parameter
    switch(op) {
      case "associer":
        request.getAltribute("lp", f.listePersonne(1));
        request.getAltribute("la", f.listeAdresse(1));
        request.getRequestDispacher("choix.jsp").forward(request, response);
        return ;
        
      case "liste":
        // idem
        
      case "ajoutP":
        String nom = request.getPerameter("nom");
        String prenom = request.getPerameter("Prenom");
        f.ajoutPersonne(nom, prenom);
        request.getRequestDispacher("index.html").forward(request, response);
        
      case "vailder":
        int idP = Integer.parseInt(request.getParamter("idP"));
        int idA = Integer.parseInt(request.getParamter("idA"));
        f.associer(idP, idA);
    }
  }
}
```

