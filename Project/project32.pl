:- op(900,xfx,::).
:- op(880,xfx,then).
:- op(870,fx,if).
:- op(850,xfx,cert).
:- op(800,xfx,was).
:- op(550,xfy,or).
:- op(540,xfy,and).
:- op(300,fx,'derived by').
:- op(600,xfx,from).
:- op(600,xfx,by).
:- dynamic (::)/2.
:- dynamic fact/1.
:- op(100, xfx, [has, gives, isa, eats, 'does not', 'made in', 'runs on', 'takes off', stays, lays, was_connected_to]).
:- op(100, xf, [swims, flies, failed]).
:- op(300, xfx, 'with certainty ').
:- dynamic cert/2.
:- dynamic was_told/2.

explore(Goal, _, Goal 'with certainty ' Certainty was 'found as a fact', Certainty) :- fact(Goal) cert Certainty.

explore(Goal, Trace, Goal 'with certainty ' Certainty was 'derived by' Rule from Answer, Certainty) :- check_cycles(Goal, Trace, [], Cycles), 
																								  falsity(Cycles),
																								 Rule :: if Condition then Goal cert C1,
																			  					  explore(Condition, [Goal by Rule|Trace], Answer, C2),
																			  					  Certainty is C1 * C2.

explore(Goal1 and Goal2, Trace, Answer, Certainty) :- explore(Goal1, Trace, Answer1, C1),
													  explore(Goal2, Trace, Answer2, C2),
													  Answer = Answer1 and Answer2,
													  min(C1, C2, Certainty).

explore(Goal1 or Goal2, Trace, Answer, Certainty) :- explore(Goal1, Trace, Answer1, C1), 
													 explore(Goal2, Trace, Answer2, C2),
													 Answer = Answer1 or Answer2,
													 max(C1, C2, Certainty).

explore(Goal, Trace, Goal 'with certainty ' Certainty was told, Certainty) :- useranswer(Goal, Trace, Certainty).


falsity(false).
%%Finding if an answer is true or false%%
certainty(_ 'with certainty ' Certainty was _, Certainty) :- !.

certainty(Answer1 and Answer2, Certainty) :- certainty(Answer1, C1),
											 certainty(Answer2, C2),
											 min(C1, C2, Certainty).

certainty(Answer1 or Answer2, Certainty) :- certainty(Answer1, C1),
									  	 	certainty(Answer2, C2),
											max(C1, C2, Certainty).

max(C1, C2, C1) :- C1 > C2, !.
max(_, C2, C2) :- true.

min(C1, C2, C1) :- C1 < C2, !.
min(_, C2, C2) :- true.

check_cycles(_, [], _, false). %check_cycles(Goal, [], FinishedTrace, false).
check_cycles(Goal, [Goal by Rule|_], FinishedTrace, true) :- !, nl, write('Cycle in rules. Couldn\'t proceed further.'), nl, 
																	write('Do you want to see how?'), nl, 
																	read(Reply),  
																	(expand(Reply, yes), showtrace([Goal by Rule|FinishedTrace]); true).
check_cycles(Goal, [Goal2 by Rule|Trace], FinishedTrace, Answer) :- check_cycles(Goal, Trace, [Goal2 by Rule | FinishedTrace], Answer).


%%Asking and getting user's answer to a goal
useranswer(Goal, Trace, Certainty) :- instantiated(Goal), !, (was_told(Goal, Certainty); ask(Goal, Trace, Certainty), assert(was_told(Goal, Certainty))).
useranswer(Goal, Trace, Certainty) :- askable(Goal,ExternFormat), format(Goal,ExternFormat,Question,[],Variables), 
									  ask(Goal, Question, Trace, Variables, Certainty), asserta(was_told(Goal,Certainty)).

ask(Goal, Trace, Certainty) :- 	  introduce(Goal),
						  		  getreply(Reply),
						  		  process(Reply, Goal, Trace, Certainty).

ask(Goal, Question, Trace, Variables, Certainty) :- 	  introduce(Question),
									  		  getreply(Reply),
						  		  		      processUn(Reply, Goal, Question, Trace, Variables, Certainty).

introduce(Goal) :- nl, write('Is it true: '), write(Goal), write('?'), nl.
getreply(Reply) :- read(Answer), write(Answer), expand(Answer, Reply), !;
				   nl, write('Unknown reply, please try again'), nl, getreply(Reply).
expand(yes,yes).
expand(y,yes).
expand(no,no).
expand(n,no).
expand(why,why).
expand(w,why).
expand(Certainty, Certainty) :- (float(Certainty); integer(Certainty)), (Certainty > 0; Certainty =:= 0), (Certainty < 1; Certainty =:= 1).

