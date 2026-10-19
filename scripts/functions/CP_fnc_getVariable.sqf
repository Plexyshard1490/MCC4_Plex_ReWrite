
//==================================================================CP_fnc_getVariable======================================================================================
// Global execute a command on server only  - SERVER ONLY
// Example: [[varName,playerID,VarDefaultValue], "CP_fnc_getVariable", false, false] call MCC_fnc_remoteExec;
//==============================================================================================================================================================================

params [
	["_varName", "", [""]],
	["_id", "", [""]],
	["_varDefault", [], [[]]]
];

if (!isServer) exitWith {
	diag_log "CP: Rejected player-level lookup outside the server.";
};

private _authorized = true;
if (remoteExecutedOwner > 2) then {
	private _caller = allPlayers select {owner _x == remoteExecutedOwner};
	_authorized = !(_caller isEqualTo []) && {getPlayerUID (_caller select 0) isEqualTo _id};
};
if (!_authorized) exitWith {
	diag_log format ["CP: Rejected player-level lookup for UID '%1' from owner %2.", _id, remoteExecutedOwner];
};

private _allowedVariables = [
	"officerLevel", "arLevel", "riflemanLevel", "ATLevel", "corpsmanLevel",
	"marksmanLevel", "specialistLevel", "crewLevel", "pilotLevel"
];
if !(_varName in _allowedVariables) exitWith {
	diag_log format ["CP: Rejected unsupported player-level variable '%1'.", _varName];
};

_value = profileNamespace getVariable format ["%1_%2",_varName,_id];
if (isnil "_value") then {														//if it's first time then set us default. 
	profileNamespace setVariable [format ["%1_%2",_varName,_id], _varDefault];
	};
_value = profileNamespace getVariable format ["%1_%2",_varName,_id];	
[[[_varName],[_value],_id], "CP_fnc_setValue", true, false] call MCC_fnc_remoteExec;
