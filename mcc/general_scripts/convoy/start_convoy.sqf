if !mcc_isloading then 
	{
	if (mcc_missionmaker == (name player)) then
	{
		if (MCC_capture_state) then
		{
			MCC_capture_var=MCC_capture_var + FORMAT ["
								[[[%1, %2 , %3, %4], %5 select 0],""MCC_fnc_startConvoy"",true,false] call MCC_fnc_remoteExec;
								"								 
								,point2
								,point3
								,point4
								,point5
								,vip];
			Hint "Action captured";
		} else {
			hint "Convoy is moving";
			[[[point2,point3,point4,point5],vip select 0],"MCC_fnc_startConvoy",true,false] call MCC_fnc_remoteExec;
			};
	}	
		else { player globalchat "Access Denied"};
	};