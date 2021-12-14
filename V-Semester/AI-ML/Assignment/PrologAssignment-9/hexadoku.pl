/* email: skumar19@binghamton.edu */
:- use_rendering(sudoSolver).
:- use_module(library(clpfd)).

/*solver receives list X, verifies that X is length 256*/
/*remaps hex char atomics to numeral atomics, solves and returns string R with answer*/
solver(X,R):-
  X = [  
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
  _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_
  ],
  remap(Y,X), /*create Y with hex vals*/
  sudoSolver(Y), /*solve sudoku puzzle Y*/
  remap(Y,X),  /*X now has no open variables, close open variables in Y*/
  atomic_list_concat(X,R).  /*unify R with string for solution*/

/*Open variables should trivially unify*/
num_map(X,Y):-var(Y),var(X).
/*Otherwise remap between valid decimals and hex chars*/
num_map(0,0).
num_map(1,1).
num_map(2,2).
num_map(3,3).
num_map(4,4).
num_map(5,5).
num_map(6,6).
num_map(7,7).
num_map(8,8).
num_map(9,9).
num_map(10,a).
num_map(11,b).
num_map(12,c).
num_map(13,d).
num_map(14,e).
num_map(15,f).

/*remap between hex char and numeral atomic list*/
remap([],[]).
remap([H1|T1],[H2|T2]):-
  num_map(H1,H2),
  remap(T1,T2).

/**to matrix receives list X and makes matrix Y*/
to_matrix([],[]).
to_matrix(X,Y):-
  X = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P|TailX],
  Y = [[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P]|TailY],
  to_matrix(TailX, TailY).

/*creates matrix from list and solves sudoku*/
sudoSolver(X):-
  to_matrix(X,Y),
  Y = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P],  
  sudoku(Y).

/*solves sudoku puzzle for input 16x16 matrix holding values between 0-15*/
sudoku(Row) :-  
  append(Row, Vars),
  Vars ins 0..15,
  maplist(all_distinct, Row),
  transpose(Row, Col),     
  maplist(all_distinct, Col),     
  Row = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P],
  blocks(A,B,C,D),
  blocks(E,F,G,H),
  blocks(I,J,K,L),
  blocks(M,N,O,P),
  maplist(label, Row).

/*checks each block in matrix is unique*/ 
blocks([], [], [], []).
blocks([A,B,C,D|BL1], [E,F,G,H|BL2], [I,J,K,L|BL3], [M,N,O,P|BL4]) :-
  all_distinct([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P]),      
  blocks(BL1, BL2, BL3, BL4).
