% inside(Box1,Box2) tells whether Box1 is inside Box2
% insideof(Box1, Box2) tells hether Box1 is just inside Box2)

% rules for inside
inside(Box1,Box2):- insideof(Box1,Box2) .
inside(Box1,Box2):- insideof(Box1,X), inside(X,Box2) .

% facts about just inside
insideof(purple,orange).
insideof(orange,green) .
insideof(green,blue) .
