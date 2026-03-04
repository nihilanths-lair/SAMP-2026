public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsABank(playerid))
	{
	    if(newkeys == KEY_SECONDARY_ATTACK)
	    {
	        //SCM(playerid, -1, " Тут будет меню банка");
	        ShowPlayerDialogEx(playerid,9666,DIALOG_STYLE_LIST, "Банк", "[0] Пополнить счет\n[1] Снять со счета\n[2] Сделать перевод\n[3] Баланс\n[4] Оплатить квартплату", "Выбрать", "Назад");
	    }
	}
	if(newkeys & KEY_SECONDARY_ATTACK && Spectate[playerid])
	{
		DisableEnableReconButton(playerid, ReconSelect[playerid], 0);
		return SelectTextDraw(playerid, 0xD97700AA);
	}
	if(newkeys & KEY_HANDBRAKE && newkeys & KEY_SECONDARY_ATTACK )
	{
		if(PlayerToPoint(2.5,playerid,768.5205,-2.8860,1000.7214) || PlayerToPoint(2.5,playerid,769.8723,14.4393,1000.6978))
		{
			if(Flood[playerid] > 0) return true;
			if(training[playerid] == 1 && PTEMP[playerid][pBoxSkill] < 1000)
			{
				PTEMP[playerid][pBoxSkill] += 1;
				format(string,90, "~g~NEED: ~w~%d / 1000",PTEMP[playerid][pBoxSkill]);
				GameTextForPlayer(playerid, string, 2000, 3);
				return true;
			}
			else if(training[playerid] == 1 && PTEMP[playerid][pBoxSkill] > 999) return training[playerid] = 2;
			else if(training[playerid] == 2) return SCM(playerid,COLOR_GREEN," Вы готовы к бою! Найдите соперника и тренера, который устроит вам поединок."),SetPlayerFightingStyle (playerid, FIGHT_STYLE_BOXING),Flood[playerid] = 4;
			else if(training[playerid] == 3 && PTEMP[playerid][pKickboxSkill] < 1000)
			{
				PTEMP[playerid][pKickboxSkill] += 1;
				format(string,90, "~g~NEED: ~w~%d / 1000",PTEMP[playerid][pKickboxSkill]);
				GameTextForPlayer(playerid, string, 2000, 3);
				return true;
			}
			else if(training[playerid] == 3 && PTEMP[playerid][pKickboxSkill] > 999) return training[playerid] = 4;
			else if(training[playerid] == 4) return SCM(playerid,COLOR_GREEN," Вы готовы к бою! Найдите соперника и тренера, который устроит вам поединок."),SetPlayerFightingStyle (playerid, FIGHT_STYLE_KNEEHEAD),Flood[playerid] = 4;
			else if(training[playerid] == 5 && PTEMP[playerid][pKongfuSkill] < 1000)
			{
				PTEMP[playerid][pKongfuSkill] += 1;
				format(string,90, "~g~NEED: ~w~%d / 1000",PTEMP[playerid][pKongfuSkill]);
				GameTextForPlayer(playerid, string, 2000, 3);
				return true;
			}
			else if(training[playerid] == 5 && PTEMP[playerid][pKongfuSkill] > 999) return PTEMP[playerid][pTraining] = 5;
			else if(PTEMP[playerid][pTraining] == 5) return SCM(playerid,COLOR_GREEN," Вы готовы к бою! Найдите соперника и тренера, который устроит вам поединок."),SetPlayerFightingStyle (playerid, FIGHT_STYLE_KUNGFU),Flood[playerid] = 4;
		}
	}
	if(newkeys == 65536)
	{
		if(KostiName[playerid] < 999)
		{
			new dice = random(6)+1;
			new dice1 = random(6)+1;
			format(YCMDstr,sizeof(YCMDstr), " %s и %s бросили кости. Результат: {CC9900}%i:%i",Name(KostiName[playerid]),Name(playerid),dice,dice1);
			ProxDetector(30.0, playerid,YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			if(dice > dice1)
			{
				PTEMP[KostiName[playerid]][pCash] += KostiMoney[playerid]/100*90;
				PTEMP[playerid][pCash] -= KostiMoney[playerid];
				BizzInfo[4][bTill] += KostiMoney[playerid]*2/100*5;
				format(YCMDstr, sizeof(YCMDstr), " Поздравляем, Вы выиграли! Вы получаете %d от суммы ставки",KostiMoney[playerid]/100*90);
				SCM(KostiName[playerid], COLOR_GREEN, YCMDstr);
				SCM(playerid, COLOR_ORANGE, " К сожалению, Вы проиграли!");
				format(YCMDstr, sizeof(YCMDstr), "~g~+%d$", KostiMoney[playerid]);
				GameTextForPlayer(KostiName[playerid], YCMDstr, 3000, 1);
				format(YCMDstr, sizeof(YCMDstr), "~r~-%d$", KostiMoney[playerid]);
				GameTextForPlayer(playerid, YCMDstr, 3000, 1);
				format(string,sizeof(string), "Выпало: %i",dice1);
				SetPlayerChatBubble(playerid,string,COLOR_ORANGE,30.0,10000);
				format(string,sizeof(string), "Выпало: %i",dice);
				SetPlayerChatBubble(KostiName[playerid],string,TEAM_GROVE_COLOR,30.0,10000);
				ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
				SetPlayerAttachedObject(playerid, 1, 1851, 1, 0.062400, 0.453750, 0.000000, 0.000000, 94.689310, 0.000000);
				ApplyAnimation(KostiName[playerid],"CARRY","crry_prtial",4.1,1,0,0,1,1);
				SetPlayerAttachedObject(KostiName[playerid], 1, 1851, 1, 0.062400, 0.453750, 0.000000, 0.000000, 94.689310, 0.000000);
				SetTimer("_DiceOff", 5000, 0);
				OpustitRuki[playerid] = 1;
				OpustitRuki[KostiName[playerid]] = 1;
				dicetime = gettime() + 5;
				ZapretDice[playerid] = 0;
				ZapretDice[KostiName[playerid]] = 0;
				KostiMoney[playerid] = 0;
				KostiName[playerid] = 999;
			}
			if(dice < dice1)
			{
				PTEMP[KostiName[playerid]][pCash] -= KostiMoney[playerid];
				PTEMP[playerid][pCash] += KostiMoney[playerid]/100*90;
				BizzInfo[4][bTill] += KostiMoney[playerid]*2/100*5;
				format(YCMDstr, sizeof(YCMDstr), " Поздравляем, Вы выиграли! Вы получаете %d от суммы ставки",KostiMoney[playerid]/100*90);
				SCM(playerid, COLOR_GREEN, YCMDstr);
				SCM(KostiName[playerid], COLOR_ORANGE, " К сожалению, Вы проиграли!");
				format(YCMDstr, sizeof(YCMDstr), "~g~+%d$", KostiMoney[playerid]);
				GameTextForPlayer(playerid, YCMDstr, 3000, 1);
				format(YCMDstr, sizeof(YCMDstr), "~r~-%d$", KostiMoney[playerid]);
				GameTextForPlayer(KostiName[playerid], YCMDstr, 3000, 1);
				format(string,sizeof(string), "Выпало: %i",dice1);
				SetPlayerChatBubble(playerid,string,TEAM_GROVE_COLOR,30.0,10000);
				format(string,sizeof(string), "Выпало: %i",dice);
				SetPlayerChatBubble(KostiName[playerid],string,COLOR_ORANGE,30.0,10000);
				ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
				SetPlayerAttachedObject(playerid, 1 , 1851, 1, 0.062397, 0.453746, 0.000000, 0.000000, 94.689308, 0.000000);
				ApplyAnimation(KostiName[playerid],"CARRY","crry_prtial",4.1,1,0,0,1,1);
				SetPlayerAttachedObject(KostiName[playerid], 1, 1851, 1, 0.062400, 0.453750, 0.000000, 0.000000, 94.689310, 0.000000);
				SetTimer("_DiceOff", 5000, 0);
				OpustitRuki[playerid] = 1;
				OpustitRuki[KostiName[playerid]] = 1;
				dicetime = gettime() + 5;
				ZapretDice[playerid] = 0;
				ZapretDice[KostiName[playerid]] = 0;
				KostiMoney[playerid] = 0;
				KostiName[playerid] = 999;
			}
			else if(dice == dice1)
			{
				SCM(playerid, COLOR_ORANGE, " Игра закончилась в ничью!");
				SCM(KostiName[playerid], COLOR_ORANGE, " Игра закончилась в ничью!");
				format(string,sizeof(string), "Выпало: %i",dice1);
				SetPlayerChatBubble(playerid,string,COLOR_LIGHTBLUE,30.0,10000);
				format(string,sizeof(string), "Выпало: %i",dice);
				SetPlayerChatBubble(KostiName[playerid],string,COLOR_LIGHTBLUE,30.0,10000);
				ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
				SetPlayerAttachedObject(playerid, 1 , 1851, 1, 0.062397, 0.453746, 0.000000, 0.000000, 94.689308, 0.000000);
				ApplyAnimation(KostiName[playerid],"CARRY","crry_prtial",4.1,1,0,0,1,1);
				SetPlayerAttachedObject(KostiName[playerid], 1, 1851, 1, 0.062400, 0.453750, 0.000000, 0.000000, 94.689310, 0.000000);
				SetTimer("_DiceOff", 5000, 0);
				OpustitRuki[playerid] = 1;
				OpustitRuki[KostiName[playerid]] = 1;
				dicetime = gettime() + 5;
				ZapretDice[playerid] = 0;
				ZapretDice[KostiName[playerid]] = 0;
				KostiMoney[playerid] = 0;
				KostiName[playerid] = 999;
			}
		}
		else
		{
			return true;
		}
		return true;
	}
	if(Works[playerid])
	{
		if(JobCP[playerid] == 2 && usemesh[playerid] == 1)
		{
			if(newkeys & KEY_JUMP || newkeys & KEY_FIRE || newkeys & KEY_SECONDARY_ATTACK)  // при нажатии выполняется действие
			{
				SCM(playerid, COLOR_LIGHTRED, " Вы уронили мешок");
				DisablePlayerCheckpoint(playerid);
				ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,1,0);
				mesh[playerid] = 0;
				usemesh[playerid] = 0;
				if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
				SetPlayerCheckpoint(playerid,2230.3528,-2286.1353,14.3751,1.5);
				JobCP[playerid] = 1;
			}
		}
	}
	if(GetPVarInt(playerid, "matovoz_rob"))
	{
		if(newkeys & KEY_JUMP || newkeys & KEY_FIRE || newkeys & KEY_SECONDARY_ATTACK)  // при нажатии выполняется действие
		{
			SCM(playerid, COLOR_LIGHTRED, " Вы уронили ящик");
			DisablePlayerCheckpoint(playerid);
			ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,1,0);
			if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
			DeletePVar(playerid, "matovoz_rob");
			MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad] += 250;
			format(string, sizeof(string), "Кол-во груза\n%i", MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad]);
        	UpdateDynamic3DTextLabelText(Rob3DText, 0xEDEA9FAA, string);
		}
	}
	if(newkeys == 131072)
	{
		if(KostiName[playerid] != 999)
		{
			KostiMoney[playerid] = 0;
			SendMes(playerid, COLOR_ORANGE, " Вы отказались играть в кости с %s",PTEMP[KostiName[playerid]][pName]);
			SendMes(KostiName[playerid], COLOR_ORANGE, " %s отказался играть с вами в кости",PTEMP[playerid][pName]);
			ZapretDice[playerid] = 0;
			ZapretDice[KostiName[playerid]] = 0;
			KostiMoney[playerid] = 0;
			KostiName[playerid] = 999;
		}
	}
	if(newkeys & KEY_SPRINT && Spectate[playerid])
	{
		PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
		if(ReconSelectSub[playerid] == INVALID_TEXT_DRAW) OnPlayerClickPlayerTextDraw(playerid, ReconPlayer[ReconSelect[playerid]]);
		else OnPlayerClickPlayerTextDraw(playerid, ReconPlayer[ReconSelectSub[playerid]]);
		return 1;
	}
	if(PRESSED(8))
	{
		if(avtocar[playerid] != 0 && GetNearestVehicle(playerid) == avtocar[playerid])
		{
			if(IsPlayerInAnyVehicle(playerid)) return 1;
			GetVehicleParamsEx(avtocar[playerid],engine,lights,alarm,doors,bonnet,boot,objective);
			if(doors == 0) return SCM(playerid,COLOR_GREY," Замок автомобиля уже открыт!");
			ApplyAnimation(playerid,"BD_FIRE","wash_up",4.1,1,1,1,1,0);
			timervzlom[playerid] = SetTimerEx("_Ugon", 20000, 0, "i", playerid);
			idcarv[playerid] = avtocar[playerid];
			nachalvzlom[playerid] = 1;
			SCM(playerid,COLOR_BLUE," Вы пытаетесь взломать замок автомобиля (( Не отпускайте клавишу 20 секунд )) ");
		}
	}
	else if (RELEASED(8))
	{
		if(IsPlayerInAnyVehicle(playerid)) return 1;
		if(nachalvzlom[playerid] == 0) return 1;
		idcarv[playerid] = 0;
		KillTimer(timervzlom[playerid]);
		ClearAnimations(playerid);
		nachalvzlom[playerid] = 0;
	}
	if(newkeys == KEY_CROUCH)
	{
		if(PlayerToPoint(3.0,playerid,-2438.7942,524.3234,29.6306))
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -2501.9170,524.2781,491.5463);
				SetPlayerPos(tmpcar, -2501.9170,524.2781,491.5463);
				SetVehicleZAngle(tmpcar, 273.4404);
				TelePos[playerid][0] = 0.0;
				TelePos[playerid][1] = 0.0;
			}
		}
		else if(PlayerToPoint(3.0,playerid,-2500.6748,534.4558,491.7077))
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, -2443.1113,524.0466,29.6310);
			SetPlayerPos(tmpcar, -2443.1113,524.0466,29.6310);
			SetVehicleZAngle(tmpcar, 180.2442);
			TelePos[playerid][0] = 0.0;
			TelePos[playerid][1] = 0.0;
		}
		else if(IsPlayerNearGarage(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInVehicle(playerid, house_car[playerid]))
		{
			CallLocalFunction("OnPlayerCommandText", "is", playerid, "/enterg");
		}
	}
	if(newkeys & 16)
	{
		if(SERIU[playerid][sID] != INVALID_PLAYER_ID)
		{
			SelectTextDraw(playerid, 0xFF9933FF);
		}
	}
	if(newkeys == 4 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerWeapon(playerid) == 17)
	{
	    new Float:fX, Float:fY, Float:fZ;
	    GetPlayerPos(playerid, fX, fY, fZ);
		if((PTEMP[playerid][pMember] == 2 || PTEMP[playerid][pLeader] == 2) && GetPVarInt(playerid, "Fraction_Duty") == 1)
  		{
		    foreach(i)
		    {
	            if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 10.0, fX, fY, fZ) && (!IsACop(i) || GetPVarInt(i, "Fraction_Duty") == 0))
	            {
					PlayerCuffed[playerid] = 1;
 					PlayerCuffedTime[playerid] = 10;
 					GameTextForPlayer(i,"~r~freeze", 5000, 3);
					ApplyAnimation(i, "ped", "gas_cwr", 4.1, 0, 1, 1, 1, 0, 1);
					TogglePlayerControllable(i, false);
					SetTimerEx("_UnFreeze" , 10000, false, "i", i);
					//GameTextForPlayer(i,"~g~unfreeze", 10000, 3);
					SetCameraBehindPlayer(i);
	            }
		    }
	    }
	}
	if(newkeys == 1024)
	{
		if(/*IsAtFishPlace(playerid) > 0 && */GetPVarInt(playerid,"fish_began"))
		{
			switch(GetPVarInt(playerid,"fish_ready"))
			{
			case 0:
				{
					if(Flood[playerid]) return true;
					if(!GetPVarInt(playerid,"fish_gear")) return SCM(playerid,0x81DA99AA,"У вас нет снастей");
					else
					{
						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 6.1, 0, 0, 0, 0, 0,1);
						SCM(playerid,0x81DA99AA,"Вы оснастили удочку");
						SetPVarInt(playerid,"fish_gear",GetPVarInt(playerid,"fish_gear")-1);
						SetPVarInt(playerid,"fish_ready",1);
						UpdateFish(playerid);
						Flood[playerid] = 1;
					}
				}
			case 1:
				{
					if(Flood[playerid]) return true;
					if(!GetPVarInt(playerid,"fish_worms")) return SCM(playerid,0x81DA99AA,"У вас нет червей");
					else
					{
						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 6.1, 0, 0, 0, 0, 0,1);
						SCM(playerid,0x81DA99AA,"Вы наживили червя");
						SetPVarInt(playerid,"fish_worms",GetPVarInt(playerid,"fish_worms")-1);
						SetPVarInt(playerid,"fish_ready",2);
						UpdateFish(playerid);
						Flood[playerid] = 1;
					}
				}
			case 2:
				{
					if(Flood[playerid]) return true;
					SetPVarInt(playerid,"fish_time", gettime() + 3);
					ApplyAnimation(playerid,"SWORD","sword_IDLE",50.0,0,1,1,1,1);
					SetPVarInt(playerid,"fish_ready",3);
					SetPVarInt(playerid,"fish_chanse",99);
					SCM(playerid,0x81DA99AA,"Вы закинули удочку. Следите за поплавком, когда он опустится - подсекайте");
					GameTextForPlayer(playerid,"~b~!",4000,6);
					UpdateFish(playerid);
					Flood[playerid] = 1;
				}
			case 3:
				{
					new kg, info = random(10);
					if(GetPVarInt(playerid,"fish_chanse") < 3)
					{
						ClearAnimations(playerid);
						DeletePVar(playerid,"fish_chanse");
						SetPVarInt(playerid,"fish_ready",1);
						ApplyAnimation(playerid,"SWORD","sword_part",50.0,0,0,0,0,0);
						if(info == 1) return SCM(playerid,0x81DA99AA,"Рыба сорвалась");
						switch(GetPVarInt(playerid,"fish_chanse"))
						{
						case 0:
							{
								ApplyAnimation(playerid,"SWORD","sword_part",50.0,0,0,0,0,0);
								kg = 0;
								GameTextForPlayer(playerid,"~g~~n~!", 100, 6);
							}
						case 1:
							{
								ApplyAnimation(playerid,"SWORD","sword_part",50.0,0,0,0,0,0);
								if(info == 2) return SCM(playerid,0x81DA99AA,"Рыба сорвалась и оборвала снасти"), SetPVarInt(playerid,"fish_ready",0);
								kg = 10;
								GameTextForPlayer(playerid,"~n~~n~~y~!", 100, 6);
							}
						case 2:
							{
								ApplyAnimation(playerid,"SWORD","sword_part",50.0,0,0,0,0,0);
								if(info == 2) return SCM(playerid,0x81DA99AA,"Рыба сорвалась и оборвала снасти"), SetPVarInt(playerid,"fish_ready",0);
								kg = 20;
								GameTextForPlayer(playerid,"~n~~n~~r~~n~!", 100, 6);
							}
						}
						ApplyAnimation(playerid,"SWORD","sword_part",50.0,0,0,0,0,0);
						format(YCMDstr,24,"%i.%i",random(40)+kg,random(99));
						new Float:kg_ = floatstr(YCMDstr);
						SendMes(playerid,0x81DA99AA," Вы поймали %s весом %.2f кг",FishNames[random(18)],kg_);
						PTEMP[playerid][pFishes]+=kg_;
						Sonar[IsAtFishPlace(playerid)]-=kg_;
						if(Sonar[IsAtFishPlace(playerid)] < 0) Sonar[IsAtFishPlace(playerid)] = 0;
						UpdateFish(playerid);
						if(PTEMP[playerid][pFishLic] < 1 && PTEMP[playerid][pWantedLevel] < 6)
						{
							PTEMP[playerid][pWantedLevel] += 1;
							PTEMP[playerid][pZakonp] -= 1;
							SetPlayerWantedLevel(playerid,PTEMP[playerid][pWantedLevel]);
							SetPlayerCriminal(playerid,"Неизвестный", "Нелегальная рыбалка");
						}
					}
					else if(!Flood[playerid]) SCM(playerid,0x81DA99AA,"Вы ничего не поймали");ApplyAnimation(playerid,"SWORD","sword_part",50.0,0,0,0,0,0);
				}
			}
		}
	}
	if(newkeys == 1024)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3,2283.0381,-1137.9327,1050.8984)) return ShowPlayerDialogEx(playerid, 8003, 2, "Меню квартиры","Купить комнату\nПродать комнату\nКвартплата\nДверной замок\nАптечка\nСменить интерьер\nИнформация","Выбор","Закрыть");
		else if(IsPlayerInRangeOfPoint(playerid, 3,54.8790,-79.7394,1004.2859)) return ShowPlayerDialogEx(playerid, 8003, 2, "Меню квартиры","Купить комнату\nПродать комнату\nКвартплата\nДверной замок\nАптечка\nСменить интерьер\nИнформация","Выбор","Закрыть");
		else if(IsPlayerInRangeOfPoint(playerid, 3,34.9120,-81.2602,1004.2859)) return ShowPlayerDialogEx(playerid, 8003, 2, "Меню квартиры","Купить комнату\nПродать комнату\nКвартплата\nДверной замок\nАптечка\nСменить интерьер\nИнформация","Выбор","Закрыть");
		else
		{
			for(new i = 1; i <= TotalHouse; i++)
			{
				if(!PlayerToPoint(3, playerid,HouseInfo[i][hExitx], HouseInfo[i][hExity], HouseInfo[i][hExitz])) continue;
				ShowPlayerDialogEx(playerid, 6700, 2, "Меню дома","Купить дом\nПродать дом\nДверной замок\nАптечка\nСменить интерьер\nИнформация","Готово","Отмена");
				break;
			}
		}
	}
	if(newkeys == 4)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			CallLocalFunction("OnPlayerCommandText", "is", playerid, "/lights");
		}
	}
	if(newkeys == KEY_SECONDARY_ATTACK)
	{
		CallLocalFunction("OnPlayerCommandText", "is", playerid, "/exit");
		for(new i = 1; i <= ALLKVARTIRI; i++)
		{
			new x = GetPlayerVirtualWorld(playerid);
			if(IsPlayerInRangeOfPoint(playerid, 2, kvartinfo[i][pXpic],kvartinfo[i][pYpic],kvartinfo[i][pZpic]) && kvartinfo[i][kworld] == GetPlayerVirtualWorld(playerid))
			{
				KGet(playerid);
				if(kvartinfo[i][lock]   ==  1 && PTEMP[playerid][pKvartiraKey] != i)return SCM(playerid, COLOR_GRAD1, "Квартира закрыта. У вас нет ключей");
				if(kvartinfo[i][kInt] == 0)
				{
					SetPlayerPos(playerid,2283.3474,-1139.2313,1050.8984);
					SetPlayerInterior(playerid,11);
					SetPlayerVirtualWorld(playerid, i);
					return true;
				}
				else if(kvartinfo[i][kInt] == 1)
				{
					SetPlayerPos(playerid,31.3584,-84.8000,1004.2859);
					SetPlayerInterior(playerid,15);
					SetPlayerVirtualWorld(playerid, i);
					return true;
				}
				else if(kvartinfo[i][kInt] == 2)
				{
					SetPlayerPos(playerid,58.2073,-79.1497,1004.2859);
					SetPlayerInterior(playerid,15);
					SetPlayerVirtualWorld(playerid, i);
					return true;
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3, 2283.3474,-1139.2313,1050.8984) && kvartinfo[x][kCena] == 100000)
			{
				SetPlayerPos(playerid,    kvartinfo[x][pXpic],kvartinfo[x][pYpic],kvartinfo[x][pZpic]);
				SetPlayerInterior(playerid,15);
				SetPlayerVirtualWorld(playerid, kvartinfo[x][kworld]);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3, 2283.3474,-1139.2313,1050.8984) && kvartinfo[x][kCena] != 100000)
			{
				SetPlayerPos(playerid,    kvartinfo[x][pXpic],kvartinfo[x][pYpic],kvartinfo[x][pZpic]);
				SetPlayerInterior(playerid,1);
				SetPlayerVirtualWorld(playerid, kvartinfo[x][kworld]);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3, 34.9105,-81.2279,1004.2859) && kvartinfo[x][kCena] == 100000)
			{
				SetPlayerPos(playerid,    kvartinfo[x][pXpic],kvartinfo[x][pYpic],kvartinfo[x][pZpic]);
				SetPlayerInterior(playerid,15);
				SetPlayerVirtualWorld(playerid, kvartinfo[x][kworld]);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3, 34.9105,-81.2279,1004.2859) && kvartinfo[x][kCena] != 100000)
			{
				SetPlayerPos(playerid,    kvartinfo[x][pXpic],kvartinfo[x][pYpic],kvartinfo[x][pZpic]);
				SetPlayerInterior(playerid,1);
				SetPlayerVirtualWorld(playerid, kvartinfo[x][kworld]);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3, 54.8791,-79.6500,1004.2859) && kvartinfo[x][kCena] == 100000)
			{
				SetPlayerPos(playerid,    kvartinfo[x][pXpic],kvartinfo[x][pYpic],kvartinfo[x][pZpic]);
				SetPlayerInterior(playerid,15);
				SetPlayerVirtualWorld(playerid, kvartinfo[x][kworld]);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3, 54.8791,-79.6500,1004.2859) && kvartinfo[x][kCena] != 100000)
			{
				SetPlayerPos(playerid,    kvartinfo[x][pXpic],kvartinfo[x][pYpic],kvartinfo[x][pZpic]);
				SetPlayerInterior(playerid,1);
				SetPlayerVirtualWorld(playerid, kvartinfo[x][kworld]);
				return true;
			}
		}
	}
	if(newkeys == KEY_SPRINT)
	{
		if(GetPVarInt(playerid,"RStol") && !GetPVarInt(playerid,"RStavka") && !RouletPlay[GetPVarInt(playerid,"RStol")]) {
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1,5,12: ShowPlayerDialogEx(playerid,5576,DIALOG_STYLE_INPUT,"Ставка","Минимальная ставка: 500 вирт\nМаксимальняа ставка: 5000 вирт\nВведите сумму:","Играть","Закрыть");
			case 2,7,10: ShowPlayerDialogEx(playerid,5576,DIALOG_STYLE_INPUT,"Ставка","Минимальная ставка: 2000 вирт\nМаксимальняа ставка: 20000 вирт\nВведите сумму:","Играть","Закрыть");
			case 3,8,11: ShowPlayerDialogEx(playerid,5576,DIALOG_STYLE_INPUT,"Ставка","Минимальная ставка: 5000 вирт\nМаксимальняа ставка: 50000 вирт\nВведите сумму:","Играть","Закрыть");
			case 4,6,9: ShowPlayerDialogEx(playerid,5576,DIALOG_STYLE_INPUT,"Ставка","Минимальная ставка: 10000 вирт\nМаксимальняа ставка: 100000 вирт\nВведите сумму:","Играть","Закрыть");
			} }
	}
	if(newkeys == 16)
	{
		if(GetRoulet(playerid))
		{
			if(GetPVarInt(playerid,"RStol")) return ShowPlayerDialogEx(playerid,5490,DIALOG_STYLE_MSGBOX,"Рулетка: Выход","Вы действительно хотите выйти из-за стола?","Выход","Отмена");
			if(GetPVarInt(playerid,"CasinoRank") > 0) return SCM(playerid,COLOR_GREY," Крупье не может играть!");
			new null = 0;
			foreach(i) if(GetPVarInt(i,"RStol") == GetRoulet(playerid)) null++;
			if(null > 4) return SCM(playerid,COLOR_GREY," За этим столом нет свободных мест!");
			switch(GetRoulet(playerid))
			{
			case 1: SetPVarFloat(playerid,"RX",1962.96), SetPVarFloat(playerid,"RY",1026.88), SetPVarFloat(playerid,"RZ",992.33);
			case 2: SetPVarFloat(playerid,"RX",1958.36), SetPVarFloat(playerid,"RY",1026.88), SetPVarFloat(playerid,"RZ",992.33);
			case 3: SetPVarFloat(playerid,"RX",1958.36), SetPVarFloat(playerid,"RY",1008.88), SetPVarFloat(playerid,"RZ",992.33);
			case 4: SetPVarFloat(playerid,"RX",1962.96), SetPVarFloat(playerid,"RY",1008.88), SetPVarFloat(playerid,"RZ",992.33);

			case 5: SetPVarFloat(playerid,"RX",2230.31), SetPVarFloat(playerid,"RY",1619.56), SetPVarFloat(playerid,"RZ",1006.06);
			case 6: SetPVarFloat(playerid,"RX",2241.89), SetPVarFloat(playerid,"RY",1619.56), SetPVarFloat(playerid,"RZ",1006.06);
			case 7: SetPVarFloat(playerid,"RX",2230.31), SetPVarFloat(playerid,"RY",1613.56), SetPVarFloat(playerid,"RZ",1006.06);
			case 8: SetPVarFloat(playerid,"RX",2241.89), SetPVarFloat(playerid,"RY",1613.56), SetPVarFloat(playerid,"RZ",1006.06);

			case 9: SetPVarFloat(playerid,"RX",2230.31), SetPVarFloat(playerid,"RY",1594.56), SetPVarFloat(playerid,"RZ",1006.06);
			case 10: SetPVarFloat(playerid,"RX",2241.89), SetPVarFloat(playerid,"RY",1594.56), SetPVarFloat(playerid,"RZ",1006.06);
			case 11: SetPVarFloat(playerid,"RX",2230.31), SetPVarFloat(playerid,"RY",1588.56), SetPVarFloat(playerid,"RZ",1006.06);
			case 12: SetPVarFloat(playerid,"RX",2241.89), SetPVarFloat(playerid,"RY",1588.56), SetPVarFloat(playerid,"RZ",1006.06);
			}
			new Float:pos[6];
			GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
			SetPVarInt(playerid,"RStavka",0);
			SetPVarInt(playerid,"RStol",GetRoulet(playerid));
			SetPVarFloat(playerid,"RXONE",GetPVarFloat(playerid,"RX"));
			SetPVarFloat(playerid,"RYONE",GetPVarFloat(playerid,"RY"));
			SetPVarFloat(playerid,"RZONE",GetPVarFloat(playerid,"RZ"));
			SetPVarFloat(playerid,"RNumber",0);
			new obj = CreateObject(random(5) + 1912,GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"),0.00,0.00,0.00);
			SetPVarInt(playerid,"RObj",obj);
			GetObjectPos(obj, pos[3], pos[4], pos[5]);
			SetPlayerCameraPos(playerid,pos[0],pos[1],pos[2]+0.8);
			SetPlayerCameraLookAt(playerid,pos[3],pos[4],pos[5]);
			SCM(playerid,0xc175ffaa," Игра начата. Сделайте ставку");
			TogglePlayerControllableEx(playerid, 0);
			PlayerTextDrawShow(playerid,RouletText[playerid]);
			return PlayerTextDrawSetString(playerid,RouletText[playerid],"~<~~>~~up~~down~~n~~g~Money: none~n~~y~Bet: none");
		}
		else if(IsPlayerNearBone(playerid) != -1)
		{
			new null = -1;
			for(new i = 0; i != 5; i++) if(BoneInfo[IsPlayerNearBone(playerid)][Gamer][i] == INVALID_PLAYER_ID) { null = i; break; }
			if(GetPVarInt(playerid,"CasinoRank") && BoneInfo[IsPlayerNearBone(playerid)][Crupie] != INVALID_PLAYER_ID) return SCM(playerid,COLOR_GREY," Тут уже работает крупье!");
			if(GetPVarInt(playerid,"BoneStol")) return SCM(playerid,COLOR_GREY," Ты уже зарегистрирован на другом столе!");
			if(null == -1 && !GetPVarInt(playerid,"CasinoRank")) return SCM(playerid,COLOR_GREY," За этим столом нет свободных мест!");
			if(!GetPVarInt(playerid,"CasinoRank")) BoneInfo[IsPlayerNearBone(playerid)][Gamer][null] = playerid;
			else BoneInfo[IsPlayerNearBone(playerid)][Crupie] = playerid;
			for(new i; i != 4; i++) TextDrawShowForPlayer(playerid,Bone[i]), PlayerTextDrawShow(playerid,PlayerBone[playerid][i]);
			SetPVarInt(playerid,"BoneStol",IsPlayerNearBone(playerid)+1);
			SelectTextDraw(playerid,0x33AAFFFF);
			return UpdateBone(IsPlayerNearBone(playerid));
		}
	}
	if( (newkeys & KEY_FIRE) || ( (newkeys & KEY_AIM) && (oldkeys & KEY_AIM) && (newkeys & KEY_SECONDARY_ATTACK) ) )
	{
		if(IsAArm(playerid) || IsACop(playerid) || IsAMayor(playerid) || PTEMP[playerid][pAdmin] > 1) return true;
		if(!IsAAntidm(playerid)) return true;
		if(IsPlayerInAnyVehicle(playerid)) return true;
		ApplyAnimation(playerid,"PED","IDLE_tired",4.1,0,1,1,0,7000,1);
	}
	if (newkeys == KEY_CROUCH)
	{
		if(GetPlayerState(playerid) != 2) return true;
		if(PlayerToPoint(8.0,playerid,-2074.50000000,-94.90000153,35.00000000))
		{
			CallLocalFunction("OnPlayerCommandText", "is", playerid, "/instopen");
		}
		else if(PlayerToPoint(10.0,playerid,2203.7639160156,-2252.0620117188,13.5))
		{
			CallLocalFunction("OnPlayerCommandText", "is", playerid, "/prodopen");
		}
	}
	if(newkeys == KEY_CROUCH)
	{
		if(PTEMP[playerid][pMember] == 19 || PTEMP[playerid][pLeader] == 19 || proverkaforma[playerid] == 1)
		{
			if(IsPlayerConnected(playerid))
			{
				if(PlayerToPoint(8.0,playerid,290.2172,1822.6295,17.6406))
				{
					if (GetPlayerState(playerid) == 2)
					{
						if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 416 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 433)
						{
							SCM(playerid,COLOR_GREY, "Попробуйте в объезд!");
							return true;
						}
						new tmpcar = GetPlayerVehicleID(playerid);
						SetVehiclePos(tmpcar, 282.0428, 1822.5503, 17.6406);
						PTEMP[ playerid ][ pPos_x ] = 282.0428;
						PTEMP[ playerid ][ pPos_y ] = 1822.5503;
						PTEMP[ playerid ][ pPos_z ] = 17.6406;
						SetPVarInt(playerid, "AntiBreik", 2);
						TelePos[playerid][0] = 0.0;
						TelePos[playerid][1] = 0.0;
					}
				}
				else if(PlayerToPoint(8.0,playerid,282.0428,1822.5503,17.6406))
				{
					if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 416 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 433)
					{
						SCM(playerid,COLOR_GREY, "Попробуйте в объезд!");
						return true;
					}
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 290.2172,1822.6295,17.6406);
					PTEMP[ playerid ][ pPos_x ] = 290.2172;
					PTEMP[ playerid ][ pPos_y ] = 1822.6295;
					PTEMP[ playerid ][ pPos_z ] = 17.6406;
					SetPVarInt(playerid, "AntiBreik", 2);
					TelePos[playerid][0] = 0.0;
					TelePos[playerid][1] = 0.0;
					return true;
				}
			}
		}
	}
	if(newkeys & KEY_HANDBRAKE && newkeys & KEY_SECONDARY_ATTACK )
	{
		if(IsAMafia(playerid))
		{
			new giveplayerid;
			if(GetPlayerState(playerid)!=PLAYER_STATE_ONFOOT) return true;
			if(GetPlayerState(giveplayerid)!=PLAYER_STATE_ONFOOT) return true;
			giveplayerid= GetClosestforeach(playerid);
			new Float:health;
			GetPlayerHealth(giveplayerid,health);
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(PTEMP[playerid][pMember] == 6)
				{
					if(KrishaOffer[giveplayerid] < 999)
					{
						if(health <= 25 && PTEMP[giveplayerid][pJob] != 0)
						{
							SCM(playerid,COLOR_GREEN, " Вы избили должника до 25 хп, крыша была автоматически установлена!");
							PTEMP[giveplayerid][pKrisha] = 6;
							KrishaOffer[giveplayerid] = 999;
							return true;
						}
					}
				}
			}
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(PTEMP[playerid][pMember] == 5)
				{
					if(KrishaOffer[giveplayerid] < 999)
					{
						if(health <= 25 && PTEMP[giveplayerid][pJob] != 0)
						{
							SCM(playerid,COLOR_GREEN, " Вы избили должника до 25 хп, крыша была автоматически установлена!");
							PTEMP[giveplayerid][pKrisha] = 5;
							KrishaOffer[giveplayerid] = 999;
							return true;
						}
					}
				}
			}
			if(PTEMP[playerid][pMember] == 14)
			{
				if(KrishaOffer[giveplayerid] < 999)
				{
					if(health <= 25 && PTEMP[giveplayerid][pJob] != 0)
					{
						SCM(playerid,COLOR_GREEN, " Вы избили должника до 25 хп, крыша была автоматически установлена!");
						PTEMP[giveplayerid][pKrisha] = 14;
						KrishaOffer[giveplayerid] = 999;
						return true;
					}
				}
			}
		}
	}
	if(newkeys & KEY_HANDBRAKE  && newkeys & KEY_SECONDARY_ATTACK )
	{
		if(IsAMafia(playerid))
		{
			new giveplayerid;
			if(GetPlayerState(playerid)!=PLAYER_STATE_ONFOOT) return true;
			if(GetPlayerState(giveplayerid)!=PLAYER_STATE_ONFOOT) return true;
			giveplayerid= GetClosestforeach(playerid);
			new Float:health;
			GetPlayerHealth(giveplayerid,health);
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(PTEMP[giveplayerid][pKrisha] ==6)
				{
					if(health <= 25 && PTEMP[giveplayerid][pUseKrisha] !=0)
					{
						if(PTEMP[giveplayerid][pDolg] < 50) return SCM(playerid,COLOR_GREY, " Он/Она еще ни чего не заработал(а)!");
						SCM(playerid,COLOR_GREEN, " Вы избили должника до 25 хп, долг был выбит");
						MafiaBank[0][nYakuza]+=PTEMP[giveplayerid][pDolg];
						PTEMP[giveplayerid][pDolg] = 0;
						PTEMP[giveplayerid][pUseKrisha] =0;
						return true;
					}
				}
			}
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(PTEMP[giveplayerid][pKrisha] ==5)
				{
					if(health <= 25 && PTEMP[giveplayerid][pUseKrisha] !=0)
					{
						if(PTEMP[giveplayerid][pDolg] < 50) return SCM(playerid,COLOR_GREY, " Он/Она еще ни чего не заработал(а)!");
						SCM(playerid,COLOR_GREEN, " Вы избили должника до 25 хп, долг был выбит");
						MafiaBank[0][nLcn]+=PTEMP[giveplayerid][pDolg];
						PTEMP[giveplayerid][pDolg] = 0;
						PTEMP[giveplayerid][pUseKrisha] =0;
						return true;
					}
				}
			}
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(PTEMP[giveplayerid][pKrisha] ==14)
				{
					if(health <= 25 && PTEMP[giveplayerid][pUseKrisha] !=0)
					{
						if(PTEMP[giveplayerid][pDolg] < 50) return SCM(playerid,COLOR_GREY, " Он/Она еще ни чего не заработал(а)!");
						SCM(playerid,COLOR_GREEN, " Вы избили должника до 25 хп, долг был выбит");
						MafiaBank[0][nRm]+=PTEMP[giveplayerid][pDolg];
						PTEMP[giveplayerid][pDolg] = 0;
						PTEMP[giveplayerid][pUseKrisha] =0;
						return true;
					}
				}
			}
		}
	}
	if(newkeys & KEY_SPRINT && newkeys & KEY_JUMP && GetPlayerState(playerid) != 2) ClearAnimations(playerid), ApplyAnimation(playerid,"PED","getup_front",4.0,0,0,0,0,0);
	if((newkeys & KEY_SUBMISSION && !(oldkeys & KEY_SUBMISSION)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(IsPlayerInGarage(playerid)) return MovePlayerFromGarage(playerid); // Телепорт игрока из гараж вместе с машиной
		CallLocalFunction("OnPlayerCommandText", "is", playerid, "/en");
	}
	if((newkeys & 1 && !(oldkeys & 1)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) CallLocalFunction("OnPlayerCommandText", "is", playerid, "/slimit");
	if(newkeys == 16)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			CallLocalFunction("OnPlayerCommandText", "is", playerid, "/atm");
		}
	}
	if(newkeys == 16)
	{
		if(IsAFoods(playerid))
		{
			ClearAnimations(playerid, 1);
			SCM(playerid,0x9f0000aa, " Автомат сломан");
			return true;
		}
	}
	return true;
}