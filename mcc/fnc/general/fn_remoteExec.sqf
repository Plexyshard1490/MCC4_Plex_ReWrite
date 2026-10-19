params [
	["_arguments", [], [[]]],
	["_functionName", "", [""]],
	["_target", 0],
	["_jip", false]
];

if (_functionName isEqualTo "") exitWith {
	diag_log "MCC: Refusing remote execution without a function name.";
	false
};

private _isAllowedFunction = isClass (missionConfigFile >> "CfgRemoteExec" >> "Functions" >> _functionName)
	|| {isClass (configFile >> "CfgRemoteExec" >> "Functions" >> _functionName)};
if (!_isAllowedFunction) exitWith {
	diag_log format ["MCC: Refusing remote execution of non-whitelisted function '%1'.", _functionName];
	false
};

if (_target isEqualType true) then {
	_target = if (_target) then {0} else {2};
};

if (_target isEqualType "" && {isNull (objectFromNetId _target)}) exitWith {
	diag_log format ["MCC: Refusing remote execution to unresolved target '%1'.", _target];
	false
};

if (_target isEqualType "") then {
	_target = objectFromNetId _target;
};

_arguments remoteExec [_functionName, _target, _jip];
