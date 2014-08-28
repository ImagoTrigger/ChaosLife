private ["_cash","_option"];
_option = ((_this select 3) select 0);

if (random 100 > 10) exitwith {
switch (_option) do {
  case "jonna": {
    "Father Jonna" hintC format["Hello %1,  I gave my whistle to a young asian boy, sorry.", name player];
    sleep 0.1;
    hint "";
  };

  case "eli": {
    "Father Eli" hintC format["Hello %1, I only have popsicles right now, sorry.", name player];
    sleep 0.1;
    hint "";
  };

  case "daniels": {
    "Father Daniels" hintC format["Hello %1, You don't need a rape whistle, God will save you!", name player];
    sleep 0.1;
    hint "";
  };

  case "alacard": {
    "Father Alacard" hintC format["Sorry I don't have a rape whistle, %1. Please come by and try again later.", name player];
    sleep 0.1;
    hint "";
  };

  case "able": {
    "Father Able" hintC format["Romans took the rape whistle, sorry %1", name player];
    sleep 0.1;
    hint "";
  };

  case "jacobs": {
    "Father Jacobs" hintC format["%1, I'm letting the young little neighbor boy use my rape whistle.", name player];
    sleep 0.1;
    hint "";
  };
  case "kaleb": {
    "Father Kaleb" hintC format["%1, The damn chickens got into my supply of rape whistles !!!", name player];
    sleep 0.1;
    hint "";
  };
  case "joseph": {
    "Father Joseph" hintC format["%1, Don't you love these new cops?  They took all my rape whistles", name player];
    sleep 0.1;
    hint "";
  };
};

_cash  = 'cash' call INV_GetItemAmount;

if (_cash == 0) exitwith {
	player groupchat "Sorry my child, you won't get a rape whistle from me with empty hands!";
};
if (_cash < 100000) exitwith {
	player groupchat "I had a rape whistle earlier but some fat woman offered me $100,000 for it!";
};

if (primaryweapon player == "" and secondaryweapon player == "") then {
	player playmove "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon";
} else {
	player playmove "AinvPknlMstpSlayWrflDnon"};
};
['cash', -(100000)] call INV_AddInventoreItem;
["rapewhistle", 1, "INV"] call INV_CreateItem;
player groupChat "Here my child, take this rape whistle - Praise Allah";
