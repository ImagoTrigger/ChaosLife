BANK_zinsen = {
	if (Kontostand > 0) then {
		Kontostand = round(Kontostand+(Kontostand/100*zinsen_prozent));
		playsound "scoringsfx";
		["GC_Money",["FIRST BANK OF STRATIS",format ["At %2%3 interest, you now have $%1 in savings.",(Kontostand call ISSE_str_IntToStr), (zinsen_prozent call ISSE_str_IntToStr),"%"]]] spawn bis_fnc_showNotification;

	};
};


