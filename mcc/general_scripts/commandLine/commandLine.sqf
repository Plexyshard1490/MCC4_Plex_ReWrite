#define MCC_CLTEXT 2001
disableSerialization;
private ["_type", "_string", "_command","_str"];

if (mcc_missionmaker == (name player)) then {
	_type = _this select 0;
	_string = ctrlText MCC_CLTEXT;
	
	switch (_type) do
	{
	   case 0:	//Local
		{ 
			call (compile _string); 
		};
		
	   case 1:	//Global
		{ 
			hint "Remote SQF execution is disabled.";
		};
		
		case 2: // mcc load
		{
			_command = 'mcc_isloading=true;' + _string + 'mcc_isloading=false;'; 
			[] spawn compile _command;
		};
		
		case 3: // BroadCast text - small
		{
			[[2, "broadcastTitleText", [_string]], "MCC_fnc_globalExecute", true, false] call MCC_fnc_remoteExec;
		};
		
		case 4: // BroadCast text - Big
		{
			_str = "<t size='1' t font = 'puristaLight' color='#FFFFFF'>" + _string + "</t>";
			[[2, "dynamicText", [_str]], "MCC_fnc_globalExecute", true, false] call MCC_fnc_remoteExec;
		};
	};
} else {player globalchat "Access Denied"};