:- set_prolog_flag(toplevel_print_options, [quoted(true), portray(true), max_depth(100), priority(699)]). 

check_safe(G,J,A,s(X,Y,R)):- X>=0, X=<G, Y>=0, Y=<J, R>=0, R=<A.

move(G,J,A,s(X,Y,R),s(Z,0,R)) :- Z is X + Y, Z =< G.
move(G,J,A,s(X,Y,R),s(0,Z,R)) :- Z is X + Y, Z =< J.
move(G,J,A,s(X,Y,R),s(X,Z,0)) :- Z is Y + R, Z =< J.
move(G,J,A,s(X,Y,R),s(X,0,Z)) :- Z is Y + R, Z =< A.
move(G,J,A,s(X,Y,R),s(Z,Y,0)) :- Z is X + R, Z =< G.
move(G,J,A,s(X,Y,R),s(0,Y,Z)) :- Z is X + R, Z =< A.


move(G,J,A,s(X,Y,R),s(X,Z,A)) :- Z is Y - (A - R), Z >=0.
move(G,J,A,s(X,Y,R),s(G,Z,R)) :- Z is Y - (G - X), Z >=0.
move(G,J,A,s(X,Y,R),s(X,J,Z)) :- Z is R - (J - Y), Z >=0.
move(G,J,A,s(X,Y,R),s(G,Y,Z)) :- Z is R - (G - X), Z >=0.
move(G,J,A,s(X,Y,R),s(Z,J,R)) :- Z is X - (J - Y), Z >=0.
move(G,J,A,s(X,Y,R),s(Z,Y,A)) :- Z is X - (A - R), Z >=0.


move(G,J,A,s(X,Y,0),s(X,Y,A)).
move(G,J,A,s(0,Y,R),s(G,Y,R)).
move(G,J,A,s(X,0,R),s(X,J,R)).

move(G,J,A,s(X,Y,R),s(0,Y,R)) :- X > 0.
move(G,J,A,s(X,Y,R),s(X,0,R)) :- Y > 0.
move(G,J,A,s(X,Y,R),s(X,Y,0)) :- R > 0.

path(G,J,A,K,L,D,[s(X,Y,R)|Xs],[s(X,Y,R)|Xs]):- (X=K,Y=L,R=D),!.

path(G,J,A,K,L,D,[X|Xs],Rs):- 
    move(G,J,A,X,Y),
    check_safe(G,J,A,Y),
    not(member(Y,[X|Xs])),
    path(G,J,A,K,L,D,[Y,X|Xs],Rs).
	
waterjug(P,[G,J,A|T],[W,B,C|T],[K,L,D|T]):- path(G,J,A,K,L,D,[s(W,B,C)],P), reverse(P, Sol), write(Sol), nl.
% Here's an easy little predicate for printing a list.
writeOut([]).
writeOut([H|T]):-write(H),nl, writeOut(T).