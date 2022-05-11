% Programmation Déclarative
% MiniProjet 2 : Programmation par contraintes
% @Author : Arthur COUTURIER - L2
%           Enzo DI MARIA - L2
%           Guohao DAI - L2

:- include(libtp2).

%**************************** 1. Modele basique *********************************%

% solve(Num, Xs, Ys) solves the Num instance and assigns the Xs and Ys decision variable lists.

coordinate_domain([], _, []).
% C : Coordinate %
coordinate_domain([Ci|Cs], Capacity, [Ti|Ts]) :-
    Max is Capacity - Ti,
    fd_domain(Ci, 0, Max),
    coordinate_domain(Cs, Capacity, Ts).

chevauchement([], [], []).
chevauchement([Xi|Xs], [Yi|Ys], [Ti|Ts]) :-
    chevauchement_pair(Xi, Yi, Ti, Xs, Ys, Ts),
    chevauchement(Xs, Ys, Ts).

% Constraint Predicates of Non-overlapping in pair: Square_i & [Square_j|Square_s] %
chevauchement_pair(_, _, _, [], [], []).
chevauchement_pair(Xi, Yi, Ti, [Xj|Xs], [Yj|Ys], [Tj|Ts]) :-
        Xi + Ti #=< Xj
    #\/ Xj + Tj #=< Xi 
	#\/ Yi + Ti #=< Yj 
	#\/ Yj + Tj #=< Yi,
    % rec. Ts %
    chevauchement_pair(Xi, Yi, Ti, Xs, Ys, Ts).

% Test command : %
%   ['ppc.pl']. %
%   solve_v1(1,Xs,Ys, B). %
solve_v1(Num, Xs, Ys, B) :-
    % Get data from FILE: libtp2.pl %
    data(Num, T, Ts),
    %%
    length(Ts, Len),
    length(Xs, Len),
    length(Ys, Len),
    % The domains of the variables in the lists Xs and Ys %
    coordinate_domain(Xs, T, Ts),
    coordinate_domain(Ys, T, Ts),
    % Constraint Predicates of non-overlapping %
    chevauchement(Xs, Ys, Ts),
    % Calculate the solution and backtracks %
    fd_labeling(Xs, [backtracks(B)]),
    fd_labeling(Ys, [backtracks(B)]),
    % Write results in FILE: tiles01.txt %
    printsol('tiles01.txt', Xs, Ys, Ts). 

% Test: %
% Without redundant constraints: "solve_v1(1,Xs,Ys,B)."         B = 2; %



%************************* 2. Contraintes redondantes ****************************%

% In order to be able to solve larger scale problems, %
% the efficiency of constraint propagation can be improved by adding the following redundant constraints: %
% The sum of sizes of the small squares that intersect vertically (or horizontally) = size of the large squares. %

% \sum _{i=1} ^{n}%
sum_list_element([], 0).
sum_list_element([Head | Tail], Result) :-
    sum_list_element(Tail, Sub_Result),
    Result #= Head + Sub_Result.

% Ti \times (Xi≤v ∧ v<Xi+Ti) %
multi_liste([],[],[]).
multi_liste([Head1 | Tail1], [Head2 | Tail2], R) :-
        P #= Head1 * Head2,
        multi_liste(Tail1, Tail2, R1),
        append([P], R1, R).

redundant_constraint(Capacity, Capacity, _, _).
redundant_constraint(Capacity, Vertical, Xs, Ts) :-
	% Redundant constraint for the current vertical %
    redundant_constraint_unite(Vertical, Xs, Ts, B),
    % S[] = Ts * B %
    multi_liste(Ts, B, S),
    % Sum S[] %
    sum_list_element(S, Capacity),
    % Next one %
    Next #= Vertical + 1,
    % Recursively call the Next %
    redundant_constraint(Capacity, Next, Xs, Ts).

redundant_constraint_unite(_, [], [], []).
redundant_constraint_unite(Vertical, [Xi|Xs], [Ti|Ts], [Bi|Bs]) :-
	% verify the vertical intersects %
    Bi #<=> (
            Xi #=< Vertical 
        #/\ Vertical #< Xi + Ti),

    % Recursively call %
    redundant_constraint_unite(Vertical, Xs, Ts, Bs).


% Test command : %
%   ['ppc.pl']. %
%   solve_v2(1,Xs,Ys, B). %
solve_v2(Num, Xs, Ys, B) :- 
	% Get data from FILE: libtp2.pl %
	data(Num, T, Ts),
	%%
	length(Ts, Len),
	length(Xs, Len),
	length(Ys, Len),
	% The domains of the variables in the lists Xs and Ys %
	coordinate_domain(Xs, T, Ts),
	coordinate_domain(Ys, T, Ts),
	% Constraint Predicates of non-overlapping %
    chevauchement(Xs, Ys, Ts),
	% Redundant constraints %
	redundant_constraint(T, 0, Xs, Ts),
	redundant_constraint(T, 0, Ys, Ts),
	% Calculate the solution and backtracks %
	fd_labeling(Xs, [backtracks(B)]),
	fd_labeling(Ys, [backtracks(B)]),
	% Write results in FILE: tiles02.txt %
	printsol('tiles02.txt',Xs,Ys,Ts).

