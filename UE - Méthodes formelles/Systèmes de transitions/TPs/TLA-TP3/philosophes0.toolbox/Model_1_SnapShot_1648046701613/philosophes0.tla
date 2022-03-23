---------------- MODULE philosophes0 ----------------
(* Philosophes. Version en utilisant l'état des voisins. *)

EXTENDS Naturals

CONSTANT N

ASSUME N \in Nat /\ N > 1

Philos == 0..N-1

gauche(i) == (i+1)%N       \* philosophe à gauche du philo n°i
droite(i) == (i+N-1)%N     \* philosophe à droite du philo n°i

Hungry == "H"
Thinking == "T"
Eating == "E"

VARIABLES
    etat,         \* i -> Hungry,Thinking,Eating
    jeton

TypeInvariant == [](etat \in [ Philos -> { Hungry, Thinking, Eating }])

(* TODO : autres propriétés de philosophes0 (exclusion, vivacité) *)  

ExclusionMutuelle == [] (\A i \in Philos : etat[i] = Eating => (etat[gauche(i)] # Eating /\ etat[droite(i)] # Eating))

AbsenceDeFamine == \A i \in Philos : [] (etat[i] = Hungry => <> (etat[i] = Eating))

Sanity == [] (\A i \in Philos : etat[i] = Eating => jeton = i)

JetonVaPartout == \A i \in Philos : [] <> (jeton = i)

----------------------------------------------------------------

Init ==  \* À changer
        etat = [i \in 0..N-1 |-> Thinking]

demande(i) ==  \* À changer
                /\ etat[i] = Thinking
                /\ etat' = [etat EXCEPT ![i] = Hungry]
                /\ UNCHANGED jeton

mange(i) == \* À changer
            /\ etat[i] = Hungry
            \* /\ \A j \in {gauche(i), droite(i)} : etat[j] # Eating
            /\ etat[gauche(i)] # Eating
            /\ etat[droite(i)] # Eating
            /\ jeton = 1
            /\ etat' = [etat EXCEPT ![i] = Eating]
            /\ UNCHANGED jeton

pense(i) ==  \* À changer
            /\ etat[i] = Eating
            /\ etat' = [etat EXCEPT ![i] = Thinking]
            /\ UNCHANGED jeton
            
bouger(i) ==    /\ jeton = i
                /\ etat[i] \notin { Hungry, Eating }
                /\ jeton' = (i+1)%N
                /\ UNCHANGED etat

Next ==
  \E i \in Philos : \/ demande(i)
                    \/ mange(i)
                    \/ pense(i)
                    \/ bouger(i)

Fairness == \* À changer
            \A i \in 0..N-1 : SF_<<etat>>(mange(i)) /\ WF_<<etat>>(pense(i))
                        

Spec ==
  /\ Init
  /\ [] [ Next ]_<<etat>>
  /\ Fairness

================================
