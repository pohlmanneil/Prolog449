main:-
    assigsWithZero([1,2,3,4],X),
    write(X),nl,

    removeTooClose(X,[1,3],XBetter),
    write(XBetter),nl,

    removeTooClose(XBetter,[3,4],Mid),
    removeTooClose(Mid,[4,3],XBest),
    write(XBest),nl,

    removeBadAssig(XBest,[1,1],Uhh),
    write(Uhh),nl.