% Test: %
% With redundant constraints: "solve_v2(1,Xs,Ys,B)."            B = 0; %
% Without redundant constraints: "solve_v1(1,Xs,Ys,B)."         B = 2; %
% Combining the above two tests, the redundant constraints effectively reduce the number of backtracks(B). %


%************************* 3. Stratégie de recherche ****************************%
% Test command : %
%   ['ppc.pl']. %
%   solve_v3(1,Xs,Ys,B,(assign/indomain),NbSol). %
solve_v3(Num, Xs, Ys, B, Goal, NbSol) :- 
    % Get data from FILE: libtp2.pl %
	data(Num, T, Ts),
	%%
	length(Ts, Len),
	length(Xs, Len),
	length(Ys, Len),
	% The domains of the variables in the lists Xs and Ys %
	coordinate_domain(Xs, T, Ts),
	coordinate_domain(Ys, T, Ts),
	% Constraint Predicates of non-overlapping %
    chevauchement(Xs, Ys, Ts),
	% Redundant constraints %
	redundant_constraint(T, 0, Xs, Ts),
	redundant_constraint(T, 0, Ys, Ts),
    % Calculate the solution and backtracks %
    % Use the labeling with the minmin criterion %
    labeling(Xs, Ys, Goal, minmin, B, NbSol),
    % Write results in FILE: tiles03.txt %
    printsol('tiles03.txt',Xs,Ys,Ts).

% Test: %
% "solve_v3(1,Xs,Ys,B,(assign/indomain),NbSol)." : %
%       Strategy: assign      |   B = 0         |   NbSol = 1 %
%       Strategy: indomain    |   B = 0         |   NbSol = 1 %
% "solve_v3(2,Xs,Ys,B,(assign/indomain),NbSol)." : %
%       Strategy: assign      |   B = 805       |   NbSol = 1 %
%       Strategy: indomain    |   B = 9038      |   NbSol = 1 %
% "solve_v3(3,Xs,Ys,B,(assign/indomain),NbSol)." : %
%       Strategy: assign      |   Null (Fatal Error: stack overflow)
%       Strategy: indomain    |   Null (Fatal Error: stack overflow)
% "solve_v3(4,Xs,Ys,B,(assign/indomain),NbSol)." : %
%       Strategy: assign      |   Null (Fatal Error: stack overflow)
%       Strategy: indomain    |   Null (Fatal Error: stack overflow)



%************************* 4. Symétriesde ****************************%

sort([_], [_], [_]).
sort([X,Xi|Xs], [Y,Yi|Ys], [T,Ti|Ts]) :-
    (Ti #\= T) 
    #\/ (
        (       Yi #< Y
            #\/ Xi #< X)
        #/\ Xi #=< X),
    sort([Xi|Xs], [Yi|Ys], [Ti|Ts]).

% Test command : %
%   ['ppc.pl']. %
%   solve_v4(1,Xs,Ys, B). %
%   a %
solve_v4(Num, Xs, Ys, B, Goal, NbSol) :- 
    % Get data from FILE: libtp2.pl %
	data(Num, T, Ts),
	%%
	length(Ts, Len),
	length(Xs, Len),
	length(Ys, Len),
	% The domains of the variables in the lists Xs and Ys %
	coordinate_domain(Xs, T, Ts),
	coordinate_domain(Ys, T, Ts),
	% Constraint Predicates of non-overlapping %
    chevauchement(Xs, Ys, Ts),
	% Redundant constraints %
	redundant_constraint(T, 0, Xs, Ts),
	redundant_constraint(T, 0, Ys, Ts),
    sort(Xs, Ys, Ts),
    % Calculate the solution and backtracks %
    % Use the labeling with the minmin criterion %
    labeling(Xs, Ys, Goal, minmin, B, NbSol),
    % Write results in FILE: tiles04.txt %
    printsol('tiles04.txt',Xs,Ys,Ts).

% Test: %
% Instance 1 : %
%    Without   Sort : "solve_v3(1, Xs, Ys, B, assign, NbSol)."         B = 479 |   NbSol = 480     %
%       With   Sort : "solve_v4(1, Xs, Ys, B, assign, NbSol)."         B = 9   |   NbSol = 4       %


% Strategy: assign % 
%   "solve_v4(1,Xs,Ys,B,assign,NbSol)." : %
%       Instance 1      |   B = 9           |   NbSol = 4 %
%       Instance 2      |   B = 29902       |   NbSol = 10216 %