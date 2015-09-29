/*
 * transform(Inlist,Outlist):- transforms sentence depicted by Inlist following certain rules to Outlist
 *
 * transform(Original,Replacement):- replaces a word by Replaceent
*/

% base case when we have an empty list
transform([],[]).

% transform first word and then trans for the rest of the list recursively
transform([H|T],[X|Y]) :- transform_to(H,X),transform(T,Y).

% facts of what to be replace by what
transform_to(you,i).
transform_to(are,[am,not]).
transform_to(do,yes).

% rules for non specific word where they are to be copied to the target
transform_to(X,X).
