// F3 - Process ParamsArray
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

for "_i" from 0 to (count paramsArray - 1) do {
	private _parameter = (missionConfigFile >> "Params") select _i;
	private _parameterName = configName _parameter;
	private _variableName = getText (_parameter >> "variable");

	if (_variableName isEqualTo "") then {
		diag_log format ["F3: Parameter '%1' has no variable target.", _parameterName];
	} else {
		missionNamespace setVariable [_variableName, paramsArray select _i];
	};
};