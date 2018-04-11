twoMachTaskToInts([],[],_).
twoMachTaskToInts([[40,Fst,44,Snd,41|Rest]|Raw],Out,ErrFlag):- subtract(Rest," ",Emp),
    (Emp \= [] *-> (ErrFlag is -1, Out = 'Error while parsing input file'); (machToDig(Fst,FstNum) *-> (taskToDig(Snd,SndNum) *-> (twoMachTaskToInts(Raw,Mid,ErrFlag),
    append([[FstNum,SndNum]],Mid,Out)); (ErrFlag is -2, Out = 'invalid machine/task')); (ErrFlag is -2, Out = 'invalid machine/task') ) ).
twoMachTaskToInts(_,'Error while parsing input file',-1).

twoTaskTaskToInts([],[],_).
twoTaskTaskToInts([[40,Fst,44,Snd,41|Rest]|Raw],Out,ErrFlag):- subtract(Rest," ",Emp),
    (Emp \= [] *-> (ErrFlag is -1, Out = 'Error while parsing input file'); (taskToDig(Fst,FstNum) *-> (taskToDig(Snd,SndNum) *-> (twoTaskTaskToInts(Raw,Mid,ErrFlag),
    append([[FstNum,SndNum]],Mid,Out)); (ErrFlag is -2, Out = 'invalid machine/task')); (ErrFlag is -2, Out = 'invalid machine/task') ) ).
twoTaskTaskToInts(_,'Error while parsing input file',-1).
 
	
%ErrFlag is 0 for good, -1 for garbage, -2 for invalid penalty
thrBrackToInts([],[],_).
thrBrackToInts([[40,Fst,44,Snd,44|Rest]|Raw],Out,ErrFlag):- subtract(Rest," ",RestNoSpc),
    nth(End,RestNoSpc,41),
	Last is End-1,
	take(Last,RestNoSpc,Thd),
	drop(End,RestNoSpc,Emp),
	(Emp \= [] *-> (ErrFlag is -1); (taskToDig(Fst,FstNum) *-> (taskToDig(Snd,SndNum) *-> (toLongNum(Thd,ThdNum) *-> (thrBrackToInts(Raw,Mid,ErrFlag),
    append([[FstNum,SndNum,ThdNum]],Mid,Out)); ErrFlag is -4); ErrFlag is -3); ErrFlag is -3)).
thrBrackToInts(_,'Error while parsing input file',-1).

%thrBrackToInts(_,_,-2). %Need to catch illegal penalty somehow...
	
	
penToDig(X,Y):- X>=48, X=<57, Y is X-48.
taskToDig(X,Y):- X>=65, X=<72, Y is X-64.
machToDig(X,Y):- X>=49, X=<56, Y is X-48.

toLongNum([],0).
toLongNum([X|Xs],Y):- toLongNum(Xs,Mid),
    length(Xs,Pow),
    penToDig(X,Dig),
    Y is (Dig*(10**Pow))+Mid.

loopLongNum([],[]).
loopLongNum([X|Xs],Y):- loopLongNum(Xs,Mid),
    toLongNum(X,Num),
    append([Num],Mid,Y).