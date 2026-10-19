#ifdef MCCMODE
 #include "\mcc_sandbox_mod\VAS\functions\macro.sqf"
#else
 #include "macro.sqf"
#endif
/*
	File: fn_transferNetwork.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Receives information sent for a transfer request and prompts the user.
	
	STR_VAS_Transfer_Request
*/
params [
	["_from", "", [""]],
	["_loadout", [], [[]]]
];
if (_from isEqualTo "") exitWith {};
if (_loadout isEqualTo []) exitWith {};

private _authorized = true;
if (remoteExecutedOwner > 2) then {
	private _sender = allPlayers select {owner _x == remoteExecutedOwner};
	_authorized = !(_sender isEqualTo []) && {name (_sender select 0) isEqualTo _from};
};
if (!_authorized) exitWith {
	diag_log format ["VAS: Rejected loadout transfer from owner %1.", remoteExecutedOwner];
};

if(!createDialog "VAS_prompt") exitWith {hint format["%1 tried to send you a saved loadout but we couldn't open the menu.",_from];};
disableSerialization;
waitUntil {!isNull (findDisplay VAS_prompt_Display)};
(VAS_getControl(VAS_prompt_Display,VAS_prompt_text)) ctrlSetStructuredText parseText format["<t align='center'><t size='.8px'>%1 %2</t></t><br/><t align='center'><t size='0.6px'>%3</t></t>",_from,localize "STR_VAS_Transfer_Request",localize "STR_VAS_Transfer_Request2"];
(VAS_getControl(VAS_prompt_Display,VAS_prompt_true)) ctrlSetText localize "STR_VAS_Prompt_deleteYes";
(VAS_getControl(VAS_prompt_Display,VAS_prompt_false)) ctrlSetText localize "STR_VAS_Prompt_deleteNo";

waitUntil {!isNil "vas_prompt_choice"};
if(vas_prompt_choice) then
{
	[_loadout] spawn VAS_fnc_transferSaveMenu;
};

vas_prompt_choice = nil;