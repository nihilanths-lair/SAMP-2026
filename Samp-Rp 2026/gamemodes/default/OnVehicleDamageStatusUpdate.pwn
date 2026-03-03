public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new Float: carhp;
	GetVehicleHealth(vehicleid,carhp);
	if((vehicleid >= buscar[0] && vehicleid <= buscar[1]) || (vehicleid >= buscar[2] && vehicleid <= buscar[3]) || (vehicleid >= buscar[4] && vehicleid <= buscar[5]) || (vehicleid >= buscar[6] && vehicleid <= buscar[7])) SetPVarInt(playerid,"BusRepairMoney", (1000-floatround(carhp))*3);
	if(carhp > 0 && carhp < 300 && enginebrokened[vehicleid] == 0)
	{
		GameTextForPlayer(playerid,"~r~ENGINE HAS BROKENED", 5000, 3),enginebrokened[vehicleid] = 1, SetVehicleHealth(vehicleid, 300.0);
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicleid,false,false,alarm,doors,bonnet,boot,objective);
	}
	if(GetPlayerVehicleID(playerid) == house_car[playerid])
	{
		if(CarInfo[playerid][carPercent][GetPVarInt(playerid, "chosencar")] <= 0)
		{
			return true;
		}
		if(carhp > 600 && carhp < 1000)
		{
			CarInfo[playerid][carPercent][GetPVarInt(playerid, "chosencar")] -= 1;
			return true;
		}
		else if(carhp > 400 && carhp < 600)
		{
			CarInfo[playerid][carPercent][GetPVarInt(playerid, "chosencar")] -= 2;
			return true;
		}
	}
	if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)) && PTEMP[playerid][pDgruz] > 1)
	{
		SetPVarInt(playerid, "GruzUron", GetPVarInt(playerid, "GruzUron")+1);
		if(GetPVarInt(playerid, "GruzUron") > 5)
		{
			if(PTEMP[playerid][pDgruz] == 0) PTEMP[playerid][pDgruz] = 1;
			PTEMP[playerid][pDgruz]--;
			SetPVarInt(playerid, "GruzUdar", 1);
			SCM(playerid, 0xFF6347AA, " Вы потеряли часть груза");
			DeletePVar(playerid, "GruzUron");
			return 1;
		}
	}
	new Float: trailhp;
	GetVehicleHealth(GetVehicleTrailer(GetPlayerVehicleID(playerid)), trailhp);
	if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)) && PTEMP[playerid][pDgruz] > 1)
	{
		if(trailhp < 300)
		{
			SCM(playerid, 0xFF6347AA, " Вы потеряли свой груз");
			peremennn[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			DriverJob[playerid] = false;
			PTEMP[playerid][pDgruz] = 0;
			Gruz[playerid] = 0;
			bGruz[playerid] = 0;
		}
	}
	GetVehicleHealth(vehicleid, carhp);
	if(floatcmp(last_vehicle_health[playerid], carhp) == 1)
	{
		accept_car_damage[playerid] += (last_vehicle_health[playerid] - carhp);
		last_vehicle_health[playerid] = carhp;
		if(accept_car_damage[playerid] > 900)
		{
			if(PTEMP[playerid][pDrivingSkill] <= 1800 && !IsANoLimiter(GetPlayerVehicleID(playerid)))
			{
				switch(PTEMP[playerid][pDrivingSkill])
				{
				case 0..1: PTEMP[playerid][pDrivingSkill] = 300;
				case 2..299: PTEMP[playerid][pDrivingSkill] = 600;
				case 300..599: PTEMP[playerid][pDrivingSkill] = 900;
				case 900..1199: PTEMP[playerid][pDrivingSkill] = 1200;
				}
				switch(PTEMP[playerid][pDrivingSkill])
				{
				case 300, 600, 900, 1200:
					{
						SCM(playerid,COLOR_RED," Ваш навык вождения был понижен. Соблюдайте /pdd для его повышения!");
						PlayerTextDrawSetString(playerid,LimitShow[playerid],"~r~MAX");
						accept_car_damage[playerid] = 0;
					}
				}
				accept_car_damage[playerid] = 0.0;
			}
		}
	}
	else last_vehicle_health[playerid] = carhp;
	return 1;
}