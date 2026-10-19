//==================================================================CP_fnc_setVehicleInit======================================================================================
// Sets vehicle init
// SQF vehicle-init strings are intentionally not executed.
// Params: 
//	_unit: object, vehicle we want to set its init. 
//	_init: string, the new init command (use _this instead of this)
//==============================================================================================================================================================================	
params ["_netId", "_unitInit"];
private _unit = objectFromNetId _netId;

if (!isNull _unit && {!(_unitInit isEqualTo "")}) then {
	diag_log format ["CP: Ignored SQF vehicle init for %1; SQF string execution is disabled.", _unit];
};

false
