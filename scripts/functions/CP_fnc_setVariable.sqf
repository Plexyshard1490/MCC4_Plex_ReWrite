
//==================================================================CP_fnc_setVariable======================================================================================
// Stores a player-specific value in the server profile.
// Example: [[varName,playerID,VarValue], "CP_fnc_setVariable", false, false] call MCC_fnc_remoteExec;
//==============================================================================================================================================================================

params [
	["_varName", "", [""]],
	["_id", "", [""]],
	"_value"
];

if (!isServer) exitWith {
	diag_log "CP: Rejected player-level storage outside the server.";
};

private _allowedVariables = [
	"officerlevel", "commanderlevel", "arlevel", "riflemanlevel", "atlevel", "corpsmanlevel",
	"marksmanlevel", "specialistlevel", "crewlevel", "pilotlevel"
];
if !((toLower _varName) in _allowedVariables) exitWith {
	diag_log format ["CP: Rejected unsupported player-level variable '%1'.", _varName];
};
if (isNil "_value" || {!(_value isEqualType [])}) exitWith {
	diag_log "CP: Rejected player-level storage with an invalid value.";
};

private _authorized = true;
if (remoteExecutedOwner > 2) then {
	private _caller = allPlayers select {owner _x == remoteExecutedOwner};
	_authorized = !(_caller isEqualTo []) && {getPlayerUID (_caller select 0) isEqualTo _id};
};
if (!_authorized) exitWith {
	diag_log format ["CP: Rejected player-level storage for UID '%1' from owner %2.", _id, remoteExecutedOwner];
};

profileNamespace setVariable [format ["%1_%2", _varName, _id], _value];