/*
	File: AEG_fnc_node.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A function to update node information in the AEG_System dialog.

	Parameters:
	_this select 0: The pertinent AEG object (String).
	
	Execution:
	Loaded into memory by AEG_controls.sqf (and only once per mission per client as detemined by the GV AEG_controls).  Function called by interaction with dialog controls or other UI events.
*/

// Create a function that will give detailed information about a node in the text area on the right of the screen.
AEG_fnc_node = 
{
	// Scope //
	private ["_name", "_onStr", "_on", "_status", "_output"];
	
	// Parameter(s) //
	_name = (_this select 0);
	_onStr = (format ["AEG_on_%1", _name]);
 
	// Get the power on state of the AEG object/
	_on = missionNameSpace getVariable _onStr;
	
	// If Power is on then show ONLINE in green.  If off, then show OFFLINE in red.
	if (_on) then
	{
		_status = parseText "Status: <t color='#00ff00'>ONLINE</t>";
	}
	else
	{
		_status = parseText "Status: <t color='#ff0000'>OFFLINE</t>";
	};
 
	// Display a structured text in the information section of the screen displaying info for the pertinent node.
	switch (_name) do
	{	
		case "P_Elek":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Elektrovadosk", lineBreak,
                "Circuit Bus: P_Elek", lineBreak,
                "Connection(s) In: NONE", lineBreak,
                "Connection(s) Out: Generation lines to T_Elek_1, T_Elek_2, and D_Elek", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "T_Elek_1":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Elektrovadosk", lineBreak,
                "Circuit Bus: T_Elek_1", lineBreak,
                "Connection(s) In: P_Elek", lineBreak,
                "Connection(s) Out: Transmission Line to T_SZag_1", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "T_Elek_2":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Elektrovadosk", lineBreak,
                "Circuit Bus: T_Elek_2", lineBreak,
                "Connection(s) In: P_Elek", lineBreak,
                "Connection(s) Out: Transmission Line to D_Zele", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "D_Elek":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Elektrovadosk", lineBreak,
                "Circuit Bus: D_Elek", lineBreak,
                "Connection(s) In: P_Elek", lineBreak,
                "Connection(s) Out: Transmission Line to D_Soln.  Distribution Feeders to Elektrozavodsk, Zelenaya Coast, Kamyshovo, Skalisty, Golova, Topolka, Pusta, and Prigorodki.", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "T_SZag_1":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Regional", lineBreak,
                "Circuit Bus: T_SZag_1", lineBreak,
                "Connection(s) In: T_Elek_2", lineBreak,
                "Connection(s) Out: Transmission Line to D_SZag", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "D_SZag":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Regional", lineBreak,
                "Circuit Bus: D_SZag", lineBreak,
                "Connection(s) In: T_SZag_1, T_SZag_2", lineBreak,
                "Connection(s) Out: Transmission Line to D_Cher.  Distribution Feeders to Nadezhdino, Mogilevka, Vyshnoye, Guglovo, Novy Sobor, Stary Sobor, Kabinino, Dosnovka, Myshkino, Pustoshka, Vybor, Lopatino, Northern Airfield, Grishino, Petrovka, Skalka.", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
			
		case "T_SZag_2":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Regional", lineBreak,
                "Circuit Bus: T_SZag_2", lineBreak,
                "Connection(s) In: T_Cher_1", lineBreak,
                "Connection(s) Out: Transmission Line to T_SZag_3", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "T_SZag_3":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Regional", lineBreak,
                "Circuit Bus: T_SZag_3", lineBreak,
                "Connection(s) In: T_SZag_2, T_SZag_1", lineBreak,
                "Connection(s) Out: Transmission Line to T_Zele_1", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "D_Cher":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Chernogorsk Distribution", lineBreak,
                "Circuit Bus: D_Cher", lineBreak,
                "Connection(s) In: D_SZag, T_Cher_1", lineBreak,
                "Connection(s) Out: Distribution Feeders to Chernogorsk, Mutnaya Coast, Balota, Balota Airstrip, Vysota, Komarovo", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "P_Cher":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Chernogorsk Generation", lineBreak,
                "Circuit Bus: P_Cher", lineBreak,
                "Connection(s) In: NONE", lineBreak,
                "Connection(s) Out: Generation line to T_Cher_1", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "T_Cher_1":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Chernogorsk Generation", lineBreak,
                "Circuit Bus: T_Cher_1", lineBreak,
                "Connection(s) In: P_Cher", lineBreak,
                "Connection(s) Out: Transmission Line to T_SZag_2", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "T_Zele_1":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Zelenogorsk", lineBreak,
                "Circuit Bus: T_Zele_1", lineBreak,
                "Connection(s) In: T_SZag_3", lineBreak,
                "Connection(s) Out: Transmission Lines to T_Zele_2, D_Zele", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "T_Zele_2":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Zelenogorsk", lineBreak,
                "Circuit Bus: T_Zele_2", lineBreak,
                "Connection(s) In: T_Zele_1, D_Zele", lineBreak,
                "Connection(s) Out: Transmission Line to D_Bere", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "D_Zele":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Zelenogorsk", lineBreak,
                "Circuit Bus: D_Zele", lineBreak,
                "Connection(s) In: T_Elek_1, T_Zele_1", lineBreak,
                "Connection(s) Out: Transmission line to T_Zele_1.  Distribution Feeders to Zelenogorsk, Drozhino, Pavlovo, Bor, Windy Mountain, Kozlovka, Green Mountain, Pogorevka, Rogovo, Pulkovo, Kamenka", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "D_Bere":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Berezino", lineBreak,
                "Circuit Bus: D_Bere", lineBreak,
                "Connection(s) In: T_Zele_2", lineBreak,
                "Connection(s) Out: Distribution Feeders to Berezino, Khelm, Orlovets, Dubrovka, Gorka, Gvozdno, Krasnostov, Krasnostov Airstrip, Olsha", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
		
		case "D_Soln":
		{
			_output = composeText
			[
				"NODE INFORMATION:", lineBreak, lineBreak,
				"Substation: Solnichniy", lineBreak,
                "Circuit Bus: D_Soln", lineBreak,
                "Connection(s) In: T_Elek_2", lineBreak,
                "Connection(s) Out: Distribution Feeders to Solnichniy, Three Valleys, Dolina, Tulga, Nizhnoye, Msta, Polana, Shakhova, Staroye", lineBreak,lineBreak,
                _status, lineBreak, lineBreak,
                "Click a button below to connect or disconnect this node."
			];
		};
 
	}; // End switch-do.
 
	with uiNamespace do {(findDisplay 20700 displayCtrl 20702) ctrlSetStructuredText _output;};	
};