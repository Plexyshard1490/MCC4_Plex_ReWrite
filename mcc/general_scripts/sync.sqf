private ["_type","_d","_RainLevel","_waves","_lightning","_cloudLevel","_weather","_footer","_x", "_html", "_loop","_wind","_fog","_player"];

_type = _this select 0;
 
switch (_type) do
{
   case 0:
	{	
		if (isserver) exitwith {};
		waituntil {! isnil "MCC_fnc_countDownLine"}; 
		mcc_sync_status = false; 
		[[1, "syncRequest", [[1, [netId player, player]]]], "MCC_fnc_globalExecute", true, false] call MCC_fnc_remoteExec;
		_loop = 20; 
		for [{_x=1},{_x<=_loop},{_x=_x+1}]  do //Create progress bar
		{
			_footer = [_x,_loop] call MCC_fnc_countDownLine;
			//add header
			_html = "<t color='#818960' size='1.2' shadow='0' align='left' underline='true'>" + "Synchronizing with server" + "</t><br/><br/>";
			//add _text
			_html = _html + "<t color='#a9b08e' size='1' shadow='0' shadowColor='#312100' align='left'>" + "Wait a moment, Synchronizing with the server" + "</t>";
			//add _footer
			_html = _html + "<br/><br/><t color='#818960' size='0.85' shadow='0' align='right'>" + _footer + "</t>";
			hintsilent parseText(_html);
			sleep 0.1;
			if (!mcc_sync_status) then {sleep 3}; 
		};
		if (!isNil "MCC_sync" && {MCC_sync isEqualType ""} && {MCC_sync != ""}) then {
			diag_log "MCC: Skipped execution of synchronized SQF text; remote SQF string execution is disabled.";
			hint "Synchronization finished without executing remote SQF state.";
		} else {
			hint "Synchronizing Done";
		};
	};
   
   case 1:
   {
		if (!isserver) exitwith {};
		_player = if (((_this select 1) select 0)=="") then {(_this select 1) select 1} else {objectFromNetID ((_this select 1) select 0)};
		sleep 1;
	   _d=[date select 0, date select 1, date select 2, date select 3, date select 4];
	   [[_d],"MCC_fnc_setTime",true,false] call MCC_fnc_remoteExec;
	   _cloudLevel = overcast;
	   _wind = windStr; 
	   _waves = waves; 
	   _RainLevel = rain;
	   _lightning=lightnings;
	   //_fog = fog;
	   _weather = [_cloudLevel, _wind, _waves, _RainLevel,_lightning];
	   [[_weather],"MCC_fnc_setWeather",true,false] call MCC_fnc_remoteExec;
	   [[2, "syncState", [MCC_sync, mcc_missionmaker]], "MCC_fnc_globalExecute", _player, false] call MCC_fnc_remoteExec;
	};
 };
