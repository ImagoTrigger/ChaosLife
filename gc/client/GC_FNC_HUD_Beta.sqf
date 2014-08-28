 //DOA <imagotrigger@gmail.com>  for Global Chaos Gaming
private ["_md","_cc"];
disableserialization;
waituntil {sleep 0.1; !(IsNull (findDisplay (_this select 0)))};
 _md = (findDisplay (_this select 0));
_cc = _md  displayCtrl (_this select 1);
_cc ctrlShow false;
_cc = _md  displayCtrl (_this select 2);
_cc ctrlShow false;
_cc = _md  displayCtrl (_this select 3);
_cc ctrlShow false;
_cc = _md displayCtrl (_this select 4);
_cc ctrlShow false;
