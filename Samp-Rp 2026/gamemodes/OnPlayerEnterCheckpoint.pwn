public OnPlayerEnterCheckpoint(playerid)
{
	if(SERVERTEST) SendMes(playerid,COLOR_BLUE,"CHECKPOINT: ENTERCHECKPOINT - %i",playerid);
	if(GetPVarInt(playerid,"farm_status") == 1)
	{
		switch(booston)
		{
		case 0:ClearAnimations(playerid),ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,1,1,1,1,0), Farmtimer[playerid] = SetTimerEx("FarmDuty", 15000, false, "d", playerid);
		case 1:ClearAnimations(playerid),ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,1,1,1,1,0), Farmtimer[playerid] = SetTimerEx("FarmDuty", 4950, false, "d", playerid);
		}
	}
	DeletePVar(playerid,"checkpoint");
	if(updatecheck[playerid] != 9999) KillTimer(kekovich(playerid)),DisablePlayerCheckpoint(playerid);
	if(updatecheck[playerid] != 9999) GameTextForPlayer(playerid, "\n\n~g~At Destination", 3000, 3),updatecheck[playerid] = 9999;
	new tmpcar = GetPlayerVehicleID(playerid);
	if(GetTickCount() - GetPVarInt(playerid,"entercheckpoint") <= 500) return CheatKick(playerid,003);
	SetPVarInt(playerid,"entercheckpoint", GetTickCount());
	if(GetPVarInt(playerid, "matovoz_rob") || GetPVarInt(playerid, "zapravka_rob"))
	{
	    if((vertmatbilsa[RobbingBiker[bikerCar]][0] + 250) <= 10000 && RobbingBiker[robType] == 1)
	    {
			vertmatbilsa[RobbingBiker[bikerCar]][0] += 250;
			SendMes(playerid,COLOR_GREEN," Груза в фургоне: %i / 10000",vertmatbilsa[RobbingBiker[bikerCar]][0]);
		}
		else if((vertmatbilsa[RobbingBiker[bikerCar]][0] + 100) <= 10000 && RobbingBiker[robType] == 2)
		{
			vertmatbilsa[RobbingBiker[bikerCar]][0] += 100;
			SendMes(playerid,COLOR_GREEN," Груза в фургоне: %i / 10000",vertmatbilsa[RobbingBiker[bikerCar]][0]);
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Грузовик полон!");
			if(RobbingBiker[robType] == 1)
			{
				MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad] += 250;
				format(string, sizeof(string), "Кол-во груза\n%i", MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad]);
			}
			else if(RobbingBiker[robType] == 2)
			{
				RobbingBiker[bresult] += 100;
        		format(string, sizeof(string), "Кол-во груза\n%i", RobbingBiker[bresult]);
  			}
		}
		UpdateDynamic3DTextLabelText(Rob3DText, 0xEDEA9FAA, string);
    	if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
    	ClearAnimations(playerid);
		ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,1,0);
		DisablePlayerCheckpoint(playerid);
	}
	
	if(GetPVarInt(playerid,"installation") == 2 && IsPlayerInRangeOfPoint(playerid, 10.0, 1067.3966,2128.3901,10.5110) && GetPVarInt(playerid,"Workshop") > 0)
	{
		switch(GetPVarInt(GetPVarInt(playerid,"installation_"),"detals"))
		{
		case 99: CarInfo[GetPVarInt(playerid,"installation_")][carPercent][GetPVarInt(GetPVarInt(playerid,"installation_"), "chosencar")] = 100; // ремонт двигателя
		case 100://перекраска
			{
				CarInfo[GetPVarInt(playerid,"installation_")][carColor_one][GetPVarInt(GetPVarInt(playerid,"installation_"), "chosencar")] = GetPVarInt(GetPVarInt(playerid,"installation_"),"color0");
				CarInfo[GetPVarInt(playerid,"installation_")][carColor_two][GetPVarInt(GetPVarInt(playerid,"installation_"), "chosencar")] = GetPVarInt(GetPVarInt(playerid,"installation_"),"color1");
				DeletePVar(GetPVarInt(playerid,"installation_"),"color0");
				DeletePVar(GetPVarInt(playerid,"installation_"),"color1");
			}
		}
		ClearAnimations(playerid);
		ApplyAnimation(playerid,"GANGS","hndshkba",4.1,0,1,1,0,1,1);
		SCM(playerid,COLOR_GREEN," Деталь установлена");
		SCM(GetPVarInt(playerid,"installation_"),COLOR_GREEN," Механик установил деталь");
		WorkshopInfo[GetPVarInt(playerid,"Workshop")][wProds]-=GetPVarInt(GetPVarInt(playerid,"installation_"),"prods");
		WorkshopInfo[GetPVarInt(playerid,"Workshop")][wBank]+=(GetPVarInt(GetPVarInt(playerid,"installation_"),"cost")/80);
		PTEMP[GetPVarInt(playerid,"installation_")][pBank]-=GetPVarInt(GetPVarInt(playerid,"installation_"),"cost");
		SetPVarInt(playerid,"Workshop_",GetPVarInt(playerid,"Workshop_")+((GetPVarInt(GetPVarInt(playerid,"installation_"),"cost")/1000)*WorkshopInfo[GetPVarInt(playerid,"Workshop")][wZp]));
		DeletePVar(GetPVarInt(playerid,"installation_"),"cost");
		DeletePVar(GetPVarInt(playerid,"installation_"),"prods");
		DeletePVar(GetPVarInt(playerid,"installation_"),"detals");
		DeletePVar(GetPVarInt(playerid,"installation_"),"number");
		DeletePVar(GetPVarInt(playerid,"installation_"),"color0");
		DeletePVar(GetPVarInt(playerid,"installation_"),"color1");
		DeletePVar(playerid,"installation");
		SaveTuning(GetPVarInt(playerid,"installation_"),CarInfo[GetPVarInt(playerid,"installation_")][carColor_two][GetPVarInt(GetPVarInt(playerid,"installation_"), "chosencar")]);
		return DisablePlayerCheckpoint(playerid);
	}
	if(GetPVarInt(playerid,"w_time") > gettime() && GetPVarInt(playerid,"w_id"))
	{
		if(GetVehicleModel(house_car[playerid]) == 0) return SCM(playerid,COLOR_GREY," У вас нет автомобиля!");
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || GetPlayerVehicleID(playerid) != house_car[playerid]) return SCM(playerid,COLOR_GREY," Вы должны находиться за рулем автомобиля!");
		new null = -1;
		foreach(i)
		{
			if(!IsPlayerInAnyVehicle(i) || GetPlayerVehicleID(i) != GetPlayerVehicleID(playerid) || GetPVarInt(i,"Workshop") != GetPVarInt(playerid,"w_id") || i == playerid) continue;
			null = i;
		}
		if(null == -1) return SCM(playerid,COLOR_GREY," Механик должен находиться с вами в авто!");
		SetPVarInt(playerid,"InWorkshop",GetPVarInt(playerid,"w_id"));
		DeletePVar(playerid,"w_time");
		SetPVarInt(null,"installation_",playerid);
		SetPVarInt(playerid,"mechanic",null);
		SetPlayerVirtualWorld(playerid,GetPVarInt(playerid,"w_id"));
		SetPlayerVirtualWorld(null,GetPVarInt(playerid,"w_id"));
		SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPVarInt(playerid,"w_id"));
		SetVehiclePos(GetPlayerVehicleID(playerid),1067.3966,2128.3901,10.5110);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),271.2212);
		SCM(null,COLOR_YELLOW," Используйте /tupdate");
		return DisablePlayerCheckpoint(playerid);
	}
	if(PicCP[playerid]==3)
	{
		ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Закрыть");
		return 1;
	}
	if(rabotaon[playerid] == 1)
	{
		if(avtocar[playerid] != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_BLUE,"Это не та машина, которую мы заказывали!");
		new Float:hp;
		GetVehicleHealth(tmpcar,hp);
		if(hp < 700) return SCM(playerid,COLOR_BLUE," Нам не нужен металлолом!");
		if(IsANope(tmpcar))
		{
			SCM(playerid,COLOR_BLUE,"[SMS]: Отличная работа. Приходи ещё.");
			PTEMP[playerid][pCash] +=500;
			GameTextForPlayer(playerid,"~b~+$500", 3000, 1);
			timecar[playerid] = 0;
			if(PTEMP[playerid][pSkilla] < 1000 && booston == 0) PTEMP[playerid][pSkilla]++;
			else if(PTEMP[playerid][pSkilla] < 1000 && booston == 1) PTEMP[playerid][pSkilla]+=3;
		}
		else if(IsAB(tmpcar))
		{
			SCM(playerid,COLOR_BLUE,"[SMS]: Отличная работа. Приходи ещё.");
			PTEMP[playerid][pCash] +=3000;
			GameTextForPlayer(playerid,"~b~+$3000", 3000, 1);
			timecar[playerid] = 0;
			if(PTEMP[playerid][pSkilla] < 1000 && booston == 0) PTEMP[playerid][pSkilla]+=2;
			else if(PTEMP[playerid][pSkilla] < 1000 && booston == 1) PTEMP[playerid][pSkilla]+=6;
		}
		else if(IsAA(tmpcar))
		{
			SCM(playerid,COLOR_BLUE,"[SMS]: Отличная работа. Приходи ещё.");
			PTEMP[playerid][pCash] +=7000;
			GameTextForPlayer(playerid,"~b~+$7000", 3000, 1);
			timecar[playerid] = 0;
			if(PTEMP[playerid][pSkilla] < 1000 && booston == 0) PTEMP[playerid][pSkilla]+=3;
			else if(PTEMP[playerid][pSkilla] < 1000 && booston == 1) PTEMP[playerid][pSkilla]+=9;
		}
		else if(caroff[tmpcar] == 1) caroff[tmpcar] = 0, DestroyVehicle(tmpcar);
		rabotaon[playerid] = 0;
		avtocar[playerid] = 0;
		return DisablePlayerCheckpoint(playerid);
	}
	if(VertMats[playerid]==1)
	{
		if(vertmatbi[GetPlayerVehicleID(playerid)][0] >= 30000)
		{
			SendMes(playerid,TEAM_GROVE_COLOR," Материалов: %i / 30000",vertmatbi[GetPlayerVehicleID(playerid)][0]);
			VertMats[playerid]=2;
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid,334.5107,1994.6956,17.6406,10);
			return true;
		}
		vertmatbi[GetPlayerVehicleID(playerid)][0] += 30000;
		SendMes(playerid,TEAM_GROVE_COLOR," Материалов: %i / 30000",vertmatbi[GetPlayerVehicleID(playerid)][0]);
		VertMats[playerid]=2;
		DisablePlayerCheckpoint(playerid);
		return SetPlayerCheckpoint(playerid,334.5107,1994.6956,17.6406,10);
	}
	else if(VertMats[playerid]==2)
	{
		if(armmatbi >= 299999)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid,-1468.2487,1488.6337,9.8943,14.0);
			VertMats[playerid] = 1;
			format(string, 100, " На главном складе LVa: %i/300000", armmatbi);
			SCM(playerid, COLOR_YELLOW, string);
			SCM(playerid, COLOR_GREY, " Склад заполнен");
			return true;
		}
		vertmatbi[GetPlayerVehicleID(playerid)][0] -= 30000;
		armmatbi += 30000;
		new strings1[50];
		format(strings1,sizeof(strings1), "{33AA33}Склад армии ЛВ: {FFFFFF}%i", armmatbi);
		UpdateDynamic3DTextLabelText(LvaLable, 0xFFFF00FF, strings1);
		if(armmatbi > 300000) armmatbi = 300000;
		SendMes(playerid,TEAM_GROVE_COLOR," Материалов: %i / 30000",vertmatbi[GetPlayerVehicleID(playerid)][0]);
		format(string, 100, " На главном складе LVa: %i/300000", armmatbi);
		SCM(playerid, COLOR_YELLOW, string);
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid,-1468.2487,1488.6337,9.8943,14.0);
		return VertMats[playerid] = 1;
	}
	if(VertMatslsa[playerid]==1)
	{
		if(vertmatbilsa[GetPlayerVehicleID(playerid)][0] >= 30000)
		{
			SendMes(playerid,TEAM_GROVE_COLOR," Материалов: %i / 30000",vertmatbilsa[GetPlayerVehicleID(playerid)][0]);
			VertMatslsa[playerid]=2;
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid,2773.1833,-2354.5332,15.3227,10);
			return true;
		}
		vertmatbilsa[GetPlayerVehicleID(playerid)][0] += 30000;
		SendMes(playerid,TEAM_GROVE_COLOR," Материалов: %i / 30000",vertmatbilsa[GetPlayerVehicleID(playerid)][0]);
		VertMatslsa[playerid]=2;
		DisablePlayerCheckpoint(playerid);
		return SetPlayerCheckpoint(playerid,2773.1833,-2354.5332,15.3227,10);
	}
	else if(VertMatslsa[playerid]==2)
	{
		if(lsamatbi >= 100000)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid,-1468.2487,1488.6337,9.8943,14.0);
			VertMatslsa[playerid] = 1;
			format(string, 100, " На главном складе LSa: %i/100000", lsamatbi);
			SCM(playerid, COLOR_YELLOW, string);
			SCM(playerid, COLOR_GREY, " Склад заполнен");
			return true;
		}
		vertmatbilsa[GetPlayerVehicleID(playerid)][0] -= 30000;
		lsamatbi += 30000;
		if(lsamatbi > 100000) lsamatbi = 100000;
		SendMes(playerid,TEAM_GROVE_COLOR," Материалов: %i / 30000",vertmatbilsa[GetPlayerVehicleID(playerid)][0]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " На главном складе LSa: %i/100000", lsamatbi);
		SCM(playerid, COLOR_YELLOW, string);
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid]=0;
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid,-1468.2487,1488.6337,9.8943,14.0);
		return VertMatslsa[playerid] = 1;
	}
	if(CP[playerid] == 500)
	{
		SCM(playerid, COLOR_GREEN, " Вы получили премию, в размере: 600 вирт");
		PTEMP[playerid][pCash] += 600;
		DisablePlayerCheckpoint(playerid);
		CP[playerid] = 0;
	}
	else if(MatsArmyCar[playerid] == 20)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] >= 5000 || armmatbi <= 10000)
		{
			format(string, 64, " Склад пуст или грузовик полон!");
			SCM(playerid, COLOR_GREY, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] += 10000;
		format(string, 100, " Материалы успешно загружены! Компоненты материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		armmatbi -= 10000;
		new strings1[50];
		format(strings1,sizeof(strings1), "{33AA33}Склад армии ЛВ: {FFFFFF}%i", armmatbi);
		UpdateDynamic3DTextLabelText(LvaLable, 0xFFFF00FF, strings1);
		DisablePlayerCheckpoint(playerid);
		format(string, 100, " На складе Зоны 51: %i/300000", armmatbi);
		format(string, 100, " Введите: /carm, чтобы начать развозку материалов");
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 35)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || sfpdmats >= 99999)
		{
			format(string, 144, " Склад SFPD заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		sfpdmats += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/100000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад SFPD: %i/100000", sfpdmats);
		SCM(playerid, -1, string);
		return CP[playerid] = 0;
	}
	else if(MatsArmyCar[playerid] == 150)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || lvpdmats >= 99999)
		{
			format(string, 100, " Склад LVPD заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		lvpdmats += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/100000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад LVPD: %i/100000", lvpdmats);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 151)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || lsamatbi >= 99999)
		{
			format(string, 100, " Склад LSA заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		lsamatbi += 10000;
		if(lsamatbi > 99999) lsamatbi = 99999;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад LSA: %i/100000", lsamatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 61)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || hamcmatbi >= 99999)
		{
			format(string, 100, " Склад Hell's Angels MC заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		hamcmatbi += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад Hell's Angels MC: %i/100000", hamcmatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 63)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || wmcmatbi >= 99999)
		{
			format(string, 100, " Склад Warlocks MC заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		wmcmatbi += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад Warlocks MC: %i/50000", wmcmatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 66)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || pmcmatbi >= 99999)
		{
			format(string, 100, " Склад Pagans MC заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		pmcmatbi += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад Pagans MC: %i/50000", pmcmatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 100)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || ballasmatbi >= 99999)
		{
			format(string, 100, " Склад The Ballas заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		ballasmatbi += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад The Ballas: %i/100000", ballasmatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 101)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || vagosmatbi >= 99999)
		{
			format(string, 100, " Склад The Vagos заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		vagosmatbi += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад The Vagos: %i/100000", vagosmatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 102)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || groovmatbi >= 99999)
		{
			format(string, 100, "Склад The Grove заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		groovmatbi += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад The Grove: %i/100000", groovmatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 103)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || aztekmatbi >= 99999)
		{
			format(string, 100, "Склад The Aztec заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		aztekmatbi += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад The Aztec: %i/100000", aztekmatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 104)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || rifamatbi >= 99999)
		{
			format(string, 100, " Склад The Rifa заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		rifamatbi += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад The Rifa: %i/100000", rifamatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 31)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || lspdmatbi >= 99999)
		{
			format(string, 100, " Склад LSPD заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		lspdmatbi += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid]=0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/100000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад LSPD: %i/100000", lspdmatbi);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 24)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || fbimats >= 99999)
		{
			format(string, 100, "Склад FBI заполнен либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		fbimats += 10000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Материалы успешно доставлены! Материалов: %i/100000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад FBI: %i/100000", fbimats);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 21)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || armmatsf >= 300000)
		{
			format(string, 100, "Cклад Армии SF заполнен, или грузовик пуст!");
			SCM(playerid, COLOR_GRAD1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		armmatsf += 10000;
		if(armmatsf > 300000) armmatsf = 300000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Оружие успешно доставлено! Оружие: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад Армии SF: %i/300000", armmatsf);
		return SCM(playerid, -1, string);
	}
	else if(MatsArmyCar[playerid] == 25)
	{
		if(MatHaul[tmpcar-gunscar[0]][mLoad] == 0 || armmatsf >= 300000)
		{
			format(string, 100, " Склад армии SF заполнен, либо грузовик пуст!");
			SCM(playerid, -1, string);
			DisablePlayerCheckpoint(playerid);
			return true;
		}
		MatHaul[tmpcar-gunscar[0]][mLoad] -= 10000;
		armmatsf += 10000;
		if(armmatsf > 300000) armmatsf = 300000;
		DisablePlayerCheckpoint(playerid);
		MatsArmyCar[playerid] = 0;
		format(string, 100, " Оружие успешно доставлено! Оружие: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
		format(string, 100, " Склад Армии SF: %i/300000", armmatsf);
		return SCM(playerid, -1, string);
	}
	if(CP[playerid] == 123)
	{
		DisablePlayerCheckpoint(playerid);
		SCM(playerid, -1, " Введите /sloading для загрузки");
		return CP[playerid] = 0;
	}
	if(GruzCP[playerid] == 1 && PlayerToPoint(2.0,playerid,600.4599,868.0458,-42.9609))
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerSpecialAction (playerid, SPECIAL_ACTION_CARRY);
		SetPlayerAttachedObject(playerid, 1 , 2358, 1,0.11,0.36,0.0,0.0,90.0);
	}
	if(Works[playerid])
	{
		if(JobCP[playerid] == 1 && IsPlayerInRangeOfPoint(playerid,2.0,2230.3528,-2286.1353,14.3751))
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid,2172.4146,-2255.5405,13.3041,1.5);
				ClearAnimations(playerid);
				ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,1,0,0,1,1,1);
				SetPlayerAttachedObject(playerid, 1 , 2060, 1,0.11,0.36,0.0,0.0,90.0);
				JobCP[playerid] = 2;
				mesh[playerid] = 1;
				usemesh[playerid] = 1;
				SetPVarInt(playerid, "Time_Carry", gettime());
			}
		}
		if(JobCP[playerid] == 2  && IsPlayerInRangeOfPoint(playerid,2.0,2172.4146,-2255.5405,13.3041))
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(mesh[playerid] < 8) return true;
				JobAmmount[playerid] ++;
				format(string,100, "Мешков перетащено: %i",JobAmmount[playerid]);
				SCM(playerid,COLOR_GREEN,string);
				DisablePlayerCheckpoint(playerid);
				mesh[playerid] = 0;
				usemesh[playerid] = 0;
				if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
				SetPlayerCheckpoint(playerid,2230.3528,-2286.1353,14.3751,1.5);
				JobCP[playerid] = 1;
				ClearAnimations(playerid);
				ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,1,0);
				if(PTEMP[playerid][pQuestL] == 1 && PTEMP[playerid][pQuest] == 1) PTEMP[playerid][pQuestP] ++;
				if(PTEMP[playerid][pQuestL] == 1 && PTEMP[playerid][pQuest] == 1 && PTEMP[playerid][pQuestP] == 15)
				{
					PlayerPlaySound(playerid, 4201, 0.0, 0.0, 0);
					ShowPlayerDialogEx(playerid,11230,DIALOG_STYLE_MSGBOX,"Задание","Это снова Джанк,вижу тебе нужны права.\nУ меня есть знакомые в Автошколе,они помогут тебе сдать совершенно бесплатно.\nЧтобы добраться до Автошколы,воспользуйся Автобусом или Такси.\n{DDCD70}Задача: Пройдите автосдачу на права(Не покупкая права у инструктора!)\n{17B757}Награда: Бесплатная сдача на права"
					,"Готово","");
					GameTextForPlayer(playerid, "~g~+1000$", 2000, 1);
					PTEMP[playerid][pCash] += 1000;
					PTEMP[playerid][pQuest] = 2;
					PTEMP[playerid][pQuestP] = 0;
					PTEMP[playerid][pQuestPF] = 0;
					SCM(playerid,0x30a0a7aa," Задание выполнено");
				}
				new null = GetPVarInt(playerid, "Time_Carry");
				if((gettime() - null) < 10)
				{
				    format(string, 90, " <Warning> %s[%i]: Возможно Бот-Грузчик", PTEMP[playerid][pName], playerid);
					ABroadCast(COLOR_REDD,string,2);
				}
			}
		}
	}
	else if(CP[playerid] == 500)
	{
		PTEMP[playerid][pCash] += 600;
		CP[playerid] = 0;
		format(string, 32, "~g~+600");
		GameTextForPlayer(playerid, string, 5000, 1);
		DisablePlayerCheckpoint(playerid);
	}
	else
	{
		switch (gPlayerCheckpointStatus[playerid])
		{
		case 12:
			{
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				DisablePlayerCheckpoint(playerid);
				gPlayerCheckpointStatus[playerid] = 0;
				GameTextForPlayer(playerid, "~w~Is in~n~~y~House", 5000, 1);
			}
		}
	}
	return true;
}