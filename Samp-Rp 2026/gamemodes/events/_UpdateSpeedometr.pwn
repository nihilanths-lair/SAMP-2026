publics:_UpdateSpeedometr()
{
    //print("--> _UpdateSpeedometr()");

	foreach(playerid)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) continue;
		if(IsAPlane(GetPlayerVehicleID(playerid)) || IsABoat(GetPlayerVehicleID(playerid)) || IsABike(GetPlayerVehicleID(playerid))) continue;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		_UnSurfCar(vehicleid);
		format(str1,5,"%i",SpeedVehicle(playerid));
		if(PTEMP[playerid][pDrivingSkill] > 0 && !IsANoLimiter(vehicleid))
		{
			switch(PTEMP[playerid][pDrivingSkill])
			{
			case 1..300: if(SpeedVehicle(playerid) > 50) format(str1, 5, "50");
			case 301..600: if(SpeedVehicle(playerid) > 45) format(str1, 5, "45");
			case 601..900: if(SpeedVehicle(playerid) > 40) format(str1, 5, "40");
			case 901..1200: if(SpeedVehicle(playerid) > 35) format(str1, 5, "35");
			}
		}
		PlayerTextDrawSetString(playerid,SpeedShow[playerid],str1);
		if(Fuell[vehicleid] <= 0 && engine)
		{
			Fuell[vehicleid] = 0;
			GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			SetVehicleParamsEx(vehicleid,false,false,alarm,doors,bonnet,boot,objective);
			GameTextForPlayer(playerid,"~r~FUEL HAS ENDED", 5000, 3);
			SCM(playerid, COLOR_GREEN, " {00A86B}Используйте телефон {FFFFFF}(( /call )) {00A86B}чтобы вызвать механика / таксиста");
			SCM(playerid, COLOR_GREEN, " {00A86B}Если у вас есть канистра с бензином, введите {FFFFFF}(( /fillcar ))");
		}
		if(Fuell[vehicleid] <= 45) format(str2, sizeof(str2), "~r~%.0f", Fuell[vehicleid]);
		else if(Fuell[vehicleid] <= 100) format(str2, sizeof(str2), "~y~%.0f", Fuell[vehicleid]);
		else format(str2, sizeof(str2), "~g~%.0f", Fuell[vehicleid]);
		PlayerTextDrawSetString(playerid,FuelShow[playerid],str2);
		if(vehicleid == house_car[playerid]) CarInfo[playerid][carFuel][GetPVarInt(playerid, "chosencar")] = Fuell[vehicleid];
		if(!engine && SpeedVehicle(playerid) > 20 && GetPVarInt(playerid,"not_engine") < gettime() && GetPVarInt(playerid, "AFK_Time") < 2)
		{
			if(GetPVarInt(playerid,"not_engine") > 0 && GetPVarInt(playerid,"not_engine_") < SpeedVehicle(playerid))
			{
				return CheatKick(playerid, 033);
			}
			SetPVarInt(playerid,"not_engine", gettime() + 5);
			SetPVarInt(playerid,"not_engine_", SpeedVehicle(playerid));
		}
	}

    //print("<-- _UpdateSpeedometr()");

	return true;
}