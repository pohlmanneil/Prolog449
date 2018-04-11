twoBrackToInts([],[],_).
twoBrackToInts([H|Raw],Out,ErrFlag):- subtract(H,"(,) ",[Fst,Snd|Emp]),
    (Emp \= [] *-> (ErrFlag is -1); Foo is 0),
    toDig(Fst,FstNum),
	toDig(Snd,SndNum),
	twoBrackToInts(Raw,Mid,ErrFlag),
	append([[FstNum,SndNum]],Mid,Out).

	
%ErrFlag is 0 for good, -1 for garbage, -2 for invalid penalty
thrBrackToInts([],[],_).
thrBrackToInts([H|Raw],Out,ErrFlag):- subtract(H,"(, ",[Fst,Snd|Rest]),
    nth(End,Rest,41),
	Last is End-1,
	take(Last,Rest,Thd),
	drop(End,Rest,Emp),
	(Emp \= [] *-> (ErrFlag is -1); Foo is 0),
    toDig(Fst,FstNum),
    toDig(Snd,SndNum),
    toLongNum(Thd,ThdNum),
    thrBrackToInts(Raw,Mid,ErrFlag),
    append([[FstNum,SndNum,ThdNum]],Mid,Out).

%thrBrackToInts(_,_,-2). %Need to catch illegal penalty somehow...
	
	
toDig(X,Y):- X>=48, X=<57, Y is X-48.
toDig(X,Y):- X>=65, X=<72, Y is X-64.

toLongNum([],0).
toLongNum([X|Xs],Y):- toLongNum(Xs,Mid),
    length(Xs,Pow),
    toDig(X,Dig),
    Y is (Dig*(10**Pow))+Mid.