/*
 * appnd(List1,List2,Result):- appends List2 to List1 and thr result is in Result
 *
 * len(List,Listlen):- has the length of List in Listlen
 *
 * member(X,List):- true when X is a member of the List
 *
 * fre_sort(List,Reslist):- sorts list on the basis of frequency of the length and saves result in Reslist
 *
 * frequency(Elem,List,Freq):- Freq contains the frequency of Elements of length same as Elem in List  
*/

% rules for appnd
% base case when 1st list is empty
appnd([],List2,List2).
% if first list is non empty then the firt elem of the frst list will be added to the output list  and the tail is passed for recursive addition
appnd([X|List1],List2,[X|List3]):- appnd(List1,List2,List3).

% rules for len
% base case
len([],0).
% length is 1 + length of tail
len([_|Y],Listlen):-len(Y,N1), Listlen is N1 + 1.

% member(X, [Head|Tail]) is true if X = Head. i.e, if X is the head of the list
member(X, [X|_]).        			
% or if X is a member of Tail.  ie. if member(X, Tail) is true.
member(X, [_|Tail]) :-   member(X, Tail).  	


% case when the input list is empty
fre_sort([], []).
%   elem in the input list will be added to the output list when it has the minimum frequency among all the elems to its right
fre_sort([H|T], [H|R]) :- frequency(H,[H|T],Fh), forall(member(M, T), (frequency(M, [H|T], Fm), Fh =< Fm)), fre_sort(T,R), !.
% when the frist elem is not the one with min frequency the append it to the last of that list and sort the new list
fre_sort([F,S|T], R) :- appnd(T, [F], X), fre_sort([S|X], R). 

% base case for frequency in an empty list
frequency(_, [], 0). 
% the frequency if length of an elem to be looked for is same as that of first elem will be 1+frequence in remaining list
frequency(F, [H|T], N) :- len(F, LF),len(H,LH), LF == LH, frequency(F,T, M), !, N is 1 + M. 
% if the len of first elem is not same then frequency is the frequency in the tail
frequency(F, [_|T], N) :- frequency(F,T,N).
