#define MCC_CONSOLE_UAV_MISSILE 9109

private ["_control","_action"];
disableSerialization;
_action = _this select 0;
_control = _this select 1;

if (isnil 'MCC_ConolseUAV') exitWith {}; 
//Flyhight
if (_action == 0) then	
	{
		(_control select 0) ctrlSetTooltip str (_control select 1);  
		[[2, "uavFlyInHeight", [netId MCC_ConolseUAV, sliderPosition (_control select 0)]], "MCC_fnc_globalExecute", MCC_ConolseUAV, false] call MCC_fnc_remoteExec;
	};

//Fire Missile
if (_action == 1) then	
	{
		[[2, "uavFire", [netId MCC_ConolseUAV, MCC_ConsoleUAVmissiles select 2]], "MCC_fnc_globalExecute", MCC_ConolseUAV, false] call MCC_fnc_remoteExec;
	};
