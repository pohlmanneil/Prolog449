%%Looper Remover (Removes lists of pairs)%%

%removes any assignments in Assigns that contains any pair assignment from IllPairList.
loopRemoveClose(Assigns,[H],NewAssigns):- removeTooClose(Assigns,H,NewAssigns).
loopRemoveClose(Assigns,[H|IllPairList],NewAssigns):- loopRemoveClose(Assigns,IllPairList,Mid),
    removeTooClose(Mid,H,NewAssigns).

%removes any assignments in Assigns that contain any machTask in MachTaskList.
loopRemoveTask(Assigns,[H],NewAssigns):- removeBadAssig(Assigns,H,NewAssigns).
loopRemoveTask(Assigns,[H|MachTaskList],NewAssigns):- loopRemoveTask(Assigns,MachTaskList,Mid),
    removeBadAssig(Mid,H,NewAssigns).


%%Single Pair Removers%%

%removes any assignments in Assigns that contains the neighbour IllPair.
removeTooClose([],_,[]).
removeTooClose([H|Assigns],IllPair,NewAssigns):- removeTooClose(Assigns,IllPair,Mid),
    isSublist(IllPair,H,EmpOrAssig),
    append(EmpOrAssig,Mid,NewAssigns).


%removes any assignments in Assigns that contains the MachTask IllMachTask
removeBadAssig([],_,[]).
removeBadAssig([H|Assigns],IllMachTask,NewAssigns):-removeBadAssig(Assigns,IllMachTask,Mid),
    isAssigned(IllMachTask,H,EmpOrAssig),
	append(EmpOrAssig,Mid,NewAssigns).



%%Helpers%%

%%empty 3rd arg if IllPair is neighbouring in H. H 3rd arg if not neighbours%%
isSublist(IllPair,H,[]):-neighboursIn(IllPair,H).
isSublist(IllPair,H,[H]).

%%True if IllPair(0) and IllPair(1) are concurrent in Assign%%
neighboursIn(IllPair,Assign):-
    nth(1,IllPair,Task0),
    nth(2,IllPair,Task1),
    nth(X,Assign,Task0),
    setTheY(X,Y),
    nth(Y,Assign,Task1).

setTheY(X,Y):-X=:=8, Y is 1.
setTheY(X,Y):- Y is X+1.

%%empty 3rd arg if IllMachTask is assigned in H. H 3rd arg if not assigned%%
isAssigned(IllMachTask,H,[]):-assignedIn(IllMachTask,H).
isAssigned(IllMachTask,H,[H]).

%%True if IllMachTask is assigned in Assign%%
assignedIn(IllMachTask,Assign):-
    nth(1,IllMachTask,Mach),
	nth(2,IllMachTask,Task),
	nth(Mach,Assign,X),
	X=Task.