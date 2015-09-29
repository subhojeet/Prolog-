/* 
 * nu(Elem1,Elem2):- a predicate that succeeds when Elem1 is not unifiable with Elem2 and fails otherwise using \+ which means negation as failure
*/

nu(Elem1,Elem2) :- \+ Elem1=Elem2. % when Elem1=Elem2 condition is met then it will fail
