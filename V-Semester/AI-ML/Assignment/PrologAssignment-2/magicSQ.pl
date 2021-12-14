/* 106119100 Rajneesh Pandey */

/* initializes a list with all values 0 */
initialize_list(0, []).

initialize_list(Count, [0|T]):-
	Rem is Count - 1,
	initialize_list(Rem, T).

/* sets a value in a list at given index */
set_values([], _, _, []).

set_values([_|T], 0, Val, [Val|T]).

set_values([H|T], Index, Val, [H|T_]):-
	Next is Index - 1,
	set_values(T, Next, Val, T_).

/* gets the value from a list at given index */
get_values([], _, 0).

get_values([H|_], 0, H).

get_values([_|T], Index, Val):-
	Next is Index - 1,
	get_values(T, Next, Val).

/* calculates sum of a list */
list_sum([], 0).

list_sum([H|T], Sum):-
	list_sum(T, Rem),
	Sum is H + Rem.

/* creates a copy of a list */
list_copy(List, List).

/* finds the next index to be filld in the list */
next_index(List, N, Row, Col, Row_, Col_):-
	X is Row - 1,
	Y is Col + 1,

	(	(X =:= -1, Y =:= N) ->
			X_ is 0,
			Y_ is N - 2
	;
		(	X =:= -1 ->
				X_ is N - 1;
			X_ is X
		),
		(	Y =:= N ->
				Y_ is 0;
			Y_ is Y
		)
	),

	Index is ((X_ * N) + Y_),
	get_values(List, Index, Current),

	(	Current =\= 0 ->
			X__ is X_ + 1,
			Y__ is Y_ - 2;
		X__ is X_,
		Y__ is Y_
	),

	Row_ is X__,
	Col_ is Y__.

/* fills an initialized list with magicSQ square values */
fill(List, Offset, N, Row, Col, Num, Result):-
	Index is ((Row * N) + Col),
	Val is Offset + Num,
	set_values(List, Index, Val, New),

	(	(Row =:= floor(N / 2), Col =:= 0) ->
			list_copy(New, Result)
	
	;
		next_index(New, N, Row, Col, Row_, Col_),
		Next is Num + 1,
		fill(New, Offset, N, Row_, Col_, Next, Result)
	).

/* displays a list as a square */
display_square(_, 0, _):-
	nl, nl.

display_square([H|T], Size, N):-
	(	Size mod N =:= 0 ->
			nl, nl
	;
		true
	),

	write(H), write('\t'),
	Size_ is Size - 1,
	display_square(T, Size_, N).

magicSQ(N, List):-
	Size is N * N,
	initialize_list(Size, Initial),
	random(21, 31, Offset),
	Row is floor(N / 2),
	Col is N - 1,
	fill(Initial, Offset, N, Row, Col, 1, List),
	list_sum(List, Sum_),
	Sum is Sum_ / N,
	display_square(List, Size, N),
	write('Sum of each row/column/diagonal: '), write(Sum), nl, nl.
