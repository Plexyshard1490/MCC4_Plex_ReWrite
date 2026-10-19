params [
	["_mode", 2, [0]],
	["_action", "", [""]],
	["_arguments", []]
];

if (_mode == 0 && {isServer}) exitWith {};
if (_mode == 1 && {!isServer}) exitWith {};
if !(_mode in [0, 1, 2]) exitWith {
	diag_log format ["MCC: Rejected remote action with invalid execution mode '%1'.", _mode];
};

private _authorized = true;
if (remoteExecutedOwner > 2) then {
	private _caller = allPlayers select {owner _x == remoteExecutedOwner};
	_authorized = !(_caller isEqualTo []) && {
		(name (_caller select 0)) isEqualTo mcc_missionmaker
	};

	if (_action isEqualTo "syncRequest") then {
		private _requestData = _arguments param [0, []];
		private _requestPlayerData = _requestData param [1, []];
		private _requestPlayer = _requestPlayerData param [1, objNull];
		_authorized = !isNull _requestPlayer && {
			owner _requestPlayer == remoteExecutedOwner
		};
	};
};

if (!_authorized) exitWith {
	diag_log format ["MCC: Rejected remote action '%1' from owner %2.", _action, remoteExecutedOwner];
};

switch (_action) do {
	case "deleteMarkerLocal": {
		deleteMarkerLocal (_arguments select 0);
	};

	case "endMission": {
		_arguments params ["_endType", "_music", ["_killPlayer", false]];
		if (_killPlayer && {!isNil "CP_activated"} && {CP_activated}) then {
			cutText ["", "BLACK", 0.1];
			player setDamage 1;
		};
		_endType call BIS_fnc_endMission;
		playMusic _music;
	};

	case "enableEngineArtillery": {
		enableEngineArtillery (_arguments select 0);
	};

	case "dynamicText": {
		[_arguments select 0, 0, 0.2, 5, 1, 0] spawn BIS_fnc_dynamicText;
	};

	case "broadcastTitleText": {
		titleText [_arguments select 0, "PLAIN DOWN"];
		titleFadeOut 60;
	};

	case "deleteLastSpawn": {
		if (isNil "MCC_lastSpawn" || {MCC_lastSpawn isEqualTo []}) exitWith {};
		private _lastSpawn = MCC_lastSpawn deleteAt (count MCC_lastSpawn - 1);
		if (_lastSpawn isEqualType []) then {
			deleteVehicle (_lastSpawn select 0);
			{deleteVehicle _x} forEach (_lastSpawn select 1);
		} else {
			deleteVehicle _lastSpawn;
		};
	};

	case "playMusic": {
		playMusic (_arguments select 0);
	};

	case "removeSimpleTask": {
		if (isNil "MCC_tasks") exitWith {};
		private _taskIndex = _arguments select 0;
		if (_taskIndex >= 0 && {_taskIndex < count MCC_tasks}) then {
			player removeSimpleTask ((MCC_tasks select _taskIndex) select 1);
		};
	};

	case "setTaskState": {
		if (isNil "MCC_tasks") exitWith {};
		_arguments params ["_taskIndex", "_state"];
		if (_taskIndex >= 0 && {_taskIndex < count MCC_tasks}) then {
			((MCC_tasks select _taskIndex) select 1) setTaskState _state;
		};
	};

	case "setVehicleHit": {
		_arguments params ["_vehicleNetId", "_hitPoint", "_damage"];
		private _vehicle = objectFromNetId _vehicleNetId;
		if (!isNull _vehicle) then {
			_vehicle setHit [_hitPoint, _damage];
		};
	};

	case "showNotification": {
		_arguments call BIS_fnc_showNotification;
	};

	case "syncRequest": {
		if (isServer) then {
			_arguments execVM format ["%1mcc\general_scripts\sync.sqf", MCC_path];
		};
	};

	case "syncState": {
		_arguments params ["_syncState", "_missionMaker"];
		MCC_sync = _syncState;
		mcc_missionmaker = _missionMaker;
		mcc_sync_status = true;
	};

	case "uavFire": {
		_arguments params ["_uavNetId", "_weapon"];
		private _uav = objectFromNetId _uavNetId;
		if (!isNull _uav) then {
			_uav fire _weapon;
		};
	};

	case "uavFlyInHeight": {
		_arguments params ["_uavNetId", "_height"];
		private _uav = objectFromNetId _uavNetId;
		if (!isNull _uav) then {
			_uav flyInHeight _height;
		};
	};

	default {
		diag_log format ["MCC: Rejected unsupported remote action '%1'.", _action];
	};
};
