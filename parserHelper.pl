%%changes text from list of ints to list of lists, each list being a line.
splitTheText([],[]).
splitTheText(Text,Out):- append(A1,[13,10|A2],Text), %splitting at end-of-line
    splitTheText(A2,Mid),
    append([A1],Mid,Some),
    subtract(Some, [[],[32]], Out).
splitTheText(Text,Out):- append(A1,[10|A2],Text), %splitting at end-of-line
    splitTheText(A2,Mid),
    append([A1],Mid,Some),
    subtract(Some, [[],[32]], Out).
splitTheText(Text,[Text]).

splitOnSpace([],[]).
splitOnSpace(Text,Out):- append(A1,[32|A2],Text), %splitting at space
    splitOnSpace(A2,Mid),
    append([A1],Mid,Some),
    subtract(Some, [[],[32]], Out).
splitOnSpace(Text,[Text]).

checkCharAndReadRest(end_of_file,[],_):-!.
checkCharAndReadRest(-1,[],_):-!.
checkCharAndReadRest(Char,[Char|Chars],Instream):-
    get_code(Instream,NextChar),
	checkCharAndReadRest(NextChar,Chars,Instream).

matchPenTrip([],[],_,_).
matchPenTrip([H|TextIn],TextOut,CounterRow,CounterCol) :- append([CounterRow,CounterCol],[H],Mid),
    (CounterCol == 8 *-> (NewRow is CounterRow + 1,NewCol is 1); (NewCol is CounterCol + 1, NewRow is CounterRow)),
    matchPenTrip(TextIn,Out,NewRow,NewCol),
    append([Mid],Out,TextOut).

