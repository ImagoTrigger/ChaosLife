GC_addSkill = {
	private["_skill","_amount"];
	_skill = _this select 0;
	_amt = _this select 1;

	call compile format ['%1 = %1 + %2;', _skill, _amt];
	call compile format ['if (%1 > 100) then {%1 = 100;};["%1", %1] call ClientSaveVar;', _skill];
};