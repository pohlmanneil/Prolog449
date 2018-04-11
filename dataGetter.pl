%%Data is either the wanted data, or an error code
%%RestOfText is either the text, with the data dropped, or the error message corresponding to Data.

getData([H|Text],Data,RestOfText):- H == "forced partial assignment:",
    nth(Next,Text,"forbidden machine:"),
    Len is Next-1,
    split(Len,Text,RawDat,RestOfText),
    twoMachTaskToInts(RawDat,Data,Err).

getData([H|Text],Data,RestOfText):- H == "forbidden machine:",
    nth(Next,Text,"too-near tasks:"),
    Len is Next-1,
    split(Len,Text,RawDat,RestOfText),
    twoMachTaskToInts(RawDat,Data,Err).

getData([H|Text],Data,RestOfText):- H == "too-near tasks:",
    nth(Next,Text,"machine penalties:"),
    Len is Next-1,
    split(Len,Text,RawDat,RestOfText),
    twoTaskTaskToInts(RawDat,Data,Err).

getData([H|Text],Data,RestOfText):- H == "machine penalties:",
    nth(Next,Text,"too-near penalities"),
    Len is Next-1,
    split(Len,Text,RawDat,RestOfText). %TODO: Add parser for int grid

getData([H|Text],Data,RestOfText):- H == "too-near penalities",
    thrBrackToInts(Text,MaybeData,ErrFlag),
    (ErrFlag == -1 *-> (Data = -1, RestOfText = 'GARBAGE', Foo is 1); Foo is 0),
    (ErrFlag == -2 *-> (RestOfText = 'invalid penalty', Data = -1, Bar is 1); Bar is 0),
    Tik is (Foo + Bar),
	(Tik == 0 *-> (Data = MaybeData, RestofText = []); Wee is 0).

getData([H|Text],Data,RestOfText):- H == 

getData(Text,-1,'Error while parsing input file').
	
	
take(N, _, Xs):- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- M is N-1, take(M, Xs, Ys).

drop(N,Xs,Ys):- N =< 0, !, N=:= 0, Ys = Xs.
drop(N,[X|Xs],R):- N >0,
    N1 is N-1,
    drop(N1,Xs,R).
	
split(N,Xs,X,Y):- take(N,Xs,X),drop(N,Xs,Y).