process(why, Goal, Trace, Certainty) :- showtrace(Trace), ask(Goal, Trace, Certainty).
process(yes, _, _, 1).  %process(yes, Goal, Trace, 1).
process(no, _, _, 0). %process(no, Goal, Trace, 0).
process(Certainty, _, _, Certainty) :- float(Certainty), Certainty >= 0, Certainty =< 1.

showtrace([]).
showtrace([Goal by Rule|Trace]) :-  nl, write('To investivagate by '), write(Rule), write(', '), write(Goal), 
									showtrace(Trace).



processUn(why, Goal, Question, Trace, Variables, Certainty) :- showtrace(Trace), ask(Goal, Question, Trace, Variables, Certainty).
processUn(yes, Goal, _, _, Variables, Certainty) :- askvars(Variables), nl, write('Please enter Certainty: '), 
																read(Certainty), (integer(Certainty); float(Certainty)), Certainty >= 0, Certainty =< 1,
																asserta(was_told(Goal, Certainty)).
processUn(no, _, _, _, _, 0).  %processUn(no, Goal, Question, Trace, Variables, 0).
%processUn(Certainty, Goal, Question, Trace, Variables, Certainty) :- float(Certainty), Certainty >= 0, Certainty =< 1.

instantiated(Term) :-
	numbervars(Term,0,0).


askvars([]).
askvars([Variable/Name | Variables]) :- 
				 nl,write(Name),write('='),
				 read(Variable),
				 askvars(Variables).


format( Var, Name, Name, Vars, [Var/Name|Vars])  :-
  var( Var), !.

format( Atom, Name, Atom, Vars, Vars)  :-
  atomic( Atom),  !,
  atomic( Name).

format( Goal, Form, Question, Vars0, Vars)  :-
  Goal =.. [Functor|Args1],
  Form =.. [Functor|Forms],
  formatall( Args1, Forms, Args2, Vars0, Vars),
  Question =.. [Functor|Args2], !.

% If formatting failed due to structural difference format Goal after itself

format( Goal, _, Question, Vars0, Vars)  :-
  format( Goal, Goal, Question, Vars0, Vars).

formatall( [], [], [], Vars, Vars).

formatall( [X|XL], [F|FL], [Q|QL], Vars0, Vars)  :-
  formatall( XL, FL, QL, Vars0, Vars1),
  format( X, F, Q, Vars1, Vars).

% instance-of( T1, T2) means: instance of T1 is T2; that is
% term T1 is more general than T2 or equally general as T2

instance_of( Term, Term1)  :-   % Instance of Term is Term1
  copy_term( Term1, Term2),     % Copy of Term1 with fresh set of variables
  numberrvarss( Term2, 0, _), !,
  Term = Term2.                 % This succeeds if Term1 is instance of Term

freshcopy( Term, FreshTerm)  :- % Make a copy of Term with variables renamed
  asserta( copy( Term)),
  retract( copy( FreshTerm)), !.


nextindex( Next)  :-            % Next free index for 'wastold'
  retract( lastindex( Last)), !,
  Next is Last + 1,
  assert( lastindex( Next)).


was_told(something, 0).


%askable(_ gives _).
%askable(_ flies).
%askable(_ lays eggs).
%askable(_ eats _).
%askable(_ has _).
%askable(_ 'does not' _).
%askable(_ swims).
%askable(_ isa 'good flier').
%askable(_ isa _).


askable(_ 'made in' _,'Vehicle' 'made in' 'Someplace' ).
askable(_ 'runs on' _,'Vehicle' 'runs on' 'Somewhere' ).
askable(_ 'takes off' _,'Vehicle' 'takes off' 'Somehow' ).


askable(_ gives _,'Vehicle' gives 'Something' ).
askable(_ flies,'Vehicle' flies ).
askable(_ stays _,'Vehicle' stays 'Somewhere').
askable(_ lays eggs,'Vehicle' lays eggs).
askable(_ eats _,'Vehicle' eats 'Something' ).
askable(_ has _,'Vehicle' has 'Something' ).
askable(_ 'does not' _,'Vehicle' 'does not' 'Something' ).
askable(_ swims,'Vehicle' swims ).
askable(_ isa 'good flier','Vehicle' isa 'good flier' ).
askable(_ isa _,'Vehicle' isa 'Something' ).

listwastold :- forall(was_told(X,Y), writewastold(X,Y)).
writewastold(X,Y) :- nl, write(X), write(Y).
