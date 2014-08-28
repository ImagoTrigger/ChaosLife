//ImagoTrigger <imagotrigger@gmail.com> for Chaos Life
if (isServer or !isMultiplayer) then {
	GC_ServerFunc = compile preprocessFileLineNumbers "servermissionfile\GC_serverFunctions.sqf";
};

priest1 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_scientist_co.paa"];
priest2 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_scientist_co.paa"];
priest3 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_scientist_co.paa"];
priest4 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_scientist_co.paa"];
priest5 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_scientist_co.paa"];
priest6 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_scientist_co.paa"];
priest7 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_scientist_co.paa"];
priest8 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_scientist_co.paa"];

{
	if (!(_x in playableUnits) and !(tolower(typeOf _x) in AIArray) and _x != player) then {
		_x setVariable ["BIS_noCoreConversations", true];
		_x setVariable ["NPC", true];	
		removeAllAssignedItems _x;
		removeallweapons _x;
		removeVest _x; 
		removeHeadgear _x; 
		removeGoggles _x; 
		removebackpack _x;
		//if (isServer) then {	
			if (side (group _x) == west) then {
				if (_x in bankflagarray) then {
					_x addheadgear "H_Cap_grn"; 
					_x setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_grey_co.paa"];
				} else {
					_x addheadgear "H_Beret_blk_POLICE"; 
				};
			};
			if ((side (group _x)) == CIVILIAN or (side (group _x)) == Resistance) then {
				_x addheadgear "H_Cap_blk_CMMG"; 
			};	
		//};
		if (_x in sitNPCs) then {
			if (isServer) then {["seat",_x] call GC_ServerFunc;};
			_chair = getPos _x nearestObject "Land_ChairPlastic_F";
			_x setDir (getDir _chair) + 90;
			_x setPos (getPos _chair);
			_x switchMove "InBaseMoves_SittingRifle1";
			_x disableAI "MOVE";
			_x disableAI "AUTOTARGET";
			_x disableAI "FSM";
			_x disableAI "TARGET";
			if (!isServer) then {sleep 0.04;};
			_x disableAI "ANIM";
			_x enableSimulation false;
			if (!isServer) then {
				_nolight = _x getVariable "noLight";
				if (isnil "_nolight") then {
					_light = "#lightpoint" createVehicleLocal getpos _x;
					_light lightAttachObject [_x, [0,0,-0.1]];
					_light setLightBrightness 0.1;
					_light setLightAmbient    [0.6,0.7,0.85];
					_light setLightColor [0.6,0.7,0.85];
				};
			};			
			
		} else {
			_move = _x getVariable "move";
			if (isnil "_move") then {
				_x switchMove "UnaErcPoslechVelitele1";
				_x disableAI "MOVE";
				_x disableAI "AUTOTARGET";
				_x disableAI "FSM";
				_x disableAI "TARGET";
				if (!isServer) then {sleep 0.04;};
				_x disableAI "ANIM";
				_x enableSimulation false;
			} else {
				_x disableAI "AUTOTARGET";
				_x disableAI "FSM";
				_x disableAI "TARGET";
				_x disableAI "MOVE";
			};
			if (!isServer) then {
				_nolight = _x getVariable "noLight";
				if (isnil "_nolight") then {
					_light = "#lightpoint" createVehicleLocal getpos _x;
					_light lightAttachObject [_x, [0,0,-0.1]];
					_light setLightBrightness 0.1;
					_light setLightAmbient    [0.6,0.7,0.85];
					_light setLightColor [0.6,0.7,0.85];
				};
			};			
		};
		
	};
} forEach allUnits;


if (isServer or !isMultiplayer) then {
	["groups",8] call GC_ServerFunc;
};

