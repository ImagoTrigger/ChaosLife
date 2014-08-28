private ["_scale","_playerTag","_usedTagCount","_playerTagPos","_shopFound","_shopName","_screenPos","_hidden","_pos","_distance","_controlToHide","_idcsToHide","_loopcount","_tagsUi","_interactCtrl","_cash","_target","_veh","_dir","_adj","_shopNPC","_namedNPC"];
#define nametags_idc 63500
sleep 1;
disableSerialization;

_loopcount = 0;

("GCHUD_Tags" call BIS_fnc_rscLayer) cutRsc ["Rtags","PLAIN"];
_tagsUi        = uiNamespace getVariable "TAGS_HUD";
_interactCtrl  = _tagsUi displayCtrl 64438;
usedIDCs = [];

while {_loopcount <= 144000} do {
	_loopcount = _loopcount + 1;
	if (alive player and isdead == 0 and deadcam == 0) then {
		if (INV_shortcuts and !visibleMap and !dialog) then {
			usedIDCs = [];
			_shopFound = false;
			_usedTagCount = 0;
			{
				_pos = getposATL vehicle _x;
				_shopNPC = false;
				_namedNPC = false;

				if(surfaceIsWater _pos) then {
					_pos = getposASL vehicle _x;
				};

				_distance = _pos distance vehicle player;
				if (_distance < 30) then {
					_hidden = _x getVariable "hidden";
					if (isNil "_hidden" and !lineIntersects [eyepos player, eyepos _x, player, _x]) then {
						_pos set [2, (_pos select 2) + 2.07];
						_screenPos = worldToScreen _pos;
						if (count _screenPos > 1 ) then {
							_scale = 0;
							if (_distance <= 5) then {
								_scale = 0.9;
							} else {
								_scale = 0.8 min (((25 - _distance) / 20) max 0.3);
							};

							// Players
							if ((isPlayer _x) && (alive _x) && (_x != player) && (_x != vehicle player)) then {
								_target = objnull;
								_veh = false;
								if (_x != vehicle _x or _x isKindOf "LandVehicle" or _x isKindOf "Ship" or _x isKindOf "Air") then {
									_pos = getposATL driver _x;
									_veh = true;
									if(surfaceIsWater _pos) then {
										_pos = getposASL vehicle _x;
									};
									_pos set [2, (_pos select 2) + 1.65];
									_screenPos = worldToScreen _pos;
									if (count _screenPos > 1) then {_target = driver _x;};
								} else {
									if (_x in playerarray) then {
										_target = _x;
									};
								};

								if (!isnull _target) then {
									_playerTag = _tagsUi displayCtrl (nametags_idc + _usedTagCount);
									usedIDCs set [count usedIDCs, nametags_idc + _usedTagCount];
									_usedTagCount = _usedTagCount + 1;

									_playerTagPos = ctrlPosition _playerTag;
									_playerTagPos set [0,((_screenPos select 0) - 0.080)];
									_playerTagPos set [1,((_screenPos select 1) + 0.01)];

									_playerTag ctrlSetStructuredText parseText format["<t align='left'>%1 (%2)</t>", name _target, _target];
									_playerTag ctrlSetPosition _playerTagPos;
									_playerTag ctrlSetScale _scale;
									_playerTag ctrlSetFade ((1- _scale ) / 2);

									if (side (group _target) == CIVILIAN or side (group _target) == Resistance) then {
										if ((call compile format ["%1_wanted;", _target]) == 1) then {
										// Red - Player is wanted;
											_playerTag ctrlSetTextColor [1, 0, 0, 0.8];
										} else {
											// Yellow - Player not wanted;
											_playerTag ctrlSetTextColor [1, 1, 0, 0.8];
										};
										//always show gang members green NYI TODO A3 flash red/green wanted gang members ;-)
										if (_target in (units group player)) then {
											_playerTag ctrlSetTextColor [0, 1, 0, 0.8];
										};
									} else {
										_playerTag ctrlSetTextColor [0, 0, 1, 0.8];;
									};
									if (_distance < 4 and !_veh and player == vehicle player) then {
										_dir = [vehicle player,_target] call GC_DirTo;
										if (_dir < 0) then { _dir = _dir + 360 };
										_adj = abs (_dir - (getdir vehicle player));
										if (_adj < 70) then {
											_shopFound = true;
											_interactCtrl ctrlSetText "Interact (E)";
											_interactCtrl ctrlSetTextColor [1, 1, 1, 0.8];
											_interactCtrl ctrlShow true;
										};
									};
									_playerTag ctrlCommit 0;
									_playerTag ctrlShow true;
								};
							};

							if (_x in shopusearray) then {
								_shopNPC = true;
								_namedNPC = true;
							};

							if ((!_shopNPC) && (_x in GC_NPCNamesArray)) then { _namedNPC = true; };

							// Shops
							if (_namedNPC) then {
								_playerTag = _tagsUi displayCtrl (nametags_idc + _usedTagCount);
								usedIDCs set [count usedIDCs, nametags_idc + _usedTagCount];
								_usedTagCount = _usedTagCount + 1;

								_playerTagPos = ctrlPosition _playerTag;
								_playerTagPos set [0,((_screenPos select 0) - 0.070)];
								_playerTagPos set [1,(_screenPos select 1)];

								if (_shopNPC) then {
									_shopName = (_x call INV_getshopArray) select 1;
								} else {
									_shopName = (_x call GC_FNC_GetNPCName);
								};

								_playerTag ctrlSetStructuredText parseText format ["<t align='left'>%1</t>", _shopName];
								_playerTag ctrlSetPosition _playerTagPos;
								_playerTag ctrlSetScale _scale;
								_playerTag ctrlSetFade ((1- _scale ) / 2);
								_playerTag ctrlSetTextColor [1, 1, 1, 0.8];
								_playerTag ctrlCommit 0;
								_playerTag ctrlShow true;

								if (_shopNPC) then {
									if (_distance < 4 and player == vehicle player) then {
										_shopFound = true;
										if(!(ctrlShown  _interactCtrl)) then {
											if (iscop && (_x in drugsellarray)) then {
												_interactCtrl ctrlSetText "Drug Search (E)";
												_interactCtrl ctrlSetTextColor [0, 0, 1, 0.8];
												_interactCtrl ctrlShow true;
											} else {
												_interactCtrl ctrlSetText format["Shop at %1 (E)", _shopName];
												_interactCtrl ctrlSetTextColor [1, 1, 1, 0.8];
												_interactCtrl ctrlShow true;
											};
										};
									};
								};
							};

							// ATMS
							if (_x in bankflagarray) then {
								_playerTag = _tagsUi displayCtrl (nametags_idc + _usedTagCount);
								usedIDCs set [count usedIDCs, nametags_idc + _usedTagCount];
								_usedTagCount = _usedTagCount + 1;

								_playerTagPos = ctrlPosition _playerTag;
								_playerTagPos set [0,((_screenPos select 0) - 0.035)];
								_playerTagPos set [1,((_screenPos select 1) + 0.04)];

								_playerTag ctrlSetStructuredText parseText "<t align='left'>ATM</t>";
								_playerTag ctrlSetPosition _playerTagPos;
								_playerTag ctrlSetScale _scale;
								_playerTag ctrlSetFade ((1- _scale ) / 2);
								_playerTag ctrlSetTextColor [1, 1, 1, 0.8];
								_playerTag ctrlCommit 0;
								_playerTag ctrlShow true;

								if (_distance < 4 and player == vehicle player) then {
									_shopFound = true;
									if(!(ctrlShown  _interactCtrl)) then {
										_interactCtrl ctrlSetText "ATM (E)";
										_interactCtrl ctrlSetTextColor [0, 1, 0, 0.8];
										_interactCtrl ctrlShow true;
									};
								};
							};

							// Speed Cams
							if (typeof _x == "Land_Runway_PAPI") then {
								_playerTag = _tagsUi displayCtrl (nametags_idc + _usedTagCount);
								usedIDCs set [count usedIDCs, nametags_idc + _usedTagCount];
								_usedTagCount = _usedTagCount + 1;

								_playerTagPos = ctrlPosition _playerTag;
								_playerTagPos set [0,((_screenPos select 0) - 0.035)];
								_playerTagPos set [1,((_screenPos select 1) + 0.04)];

								_playerTag ctrlSetStructuredText parseText "<t align='left'>Police Speedcam</t>";
								_playerTag ctrlSetPosition _playerTagPos;
								_playerTag ctrlSetScale _scale;
								_playerTag ctrlSetFade ((1- _scale ) / 2);
								_playerTag ctrlSetTextColor [1, 1, 1, 0.8];
								_playerTag ctrlCommit 0;
								_playerTag ctrlShow true;
							};

							//vehicle interaction takes priority
							if (vehicle player == player) then {
								if (_x iskindOf "LandVehicle" or _x iskindOf "Ship" or _x iskindOf "Air") then {
									if (_distance < 3 and (_x in INV_VehicleArray) and !(isnull _x) and locked _x != 0) then {
										_shopFound = true;
										_interactCtrl ctrlSetText "Trunk (T) / Unlock (L)";
										_interactCtrl ctrlSetTextColor [1, 1, 1, 0.8];
										_interactCtrl ctrlCommit 0;
										_interactCtrl ctrlShow true;

									};
									if (_distance < 4  and !(isnull _x) and locked _x == 0 and alive _x) then {
										_shopFound = true;
										_interactCtrl ctrlSetText "Enter (E)";
										_interactCtrl ctrlSetTextColor [1, 1, 1, 0.8];
										_interactCtrl ctrlCommit 0;
										_interactCtrl ctrlShow true;
									};
								};
							} else {
								if (locked vehicle player == 0 and speed vehicle player < 30) then {
									_shopFound = true;
									_interactCtrl ctrlSetText "Eject (E)";
									_interactCtrl ctrlSetTextColor [1, 1, 1, 0.8];
									_interactCtrl ctrlCommit 0;
									_interactCtrl ctrlShow true;
								};
							};
						};
					};
				};
			} forEach nearestObjects [player, ["Man", "Land_CashDesk_F", "LandVehicle", "Ship", "Air", "Land_Suitcase_F", "Land_Runway_PAPI"], 20];

			if (!_shopFound) then {
				_interactCtrl ctrlShow false;
			};

			if (isNil "previousIDCs") then {
				previousIDCs = [];
			};

			_idcsToHide = previousIDCs - usedIDCs;
			{
				_controlToHide = _tagsUi displayCtrl _x;
				_controlToHide ctrlShow false;
			} forEach _idcsToHide;

			previousIDCs = usedIDCs;
		} else {
			{(_tagsUi displayCtrl _x) ctrlShow false;} forEach usedIDCs;
			_interactCtrl ctrlShow false;
		};
	} else {
		{(_tagsUi displayCtrl _x) ctrlShow false;} forEach usedIDCs;
		_interactCtrl ctrlShow false;
		waituntil{sleep 1; (alive player and isdead == 0)};
	};
	sleep 0.025;
};

diag_log text format["flushing %1",__FILE__];

hud_handle_tags = [] spawn GC_HUD_Tags;