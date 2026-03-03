public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(SERVERTEST) SendMes(playerid,COLOR_BLUE,"EXITVEHICLE: PLAYERID - %i, VEHICLEID - %i",playerid,vehicleid);
	SetPVarInt(playerid,"AFK_Time",0);
	SetPVarInt(playerid, "GunCheckTime", 2);
	car_ex[vehicleid] = true;
	GetVehiclePos(vehicleid,car_coord[vehicleid][0],car_coord[vehicleid][1],car_coord[vehicleid][2]);
	GetVehicleZAngle(vehicleid,car_coord[vehicleid][3]);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPVarInt(playerid,"TaxiDuty"))
	{
		Delete3DTextLabel(JobText3D[GetPVarInt(playerid,"rentcar_job")]);
		DeletePVar(playerid,"TaxiDuty");
	}
	if(race_info[1] > 1 && GetPVarInt(playerid,"gonka") != 0)
	{
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,831.7769,6.8750,1004.1797);
		SetPlayerFacingAngle(playerid,108.1610);
		DestroyVehicle(RaceInfo[GetPVarInt(playerid,"gonka")-1][rCar]);
		DeletePVar(playerid,"gonka");
		SCM(playerid,COLOR_LIGHTRED,"Вы были дисквалифицированы!");
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
		foreach(i)
		{
			if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && GetPlayerState(i) == 2 && GetPVarInt(i,"TaxiDuty") > 0)
			{
				if(GetPVarInt(i,"Taxi_")-1 == playerid)
				{
					SCM(i, COLOR_BLUE, " Пассажир вышел из вашего Такси. Деньги будут зачислены во время зарплаты");
					if(GetPVarInt(i,"PayDayCashJob") > gettime()) {}
					else
					{
						new taxizp = 200+random(200);
						PTEMP[i][pPayCheck] += taxizp*PTEMP[i][ptaxilvl];
						if(PTEMP[i][pPayCheck] > 4000+(PTEMP[i][ptaxilvl]*1000)) PTEMP[i][pPayCheck] = 4000+(PTEMP[i][ptaxilvl]*1000);
					}
					SetPVarInt(playerid, "TaxiPlayer", i);
					ShowPlayerDialogEx(GetPVarInt(i,"Taxi_")-1, 1203, DIALOG_STYLE_MSGBOX, "Такси", "Как вас обслужили?", "Хорошо", "Плохо");
					DeletePVar(i,"Taxi_");
					for(new id; id < GetMaxPlayers(); id++)
					{
						if(IsPlayerInVehicle(id, GetPlayerVehicleID(playerid)) && id != i && id != playerid)
						{
							format(string, 128, " Довезите пассажира %s и государство заплатит вам",PTEMP[id][pName]);
							SCM(i, COLOR_BLUE, string);
							SetPVarInt(i,"Taxi_",id+1);
							break;
						}
					}
				}
			}
		}
	}
	if(rabotaon[playerid] == 1) DisablePlayerCheckpoint(playerid);
	if(PEfir[playerid] != 255)
	{
		format(string, 90, " Вы вышли из прямого эфира");
		SCM(playerid, -1, string);
		PEfir[playerid] = 255;
	}
	if(Pefir[playerid] == 1 || Pefir[playerid] == 2)
	{
		PEfir[playerid] = 255;
		format(string, 90, " Вы вышли из прямого эфира");
		SCM(playerid, -1, string);
	}
	DeletePVar(playerid, "EnterVehTime");
	return true;
}