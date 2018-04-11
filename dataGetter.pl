%%Data is either the wanted data, or an error code
%%RestOfText is either the text, with the data dropped, or the error message corresponding to Data.

getData([H|Text],Data,RestOfText,Err):- H == "forced partial assignment:",
    nth(Next,Text,"forbidden machine:"),
    Len is Next-1,
    split(Len,Text,RawDat,RestOfText),
    twoMachTaskToInts(RawDat,Data,Err).

getData([H|Text],Data,RestOfText,Err):- H == "forbidden machine:",
    nth(Next,Text,"too-near tasks:"),
    Len is Next-1,
    split(Len,Text,RawDat,RestOfText),
    twoMachTaskToInts(RawDat,Data,Err).

getData([H|Text],Data,RestOfText,Err):- H == "too-near tasks:",
    nth(Next,Text,"machine penalties:"),
    Len is Next-1,
    split(Len,Text,RawDat,RestOfText),
    twoTaskTaskToInts(RawDat,Data,Err).

getData([H|Text],Data,RestOfText,Err):- H == "machine penalties:",
    nth(Next,Text,"too-near penalities"),
    Len is Next-1,
    split(Len,Text,RawDat,RestOfText),
    lineRemover(RawDat,SingleDat),
	splitOnSpace(SingleDat,LofLNum),
	(loopLongNum(LofLNum,IntPensList) *-> (length(IntPensList,64) *-> matchPenTrip(IntPensList,Data,1,1);
	(Err is -5,write(IntPensList))) ; Err is -4).
	
	%TODO: Fix lineRemover so that it does not concatenate last element of line with first elemenet of following line!!!!!
	%might also be in splitOnSpace. but probably not..

getData([H|Text],Data,RestOfText,Err):- H == "too-near penalities",
    thrBrackToInts(Text,Data,Err), RestOfText = 'Empty'.

getData(Text,[],'Error while parsing input file',-1).
	
	
take(N, _, Xs):- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- M is N-1, take(M, Xs, Ys).

drop(N,Xs,Ys):- N =< 0, !, N=:= 0, Ys = Xs.
drop(N,[X|Xs],R):- N >0,
    N1 is N-1,
    drop(N1,Xs,R).
	
split(N,Xs,X,Y):- take(N,Xs,X),drop(N,Xs,Y).