
%% Rules %%

membership_rule :: if member(X,[cheetah, tiger, penguin, albatross]) 
				   then X isa animal cert 1.





rule7 :: if Vehicle 'runs on' roads
		  then Vehicle is roadways cert 0.8.

rule8 :: if Vehicle 'runs on' tracks
		then Vehicle isa railways cert 1.


rule9 :: if Vehicle isa railways and
		 Vehicle has separate-engine
		 then Vehicle isa train cert 0.7.


rule10 :: if Vehicle isa railways and
		  Vehicle isa roadways
		  then Vehicle isa tram cert 0.6.

rule11 :: if Vehicle isa railways and
		Vehicle stays underground
		then Vehicle isa metro cert 0.2.

rule12 :: if Vehicle flies
		then Vehicle isa airways cert 0.9.

rule13 :: if Vehicle isa airways and
		Vehicle has wings
		then Vehicle isa plane cert 0.8.

rule14 :: if Vehicle isa airways and
		Vehicle 'takes off' vertically and
		Vehicle has rotors
		then Vehicle isa helicopter cert 0.9.

rule15 :: if Vehicle isa helicopter and
		Vehicle 'made in' 'South Africa'
		then Vehicle isa 'Rooivalk' cert 0.5.

rule16 :: if Vehicle isa roadways and
		  Vehicle has 'two-wheels'
		  then Vehicle isa 'two-wheeler' cert 1.


rule17 :: if Vehicle isa roadways and
		  Vehicle has 'four-wheels'
		  then Vehicle isa 'four-wheeler' cert 1.



rule18 :: if Vehicle isa 'two-wheeler' and
		Vehicle has engine
		then Vehicle isa bike cert 0.7.


rule19 :: if Vehicle isa 'two-wheeler' and
		Vehicle has pedals
		then Vehicle isa cycle cert 0.6.


askable(_ flies).
askable(_ has _).
askable(_ isa _).
askable(_ 'made in' _).
askable(_ 'takes off' _).
askable(_ 'runs on' _).
askable(_ stays _).

askable(_ gives _).
% askable(_ flies).
askable(_ lays eggs).
askable(_ eats _).
% askable(_ has _).
askable(_ 'does not' _).
askable(_ swims).
% askable(_ isa 'good flier').
%askable(_ isa _).
