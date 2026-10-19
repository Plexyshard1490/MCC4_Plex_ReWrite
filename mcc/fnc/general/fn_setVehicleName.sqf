//==================================================================MCC_fnc_setVehicleName======================================================================================
// Sets vehicle name
// Example: [[[netid _unit,_unit], _name], "MCC_fnc_setVehicleName", true, true] spawn MCC_fnc_remoteExec;
// Params: 
//	_unit: object, vehicle we want to set its init. 
//	_name: string, the new name
//==============================================================================================================================================================================	
params ["_unitReference", "_unitName"];

private _unit = if ((_unitReference select 0) isEqualTo "") then {
	_unitReference select 1
} else {
	objectFromNetId (_unitReference select 0)
};

if (isNull _unit) exitWith {
	diag_log "MCC: Refusing to assign a name to an unresolved object.";
	false
};

_unit setVehicleVarName _unitName;
missionNamespace setVariable [_unitName, _unit, true];
