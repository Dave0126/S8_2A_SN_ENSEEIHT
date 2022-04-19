solve(Vars) :-
    Vars = [D, O, N, A, L, G, E, R, B, T],
    fd_domain(Vars,0,9),
    fd_all_different(Vars),
    D #> 0,
    C #> 0,
    R #> 0,
    (D + L*10 + A*100 + N*1000 + O*10000 + D*100000) +
    (D + L*10 + A*100 + R*1000 + E*10000 + G*100000) #=
    (T + R*10 + E*100 + B*1000 + O*10000 + R*100000),
    fd_labeling(Vars).