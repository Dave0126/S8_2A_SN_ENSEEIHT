solve(Vars) :-
    Vars = [N, A, B, C, D],
    N #< 1000000,
    [A,B] #\= [C,D],
    [A,B] #\= [D,C],
    N #= A*A*A + B*B*B,
    N #= C*C*C + D*D*D,
    fd_labeling(Vars).