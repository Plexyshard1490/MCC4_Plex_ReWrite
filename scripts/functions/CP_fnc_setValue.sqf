//==================================================================CP_fnc_setValue======================================================================================
// Sets values on a specific player.
// Example: [[_varNames],[_values],_id], "CP_fnc_setValue", true, false] call MCC_fnc_remoteExec;
//==============================================================================================================================================================================	
params ["_varNames", "_values", "_id"];
if !(_id isEqualType "") exitWith {
	diag_log "CP: Rejected player-level update with an invalid UID.";
};
if !(_varNames isEqualType []) then {_varNames = [_varNames]};
if !(_values isEqualType []) then {_values = [_values]};

if (count _varNames != count _values) exitWith {
	diag_log "CP: Rejected player-level update with mismatched names and values.";
};

if !(getPlayerUID player isEqualTo _id) exitWith {};

private _allowedVariables = [
	"playerLevel", "commanderLevel", "officerLevel", "arLevel", "riflemanLevel",
	"ATLevel", "corpsmanLevel", "marksmanLevel", "specialistLevel", "crewLevel",
	"pilotLevel", "CP_gotValueFromServer"
];
if (_varNames findIf {!(_x isEqualType "") || {!(_x in _allowedVariables)}} >= 0) exitWith {
	diag_log "CP: Rejected player-level update containing an unsupported variable.";
};
if (_values findIf {!(_x isEqualType [] || {_x isEqualType true})} >= 0) exitWith {
	diag_log "CP: Rejected player-level update containing an invalid value.";
};

if (!isServer && {remoteExecutedOwner != 2}) exitWith {
	diag_log format ["CP: Rejected player-level update from owner %1.", remoteExecutedOwner];
};

{
	missionNamespace setVariable [_x, _values select _forEachIndex];
} forEach _varNames;
