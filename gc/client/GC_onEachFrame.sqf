//Global Chaos Gaming -http://globalchaosgaming.net - Chaos Life 1.3
addMissionEventHandler ["Draw3D", {}]; //not ued (yet?)
onEachFrame {
	if((cameraView == "EXTERNAL" || cameraView == "GROUP") and (vehicle player == player)) then {
		vehicle player switchCamera "INTERNAL";
	};
};
GC_playerColor = getarray (configfile >> "cfgingameui" >> "islandmap" >> "colorMe");
GC_playerColor2 = [1,1,1,1];
GC_currentColor = [1,1,1,1];
GC_Mecon = { 
	if (format["%1",GC_currentColor] == format["%1",GC_playerColor] and diag_frameno % 10 == 0) then {GC_currentColor = GC_playerColor2} else {GC_currentColor = GC_playerColor};
	(_this select 0) drawicon["\a3\ui_f\data\map\Markers\System\empty_ca.paa",GC_currentColor,position vehicle player,32,32,direction vehicle player,name vehicle player,false];
};
if !(isnil "GC_drawEH") then {((finddisplay 12) displayctrl 51) ctrlremoveeventhandler ["draw",GC_drawEH]};
GC_drawEH = ((finddisplay 12) displayctrl 51) ctrladdeventhandler ["draw","_this call GC_Mecon;"];
