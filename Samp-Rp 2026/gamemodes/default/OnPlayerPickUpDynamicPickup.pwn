public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(SERVERTEST) SendMes(playerid,COLOR_BLUE,"PICKUP: PLAYERID - %i, PICKUPID",playerid,pickupid);
	if(pickupid == oldpickup[playerid]) return true;
	oldpickup[playerid] = pickupid;
	timepickup[playerid] = 3;
	for(new i; i < 20; i++)
	{
		if(pickupid == LPick[i])
 		{
   			if(PTEMP[playerid][progolos] == true) return SendClientMessage(playerid,COLOR_GREY," Вы уже голосовали!");
			new str[512];
	     	for(new h = 0; h < idgols; h++)
	 		{
	 			new strz[64];
	 			format(strz,sizeof(str2),"%s\n",Golosovan[h][Variant]);
	 			strcat(str,strz,sizeof(str));
	 		}
	 		ShowPlayerDialogEx(playerid,1134,DIALOG_STYLE_LIST,GL2[NameGolos],str,"Выбор","Отмена");
 		}
 	}
	
	new Float:zx;
	GetPlayerPos(playerid, PickupX[playerid], PickupY[playerid], zx);
	if(pickupid == RobbingBiker[pickup])
	{
	    if(!IsABiker(playerid)) return true;
	    if(RobbingBiker[robType] == 1)
	 	{
	 	    ClearAnimations(playerid);
		    ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,1,0,0,1,1,1);
			SetPlayerAttachedObject(playerid, 1 , 2969, 1,0.11,0.36,0.0,0.0,90.0);
			MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad] -= 250;
	        format(string, sizeof(string), "Кол-во груза\n%i", MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad]);
	        UpdateDynamic3DTextLabelText(Rob3DText, 0xEDEA9FAA, string);
	        if(MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad] <= 0)
	        {
				DestroyDynamicPickup(RobbingBiker[pickup]);
				RobbingBiker[pickup] = -1;
				DestroyDynamic3DTextLabel(Rob3DText);
				RobbingBiker[robCar] = -1;
				foreach(i)
				{
					DeletePVar(i, "matovoz_rob");
					DeletePVar(i, "zapravka_rob");
				}
				RobbingBiker[robType] = -1;
	        }
	        new Float:x1, Float:y1, Float:z1;
	        GetCoordBootVehicle(RobbingBiker[bikerCar], x1, y1, z1);
	        SetPlayerCheckpointEx(playerid, x1, y1, z1, 1.5);
	        SetPVarInt(playerid, "matovoz_rob", 1);
        }
        else if(RobbingBiker[robType] == 2)
        {
            ClearAnimations(playerid);
        	ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,1,0,0,1,1,1);
			SetPlayerAttachedObject(playerid, 1 , 1650, 1,0.45,0.36,0.0,0.0,90.0, 0.0, 1.5, 1.5, 1.5);
			RobbingBiker[bresult] -= 100;
	        format(string, sizeof(string), "Кол-во груза\n%i", RobbingBiker[bresult]);
	        UpdateDynamic3DTextLabelText(Rob3DText, 0xEDEA9FAA, string);
	        if(RobbingBiker[bresult] <= 0)
	        {
				DestroyDynamicPickup(RobbingBiker[pickup]);
				RobbingBiker[pickup] = -1;
				DestroyDynamic3DTextLabel(Rob3DText);
				RobbingBiker[robCar] = -1;
	        }
	        new Float:x1, Float:y1, Float:z1;
	        GetCoordBootVehicle(RobbingBiker[bikerCar], x1, y1, z1);
	        SetPlayerCheckpointEx(playerid, x1, y1, z1, 1.5);
	        SetPVarInt(playerid, "zapravka_rob", 1);
        }
	}
	if(pickupid == exitpodeezd)
	{
		new i = GetPVarInt(playerid, "podeezd");
		new str[8], varv[100];
		strcat(varv,"Улица\n");
		for(new f = 0; f < PodeezdInfo[i][podEtazi]; f++)
		{
			format(str, 10, "%d Этаж\n", f+1);
			strcat(varv,str);
		}
		return ShowPlayerDialogEx(playerid, 6485, 2, "Лифт", varv, "Перейти", "Отмена");
	}
	if(pickupid == podeezdils)
	{
		new i = GetPVarInt(playerid, "podeezd");
		new str[8], varv[100];
		strcat(varv,"Улица\n");
		for(new f = 0; f < PodeezdInfo[i][podEtazi]; f++)
		{
			format(str, 10, "%d Этаж\n", f+1);
			strcat(varv,str);
		}
		return ShowPlayerDialogEx(playerid, 6485, 2, "Лифт", varv, "Перейти", "Отмена");
	}
	if(pickupid >= garagexit[0] && pickupid <= garagexit[3])
	{
		ShowPlayerDialogEx(playerid, 1007, 2, "Выход","Выйти на улицу\nВойти в дом", "Готово", "Отмена");
	}
	for(new i = GetVehiclePoolSize(); i >= 0; i--)
	{
		new null;
		for(new idx = 0; idx <= TOTALFARM; idx++) if(i >= FarmInfo[idx][fSeed_Car][0] && i <= FarmInfo[idx][fSeed_Car][1]) null = idx;
		if(pickupid == Farmcar_pickup[i] && null)
		{
			new Float:x, Float:y, Float:z;
			if(GetPVarInt(playerid,"farm_id") != null) return true;
			if(GetPVarInt(playerid,"farm_status") == 0)
			{
				DisablePlayerCheckpoint(playerid);
				RemovePlayerAttachedObject(playerid,3);
				GetVehiclePos(i, x, y, z);
				new Float:X12, Float:Y12, Float:Z12;
				GetXYInBackOfPlayer(playerid, X12, Y12, Z12);
				SetPlayerCheckpoint(playerid,X12+random(5),Y12+random(5),z, 1.3);
				SetPVarInt(playerid,"farm_status", 1);
				SCM(playerid,COLOR_GREEN," Для начала соберите урожай{ffffff} (( Встаньте на красный чекпоинт, и ждите 15 секунд ))");
				SCM(playerid,COLOR_GREEN," Когда соберете положите в кузов автомобиля{ffffff} (( Встаньте на желтую стрелку ))");
				SCM(playerid,COLOR_GREEN," Если захотите завершить работу, пройдите к раздевалке{ffffff} (( Встаньте на синий пикап у фермы ))");
				SCM(playerid,COLOR_GREEN," Если вы фермер, то просто сядьте в машину для завершения сбора урожая");
			}
			else if(GetPVarInt(playerid,"farm_status") == 1) return SCM(playerid, COLOR_GREY," Вы ещё не собрали урожай");
			else if(GetPVarInt(playerid,"farm_status") == 2)
			{
				if(Farmcar_prods[i] >= 1000)
				{
					SCM(playerid, COLOR_GREY," В грузовике нет места");
					Farmcar_prods[i] = 1000;
					UpdateDynamic3DTextLabelText(Farmcar_text[i], 0x5CABBDFF, "Загружено\n{ffffff}1000 / 1000");
					return true;
				}
				Farmcar_prods[i] += 5;
				SetPVarInt(playerid,"farm_zp", GetPVarInt(playerid,"farm_zp") + FarmInfo[GetPVarInt(playerid,"farm_id")][fZp]);
				format(string, 32, "~b~count:~w~%i$",GetPVarInt(playerid,"farm_zp"));
				FarmStatPay[null][2] += 5;
				FarmStatDay[null][2] += 5;
				FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] -= 5;
				GameTextForPlayer(playerid, string, 3000, 1);
				DisablePlayerCheckpoint(playerid);
				SetPVarInt(playerid,"farm_status",1);
				RemovePlayerAttachedObject(playerid,3);
				GetVehiclePos(i, x, y, z);
				new Float:X12, Float:Y12, Float:Z12;
				GetXYInBackOfPlayer(playerid, X12, Y12, Z12);
				SetPlayerCheckpoint(playerid,X12+random(5),Y12+random(5),z, 1.3);
				format(string, 64, "Загружено\n{ffffff}%i / 1000",Farmcar_prods[i]);
				Update3DTextLabelText(Farmcar_text[i], 0x5CABBDAA, string);
				if(PTEMP[playerid][pQuestL] == 1 && PTEMP[playerid][pQuest] == 3) PTEMP[playerid][pQuestP] ++;
				if(PTEMP[playerid][pQuestL] == 1 && PTEMP[playerid][pQuest] == 3 && PTEMP[playerid][pQuestP] == 30)
				{
					PlayerPlaySound(playerid, 4201, 0.0, 0.0, 0);
					ShowPlayerDialogEx(playerid,13374,DIALOG_STYLE_MSGBOX,"Задание","Теперь у тебя есть права и деньги.Пора бы приодеться\nВ каждом городе есть магазин одежды.Доедь до него,и купи что-нибудь приличное.\nИ не забывай использовать gps\n{DDCD70}Задача: Купить любой скин\n{17B757}Награда: 1000 вирт"
					,"Готово","");
					GameTextForPlayer(playerid, "~g~+2000$", 2000, 1);
					PTEMP[playerid][pCash] += 2000;
					PTEMP[playerid][pQuest] = 4;
					PTEMP[playerid][pQuestP] = 0;
					PTEMP[playerid][pQuestPF] = 0;
					SCM(playerid,0x30a0a7aa," Задание выполнено");
				}
			}
		}
		if((i >= comptruck[0] && i <= comptruck[1]) && car_pickup[i] == pickupid)
		{
			if(!IsPlayerInAnyVehicle(playerid) && Works[playerid] && JobCP[playerid] == 2)
			{
				if(car_grain[i][0] >= car_grain[i][1]) return SCM(playerid,COLOR_GREY," В машине нет места"), car_grain[i][0] = car_grain[i][1];
				car_grain[i][0] += 100;
				if(car_grain[i][0] > car_grain[i][1]) car_grain[i][0] = car_grain[i][1];
				JobAmmount[playerid] ++;
				format(string,100, "Мешков перетащено: %i",JobAmmount[playerid]);
				ClearAnimations(playerid);
				ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,1,0);
				SCM(playerid,COLOR_GREEN,string);
				DisablePlayerCheckpoint(playerid);
				SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
				mesh[playerid] = 0;
				usemesh[playerid] = 0;
				if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
				SetPlayerCheckpoint(playerid,2230.3528,-2286.1353,14.3751,1.5);
				JobCP[playerid] = 1;
				format(string, 64, "Загружено\n{ffffff}%i / %i",car_grain[i][0],car_grain[i][1]);
				UpdateDynamic3DTextLabelText(car_text[i], 0x5CABBDAA, string);
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
			}
		}
	}
	for(new idx = 0; idx <= TOTALFARM; idx++)
	{
		if(pickupid == FarmInfo[idx][fPickup][0]) return ShowPlayerDialogEx(playerid,0,DIALOG_STYLE_MSGBOX,"Информация о работе", "Здесь вы можете подработать сборщиком урожая.\n\nЧто бы начать работу найдите фермера,\nон все вам объяснит.\n\nНеподалеку находится раздевалка,\nтам же получать деньги.\n\nЧтобы начать работу необходимо переодеться в робу,\nдалее вам укажут, где брать груз.\n\nКак только вы захотите завершить рабочий день,\nподойдите к раздевалке.", "Ок", "");
		if(pickupid == FarmInfo[idx][fPickup][1]) return ShowPlayerDialogEx(playerid,150,DIALOG_STYLE_MSGBOX,"Раздевалка", "Вы хотите начать рабочий день, или завершить?", "Начать", "Завершить");
	}
	for(new idx = 1; idx <= TOTALSHOPS; idx++)
	{
		if(pickupid == WorkshopInfo[idx][wPickup][0])
		{
			oldpickup[playerid] = WorkshopInfo[idx][wPickup][1];
			timepickup[playerid] = 3;
			SetPlayerInterior(playerid,3);
			SetPlayerPos(playerid,WorkshopInfo[idx][wExit][0],WorkshopInfo[idx][wExit][1],WorkshopInfo[idx][wExit][2]);
			SetPlayerVirtualWorld(playerid,idx);
			GetPlayerPos(playerid, PickupX[playerid], PickupY[playerid], zx);
			return SetPlayerFacingAngle(playerid, 172.8032);
		}
		else if(pickupid == WorkshopInfo[idx][wPickup][1])
		{
			oldpickup[playerid] = WorkshopInfo[idx][wPickup][0];
			timepickup[playerid] = 3;
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,WorkshopInfo[idx][wEntr][0],WorkshopInfo[idx][wEntr][1],WorkshopInfo[idx][wEntr][2]);
			SetPlayerVirtualWorld(playerid,0);
			GetPlayerPos(playerid, PickupX[playerid], PickupY[playerid], zx);
			return SetPlayerFacingAngle(playerid, 0);
		}
		else if(pickupid == WorkshopInfo[idx][wPickup][2]) return ShowPlayerDialogEx(playerid,139,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день, или завершить?", "Начать", "Закончить");
		else if(pickupid == WorkshopInfo[idx][wPickup][3])
		{
			new str[390];
			for(new i = 9; i >= 0; i--)
			{
				if(!strlen(WorkshopList[i][idx][wlName])) format(string,30,"%i. Пусто\n",i+1);
				else format(string,30,"%i. %s[ID:%i]\n",i+1,WorkshopList[i][idx][wlName],WorkshopList[i][idx][wlID]);
				strcat(str, string);
			}
			return ShowPlayerDialogEx(playerid,10111,DIALOG_STYLE_MSGBOX, "Очередь",str, "Закрыть", "");
		}
	}
	if(pickupid == rabota1)
	{
		new rabotadialog[2148];
		format(rabotadialog,sizeof(rabotadialog), "%s%s%s%s%s%s%s%s%s%s%s%s",
		rabotaMSG[0],rabotaMSG[1],rabotaMSG[2],rabotaMSG[3],rabotaMSG[4],rabotaMSG[5],rabotaMSG[6],rabotaMSG[7],rabotaMSG[8],rabotaMSG[9],rabotaMSG[10],rabotaMSG[11]);
		ShowPlayerDialogEx(playerid,133,DIALOG_STYLE_MSGBOX, "Информация о работе", rabotadialog, "Готово", "");
	}
	else if(pickupid == ammonac[0])
	{
		if(PTEMP[playerid][pGunLic] == 0) return SCM(playerid, 0x9f0000aa, " У вас нет лицензии на оружие!");
		SetPlayerInterior(playerid,7);
		SetPlayerPos(playerid,314.4596,-141.2016,999.6016);
		SetPlayerFacingAngle(playerid, 16.0505);
		SetPlayerVirtualWorld(playerid, 0);
		if(!GetPVarInt(playerid,"checkpoint")) SetPlayerCheckpoint(playerid,313.7471,-133.8828,999.6016,1.5);
		PicCP[playerid] = 3;
		RobInts[playerid] = 0;
	}
	else if(pickupid == nikname)
	{
		ShowPlayerDialogEx(playerid,10352,DIALOG_STYLE_MSGBOX, "Смена имени","Вы желаете добавить заявку на смену имени?", "Добавить", "Отмена");
		return true;
	}
	else if(pickupid == nikname2)
	{
		ShowPlayerDialogEx(playerid,10352,DIALOG_STYLE_MSGBOX, "Смена имени","Вы желаете добавить заявку на смену имени?", "Добавить", "Отмена");
		return true;
	}
	else if(pickupid == ammonac[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,-2625.8115,211.2747,4.6192);
		SetPlayerFacingAngle(playerid, 171.4908);
		SetPlayerVirtualWorld(playerid,0);
		DisablePlayerCheckpoint(playerid);
		PicCP[playerid] = 0;
		RobInts[playerid] = -1;
	}
	else if(pickupid == ammonac[2])
	{
		if(PTEMP[playerid][pGunLic] == 0) return SCM(playerid, 0x9f0000aa, " У вас нет лицензии на оружие!");
		SetPlayerInterior(playerid,1);
		SetPlayerPos(playerid,286.4246,-39.4431,1001.5156);
		SetPlayerFacingAngle(playerid, 180.1923);
		SetPlayerVirtualWorld(playerid, 0);
		if(!GetPVarInt(playerid,"checkpoint")) SetPlayerCheckpoint(playerid,295.4419,-37.9094,1001.5156,1.5);
		PicCP[playerid] = 3;
		RobInts[playerid] = 1;
	}
	else if(pickupid == tpadminhome[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,47.7949,1001.1465,179.9551);
		SetPlayerFacingAngle(playerid, 171.4908);
	}
	else if(pickupid == tpadminhome[1])
	{
		SetPlayerInterior(playerid,1);
		SetPlayerPos(playerid,286.4246,-39.4431,1001.5156);
		SetPlayerFacingAngle(playerid, 180.1923);
	}
	else if(pickupid == ammonac[3])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,2157.0044,943.3574,10.8203);
		SetPlayerFacingAngle(playerid, 87.4521);
		SetPlayerVirtualWorld(playerid,0);
		DisablePlayerCheckpoint(playerid);
		PicCP[playerid] = 0;
		RobInts[playerid] = -1;
	}
	else if(pickupid == ammonac[4])
	{
		if(PTEMP[playerid][pGunLic] == 0) return SCM(playerid, 0x9f0000aa, " У вас нет лицензии на оружие!");
		SetPlayerInterior(playerid,4);
		SetPlayerPos(playerid,285.7668,-85.0216,1001.5156);
		SetPlayerFacingAngle(playerid, 357.9616);
		SetPlayerVirtualWorld(playerid, 0);
		if(!GetPVarInt(playerid,"checkpoint")) SetPlayerCheckpoint(playerid,296.9124,-80.0943,1001.5156,1.5);
		PicCP[playerid] = 3;
		RobInts[playerid] = 2;
	}
	else if(pickupid == ammonac[5])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1366.3022,-1279.4131,13.5469);
		SetPlayerFacingAngle(playerid, 87.0350);
		SetPlayerVirtualWorld(playerid,0);
		DisablePlayerCheckpoint(playerid);
		PicCP[playerid] = 0;
		RobInts[playerid] = -1;
	}
	else if(pickupid == skills[0])
	{
		SetPlayerPos(playerid,303.6031,-159.3046,999.5938);
		SetPlayerFacingAngle(playerid, 93.0350);
	}
	else if(pickupid == skills[1])
	{
		SetPlayerPos(playerid,308.4442,-160.3095,999.5938);
		SetPlayerFacingAngle(playerid, 269.0350);
	}
	else if(pickupid == caligula[0])
	{
		if(GetPVarInt(playerid,"CasinoRank")) DeletePVar(playerid,"CasinoRank"), SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
		SetPlayerPos(playerid,2192.89,1677.09,12.3672);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
	}
	else if(pickupid == RouletCloakroom[0])
	{
		if(GetPVarInt(playerid,"Fraction_Duty")) return true;
		switch(GetPVarInt(playerid,"CasinoRank"))
		{
		case 0:
			{
				if(!GetCasino(playerid,1)) return true;
				switch(PTEMP[playerid][pSex])
				{
				case 1:
					{
						if(GetCasino(playerid,1) == 1) SetPlayerSkin(playerid,171);
						else SetPlayerSkin(playerid,189);
					}
				case 2:
					{
						if(GetCasino(playerid,1) == 1) SetPlayerSkin(playerid,172);
						else SetPlayerSkin(playerid,194);
					}
				}
				SetPVarInt(playerid,"CasinoRank",GetCasino(playerid,1));
			}
		default:
			{
				DeletePVar(playerid,"CasinoRank");
				SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
			}
		}
		return SCM(playerid, COLOR_GREY," Вы тут не работаете");
	}
	else if(pickupid == RouletCloakroom[1])
	{
		if(GetPVarInt(playerid,"Fraction_Duty")) return true;
		switch(GetPVarInt(playerid,"CasinoRank"))
		{
		case 0:
			{
				if(!GetCasino(playerid,2)) return true;
				switch(PTEMP[playerid][pSex])
				{
				case 1:
					{
						if(GetCasino(playerid,2) == 1) SetPlayerSkin(playerid,171);
						else SetPlayerSkin(playerid,189);
					}
				case 2:
					{
						if(GetCasino(playerid,2) == 1) SetPlayerSkin(playerid,172);
						else SetPlayerSkin(playerid,194);
					}
				}
				SetPVarInt(playerid,"CasinoRank",GetCasino(playerid,2));
			}
		default:
			{
				DeletePVar(playerid,"CasinoRank");
				SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
			}
		}
		return SCM(playerid, COLOR_GREY," Вы тут не работаете");
	}
	else if(pickupid == caligula[2])
	{
		SetPlayerPos(playerid,2233.79,1711.64,1011.58);
		SetPlayerInterior(playerid,1);
		SetPlayerVirtualWorld(playerid,999);
	}
	else if(pickupid == monitoring) return ShowPlayerDialogEx(playerid,1755,DIALOG_STYLE_LIST,"Мониторинг бизнесов","Бары и клубы\nЗакусочные\nМагазины 24/7\nЗаправки", "Далее", "Отмена");
	else if(pickupid == auctionpic[0])
	{
		new test = 0, sctring[856],str[64],id = 0;
		for(new i = 1; i <= TotalBizz; i++) if(strcmp(BizzInfo[i][bOwner],"None",true) == 0) test++;
		if(test == 0) return SCM(playerid,COLOR_GREY," В данный момент на аукционе нет бизнесов");
		if(test > 0)
		{
			for(new i = 1; i <= TotalBizz; i++)
			{
				if(strcmp(BizzInfo[i][bOwner],"None",true) == 0)
				{
					id++;
					bizname[playerid][id] = i;
					format(str,sizeof(str), "%s\n",BizzInfo[i][bMessage]);
					strcat(sctring,str);
				}
			}
			ShowPlayerDialogEx(playerid,1667,DIALOG_STYLE_LIST,"Аукцион бизнесов",sctring, "Далее", "Отмена");
			return true;
		}
	}
	else if(pickupid == auctionpic[1])
	{
		new null = 0, str[556],idx = 0;
		for(new i = 1; i <= TOTALSHOPS; i++) if(strcmp(WorkshopInfo[i][wOwner],"None",true) == 0) null++;
		for(new i = 0; i <= TOTALFARM; i++) if(strcmp(FarmInfo[i][fOwner],"None",true) == 0) null++;
		if(null == 0) return SCM(playerid,COLOR_GREY," В данный момент на аукционе нет бизнесов");
		for(new i = 1; i <= TOTALFARM; i++)
		{
			if(strcmp(FarmInfo[i][fOwner],"None",true) != 0) continue;
			bizname[playerid][idx] = i;
			format(YCMDstr,64, "Ферма[%i]\n",FarmInfo[i][fID]-1);
			strcat(str,YCMDstr);
			auction_info[idx] = 2;
			idx++;
		}
		for(new i = 1; i <= TOTALSHOPS; i++)
		{
			if(strcmp(WorkshopInfo[i][wOwner],"None",true) != 0) continue;
			bizname[playerid][idx] = i;
			format(YCMDstr,64, "СТО[%i]\n",WorkshopInfo[i][wID]-1);
			strcat(str,YCMDstr);
			auction_info[idx] = 1;
			idx++;
		}
		return ShowPlayerDialogEx(playerid,1690,DIALOG_STYLE_LIST,"Аукцион Ферм и СТО",str, "Далее", "Закрыть");
	}
	else if(pickupid == pickcars[4])
	{
		if(avtocar[playerid] != 0) return ShowPlayerDialogEx(playerid,1336,DIALOG_STYLE_MSGBOX,"Автоугонщик"," Вы уже взяли контракт\nВы хотите его отменить?", "Да", "Отмена");
		if(!IsAGang(playerid) && !IsABiker(playerid) && !IsAMafia(playerid) && PTEMP[playerid][pMember] != 0) return SCM(playerid,COLOR_GREY," Вы состоите во фракции!");
		if(PTEMP[playerid][pJob] != 65) return ShowPlayerDialogEx(playerid,1335,DIALOG_STYLE_MSGBOX,"Автоугонщик","Ты хочешь работать у нас?", "Устроиться", "Отмена");
		ShowPlayerDialogEx(playerid,1334,DIALOG_STYLE_LIST,"Выбор автомобиля","Nope Class\nB Class\nA Class", "Выбор", "Отмена");
	}
	else if(pickupid >= pickcars[0] && pickupid <= pickcars[3])
	{
		if(PTEMP[playerid][pJob] != 65) return SCM(playerid,COLOR_BLUE, " Уйди!!! Не дай бог стуканёш копам!");
		if(tookmoped[playerid] != 0) DestroyVehicle(tookmoped[playerid]);
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		tookmoped[playerid] = CreateVehicle(462,x,y,z,1,0,0, 300);
		PutPlayerInVehicleEx(playerid, tookmoped[playerid], 0);
		SetPlayerArmedWeapon(playerid,0);
		Fuell[tookmoped[playerid]] = 100;
		UnLockCar(playerid,tookmoped[playerid]);
		return 1;
	}
	else if(pickupid == dragons[0])
	{
		if(GetPVarInt(playerid,"CasinoRank")) DeletePVar(playerid,"CasinoRank"), SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
		SetPlayerPos(playerid,2022.8,1007.89,10.8203);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
	}
	else if(pickupid == dragons[1])
	{
		SetPlayerPos(playerid,2016.04,1017.97,996.875);
		SetPlayerInterior(playerid,10);
		SetPlayerVirtualWorld(playerid,1);
	}
	else if(pickupid == rob)
	{
		if(robh[playerid] != true)return SCM(playerid,COLOR_GREY," У вас нет с собой металла");
		robh[playerid] = false;
		PTEMP[playerid][pCash] += 500;
		PTEMP[playerid][pRobHouse] = 1;
		SCM(playerid,COLOR_GREY," Вы сдали ограбленное на 500 вирт");
		return true;
	}
	else if(pickupid == sportfrac)
	{
		if(training[playerid] != 0)
		{
			SetPlayerSkin(playerid,OldSkin[playerid]);
			SetPlayerFightingStyle (playerid, FIGHT_STYLE_GRABKICK);
			SCM(playerid,TEAM_GROVE_COLOR," Вы закончили тренировку");
			return training[playerid] = 0;
		}
		switch(PTEMP[playerid][pTraining])
		{
		case 0:
			{
				OldSkin[playerid] = GetPlayerSkin(playerid);
				SetPlayerSkin(playerid,81);
				SetPlayerFightingStyle (playerid, FIGHT_STYLE_BOXING);
				SCM(playerid,TEAM_GROVE_COLOR," Вы начали тренировку");
				SCM(playerid,TEAM_GROVE_COLOR," Для повышения навыка,наносите удары по груше. Чем разнообразнее удары,тем быстрее растет навык.");
				training[playerid] = 1;
			}
		case 1:
			{
				OldSkin[playerid] = GetPlayerSkin(playerid);
				SetPlayerSkin(playerid,81);
				SetPlayerFightingStyle (playerid, FIGHT_STYLE_BOXING);
				SCM(playerid,TEAM_GROVE_COLOR," Вы начали тренировку");
				SCM(playerid,TEAM_GROVE_COLOR," Найдите себе соперника и тренера который устроит вам поединок!");
				SCM(playerid,TEAM_GROVE_COLOR," Чтобы обладать стилем бокса,вы должны одержать победу в 2-х боях");
				training[playerid] = 2;
			}
		case 2:
			{
				OldSkin[playerid] = GetPlayerSkin(playerid);
				SetPlayerSkin(playerid,81);
				SetPlayerFightingStyle (playerid, FIGHT_STYLE_KNEEHEAD);
				SCM(playerid,TEAM_GROVE_COLOR," Вы начали тренировку");
				SCM(playerid,TEAM_GROVE_COLOR," Для повышения навыка,наносите удары по груше. Чем разнообразнее удары,тем быстрее растет навык.");
				training[playerid] = 3;
			}
		case 3:
			{
				OldSkin[playerid] = GetPlayerSkin(playerid);
				SetPlayerSkin(playerid,81);
				SetPlayerFightingStyle (playerid, FIGHT_STYLE_KNEEHEAD);
				SCM(playerid,TEAM_GROVE_COLOR," Вы начали тренировку");
				SCM(playerid,TEAM_GROVE_COLOR," Найдите себе соперника и тренера который устроит вам поединок!");
				SCM(playerid,TEAM_GROVE_COLOR," Чтобы обладать стилем кик-бокса,вы должны одержать победу в 2-х боях");
				training[playerid] = 4;
			}
		case 4:
			{
				OldSkin[playerid] = GetPlayerSkin(playerid);
				SetPlayerSkin(playerid,81);
				SetPlayerFightingStyle (playerid, FIGHT_STYLE_KUNGFU);
				SCM(playerid,TEAM_GROVE_COLOR," Вы начали тренировку");
				SCM(playerid,TEAM_GROVE_COLOR," Для повышения навыка,наносите удары по груше. Чем разнообразнее удары,тем быстрее растет навык.");
				training[playerid] = 5;
			}
		case 5:
			{
				OldSkin[playerid] = GetPlayerSkin(playerid);
				SetPlayerSkin(playerid,81);
				SetPlayerFightingStyle (playerid, FIGHT_STYLE_KUNGFU);
				SCM(playerid,TEAM_GROVE_COLOR," Вы начали тренировку");
				SCM(playerid,TEAM_GROVE_COLOR," Найдите себе соперника и тренера который устроит вам поединок!");
				SCM(playerid,TEAM_GROVE_COLOR," Чтобы обладать стилем кик-бокса,вы должны одержать победу в 2-х боях");
				training[playerid] = 6;
			}
		}
	}
	else if(pickupid == FormaFracPic[0])
	{
		if(PTEMP[playerid][pMember] == 1)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[1])
	{
		if(PTEMP[playerid][pMember] == 2)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[2])
	{
		if(PTEMP[playerid][pMember] == 3)
		{
			if(PTEMP[playerid][pRank] <= 2 && GetPVarInt(playerid,"Fraction_Duty")) return SCM(playerid,COLOR_GREY," Раздевалка доступна с 3 ранга!");
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[3] || pickupid == FormaFracPic[12] || pickupid == FormaFracPic[13] || pickupid == FormaFracPic[14] || pickupid == FormaFracPic[15])
	{
		if(PTEMP[playerid][pMember] == 4)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[4])
	{
		if(PTEMP[playerid][pMember] == 7)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[5])
	{
		if(PTEMP[playerid][pMember] == 9)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[6])
	{
		if(PTEMP[playerid][pMember] == 10)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[7])
	{
		if(PTEMP[playerid][pMember] == 11)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[8])
	{
		if(PTEMP[playerid][pMember] == 16)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[9])
	{
		if(PTEMP[playerid][pMember] == 19)
		{
			if(PTEMP[playerid][pRank] <= 2 && GetPVarInt(playerid,"Fraction_Duty")) return SCM(playerid,COLOR_GREY," Раздевалка доступна с 3 ранга!");
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[10])
	{
		if(PTEMP[playerid][pMember] == 20)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == FormaFracPic[11])
	{
		if(PTEMP[playerid][pMember] == 21)
		{
			if(!GetPVarInt(playerid,"Fraction_Duty")) ShowPlayerDialogEx(playerid,1010,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid,1011,DIALOG_STYLE_LIST, "Раздевалка", "Завершить рабочий день\nСменить одежду", "Далее", "Отмена");
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вы не работаете в данной организации");
		}
	}
	else if(pickupid == parashut)
	{
		GiveWeapon(playerid, 46, 1);
	}
	else if(pickupid == derbyrace[0])
	{
		return SCM(playerid,COLOR_GREY," Разработка");
	}
	else if(pickupid == derbyrace[1])
	{
		SetPlayerInterior(playerid,1);
		SetPlayerPos(playerid,-2170.4685,638.5978,1052.3750);
		SetPlayerFacingAngle(playerid,355.9632);
	}
	else if(pickupid == derbyrace[2])
	{
		//if(Playerderby[playerid] == 1) DerbyPlayers -= 1;
		TogglePlayerControllable(playerid, 1);
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2113.5208,-442.3560,38.2776);
		SetPlayerFacingAngle(playerid, 76.4112);
		//Playerderby[playerid] = 0;
	}
	else if(pickupid == sportzal[0])
	{
		if(PTEMP[playerid][pJob] == 6 && PTEMP[playerid][pMember] == 0)
		{
			SetPlayerSkin(playerid, 49);
		}
		SetPlayerInterior(playerid,5);
		SetPlayerPos(playerid,771.4412,-2.7885,1000.7279);
		SetPlayerFacingAngle(playerid, 21.2131);
	}
	else if(pickupid == sportzal[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,2097.5024,2489.8967,14.8390);
		SetPlayerFacingAngle(playerid, 180.8626);
		SetPlayerFightingStyle (playerid, FIGHT_STYLE_GRABKICK);
		if(PTEMP[playerid][pMember] >= 1) { SetPlayerSkin(playerid,PTEMP[playerid][pModel]);}
		if(PTEMP[playerid][pMember] == 0) { SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);}
	}
	else if(pickupid >= carpick[0] && pickupid <= carpick[3]) CallLocalFunction("OnPlayerCommandText", "is", playerid, "/buycar");
	else if(pickupid == arace)
	{
		if(race_info[1] != 1) return SCM(playerid,COLOR_GREY," Регистрация закрыта");
		//if(PTEMP[playerid][pLevel] < 3)return SCM(playerid,COLOR_GRAD1,"Участвовать можно с 3-х лет проживания в штате!");
		if(PTEMP[playerid][pWarns]) return SCM(playerid,COLOR_GREY, " Нельзя учавствовать с Варном");
		if(GetPVarInt(playerid, "gonka")) return SCM(playerid, COLOR_GREY, " Вы уже зарегистрировались на матч!");
		new null;
		foreach(i) if(GetPVarInt(i,"gonka")) null++;
		if(null > 12) return SCM(playerid,COLOR_GREY, " Слишком много участников");
		SetPVarInt(playerid, "gonka", 1);
		SCM(playerid,0x6495EDFF,"Вы успешно зарегистрированы на гонку. Не выходите из помещения!");
		format(YCMDstr, sizeof(YCMDstr), " Зарегистрирован участник под номером: %i",null+1);
		if(GetPVarInt(playerid,"gonka")) ProxDetector(30.0, playerid, YCMDstr, 0x6495EDFF,0x6495EDFF,0x6495EDFF,0x6495EDFF,0x6495EDFF);
		return true;
	}
	else if(pickupid == racee[0])
	{
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,831.7769,6.8750,1004.1797);
		SetPlayerFacingAngle(playerid,108.1610);
	}
	else if(pickupid == racee[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1958.6117,-2183.5022,13.5469);
		SetPlayerFacingAngle(playerid,271.8013);
		SetPlayerVirtualWorld(playerid,0);
		DeletePVar(playerid,"gonka");
	}
	else if(pickupid == lspic[0])
	{
		if(PTEMP[playerid][pNkeys] == 16 || PTEMP[playerid][pMember] == 16 || PTEMP[playerid][pNkeys] == 1)
		{
			SetPlayerPos(playerid,1650.9373,-1649.7738,99.5609);
			SetPlayerFacingAngle(playerid, 359.8156);
			SetPlayerVirtualWorld(playerid, 1);
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("_UnFreeze" , 400, false, "i", playerid);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lspic[1])
	{
		if(PEfir[playerid] != 255)
		{
			SCM(playerid, -1, " Вы вышли из прямого эфира");
			PEfir[playerid] = 255;
			if(PTEMP[playerid][pMember] == 9 && smssf == playerid)
			{
			    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
				format(string, 128, " [SFN] %s завершил приём звонков от слушателей", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
				smssf = -1;
			}
			else if(PTEMP[playerid][pMember] == 16 && smsls == playerid)
			{
			    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
				format(string, 128, " [LSN] %s завершил приём звонков от слушателей", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
				smsls = -1;
			}
			else if(PTEMP[playerid][pMember] == 20 && smslv == playerid)
			{
			    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
				format(string, 128, " [LVN] %s завершил приём звонков от слушателей", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
				smslv = -1;
			}
		}
		if(Pefir[playerid] == 1 || Pefir[playerid] == 2)
		{
			PEfir[playerid] = 255;
			SCM(playerid, -1, " Вы вышли из прямого эфира");
		}
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1658.3607,-1694.8757,15.6094);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == lvpic[0])
	{
		if(PTEMP[playerid][pNkeys] == 20 || PTEMP[playerid][pMember] == 20 || PTEMP[playerid][pNkeys] == 1)
		{
			SetPlayerPos(playerid,2643.4954,1198.2725,40.5609);
			SetPlayerFacingAngle(playerid, 359.8156);
			SetPlayerVirtualWorld(playerid, 3);
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("_UnFreeze" , 400, false, "i", playerid);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта!");
		}
	}
	else if(pickupid == lvpic[1])
	{
		if(PEfir[playerid] != 255)
		{
			SCM(playerid, -1, " Вы вышли из прямого эфира");
			PEfir[playerid] = 255;
			if(PTEMP[playerid][pMember] == 9 && smssf == playerid)
			{
			    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
				format(string, 128, " [SFN] %s завершил приём звонков от слушателей", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
				smssf = -1;
			}
			else if(PTEMP[playerid][pMember] == 16 && smsls == playerid)
			{
			    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
				format(string, 128, " [LSN] %s завершил приём звонков от слушателей", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
				smsls = -1;
			}
			else if(PTEMP[playerid][pMember] == 20 && smslv == playerid)
			{
			    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
				format(string, 128, " [LVN] %s завершил приём звонков от слушателей", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
				smslv = -1;
			}
		}
		if(Pefir[playerid] == 1 || Pefir[playerid] == 2)
		{
			PEfir[playerid] = 255;
			SCM(playerid, -1, " Вы вышли из прямого эфира");
		}
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,2649.1655,1183.9111,10.8203);
		SetPlayerFacingAngle(playerid, 180.0000);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == pdd)
	{
		GameTextForPlayer(playerid, "~r~/pdd", 1000, 1);
	}
	else if(pickupid == medicss[0]) // medic SF enter
	{
		SetPlayerInterior(playerid,15);
		SetPlayerPos(playerid,283.977203, 181.335388, 1214.794922);
		SetPlayerFacingAngle(playerid, 270);
		SetPlayerVirtualWorld(playerid, 3);
		TogglePlayerControllableEx(playerid, 0);
		SetTimerEx("_UnFreeze" , 1000, false, "i", playerid);
		RobInts[playerid] = 5;
	}
	else if(pickupid == medicss[1]) // medic SF exit
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2664.4895,636.7567,14.4531);
		SetPlayerFacingAngle(playerid, 180.9984);
		SetPlayerVirtualWorld(playerid, 0);
		RobInts[playerid] = -1;
	}
	else if(pickupid == medicss[2]) // medic LS enter
	{
		SetPlayerInterior(playerid,15);
		SetPlayerPos(playerid,283.977203, 181.335388, 1214.794922);
		SetPlayerFacingAngle(playerid, 270);
		SetPlayerVirtualWorld(playerid, 4);
		TogglePlayerControllableEx(playerid, 0);
		SetTimerEx("_UnFreeze" , 1000, false, "i", playerid);
		RobInts[playerid] = 6;
	}
	else if(pickupid == medicss[3]) // medic LS exit
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,1176.2983,-1323.4597,14.0144);
		SetPlayerFacingAngle(playerid, 270.0000);
		SetPlayerVirtualWorld(playerid, 0);
		RobInts[playerid] = -1;
	}
	else if(pickupid == medicss[4]) // medic LV enter
	{
		SetPlayerInterior(playerid,15);
		SetPlayerPos(playerid,283.977203, 181.335388, 1214.794922);
		SetPlayerFacingAngle(playerid, 270);
		SetPlayerVirtualWorld(playerid, 5);
		TogglePlayerControllableEx(playerid, 0);
		SetTimerEx("_UnFreeze" , 1000, false, "i", playerid);
		RobInts[playerid] = 7;
	}
	if(pickupid == medicss[5]) // medic LV exit
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,1607.5677,1818.9572,10.8203);
		SetPlayerFacingAngle(playerid, 360.0000);
		SetPlayerVirtualWorld(playerid, 0);
		RobInts[playerid] = -1;
	}
	else if(pickupid == medicss[6]) // medic FC enter
	{
		SetPlayerInterior(playerid,15);
		SetPlayerPos(playerid,283.977203, 181.335388, 1214.794922);
		SetPlayerFacingAngle(playerid, 270);
		SetPlayerVirtualWorld(playerid, 6);
		TogglePlayerControllableEx(playerid, 0);
		SetTimerEx("_UnFreeze" , 1000, false, "i", playerid);
		RobInts[playerid] = 8;
	}
	if(pickupid == medicss[7]) // medic FC exit
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-318.9004,1051.0360,20.3403);
		SetPlayerFacingAngle(playerid, 345.8104);
		SetPlayerVirtualWorld(playerid, 0);
		RobInts[playerid] = -1;
	}
	else if(pickupid == medicss[8]) // medic CGH enter
	{
		SetPlayerInterior(playerid,15);
		SetPlayerPos(playerid,283.977203, 181.335388, 1214.794922);
		SetPlayerFacingAngle(playerid, 270);
		SetPlayerVirtualWorld(playerid, 7);
		TogglePlayerControllableEx(playerid, 0);
		SetTimerEx("_UnFreeze" , 1000, false, "i", playerid);
		RobInts[playerid] = 9;
	}
	if(pickupid == medicss[9]) // medic CGH exit
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,2034.4718,-1404.8879,17.2479);
		SetPlayerFacingAngle(playerid, 180.0);
		SetPlayerVirtualWorld(playerid, 0);
		RobInts[playerid] = -1;
	}
	else if(pickupid == mast[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1657.9347,2197.8618,10.8203);
		SetPlayerFacingAngle(playerid, 183.9151);
		SetPlayerVirtualWorld(playerid, 0);
		RemovePlayerAttachedObject(playerid,0);
	}
	else if(pickupid == mast[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,-1800.4135,1197.5573,25.1194);
		SetPlayerFacingAngle(playerid, 182.3717);
		SetPlayerVirtualWorld(playerid, 0);
		RemovePlayerAttachedObject(playerid,0);
	}
	else if(pickupid == mast[2])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,854.0541,-601.7619,18.4219);
		SetPlayerFacingAngle(playerid, 0.6835);
		SetPlayerVirtualWorld(playerid, 0);
		RemovePlayerAttachedObject(playerid,0);
	}
	else if(pickupid == addictionenter)
	{
		SetPlayerInterior(playerid,5);
		SetPlayerPos(playerid,318.2598,1118.8209,1083.8828);
		SetPlayerFacingAngle(playerid, 2.7967);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == sfpdpic[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,-2052.4917,458.5779,35.1719);
		SetPlayerFacingAngle(playerid, 312.1454);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == sfpdpic[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,-2047.0208,450.5458,139.7422);
		SetPlayerFacingAngle(playerid, 153.7635);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == sfpdpic[2])
	{
		if(PEfir[playerid] != 255)
		{
			SCM(playerid, -1, " Вы вышли из прямого эфира");
			PEfir[playerid] = 255;
			if(PTEMP[playerid][pMember] == 9 && smssf == playerid)
			{
			    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
				format(string, 128, " [SFN] %s завершил приём звонков от слушателей", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
				smssf = -1;
			}
			else if(PTEMP[playerid][pMember] == 16 && smsls == playerid)
			{
			    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
				format(string, 128, " [LSN] %s завершил приём звонков от слушателей", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
				smsls = -1;
			}
			else if(PTEMP[playerid][pMember] == 20 && smslv == playerid)
			{
			    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
				format(string, 128, " [LVN] %s завершил приём звонков от слушателей", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
				smslv = -1;
			}
		}
		if(Pefir[playerid] == 1 || Pefir[playerid] == 2)
		{
			PEfir[playerid] = 255;
			SCM(playerid, -1, " Вы вышли из прямого эфира");
		}
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,-2052.4917,458.5779,35.1719);
		SetPlayerFacingAngle(playerid, 312.1454);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == sfpdpic[3])
	{
		if(PTEMP[playerid][pNkeys] == 9 || PTEMP[playerid][pMember] == 9 || PTEMP[playerid][pNkeys] == 1)
		{
			SetPlayerPos(playerid,-2057.9453,445.6013,189.7110);
			SetPlayerFacingAngle(playerid, 359.8156);
			SetPlayerVirtualWorld(playerid, 2);
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("_UnFreeze" , 400, false, "i", playerid);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lcnpic[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1451.8104,750.8665,11.0234);
		SetPlayerFacingAngle(playerid, 89.1102);
		SetPlayerVirtualWorld(playerid, 0);
	}
	if(pickupid == lcnpic[1])
	{
		SetPlayerInterior(playerid, 5);
		SetPlayerPos(playerid,1298.6915,-794.2542,1084.0078);
		SetPlayerFacingAngle(playerid, 349.0933);
		SetPlayerVirtualWorld(playerid, 2);
	}
	else if(pickupid == lcnpic[2])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1533.6487,751.3372,11.0234);
		SetPlayerFacingAngle(playerid, 89.1102);
		SetPlayerVirtualWorld(playerid, 0);
	}
	if(pickupid == lcnpic[3])
	{
		SetPlayerInterior(playerid, 5);
		SetPlayerPos(playerid,1263.3304,-785.4093,1091.9063);
		SetPlayerFacingAngle(playerid, 349.0933);
		SetPlayerVirtualWorld(playerid, 2);
	}
	else if(pickupid == zip[0])
	{
		SetPlayerInterior(playerid,5);
		SetPlayerPos(playerid,225.2378,-8.0487,1002.2109);
		SetPlayerFacingAngle(playerid, 89.5070);
		SetPlayerVirtualWorld(playerid,1);
		zips[playerid] = true;
		RobInts[playerid] = 3;
	}
	else if(pickupid == zip[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,-1696.8130,948.5907,24.8906);
		SetPlayerFacingAngle(playerid, 137.1418);
		SetPlayerVirtualWorld(playerid,0);
		zips[playerid] = false;
		RobInts[playerid] = -1;
	}
	else if(pickupid == victim2[0])
	{
		SetPlayerInterior(playerid,5);
		SetPlayerPos(playerid,225.2378,-8.0487,1002.2109);
		SetPlayerFacingAngle(playerid, 89.5070);
		SetPlayerVirtualWorld(playerid,2);
		RobInts[playerid] = 4;
	}
	else if(pickupid == victim2[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,458.0936,-1501.5496,31.0372);
		SetPlayerFacingAngle(playerid, 101.4322);
		SetPlayerVirtualWorld(playerid,0);
		RobInts[playerid] = -1;
	}
	else if(pickupid == addictionexit)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,2168.0977,-1673.5548,15.0826);
		SetPlayerFacingAngle(playerid,217.7220);
		SetPlayerVirtualWorld(playerid,0);
	}
	else if(pickupid == rmpic[1])
	{
		SetPlayerInterior(playerid, 5);
		SetPlayerPos(playerid,1286.2816,-836.2054,1085);
		SetPlayerFacingAngle(playerid, 3.7600);
		SetPlayerVirtualWorld(playerid, 1);
	}
	else if(pickupid == rmpic[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,963.4916,1684.2570,8.8516);
		SetPlayerFacingAngle(playerid, 270.5075);
		SetPlayerVirtualWorld(playerid,0);
	}
	else if(pickupid == rmpic2[1])
	{
		SetPlayerInterior(playerid, 5);
		SetPlayerPos(playerid,1263.1458,-785.5604,1091.9063);
		SetPlayerFacingAngle(playerid, 349.0933);
		SetPlayerVirtualWorld(playerid, 1);
	}
	else if(pickupid == rmpic2[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,964.5447,1782.8569,8.8581);
		SetPlayerFacingAngle(playerid, 276.0833);
		SetPlayerVirtualWorld(playerid,0);
	}
	else if(pickupid == rmpick[1])
	{
		SetPlayerInterior(playerid, 5);
		SetPlayerPos(playerid,1298.9998,-794.4816,1084.0078);
		SetPlayerFacingAngle(playerid, 346.4799);
		SetPlayerVirtualWorld(playerid, 1);
	}
	else if(pickupid == rmpick[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,940.2573,1733.2078,8.8516);
		SetPlayerFacingAngle(playerid, 268.7956);
		SetPlayerVirtualWorld(playerid,0);
	}
	else if(pickupid == yakexit[1])
	{
		SetPlayerInterior(playerid, 5);
		SetPlayerPos(playerid,1298.6915,-794.2542,1084.0078);
		SetPlayerFacingAngle(playerid, 349.0933);
	}
	else if(pickupid == yakexit[0])
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,1457.5305,2773.4219,10.8203);
		SetPlayerFacingAngle(playerid, 276.0466);
	}
	else if(pickupid == fbi[5])
	{
		SetPlayerInterior(playerid,3);
		SetPlayerVirtualWorld(playerid, 130);
		SetPlayerPos(playerid,-2477.3394,534.8168,1039.1460);
		SetPlayerFacingAngle(playerid, 180.000);
	}
	else if(pickupid == fbi[4])
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,-2443.0530,497.7977,492.1183);
		SetPlayerFacingAngle(playerid, 359.8720);
	}
	else if(pickupid == fbi[3])
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2456.9695,518.1188,492.1730);
		SetPlayerFacingAngle(playerid, 176.8417);
	}
	else if(pickupid == fbi[2])
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2452.6711,513.1982,45.5625);
		SetPlayerFacingAngle(playerid, 264.6982);
	}
	/*if(pickupid == rmspawn[0]) // Vhod RM
	{
		SetPlayerPos(playerid, 1286.6494,-837.5760,1085.6328);
		SetPlayerVirtualWorld(playerid,1);
		SetPlayerInterior(playerid, 5);
		SetPlayerFacingAngle(playerid, 356.8563);
	}*/
	if(pickupid == rmspawn[1]) // Vyhod RM
	{
		SetPlayerPos(playerid, 962.8901,1684.3445,8.8516);
		SetPlayerVirtualWorld(playerid,0);
		SetPlayerInterior(playerid, 0);
		SetPlayerFacingAngle(playerid, 88.6402);
	}
	else if(pickupid == lift)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,1161.3190,-1327.4117,31.4998);
		SetPlayerFacingAngle(playerid, 0);
	}
	else if(pickupid == kauta)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1328.9766,495.3914,27.8631);
		SetPlayerVirtualWorld(playerid, 5);
		SetPlayerFacingAngle(playerid, 0);
	}
	else if(pickupid == kauta2)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1348.2666,494.8684,18.2278);
		SetPlayerFacingAngle(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == wmcvhod)
	{
		SetPlayerInterior(playerid, 11);
		SetPlayerVirtualWorld(playerid, 998);
		SetPlayerPos(playerid, 502.0615,-70.1586,998.7578);
		SetPlayerFacingAngle(playerid,178.1080);
	}
	else if(pickupid == vmcvhod)
	{
		SetPlayerInterior(playerid, 11);
		SetPlayerVirtualWorld(playerid, 52);
		SetPlayerPos(playerid, 502.0615,-70.1586,998.7578);
		SetPlayerFacingAngle(playerid,178.1080);
	}
	else if(pickupid == vmcvqhod)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 681.5864,-478.4098,16.3359);
		SetPlayerFacingAngle(playerid,179.4115);
	}
	/*if(pickupid == rmspawn[0]) // Vhod LCN
	{
		SetPlayerPos(playerid, 1263.6709,-785.2509,1091.9063);
		SetPlayerVirtualWorld(playerid,1);
		SetPlayerInterior(playerid, 5);
		SetPlayerFacingAngle(playerid, 356.8563);
	}*/
	if(pickupid == rmspawn[1]) // Vyhod LCN
	{
		SetPlayerPos(playerid, 1532.5365,751.3397,11.0234);
		SetPlayerVirtualWorld(playerid,0);
		SetPlayerInterior(playerid, 0);
		SetPlayerFacingAngle(playerid, 88.6402);
	}
	else if(pickupid == wmcvqhod)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 661.4137,1718.1427,7.1875);
		SetPlayerFacingAngle(playerid,39.7059);
	}
	else if(pickupid == pmcvhod)
	{
		SetPlayerInterior(playerid, 11);
		SetPlayerVirtualWorld(playerid, 8);
		SetPlayerPos(playerid, 502.0615,-70.1586,998.7578);
		SetPlayerFacingAngle(playerid,178.1080);
	}
	else if(pickupid == pmcvqhod)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, -2103.5435,-2482.9031,30.6250);
		SetPlayerFacingAngle(playerid,93.5094);
	}
	else if(pickupid == paints[0])
	{
		if(paint_info[1] != 1) return SCM(playerid,COLOR_GREY," Регистрация закрыта");
		//if(PTEMP[playerid][pLevel] < 3)return SCM(playerid,COLOR_GRAD1,"Участвовать можно с 3-х лет проживания в штате!");
		if(PTEMP[playerid][pWarns]) return SCM(playerid,COLOR_GREY, " Нельзя учавствовать с Варном");
		if(GetPVarInt(playerid, "player_paint")) return SCM(playerid, COLOR_GREY, " Вы уже зарегистрировались на матч!");
		new null;
		foreach(i) if(GetPVarInt(i,"player_paint")) null++;
		if(null >= 20) return SCM(playerid,COLOR_GREY, " Слишком много участников");
		SetPVarInt(playerid, "player_paint", 1);
		SCM(playerid,0x6495EDFF," Вы успешно зарегистрированы на матч. Не выходите из помещения!");
		format(string, 144, " Зарегистрирован участник под номером: %i", null+1);
		foreach(i) if(GetPVarInt(i,"player_paint")) SCM(i,0x6495EDFF, string);
		return true;
	}
	else if(pickupid == paints[1])
	{
		SetPlayerInterior(playerid, 1);
		SetPlayerPos(playerid, 286.4868, -40.2647, 1001.5156);
		SetPlayerFacingAngle(playerid, 318.7845);
		SetPlayerVirtualWorld(playerid, 1);
	}
	else if(pickupid == paints[2])
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, 2593.7839,2790.6182,10.8203);
		SetPlayerFacingAngle(playerid, 92.0974);
		SetPlayerVirtualWorld(playerid, 0);
		CP[playerid] = 0;
		DeletePVar(playerid,"player_paint");
		return true;
	}
	else if(pickupid >= paintguns[0] && pickupid <= paintguns[3])
	{
		if(GetPVarInt(playerid,"player_paint") != 2) return true;
		if(pickupid == paintguns[0]) GiveWeapon(playerid, 25, 30);
		else if(pickupid == paintguns[1]) GiveWeapon(playerid, 24, 30);
		else GiveWeapon(playerid, 31, 90);
	}
	else if(pickupid == lift2)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,1147.1436,-1315.2219,13.6735);
		SetPlayerFacingAngle(playerid, 0);
	}
	else if(pickupid == lift3)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2713.6965,629.1685,34.4028);
		SetPlayerFacingAngle(playerid, 0);
	}
	else if(pickupid == lift4)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2705.8311,637.6959,14.4545);
		SetPlayerFacingAngle(playerid, 0);
	}
	else if(pickupid == cerkva)
	{
		SetPlayerInterior(playerid, 1);
		SetPlayerPos(playerid,-1940.1830,1118.6595,1332.6483);
		SetPlayerVirtualWorld(playerid, 1);
	}
	else if(pickupid == cerkva2)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1985.9872,1118.4680,53.6462);
		SetPlayerFacingAngle(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == lift5)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,1607.3185,1788.1012,30.4688);
		SetPlayerFacingAngle(playerid, 0);
	}
	else if(pickupid == lift6)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,1599.6445,1817.1877,10.8203);
		SetPlayerFacingAngle(playerid, 0);
	}
	else if(pickupid == ash)
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPos(playerid,-2048.9138,-100.3720,1035.2432);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerFacingAngle(playerid, 180.0000);
	}
	else if(pickupid == ash2)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2026.3933,-99.7156,35.1641);
		SetPlayerFacingAngle(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerFacingAngle(playerid, 5.2804);
	}
	else if(pickupid == ash3)
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPos(playerid,-2050.8137,-121.7935,1035.2432);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerFacingAngle(playerid, 359.9116);
	}
	else if(pickupid == ash4)
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2029.7860,-122.9273,35.1974);
		SetPlayerFacingAngle(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == fbi[1])
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,-2453.7595,503.7701,30.0798);
		SetPlayerFacingAngle(playerid, 272.4807);
		SetPVarInt(playerid, "inUchastok", 0);
	}
	else if(pickupid == fbi[0])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,3);
			SetPlayerVirtualWorld(playerid, 130);
			SetPlayerPos(playerid,-2459.2603,516.7242,1039.1460);
			SetPlayerFacingAngle(playerid, 90.0);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lspd[0])
	{
		if(IsAArm(playerid) || IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,6);
			SetPlayerPos(playerid,246.6428,65.8026,1003.6406);
			SetPlayerFacingAngle(playerid, 2.2168);
			SetPVarInt(playerid, "inUchastok", 1);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lspd[1])
	{
		if (IsAArm(playerid) || IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,1552.8159,-1675.4498,16.1953);
			SetPlayerFacingAngle(playerid, 91.8310);
			SetPlayerVirtualWorld(playerid, 0);
			PTEMP[playerid][pPKeys] = 0;
			SetPVarInt(playerid, "inUchastok", 0);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lspd[4])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1528.010864,-1678.141723,5.890625);
		SetPlayerFacingAngle(playerid, 259.617370);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == lspd[2])
	{
		if (IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid))
		{
			SetPlayerInterior(playerid,6);
			SetPlayerPos(playerid,316.3837,-167.8547,999.5938);
			SetPlayerFacingAngle(playerid, 34.3574);
			SetPlayerVirtualWorld(playerid, 5);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " Вы не полицейский. Дверь заперта!");
		}
	}
	else if(pickupid == sf[4])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid))
		{
			SetPlayerInterior(playerid,6);
			SetPlayerPos(playerid,316.3837,-167.8547,999.5938);
			SetPlayerFacingAngle(playerid, 34.3574);
			SetPlayerVirtualWorld(playerid, 1);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == sf[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,-1606.4532,674.2636,-5.2422);
		SetPlayerFacingAngle(playerid, 357.2527);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == sf[1])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,-1590.8289,716.0479,-5.2422);
			SetPlayerFacingAngle(playerid, 269.9364);
			SetPlayerVirtualWorld(playerid, 0);
			PTEMP[playerid][pPKeys] = 0;
			SetPVarInt(playerid, "inUchastok", 0);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == sf[2])
	{
		SetPlayerInterior(playerid,10);
		SetPlayerPos(playerid,217.3147,121.3382,999.0156);
		SetPlayerFacingAngle(playerid, 272.8898);
		SetPVarInt(playerid, "inUchastok", 1);
	}
	else if(pickupid == sf[3])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 0)
		{
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,-1605.9866,718.9982,12.0476);
			SetPlayerFacingAngle(playerid, 359.1870);
			PTEMP[playerid][pPKeys] = 0;
			SetPVarInt(playerid, "inUchastok", 0);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == sf[5])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,10);
			SetPlayerPos(playerid,246.0613,110.8390,1003.2188);
			SetPlayerFacingAngle(playerid, 358.6587);
			PTEMP[playerid][pPKeys] = 0;
            SetPVarInt(playerid, "inUchastok", 1);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lspd[5])
	{
		SetPlayerInterior(playerid,6);
		SetPlayerPos(playerid,253.9933,86.9706,1002.4453);
		SetPlayerFacingAngle(playerid, 271.0300);
		SetPVarInt(playerid, "inUchastok", 1);
	}
	else if(pickupid == lspd[3])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,1568.6962,-1692.2069,5.8906);
			SetPlayerFacingAngle(playerid, 259.617370);
			SetPlayerVirtualWorld(playerid, 0);
			PTEMP[playerid][pPKeys] = 0;
			SetPVarInt(playerid, "inUchastok", 0);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == armijavhod)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,156.4952,1945.6383,20.0000);
		SetPlayerFacingAngle(playerid, 183.1738);
	}
	else if(pickupid == armijavihod)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,139.5660,1936.6910,19.2734);
		SetPlayerFacingAngle(playerid, 183.1738);
	}
	else if(pickupid == lvpdpic[0])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,3);
			SetPlayerVirtualWorld(playerid, 122);
			SetPlayerPos(playerid,238.5033,141.1578,1003.0234);
			SetPlayerFacingAngle(playerid, 359.1617);
			SetPVarInt(playerid, "inUchastok", 1);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lvpdpic[1])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid,2295.1934,2451.8459,10.8203);
			SetPlayerFacingAngle(playerid, 94.8742);
			PTEMP[playerid][pPKeys] = 0;
			SetPVarInt(playerid, "inUchastok", 0);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lvpdpic[2])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,3);
			SetPlayerVirtualWorld(playerid, 122);
			SetPlayerPos(playerid,288.7445,169.2445,1007.1719);
			SetPlayerFacingAngle(playerid, 9.7598);
			SetPVarInt(playerid, "inUchastok", 1);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lvpdpic[3])
	{
		if(IsAArm(playerid)|| IsACop(playerid) || IsAMayor(playerid)|| PTEMP[playerid][pPKeys] == 1)
		{
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid,2340.1965,2455.9792,14.9688);
			SetPlayerFacingAngle(playerid, 178.3347);
			PTEMP[playerid][pPKeys] = 0;
			SetPVarInt(playerid, "inUchastok", 0);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " У вас нет пропуска. Дверь заперта");
		}
	}
	else if(pickupid == lvpdpic[4])
	{
		ShowPlayerDialogEx(playerid,8240,DIALOG_STYLE_MSGBOX, "Вход", "Куда вы хотите войти?", "Склад", "На крышу");
	}
	else if(pickupid == lvpdpic[5])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,2293.3225,2468.6162,10.8203);
		SetPlayerFacingAngle(playerid, 93.6957);
	}
	else if(pickupid == lvpdpic[6])
	{
		ShowPlayerDialogEx(playerid,8241,DIALOG_STYLE_MSGBOX, "Вход", "Куда Вы хотите войти?", "Склад", "Вниз");
	}
	else if(pickupid >= chekmatlva[0] && pickupid <= chekmatlva[9])
	{
		if (!IsAGang(playerid)) return SCM(playerid,COLOR_GREY, " Вы не бандит");
		if(armmatbi <= 100) return SCM(playerid,COLOR_GRAD1, " На складе нет материалов");
		if(PTEMP[playerid][pMats] > 500) return SCM(playerid,COLOR_GRAD1, " У вас на руках уже есть материалы");
		SCM(playerid, 0x6495EDFF, " Вы взяли несколько комплектов");
		armmatbi -= 500;
		new strings1[50];
		format(strings1,sizeof(strings1), "{33AA33}Склад армии ЛВ: {FFFFFF}%i", armmatbi);
		UpdateDynamic3DTextLabelText(LvaLable, 0xFFFF00FF, strings1);
		if(PTEMP[playerid][pMember] == BestGang) PTEMP[playerid][pMats] = 1000;
		else PTEMP[playerid][pMats] = 500;
	}
	else if(pickupid >= chekmats[0]&& pickupid <= chekmats[1])
	{
		if (!IsAGang(playerid)) return SCM(playerid,COLOR_GREY, " Вы не бандит");
		if(armmatsf <= 100) return SCM(playerid,COLOR_GRAD1, " На складе нет материалов");
		if(PTEMP[playerid][pMats] > 500) return SCM(playerid,COLOR_GRAD1, " У вас на руках уже есть материалы");
		SCM(playerid, 0x6495EDFF, "Вы взяли несколько комплектов");
		armmatsf -= 500;
		if(PTEMP[playerid][pMember] == BestGang) PTEMP[playerid][pMats] = 1000;
		else PTEMP[playerid][pMats] = 500;
	}
	else if(pickupid >= mushroom[0]&& pickupid <= mushroom[1])
	{
		format(string, 40, " %s срезал(а) гриб", PTEMP[playerid][pName]);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		PTEMP[playerid][pMushrooms] += 1;
		ClearAnimations(playerid);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 6.1, 0, 0, 0, 0, 0,1);
		format(string,160, " Вы нашли гриб: \"%s\". Грибов собрано: %i штук",GribNames[random(3)],PTEMP[playerid][pMushrooms]);
		SCM(playerid,-1,string);
	}
	else if(pickupid == buygunzakon[0])
	{
		if(GetPVarInt(playerid,"Fraction_Duty") && IsACop(playerid) && IsAArm(playerid))
		{
	   		GetGunsDialog(playerid);
		}
	}
	else if(pickupid == buygunzakon[1])
	{
		if(GetPVarInt(playerid,"Fraction_Duty") && IsACop(playerid) && IsAArm(playerid))
		{
	   		GetGunsDialog(playerid);
		}
	}
	else if(pickupid == buygunzakon[3])
	{
		if(GetPVarInt(playerid,"Fraction_Duty") && IsACop(playerid) && IsAArm(playerid))
		{
	   		GetGunsDialog(playerid);
		}
	}
	else if(pickupid == buygunzakon[2])
	{
		if(GetPVarInt(playerid,"Fraction_Duty") && IsACop(playerid) && IsAArm(playerid))
		{
	   		GetGunsDialog(playerid);
		}
	}
	else if(pickupid >= serdce[0]&& pickupid <= serdce[2])
	{
		if(PTEMP[playerid][pLevel] == 1 || PTEMP[playerid][pLevel] == 2)
		{
			SetPlayerHealthAC(playerid, 100);
			PTEMP[playerid][pHP] = 100;
			PTEMP[playerid][pSatiety] = 100;
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " Только для новичков(1 и 2 лвл)");
		}
	}
	else if(pickupid == serdce[3])
	{
		if(PTEMP[playerid][pLevel] == 1 || PTEMP[playerid][pLevel] == 2 || PTEMP[playerid][pMember] == 7 || PTEMP[playerid][pLeader] == 7)
		{
			SetPlayerHealthAC(playerid, 100);
			PTEMP[playerid][pHP] = 100;
			PTEMP[playerid][pSatiety] = 100;
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " Только для новичков(1 и 2 лвл)");
		}
	}
	else if(pickupid == cashs)
	{
		if(Works[playerid] == false) return true;
		if(JobAmmount[playerid] == 0) return SCM(playerid,COLOR_GREY, " Вы ничего не заработали");
		PTEMP[playerid][pCash] +=JobAmmount[playerid]*25;
		format(YCMDstr, sizeof(YCMDstr), "~g~+%d$", JobAmmount[playerid]*25);
		GameTextForPlayer(playerid, YCMDstr, 3000, 1);
		SCM(playerid,COLOR_GREEN,"Спасибо за работу, приходите еще!");
		JobAmmount[playerid] = 0; Employer[playerid] = 999;
		return true;
	}
	else if(pickupid == clothes)
	{
		ShowPlayerDialogEx(playerid,4423,DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите начать рабочий день , или закончить?", "Начать", "Закончить");
	}
	else if(pickupid == skinshop[0] || pickupid == skinshop[2])
	{
		if(PTEMP[playerid][pSex] != 1) return SCM(playerid, -1, " Вы ошиблись кабинкой");
		if(!GetPVarInt(playerid,"Fraction_Duty"))
		{
			SetPlayerInterior(playerid,5);
			SCM(playerid, COLOR_RED, " Используйте клавишу 'Быстрый бег' (пробел по умолчанию)");
			SCM(playerid, COLOR_RED, " Используйте клавишу 'Вверх,вниз' (W,S по умолчанию)");
			SetPlayerPos(playerid,222.3489,-8.5845,1002.2109);
			SetPlayerFacingAngle(playerid, 266.7302);
			SetPlayerCameraPos(playerid,225.3489,-8.5845,1002.2109);
			SetPlayerCameraLookAt(playerid,222.3489,-8.5845,1002.2109);
			TogglePlayerControllable(playerid, 0);
			ChangeSkin[playerid] = 0;
			new skin = Random(2,200);
			SetPlayerVirtualWorld(playerid,skin);
			if(!IsValidMenu(BuyClothes))
			{
				BuyClothes = CreateMenu("Clothes", 1, 50.0, 160.0, 110.0);
				SetMenuColumnHeader(BuyClothes, 0, "Choose Skin");
				AddMenuItem(BuyClothes, 0, "Next >>");
				AddMenuItem(BuyClothes, 0, "<< Previous");
				AddMenuItem(BuyClothes, 0, "Buy");
				AddMenuItem(BuyClothes, 0, "Exit");
			}
			ShowMenuForPlayer(BuyClothes, playerid);
			SetPlayerSkin(playerid,SkinMen[ChangeSkin[playerid]][0]);// Одеваем скин
			return true;
		}
		else if(PTEMP[playerid][pMember] > 0)
		{
			if(PTEMP[playerid][pMember] == 1) {  ChosenSkin[playerid] = 59; }
			else if(PTEMP[playerid][pMember] == 2) {  ChosenSkin[playerid] = 286; }
			else if(PTEMP[playerid][pMember] == 3) {  ChosenSkin[playerid] = 287; }
			else if(PTEMP[playerid][pMember] == 4) {  ChosenSkin[playerid] = 70; }
			else if(PTEMP[playerid][pMember] == 5) {  ChosenSkin[playerid] = 223; }
			else if(PTEMP[playerid][pMember] == 6) {  ChosenSkin[playerid] = 120; }
			else if(PTEMP[playerid][pMember] == 7) {  ChosenSkin[playerid] = 57; }
			else if(PTEMP[playerid][pMember] == 8) {  ChosenSkin[playerid] = 171; }
			else if(PTEMP[playerid][pMember] == 9) {  ChosenSkin[playerid] = 250; }
			else if(PTEMP[playerid][pMember] == 10) {  ChosenSkin[playerid] = 280; }
			else if(PTEMP[playerid][pMember] == 11) {  ChosenSkin[playerid] = 59; }
			else if(PTEMP[playerid][pMember] == 12) {  ChosenSkin[playerid] = 102; }
			else if(PTEMP[playerid][pMember] == 13) {  ChosenSkin[playerid] = 108; }
			else if(PTEMP[playerid][pMember] == 14) {  ChosenSkin[playerid] = 111; }
			else if(PTEMP[playerid][pMember] == 15) {  ChosenSkin[playerid] = 106; }
			else if(PTEMP[playerid][pMember] == 16) {  ChosenSkin[playerid] = 250; }
			else if(PTEMP[playerid][pMember] == 17) {  ChosenSkin[playerid] = 114; }
			else if(PTEMP[playerid][pMember] == 18) {  ChosenSkin[playerid] = 173; }
			else if(PTEMP[playerid][pMember] == 19) {  ChosenSkin[playerid] = 287; }
			else if(PTEMP[playerid][pMember] == 20) {  ChosenSkin[playerid] = 250; }
			else if(PTEMP[playerid][pMember] == 21) {  ChosenSkin[playerid] = 280; }
			else if(PTEMP[playerid][pMember] == 22) {  ChosenSkin[playerid] = 70; }
			else if(PTEMP[playerid][pMember] == 24) {  ChosenSkin[playerid] = 247; }
			else if(PTEMP[playerid][pMember] == 26) {  ChosenSkin[playerid] = 247; }
			else if(PTEMP[playerid][pMember] == 29) {  ChosenSkin[playerid] = 247; }
			else if(PTEMP[playerid][pMember] == 33) {  ChosenSkin[playerid] = 70; }
			SetPlayerInterior(playerid,5);
			SCM(playerid, COLOR_RED, " Используйте клавишу 'Быстрый бег' (пробел по умолчанию)");
			SCM(playerid, COLOR_RED, " Используйте клавишу 'Вверх,вниз' (W,S по умолчанию)");
			SetPlayerPos(playerid,222.3489,-8.5845,1002.2109);
			SetPlayerFacingAngle(playerid, 266.7302);
			SetPlayerCameraPos(playerid,225.3489,-8.5845,1002.2109);
			SetPlayerCameraLookAt(playerid,222.3489,-8.5845,1002.2109);
			TogglePlayerControllable(playerid, 0);
			new skin = Random(2,200);
			SetPlayerVirtualWorld(playerid,skin);
			SelectChar[playerid] = 255;
			SelectCharID[playerid] = PTEMP[playerid][pMember];
			SelectCharPlace[playerid] = 1;
			PTEMP[playerid][pModel] = ChosenSkin[playerid];
			if(!IsValidMenu(ChoseSkin[0]))
			{
				ChoseSkin[0] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
				SetMenuColumnHeader(ChoseSkin[0], 0, "Choose Skin");
				AddMenuItem(ChoseSkin[0], 0, ">> Next");
				AddMenuItem(ChoseSkin[0], 0, "<< Previous");
				AddMenuItem(ChoseSkin[0], 0, "Done");
			}
			ShowMenuForPlayer(ChoseSkin[0],playerid);
			return true;
		}
	}
	else if(pickupid == skinshop[1] || pickupid == skinshop[3])
	{
		if(PTEMP[playerid][pSex] != 2) return SCM(playerid, -1, " Вы ошиблись кабинкой");
		if(!GetPVarInt(playerid,"Fraction_Duty"))
		{
			if(!IsValidMenu(BuyClothes))
			{
				BuyClothes = CreateMenu("Clothes", 1, 50.0, 160.0, 110.0);
				SetMenuColumnHeader(BuyClothes, 0, "Choose Skin");
				AddMenuItem(BuyClothes, 0, "Next >>");
				AddMenuItem(BuyClothes, 0, "<< Previous");
				AddMenuItem(BuyClothes, 0, "Buy");
				AddMenuItem(BuyClothes, 0, "Exit");
			}
			ShowMenuForPlayer(BuyClothes, playerid);
			SetPlayerInterior(playerid,5);
			SCM(playerid, COLOR_RED, " Используйте клавишу 'Быстрый бег' (пробел по умолчанию)");
			SCM(playerid, COLOR_RED, " Используйте клавишу 'Вверх,вниз' (W,S по умолчанию)");
			SetPlayerPos(playerid,222.3489,-8.5845,1002.2109);
			SetPlayerFacingAngle(playerid, 266.7302);
			SetPlayerCameraPos(playerid,225.3489,-8.5845,1002.2109);
			SetPlayerCameraLookAt(playerid,222.3489,-8.5845,1002.2109);
			TogglePlayerControllable(playerid, 0);
			ChangeSkin[playerid]=0;
			new skin = Random(2,200);
			SetPlayerVirtualWorld(playerid,skin);
			if(ChangeSkin[playerid]	== sizeof(SkinMale)-1) ChangeSkin[playerid] = 0;
			else ChangeSkin[playerid]++;
			SetPlayerSkin(playerid,SkinMale[ChangeSkin[playerid]][0]);// Одеваем скин
		}
		else if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] >= 1)
		{
			if(!IsValidMenu(ChoseSkin[0]))
			{
				ChoseSkin[0] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
				SetMenuColumnHeader(ChoseSkin[0], 0, "Choose Skin");
				AddMenuItem(ChoseSkin[0], 0, ">> Next");
				AddMenuItem(ChoseSkin[0], 0, "<< Previous");
				AddMenuItem(ChoseSkin[0], 0, "Done");
			}
			ShowMenuForPlayer(ChoseSkin[0],playerid);
			if(PTEMP[playerid][pMember] == 1) {  ChosenSkin[playerid] = 59; }
			else if(PTEMP[playerid][pMember] == 2) {  ChosenSkin[playerid] = 286; }
			else if(PTEMP[playerid][pMember] == 3) {  ChosenSkin[playerid] = 287; }
			else if(PTEMP[playerid][pMember] == 4) {  ChosenSkin[playerid] = 70; }
			else if(PTEMP[playerid][pMember] == 5) {  ChosenSkin[playerid] = 223; }
			else if(PTEMP[playerid][pMember] == 6) {  ChosenSkin[playerid] = 120; }
			else if(PTEMP[playerid][pMember] == 7) {  ChosenSkin[playerid] = 57; }
			else if(PTEMP[playerid][pMember] == 8) {  ChosenSkin[playerid] = 171; }
			else if(PTEMP[playerid][pMember] == 9) {  ChosenSkin[playerid] = 250; }
			else if(PTEMP[playerid][pMember] == 10) {  ChosenSkin[playerid] = 280; }
			else if(PTEMP[playerid][pMember] == 11) {  ChosenSkin[playerid] = 59; }
			else if(PTEMP[playerid][pMember] == 12) {  ChosenSkin[playerid] = 102; }
			else if(PTEMP[playerid][pMember] == 13) {  ChosenSkin[playerid] = 108; }
			else if(PTEMP[playerid][pMember] == 14) {  ChosenSkin[playerid] = 111; }
			else if(PTEMP[playerid][pMember] == 15) {  ChosenSkin[playerid] = 106; }
			else if(PTEMP[playerid][pMember] == 16) {  ChosenSkin[playerid] = 250; }
			else if(PTEMP[playerid][pMember] == 17) {  ChosenSkin[playerid] = 114; }
			else if(PTEMP[playerid][pMember] == 18) {  ChosenSkin[playerid] = 173; }
			else if(PTEMP[playerid][pMember] == 19) {  ChosenSkin[playerid] = 287; }
			else if(PTEMP[playerid][pMember] == 20) {  ChosenSkin[playerid] = 250; }
			else if(PTEMP[playerid][pMember] == 21) {  ChosenSkin[playerid] = 280; }
			else if(PTEMP[playerid][pMember] == 22) {  ChosenSkin[playerid] = 70; }
			else if(PTEMP[playerid][pMember] == 24) {  ChosenSkin[playerid] = 247; }
			else if(PTEMP[playerid][pMember] == 26) {  ChosenSkin[playerid] = 247; }
			else if(PTEMP[playerid][pMember] == 29) {  ChosenSkin[playerid] = 247; }
			else if(PTEMP[playerid][pMember] == 33) {  ChosenSkin[playerid] = 70; }
			else { return true; }
			SetPlayerInterior(playerid,5);
			new skin = Random(2,200);
			SetPlayerVirtualWorld(playerid,skin);
			SetPlayerPos(playerid,222.3489,-8.5845,1002.2109);
			SetPlayerFacingAngle(playerid, 266.7302);
			SetPlayerCameraPos(playerid,225.3489,-8.5845,1002.2109);
			SetPlayerCameraLookAt(playerid,222.3489,-8.5845,1002.2109);
			TogglePlayerControllable(playerid, 0);
			SelectChar[playerid] = 255;
			SelectCharID[playerid] = PTEMP[playerid][pMember];
			SelectCharPlace[playerid] = 1;
			PTEMP[playerid][pModel] = ChosenSkin[playerid];
			return true;
		}
	}
	else if(pickupid == marenter[0])
	{
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,385.9440,173.6978,1008.3828);
		SetPlayerFacingAngle(playerid, 88.1044);
		if(PTEMP[playerid][pQuestL] == 1 && PTEMP[playerid][pQuest] == 5)
		{
			PlayerPlaySound(playerid, 4201, 0.0, 0.0, 0);
			ShowPlayerDialogEx(playerid,13376,DIALOG_STYLE_MSGBOX,"Задание","Поздравляем\nСюжетная линия ''Гость'' пройдена!"
			,"Готово","");
			GameTextForPlayer(playerid, "~g~+4000$", 2000, 1);
			PTEMP[playerid][pCash] += 4000;
			if(PTEMP[playerid][pLevel] == 1) SCM(playerid, COLOR_LIGHTGREEN, " Поздравляем! Ваш лвл повысился");
			if(PTEMP[playerid][pLevel] == 1) PTEMP[playerid][pLevel] = 2;
			if(PTEMP[playerid][pLevel] == 2) PTEMP[playerid][pExp] = 0;
			PTEMP[playerid][pQuestL] = 0;
			PTEMP[playerid][pQuest] = 0;
			PTEMP[playerid][pQuestF] = 0;
			PTEMP[playerid][pQuestP] = 0;
			PTEMP[playerid][pQuestPF] = 0;
			SCM(playerid,0x30a0a7aa," Задание выполнено");
		}
	}
	else if(pickupid == marenter[1])
	{
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,366.4958,193.5977,1008.3828);
		SetPlayerFacingAngle(playerid, 91.0948);
		if(PTEMP[playerid][pQuestL] == 1 && PTEMP[playerid][pQuest] == 5)
		{
			PlayerPlaySound(playerid, 4201, 0.0, 0.0, 0);
			ShowPlayerDialogEx(playerid,13376,DIALOG_STYLE_MSGBOX,"Задание","Поздравляем\nСюжетная линия ''Гость'' пройдена!"
			,"Готово","");
			GameTextForPlayer(playerid, "~g~+4000$", 2000, 1);
			PTEMP[playerid][pCash] += 4000;
			if(PTEMP[playerid][pLevel] == 1) SCM(playerid, COLOR_LIGHTGREEN, " Поздравляем! Ваш лвл повысился");
			if(PTEMP[playerid][pLevel] == 1) PTEMP[playerid][pLevel] = 2;
			if(PTEMP[playerid][pLevel] == 2) PTEMP[playerid][pExp] = 0;
			PTEMP[playerid][pQuestL] = 0;
			PTEMP[playerid][pQuest] = 0;
			PTEMP[playerid][pQuestF] = 0;
			PTEMP[playerid][pQuestP] = 0;
			PTEMP[playerid][pQuestPF] = 0;
			SCM(playerid,0x30a0a7aa," Задание выполнено");
		}
	}
	else if(pickupid == marenter[2])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1435.1095,-1789.6874,33.4297);
		SetPlayerFacingAngle(playerid, 87.9211);
	}
	else if(pickupid == maria)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1410.1788,-1790.2755,13.5540);
		SetPlayerFacingAngle(playerid, 87.9211);
	}
	else if(pickupid == marexit)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1480.8832,-1769.0471,18.7958);
		SetPlayerFacingAngle(playerid, 0.3133);
		DisablePlayerCheckpoint(playerid);
		PicCP[playerid] = 0;
		CP[playerid] = 0;
	}
	else if(pickupid == rifa[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,2185.96,-1811.94,13.55);
		SetPlayerFacingAngle(playerid, 400);
	}
	else if(pickupid == rifa[1])
	{
		SetPlayerInterior(playerid,8);
		SetPlayerVirtualWorld(playerid, 63);
		SetPlayerPos(playerid,2807.2239,-1172.5020,1025.5703);
		SetPlayerFacingAngle(playerid, 360);
	}
	else if(pickupid == vagospic[0])
	{
		SetPlayerInterior(playerid,4);
		SetPlayerVirtualWorld(playerid, 75);
		SetPlayerPos(playerid,2806.8708,-1603.3502,-36.5231);
		SetPlayerFacingAngle(playerid, 500);
		TogglePlayerControllable(playerid, 0);
		SetTimerEx("_UnFreeze" , 400, false, "i", playerid);
	}
	else if(pickupid == vagospic[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,2774.2017,-1628.0233,12.1775);
		SetPlayerFacingAngle(playerid, 330.4577);
	}
	else if(pickupid == grooveenter)
	{
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,2496.1580,-1694.5743,1014.7422);
		SetPlayerFacingAngle(playerid,177.8856);
		SetPlayerVirtualWorld(playerid, 1);
	}
	else if(pickupid == grooveexit)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,2495.1199,-1688.3727,13.7653);
		SetPlayerFacingAngle(playerid, 4.2929);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == aztecpic[0])
	{
		SetPlayerInterior(playerid,8);
		SetPlayerVirtualWorld(playerid, 36);
		SetPlayerPos(playerid,-42.31,1408.18,1084.43);
		SetPlayerFacingAngle(playerid, 1000);
	}
	else if(pickupid == aztecpic[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,1667.4498,-2108.3840,13.8906);
		SetPlayerFacingAngle(playerid, 178.1356);
	}
	else if(pickupid == bankpic[0])
	{
		SetPVarInt(playerid, "in_bank", 1);
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,2307.65,-15.7474,26.7496);
		SetPlayerFacingAngle(playerid, 281.2246);
	}
	else if(pickupid == bankpic[1])
	{
	    DeletePVar(playerid, "in_bank");
		if(ebanksf[playerid] == 1)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid,1415.4658,-1700.8145,13.5395);
			SetPlayerFacingAngle(playerid, 267.6245);
			ebanksf[playerid] = 0;
			return true;
		}
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,1414.14,-1702.78,13.5395);
		SetPlayerFacingAngle(playerid, 209.7472);
	}
	/*else if(pickupid == banksf)
	{
		ebanksf[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,2307.6462,-15.7474,26.7496);
		SetPlayerFacingAngle(playerid, 281.2246);
	}*/
	else if(pickupid == ballasvhod[0])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,2647.9932,-2021.5747,13.5469);
		SetPlayerFacingAngle(playerid, 100);
	}
	else if(pickupid == ballasvhod[1])
	{
		SetPlayerInterior(playerid,6);
		SetPlayerVirtualWorld(playerid, 34);
		SetPlayerPos(playerid,-68.6311,1353.8743,1080.2109);
		SetPlayerFacingAngle(playerid, 100);
	}
	else if(pickupid == sklad[0])
	{
		SetPlayerInterior(playerid,6);
		SetPlayerPos(playerid,316.9104,-168.6356,999.5938);
		SetPlayerFacingAngle(playerid, 355.8037);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == sklad[1])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,338.3804,1949.1343,22.0174);
		SetPlayerFacingAngle(playerid, 92.2485);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == skladfbi)
	{
		SetPlayerInterior(playerid,6);
		SetPlayerPos(playerid,316.9104,-168.6356,999.5938);
		SetPlayerFacingAngle(playerid, 355.8037);
		SetPlayerVirtualWorld(playerid, 130);
	}
	else if(pickupid == skladfbi2)
	{
		SetPlayerInterior(playerid, 3);
		SetPlayerPos(playerid,-2472.7883,513.3563,1039.1460);
		SetPlayerFacingAngle(playerid, 0);
		SetPlayerVirtualWorld(playerid, 130);
	}
	else if(pickupid == sklad[2])
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,-1370.39,498.79,11.20);
		SetPlayerFacingAngle(playerid, 270.0000);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else if(pickupid == sklad[3])
	{
		SetPlayerInterior(playerid,6);
		SetPlayerPos(playerid,316.9104,-168.6356,999.5938);
		SetPlayerFacingAngle(playerid, 355.8037);
		SetPlayerVirtualWorld(playerid, 3);
	}
	else if(pickupid == lsaammo)
	{
		if(GetPVarInt(playerid,"Fraction_Duty") || IsACop(playerid) || IsAArm(playerid))
		{
			SetPVarInt(playerid,"lsaammo",1);
	   		GetGunsDialog(playerid);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " Вы не силовик");
		}
	}
	else if(pickupid == lsamat)
	{
	//	if(!IsAGang(playerid)) return SCM(playerid,COLOR_GREY," Вы не бандит");
		SCM(playerid, 0x6ab1ffaa, " Склад с оружием. Чтобы украсть комплект, используйте /materials get");
	}
	else if(pickupid == gunarm[0])
	{
		if(GetPVarInt(playerid,"Fraction_Duty") || IsACop(playerid) || IsAArm(playerid))
		{
	   		GetGunsDialog(playerid);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " Вы не силовик");
		}
	}
	else if(pickupid == gunarm[1])
	{
		if(GetPVarInt(playerid,"Fraction_Duty") || IsACop(playerid) || IsAArm(playerid))
		{
	   		GetGunsDialog(playerid);
		}
		else
		{
			SCM(playerid, 0x9f0000aa, " Вы не силовик");
		}
	}
	else if(pickupid == zonaa)
	{
		if(PTEMP[playerid][pMember] == 19 || PTEMP[playerid][pLeader] == 19 || proverkaforma[playerid] == 1)
		{
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,279.4233,1835.0087,17.6481);
			SetPlayerFacingAngle(playerid, 17.2727);
		}
		else
		{
			SCM(playerid, -1, " У вас нет ключа!");
		}
	}
	else if(pickupid == zona)
	{
		if(PTEMP[playerid][pMember] == 19 || PTEMP[playerid][pLeader] == 19 || proverkaforma[playerid] == 1)
		{
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,291.8297,1836.4666,17.6406);
			SetPlayerFacingAngle(playerid, 346.3333);
		}
		else
		{
			SCM(playerid, -1, " У вас нет ключа!");
		}
	}
	else if(pickupid >= PickupRazd[0] && pickupid <= PickupRazd[34])
	{
		new bouse = PTEMP[playerid][pPHouseKey];
		if (GetPlayerVirtualWorld(playerid) != bouse+50) return true;
		if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] != 0) return SCM(playerid,COLOR_GREY," Вы не можете использовать гардероб! ( Если вы состоите в гос. организации, переоденьтесь на базе )");
		t_SetPlayerPos(playerid,181.5215,-88.0678,1002.0234);
		SetPlayerFacingAngle(playerid, 92.6158);
		SetPlayerCameraPos(playerid,179.1173,-88.0198,1002.0234);
		SetPlayerCameraLookAt(playerid,179.1173,-88.0198,1002.0234);
		SetPlayerInterior(playerid,18);
		ShowPlayerDialogEx(playerid,10399,DIALOG_STYLE_LIST, "Гардероб","Вешалка №1\nВешалка №2\nВешалка №3\nВешалка №4\nВешалка №5", "Повешать", "Выход");
	}
	for(new h = 1; h <= TotalHouse; h++)
	{
		if(pickupid == HouseInfo[h][hPickup])
		{
			if(strcmp(HouseInfo[h][hOwner],"None",true) != 0)
			{
				new ttextt[32];
				if(IsPlayerConnected(GetPlayerID(HouseInfo[h][hOwner]))) ttextt = "[{22ff00}Online{F2EEF0}]";
				else if(!IsPlayerConnected(GetPlayerID(HouseInfo[h][hOwner]))) ttextt = "[{ff001c}Offline{F2EEF0}]";
				if(HouseInfo[h][hKlass] == 0)format(string, 256, "{FFFFFF}Владелец: %s {F2EEF0}%s\n{FFFFFF}Класс: Nope\n{FFFFFF}Номер дома: %i",HouseInfo[h][hOwner],ttextt,h);
				else if(HouseInfo[h][hKlass] == 1)format(string, 256, "{FFFFFF}Владелец: {F2EEF0}%s %s\n{FFFFFF}Класс: D\n{FFFFFF}Номер дома: %i",HouseInfo[h][hOwner],ttextt,h);
				else if(HouseInfo[h][hKlass] == 2)format(string, 256, "{FFFFFF}Владелец: {F2EEF0}%s %s\n{FFFFFF}Класс: C\n{FFFFFF}Номер дома: %i",HouseInfo[h][hOwner],ttextt,h);
				else if(HouseInfo[h][hKlass] == 3)format(string, 256, "{FFFFFF}Владелец: {F2EEF0}%s %s\n{FFFFFF}Класс: B\n{FFFFFF}Номер дома: %i",HouseInfo[h][hOwner],ttextt,h);
				else if(HouseInfo[h][hKlass] == 4)format(string, 256, "{FFFFFF}Владелец: {F2EEF0}%s %s\n{FFFFFF}Класс: A\n{FFFFFF}Номер дома: %i",HouseInfo[h][hOwner],ttextt,h);
				else format(string, 256, "{FFFFFF}Владелец: %s %s\n{FFFFFF}Класс: S\n{FFFFFF}Номер дома: %i",HouseInfo[h][hOwner],ttextt,h);
				ShowPlayerDialogEx(playerid,10075,DIALOG_STYLE_MSGBOX, "Дом занят",string, "Войти", "Отмена");
				return true;
			}
			else
			{
				if(HouseInfo[h][hKlass] == 0)
				{
					format(string, 256, "{FFFFFF}Стоимость: %i\n{FFFFFF}Класс: Nope\n{FFFFFF}Номер дома: %i\n{FFFFFF}Введите: /buyhouse чтобы купить дом",HouseInfo[h][hValue],h);
				}
				else if(HouseInfo[h][hKlass] == 1)
				{
					format(string, 256, "{FFFFFF}Стоимость: %i\n{FFFFFF}Класс: D\n{FFFFFF}Номер дома: %i\n{FFFFFF}Введите: /buyhouse чтобы купить дом",HouseInfo[h][hValue],h);
				}
				else if(HouseInfo[h][hKlass] == 2)
				{
					format(string, 256, "{FFFFFF}Стоимость: %i\n{FFFFFF}Класс: C\n{FFFFFF}Номер дома: %i\n{FFFFFF}Введите: /buyhouse чтобы купить дом",HouseInfo[h][hValue],h);
				}
				else if(HouseInfo[h][hKlass] == 3)
				{
					format(string, 256, "{FFFFFF}Стоимость: %i\n{FFFFFF}Класс: B\n{FFFFFF}Номер дома: %i\n{FFFFFF}Введите: /buyhouse чтобы купить дом",HouseInfo[h][hValue],h);
				}
				else if(HouseInfo[h][hKlass] == 4)
				{
					format(string, 256, "{FFFFFF}Стоимость: %i\n{FFFFFF}Класс: A\n{FFFFFF}Номер дома: %i\n{FFFFFF}Введите: /buyhouse чтобы купить дом",HouseInfo[h][hValue],h);
				}
				else
				{
					format(string, 256, "{FFFFFF}Стоимость: %i\n{FFFFFF}Класс: S\n{FFFFFF}Номер дома: %i\n{FFFFFF}Введите: /buyhouse чтобы купить дом",HouseInfo[h][hValue],h);
				}
				ShowPlayerDialogEx(playerid,10026,DIALOG_STYLE_MSGBOX, "Дом свободен",string, "Войти", "Отмена");
				return true;
			}
		}
	}
	for(new b = 1; b <= TotalBizz; b++)
	{
		if(pickupid == BizzInfo[b][bEnterPic])
		{
			if(strcmp(BizzInfo[b][bOwner],"None",true) == 0)
			{
				PickupX[playerid] = BizzInfo[b][bExitX], PickupY[playerid] = BizzInfo[b][bExitY];
				oldpickup[playerid] = BizzInfo[b][bExitPic];
				timepickup[playerid] = 3;
				SetPlayerInterior(playerid,BizzInfo[b][bInterior]);
				SetPlayerPos(playerid,BizzInfo[b][bExitX],BizzInfo[b][bExitY],BizzInfo[b][bExitZ]);
				SetPlayerVirtualWorld(playerid,BizzInfo[b][bVirtualWorld]);
				return true;
			}
			if(BizzInfo[b][bType] == 1)
			{
				if(enterbiz[playerid] != b && PTEMP[playerid][pPBizzKey] != b)
				{
					if(BizzInfo[b][bLocked] == 1)
					{
						SCM(playerid, COLOR_GRAD1, " Бизнес закрыт");
						return true;
					}
					format(string,100, "Цена входа %i вирт\nВы хотите войти?",BizzInfo[b][bEntranceCost]);
					ShowPlayerDialogEx(playerid,9898,DIALOG_STYLE_MSGBOX, "Вход",string, "Да", "Отмена");
					return true;
				}
				else
				{
					PickupX[playerid] = BizzInfo[b][bExitX], PickupY[playerid] = BizzInfo[b][bExitY];
					oldpickup[playerid] = BizzInfo[b][bExitPic];
					timepickup[playerid] = 3;
					SetPlayerInterior(playerid,BizzInfo[b][bInterior]);
					SetPlayerPos(playerid,BizzInfo[b][bExitX],BizzInfo[b][bExitY],BizzInfo[b][bExitZ]);
					SetPlayerVirtualWorld(playerid,BizzInfo[b][bVirtualWorld]);
					return true;
				}
			}
			else
			{
				if(BizzInfo[b][bLocked] == 1)
				{
					SCM(playerid, COLOR_GRAD1, " Бизнес закрыт");
					return true;
				}
				PickupX[playerid] = BizzInfo[b][bExitX], PickupY[playerid] = BizzInfo[b][bExitY];
				oldpickup[playerid] = BizzInfo[b][bExitPic];
				timepickup[playerid] = 3;
				SetPlayerInterior(playerid,BizzInfo[b][bInterior]);
				SetPlayerPos(playerid,BizzInfo[b][bExitX],BizzInfo[b][bExitY],BizzInfo[b][bExitZ]);
				SetPlayerVirtualWorld(playerid,BizzInfo[b][bVirtualWorld]);
				return true;
			}
		}
		else if(pickupid == BizzInfo[b][bExitPic])
		{
			PickupX[playerid] = BizzInfo[b][bEntranceX], PickupY[playerid] = BizzInfo[b][bEntranceY];
			oldpickup[playerid] = BizzInfo[b][bEnterPic];
			timepickup[playerid] = 3;
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,BizzInfo[b][bEntranceX],BizzInfo[b][bEntranceY],BizzInfo[b][bEntranceZ]);
			SetPlayerVirtualWorld(playerid,0);
			return true;
		}
		else if(pickupid == BizzInfo[b][bPickup] && PlayerToPoint(2.0,playerid,BizzInfo[b][bBarX],BizzInfo[b][bBarY],BizzInfo[b][bBarZ])) GameTextForPlayer(playerid, "~w~Print:~g~\"/eat\"", 5000, 3);
	}
	if(pickupid == podeezdi)
	{
		new i = GetPVarInt(playerid, "podeezd");
		PickupX[playerid] = PodeezdInfo[i][podPicX], PickupY[playerid] = PodeezdInfo[i][podPicY];
		oldpickup[playerid] = PodeezdInfo[i][podPic];
		timepickup[playerid] = 3;
		SetPlayerPos(playerid, PodeezdInfo[i][podPicX],PodeezdInfo[i][podPicY],PodeezdInfo[i][podPicZ]);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		DeletePVar(playerid, "podeezd");
		return true;
	}
	
	for(new g = 1; g <= AllPODEZD; g++)
	{
		if(pickupid == PodeezdInfo[g][podPic])
		{
			SetPVarInt(playerid, "podeezd",g);
			new str[8], varv[100];
			strcat(varv,"Парковка\n");
			for(new f = 1; f <= PodeezdInfo[g][podEtazi]; f++)
			{
				format(str, 10, "%i этаж\n", f);
				strcat(varv,str);
			}
			return ShowPlayerDialogEx(playerid, 8999, 2, "Лифт", varv, "Перейти", "Закрыть");
		}
	}
	return true;
}