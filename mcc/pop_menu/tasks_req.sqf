#define MCC_SANDBOX3_IDD 3000
#define MCC_TASKS_NAME 3056
#define MCC_TASKS_DESCRIPTION 3057
#define MCC_TASKS_LIST 3058

disableSerialization;
private ["_type", "_dlg", "_stringName", "_stringDescription", "_ok", "_comboBox","_tasks"];
_type = _this select 0;

_dlg = findDisplay MCC_SANDBOX3_IDD;

	if (mcc_missionmaker == (name player)) then {
	switch (_type) do
	{
	   case 0:	//create
	   {_stringName = ctrlText (_dlg displayCtrl MCC_TASKS_NAME);
		_stringDescription = ctrlText (_dlg displayCtrl MCC_TASKS_DESCRIPTION); 
		_pos =[];
		if (MCC_capture_state) then
			{
				hint "Task Captured";
				MCC_capture_var = MCC_capture_var + FORMAT ['
								 [[%1, "%2", "%3", %4],"MCC_fnc_makeTaks",true,false] spawn MCC_fnc_remoteExec;
								'								 
								,_type
								,_stringName
								,_stringDescription
								,_pos
								];
			} else {
				mcc_safe=mcc_safe + FORMAT ['
										 [[%1, "%2", "%3", %4],"MCC_fnc_makeTaks",true,false] spawn MCC_fnc_remoteExec;
										sleep 1;'								 
										,_type
										,_stringName
										,_stringDescription
										,_pos
										];
				hint "Task updated";
				[[_type, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call MCC_fnc_remoteExec;
				sleep 1;
				_comboBox = (findDisplay MCC_SANDBOX3_IDD) displayCtrl MCC_TASKS_LIST; //fill Tasks
				lbClear _comboBox;
				{
					_comboBox lbAdd format ["%1",_x select 0];
				} foreach MCC_tasks;
				_comboBox lbSetCurSel 0;
				};
			};
		
	   case 1:	//Set WP Cinametic
	   {
		if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
		stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0;  
		stringDescription = lbCurSel MCC_TASKS_LIST;
		typ = _type;
		hint "Left click on the map to set a WP for this Task";
		if (MCC_capture_state) then
			{
			onMapSingleClick " 	hint 'Wp captured.'; 
								MCC_capture_var = MCC_capture_var + FORMAT ['
								[[%1, ""%2"", %3, %4],""MCC_fnc_makeTaks"",true,false] spawn MCC_fnc_remoteExec;
								'
								,typ
								,stringName
								,stringDescription
								,_pos
								];
								onMapSingleClick """";";
			} 
			else 
			{
			onMapSingleClick " 	hint 'Wp added.'; 
								[[typ, stringName, stringDescription, _pos],'MCC_fnc_makeTaks',true,false] spawn MCC_fnc_remoteExec;
								mcc_safe=mcc_safe + FORMAT [""
										[[%1, '%2', %3, %4],'MCC_fnc_makeTaks',true,false] spawn MCC_fnc_remoteExec;
										sleep 1;""								 
										,typ
										,stringName
										,stringDescription
										,_pos
										];
								onMapSingleClick """";
								";
			};
		};
		
		case 2:	//Set Succeeded
	   {
		if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
		_stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0; 
		_stringDescription = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 1;
		_pos =[];
		if (MCC_capture_state) then  
			{
			hint "Task Succeeded Captured"; 
			MCC_capture_var = MCC_capture_var + FORMAT ['
								[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn MCC_fnc_remoteExec;
								'
								,_stringName
								];
			} else
			{
			[[2, _stringName, _stringDescription, [0,0,0]],'MCC_fnc_makeTaks',true,false] call MCC_fnc_remoteExec;
			/*_stringDescription setTaskState "SUCCEEDED";
			[[2, "showNotification", ["TaskSucceeded", ["", _stringName]]], "MCC_fnc_globalExecute", true, false] call MCC_fnc_remoteExec;
			*/
			};
		};
		
		case 3:	//Set Failed
	   {
		if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
		_stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0; 
		_stringDescription = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 1;
		_pos =[];
		if (MCC_capture_state) then
			{
			hint "Task Succeeded Captured"; 
			MCC_capture_var = MCC_capture_var + FORMAT ['
								[[3, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn MCC_fnc_remoteExec;
								'
								,_stringName
								];
			} else
				{
					[[3, _stringName, _stringDescription, [0,0,0]],'MCC_fnc_makeTaks',true,false] call MCC_fnc_remoteExec;
				};
		};
		
		case 4:	//Set Canceled
	   {
		if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
		_stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0; 
		_stringDescription = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 1;
		_pos =[];
		if (MCC_capture_state) then
			{
			hint "Task Succeeded Captured"; 
			MCC_capture_var = MCC_capture_var + FORMAT ['
								[[4, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn MCC_fnc_remoteExec;
								'
								,_stringName
								];
			} else
				{
					[[4, _stringName, _stringDescription, [0,0,0]],'MCC_fnc_makeTaks',true,false] call MCC_fnc_remoteExec;
				};
		};
		
		case 5:	//End Mission : Sucess
		{
			if (MCC_capture_state) then
			{
			MCC_capture_var = MCC_capture_var + FORMAT ['
								[[2, "endMission", ["end1", "Track06_CarnHeli", false]], "MCC_fnc_globalExecute", true, false] call MCC_fnc_remoteExec;
								'
								];
			} else
			{
			[[2, "endMission", ["end1", "Track06_CarnHeli", false]], "MCC_fnc_globalExecute", true, false] call MCC_fnc_remoteExec;
			};
		};
		
		case 6:	//End Mission : Fail
		{
			if (MCC_capture_state) then
			{
			MCC_capture_var = MCC_capture_var + FORMAT ['
								[[2, "endMission", ["LOSER", "Track07_ActionDark", true]], "MCC_fnc_globalExecute", true, false] call MCC_fnc_remoteExec;
								'
								];
			} else
			{
			[[2, "endMission", ["LOSER", "Track07_ActionDark", true]], "MCC_fnc_globalExecute", true, false] call MCC_fnc_remoteExec;
			};
		};
		
		case 7:	//Set WP No Cinametic
	   {
		if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
		stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0;  
		stringDescription = lbCurSel MCC_TASKS_LIST;
		typ = _type;
		hint "Left click on the map to set a WP for this Task";
		if (MCC_capture_state) then
			{
			onMapSingleClick " 	hint 'Wp captured.'; 
								MCC_capture_var = MCC_capture_var + FORMAT ['
								[[%1, ""%2"", %3, %4],""MCC_fnc_makeTaks"",true,false] spawn MCC_fnc_remoteExec;
								'
								,typ
								,stringName
								,stringDescription
								,_pos
								];
								onMapSingleClick """";";
			} else 
			{
			onMapSingleClick " 	hint 'Wp added.'; 
								[[typ, stringName, stringDescription, _pos],'MCC_fnc_makeTaks',true,false] spawn MCC_fnc_remoteExec;
								mcc_safe=mcc_safe + FORMAT [""
										[[%1, '%2', %3, %4],'MCC_fnc_makeTaks',true,false] spawn MCC_fnc_remoteExec;
										sleep 1;""								 
										,typ
										,stringName
										,stringDescription
										,_pos
										];
								onMapSingleClick """";
								";
			};
		};
		
		case 8:	//Delete Task
		{
			if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
			_stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0; 
			_stringDescription = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 1;
			_pos =[];
			if (MCC_capture_state) then
			{
				hint "Task Succeeded Captured"; 
				MCC_capture_var = MCC_capture_var + FORMAT ['
								[[9, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn MCC_fnc_remoteExec;
								'
								,_stringName
								];
			} 
			else
			{
				_tasks = str MCC_tasks; 
				[[9, _stringName, _stringDescription, [0,0,0]],'MCC_fnc_makeTaks',true,false] call MCC_fnc_remoteExec;
				
				waituntil {_tasks != str MCC_tasks};
				sleep 1;
				//Refresh the tasks list
				_comboBox = (findDisplay MCC_SANDBOX3_IDD) displayCtrl MCC_TASKS_LIST; 
				lbClear _comboBox;
				{
					_comboBox lbAdd format ["%1",_x select 0];
				} foreach MCC_tasks;
				_comboBox lbSetCurSel 0;
			};
		};
	 };
} else {player globalchat "Access Denied"};
