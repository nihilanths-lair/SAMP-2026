public OnPlayerDisconnect(playerid, reason)
{
    if(robscdtimer[playerid] != -1)
	{
		KillTimer(robscdtimer[playerid]);
		robscdtimer[playerid] = -1;
	}
	if(LabelOn[playerid] == 1) Delete3DTextLabel(LabelRecognition[playerid]), LabelOn[playerid] = 0;
	if(PTEMP[playerid][pLogin] == 1) strmid(ExitInfo[playerid][ExitIP],PTEMP[playerid][pIp], 0, strlen(PTEMP[playerid][pIp]), 32), ExitInfo[playerid][ExitTime] = GetTickCount();
	if(GetPVarInt(playerid,"h_stall")) UpdateDynamic3DTextLabelText(StallInfo[GetPVarInt(playerid,"h_stall")][stText], 0xFF8C37FF,"Не работает");
	if(GetPVarInt(playerid,"took_faggio")) DestroyVehicle(GetPVarInt(playerid,"took_faggio"));

	if(PlayerCuffed[playerid] >= 1) {
	    PTEMP[playerid][pMestoJail] = 1;
	    PTEMP[playerid][pJailTime] = 3600;
	}

	if(cuffto[playerid] != 9999)
	{
		TogglePlayerControllable(cuffto[playerid], 1);
		SetPlayerSpecialAction(cuffto[playerid],SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(cuffto[playerid],0);
		PlayerCuffed[cuffto[playerid]] = 0;
		PlayerCuffedTime[cuffto[playerid]] = 0;
		cuffto[playerid] = 9999;
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
	if(race_info[1] > 1 && GetPVarInt(playerid,"gonka") != 0)
	{
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,831.7769,6.8750,1004.1797);
		SetPlayerFacingAngle(playerid,108.1610);
		DestroyVehicle(RaceInfo[GetPVarInt(playerid,"gonka")-1][rCar]);
		DeletePVar(playerid,"gonka");
		SCM(playerid,COLOR_LIGHTRED,"Вы были дисквалифицированы!");
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPVarInt(playerid,"TaxiDuty"))
	{
		Delete3DTextLabel(JobText3D[GetPVarInt(playerid,"rentcar_job")]);
		DeletePVar(playerid,"TaxiDuty");
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
		SCM(GetPVarInt(playerid,"mechanic"),COLOR_LIGHTRED," Заказчик вышел из игры!");
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
		TogglePlayerControllableEx(playerid, true);
		SetCameraBehindPlayer(playerid);
	}
	if(GetPVarInt(playerid,"BoneStol")) ExitBone(playerid);
	PlayerTextDrawDestroy(playerid,RouletText[playerid]);
	if(SpecID[playerid] != INVALID_PLAYER_ID)
	{
		if(Spectate[SpecID[playerid]] == 1 && SpecAd[SpecID[playerid]] == playerid)
		{
			GameTextForPlayer(SpecID[playerid], "~r~~n~PLAYER DISCONNECT", 5000, 4);
			ShowPlayerDialogEx(SpecID[playerid], 203, DIALOG_STYLE_MSGBOX, "Игрок вышел", "Игрок, за которым вы следили, вышел\nХотите отключить Recon?", "Выйти", "Отмена");
			DisallowSpawn[playerid] = 1;
		}
	}
	if(SpecAd[playerid] != 65535)
	{
		SpecID[SpecAd[playerid]] = 65535;
		SpecAd[playerid] = 65535;
	}
	SpecID[playerid] = 65535;
	if(tipsterplayer == playerid)
	{
		SendRadioMessage(2,COLOR_ISPOLZUY ," Игрок покинул район. Прослушивание отключено");
		tipsteron = -1;
		tipsterplayer = -1;
	}
	if(GetPVarInt(playerid,"fish_began")) RemovePlayerAttachedObject(playerid,0);
	if(PlayerCuffed[playerid] > 0 && reason == 1 && PTEMP[playerid][pJailTime] == 0)
	{
		PTEMP[playerid][pWantedLevel] = 0;
		PTEMP[playerid][pJailTime] = 3600;
		PTEMP[playerid][pArrested] += 1;
		PTEMP[playerid][pMestoJail] = 1;
	}
	if(creatcar[playerid] != -1)
	{
		DestroyVehicle(creatcar[playerid]);
		creatcar[playerid] = -1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPVarInt(playerid,"TaxiDuty")) Delete3DTextLabel(JobText3D[GetPlayerVehicleID(playerid)]);
	SetPVarInt(playerid,"Register",0);
	if(avtocar[playerid] != 0)
	{
		if(caroff[avtocar[playerid]] == 1) DestroyVehicle(avtocar[playerid]);
		avtocar[playerid] = 0;
		if(PTEMP[playerid][pSkilla] > 0) PTEMP[playerid][pSkilla]--;
	}
	if(tookmoped[playerid] != 0) DestroyVehicle(tookmoped[playerid]);
	if(GetPVarInt(playerid, "TypeBus") > 0)
	{
		DeletePVar(playerid, "BusTime");
		DeletePVar(playerid, "TypeBus");
		DeletePVar(playerid, "BusStop");
		DeletePVar(playerid, "BusMoney");
		PTEMP[playerid][pPayCheck] -= GetPVarInt(playerid,"BusRepairMoney");
		DeletePVar(playerid, "BusRepairMoney");
		pPressed[playerid] = 0;
		Delete3DTextLabel(JobText3D[GetPlayerVehicleID(playerid)]);
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		DisablePlayerRaceCheckpoint(playerid);
	}
	mysql_format(DATABASE, QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pLogin = '0' WHERE name = '%e'",PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	if(house_car[playerid] != -1)
	{
		new bool:proverka;
		foreach(i)
		{
			if(avtocar[i] == house_car[playerid]) proverka = true;
		}
		if(proverka == true) caroff[house_car[playerid]] = 1;
		else DestroyVehicle(house_car[playerid]);
		CarInfo[playerid][carFuel][0] = Fuell[house_car[playerid]];
		house_car[playerid] = -1;
		createdcar --;
	}
	DestroyVehicle(garage_car[playerid][0]);
	DestroyVehicle(garage_car[playerid][1]);
	DestroyVehicle(garage_car[playerid][2]);
	DestroyVehicle(garage_car[playerid][3]);
	DestroyVehicle(garage_car[playerid][4]);
	//SaveMySQL(10,playerid);
	for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) if(IsPlayerAttachedObjectSlotUsed(playerid, i)) RemovePlayerAttachedObject(playerid, i);
	PlayerTextDrawDestroy(playerid, Capture[playerid]);
	if(PTEMP[playerid][pJob] == 2 && gcontract[playerid] == 1) Delete3DTextLabel(Meh3d[GetPlayerVehicleID(playerid)]), gcontract[playerid] = 0;
	new sendername[MAX_PLAYER_NAME];
	new year, month,day;
	MehJob[playerid] = 999;
	format(WantNickChange[playerid],MAX_PLAYER_NAME, "");
	getdate(year, month, day);
	new hour, minute, second;
	gettime(hour, minute, second);
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
	mysql_format(DATABASE,QUERY, 384, "UPDATE `"TABLE_ACCOUNTS"` SET pVhoddata = '%i',pVhodMes = '%i',pVhodchas = '%i',pVhodminute = '%i' WHERE name = '%e'",day,month,hour,minute,PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	ebanksf[playerid] = 0;
	Tune[playerid] = 0;
	robh[playerid] = false;
	Flood[playerid] = 0;
	SelectCharPlace[playerid] = 0;
	CharPrice[playerid] = 0;
	SelectCharID[playerid] = 0;
	SelectChar[playerid] = 0;
	PicCP[playerid] = 0;
	tex[playerid] = 0;
	tex2[playerid] = 0;
	PicCP[playerid] = 0;
	enterbiz[playerid] = 0;
	//KillTimer(Timerkk[playerid]);
	TextDrawHideForPlayer(playerid, BoxPanel);// СПидометр
	PlayerTextDrawDestroy(playerid,SpeedShow[playerid]);
	PlayerTextDrawDestroy(playerid,FuelShow[playerid]);
	PlayerTextDrawDestroy(playerid,StatusShow[playerid]);
	PlayerTextDrawDestroy(playerid,KMShow[playerid]);
	PlayerTextDrawDestroy(playerid,LimitShow[playerid]);
	PlayerTextDrawDestroy(playerid,FillShow[playerid]);
	PlayerTextDrawDestroy(playerid,FishingText[playerid]);
	TextDrawHideForPlayer(playerid, Speed);
	//for(new i; i < 5; i++) TextDrawHideForPlayer(playerid, Tookfaggio[i]);
	//KillTimer(STimer[playerid]);
	arenda[playerid] = 0;
	chet[playerid] = 0;
	arenda[playerid] = 0;
	zd[playerid] = 0;
	proverkaforma[playerid] = 0;
	SetPlayerSkills(playerid);
	SelectCharPlace[playerid] = 0;
	CharPrice[playerid] = 0;
	SelectCharID[playerid] = 0;
	SaveMySQL(2, playerid);
	PTEMP[playerid][pAdmin] = 0;
	PTEMP[playerid][pLogin] = 0;
	for(new i=0;i<players;i++)
	{
		if(Players[i]==playerid)
		{
			Players[i]=Players[--players];
			Players[players]=-1;
			break;
		}
	}
	for(new i = 0; i < 5; i++)
	{
		if(spys[i][0] == playerid)
		{
		    spys[i][0] = -1;
		    spys[i][1] = -1;
		    format(YCMDstr, 80, " (( Шпион %s вышел из игры. Маскировка освободилась ))", PTEMP[playerid][pName]);
			SendFamilyMessage(2, 0x00b953ff, YCMDstr);
		}
	}
	new pIps[32];
	GetPlayerIp(playerid, pIps, 32);
	new szDisconnectReason[3][] =
    {
        "Крэш",
        "Самовольно",
        "Принудительно"
    };
	printf("Игрок %s вышел с сервера IP: [%s] (%s)",PTEMP[playerid][pName], pIps, szDisconnectReason[reason]);
	return true;
}