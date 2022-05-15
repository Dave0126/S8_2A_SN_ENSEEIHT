## Examen_14 : DB

#### Lists des attributes

$\mathcal{R}_{elation}$ :

```java
Relation{
  // Adherent
  numero_adherent, nom_adherent, prenom_adherent, address_adherent, date_adherent, 
  tarif_cotisation, montant_cotisation,
    
  (numero_inventaire), date_inventaire, mode_inventaire, etat_exemplaire,
  
  {ISBN}, date_edition, (nom_intervenant), (prenom_intervenant),
  
  {cote}, titre, (auteur), (mot_clef), 
  
  (date_pret), date_retour,
  // ()里的是不在 -> 右边的键: Reste()
  // {}里是 DMVs 后剩下的
}
```



#### Liste des DFs

**(a)** numero_adherent $\quad \to \quad$ nom_adherent, prenom_adherent, address_adherent, date_adherent, 
  tarif_cotisation

**(b)** tarif_cotisation $\quad \to \quad$ montant_cotisation

**(c)** numero_inventaire $\quad \to \quad$ date_inventaire, mode_inventaire, etat_exemplaire, ISBN,

**(d)** ISBN $\quad \to \quad$ date_edition, cote

**(e)** cote $\quad \to \quad $ titre

**(f)** numero_inventaire, date_pret $\quad \to \quad $ date_retour, numero_adherent

----

**(g)** numero_inventaire $\quad \to \quad$ date_pret | {nom_intervenant, prenom_intervenant, auteur, mot_clef }（详见下文）

**(h)** cote $\quad \to \quad$ mot_clef

**(i)** cote $\quad \to \quad$ auteur

**(j)** ISBN $\quad \to \quad$ nom_intervenant, prenom_intervenant



#### Decamp. au FNBC（2-范式）

- `Adherent([numero_adherent], nom_adherent, prenom_adherent, address_adherent, date_adherent, tarif_cotisation)`
- `Tarif([tarif_cotisation], montant_cotisation)`
- `([cote], titre)`
- `([ISBN], date_edition, cote)`
- `Exemplaire([numero_inventaire], date_inventaire, mode_inventaire, etat_exemplaire, ISBN)`
- `Emprunter([numero_inventaire], [date_pret], date_retour, numero_adherent)`
- `Reste([numero_inventaire], [nom_intervenant], [prenom_intervenant], [auteur], [mot_clef], [date_pret])`

---

- `Mot_clef([cote], [mot_clef])`
- `Auteur([cote], [autuer])`
- `Intervenant([ISBN], [nom_intervenant], [prenom_intervenant])`



mot_clef $\quad \nrightarrow \quad$ date_pret|{ numero_inventaire, nom_intervenant, prenom_intervenant, auteur }

例：

| mot_clef | date_pret | nom_intervenant    |
| -------- | --------- | ------------------ |
| OULIPO   | 1 avril   | xxx                |
| OULIPO   | 8 sept    | yyy                |
| OULIPO   | 8 sept    | zzz (不能唯一确定) |

**(g)** numero_inventaire $\quad \to \quad$ date_pret | {nom_intervenant, prenom_intervenant, auteur, mot_clef }

例：

| numero_inventaire | date_pret | mot_clef          |
| ----------------- | --------- | ----------------- |
| xxx               | 1 avril   | OULIPO            |
| yyy               | 8 sept    | RED               |
| yyy               | 8 sept    | RED(可以唯一确定) |



#### Decamp. au 4FN（4-范式）

