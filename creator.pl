assigsWithZero(MachList,Assigs):-
    findall(AssigWPen, (permutation(MachList,Assig),append(Assig,[0],AssigWPen) ), Assigs).
