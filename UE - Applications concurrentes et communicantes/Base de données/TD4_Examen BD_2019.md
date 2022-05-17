## Examen de BD_2019

##### Liste des attributes

```c
Relation{
  // (x) are primary keys who never been dependeced in Liste des DFs
  (GPS_symbole), value_symbole, (GPS_lieux), 
  // lieux:
  nom_lieux, description_lieux, telephone_lieux,
  // client:
  (pseudonyme_cilent,) address_cilent, comment_client, note_client,
  // ligne:
  value_ligne, (point_depart_ligne), nom_ligne, description_ligne, 
  GPS_point, (numero_autre_point),
}
```

```sql
SELECT GPS_point
FROM drace
WHERE nom_ligne = "Garonne"
ORDER BY numero_autre_point
```



##### Liste des DFs

- (a) `GPS_symbole` $\quad \to \quad$ `value_symbole`
- (b) `GPS_lieux` $\quad \to \quad$ `nom_lieux, description_lieux, telephone_lieux`
- (c) `pseudonyme_cilent` $\quad \to \quad$ `address_cilent`
- (d) `pseudonyme_cilent, GPS_lieux` $\quad \to \quad$ `comment_client, note_client`
- (e) `point_depart_ligne` $\quad \to \quad $ `natule_ligne, nom_ligne, description_ligne`
- (f) `point_depart_ligne, numero_autre_point` $\quad \to \quad$ `GPS_point`

>  About (f):

```mermaid
graph LR
a["point_depart_ligne(0)"] --> b["numero_autre_point (1)"]
b --> c["numero_autre_point (2)"]
c --> d["numero_autre_point (...)"]
e["GPS_point (depart+num)"] --> c
```

---

- (g) $\empty \quad \to \quad$ `[GPS_symbole], [GPS_lieux], [pseudonyme_cilent], | [point_depart_ligne], [numero_autre_point]`
- (h) `GPS_lieux` $\quad \to \quad$ `GPS_symbole | pseudonyme_cilent`



##### Decamp. au FNBC（2-范式）

- `Symbole([GPS_symbole], value_symbole)`
- `Lieux([GPS_lieux], nom_lieux, description_lieux, telephone_lieux)`
- `Client([pseudonyme_cilent], address_cilent)`
- `Commentaire([pseudonyme_cilent], [GPS_lieux], comment_client, note_client)`
- `Ligne([point_depart_ligne], natule_ligne, nom_ligne, description_ligne,)`
- `Drace([point_depart_ligne], [numero_autre_point], GPS_point)`
- `Reste([GPS_symbole], [GPS_lieux], [pseudonyme_cilent], [point_depart_ligne], [numero_autre_point])`

---

- `Represent(GPS_lieux, GPS_symbole) // Decamp. 4N`



```sql
/* trace de la Graonne */
SELECT GPS_point
FROM Drace
WHERE nom_ligne = "Garonne"
ORDER BY numero_autre_point;;
```



```sql
/* liste des lieux commentaires avec les moyen de note(+ nom de lieux) */
SELECT nom_lieux, GPS, AVG(note_client)
FROM Lieux, Commentaire
WHERE GPS = "lieux"
GROUP BY nom_lieux, GPS;;
```

