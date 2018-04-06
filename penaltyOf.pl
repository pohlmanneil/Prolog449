%%Looper Remover (Removes lists of pairs)%%

%removes any assignments in Assigns that contains any pair assignment from IllPairList.
loopClosePenal(Assigns,[H],NewAssigns):- removeTooClose2(Assigns,H,NewAssigns).
loopClosePenal(Assigns,[H|IllPairList],NewAssigns):- loopClosePenal(Assigns,IllPairList,Mid),
    removeTooClose2(Mid,H,NewAssigns).

%removes any assignments in Assigns that contain any machTask in MachTaskList.
loopTaskPenal(Assigns,[H],NewAssigns):- removeBadAssig2(Assigns,H,NewAssigns).
loopTaskPenal(Assigns,[H|MachTaskList],NewAssigns):- loopTaskPenal(Assigns,MachTaskList,Mid),
    removeBadAssig2(Mid,H,NewAssigns).


%%Single Pair Removers%%

%removes any assignments in Assigns that contains the neighbour IllPair.
removeTooClose2([],_,[]).
removeTooClose2([H|Assigns],IllPair,NewAssigns):- removeTooClose2(Assigns,IllPair,Mid),
    isSublist2(IllPair,H,EmpOrAssig),
    append(EmpOrAssig,Mid,NewAssigns).


%removes any assignments in Assigns that contains the MachTask IllMachTask
removeBadAssig2([],_,[]).
removeBadAssig2([H|Assigns],IllMachTask,NewAssigns):-removeBadAssig2(Assigns,IllMachTask,Mid),
    isAssigned2(IllMachTask,H,EmpOrAssig),
	append(EmpOrAssig,Mid,NewAssigns).



%%Helpers%%

%%add penalty if close trip is in H%%
isSublist2(CloseTrip,H,[AssigWithPenal]):-neighboursIn2(CloseTrip,H),
    nth(9,H,OldPenal),
	nth(3,CloseTrip,AddPenal),
	NewPenal is OldPenal+AddPenal,
	replaceInThePosition(H,9,NewPenal,AssigWithPenal).
isSublist2(IllPair,H,[H]).

%%True if IllPair(0) and IllPair(1) are concurrent in Assign%%
neighboursIn2(IllPair,Assign):-
    nth(1,IllPair,Task0),
    nth(2,IllPair,Task1),
    nth(X,Assign,Task0),
    setTheY2(X,Y),
    nth(Y,Assign,Task1).

setTheY2(X,Y):-X=:=8, Y is 1.
setTheY2(X,Y):- Y is X+1.

%%add penalty if MachTaskTrip is in H%%
isAssigned2(MachTaskTrip,H,[AssigWithPenal]):-assignedIn2(MachTaskTrip,H),
    nth(9,H,OldPenal),
	nth(3,MachTaskTrip,AddPenal),
	NewPenal is OldPenal+AddPenal,
	replaceInThePosition(H,9,NewPenal,AssigWithPenal).
isAssigned2(IllMachTask,H,[H]).

%%True if IllMachTask is assigned in Assign%%
assignedIn2(IllMachTask,Assign):-
    nth(1,IllMachTask,Mach),
	nth(2,IllMachTask,Task),
	nth(Mach,Assign,X),
	X=Task.
	
	
	
	
replaceInThePosition([_|T],1,Element,[Element|T]).
replaceInThePosition([H|T],Pos,Element,[H|R]) :-
    Pos > 1, NewPos is Pos-1, replaceInThePosition(T,NewPos,Element,R).