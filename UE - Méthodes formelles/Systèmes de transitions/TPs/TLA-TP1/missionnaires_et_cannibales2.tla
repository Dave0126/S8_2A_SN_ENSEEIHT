---------------- MODULE missionnaires_et_cannibales2----------------
(* m:传教士    c:食人者 *)
EXTENDS Naturals, FiniteSite, Sequences
Cannibale == 
    {"Cao", "Cheng", "Cong"}
    
Missionnaire ==
    {"Mu", "Mulan", "Ming"}
    
Entites == Cannibale \/ Missionnaire

VARIABLES
    posLeft,
    posRight,
    Boat

Rives == {"Left", "Right"}
    
TypeInvariant == 
    []( /\ (posLeft \/ posRight = Entites)
        /\ (posLeft /\ posRight = {})
        /\ (Cannibale \in Rives)
        /\ (Missionnaire \in Rives))


   
pasMiam == 
    /\ ((Len(<< posLeft /\ Missionnaire >>) >= Len(<< posLeft /\ Cannibale >>)) \/ Len(<< posLeft /\ Missionnaire >>) = 0)
    /\ ((Len(<< posRight /\ Missionnaire >>) >= Len(<< posRight /\ Cannibale >>)) \/ Len (<< posRight /\ Missionnaire >>) = 0)
    
ToujoursOk == []pasMiam
      
Solution ==
    [] \neg (posLeft = {} /\ posRight = Entites)

----------------------------------------------------------------
inv(r) == IF r = "Left" THEN "Right" ELSE "Left"

Init == 
    /\ posLeft = Entites
    /\ posRight = {}
    /\ Boat = "Left"
    
C_C_toRight ==
    /\ cLeft > 1
    /\ cLeft' = cLeft - 2
    /\ cRight' = cRight + 2
    /\ UNCHANGED <<mLeft, mRight>>
    /\ Boat = "Left"
    /\ Boat' = "Right"
    /\ pasMiam'
    
C_toRight ==
    /\ cLeft > 0
    /\ cLeft' = cLeft - 1
    /\ cRight' = cRight + 1
    /\ UNCHANGED <<mLeft, mRight>>
    /\ Boat = "Left"
    /\ Boat' = "Right"
    /\ pasMiam'
    
C_M_toRight ==
    /\ cLeft > 0
    /\ mLeft > 0
    /\ cLeft' = cLeft - 1
    /\ cRight' = cRight + 1
    /\ mLeft' = mLeft - 1
    /\ mRight' = mRight + 1
    /\ Boat = "Left"
    /\ Boat' = "Right"
    /\ pasMiam' 
    
M_M_toRight ==
    /\ mLeft > 1
    /\ mLeft' = mLeft - 2
    /\ mRight' = mRight + 2
    /\ UNCHANGED <<cLeft, cRight>>
    /\ Boat = "Left"
    /\ Boat' = "Right"
    /\ pasMiam'
    
M_toRight ==
    /\ mLeft > 0
    /\ mLeft' = mLeft - 1
    /\ mRight' = mRight + 1
    /\ UNCHANGED <<cLeft, cRight>>
    /\ Boat = "Left"
    /\ Boat' = "Right"
    /\ pasMiam'

C_C_toLeft ==
    /\ cRight > 1
    /\ cLeft' = cLeft + 2
    /\ cRight' = cRight - 2
    /\ UNCHANGED <<mLeft, mRight>>
    /\ Boat = "Right"
    /\ Boat' = "Left"
    /\ pasMiam'

M_M_toLeft ==
    /\ mRight > 1
    /\ mLeft' = mLeft + 2
    /\ mRight' = mRight - 2
    /\ UNCHANGED <<cLeft, cRight>>
    /\ Boat = "Right"
    /\ Boat' = "Left"
    /\ pasMiam'
    
C_M_toLeft ==
    /\ cRight > 0
    /\ mRight > 0
    /\ cLeft' = cLeft + 1
    /\ cRight' = cRight - 1
    /\ mLeft' = mLeft + 1
    /\ mRight' = mRight - 1
    /\ Boat = "Right"
    /\ Boat' = "Left"
    /\ pasMiam'    
            
C_toLeft ==
    /\ cRight > 0
    /\ cLeft' = cLeft + 1
    /\ cRight' = cRight -1
    /\ UNCHANGED <<mLeft, mRight>>
    /\ Boat = "Right"
    /\ Boat' = "Left"
    /\ pasMiam'
    
M_toLeft ==
    /\ mRight > 0
    /\ mLeft' = mLeft + 1
    /\ mRight' = mRight -1
    /\ UNCHANGED <<cLeft, cRight>>
    /\ Boat = "Right"
    /\ Boat' = "Left"
    /\ pasMiam'  
    
Next ==     C_C_toRight \/ C_M_toRight \/ M_M_toRight \/ C_toRight \/ M_toRight 
            \/ C_C_toLeft \/ M_M_toLeft \/ C_M_toLeft \/ C_toLeft \/ M_toLeft 

Spec == Init /\ [] [ Next ]_<<mLeft, mRight, cLeft, cRight, Boat>>

================================================================


