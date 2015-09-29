%%%%%%% Interface %%%%%%%%%%%
start :- nl, write('Please enter your choice.'),nl, tab(4), write('1. Any questions?'), 
												nl, tab(4), write('2. Add some facts'), 
												nl, tab(4), write('3. Remove some facts'),
												nl, tab(4), write('4. Add some rules'),
												nl, tab(4), write('5. List facts'),
												nl, tab(4), write('6. List rules'),
		getChoice.
getChoice :-		nl, read(Reply),
					(Reply = 1, !, question;
					 Reply = 2, !, addFact;
					 Reply = 3, !, removeFact;
					 Reply = 4, !, addRule;
					 Reply = 5, !, listFact;
					 Reply = 6, !, listRules;
					 nl, write('Invalid Choice, please enter again'), nl, getChoice).

%%%Processing Questions%%%
question :-		 getQuestion(Question),
		 		 explore(Question,[],Answer,_),
		 		 showAnswer(Answer), start.

getQuestion(Question) :- nl, write('Please enter your question'), nl, read(Question).
		 
showAnswer(Answer) :- certainty(Answer, Certainty),
		 			  nl, write('True with certainty '), write(Certainty), 
		 			  nl, write('Do you want to know how? '), 
		 			  getreply(Rep),
		 			  expand(Rep, Reply),
		 			  (Reply = yes, nl, show(Answer, 0), !; true).

show(Answer1 and Answer2, Tabs) :- !, show(Answer1, Tabs), nl, tab(Tabs), write(and), nl, show(Answer2, Tabs).
show(Goal 'with certainty ' Certainty was Found, Tabs) :- tab(Tabs), write(Goal), write(' with certainty '), write(Certainty), nl, tab(Tabs), write('was '), show(Found,Tabs).
											
											%TruthValue = true, !, tab(Tabs), write(Goal), nl, tab(Tabs), write('was '), show(Found, Tabs);
											%TruthValue = false, !, tab(Tabs), write(Goal), write(' is false'), nl, tab(Tabs), write('was '), show(Found,Tabs).
show(Derived from Answer, Tabs) :- write(Derived), write(' from'), nl, Tabs2 is Tabs + 4, show(Answer, Tabs2). 
show(Found, _) :- write(Found).




%%%%Adding facts%%%%
addFact :- nl, write('Please enter fact to be added.'), nl,
		   read(Reply), (conflicts(Reply), nl, write('Fact already existing.'); 
		   				 nl, write('Please enter certainty of the fact: '), read(Certainty), 
		   				 ((float(Certainty); integer(Certainty)), Certainty >= 0, Certainty =< 1, asserta(fact(Reply) cert Certainty)); nl, write('Certainty value must be between 0 and 1')) , 
		   tell('facts.pl'), listFacts, told, 
		   nl, write('Do you want to add one more?'), nl, read(Rep), (expand(Rep, yes), !, addFact; expand(Rep, no), start; nl, write('Invalid Input.'), start).
conflicts(Fact) :- fact(Fact) cert _, !.




%%%Removing facts%%%
removeFact :- nl, write('Please enter fact to be removed.'), nl,
			  read(Fact), (fact(Fact) cert Certainty, !, retract(fact(Fact) cert Certainty), tell('facts.pl'), listFacts, told;
						   nl, write('Entered fact does not exist')),
			  nl, write('Do you want to remove one more?'), nl, read(Rep), (expand(Rep, yes), !, removeFact; expand(Rep, no), start; nl, write('Invalid Input'), start).	



%%%%Listing facts%%%%
listFact :- forall(fact(X) cert Certainty, writeFact(X, Certainty)), start.
writeFact(X, Certainty) :- write(X), write(' with certainty '), write(Certainty), write('.'), nl.

listFacts :- forall(fact(X) cert Certainty, writeFacts(X, Certainty)).
writeFacts(X, Certainty) :- write(fact(X)), write(' cert '), write(Certainty), write('.'), nl.


%%%%Adding rules%%%%
addRule :- nl, write('Please enter rule to be added.'), nl,
		   write('Rule name: '), read(Name),
		   write('if: '), read(If),
		   write('then: '), read(Then),
		   write('Certainty: '), read(Certainty),
		   ((float(Certainty); integer(Certainty)), Certainty >= 0, Certainty =< 1, asserta(Name :: if If then Then cert Certainty)),
		   append('rules.pl'), write(Name), write(':: if '), write(If), nl, write(' then '), write(Then), 														write(' cert '), write(Certainty), write('.'), nl, told.


%%%%Listing rules%%%%
listRules :- forall(Rule :: if Condition then Goal cert Certainty, writeRules(Rule, Condition, Goal, Certainty)).
writeRules(Rule, Condition, Goal, Certainty) :- write(Rule), write(':: if '), write(Condition), nl, write(' then '), write(Goal), 														write(' cert '), write(Certainty), write('.'), nl.
