public OnPlayerStateChange(playerid, newstate, oldstate)
{
    printf(">-- OnPlayerStateChange(playerid = %d, newstate = %d, oldstate = %d) -->", playerid, newstate, oldstate);
    SendMes(playerid, COLOR_BLUE, "NEWSTATE - %i, OLDSTATE - %i", newstate, oldstate);

	new tacha = GetPlayerVehicleID(playerid);
	SetPVarInt(playerid, "GunCheckTime", 2);
	if (newstate == 2) SetPVarInt(playerid,"AC_MCS",GetTickCount());
	else if (oldstate == 2) if((GetTickCount() - GetPVarInt(playerid,"AC_MCS")) <= 250 && PTEMP[playerid][pAdmin] <= 0) return CheatKick(playerid,005);
	if ((newstate == 2 && oldstate == 3) || (newstate == 3 && oldstate == 2) && PTEMP[playerid][pAdmin] <= 0) return CheatKick(playerid, 006);
	if (oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) GetVehicleHealth(GetPlayerVehicleID(playerid), last_vehicle_health[playerid]);
	else if (oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT) last_vehicle_health[playerid] = -1;
	if (oldstate == PLAYER_STATE_DRIVER)
	{
		KillTimer(timer2[playerid]);
	}
	if (SpecID[playerid] != INVALID_PLAYER_ID)
	{
		if (Spectate[SpecID[playerid]] == 1 && SpecAd[SpecID[playerid]] == playerid)
		{
			StartSpectate(SpecID[playerid],playerid);
		}
	}
	new caridi = GetPlayerVehicleID(playerid);
	//if(newstate == PLAYER_STATE_DRIVER && Type == 2) Timerkk[playerid] = SetTimerEx("_UnSurfCar",1600,1, "i",GetPlayerVehicleID(playerid));
	if (newstate == PLAYER_STATE_ONFOOT)
	{
		new Veh = GetPlayerVehicleID(playerid);
		car_ex[Veh] = true;
		GetVehiclePos(Veh,car_coord[Veh][0],car_coord[Veh][1],car_coord[Veh][2]);
		GetVehicleZAngle(Veh,car_coord[Veh][3]);
		if (GetPVarInt(playerid, "farm_status") == 3 || GetPVarInt(playerid, "farm_status") == 5) DisablePlayerRaceCheckpoint(playerid), DeletePVar(playerid, "farm_status");
		if (PTEMP[playerid][pJob] == 2)
		{
			if (gcontract[playerid] == 1)
			{
				Delete3DTextLabel(Meh3d[GetPlayerVehicleID(playerid)]);
				gcontract[playerid] = 0;
			}
		}
		if (GetPVarInt(playerid, "TypeBus") > 0)
		{
			SCM(playerid, COLOR_LIGHTRED, "У вас есть 40 секунд, чтобы вернуться");
			SetPVarInt(playerid, "BusTime", 40);
		}
		if (TalkingLive[playerid] == 2)
		{
			SCM(playerid, 0x6495EDFF, "Прямой эфир завершён");
			SCM(TalkingLive[playerid], 0x6495EDFF, "Прямой эфир завершён");
			TogglePlayerControllable(playerid, 1);
			TogglePlayerControllable(TalkingLive[playerid], 1);
			TalkingLive[TalkingLive[playerid]] = 255;
			TalkingLive[playerid] = 255;
			return true;
		}
		else if (TalkingLivels[playerid] == 2)
		{
			SCM(playerid, 0x6495EDFF, "Прямой эфир завершён");
			SCM(TalkingLivels[playerid], 0x6495EDFF, "Прямой эфир завершён");
			TogglePlayerControllable(playerid, 1);
			TogglePlayerControllable(TalkingLivels[playerid], 1);
			TalkingLivels[TalkingLivels[playerid]] = 255;
			TalkingLivels[playerid] = 255;
			return true;
		}
		else if (TalkingLivelv[playerid] == 2)
		{
			SCM(playerid, 0x6495EDFF, "Прямой эфир завершён");
			SCM(TalkingLivelv[playerid], 0x6495EDFF, "Прямой эфир завершён");
			TogglePlayerControllable(playerid, 1);
			TogglePlayerControllable(TalkingLivelv[playerid], 1);
			TalkingLivelv[TalkingLivelv[playerid]] = 255;
			TalkingLivelv[playerid] = 255;
			return true;
		}
	}
	if (newstate == PLAYER_STATE_DRIVER)
	{
		if (!IsAPlane(tacha) && !IsABoat(tacha) && !IsABike(tacha) && AutoSaloon[playerid] != true)
		{
			if (PTEMP[playerid][pDrivingSkill] < 2) PTEMP[playerid][pDrivingSkill] = 1;
			PlayerTextDrawSetString(playerid,LimitShow[playerid], "~r~MAX");
			TextDrawShowForPlayer(playerid,Speed);
			PlayerTextDrawShow(playerid,SpeedShow[playerid]);
			PlayerTextDrawShow(playerid,FuelShow[playerid]);
			PlayerTextDrawShow(playerid,StatusShow[playerid]);
			PlayerTextDrawShow(playerid,KMShow[playerid]);// СПИДОМЕТР
			PlayerTextDrawShow(playerid,LimitShow[playerid]);
			PlayerTextDrawShow(playerid,FillShow[playerid]);
			TextDrawShowForPlayer(playerid, BoxPanel);
			GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
			if (doors) PlayerTextDrawColor(playerid,StatusShow[playerid], -16776961), PlayerTextDrawSetString(playerid,StatusShow[playerid],"Lock"), PlayerTextDrawShow(playerid,StatusShow[playerid]);
			else PlayerTextDrawColor(playerid,StatusShow[playerid], 0x20B220AA), PlayerTextDrawSetString(playerid,StatusShow[playerid],"Unlock"), PlayerTextDrawShow(playerid,StatusShow[playerid]);
			if (vehicleidtp[playerid] != tacha && PTEMP[playerid][pAdmin] == 0) return 1;
			else vehicleidtp[playerid] = INVALID_VEHICLE_ID;
		}
	}
	else if (newstate == PLAYER_STATE_ONFOOT)
	{
		if (!IsAPlane(tacha) && !IsABoat(tacha) && !IsABike(tacha))
		{
			TextDrawHideForPlayer(playerid,Speed);
			PlayerTextDrawHide(playerid,SpeedShow[playerid]);
			PlayerTextDrawHide(playerid,FuelShow[playerid]);
			PlayerTextDrawHide(playerid,StatusShow[playerid]);
			PlayerTextDrawHide(playerid,KMShow[playerid]);
			PlayerTextDrawHide(playerid,LimitShow[playerid]);
			PlayerTextDrawHide(playerid,FillShow[playerid]);
			TextDrawHideForPlayer(playerid, BoxPanel);
		}
	}
	if (newstate == 2)
	{
		if (GetPVarInt(playerid, "EnterVehTime") > GetTickCount())
		{
			if (PTEMP[playerid][pAdmin] < 2)
			{
				if (GetPVarInt(playerid,"WarningCheat") < 1)
				{
					SCM(playerid,COLOR_LIGHTRED,"Вы были кикнуты по подозрению в читерстве! (#001)");
					SetPVarInt(playerid, "WarningCheat", 15);
					Kick(playerid);
				}
			}
		}
		SetPVarInt(playerid, "EnterVehTime", GetTickCount() + 950);
	}
	if (newstate == PLAYER_STATE_DRIVER)
	{
		if (avtocar[playerid] != 0 && PTEMP[playerid][pJob] == 65)
		{
			if (caridi == avtocar[playerid])
			{
				rabotaon[playerid] = 1;
				new rand = random(sizeof(acarsd));
				SCM(playerid, COLOR_BLUE, "[SMS]: Это то что нам нужно! Гони её на склад!");
				SetPlayerCheckpoint(playerid,acarsd[rand][0],acarsd[rand][1],acarsd[rand][2],8);
				GangZoneDestroy(gangzonesa[playerid]);
			}
		}
		if (Fuell[caridi] <= 0 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 462)
		{
			SCM(playerid, COLOR_RED, " Двигатель не заводится");
			SCM(playerid, COLOR_GREEN, " {00A86B}Используйте телефон {FFFFFF}(( /call )){00A86B} чтобы вызвать механика / таксиста");
			SCM(playerid, COLOR_GREEN, " {00A86B}Если у вас есть канистра с бензином, введите {FFFFFF}(( /fillcar ))");
			Fuell[caridi] = 0;
		}
		if (GetVehicleModel(caridi) == 481 || GetVehicleModel(caridi) == 509 || GetVehicleModel(caridi) == 510)
		{
			GetVehicleParamsEx(caridi, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(caridi, true, lights, alarm, doors, bonnet, boot, objective);
		}
		else
		{
			GetVehicleParamsEx(caridi,engine,lights,alarm,doors,bonnet,boot,objective);
			if (!engine && PTEMP[playerid][SalonCar] != caridi) SCM(playerid, -1, "{00AB06} Чтобы завести двигатель нажмите клавишу {FFFFFF}'2'{00AB06} или введите команду {FFFFFF}/en");
		}
		if (GetVehicleModel(caridi) == 482)
  		{
			switch (PTEMP[playerid][pMember]){
            case 12: format(string, 128, " Материалы: %i/%i", Furi[0][gBallas], maxMats[gBallas]);
            case 13: format(string, 128, " Материалы: %i/%i", Furi[0][gVagos], maxMats[gVagos]);
            case 15: format(string, 128, " Материалы: %i/%i", Furi[0][gGrove], maxMats[gGrove]);
            case 17: format(string, 128, " Материалы: %i/%i", Furi[0][gAztek], maxMats[gAztek]);
            case 18: format(string, 128, " Материалы: %i/%i", Furi[0][gRifa], maxMats[gRifa]);
			}
			SCM(playerid, TEAM_GROVE_COLOR, string);
  		}
	}
	if (newstate == PLAYER_STATE_PASSENGER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		if (doors == 1 && house_car[playerid] != vehicleid && IsABike(playerid)) RemovePlayerFromVehicleAC(playerid);
		foreach(i)
		{
			if (IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && GetPlayerState(i) == 2 && GetPVarInt(i,"TaxiDuty") > 0)
			{
				if (GetPVarInt(i,"Taxi_") == 0)
				{
					format(string, sizeof (string), " Пассажир %s сел в ваше Такси. Довезите его и государство заплатит вам",PTEMP[playerid][pName]);
					SCM(i, COLOR_BLUE, string);
					SetPVarInt(i,"Taxi_",playerid+1);
					if (PTEMP[playerid][pLevel] == 1 && PTEMP[playerid][pExp] < 4) CallLocalFunction("OnPlayerCommandText", "is", i, "/taxigps");
				}
				break;
			}
		}
	}
	if (newstate == PLAYER_STATE_DRIVER)
	{
		new newcar = GetPlayerVehicleID(playerid);
		TelePos[playerid][0] = 0.0;
		TelePos[playerid][1] = 0.0;
		if (IsAGunsCar(newcar))
		{
			format(string, 60, " Материалов: %i/10000", MatHaul[newcar-gunscar[0]][mLoad],MatHaul[newcar-gunscar[0]][mCapasity]);
			SCM(playerid, TEAM_GROVE_COLOR, string);
			SCM(playerid, -1, " Введите: /ConveyingArms (/carm)");
		}
		for (new i = 0; i <= TOTALFARM; i++)
		{
			if (newcar >= FarmInfo[i][fSeed_Car][0] && newcar <= FarmInfo[i][fSeed_Car][1])
			{
				if (GetPVarInt(playerid,"farm_rank") <= 1 || GetPVarInt(playerid,"farm_id") != i) return RemovePlayerFromVehicleAC(playerid),SCM(playerid, COLOR_GREY, " Вам недоступен данный транспорт");
				if (Farmcar_works[newcar]) ShowPlayerDialogEx(playerid,1345,DIALOG_STYLE_MSGBOX, " ","{00C8FF}Вы желаете завершить сбор урожая?", "Да", "Нет"),SendMes(playerid, TEAM_GROVE_COLOR," {00AB06}Урожая в машине: %d / 1000",Farmcar_prods[newcar]);
				else ShowPlayerDialogEx(playerid,1345,DIALOG_STYLE_MSGBOX, " ","{25BB00}Вы желаете начать сбор урожая?", "Да", "Нет"),SendMes(playerid, TEAM_GROVE_COLOR," {00AB06}Урожая в машине: %d / 1000",Farmcar_prods[newcar]);
			}
			else if (newcar == FarmInfo[i][fCombine])
			{
				if (GetPVarInt(playerid,"farm_rank") <= 1 || GetPVarInt(playerid,"farm_id") != i) return RemovePlayerFromVehicleAC(playerid),SCM(playerid, COLOR_GREY, " Вам недоступен данный транспорт");
				new idx = GetPVarInt(playerid,"farm_id");
				if (FarmInfo[idx][fGrain_Sown] > 0) return RemovePlayerFromVehicleAC(playerid),SCM(playerid, COLOR_GREY, "На поле ещё есть урожай");
				if (FarmInfo[idx][fGrain] <= 0) return RemovePlayerFromVehicleAC(playerid),SCM(playerid, COLOR_GREY, "На складе фермы недостаточно зерна");
				SetPVarInt(playerid, "farm_status", 5);
				DeletePVar(playerid, "farm_combine");

				switch (GetPVarInt(playerid, "farm_id")){
				case 1: SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")][0],Farmcar_coord_one[GetPVarInt(playerid,"farm_combine")][1],Farmcar_coord_one[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")+1][0],Farmcar_coord_one[GetPVarInt(playerid,"farm_combine")+1][1],Farmcar_coord_one[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				case 2: SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")][0],Farmcar_coord_two[GetPVarInt(playerid,"farm_combine")][1],Farmcar_coord_two[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")+1][0],Farmcar_coord_two[GetPVarInt(playerid,"farm_combine")+1][1],Farmcar_coord_two[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				case 3: SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")][0],Farmcar_coord_three[GetPVarInt(playerid,"farm_combine")][1],Farmcar_coord_three[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")+1][0],Farmcar_coord_three[GetPVarInt(playerid,"farm_combine")+1][1],Farmcar_coord_three[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				case 4: SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")][0],Farmcar_coord_four[GetPVarInt(playerid,"farm_combine")][1],Farmcar_coord_four[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")+1][0],Farmcar_coord_four[GetPVarInt(playerid,"farm_combine")+1][1],Farmcar_coord_four[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				case 5: SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")][0],Farmcar_coord_five[GetPVarInt(playerid,"farm_combine")][1],Farmcar_coord_five[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")+1][0],Farmcar_coord_five[GetPVarInt(playerid,"farm_combine")+1][1],Farmcar_coord_five[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				}
			}
		}
		if (newcar == mavlic)
		{
			if (GetPVarInt(playerid, "Fraction_Duty") && PTEMP[playerid][pMember] == 11) {}
			else
			{
				SCM(playerid,COLOR_GREY, " Вы не школьный инструктор!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= liccar[0] && newcar <= liccar[9])
		{
			if (GetPVarInt(playerid, "Fraction_Duty") && PTEMP[playerid][pMember] == 11 || TakingLesson[playerid] == 1 ) {}
			else
			{
				SCM(playerid,COLOR_GREY, " Вы не школьный инструктор!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= liccar[0] && newcar <= liccar[9])
		{
			if (PTEMP[playerid][pCarLic] == 0 && TakingLesson[playerid] == 1)
			{
				LessonStat[playerid]++;
				pLessonCar[playerid] = CHECKPOINT_1;
				SetPlayerRaceCheckpoint(playerid,0,-2056.8748,-97.6126,32.9113,-2047.1299,-82.7046,32.9072,5.0);
				SCM(playerid, 0x6495EDFF, "Используйте гудок для поднятия шлагбаума");
				SCM(playerid, 0x6495EDFF, "Чтобы прервать экзамен /endlesson");
			}
		}
		if (newcar >= armycarsf[13] && newcar <= armycarsf[15])
		{
			if (PTEMP[playerid][pMember] == 3)
			{
				SCM(playerid, COLOR_GREEN, "Учебный вертолет армии San Fierro");
			}
		}
		if (newcar >= rentcarvip[0] && newcar <= rentcarvip[8])
		{
			if (arenda[playerid] != newcar)
			{
				ShowPlayerDialogEx(playerid, 9125, DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}10000 вирт", "Оплатить", "Отмена");
				TogglePlayerControllable(playerid, 0);
			}
		}
		if (newcar >= rentcarsf[0] && newcar <= rentcarsf[6])
		{
			if (arenda[playerid] != newcar)
			{
				ShowPlayerDialogEx(playerid, 9126, DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}1500 вирт", "Оплатить", "Отмена");
				TogglePlayerControllable(playerid, 0);
			}
		}
		if (newcar >= rentcarls[0] && newcar <= rentcarls[8])
		{
			if (arenda[playerid] != newcar)
			{
				ShowPlayerDialogEx(playerid, 9126, DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}1500 вирт", "Оплатить", "Отмена");
				TogglePlayerControllable(playerid, 0);
			}
		}
		if (newcar >= rentcarlv[0] && newcar <= rentcarlv[17])
		{
			if (arenda[playerid] != newcar)
			{
				ShowPlayerDialogEx(playerid, 9126, DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}1500 вирт", "Оплатить", "Отмена");
				TogglePlayerControllable(playerid, false);
			}
		}
		new car = GetPlayerVehicleID(playerid);
		if (car >= PetrolTanker[0] && car <= PetrolTanker[5])
		{
			if (jobcar[car] == false)
			{
				if (PTEMP[playerid][pJob] == 99)
				{
					TogglePlayerControllable(playerid, false);
					ShowPlayerDialogEx(playerid, 32000, 0, "Аренда транспорта", "Стоимость аренды: {FFFF00}15000 вирт", "Оплатить", "Отмена");
				}
				else
				{
					SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Дальнобойщик");
					RemovePlayerFromVehicleAC(playerid);
					TogglePlayerControllable(playerid, true);
				}
			}
		}
		if (car >= Linerunner[0] && car <= Linerunner[1])
		{
			if (jobcar[car] == false)
			{
				TogglePlayerControllable(playerid, false);
				if (PTEMP[playerid][pJob] == 99)
				{
					ShowPlayerDialogEx(playerid, 32000, 0, "Аренда транспорта", "Стоимость аренды: {FFFF00}10000 вирт", "Оплатить", "Отмена");
				}
				else
				{
					SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Дальнобойщик");
					RemovePlayerFromVehicleAC(playerid);
					TogglePlayerControllable(playerid, true);
				}
			}
		}
		if (car >= Tanker[0] && car <= Tanker[11])
		{
			if (jobcar[car] == false)
			{
				TogglePlayerControllable(playerid, false);
				if (PTEMP[playerid][pJob] == 99)
				{
					ShowPlayerDialogEx(playerid, 32000, 0, "Аренда транспорта", "Стоимость аренды: {FFFF00}5000 вирт", "Оплатить", "Отмена");
				}
				else
				{
					SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Дальнобойщик");
					RemovePlayerFromVehicleAC(playerid);
					TogglePlayerControllable(playerid, true);
				}
			}
		}
		if (car >= Roadtrain[0] && car <= Roadtrain[5])
		{
			if (jobcar[car] == false)
			{
				TogglePlayerControllable(playerid, false);
				if (PTEMP[playerid][pJob] == 99)
                {
                    ShowPlayerDialogEx(playerid, 32000, 0, "Аренда транспорта", "Стоимость аренды: {FFFF00}20000 вирт", "Оплатить", "Отмена");
                }
                else
				{
					SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Дальнобойщик");
					RemovePlayerFromVehicleAC(playerid);
					TogglePlayerControllable(playerid, true);
				}
			}
		}
		if (newcar >= hotdogcar[0] && newcar <= hotdogcar[1])
		{
			if (PTEMP[playerid][pJob] != 3)
			{
				SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Продавец хот-догов");
				RemovePlayerFromVehicleAC(playerid);
				return true;
			}
			if (GetPVarInt(playerid, "rentcar_job") == GetPlayerVehicleID(playerid)) SCM(playerid,COLOR_GREEN,"Заключите контракт с закусочной, для торговли едой. (( Подъедьте к закусочной и введите: /hcontract ))");
			else ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
		}
		if ((newcar >= buscar[0] && newcar <= buscar[1]) || (newcar >= buscar[2] && newcar <= buscar[3]) || (newcar >= buscar[4] && newcar <= buscar[5]) || (newcar >= buscar[6] && newcar <= buscar[7]))
		{
			if (PTEMP[playerid][pJob] != 1)
			{
				SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Водитель автобуса");
				RemovePlayerFromVehicleAC(playerid);
				return true;
			}
			if (GetPVarInt(playerid, "BusTime") > 0 && GetPVarInt(playerid, "rentcar_job") == GetPlayerVehicleID(playerid))
			{
				new i = pPressed[playerid], type = GetPVarInt(playerid, "TypeBus"),name[64];
				switch (type){
				case 1: name = "Внутригородской ЛС";
				case 2: name = "Внутригородской СФ";
				case 3: name = "Внутригородской ЛВ";
				case 4: name = "Автовокзал LS << >> Автошкола SF";
				case 5: name = "Автовокзал LS << >> Автовокзал LV";
				case 6: name = "Автовокзал LS << >> Заводы";
				}
				format(string, 90, "%s\n<< Проезд бесплатный >>", name);
				Attach3DTextLabelToVehicle(JobText3D[newcar], GetPlayerVehicleID(playerid), 0.0, 0.0, 2.25);

                switch (type){
				case 1: SetPlayerRaceCheckpoint(playerid, 0, BusCityLS[i][0], BusCityLS[i][1], BusCityLS[i][2], BusCityLS[i][3], BusCityLS[i][4], BusCityLS[i][5], 7.0);
				case 2: SetPlayerRaceCheckpoint(playerid, 0, BusCitySF[i][0], BusCitySF[i][1], BusCitySF[i][2], BusCitySF[i][3], BusCitySF[i][4], BusCitySF[i][5], 7.0);
				case 3: SetPlayerRaceCheckpoint(playerid, 0, BusCityLV[i][0], BusCityLV[i][1], BusCityLV[i][2], BusCityLV[i][3], BusCityLV[i][4], BusCityLV[i][5], 7.0);
				case 4: SetPlayerRaceCheckpoint(playerid, 0, BusSchool[i][0], BusSchool[i][1], BusSchool[i][2], BusSchool[i][3], BusSchool[i][4], BusSchool[i][5], 7.0);
				case 5: SetPlayerRaceCheckpoint(playerid, 0, BusLSLV[i][0], BusLSLV[i][1], BusLSLV[i][2], BusLSLV[i][3], BusLSLV[i][4], BusLSLV[i][5], 5.0);
				case 6: SetPlayerRaceCheckpoint(playerid, 0, BusLSZavodi[i][0], BusLSZavodi[i][1], BusLSZavodi[i][2], BusLSZavodi[i][3], BusLSZavodi[i][4], BusLSZavodi[i][5], 5.0);
                }

				DeletePVar(playerid, "BusTime");
			}
			if (GetPVarInt(playerid, "rentcar_job") == GetPlayerVehicleID(playerid)) {}
			else ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
		}
		if (newcar >= taxicar[0] && newcar <= taxicar[68])
		{
			if (PTEMP[playerid][pJob] == 4 && PTEMP[playerid][pMember] == 0)
			{
				if (GetPVarInt(playerid, "rentcar_job") != newcar)
				{
					ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
				}
			}
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Таксист");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= taxi5lvlcar[0] && newcar <= taxi5lvlcar[9])
		{
			if (PTEMP[playerid][pJob] == 4 && PTEMP[playerid][pMember] == 0 && PTEMP[playerid][ptaxilvl] >= 5)
			{
				if (GetPVarInt(playerid, "rentcar_job") != newcar)
				{
					ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
				}
			}
			else
			{
	  			if (PTEMP[playerid][pJob] != 4)
				{
					SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Таксист");
					RemovePlayerFromVehicleAC(playerid);
				}
	  			else if (PTEMP[playerid][ptaxilvl] <= 5)
				{
					SCM(playerid, COLOR_GREY, " Для этого транспорта требуется 5 уровень скилла");
					RemovePlayerFromVehicleAC(playerid);
				}
			}
		}
		if (newcar >= taxi10lvlcar[0] && newcar <= taxi10lvlcar[10])
		{
			if (PTEMP[playerid][pJob] == 4 && PTEMP[playerid][pMember] == 0 && PTEMP[playerid][ptaxilvl] >= 10)
			{
				if (GetPVarInt(playerid, "rentcar_job") != newcar)
				{
					ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
				}
			}
			else
			{
	  			if (PTEMP[playerid][pJob] != 4)
				{
					SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Таксист");
					RemovePlayerFromVehicleAC(playerid);
				}
	  			else if (PTEMP[playerid][ptaxilvl] <= 10)
				{
					SCM(playerid, COLOR_GREY, " Для этого транспорта требуется 10 уровень скилла");
					RemovePlayerFromVehicleAC(playerid);
				}
			}
		}
		if (newcar >= taxi40lvlcar[0] && newcar <= taxi40lvlcar[6])
		{
			if (PTEMP[playerid][pJob] == 4 && PTEMP[playerid][pMember] == 0 && PTEMP[playerid][ptaxilvl] >= 40)
			{
				if (GetPVarInt(playerid, "rentcar_job") != newcar)
				{
					ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
				}
			}
			else
			{
	  			if (PTEMP[playerid][pJob] != 4)
				{
					SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Таксист");
					RemovePlayerFromVehicleAC(playerid);
				}
	  			else if (PTEMP[playerid][ptaxilvl] <= 40)
				{
					SCM(playerid, COLOR_GREY, " Для этого транспорта требуется 40 уровень скилла");
					RemovePlayerFromVehicleAC(playerid);
				}
			}
		}
		if (IsABoat(newcar))
		{
			if (PTEMP[playerid][pBoatLic] < 1)
			{
				SCM(playerid, COLOR_GREY, " У вас нет лицензии. Вы не можете управлять данным транспортом");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (IsAPlane(newcar))
		{
			if (PTEMP[playerid][pFlyLic] < 1)
			{
				if (TakingLesson[playerid] != 1)
				{
					SCM(playerid, COLOR_GREY, " У вас нет лицензии. Вы не можете управлять данным транспортом");
					RemovePlayerFromVehicleAC(playerid);
				}
			}
		}
		if (CarLic(newcar))
		{
			if (PTEMP[playerid][pCarLic] == 0)
			{
				if (TakingLesson[playerid] != 1)
				{
					SCM(playerid, COLOR_GREY, " Прежде чем управлять данным видом транспорта, приобретите лицензию на вождение.");//водительское удостоверение
					RemovePlayerFromVehicleAC(playerid);
				}
			}
		}
		if (newcar >= lsnewscar[0] && newcar <= lsnewscar[5])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 16) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не работник LS News!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= lvpdcar[0] && newcar <= lvpdcar[20])
		{
			if (!GetPVarInt(playerid,"Fraction_Duty") || PTEMP[playerid][pMember] != 21)
			{
				SCM(playerid, COLOR_GREY, " Транспорт принадлежит LVPD");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= hamccar[0] && newcar <= hamccar[10])
		{
			if (PTEMP[playerid][pLeader] == 24 || PTEMP[playerid][pMember] == 24) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт принадлежит Hell's Angels MC");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= wmccar[0] && newcar <= wmccar[10])
		{
			if (PTEMP[playerid][pLeader] == 26 || PTEMP[playerid][pMember] == 26) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт принадлежит Warlocks MC");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= pmccar[0] && newcar <= pmccar[10])
		{
			if (PTEMP[playerid][pLeader] == 29 || PTEMP[playerid][pMember] == 29) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт принадлежитPagans MC");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= ruscar[0] && newcar <= ruscar[14])
		{
			if (PTEMP[playerid][pLeader] == 14 || PTEMP[playerid][pMember] == 14) { }
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Русской мафии!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= lvnewscar[0] && newcar <= lvnewscar[7])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 20) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не работник LV News!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= lcncar[0] && newcar <= lcncar[14])
		{
			if (PTEMP[playerid][pLeader] == 5 || PTEMP[playerid][pMember] == 5) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член La Cosa Nostra!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= yakcar[0] && newcar <= yakcar[12])
		{
			if (PTEMP[playerid][pLeader] == 6 || PTEMP[playerid][pMember] == 6) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Yakuza!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= cnncar[0] && newcar <= cnncar[4] || newcar == cnnmav)
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 9) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член SF News!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= comptruck[0] && newcar <= comptruck[1])
		{
			if (PTEMP[playerid][pJob] == 5)
			{
				if (GetPVarInt(playerid,"rentcar_job") != newcar) ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
				else
				{
					if (car_pickup[newcar] > 0)
					{
						format(YCMDstr, 124, "{FFFFFF}Загружено: {0C9599}%i\n{FFFFFF}Общая стоимость: {0C9599}%i\n\n{B41010}Вы желаете завершить загрузку зерна?", car_grain[GetPlayerVehicleID(playerid)][0]-car_grain[GetPlayerVehicleID(playerid)][2], (car_grain[GetPlayerVehicleID(playerid)][0]-car_grain[GetPlayerVehicleID(playerid)][2])*ZernBuy);
						ShowPlayerDialogEx(playerid,1346,DIALOG_STYLE_MSGBOX, " ", YCMDstr, "Да", "Нет");
					}
					else
					{
						SendMes(playerid,TEAM_GROVE_COLOR," Зерна в машине: %i / 1000",car_grain[GetPlayerVehicleID(playerid)][0]);
						SendMes(playerid,TEAM_GROVE_COLOR," Урожая в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][0]);
						SendMes(playerid,TEAM_GROVE_COLOR," Наркотиков в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][1]);
					}
				}
				//SCM(playerid, -1, "Для загрузки продуктов, Введите: /load ");
			}
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Развозчик продуктов");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= comptruck[2] && newcar <= comptruck[3])
		{
			if (PTEMP[playerid][pJob] != 5) return SCM(playerid,COLOR_GREY," Транспорт недоступен! Вы должны устроиться на работу: Развозчик продуктов"), RemovePlayerFromVehicleAC(playerid);
			if (GetPVarInt(playerid,"rentcar_job") != newcar) ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
		}
		if (newcar >= comptruck[4] && newcar <= comptruck[5])
		{
			if (PTEMP[playerid][pJob] != 5) return SCM(playerid,COLOR_GREY," Транспорт недоступен! Вы должны устроиться на работу: Развозчик продуктов"), RemovePlayerFromVehicleAC(playerid);
			if (GetPVarInt(playerid,"rentcar_job") != newcar) ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
		}
		if (newcar >= comptruck[6] && newcar <= comptruck[7])
		{
			if (PTEMP[playerid][pPSkill] < 4) return SCM(playerid,-1," Автомобиль доступен с 4 уровня развозчика"), RemovePlayerFromVehicleAC(playerid);
			if (PTEMP[playerid][pJob] != 5) return SCM(playerid,COLOR_GREY," Транспорт недоступен! Вы должны устроиться на работу: Развозчик продуктов"), RemovePlayerFromVehicleAC(playerid);
			if (GetPVarInt(playerid,"rentcar_job") != newcar) ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
		}
		if (newcar >= comptruck[8] && newcar <= comptruck[9])
		{
			if (PTEMP[playerid][pPSkill] < 8) return SCM(playerid,-1," Автомобиль доступен с 8 уровня развозчика"), RemovePlayerFromVehicleAC(playerid);
			if (PTEMP[playerid][pJob] != 5) return SCM(playerid,COLOR_GREY," Транспорт недоступен! Вы должны устроиться на работу: Развозчик продуктов"), RemovePlayerFromVehicleAC(playerid);
			if (GetPVarInt(playerid,"rentcar_job") != newcar) ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
		}
		if (newcar >= govcar[0] && newcar <= govcar[7])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 7) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт принадлежит Мэрии!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= matsfura[0] && newcar <= matsfura[0])
		{
			if (PTEMP[playerid][pLeader] == 12 || PTEMP[playerid][pMember] == 12) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член The Ballas Gang!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= fbicar[0] && newcar <= fbicar[16])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 2) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит FBI");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= sapdcar[0] && newcar <= sapdcar[15])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 1) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит LSPD");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= medicsls[0] && newcar <= medicsls[9])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 4) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит МЧС");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= medicsfc[0] && newcar <= medicsfc[7])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 4) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит МЧС");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= medicsls1[0] && newcar <= medicsls1[0])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 4) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит МЧС");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= medicslv[0] && newcar <= medicslv[8])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 4) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит МЧС");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= medicssf[0] && newcar <= medicssf[13])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 4) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит МЧС");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= medicssf1[0] && newcar <= medicssf1[5])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 4) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит МЧС");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= mehanik[0] && newcar <= mehanik[12])
		{
			if (PTEMP[playerid][pJob] == 2 && PTEMP[playerid][pMember] == 0)
			{
				if (GetPVarInt(playerid, "rentcar_job") != newcar)
				{
					ShowPlayerDialogEx(playerid,9128,DIALOG_STYLE_MSGBOX, "Аренда транспорта", "Стоимость аренды: {FFFF00}500 вирт", "Оплатить", "Отмена");
				}
			}
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт недоступен! Вы должны устроиться на работу: Механик");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= sfpdcar[0] && newcar <= sfpdcar[15])
		{
			if (GetPVarInt(playerid, "Fraction_Duty") && PTEMP[playerid][pMember] == 10) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит SFPD");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= matsfuragrove[0] && newcar <= matsfuragrove[0])
		{
			if (PTEMP[playerid][pLeader] == 15 || PTEMP[playerid][pMember] == 15) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Grove street!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= matsfuraactek[0] && newcar <= matsfuraactek[0])
		{
			if (PTEMP[playerid][pLeader] == 17 || PTEMP[playerid][pMember] == 17) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Varios Los Aztecas!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= matsfuravagos[0] && newcar <= matsfuravagos[0])
		{
			if (PTEMP[playerid][pLeader] == 13 || PTEMP[playerid][pMember] == 13) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Vagos!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= matsfurarifa[0] && newcar <= matsfurarifa[0])
		{
			if (PTEMP[playerid][pLeader] == 18 || PTEMP[playerid][pMember] == 18) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Rifa!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= ballascar[0] && newcar <= ballascar[6])
		{
			if (PTEMP[playerid][pLeader] == 12 || PTEMP[playerid][pMember] == 12) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Ballas!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= grovecar[0] && newcar <= grovecar[6])
		{
			if (PTEMP[playerid][pLeader] == 15 || PTEMP[playerid][pMember] == 15) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Grove street!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= coronoscar[0] && newcar <= coronoscar[6])
		{
			if (PTEMP[playerid][pLeader] == 17 || PTEMP[playerid][pMember] == 17) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Varios Los Aztecas!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= vagoscar[0] && newcar <= vagoscar[6])
		{
			if (PTEMP[playerid][pLeader] == 13 || PTEMP[playerid][pMember] == 13) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Vagos!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= rifacar[0] && newcar <= rifacar[6])
		{
			if (PTEMP[playerid][pLeader] == 18 || PTEMP[playerid][pMember] == 18) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы не член Rifa!");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= gunscar[0] && newcar <= gunscar[6])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 19 || proverkaforma[playerid] == 1) {}
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт принадлежит ARMY LV");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= lsacar[0] && newcar <= lsacar[15])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 3 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 19 || proverkaforma[playerid] == 1) { }
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт принадлежит военным");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (PTEMP[playerid][pMember] == 24 && newcar == hamccar[10])
		{
		    SendMes(playerid,COLOR_GREEN," Груза в фургоне: %i / 10000",vertmatbilsa[hamccar[10]][0]);
		}
		else if (PTEMP[playerid][pMember] == 26 && newcar == wmccar[10])
		{
		    SendMes(playerid,COLOR_GREEN," Груза в фургоне: %i / 10000",vertmatbilsa[wmccar[10]][0]);
		}
		else if (PTEMP[playerid][pMember] == 26 && newcar == pmccar[10])
		{
		    SendMes(playerid,COLOR_GREEN," Груза в фургоне: %i / 10000",vertmatbilsa[pmccar[10]][0]);
		}
		if (newcar >= lsacarvert[0] && newcar <= lsacarvert[0])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 3 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 19 || proverkaforma[playerid] == 1)
			{
				if (VertMatslsa[playerid] == 0) SetPlayerCheckpoint(playerid,-1468.2487,1488.6337,9.8943,14.0);
				SendMes(playerid,TEAM_GROVE_COLOR," Материалов: %i / 30000",vertmatbilsa[GetPlayerVehicleID(playerid)][0]);
				if (VertMatslsa[playerid] == 0) SCM(playerid,COLOR_GREEN, " Миссия по доставке материалов начата, место загрузки / разгрузки помечено на карте");
				if (VertMatslsa[playerid] == 0) VertMatslsa[playerid] = 1;
				lsacarvertexit[playerid] = 1;
			}
			else
			{
				SCM(playerid, COLOR_GREY, " Транспорт принадлежит военным");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= armycarsf[0] && newcar <= armycarsf[23])
		{
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 3 || proverkaforma[playerid] == 1) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит ARMY SF");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= armycarsf[24] && newcar <= armycarsf[28])
		{
			if (GetPVarInt(playerid, "Fraction_Duty") && PTEMP[playerid][pMember] == 3 || proverkaforma[playerid] == 1)
			{
				if (VertMats[playerid] == 0) SetPlayerCheckpoint(playerid,-1468.2487,1488.6337,9.8943,14.0);
				VertMats[playerid] = 1;
				SendMes(playerid,TEAM_GROVE_COLOR," Материалов: %i / 30000",vertmatbi[GetPlayerVehicleID(playerid)][0]);
				if (VertMats[playerid] == 0) SCM(playerid, COLOR_GREEN, " Миссия по доставке материалов начата, место загрузки / разгрузки помечено на карте");
				return true;
			}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит ARMY SF");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if (newcar >= armcar[0] && newcar <= armcar[26])
		{
			if (GetPVarInt(playerid, "Fraction_Duty") && PTEMP[playerid][pMember] == 19 || proverkaforma[playerid] == 1) {}
			else
			{
				SCM(playerid, COLOR_GRAD1, " Транспорт принадлежит ARMY LV");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
	}

    printf("<-- OnPlayerStateChange(playerid = %d, newstate = %d, oldstate = %d) --<", playerid, newstate, oldstate);

	return true;
}