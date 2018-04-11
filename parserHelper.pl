%%changes text from list of ints to list of lists, each list being a line.
splitTheText([],[]).
splitTheText(Text,Out):- append(A1,[13,10|A2],Text), %splitting at end-of-line
    splitTheText(A2,Mid),
    append([A1],Mid,Some),
    subtract(Some, [[]], Out).
splitTheText(Text,Out):- append(A1,[10|A2],Text), %splitting at end-of-line
    splitTheText(A2,Mid),
    append([A1],Mid,Some),
    subtract(Some, [[]], Out).
splitTheText(Text,[Text]).



checkCharAndReadRest(end_of_file,[],_):-!.
checkCharAndReadRest(-1,[],_):-!.
checkCharAndReadRest(Char,[Char|Chars],Instream):-
    get_code(Instream,NextChar),
	checkCharAndReadRest(NextChar,Chars,Instream).

