if (!alive player)exitwith{}; 

isstunned=true;

player groupchat "You have been restrained!"; 

waituntil {count (nearestobjects[getpos player,["B_Helipilot_F"],100]) == 0 or (animationstate player != "inbasemoves_handsbehindback1")};
	
player setvariable["fucked",false,true];
if(animationstate player == "inbasemoves_handsbehindback1") then {
	player groupchat "You managed to free yourself!"; 
	(format ["[%1, 0, 0] call setPitchBank;%1 switchmove ""%2"";", player, "amovppnemstpsnonwnondnon"]) call broadcast;
} else {
	(format ["[%1, 0, 0] call setPitchBank;%1 switchmove ""%2"";", player, "amovppnemstpsnonwnondnon"]) call broadcast;
	player groupchat "You have been released!"
};

isstunned=false;
StunActiveTime=0;