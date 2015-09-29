% thief(Name) tells whether the person with name = Name is the thief
% wears(Name, Dressname) tells whether the person with name= Name wore the Dressname
% hair(Name, Hairtype) tell whether the person with name = Name has that Hairtype
% room(Name, Roomno) tell whether the person with name = Name lives in room Roomno
% profession(Name, Professionname) tells whether the person with name = Name has profession of Professionname
% gender(Name, Gendertype) tells whether the gender of person with name = Name is Gendertype
% rule for thief
thief(Name):- wears(Name,black_Shoes) , hair(Name,long_brown) .

% rules for hairtype
hair(Name,long_black):- room(Name,100) .
hair(Name,short_brown):- room(Name,102) .
hair(Name, long_brown):- room(Name,205) .
hair(Name, long_brown):- room(Name,210) .

% rules for roomno
room(Name,205):- wears(Name,black_coat) .
room(Name, 102):- wears(Name,blue_shirt) .
room(Name,210):- gender(Name,female) , wears(Name,red_gown) .

% rules for wears
wears(Name,blue_shirt):- gender(Name, male) , wears(Name,black_tie) .
wears(Name, red_gown):- profession(Name,bridesmaid) .
wears(Name, black_Shoes):- gender(Name,female) , wears(Name,silver_bracelet) .
wears(Name, black_Shoes):- gender(Name,male) , wears(Name,black_tie) .

% facts about wears
wears('James',black_coat) .
wears('Joe',black_shoes) .
wears('Jenny', silver_bracelet) .

% facts about profession
profession('Jenny',bridesmaid) .
profession('Joe',bridesmaid) .
profession('Jacy',bridesmaid) .

% rules baout gender
gender(Name, female):- profession(Name, bridesmaid) .
