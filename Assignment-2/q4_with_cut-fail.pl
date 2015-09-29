/* 
 * nu(Elem1,Elem2):- a predicate that succeeds when Elem1 is not unifiable with Elem2 and fails otherwise using the cut-fail
*/

% when both the arguments are same then this rule will be satisfied and it will fail
nu(Elem1,Elem1) :- !,fail. 	

% now if the first rule is not aplicable then this rule wiil be follwed and the cut will come into action will not let backtrack and will succeed
nu(_,_) :- !.
