
addAtI(0,[H|T],X, [HN|T]):-
 HN is H+X.

addAtI(I,[H|T],X,[H|TN]):-
 IN is I-1,
 addAtI(IN,T,X,TN).

addToMatrix([],[]).

addToMatrix([H|T],[NH|NT]):-
 addAtI(2,H,2,NH),
 addToMatrix(T,NT).

makeChange([],[]).

makeChange([H|T],[NH|NT]):-
 addToMatrix([H|T],[HH|NT]),
 addAtI(0,HH,-1,NH).
