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
    etat         \* i -> Hungry,Thinking,Eating

TypeInvariant == [](etat \in [ Philos -> { Hungry, Thinking, Eating }])

(* TODO : autres propriétés de philosophes0 (exclusion, vivacité) *)  

ExclusionMutuelle == [] (\A i \in Philos : etat[i] = Eating => (etat[gauche(i)] # Eating /\ etat[droite(i)] # Eating))

AbsenceDeFamine == \A i \in Philos : [] (etat[i] = Hungry => <> (etat[i] = Eating))

----------------------------------------------------------------

Init ==  \* À changer
        etat = [i \in 0..N-1 |-> Thinking]

demande(i) ==  \* À changer
                /\ etat[i] = Thinking
                /\ etat' = [etat EXCEPT ![i] = Hungry]

mange(i) == \* À changer
            /\ etat[i] = Hungry
            \* /\ \A j \in {gauche(i), droite(i)} : etat[j] # Eating
            /\ etat[gauche(i)] # Eating
            /\ etat[droite(i)] # Eating
            /\ etat' = [etat EXCEPT ![i] = Eating]

pense(i) ==  \* À changer
            /\ etat[i] = Eating
            /\ etat' = [etat EXCEPT ![i] = Thinking]

Next ==
  \E i \in Philos : \/ demande(i)
                    \/ mange(i)
                    \/ pense(i)

Fairness == \* À changer
            \A i \in 0..N-1 : SF_<<etat>>(mange(i)) /\ WF_<<etat>>(pense(i))
                        

Spec ==
  /\ Init
  /\ [] [ Next ]_<<etat>>
  /\ Fairness

================================
