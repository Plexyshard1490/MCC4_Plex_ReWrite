//==================================================================MCC_fnc_setVehicleInit======================================================================================
// Sets vehicle init
// Example: [[[netID _unit,_unit], _init], "MCC_fnc_setVehicleInit", true, false] spawn MCC_fnc_remoteExec;
// Params: 
//	_unit: object, vehicle we want to set its init. 
//	_init: string, the new init command (use _this instead of this)
//==============================================================================================================================================================================	
params ["_unitReference", "_unitInit"];

private _unit = if ((_unitReference select 0) isEqualTo "") then {
	_unitReference select 1
} else {
	objectFromNetId (_unitReference select 0)
};

if (isNull _unit) exitWith {
	diag_log "MCC: Ignored vehicle init for an unresolved object.";
	false
};

if !(_unitInit isEqualTo "") then {
	diag_log format [
		"MCC: Ignored SQF vehicle init for %1; remote SQF string execution is disabled.",
		_unit
	];
};

false
