main:-
    [remover,creator,penaltyOf],
	
	assigsWithZero([1,2,3,4],X),
    %write(X),nl,
    
	
    %removeTooClose(X,[1,3],XBetter),
    %write(XBetter),nl,

    %removeTooClose(XBetter,[3,4],Mid),
    %removeTooClose(Mid,[4,3],XBest),
    %write(XBest),nl,

    %removeBadAssig(XBest,[1,1],Uhh),
    %write(Uhh),nl,
	%loopRemoveTask(X,[[1,1],[2,2],[3,3],[4,4],[5,5],[6,6]],LoopTest2),
	%write('Removing list of illegal Mach Task assignments: '), nl,nl,
	%write(LoopTest2),nl,
	%write('Removing list of Too Close assignments: '), nl,nl,
    %loopRemoveClose(LoopTest2,[[1,2],[2,3],[3,4],[4,5],[5,6]],LoopTest),
	%write(LoopTest),nl.
	
	loopClosePenal(X,[[1,2,100],[3,4,25],[2,3,50]],Y),
	loopTaskPenal(Y,[[1,1,37],[2,2,27],[3,3,54],[4,4,79]],Z),
	write(Z).