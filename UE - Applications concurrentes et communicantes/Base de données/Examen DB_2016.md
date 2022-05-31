### Examen: DB_2016

#### Normalisation relationnelle

##### Liste des attributes:

```java
Relation {
  // Info of Player. PrimaryKey: [pseudonyme_joueur]
	[pseudonyme_joueur], mot_de_passe_joueur, nom_joueur, prenom_joueur, nationality_joueur, 
  address_internet_joueur, scole_joueur
	// Other Info
	address_postal, numero_de_tele,
	// Subscribe
	final_date_d_echeance, date_de_paiement,
  
	// Info of Games. PrimaryKey: [nom_badge]
	note_jeu, [nom_badge], val_badge, intitule_badge, date_de_badge, nom_jeu, date_jeu,

	// Info of Commants. PrimaryKey: [date_commantaire]
	texte_commentaire, note_commentaire, [date_commantaire]
}
```

$\mathcal{R}_{elation}$ :

- <u>`pseudonyme_joueur`</u>
- `mot_de_passe_joueur`
- `nom_joueur`
- `prenom_joueur`
- `nationality_joueur`
- `address_internet_joueur`
- `address_postal`, `numero_de_tele`
- `final_date_d_echeance`
- `date_de_paiement`
- `point_joueur`
- `note_jeu`
- <u>`nom_badge`</u>
- `val_badge`
- `intitule_badge`
- `date_de_badge`
- `nom_jeu`
- `date_jeu`
- `texte_commentaire`
- `note_commentaire`
- <u>`date_commantaire`</u>



##### Liste des DFs

- (a) `pseudonyme_joueur` $\quad \to \quad$ `mot_de_passe_joueur`, `nom_joueur`, `prenom_joueur`, `nationality_joueur`, `address_internet_joueur`, `final_date_d_echeance`, `date_de_paiement`, `scole_joueur`
- (b) `nom_badge` $\quad \to \quad$ `nom_jeu`, `date_jeu`, `val_badge`, `intitule_badge`
- (c) `nom_badge`, `pseudonyme_joueur` $\quad \to \quad$ `date_badge`
- (d) `nom_jeu`, `date_jeu`, `pseudonyme-joueur` $\quad \to \quad$ `note_jeu`
- (e) `date_commentaire`, `pseudonyme_joueur` $\quad \to \quad$ `texte_commentaire`, `note_commentaire`, `nom_jeu`, `date_jeu`





##### Decamp. au FNBC（BC-范式）

$\mathcal{R}$ + 

- `Joueurs( mot_de_passe_joueur, nom_joueur, prenom_joueur, nationality_joueur, address_internet_joueur, scole_joueur, final_date_d_echeance, date_de_paiement)`
- `Xxxx([nom_badge], [pseudonyme_joueur], date)`
- `Note([nom_jeu], [date_jeu], [pseudonyme_joueur], note)`
- `Badge([nom_badge], nom_jeu, date_jeu, val_bagde, intitule_badge)`
- `Commantaire([date], [pseudonyme_joueur], texte, note, nom_jeu, date_jeu)`
- `Reste([pseudonyme_joueur], [nom_badge], [date_commantaire])`

(f) `pseudonyme_joueur` $\quad \to \quad$ `nom_badge` | `date_commentaire`



##### Decamp. au 4FN（4-范式）



##### 2. Validation en SQL

a. 

```sql
SELECT * FROM Joueurs WHERE final_date_d_echeance > SYSDATE;;
```

