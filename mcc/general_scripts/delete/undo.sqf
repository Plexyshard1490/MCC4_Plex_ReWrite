 if !mcc_isloading then 
			{
			mcc_safe = mcc_safe + FORMAT ["script_handler = [1] execVM '%1mcc\general_scripts\delete\undo.sqf';
								waitUntil {scriptDone script_handler};
								"
								, MCC_path
								];									
			};

[[2, "deleteLastSpawn", []], "MCC_fnc_globalExecute", true, false] call MCC_fnc_remoteExec;
	
 
 

