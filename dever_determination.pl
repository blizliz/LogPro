
dever(X, Y) :-
	consult('famPred.pl'),
	sex(X,f),
	parents(_, Husb, X),
	(parents(Husb, Father, _), parents(Y, Father, _), Husb \= Y;
	parents(Husb, _, Mother), parents(Y, _, Mother), Husb \= Y),
	sex(Y,m).