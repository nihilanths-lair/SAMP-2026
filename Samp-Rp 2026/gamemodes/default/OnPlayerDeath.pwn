public OnPlayerDeath(playerid, killerid, reason)
{
	DelGun(playerid);
	if(robscdtimer[playerid] != -1)
	{
		KillTimer(robscdtimer[playerid]);
		robscdtimer[playerid] = -1;
	}
	if(SERVERTEST) SendMes(killerid,COLOR_BLUE,"DEATH: PLAYERID - %i, KILLERID - %i, REASON - %i",playerid,killerid,reason);
 	new animlib[32], animname[32];
    GetAnimationName(AnimTheLost[playerid],animlib,32,animname,32);
    if(strcmp(animlib, "PED", true) != 0) ClearAnimations(playerid);
	SetPVarInt(playerid,"CarSpWarn",0);
	new GotPVar = GetPVarInt(playerid, "VrConvoi");
	if(cuffto[playerid] != 9999)
	{
		TogglePlayerControllable(cuffto[playerid], 1);
		SetPlayerSpecialAction(cuffto[playerid],SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(cuffto[playerid],0);
		PlayerCuffed[cuffto[playerid]] = 0;
		PlayerCuffedTime[cuffto[playerid]] = 0;
		cuffto[playerid] = 9999;
	}
    if(Convoi[playerid] != 9999)
    {
        SetPVarInt(Convoi[playerid], "VrConvoi", -1);
        KillTimer(TimerForPlayer[playerid]);
        SCM(Convoi[playerid], COLOR_GREY, " Ваш заключенный мертв");
        TimerForPlayer[playerid] = INVALID_PLAYER_ID;
        Convoi[playerid] = 9999;
    }
    else if(GotPVar != -1)
    {
        SetPVarInt(playerid, "TempConvoi", -1);
        KillTimer(TimerForPlayer[GotPVar]);
        SCM(Convoi[playerid], COLOR_GREY, " Ваш конвой мертв");
        TimerForPlayer[GotPVar] = INVALID_PLAYER_ID;
        Convoi[GotPVar] = 9999;
    }
	if(killerid != INVALID_PLAYER_ID)
	{
		format(string, 60, " <Warning> %s[%i]: Возможно Фейк Килл",PTEMP[playerid][pName],playerid);
		if(GetPlayerWeapon(killerid) != reason || (!ProxDetectorS(2.0, playerid, killerid) && GetPlayerWeapon(killerid) == 0)) SendAdminMessage(COLOR_REDD, string);
	}
	if(GetPVarInt(playerid,"player_paint") == 2)
	{
		SetPVarInt(playerid,"paintdeaths",GetPVarInt(playerid,"paintdeaths")+1);
		if(killerid != INVALID_PLAYER_ID)
		{
			GameTextForPlayer(killerid, "~w~Kills +1", 5000, 1);
			if(playerid != killerid){ SetPVarInt(killerid,"paintkills",GetPVarInt(killerid,"paintkills")+1); }
		}
	}
	if(race_info[1] > 1 && GetPVarInt(playerid,"gonka") != 0)
	{
		DestroyVehicle(RaceInfo[GetPVarInt(playerid,"gonka")-1][rCar]);
		DeletePVar(playerid,"gonka");
		SCM(playerid,COLOR_LIGHTRED," Вы были дисквалифицированы!");
	}
	if(GetPVarInt(playerid,"farm_id"))
	{
		DisablePlayerCheckpoint(playerid);
		RemovePlayerAttachedObject(playerid,3);
		DeletePVar(playerid,"farm_id");
		DeletePVar(playerid,"farm_status");
		DeletePVar(playerid,"farm_rank");
		DeletePVar(playerid,"farm_zp");
	}
	if(GetPVarInt(playerid,"h_contract"))
	{
		DeletePVar(playerid,"h_contract");
		DeletePVar(playerid,"h_price");
		if(GetPVarInt(playerid,"h_stall"))
		{
			UpdateDynamic3DTextLabelText(StallInfo[GetPVarInt(playerid,"h_stall")][stText], 0xFF8C37FF,"Не работает");
			DeletePVar(playerid,"h_stall");
		}
	}
	if(GetPVarInt(playerid,"w_id"))
	{
		new null = -1, x = GetPVarInt(playerid,"w_id");
		for(new x_ = 9; x_ >= 0; x_--) if(strcmp(WorkshopList[x_][x][wlName],PTEMP[playerid][pName],true) == 0 && strlen(WorkshopList[x_][x][wlName])) null = x_;
		if(null != -1)
		{
			for(new x_ = null; x_ < 9; x++)
			{
				WorkshopList[x_][x][wlID] = WorkshopList[x_+1][x][wlID];
				strmid(WorkshopList[x_][x][wlName],WorkshopList[x_+1][x][wlName],0,strlen(WorkshopList[x_][x][wlName]), MAX_PLAYER_NAME);
				WorkshopList[x_+1][x][wlID] = -1;
				strmid(WorkshopList[x_+1][x][wlName],"", 0, strlen(""), 5);
			}
			if(null == 0 && strlen(WorkshopList[0][x][wlName]))
			{
				DisablePlayerCheckpoint(playerid);
				SCM(WorkshopList[0][x][wlID],COLOR_BLUE,"Подошла ваша очередь. У вас есть 2 минуты что бы прибыть к гаражу!");
				SetPVarInt(WorkshopList[0][x][wlID],"w_time", gettime() + 120);
				SetPlayerCheckpoint(WorkshopList[0][x][wlID],WorkshopInfo[x][wMenu][0],WorkshopInfo[x][wMenu][1],WorkshopInfo[x][wMenu][2], 10.0);
			}
			DeletePVar(playerid,"w_time");
			DeletePVar(playerid,"w_id");
		}
	}
	if(GetPVarInt(playerid,"InWorkshop") > 0)
	{
		DeletePVar(playerid,"cost");
		DeletePVar(playerid,"prods");
		DeletePVar(playerid,"detals");
		DeletePVar(playerid,"color0");
		DeletePVar(playerid,"color1");
		DeletePVar(playerid,"w_id");
		DeletePVar(GetPVarInt(playerid,"mechanic"),"installation");
		SetPlayerVirtualWorld(GetPVarInt(playerid,"mechanic"),0);
		t_SetPlayerPos(GetPVarInt(playerid,"mechanic"),WorkshopInfo[GetPVarInt(playerid,"InWorkshop")][wMenu][0],WorkshopInfo[GetPVarInt(playerid,"InWorkshop")][wMenu][1],WorkshopInfo[GetPVarInt(playerid,"InWorkshop")][wMenu][2]);
		DeletePVar(GetPVarInt(playerid,"mechanic"),"installation_");
		DeletePVar(playerid,"mechanic");
		DeletePVar(playerid,"InWorkshop");
	}
	if(GetPVarInt(playerid,"Workshop") > 0)
	{
		if(GetPVarInt(GetPVarInt(playerid,"installation_"),"InWorkshop") > 0)
		{
			DeletePVar(GetPVarInt(playerid,"installation_"),"cost");
			DeletePVar(GetPVarInt(playerid,"installation_"),"prods");
			DeletePVar(GetPVarInt(playerid,"installation_"),"detals");
			DeletePVar(GetPVarInt(playerid,"installation_"),"color0");
			DeletePVar(GetPVarInt(playerid,"installation_"),"color1");
			DeletePVar(GetPVarInt(playerid,"installation_"),"w_id");
			SetPlayerVirtualWorld(GetPVarInt(playerid,"installation_"),0);
			if(!IsPlayerInAnyVehicle(GetPVarInt(playerid,"installation_")))
			{
				t_SetPlayerPos(GetPVarInt(playerid,"installation_"),WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][0],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][1],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][2]);
				SetVehiclePos(house_car[GetPVarInt(playerid,"installation_")],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][0],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][1],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][2]);
				PutPlayerInVehicleEx(GetPVarInt(playerid,"installation_"),house_car[GetPVarInt(playerid,"installation_")],0);
				SetPlayerVirtualWorld(GetPVarInt(playerid,"installation_"),0);
			}
			else
			{
				if(GetPVarInt(playerid,"Workshop") == 1) SetVehiclePos(GetPlayerVehicleID(GetPVarInt(playerid,"installation_")),WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][0],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][1],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][2]);
				SetVehicleVirtualWorld(GetPlayerVehicleID(GetPVarInt(playerid,"installation_")),0);
			}
			SCM(GetPVarInt(playerid,"installation_"),COLOR_LIGHTRED,"Механик вышел из игры!");
			DeletePVar(GetPVarInt(playerid,"installation_"),"mechanic");
			DeletePVar(GetPVarInt(playerid,"installation_"),"InWorkshop");
		}
		DeletePVar(playerid,"installation");
		DeletePVar(playerid,"installation_");
		DeletePVar(playerid,"Workshop");
		PTEMP[playerid][pPayCheck]+=GetPVarInt(playerid,"Workshop_");
		WorkshopInfo[GetPVarInt(playerid,"Workshop")][wBank]-=GetPVarInt(playerid,"Workshop_");
		DeletePVar(playerid,"Workshop_");
		DeletePVar(playerid,"Workshop__");
	}
	if(GetPVarInt(playerid, "RStol"))
	{
		if(RouletPlay[GetPVarInt(playerid,"RStol")] == false) PTEMP[playerid][pCash]+=GetPVarInt(playerid,"RStavka");
		DestroyObject(GetPVarInt(playerid,"RObj"));
		DeletePVar(playerid,"RObj");
		DeletePVar(playerid,"RStavka");
		DeletePVar(playerid,"RStol");
		DeletePVar(playerid,"RX");
		DeletePVar(playerid,"RY");
		DeletePVar(playerid,"RZ");
		DeletePVar(playerid,"RXONE");
		DeletePVar(playerid,"RYONE");
		DeletePVar(playerid,"RZONE");
		DeletePVar(playerid,"RNumber");
		DeletePVar(playerid,"RNumbers");
		DeletePVar(playerid,"RNumber_");
		PlayerTextDrawHide(playerid,RouletText[playerid]);
		TogglePlayerControllableEx(playerid, true);
		SetCameraBehindPlayer(playerid);
	}
	DeletePVar(playerid,"CasinoRank");
 	FreezePlayer[playerid] = 1;
	for(new i; i < 11; i++) vidachagun[i][playerid] = 0;
	if(PTEMP[playerid][pJob] == 2)
	{
		if(gcontract[playerid] == 1)
		{
			Delete3DTextLabel(Meh3d[GetPlayerVehicleID(playerid)]);
			gcontract[playerid] = 0;
		}
	}
	if(reason == 38)
	{
		format(YCMDstr, sizeof(YCMDstr), " <Warning> %s[%i]: убил с минигана %s[%i] wep %i guns %i",PTEMP[killerid][pName],killerid,PTEMP[playerid][pName],playerid,GetPlayerWeapon(killerid),GetPlayerAmmo(killerid));
		ABroadCast(0xFF0000AA,YCMDstr,2);
		RemovePlayerFromVehicleAC(killerid);
	}
	TextDrawHideForPlayer(playerid, DRAP);
	SetPVarInt(playerid,"K_Times",GetPVarInt(playerid,"K_Times") + 1);
	SetPVarInt(playerid, "GunCheckTime", 2);
	//if(GetPVarInt(playerid,"K_Times") > 1 && PTEMP[playerid][pAdmin] <= 0) return CheatKick(playerid,1112);
	new name[MAX_PLAYER_NAME];
	ebanksf[playerid] = 0;
	enterbiz[playerid] = 0;
	MehJob[playerid] = 999;
	Works[playerid] = false; JobAmmount[playerid] = 0; JobCP[playerid] = 0; Employer[playerid] = 999;
	DisablePlayerCheckpoint(playerid);
	PicCP[playerid] = 1;
	mesh[playerid] = 999;
	usemesh[playerid] = 0;
	RemovePlayerAttachedObject(playerid,1);
	RemovePlayerAttachedObject(playerid,2);
	RemovePlayerAttachedObject(playerid,3);
	RemovePlayerAttachedObject(playerid,4);
	RemovePlayerAttachedObject(playerid,0);
	arenda[playerid] = 0;
	usemats[playerid] = 0;
	zd[playerid] = 0;
	VertMats[playerid] = 0;
	tex[playerid] = 0;
	tex2[playerid] = 0;
	if(PTEMP[playerid][pJob] == 7) PTEMP[playerid][pJob] = 0;
	new weaponid;
	new gunname[25];
	GetWeaponName(weaponid, gunname, sizeof(gunname));
	forma[playerid] = 0;
	proverkaforma[playerid] = 0;
	new Float:px,Float:py,Float:pz;
	gPlayerSpawned[playerid] = 0;
	GetPlayerName(playerid, name, sizeof(name));
	if(IsPlayerInAnyVehicle(playerid)) RemovePlayerFromVehicleAC(playerid);
	GetPlayerPos(playerid, px, py, pz);
	LiveOffer[playerid] = 999;
	TalkingLive[playerid] = 255;
	LiveOfferls[playerid] = 999;
	LiveOfferlv[playerid] = 999;
	TalkingLivels[playerid] = 255;
	TalkingLivelv[playerid] = 255;
	Tel[playerid] = 255;
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
	//KillTimer(Timerkk[playerid]);
	if(!IsAArm(killerid) && !IsACop(killerid) && GetPVarInt(killerid, "player_paint") != 2 && killerid != INVALID_PLAYER_ID)
	{
		if(PTEMP[killerid][pZakonp] < 0) return true;
		PTEMP[killerid][pZakonp] -= 2;
	}
	if(PTEMP[playerid][pWantedLevel] > 0 && killerid != INVALID_PLAYER_ID)
	{
		if(IsACop(killerid))
		{
			PTEMP[playerid][pWantedDeaths] += 1;
			PTEMP[playerid][pMestoJail] = 1;
			PTEMP[playerid][pJailTime] = PTEMP[playerid][pWantedLevel]*600;
			DelGun(playerid);
			PTEMP[playerid][pWantedLevel] = 0;
			SetPlayerWantedLevel(playerid,PTEMP[playerid][pWantedLevel] );
			SetPlayerInterior(playerid, 6);
			SetPlayerPos(playerid, 264.6288,77.5742,1001.0391);
			SendMes(playerid,COLOR_YELLOW, " Вас посадили в тюрьму на %i секунд!", PTEMP[playerid][pJailTime]);
			SendMes(killerid,COLOR_YELLOW, " Вы посадили преступника на %i секунд!", PTEMP[playerid][pJailTime], PTEMP[playerid][pJailTime]/600);
			PTEMP[killerid][pCash] += PTEMP[playerid][pJailTime]/600;
			format(string, sizeof(string), "~b~+$%i",PTEMP[playerid][pJailTime]/600);
			GameTextForPlayer(playerid,string, 3000, 1);
			PTEMP[playerid][pCash] -= 1;
			GameTextForPlayer(playerid,"~b~-$1", 3000, 1);
		}
	}
	if(gPlayerCheckpointStatus[playerid] > 4 && gPlayerCheckpointStatus[playerid] < 11)
	{
		DisablePlayerCheckpoint(playerid);
		gPlayerCheckpointStatus[playerid] = 0;
	}
	if(IsAArm(killerid))
	{
		if(IsAGang(playerid) || IsABiker(playerid))
		{
			if(PlayerToKvadrat(killerid, -49.979476, 1695.982177, 414.020507, 2175.982177) || PlayerToKvadrat(killerid, 2634.4395, -2562.5022, 2861.7734, -2320.1594) || PlayerToKvadrat(killerid, -1220.6725, 542.0154, -1571.1744, 257.9100))
			{
				if(PlayerToKvadrat(playerid, -49.979476, 1695.982177, 414.020507, 2175.982177) || PlayerToKvadrat(playerid, 2634.4395, -2562.5022, 2861.7734, -2320.1594) || PlayerToKvadrat(playerid, -1220.6725, 542.0154, -1571.1744, 257.9100))
				{
					PTEMP[killerid][pPayCheck] += 500;
					GameTextForPlayer(killerid, "~g~+$500", 5000, 1);
				}
			}
		}
	}
	new caller = Mobile[playerid];
	if(caller != 999)
	{
		if(caller < 999)
		{
			SCM(caller,  COLOR_GRAD2, "Связь оборвалась.");
			CellTime[caller] = 0;
			CellTime[playerid] = 0;
			Mobile[caller] = 999;
		}
		Mobile[playerid] = 999;
		CellTime[playerid] = 0;
	}
	new sendername[MAX_PLAYER_NAME];
	new killer[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(killerid != INVALID_PLAYER_ID) GetPlayerName(killerid, killer, sizeof(killer));
	for(new i = 1; i <= TOTALGZ; i++)
	{
		if(ZoneOnBattle[i] == 1 && killerid != INVALID_PLAYER_ID)
		{
			if(PTEMP[killerid][pMember] == GZInfo[i][gNapad] && PTEMP[killerid][pMember] != PTEMP[playerid][pMember] ||
					PTEMP[killerid][pMember] == GZInfo[i][gFrakVlad] && PTEMP[killerid][pMember] != PTEMP[playerid][pMember])
			{
				if(PTEMP[playerid][pMember] == GZInfo[i][gNapad] || PTEMP[playerid][pMember] == GZInfo[i][gFrakVlad])
				{
					foreach(idx)
					{
						if(PTEMP[idx][pMember] == GZInfo[i][gNapad] || PTEMP[idx][pMember] == GZInfo[i][gFrakVlad])
						if(PTEMP[idx][pAdmin] <= 0)
						SendDeathMessageToPlayer(idx, killerid, playerid, reason);
					}
					if(PlayerToKvadrat(playerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]) && PlayerToKvadrat(killerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]))
					{
						CountOnZone[PTEMP[killerid][pMember]] ++;
						PTEMP[killerid][pGRating] += 100;
						switch(PTEMP[killerid][pMember])
						{
						    case 12: gRating[Ballas] += 100;
						    case 13: gRating[Vagos]  += 100;
						    case 15: gRating[Grove]  += 100;
						    case 17: gRating[Aztec]  += 100;
						    case 18: gRating[Rifa]   += 100;
						}
					}
					else if(!PlayerToKvadrat(playerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]) || !PlayerToKvadrat(killerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]))
					{
						SetPlayerColor(killerid, TEAM_HIT_COLOR);
						SetPlayerColor(playerid, TEAM_HIT_COLOR);
						foreach(idx)
						{
							if(PTEMP[idx][pMember] == GZInfo[i][gNapad] || PTEMP[idx][pMember] == GZInfo[i][gFrakVlad]) if(PTEMP[idx][pAdmin] <= 0) SendDeathMessageToPlayer(idx, killerid, playerid, reason); }
						SetPlayerToTeamColor(killerid);
						SetPlayerToTeamColor(playerid);
					}
				}
			}
		}
	}
	if(IsAGang(killerid) && killerid != INVALID_PLAYER_ID)
	{
		if(PTEMP[playerid][pMember] == 3 && GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] != 0 || PTEMP[playerid][pLeader] == 3 && GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] != 0 || PTEMP[playerid][pMember] == 19 && GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] != 0 || PTEMP[playerid][pLeader] == 19 && GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] != 0)
		{
			for(new i = 1; i <= TOTALGZ; i++)
			{
				if(PlayerToKvadrat(playerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]))
				{
					if(PTEMP[playerid][pMember] == 3 && forma[killerid] == 0)
					{
						if(GetPlayerSkin(playerid) == 252 || PTEMP[playerid][pModel] == 252) { }
						else
						{
							forma[killerid] = 1;
							PTEMP[playerid][pModel] = 252;
							SCM(playerid,  COLOR_YELLOW, " Вы потеряли армейскую форму");
							SCM(killerid,  COLOR_YELLOW, " Вы cняли с армейца форму, введите /switchskin, чтобы переодеться");
							if(PTEMP[killerid][pZakonp] > 0) PTEMP[killerid][pZakonp] -= 2;
						}
					}
					if(PTEMP[playerid][pMember] == 19 && forma[killerid] == 0)
					{
						if(GetPlayerSkin(playerid) == 252 || PTEMP[playerid][pModel] == 252) { }
						else
						{
							forma[killerid] = 1;
							PTEMP[playerid][pModel] = 252;
							SCM(playerid,  COLOR_YELLOW, "Вы потеряли армейскую форму");
							SCM(killerid,  COLOR_YELLOW2, "Вы cняли с армейца форму, введите /switchskin, чтобы переодеться");
							if(PTEMP[killerid][pZakonp] > 0) PTEMP[killerid][pZakonp] -= 2;
						}
					}
				}
			}
		}
	}
	if(IsAGang(killerid) && killerid != INVALID_PLAYER_ID)
	{
		if(IsACop(playerid) && GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] != 0)
		{
			if(PTEMP[playerid][pMember] != 2 || PTEMP[playerid][pLeader] != 2)
			{
				for(new i =1;i<= TOTALGZ;i++)
				{
					if(PlayerToKvadrat(playerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]))
					{
						if(PTEMP[playerid][pKeys] > 0)
						{
							PTEMP[killerid][pKeys] += PTEMP[playerid][pKeys];
							if(PTEMP[killerid][pKeys] > 5) PTEMP[killerid][pKeys] = 5;
							PTEMP[playerid][pKeys] = 0;
							foreach(j)
							{
								if(PTEMP[j][pMember] == 1 || PTEMP[j][pLeader] == 1 || PTEMP[j][pMember] == 10 || PTEMP[j][pLeader] == 10 || PTEMP[j][pMember] == 2 ||PTEMP[j][pLeader] == 2 || PTEMP[j][pMember] == 21 || PTEMP[j][pLeader] == 21)
								{
								    if(GetPVarInt(j, "Fraction_Duty"))
								    {
										format(string, 144, " Полицейский %s потерял ключи от камеры",PTEMP[playerid][pName]);
										SCM(j, 0xffc801c8,string);
									}
								}
							}
							SCM(killerid,  COLOR_YELLOW, " Вы забрали у полицейского ключи от камеры!");
							if(PTEMP[killerid][pZakonp] > 0) PTEMP[killerid][pZakonp] -= 2;
						}
					}
				}
			}
		}
	}
	if(IsAMafia(killerid) && killerid != INVALID_PLAYER_ID && GetPVarInt(killerid, "mafia_war"))
	{
	    if(IsAMafia(playerid))
	    {
			for(new i = 1;i <= TotalBizz; i++)
			{
				if((PTEMP[killerid][pMember] == BizzInfo[i][bCapture] || PTEMP[killerid][pMember] == BizzInfo[i][bMafia])
					&& (PTEMP[playerid][pMember] == BizzInfo[i][bCapture] || PTEMP[playerid][pMember] == BizzInfo[i][bMafia]))
				{
					foreach(x)
					{
						if(PTEMP[x][pMember] == BizzInfo[i][bCapture] || PTEMP[x][pMember] == BizzInfo[i][bMafia])
						{
						    if(PTEMP[x][pAdmin] <= 0) SendDeathMessageToPlayer(x,killerid, playerid, reason);
						}
					}
				}
			}
	        if(ZoneID == 1)
			{
				if(PlayerToKvadrat(killerid,351.314666, 2455.576416, 439.314666, 2551.576416)
				&& PlayerToKvadrat(playerid,351.314666, 2455.576416, 439.314666, 2551.576416))
				{
				    MafiaKills[PTEMP[killerid][pMember]]++;
				}
			}
			else if(ZoneID == 2)
			{
				if(PlayerToKvadrat(killerid,393.8914,983.9361, 324.6188,833.3795)
				&& PlayerToKvadrat(playerid,393.8914,983.9361, 324.6188,833.3795))
				{
				    MafiaKills[PTEMP[killerid][pMember]]++;
				}
			}
			else if(ZoneID == 3)
			{
				if(PlayerToKvadrat(killerid,-789.8281,2015.9144, -662.7654,2083.9297)
				&& PlayerToKvadrat(playerid,-789.8281,2015.9144, -662.7654,2083.9297))
				{
				    MafiaKills[PTEMP[killerid][pMember]]++;
				}
			}
	    }
	}
	if(IsABiker(playerid) && IsABiker(killerid) && GetPVarInt(playerid, "biker_capt"))
	{
		for(new x = 0; x < sizeof(BikerZone);x++)
		{
			if(ZoneCaptureBiker == BikerZone[x])
		    {
		    	if(PlayerToKvadrat(playerid,BikerZoneCoords[x][zoneX1],BikerZoneCoords[x][zoneY1], BikerZoneCoords[x][zoneX2], BikerZoneCoords[x][zoneY2])
				&& PlayerToKvadrat(killerid,BikerZoneCoords[x][zoneX1],BikerZoneCoords[x][zoneY1], BikerZoneCoords[x][zoneX2], BikerZoneCoords[x][zoneY2]))
		    	{
					if(PTEMP[killerid][pMember] == BikerCapture[atack]) BikerKills[atack] ++;
					else if(PTEMP[killerid][pMember] == BikerCapture[other]) BikerKills[other] ++;

		    	}
    		}
   		}
   		foreach(x)
   		{
   		    format(string,120,"~y~kills~n~~n~~g~%s:~w~ %i~n~~r~%s:~w~ %i", GetNameOfBiker(BikerCapture[atack]), BikerKills[atack] , GetNameOfBiker(BikerCapture[other]), BikerKills[other]);
			PlayerTextDrawSetString(x,Capture[x],string);
   		}
   		foreach(x)
   		{
   		    if(PTEMP[x][pMember] == BikerCapture[atack] || PTEMP[x][pMember] == BikerCapture[other])
   		    	if(PTEMP[x][pAdmin] <= 0)
   		    	    SendDeathMessageToPlayer(x,killerid, playerid, reason);
   		}
	}
	if(gPlayerCheckpointStatus[playerid] > 4 && gPlayerCheckpointStatus[playerid] < 11)
	{
		DisablePlayerCheckpoint(playerid);
		gPlayerCheckpointStatus[playerid] = 0;
	}
	if(GetPlayerState(killerid) == 2 && killerid != INVALID_PLAYER_ID)
	{
		SCM(killerid, COLOR_LIGHTRED, "Убийство с водительского места запрещено!");
		PTEMP[killerid][pWantedLevel] += 1;
		SetPlayerWantedLevel(killerid,PTEMP[playerid][pWantedLevel]);
		SetPlayerCriminal(killerid,"Неизвестный", "Убийство с транспорта");
		format(YCMDstr, 50, " <Warning> %s[%i]: Убил транспортом", PTEMP[killerid][pName], killerid);
		ABroadCast(COLOR_REDD,YCMDstr,2);
	}
	if(!GetPVarInt(killerid, "biker_capt") && !GetPVarInt(killerid,"capture_on") && !GetPVarInt(killerid,"mafia_war") && !IsACop(killerid) && PTEMP[killerid][pMember] != 3 && PTEMP[killerid][pMember] != 19)
	{
		new strs[64];
		switch(PTEMP[playerid][pMember])
		{
		    case 3,19: strs = "Убийство армейца", PTEMP[killerid][pWantedLevel] += 4;
		    case 1,10,21: strs = "Убийство полицейского", PTEMP[killerid][pWantedLevel] += 5;
		    case 2: strs = "Убийство агента ФБР", PTEMP[killerid][pWantedLevel] += 6;
		    default: strs = "Убийство человека", PTEMP[killerid][pWantedLevel] += 3;
		}
		SetPlayerWantedLevel(killerid,PTEMP[playerid][pWantedLevel]);
		SetPlayerCriminal(killerid,"Неизвестно", strs);
	}
	DisablePlayerCheckpoint(playerid);
	foreach(i)
	{
		if(PTEMP[i][pAdmin] >= 1)
		{
			SendDeathMessageToPlayer(i,killerid, playerid, reason);
		}
	}
	return true;
}