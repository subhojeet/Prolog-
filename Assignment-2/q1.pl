/* rotate(List,N,RotatedList) :- the list RotatedList is obtained from the list List by 
 *   rotating the elements of List N places to the left.
 * 
 * split(List,N,Left,Right) :- the list Left contains the first N elements
 *   of the list List, the list Right contains the remaining elements.
 * 
 * len(List,Listlen) :- Listlen conatains the length of the list List
 *
 * appnd(List1,List2,Newlist) :- Newlist is the list obtained by appending List2 at the end of List1 
 * 
 * rotate_left(List,N,Rotatedlist):- rotates a List N places to the left given 0<=N<length of list
*/

%rules for appnd
appnd([],List2,List2).
appnd([X|List1],List2,[X|List3]):- appnd(List1,List2,List3).

%rules for len
len([],0).
len([_|Y],Listlen):-len(Y,N1), Listlen is N1 + 1.

%rules for rotate
rotate(List,N,RotatedList):-
                len(List,Listlen), NewN is N mod Listlen, rotate_left(List,NewN,RotatedList).

%rules for rotate_left
rotate_left(List,0,List). %base case
rotate_left(List,N,RotatedList):- N > 0, split(List,N,Left,Right), appnd(Right,Left,RotatedList).


%rules for split
split(List,0,[],List). %base case
split([X|Tail],N,[X|LeftTail],Right) :- N > 0, N1 is N - 1, split(Tail,N1,LeftTail,Right).

