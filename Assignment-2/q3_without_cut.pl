/*
 * split(List,Pos,Neg):- divides List in two lists Pos  and Neg with positive and negativ numbers respectively
*/

% base case when the input list is empty
split([],[],[]).

% rules with the cut
split([H|List] , Positive , [H|Negative]) :- H < 0, split(List,Positive,Negative). % case when the number is negative
split([H|List] , [H|Positive] , Negative) :- H>=0,  split(List,Positive,Negative).
