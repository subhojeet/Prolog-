% marriedto(X,Y) tells whether X is married to Y and is a one way relation
/*
 * married(X,Y) is true when either X is marriedto Y or Y is marriedto X 
 * i.e. marriedto(X,Y) is true or marriedto(Y,X) is true
*/

% facts
marriedto(michael,mary).
marriedto(greg,diana).
marriedto(jhon,elina).

% rules
married(X,Y) :-marriedto(X,Y).
married(X,Y) :-marriedto(Y,X).

/* Answer to the question
 * Here when we query married without our method then Prolog goes into an 
 * infinite recursion as we are are not getting any fact that satisfies the relation
 * and it runs infinitely in search of a rule where it might get true
 * say for married(joy,jane)
 * it looks whether married(jane,joy) is there which is not there
 * so it again looks whether married(joy,jane) is there or not
 * and this goes on forever
 * where as in this case married(joy,jane) will look if there is mariiedto(joy,jane)
 * if yes then it is true otherwise it look whether marriedto(jane,joy) is true
 * if both of them are not true then its sure that joy and jane are not married.
*/

