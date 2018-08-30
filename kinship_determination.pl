sex('Nikolay Bezlutskiy',m).
sex('Lyudmila Tretyakova',f).
sex('Elizaveta Bezlutskaya',f).
sex('Valentina Lukashova',f).
sex('Nikolay Tretyakov',m).
sex('Anna Zaitseva',f).
sex('Alexander Bezlutskiy',m).
sex('Vladimir Tretyakov',m).
sex('Victoria Bezlutskaya',f).
sex('Svetlana Nesterenko',f).
sex('Danislav Tretyakov',m).
sex('Bogdan Tretyakov',m).
sex('Olga Morozova',f).
sex('Daniil Lukashov',m).
sex('Maria Krepova',f).
sex('Vyacheslav Tretyakov',m).
sex('Fedor Bezlutskiy',m).
sex('Michael Bezlutskiy',m).
sex('Yana Duk',f).
sex('Marina Bezlutskaya',f).
sex('Vladislav Bezlutskiy',m).
sex('Anna Spivak',f).
sex('Konstantin Bezlutskiy',m).
sex('Julia Titova',f).
sex('Ekaterina Bezlutskaya',f).
parents('Elizaveta Bezlutskaya','Nikolay Bezlutskiy','Lyudmila Tretyakova').
parents('Victoria Bezlutskaya','Nikolay Bezlutskiy','Lyudmila Tretyakova').
parents('Vladimir Tretyakov','Nikolay Tretyakov','Valentina Lukashova').
parents('Lyudmila Tretyakova','Nikolay Tretyakov','Valentina Lukashova').
parents('Michael Bezlutskiy','Alexander Bezlutskiy','Anna Zaitseva').
parents('Fedor Bezlutskiy','Alexander Bezlutskiy','Anna Zaitseva').
parents('Nikolay Bezlutskiy','Alexander Bezlutskiy','Anna Zaitseva').
parents('Bogdan Tretyakov','Vladimir Tretyakov','Svetlana Nesterenko').
parents('Danislav Tretyakov','Vladimir Tretyakov','Svetlana Nesterenko').
parents('Valentina Lukashova','Daniil Lukashov','Olga Morozova').
parents('Nikolay Tretyakov','Vyacheslav Tretyakov','Maria Krepova').
parents('Marina Bezlutskaya','Michael Bezlutskiy','Yana Duk').
parents('Alexander Bezlutskiy','Vladislav Bezlutskiy','Anna Spivak').
parents('Konstantin Bezlutskiy','Vladislav Bezlutskiy','Anna Spivak').

trans([_],[]):-!.
trans([First,Second|Tail],ResList):-
    relship(Relation,First,Second),
    ResList = [Relation|Tmp],
    trans([Second|Tail],Tmp),!.

relative(A, B, Res) :-
	search_relative(A, B, C),
	trans(C, Res).

move(X, Y) :- 
	relship(_, X, Y).

prolong([X|T], [Y,X|T]) :-
	move(X,Y), \+(member(Y,[X|T])).

search_relative(A, B, Res) :-
	bdth_relative([[A]], B, P), reverse(P, Res).

bdth_relative([[X|T]|_], X, [X|T]).
bdth_relative([P|QI],X,R) :-
	findall(Z, prolong(P,Z),T),
	append(QI,T,QO), !,
	bdth_relative(QO,X,R).
bdth_relative([_|T],Y,L) :-
	bdth_relative(T,Y,L).

relship(husband, Husband, Wife) :-
	parents(_, Husband, Wife).

relship(wife, Wife, Husband) :-
	parents(_,Husband,Wife).

relship(mother, Mother, Child) :-
	parents(Child, _, Mother).

relship(father, Father, Child) :-
	parents(Child, Father, _).

relship(parent, Parent, Child) :-
	parents(Child, Parent, _); parents(Child, _, Parent).

relship(son, Son, Parent) :-
	(parents(Son, Parent, _); parents(Son, _, Parent)),
	sex(Son, m).

relship(daughter, Daughter, Parent) :-
	(parents(Daughter, Parent, _); parents(Daughter, _, Parent)),
	sex(Daughter, f).

relship(child, Child, Parent) :-
	(parents(Child, Parent, _); parents(Child, _, Parent)).

relship(brother, X, Y) :-
	(parents(X, Father, _), parents(Y, Father, _)), X \= Y, !; 
	(parents(X, _, Mother), parents(Y, _, Mother)), X \= Y, !,
	sex(X, m).

relship(sister, X, Y) :-
	(parents(X, Father, _), parents(Y, Father, _)), X \= Y, !;
	(parents(X, _, Mother), parents(Y, _, Mother)), X \= Y, !,
	sex(X, f).
