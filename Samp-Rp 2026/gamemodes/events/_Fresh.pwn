publics:_Fresh()
{
    //print("--> _Fresh()");

	if (players > 1000) return SendRconCommand("exit");
	new hour, minute, second;
	gettime(hour, minute, second);
	FixHour(hour);
	hour = shifthour;
	for (new i = GetVehiclePoolSize(); i >= 0; i--)
	{
		if(!GetVehicleModel(i)) continue;
		new Float:health;
		GetVehicleHealth(i, health);
		if (health != 1000 && health < CarHealth[i]) CarHealth[i] = health;
		if (CarHealth[i] < health && CarHealth[i] != 0 && !TimeHealth[i]) SetVehHealth(i,CarHealth[i]);
		if (TimeHealth[i]) TimeHealth[i]--;
	}
	for (new i; i < MAX_BONE; i++)
	{
		if (BoneInfo[i][GameStart] > 0)
		{
			BoneInfo[i][GameStart] --;
			foreach(g)
			{
				if (GetPVarInt(g,"BoneStol")-1 == i && (GetPVarInt(g,"BoneStol_") || BoneInfo[i][Crupie] == g))
				{
					if (BoneInfo[i][GameStart] == 0 && GetPVarInt(g,"BoneStol_") == 1) SetPVarInt(g,"BoneStol_",random(11) + 2), UpdateBone(i);
					else if (BoneInfo[i][GameStart] > 0)
					{
						format(YCMDstr,18,"~g~%i",BoneInfo[i][GameStart]);
						GameTextForPlayer(g,YCMDstr,1200,6);
					}
				}
			}
			if (BoneInfo[i][GameStart] == 0) return ShowItog(i);
		}
	}
	if (random(5) == 1) {
		for (new i = 1; i <= TOTALATM; i++)
		{
			if (!LABELATM_) UpdateDynamic3DTextLabelText(LABELATM[i],COLOR_LIGHTBLUE,"Введите: \"/ATM\"");
			else UpdateDynamic3DTextLabelText(LABELATM[i],0x00D900FF,"Нажмите: \"ENTER\"");
		}
		if (!LABELATM_) LABELATM_ = true;
		else LABELATM_ = false; }
	foreach(i)
	{
		if (!PTEMP[i][pLogin])
		{
			if (GetPVarInt(i,"time_logged") > 0)
			{
				SetPVarInt(i,"time_logged",GetPVarInt(i,"time_logged")-1);
				if (GetPVarInt(i,"time_logged") == 0)
				{
					SCM(i, COLOR_LIGHTRED," Время на ввод пароля ограничено!");
					ShowPlayerDialogEx(i, -1, 0, "f", "f", "f", "");
					Kick(i);
				}
			}
		}
		else
		{
			if (GetPVarInt(i,"h_stall") && !IsPlayerInRangeOfPoint(i, 5, StallInfo[GetPVarInt(i,"h_stall")][stPos][0], StallInfo[GetPVarInt(i,"h_stall")][stPos][1], StallInfo[GetPVarInt(i,"h_stall")][stPos][2]))
			{
				UpdateDynamic3DTextLabelText(StallInfo[GetPVarInt(i,"h_stall")][stText], 0xFF8C37FF,"Не работает");
				DeletePVar(i,"h_stall");
				SetPlayerSkin(i,PTEMP[i][pChar][0]);
			}
			if (PTEMP[i][pNarcoLomka] > 0) { new ttt = random(2); if(ttt == 1) { ApplyAnimation(i, "CRACK", "crckdeth1", 4.0, 0, 0, 1, 1, 1); } else { ApplyAnimation(i, "CRACK", "crckdeth3", 4.0, 0, 0, 1, 1, 1); } }
			onCheckAirBrk(i);
			if (Spectate[i] && SpecAd[i] != INVALID_PLAYER_ID)
			{
				//***********************************************
				new thewarns = 0;
				new sid = SpecAd[i];
				if (PTEMP[sid][pWarns] == 0) thewarns = 0;
				if (PTEMP[sid][pWarns] != 0 && PTEMP[sid][pWarns] != 0) thewarns = thewarns-PTEMP[sid][pWarns];
				if (PTEMP[sid][pWarns] != 0 && PTEMP[sid][pWarns] == 0) thewarns = PTEMP[sid][pWarns];
				new tttgtg;
				tttgtg = GetPlayerAmmo(SpecAd[i]);
				//EngineStatus(GetPlayerVehicleID(SpecAd[i])
				//new sobtest[20];
				//format(sobtest,sizeof(sobtest),"~n~%s / %s",(ACCCheck[SpecAd[i]] == 10 ? ("On"):("Off")),(PTEMP[SpecAd[i]][Rassa] == 16 ? ("On"):("Off")));
				new Float:health;
				GetVehicleHealth(GetPlayerVehicleID(SpecAd[i]),health);
				new Float:hppp;
				new Float:aermor;
				GetPlayerArmour(SpecAd[i],aermor);
				GetPlayerHealth(SpecAd[i],hppp);
				//			new afktext[7];

				new Float:onepercent = NumberShot[SpecAd[i]]/100;
				new percentshot = floatround(onepercent)*NumberShotTarget[SpecAd[i]];

				new Float:tonepercent = TimeNumberShot[SpecAd[i]]/100;
				new tpercentshot = floatround(tonepercent)*TimeNumberShotTarget[SpecAd[i]];
				new sname[MAX_PLAYER_NAME], httpquery[250];
				GetPlayerName(SpecAd[i], sname, sizeof(sname));
				if (GetPVarInt(SpecAd[i], "AFK_Time") > 2)
				{
					format(httpquery, sizeof(httpquery), "%s~n~ID: %i  ~r~AFK",sname,SpecAd[i]);
					PlayerTextDrawSetString(i, ReconPlayer[6],httpquery);
				}
				else
				{
					format(httpquery, sizeof(httpquery), "%s~n~ID: %i",sname,SpecAd[i]);
					PlayerTextDrawSetString(i, ReconPlayer[6],httpquery);
				}
				/*new sobtest[20];
				format(sobtest,sizeof(sobtest),"~n~%s / %s",(ACCCheck[SpecAd[i]] == 10 ? ("On"):("Off")),(PTEMP[SpecAd[i]][Rassa] == 16 ? ("On"):("Off")));*/
				new e_status[25];
				if (GetPlayerState(SpecAd[i]) == PLAYER_STATE_DRIVER) GetVehicleParamsEx(GetPlayerVehicleID(SpecAd[i]), engine, lights, alarm, doors, bonnet, boot, objective);
				if (GetPlayerState(SpecAd[i]) != PLAYER_STATE_DRIVER) e_status = "-";
				else if (engine) e_status = "On";
				else e_status = "Off";
				new maxspeed = 0;
				if (IsPlayerInAnyVehicle(SpecAd[i])) maxspeed = MaxSpeedCar[GetVehicleModel(GetPlayerVehicleID(SpecAd[i]))-400];
				//format(sobtest,sizeof(sobtest),"~n~%s / %s",(ACCCheck[SpecAd[i]] == 10 ? ("On"):("Off")),(PTEMP[SpecAd[i]][Rassa] == 16 ? ("On"):("Off")));
				format(httpquery, sizeof(httpquery), "~n~%i : %i / %i~n~%i~n~%.0f~n~%.0f~n~%.0f~n~%i / %i~n~%i~n~%i : %i~n~%i / %i : %i%%~n~%i / %i : %i%%~n~%i : %i~n~%s",
				PTEMP[SpecAd[i]][pLevel], PTEMP[SpecAd[i]][pExp], (PTEMP[SpecAd[i]][pLevel]+1)*4, thewarns, aermor,hppp,health,SpeedVehicle(SpecAd[i]), maxspeed,GetPlayerPing(SpecAd[i]),tttgtg,Weapons[SpecAd[i]][GetPlayerWeapon(SpecAd[i])],NumberShot[SpecAd[i]],NumberShotTarget[SpecAd[i]],percentshot,TimeNumberShot[SpecAd[i]],TimeNumberShotTarget[SpecAd[i]],tpercentshot,GetPVarInt(SpecAd[i], "AFK_Time"), 1000, e_status);
				PlayerTextDrawSetString(i, ReconPlayer[5],httpquery);
				//format(strr1, sizeof(strr1), "%s~n~(%i)  %s~n~~n~~r~]Armour: ~w~%.0f~n~~g~]Hp: ~w~%.0f~n~~g~]CarHp: ~w~%.0f~n~~r~]Money: ~w~%i~n~~b~]Ammo: ~w~%i~n~~p~]Warns: ~w~%i~n~~y~]Ping: ~w~%i~n~~b~]Speed: ~w~%i",getName(SpecAd[i]),SpecAd[i],afktext,aermor,hppp,health,PTEMP[SpecAd[i]][Cash],tttgtg,thewarns,GetPlayerPing(SpecAd[i]),SpeedVehicle(SpecAd[i]));
				//PlayerTextDrawSetString(i, NikPlayer,strr1);
			}
			if (GetPVarInt(i, "w_time") < gettime() && GetPVarInt(i,"w_id") && !GetPVarInt(i,"InWorkshop"))
			{
				new x = GetPVarInt(i,"w_id");
				for (new x_ = 0; x_ < 9; x_++)
				{
					WorkshopList[x_][x][wlID] = WorkshopList[x_+1][x][wlID];
					strmid(WorkshopList[x_][x][wlName],WorkshopList[x_+1][x][wlName],0,strlen(WorkshopList[x_][x][wlName]), MAX_PLAYER_NAME);
					WorkshopList[x_+1][x][wlID] = -1;
					strmid(WorkshopList[x_+1][x][wlName],"", 0, strlen(""), 5);
				}
				if (WorkshopList[0][x][wlID] != -1 && strlen(WorkshopList[0][x][wlName]))
				{
					SCM(WorkshopList[0][x][wlID],COLOR_BLUE,"Подошла ваша очередь. У вас есть 2 минуты что бы прибыть к гаражу!");
					SetPVarInt(WorkshopList[0][x][wlID],"w_time", gettime() + 120);
					SetPlayerCheckpoint(WorkshopList[0][x][wlID],WorkshopInfo[x][wMenu][0],WorkshopInfo[x][wMenu][1],WorkshopInfo[x][wMenu][2], 10.0);
				}
				DisablePlayerCheckpoint(i);
				DeletePVar(i,"w_time");
				DeletePVar(i,"w_id");
			}
			if (GetPVarInt(i, "AntiBreik") > 0) SetPVarInt(i, "AntiBreik", GetPVarInt(i, "AntiBreik") - 1);
			if (timecar[i] > 0)
			{
				timecar[i]--;
				if (nachalvzlom[i] == 0) format(YCMDstr,10,"~r~%s",Convert(timecar[i]));
				else format(YCMDstr,10,"~g~BREAK");
				GameTextForPlayer(i, YCMDstr, 2000, 6);
				if (timecar[i] == 1)
				{
					if (PTEMP[i][pSkilla] > 0) PTEMP[i][pSkilla]--;
					SCM(i, COLOR_BLUE, " SMS: Ты нас разочаровал! Миссия провалена");
					avtocar[i] = 0;
					rabotaon[i] = 0;
					GangZoneDestroy(gangzonesa[i]);
				}
			}
			if (TriggerStatus[i] != 0) if (!PlayerToPoint(2.0,i,TriggerPos[i][0],TriggerPos[i][1],TriggerPos[i][2])) TriggerStatus[i] = 0; // Устанавливаем 0 что бы снова взять триггер
			if (sms_timer[i] > 0) sms_timer[i]--;
			if (GetPVarInt(i,"fish_ready") == 3 && GetPVarInt(i,"fish_began") && GetPVarInt(i,"fish_time") < gettime())
			{
				ApplyAnimation(i,"SWORD","sword_IDLE",50.0,0,1,1,1,1);
				if (Sonar[IsAtFishPlace(i)] > 0) SetPVarInt(i,"fish_chanse",random(20));
				if (IsABoat(i)) SetPVarInt(i,"fish_chanse",random(10));
				if (GetPVarInt(i,"fish_chanse") == 0) GameTextForPlayer(i,"~g~~n~!", 5000, 6), SetPVarInt(i,"fish_time", gettime() + random(5) + 2);
				else if (GetPVarInt(i,"fish_chanse") == 1) GameTextForPlayer(i,"~n~~n~~y~!", 5000, 6), SetPVarInt(i,"fish_time", gettime() + random(5) + 2);
				else if (GetPVarInt(i,"fish_chanse") == 2) GameTextForPlayer(i,"~n~~n~~r~~n~!", 5000, 6), SetPVarInt(i,"fish_time", gettime() + random(3) + 2);
				else GameTextForPlayer(i,"~b~!",11000,6);
			}
			if (startaddiction[i] == 1 && PTEMP[i][pAddiction] > 2000 && PTEMP[i][pNarcoLomka] == 0)
			{
				if (GetPVarInt(i,"player_paint") == 2) return true;
				SCM(i, 0x9F0000AA, " ~~~~~~~~ У вас началась ломка ~~~~~~~~");
				SCM(i, -1, " (( Вызвать медика - /call => [2] Скорая помощь || Принять наркотик - /usedrugs ))");
				PTEMP[i][pNarcoLomka] = 1;
			}
			//
			if (PTEMP[i][pDrivingSkill] > 1 && GetPlayerState(i) == PLAYER_STATE_DRIVER && !IsANoLimiter(GetPlayerVehicleID(i)))
			{
				PTEMP[i][pDrivingSkill]--;
				switch (PTEMP[i][pDrivingSkill])
				{
				case 1: SCM(i, COLOR_GREEN, " Ваш навык вождения повышен. (( Нажмите клавишу \"CTRL\" для выключения ограничителя скорости ))"),accept_car_damage[i] = 0;
				case 300,600,900,1200: SCM(i, COLOR_GREEN, " Ваш навык вождения повышен."),accept_car_damage[i] = 0;
				}
			}
			if (PTEMP[i][pDrivingSkill] > 0 && GetPlayerState(i) == PLAYER_STATE_DRIVER && !IsANoLimiter(GetPlayerVehicleID(i)))
			{
				new Float:veh[3];
				GetVehicleVelocity(GetPlayerVehicleID(i),veh[0],veh[1],veh[2]);
				switch (PTEMP[i][pDrivingSkill])
				{
				case 1..300: if(SpeedVehicle(i) > 50) setVehicleSpeed(GetPlayerVehicleID(i),50);
				case 301..600: if(SpeedVehicle(i) > 45) setVehicleSpeed(GetPlayerVehicleID(i),45);
				case 601..900: if(SpeedVehicle(i) > 40) setVehicleSpeed(GetPlayerVehicleID(i),40);
				case 901..1200: if(SpeedVehicle(i) > 35) setVehicleSpeed(GetPlayerVehicleID(i),35);
				}
			}
			if (CellTime[i] > 0)
			{
				if (CellTime[i] == cchargetime)
				{
					CellTime[i] = 1;
					if (Mobile[Mobile[i]] == i) PTEMP[i][pMobile] = PTEMP[i][pMobile]+callcost;
					CellTime[i] = CellTime[i] +1;
					if (Mobile[Mobile[i]] == 999 && CellTime[i] == 5)
					{
						if (IsPlayerConnected(Mobile[i]))
						{
							format(string, 90, "У %s звонит мобильник",Name(Mobile[i]));
							ProxDetector(30.0, Mobile[i], string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						}
					}
				}
				if (CellTime[i] == 0 && PTEMP[i][pMobile] > 0)
				{
					format(string, 64, "~w~Phone~n~~r~%i", PTEMP[i][pMobile]);
					GameTextForPlayer(i, string, 5000, 1);
				}
			}
			if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(i)) && peremennn[i] == 0) peremennn[i] = 1; // если  прицеп есть
			else if (!IsTrailerAttachedToVehicle(GetPlayerVehicleID(i)) && peremennn[i] == 1)
			{
				if (bGruz[i] == 0) return true;
				PTEMP[i][pDgruz] -= 3;
				SCM(i, 0xFF6347AA, " Вы потеряли часть груза");
				peremennn[i] = 0;
				if (PTEMP[i][pDgruz] < 0) PTEMP[i][pDgruz] = 1;
			}
			if (GetPVarInt(i, "GunCheckTime") == 0 && PTEMP[i][pAdmin] == 0)
			{
				new weaponid, ammo;
				for (new it = 1; it < 11; it++)
				{
					GetPlayerWeaponData(i, it, weaponid, ammo);
					if (ammo > Weapons[i][weaponid] && weaponid != 46)
					{
						DelGun(i);
						CheatKick(i, 029);
					}
					else if(PTEMP[i][pLogin]) Weapons[i][weaponid] = ammo;
				}
			}
			if (GetPVarInt(i, "GunCheckTime") > 0) SetPVarInt(i, "GunCheckTime", GetPVarInt(i, "GunCheckTime") - 1);
			if (PTEMP[i][pSatiety] > 100) PTEMP[i][pSatiety] = 100;
			if (PTEMP[i][pWantedLevel] > 6) PTEMP[i][pWantedLevel] = 6, SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel] );
			if (PTEMP[i][pZakonp] > 100) PTEMP[i][pZakonp] = 100;
			if (PTEMP[i][pZakonp] < -100) PTEMP[i][pZakonp] = -100;
			if (LabelOn[i] == 0 && PTEMP[i][pWantedLevel] >= 0)
			{
				LabelOn[i] = 1;
    			LabelRecognition[i] = Create3DTextLabel("Преступник!",0xFF000044, 30.0, 40.0, 50.0, 40.0,0);
				Attach3DTextLabelToPlayer(LabelRecognition[i], i, 0.0, 0.0, 0.4);
			}
			if (PTEMP[i][pWantedLevel] >= 0)
			{
				switch (PTEMP[i][pWantedLevel])
				{
					case 0..2: Update3DTextLabelText(LabelRecognition[i], 0xFF000044, "Преступник!");
					case 3..4: Update3DTextLabelText(LabelRecognition[i], 0xFF000099, "Преступник!");
					case 5..6: Update3DTextLabelText(LabelRecognition[i], 0xFF0000FF, "Преступник!");
				}
			}
			if (LabelOn[i] == 1 && PTEMP[i][pWantedLevel] <= 1) Delete3DTextLabel(LabelRecognition[i]), LabelOn[i] = 0;
			if (GetPVarInt(i, "BusTime") > 0)
			{
				SetPVarInt(i, "BusTime", GetPVarInt(i, "BusTime") - 1);
				format(string,10,"~r~%i",GetPVarInt(i, "BusTime"));
				GameTextForPlayer(i, string, 2000, 6);
				if (GetPVarInt(i, "BusTime") == 0)
				{
					if (GetPVarInt(i,"BusRepairMoney") > GetPVarInt(i, "BusMoney")) SetPVarInt(i,"BusRepairMoney",PTEMP[i][pPayCheck]);
					format(YCMDstr, sizeof(YCMDstr), " Вы закончили свой рабочий день. Заработано $%i. За ремонт -$%i", GetPVarInt(i, "BusMoney"), GetPVarInt(i,"BusRepairMoney"));
					SCM(i, 0x26bf99aa, YCMDstr);
					SCM(i, -1, " Деньги будут перечислены на ваш счёт во время зарплаты");
					SetVehicleToRespawn(GetPVarInt(i, "rentcar_job"));
					Delete3DTextLabel(JobText3D[GetPVarInt(i,"rentcar_job")]);
					DisablePlayerRaceCheckpoint(i);
					PTEMP[i][pPayCheck] -= GetPVarInt(i,"BusRepairMoney");
					DeletePVar(i, "BusTime");
					DeletePVar(i, "TypeBus");
					DeletePVar(i, "BusStop");
					DeletePVar(i, "BusMoney");
					DeletePVar(i, "BusRepairMoney");
					DeletePVar(i, "rentcar_job");
					pPressed[i] = 0;
				}
			}
			if (GetPVarInt(i, "TimeBus") > 0)
			{
				SetPVarInt(i, "TimeBus", GetPVarInt(i, "TimeBus") - 1);
				format(string,32,"~r~%i",GetPVarInt(i, "TimeBus"));
				GameTextForPlayer(i, string, 2000, 6);
				if (GetPVarInt(i, "TimeBus") == 0)
				{
					DeletePVar(i, "TimeBus");
					new type = GetPVarInt(i, "TypeBus"), p = pPressed[i];
					SetPVarInt(i, "BusStop", 1);
					if (type == 1) SetPlayerRaceCheckpoint(i,0,BusCityLS[p][0],BusCityLS[p][1],BusCityLS[p][2],BusCityLS[p][3],BusCityLS[p][4],BusCityLS[p][5],5.0);
					if (type == 2) SetPlayerRaceCheckpoint(i,0,BusCitySF[p][0],BusCitySF[p][1],BusCitySF[p][2],BusCitySF[p][3],BusCitySF[p][4],BusCitySF[p][5],5.0);
					if (type == 3) SetPlayerRaceCheckpoint(i,0,BusCityLV[p][0],BusCityLV[p][1],BusCityLV[p][2],BusCityLV[p][3],BusCityLV[p][4],BusCityLV[p][5],5.0);
					if (type == 4) SetPlayerRaceCheckpoint(i,0,BusSchool[p][0],BusSchool[p][1],BusSchool[p][2],BusSchool[p][3],BusSchool[p][4],BusSchool[p][5],5.0);
					if (type == 5) SetPlayerRaceCheckpoint(i,0,BusLSLV[p][0],BusLSLV[p][1],BusLSLV[p][2],BusLSLV[p][3],BusLSLV[p][4],BusLSLV[p][5],5.0);
					if (type == 6) SetPlayerRaceCheckpoint(i,0,BusLSZavodi[p][0],BusLSZavodi[p][1],BusLSZavodi[p][2],BusLSZavodi[p][3],BusLSZavodi[p][4],BusLSZavodi[p][5],5.0);
				}
			}
			if (IsSmoking[i] == 1)
			{
				format(YCMDstr, sizeof(YCMDstr), " %s докуривает сигарету.", Name(i));
				ProxDetector(30.0, i, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				new Float:PlayerHeal;
				GetPlayerHealth(i, PlayerHeal);
				if (PlayerHeal < 120) SetPlayerHealth(i, PlayerHeal+3);
				SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
			}
			if (IsSmoking[i] == 51 || IsSmoking[i] == 31 || IsSmoking[i] == 11)
			{
				format(YCMDstr, sizeof(YCMDstr), " %s курит сигарету.", Name(i));
				ProxDetector(30.0, i, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				new Float:PlayerHeal;
				GetPlayerHealth(i, PlayerHeal);
				if(PlayerHeal < 120) SetPlayerHealthAC(i, PlayerHeal+3);
			}
			if (IsSmoking[i] > 0) IsSmoking[i] -= 1;
			if (Works[i] == true && JobCP[i] == 2) if(usemesh[i] == 1) mesh[i] +=1;
			if (Flood[i] > 0) Flood[i] -=1;
			if (hour >= 12 && minute == 10 && second == 0) startaddiction[i] = 1;
			if (PTEMP[i][pMuted] > 1) PTEMP[i][pMuted] --;
			if (PTEMP[i][pMuted] == 1) PTEMP[i][pMuted] = 0, SCM(i,COLOR_LIGHTRED, " Вам включили чат. Пожалуйста соблюдайте правила");
			if (PTEMP[i][pJailTime] > 0)
			{
				if (PTEMP[i][pJailTime] > 1) PTEMP[i][pJailTime]--;
				if (PTEMP[i][pJailTime] == 1)
				{
					if (PTEMP[i][pMestoJail] == 1) SetPlayerInterior(i, 0), SetPlayerPos(i,1553.4962,-1675.2714,16.1953), SetPlayerFacingAngle(i, 95.0636);
					if (PTEMP[i][pMestoJail] == 2) SetPlayerInterior(i, 0), SetPlayerPos(i,-1607.1873,721.3649,12.2721), SetPlayerFacingAngle(i, 2.3026);
					if (PTEMP[i][pMestoJail] == 3) SetPlayerInterior(i, 0), SetPlayerPos(i,2334.8467,2454.9456,14.9688), SetPlayerFacingAngle(i, 115.7874);
					if (PTEMP[i][pMestoJail] == 4) SetPlayerWorldBounds(i,20000.0000,-20000.0000,20000.0000,-20000.0000), SetPlayerInterior(i, 0), SetPlayerPos(i, 86.9821,1181.0541,18.6641);
					PTEMP[i][pJailTime] = 0;
					PlayerCuffed[i] = 0;
					SCM(i, COLOR_GREEN, " Вы заплатили ваш долг обществу");
					PTEMP[i][pMestoJail] = 0;
					PTEMP[i][pWantedLevel] = 0;
					SetPlayerWantedLevel(i, 0);
					SetPlayerVirtualWorld(i, 0);
					GameTextForPlayer(i,"~g~Freedom", 5000, 1);
				}
			}
			if (PlayerTazeTime[i] >= 1) PlayerTazeTime[i] += 1;
			if (PlayerTazeTime[i] >= 10) PlayerTazeTime[i] = 0, TogglePlayerControllable(i, 1);
			if (TieTime[i] > 0) TieTime[i]--;
			if (PlayerCuffed[i] == 1)
			{
				if (PlayerCuffedTime[i] <= 0)
				{
					TogglePlayerControllable(i, 1);
					PlayerCuffed[i] = 0;
					PlayerCuffedTime[i] = 0;
					PlayerTazeTime[i] = 1;
					ClearAnimations(i);
				}
				else PlayerCuffedTime[i] -= 1;
			}
			if (PlayerCuffed[i] == 2)
			{
				if (PlayerCuffedTime[i] <= 0)
				{
					TogglePlayerControllable(i, 1);
					PlayerCuffed[i] = 0;
					PlayerCuffedTime[i] = 0;
				}
				else PlayerCuffedTime[i] -= 1;
			}
		}
	}
	GetMoney();
	if (paint_info[0] > 0) GetPaintball();
	if (race_info[0] > 0) GetRace();
	if (WarStart > 0) WarStart--;
	for (new i = 0; i < 20; i++)
	{
		if (MFrakCD[i] > 1)
		{
			MFrakCD[i] --;
			if (MFrakCD[i] == 900) SendFamilyMessage(i,0x114D71AA, " У вас осталось 15 минут на подготовку!");
			else if (MFrakCD[i] == 600) SendFamilyMessage(i,0x114D71AA, " У вас осталось 10 минут на подготовку!");
			else if (MFrakCD[i] == 180) SendFamilyMessage(i,COLOR_RED, " Пора решать кому будет пренадлежать бизнес. Осталось 3 минуты");
		}
	}
	if (war > 0) war -=1;
	if ((hour > ghour) || (hour == 0 && ghour == 23))
	{
		format(string, 90, " Сейчас времени %i:00 часов",hour);
		BroadCast(-1,string);
		ghour = hour;
		PayDay();
		SaveMySQL(0);
		for (new i = 1; i <= TOTALCASINO; i++) SaveMySQL(1,i);
		for (new i = 1; i <= TOTALSHOPS; i++) SaveMySQL(3,i);
		for (new i = 1; i <= TotalBizz; i++) SaveMySQL(4,i);
		for (new i = 1; i <= TotalHouse; i++) SaveMySQL(5,i);
		for (new i = 1; i <= ALLKVARTIRI; i++) SaveMySQL(6,i);
		for (new i = 1; i <= AllPODEZD; i++) SaveMySQL(7,i);
		for (new i = 1; i <= TOTALATM; i++) SaveMySQL(8,i);
		for (new i = 0; i <= TOTALFARM; i++) SaveMySQL(9,i);
		for (new i = 0; i < 20; i++) strmid(ATMADVERTISE[i],"", 0, strlen(""),150);
		for (new i = 1; i < MAX_PLAYERS; i++) Sonar[i] = random(2000);
		if (realtime) SetWorldTime(hour);
	}
	if (hour == 4 && minute == 59 && second == 20) PayDay();
	if (hour == 00 && minute == 01 && second == 00)
	{
		if (serverRestart) restartServer(1);
		else serverRestart = true;
	}
	if (hour == 00 && minute == 01 && second == 10)
	{
		if (rr) SendRconCommand("gmx");
	}
	if (paint_info[1] == 0)
	{
		if (hour == 16 && minute == 10  || hour == 13 && minute == 10  || hour == 14 && minute == 10  || hour == 22 && minute == 10 || hour == 01 && minute == 30 || hour == 03 && minute == 15 )
		{
			SendClientMessageToAll(0xffaaffff, " Внимание! Начало пейнтбола через 5 минут. Место проведения: военный завод K.A.C.C.");
			paint_info[0] = 300;
			paint_info[1] = 1;
			foreach(i) DeletePVar(i, "player_paint");
		}
	}
	if (race_info[1] == 0)
	{
		if (hour == 12 && minute == 10  || hour == 18 && minute == 10  || hour == 21 && minute == 10  || hour == 15 && minute == 10 || hour == 23 && minute == 10 )
		{
			SendClientMessageToAll(0xb9b900aa, " Внимание! Начало гонок через 5 минут. Трасса: Аэропорт Лос Сантос. Регистрация у въезда");
			race_info[0] = 300;
			race_info[1] = 1;
			foreach(i) DeletePVar(i, "gonka");
		}
	}
	AntiCheats();

    //print("<-- _Fresh()");

	return true;
}
AntiCheats()
{
	foreach(playerid)
	{
		/******************************** Античит на рванку *******************************/
		new Float:xw, Float:yw, Float:zw;
		GetPlayerVelocity(playerid,xw,yw,zw);
		if(xw > 2.0 || yw > 2.0)
		{
			Rvanka[playerid]++;
			if(Rvanka[playerid] >= 3)
			{
				CheatKick(playerid,007);
				Rvanka[playerid] = 0;
			}
		}
		//
		//if(GetVehicleDistanceFromPoint(GetPlayerVehicleID(playerid),car_coord[GetPlayerVehicleID(playerid)][0],car_coord[GetPlayerVehicleID(playerid)][1],car_coord[GetPlayerVehicleID(playerid)][2]) > 15 && (IsVehicleOccupied(GetPlayerVehicleID(playerid)) != -1 && IsVehicleOccupied(GetPlayerVehicleID(playerid)) == playerid && GetPlayerState(IsVehicleOccupied(GetPlayerVehicleID(playerid))) != PLAYER_STATE_DRIVER)) GameTextForPlayer(playerid,"~r~CARSHOOT",1000,3);
		/******************************** Античит на игру без авторизации *******************************/
		if(!PTEMP[playerid][pLogin] && (xw > 0 || yw > 0 || zw > 0))
		{
			CheatKick(playerid,008);
		}
		/********************************* Анти Разморозка **************************************/
		if(FreezePlayer[playerid] == 0)
		{
			if(IsPlayerApplyAnimation(playerid, "JUMP_glide") && FreezePlayer[playerid] == 0 ||
					IsPlayerApplyAnimation(playerid, "JUMP_land") && FreezePlayer[playerid] == 0 ||
					IsPlayerApplyAnimation(playerid, "JUMP_launch") && FreezePlayer[playerid] == 0 ||
					IsPlayerApplyAnimation(playerid, "JUMP_launch_R") && FreezePlayer[playerid] == 0)
			{
				CheatKick(playerid,009);
			}
		}
		/********************************** Анти Нивидимость *************************************/
		if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PTEMP[playerid][pAdmin] <= 0)
		{
			CheatKick(playerid,020);
		}
		/*********************************** Антифлуд пикапами ***********************************/
		if(oldpickup[playerid] != -1)
		{
			new Float:z;
			GetPlayerPos(playerid, z, z, z);
			if(timepickup[playerid] > 0) timepickup[playerid]--;
			if(!IsPlayerInRangeOfPoint(playerid,5.0,PickupX[playerid],PickupY[playerid],z) && timepickup[playerid] == 0) oldpickup[playerid] = -1;
		}
		/*********************************** Анти AFK ***********************************/
		new stringF[50];
		if(GetPVarInt(playerid,"AFK_Tick") > 10000) SetPVarInt(playerid,"AFK_Tick",1), SetPVarInt(playerid,"AFK_Check",0);
		if(GetPVarInt(playerid,"AFK_Check") < GetPVarInt(playerid,"AFK_Tick") && GetPlayerState(playerid)) SetPVarInt(playerid,"AFK_Check",GetPVarInt(playerid,"AFK_Tick")), SetPVarInt(playerid,"AFK_Time",0);
		if(GetPVarInt(playerid,"AFK_Check") >= GetPVarInt(playerid,"AFK_Tick") && GetPlayerState(playerid))
		{
			SetPVarInt(playerid,"AFK_Time",GetPVarInt(playerid,"AFK_Time") + 1);
			if(GetPVarInt(playerid, "AFK_Time") > 2)
			{
				format(stringF,sizeof(stringF), "[AFK] [%s секунд]",ConvertSeconds(GetPVarInt(playerid, "AFK_Time")-2));
				SetPlayerChatBubble(playerid, stringF, COLOR_GREEN, 30.0, 1200);
			}
		}
		if(GetPVarInt(playerid,"AFK_Time") >= 900 && PTEMP[playerid][pAdmin] < 2) SCM(playerid,COLOR_LIGHTRED, " Вы были отсоеденены от сервера! (AFK)"), Kick(playerid);

		/*********************************** Анти Armour ***********************************/
		new Float:armour;
		GetPlayerArmour(playerid, armour);
		if(Armour[playerid] < armour) SetPlayerArmourAC(playerid, Armour[playerid]);
		else Armour[playerid] = armour;
		if(HealthOn[playerid] == 0)
		{
			new Float: Health;
			GetPlayerHealth(playerid, Health);
			if(PTEMP[playerid][pHP] < Health) SetPlayerHealth(playerid, PTEMP[playerid][pHP]);
			else PTEMP[playerid][pHP] = Health;
		}
		else HealthOn[playerid] = 0;
		/*********************************** Анти Телепорт ***********************************/
		new distance2 = 400;
		new Float:currentPos[ 3 ], distance;
		GetPlayerPos( playerid, currentPos[ 0 ], currentPos[ 1 ], currentPos[ 2 ] );
		if(IsPlayerInAnyVehicle(playerid)) distance2 = 500;
		else distance2 = 200;
		distance = floatround( GetPlayerDistanceFromPoint( playerid, PTEMP[ playerid ][ pPos_x ], PTEMP[ playerid ][ pPos_y ], PTEMP[ playerid ][ pPos_z] ) );
		if(GetPVarInt(playerid, "AntiBreik") == 0 && GetPVarInt(playerid, "AFK_Time") < 2 && PTEMP[playerid][pAdmin] == 0)
		{
			if(distance > distance2)
			{
				CheatKick ( playerid , 022) ;
			}
		}
		if(GetPVarInt(playerid, "AntiBreik") == 0)
		{
			PTEMP[ playerid ][ pPos_x ] = currentPos[ 0 ];
			PTEMP[ playerid ][ pPos_y ] = currentPos[ 1 ];
			PTEMP[ playerid ][ pPos_z ] = currentPos[ 2 ];
		}
		/**************************************** Античит на коорд мастер ****************************/
		if(currentPos[2] < -1 && !GetPVarFloat(playerid,"pos_z") && !IsPlayerInRangeOfPoint(playerid, 100, -1590.8289,716.0479,-5.2422)) SetPVarFloat(playerid,"pos_z",currentPos[2]), SetPVarFloat(playerid,"pos_x",currentPos[0]);
		else if(currentPos[2] < -1 && GetPVarFloat(playerid,"pos_z") && !IsPlayerInRangeOfPoint(playerid, 100, -1590.8289,716.0479,-5.2422) && GetPVarFloat(playerid,"pos_z") == currentPos[2] && GetPVarFloat(playerid,"pos_x") != currentPos[0] && !SpeedVehicle(playerid) && GetPlayerInterior(playerid) == 0) CheatKick(playerid, 036);
		else DeletePVar(playerid,"pos_z");
		/******************************** Античит на JETPACK *******************************/
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
		{
			CheatKick(playerid, 002);
		}
		/******************************** Античит на быструю езду на мопеде *******************************/
		if(IsPlayerInAnyVehicle(playerid) && GetVehicleModel(GetPlayerVehicleID(playerid)) == 462 && SpeedVehicle(playerid) > 110 && PTEMP[playerid][pAdmin] == 0)
		{
			CheatKick(playerid, 024);
		}
		new animlib[30], animname[30];
		GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, sizeof(animlib), animname, sizeof(animname));
		/******************************** Античит на fly *******************************/
		if(SpeedVehicle(playerid) > 40 && strcmp(animlib, "SWIM", true) == 0 && strcmp(animname, "SWIM_crawl", true) == 0 && PTEMP[playerid][pAdmin] == 0 && !IsPlayerInAnyVehicle(playerid))
		{
			CheatKick(playerid, 025);
		}
		new AnimLib[30], AnimName[30];
		GetAnimationName(GetPlayerAnimationIndex(playerid), AnimLib, sizeof(AnimLib), AnimName, sizeof(AnimName));
		if(PTEMP[playerid][pAdmin] < 2)
		{
			if(GetPlayerSpeed(playerid) > 60 && strcmp(AnimLib, "SWIM", true) == 0 && strcmp(AnimName, "SWIM_crawl", true) == 0)
			{
				if(GetPVarInt(playerid, "cheat_fly_time") == 0 || (GetPVarInt(playerid, "cheat_fly_time") + 10) > gettime())
				{
					if(GetPVarInt(playerid, "cheat_fly") >= 3) CheatKick(playerid, 026);
					else
					{
					    SetPVarInt(playerid, "cheat_fly", (GetPVarInt(playerid, "cheat_fly") +1));
					    SetPVarInt(playerid, "cheat_fly_time", gettime());
					    format(string, 90, " <Warning> %s[%i]: Возможно Airbreak", PTEMP[playerid][pName], playerid);
						ABroadCast(COLOR_REDD,string,2);
					}
				}
			}
		}
		/******************************** Античит на fly *******************************/
		if(SpeedVehicle(playerid) > 40 && GetPlayerWeapon(playerid) != 46 && strcmp(animname, "FALL_SKYDIVE_ACCEL", true) == 0 && PTEMP[playerid][pAdmin] <= 2 && !IsPlayerInAnyVehicle(playerid))
		{
			CheatKick(playerid, 026);
		}
		/******************************** Античит на езду без аренды *******************************/
		new newcar = GetPlayerVehicleID(playerid);
		if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return true;
		if(newcar >= rentcarsf[0] && newcar <= rentcarsf[6])
		{
			if(arenda[playerid] != newcar && SpeedVehicle(playerid) > 150)
			{
				CheatKick(playerid, 027);
				SetVehicleToRespawn(newcar);
			}
		}
		/******************************** Античит на езду без аренды *******************************/
		if(newcar >= rentcarls[0] && newcar <= rentcarls[8])
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return true;
			if(arenda[playerid] != newcar && SpeedVehicle(playerid) > 150)
			{
				CheatKick(playerid, 027);
				SetVehicleToRespawn(newcar);
			}
		}
		/******************************** Античит на езду без аренды *******************************/
		if(newcar >= rentcarvip[0] && newcar <= rentcarvip[8])
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return true;
			if(arenda[playerid] != newcar && SpeedVehicle(playerid) > 150)
			{
				CheatKick(playerid, 027);
				SetVehicleToRespawn(newcar);
			}
		}
		/******************************** Античит на езду без аренды *******************************/
		if(newcar >= rentcarlv[0] && newcar <= rentcarlv[17])
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return true;
			if(arenda[playerid] != newcar && SpeedVehicle(playerid) > 150)
			{
				CheatKick(playerid, 027);
				SetVehicleToRespawn(newcar);
			}
		}
		if(GetPlayerWeapon(playerid) > 0 && GetPlayerAmmo(playerid) == 0 && Weapons[playerid][GetPlayerWeapon(playerid)] == 0 && PTEMP[playerid][pLogin] && GetPVarInt(playerid, "GunCheckTime") == 0)
		{
			DelGun(playerid);
			CheatKick(playerid, 028);
		}
		/******************************** Античит на езду без аренды *******************************/
		if(newcar >= buscar[0] && newcar <= buscar[7])
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return true;
			if(GetPVarInt(playerid, "rentcar_job") != newcar && SpeedVehicle(playerid) > 40)
			{
				CheatKick(playerid, 027);
				SetVehicleToRespawn(newcar);
			}
		}
	}
	return true;
}