---------------- MODULE missionnaires_et_cannibales----------------
(* m:传教士    c:食人者 *)
EXTENDS Naturals
VARIABLES
    mLeft,
    mRight,
    cLeft,
    cRight,
    Boat
    
Rives == {"Left", "Right"}
    
    (* nb <= 3 *)

TypeInvariant == 
    [](/\ mLeft + mRight = 3
       /\ cLeft + cRight = 3
       /\ mLeft >= 0
       /\ mLeft <= 3
       /\ mRight >= 0
       /\ mRight <= 3
       /\ cLeft >= 0
       /\ cLeft <= 3
       /\ cRight >= 0
       /\ cRight <= 3
       /\ Boat \in Rives)
   
pasMiam == 
    /\ ((mLeft >= cLeft) \/ mLeft = 0)
    /\ ((mRight >= cRight) \/ mRight = 0)
    
ToujoursOk == []pasMiam
      
Solution ==
    [] \neg (mLeft = 0 /\ mRight = 3 /\ cLeft = 0 /\ cRight = 3)

----------------------------------------------------------------

Init == 
    /\ mLeft = 3
    /\ mRight = 0
    /\ cLeft = 3
    /\ cRight = 0
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



(*       
Cannibale == 
    {"Affred", "Batrice", "Charles"}
    
Missionnaire ==
    {"Dominique", "Etienne", "Florence"}
    
Entites == Cannibale \/ Missionnaire

VARIABLES
    Left,
    Right,
    Boat

    
TypeInvariant == 
    []( (Left \/ Right = Entites)
        /\ (Left \/ Right = {}) )
*)
     
