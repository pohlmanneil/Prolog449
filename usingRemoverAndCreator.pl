main:-
    [remover,creator,penaltyOf],
	
	assigsWithZero([1,2,3,4,5,6,7,8],W),
    %write(W),nl,
    
	loopRemoveNonForced(W,[[1,1],[2,2],[3,3],[4,4]],X),
	
    %removeTooClose(X,[1,3],XBetter),
    %write(XBetter),nl,

    %removeTooClose(XBetter,[3,4],Mid),
    %removeTooClose(Mid,[4,3],XBest),
    %write(XBest),nl,

    %removeBadAssig(XBest,[1,1],Uhh),
    %write(Uhh),nl,
	
    loopRemoveTask(X,[[5,5]],LoopTest2),
    
	%write('Removing list of illegal Mach Task assignments: '), nl,nl,
    %write(LoopTest2),nl,
    %write('Removing list of Too Close assignments: '), nl,nl,
    
    loopRemoveClose(LoopTest2,[[8,7],[5,6]],LoopTest),
    
    write(LoopTest),nl,
	
    loopClosePenal(LoopTest,[[6,5,100],[7,8,25],[2,3,50]],Y),
    loopTaskPenal(Y,[[6,6,37],[2,2,27],[8,8,54],[4,4,79]],Z),
    write(Z).
