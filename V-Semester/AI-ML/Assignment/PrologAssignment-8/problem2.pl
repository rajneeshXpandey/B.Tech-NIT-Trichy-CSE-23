% | Connectives whit the traditional name
:- op(650, xfy, <->).        /* equivalence  */ 
:- op(640, xfy, -->).        /* implication  */ 
:- op(630, xfy, ∨).          /* disjunction  */ 
:- op(620, xfy, ∧).          /* conjunction  */ 
:- op(610, fy,  ~).          /* negation     */ 

% | remove biconditionals using equivalence
cnf(A,F) :- doubleImplication(A,Z), Z=F.
% | cnf remove conditional using equivalence
cnf(A,F) :- implication(A,Z), Z=F.
% | cnf conjuntion elemental and
cnf(A,F) :- conjuntion(A,Z), Z=F.
% | cnf disjunction elemental or
cnf(A,F) :- disjunction(A,Z), Z=F.
% | cnf negation definition
cnf(A,F) :- negation(A,Z), Z=F.
% | otherwise atomic PROP'
cnf(A,F) :- atomic(A,Z), Z=F.

% | double implication <->
doubleImplication(~(A<->B),F) :- cnf(A-->B,X) , cnf(B-->A,Y) , cnf(~(X∧Y),F).
doubleImplication(A<->B,F) :- cnf(A-->B,X) , cnf(B-->A,Y) , cnf((X∧Y),F).

% | cnf denials implication ->
implication(~(A-->B),F) :- cnf(A-->B,W) , cnf(~(W),F).
% | cnf implication elemental ->
implication(A-->B,F) :- cnf(~(A),X) , cnf(B,Y) , cnf(X∨Y,F).

% | cnf conjuntion elemental and
% | Using De Morgan’s laws
conjuntion(~(A∧B),F) :- cnf(~(A),X) , cnf(~(B),Y) , disjunction((X∨Y),F).
conjuntion(A∧B,F) :- cnf(A,X) , cnf(B,Y) , (X∧Y) = F.

% | cnf disjunction elemental or
disjunction(A∨(B∧C),F) :- disjunction(A∨B,X) , disjunction(A∨C,Y) , (X∧Y) = F.
disjunction((A∧B)∨C,F) :- disjunction(A∨B,X) , disjunction(A∨C,Y) , (X∧Y) = F.
% | cnf Denials disyunciones'
% | Using De Morgan’s laws
disjunction(~(A∨B),F) :- cnf(~(A),X) , cnf(~(B),Y) , conjuntion((X∧Y),F).
disjunction(A∨B,F) :- cnf(A,X) , cnf(B,Y) , (X∨Y) = F.

% | cnf of two negation
negation(~(~X),F) :- cnf(X,F).
% | cnf of negation
negation(~A,F) :- cnf(A,Z), ~Z = F.

% | cnf atomic proposition definition
atomic(A,F) :- A=F.