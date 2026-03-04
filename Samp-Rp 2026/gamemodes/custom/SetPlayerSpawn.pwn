SetPlayerSpawn(playerid)
{
	DollahScoreUpdate(playerid);
	if(IsPlayerConnected(playerid))
	{
		if(PTEMP[playerid][pQuestShow] == 0)
		{
			ShowPlayerDialogEx(playerid,11228,DIALOG_STYLE_MSGBOX,"Задание","Здравствуйте! Вам пишет,игровой робот-спамер,по распоряжению Администрации нашего проекта.\nМы с администрацией рады каждому новому игроку и очень переживаем,\nчто новичкам иногда трудно разобраться в игре сразу после регистрации.\nПо этой причине мы приготовили небольошое описание действий,\nкоторое надо совершить в первую очередь,чтобы понять основные игровые моменты",
			"Готово","");
			PlayerPlaySound(playerid, 4201, 0.0, 0.0, 0);
			PTEMP[playerid][pQuestShow] = 1;
		}
		if(PTEMP[playerid][pHP] > 100) PTEMP[playerid][pHP] = 100;
		if(PTEMP[playerid][pWantedLevel] >= 1) SetPlayerWantedLevel(playerid,PTEMP[playerid][pWantedLevel] );
		SetPlayerHealthAC(playerid, PTEMP[playerid][pHP]);
		new house = PTEMP[playerid][pPHouseKey];
		//SetCameraBehindPlayer(playerid);
		switch(PTEMP[playerid][pMember] && GetPVarInt(playerid,"Fraction_Duty"))
		{
		case 1,2,3,4,7,8,9,10,11,16,19,20,21,22,23:
			{
				ResetPlayerWeapons(playerid);
				SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
			}
		}
		switch(PTEMP[playerid][pMember] && !GetPVarInt(playerid,"Fraction_Duty"))
		{
		case 1,2,3,4,7,8,9,10,11,16,19,20,21,22,23:
			{
				SetPlayerSkin(playerid, PTEMP[playerid][pChar][0]);
				SetPlayerColor(playerid, TEAM_HIT_COLOR);
			}
		}
		if(GetPVarInt(playerid,"Fraction_Duty"))
		{
			switch(PTEMP[playerid][pMember])
			{
			case 5,6,14:
				{
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerToTeamColor(playerid);
				}
			case 12,13,15,17,18:
				{
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerToTeamColor(playerid);
					GiveWeapon(playerid,5,1);
				}
			case 24,26,29:
			    {
			    	SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerToTeamColor(playerid);
					GiveWeapon(playerid,7,1);
			    }
			}
		}
		if(GetPVarInt(playerid,"Fraction_Duty"))
		{
			switch(PTEMP[playerid][pMember])
			{
			case 5: GiveWeapon(playerid,2,1);
			case 14: GiveWeapon(playerid,1,1);
			case 6: GiveWeapon(playerid,8,1);
			case 9, 16, 20: GiveWeapon(playerid, 43, 60);
			
			}
		}
		if(PTEMP[playerid][pMember] <= 0)
		{
			SetPlayerSkin(playerid, PTEMP[playerid][pChar][0]);
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
		}
		//----------------------------------------------------------------------
		if(PTEMP[playerid][pJailTime] > 0)
		{
			switch(PTEMP[playerid][pMestoJail])
			{
			case 1:
				{
					SetPlayerInterior(playerid, 6);
					SetPlayerPos(playerid,264.1425,77.4712,1001.0391);
					SetPlayerFacingAngle(playerid, 263.0160);
					return true;
				}
			case 2:
				{
					SetPlayerInterior(playerid, 10);
					SetPlayerPos(playerid,219.5400,109.9767,999.0156);
					SetPlayerFacingAngle(playerid, 1.0000);
					return true;
				}
			case 3:
				{
					SetPlayerInterior(playerid, 3);
					SetPlayerPos(playerid,198.3642,161.8103,1003.0300);
					SetPlayerFacingAngle(playerid, 1.0000);
					return true;
				}
			case 4:
				{
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid,5512.2275,1248.5988,8.8505);
					return true;
				}
			}
		}
		if(GetPVarInt(playerid, "player_paint") == 2 && paint_info[1] == 2)
		{
			GiveWeapon(playerid, 24, 28);//PaintGun[random(sizeof(PaintGun))], 300);
			new rand = random(sizeof(PaintballSpawns));
			SetPlayerPos(playerid, PaintballSpawns[rand][0], PaintballSpawns[rand][1], PaintballSpawns[rand][2]);
			SetPlayerInterior(playerid,0);
			return true;
		}
		if(training[playerid] != 0)
		{
			SetPlayerInterior(playerid,5);
			SetPlayerPos(playerid,772.2284,8.0465,1000.7086);
			SetPlayerFacingAngle(playerid, 90.4423);
			SetPlayerSkin(playerid,81);
			return true;
		}
		if(house != 9999)//если есть дом
		{
			if((!GetPVarInt(playerid, "Fraction_Duty") && PTEMP[playerid][pSpawnChange][0] == 0) || (PTEMP[playerid][pSpawnChange][1] == 0 && GetPVarInt(playerid, "Fraction_Duty")))
			{
				SetPlayerInterior(playerid,HouseInfo[house][hInt]);
				SetPlayerPos(playerid, HouseInfo[house][hExitx], HouseInfo[house][hExity],HouseInfo[house][hExitz]);
				SetPlayerVirtualWorld(playerid, house+50);
				return true;
			}
		}
		if(KGet(playerid))
		{
			if(PTEMP[playerid][pSpawnChange][0] == 0 || PTEMP[playerid][pSpawnChange][1] == 0)
			{
				if(kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] == 0)
				{
					SetPVarInt(playerid, "podeezd", kvartinfo[PTEMP[playerid][pKvartiraKey]][virtmir]);
					SetPlayerPos(playerid,2283.3474,-1139.2313,1050.8984);
					SetPlayerInterior(playerid,11);
					SetPlayerVirtualWorld(playerid, PTEMP[playerid][pKvartiraKey]);
					return true;
				}
				else if(kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] == 1)
				{
					SetPVarInt(playerid, "podeezd", kvartinfo[PTEMP[playerid][pKvartiraKey]][virtmir]);
					SetPlayerPos(playerid,31.3584,-84.8000,1004.2859);
					SetPlayerInterior(playerid,15);
					SetPlayerVirtualWorld(playerid, PTEMP[playerid][pKvartiraKey]);
					return true;
				}
				else if(kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] == 2)
				{
					SetPVarInt(playerid, "podeezd", kvartinfo[PTEMP[playerid][pKvartiraKey]][virtmir]);
					SetPlayerPos(playerid,58.2073,-79.1497,1004.2859);
					SetPlayerInterior(playerid,15);
					SetPlayerVirtualWorld(playerid, PTEMP[playerid][pKvartiraKey]);
					return true;
				}
			}
		}
		if(!HGet(playerid) && !KGet(playerid) && (PTEMP[playerid][pSpawnChange][0] == 0 || PTEMP[playerid][pSpawnChange][1] == 0)) PTEMP[playerid][pSpawnChange][0] = 1,PTEMP[playerid][pSpawnChange][1] = 1;
		if(GetPVarInt(playerid,"Fraction_Duty"))
		{
		    if(PTEMP[playerid][pSpawnChange][1] == 1)
			switch(PTEMP[playerid][pMember])
			{
			case 1:
				{
					SetPlayerInterior(playerid, 6);
					SetPlayerPos(playerid, 234.6674,71.9187,1005.0391);
					SetPlayerFacingAngle(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
					SetPVarInt(playerid, "inUchastok", 1);
					return true;
				}
			case 2:
				{
					SetPlayerInterior(playerid, 3);
					SetPlayerPos(playerid, -2462.2571,506.4978,1039.1460);
					SetPlayerFacingAngle(playerid, 90.000);
					SetPlayerVirtualWorld(playerid, 130);
					return true;
				}
			case 3:
				{
					if(forma[playerid] == 1)
					{
						SetPlayerSkin(playerid, 252);
						SetPlayerInterior(playerid, 0);
						SetPlayerPos(playerid, -1346.2050,492.3983,11.2027);
						SetPlayerVirtualWorld(playerid, 0);
						return true;
					}
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, -1371.6482,492.1947,11.1953);
					SetPlayerVirtualWorld(playerid, 0);
					return true;
				}
			case 4:
				{
					if(PTEMP[playerid][pJobHeal] == 1) // SF
					{
						SetPlayerInterior(playerid, 15);
						SetPlayerVirtualWorld(playerid, 3);
						SetPlayerPos(playerid, 303.7660,169.1190,1214.7949);
						SetPlayerFacingAngle(playerid, 269.1964);
					}
					else if(PTEMP[playerid][pJobHeal] == 2) // LS
					{
						SetPlayerInterior(playerid, 15);
						SetPlayerVirtualWorld(playerid, 4);
						SetPlayerPos(playerid, 303.7660,169.1190,1214.7949);
						SetPlayerFacingAngle(playerid, 269.1964);
					}
					else if(PTEMP[playerid][pJobHeal] == 3)// LV
					{
						SetPlayerInterior(playerid, 15);
						SetPlayerVirtualWorld(playerid, 5);
						SetPlayerPos(playerid, 303.7660,169.1190,1214.7949);
						SetPlayerFacingAngle(playerid, 269.1964);
					}
					else if(PTEMP[playerid][pJobHeal] == 4)// FC
					{
						SetPlayerInterior(playerid, 15);
						SetPlayerVirtualWorld(playerid, 6);
						SetPlayerPos(playerid, 303.7660,169.1190,1214.7949);
						SetPlayerFacingAngle(playerid, 269.1964);
					}
					else if(PTEMP[playerid][pJobHeal] == 5)// CGH
					{
						SetPlayerInterior(playerid, 15);
						SetPlayerVirtualWorld(playerid, 7);
						SetPlayerPos(playerid, 303.7660,169.1190,1214.7949);
						SetPlayerFacingAngle(playerid, 269.1964);
					}
					return true;
				}
			case 7:
				{
					SetPlayerInterior(playerid, 3);
					SetPlayerPos(playerid, 365.1517,190.6857,1014.1875);
					SetPlayerFacingAngle(playerid, 178.5881);
					SetPlayerVirtualWorld(playerid, 0);
					useguns[playerid] = 0;
					if(PTEMP[playerid][pRank] > 2 && PTEMP[playerid][pRank] < 5)
					{
						GiveWeapon(playerid,24,21);
						SetPlayerArmourAC(playerid, 100);
					}
					return true;
				}
			case 8:
				{
					SetPlayerInterior(playerid, 1);
					SetPlayerPos(playerid, 2151.4502,1602.8522,1006.1752);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 269.7087);
					SetPlayerVirtualWorld(playerid, 0);
					return true;
				}
			case 9:
				{
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, -2066.8550,463.0319,191.0859);
					SetPlayerVirtualWorld(playerid, 2);
					gNews[playerid] = 0;
					return true;
				}
			case 10:
				{
					SetPlayerInterior(playerid, 10);
					SetPlayerPos(playerid, 222.0488,111.5337,1010.2118);
					SetPlayerFacingAngle(playerid, 268.9050);
					SetPlayerVirtualWorld(playerid, 0);
					SetPVarInt(playerid, "inUchastok", 1);
					return true;
				}
			case 11:
				{
					SetPlayerInterior(playerid, 3);
					SetPlayerPos(playerid, -2055.3396,-110.8650,1035.2432);
					SetPlayerVirtualWorld(playerid, 1);
					SetPlayerFacingAngle(playerid, 90.1673);
					return true;
				}
			case 16:
				{
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, 1641.5293,-1633.2429,101.0859);
					SetPlayerFacingAngle(playerid, 359.8156);
					SetPlayerVirtualWorld(playerid, 1);
					lNews[playerid] = 0;
					return true;
				}
			case 19:
				{
					if(forma[playerid] == 1)
					{
						SetPlayerSkin(playerid, 252);
						SetPlayerInterior(playerid, 0);
						SetPlayerPos(playerid, 241.7503,1852.6790,8.7578);
						SetPlayerVirtualWorld(playerid, 0);
						return true;
					}
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, 241.7503,1852.6790,8.7578);
					SetPlayerVirtualWorld(playerid, 0);
					return true;
				}
			case 20:
				{
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, 2634.1272,1214.9916,41.6859);
					SetPlayerVirtualWorld(playerid, 3);
					LvNews[playerid] = 0;
					return true;
				}
			case 21:
				{
					SetPlayerInterior(playerid, 3);
					SetPlayerPos(playerid, 228.6151,180.0210,1003.0313);
					SetPlayerFacingAngle(playerid, 86.629);
					SetPlayerVirtualWorld(playerid, 122);
					SetPVarInt(playerid, "inUchastok", 1);
					return true;
				}
			case 22:
				{
					SetPlayerInterior(playerid, 15);
					SetPlayerVirtualWorld(playerid, 4);
					SetPlayerPos(playerid, 372.0985,-53.2946,1076.4708);
					SetPlayerFacingAngle(playerid, 90.0000);
					return true;
				}
			case 33:
				{
					SetPlayerInterior(playerid, 15);
					SetPlayerVirtualWorld(playerid, 5);
					SetPlayerPos(playerid, 372.0985,-53.2946,1076.4708);
					SetPlayerFacingAngle(playerid, 90.0000);
					return true;
				}
			case 34:
				{
					SetPlayerInterior(playerid, 3);
					SetPlayerVirtualWorld(playerid, 1);
					SetPlayerPos(playerid, 1491.0817,1306.0920,1093.2964);
					return true;
				}
			}
		}
		switch(PTEMP[playerid][pMember])
		{
		case 3:
			{
				if(PTEMP[playerid][pRank] < 3)
				{
					SetPVarInt(playerid,"Fraction_Duty",1);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SCM(playerid, COLOR_BLUE,"Рабочий день начат");
					SetPlayerToTeamColor(playerid);
					if(forma[playerid] == 1)
					{
						SetPlayerSkin(playerid, 252);
						SetPlayerInterior(playerid, 0);
						SetPlayerPos(playerid, -1346.2050,492.3983,11.2027);
						SetPlayerVirtualWorld(playerid, 0);
						return true;
					}
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, -1371.6482,492.1947,11.1953);
					SetPlayerVirtualWorld(playerid, 0);
					return true;
				}
			}
		case 19:
			{
				if(PTEMP[playerid][pRank] < 3)
				{
					SetPVarInt(playerid,"Fraction_Duty",1);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SCM(playerid, COLOR_BLUE,"Рабочий день начат");
					SetPlayerToTeamColor(playerid);
					if(forma[playerid] == 1)
					{
						SetPlayerSkin(playerid, 252);
						SetPlayerInterior(playerid, 0);
						SetPlayerPos(playerid, 241.7503,1852.6790,8.7578);
						SetPlayerVirtualWorld(playerid, 0);
						return true;
					}
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, 241.7503,1852.6790,8.7578);
					SetPlayerVirtualWorld(playerid, 0);
					return true;
				}
			}
		case 5:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 5);
					SetPlayerPos(playerid, 1265.7104,-793.7453,1084.0078);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerVirtualWorld(playerid, 2);
					return true;
				}
			}
		case 6:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 5);
					SetPlayerPos(playerid, 1265.7104,-793.7453,1084.0078);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerVirtualWorld(playerid, 0);
					return true;
				}
			}
		case 12:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerPos(playerid, -61.2984,1364.5847,1080.2109);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 100);
					SetPlayerInterior(playerid,6);
					SetPlayerVirtualWorld(playerid, 34);
					return true;
				}
			}
		case 13:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 4);
					SetPlayerVirtualWorld(playerid, 75);
					SetPlayerFacingAngle(playerid, 358.0241);
					SetPlayerPos(playerid, 2795.6206,-1605.5884,-36.9231);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					return true;
				}
			}
		case 14:
			{
				if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 5);
					SetPlayerPos(playerid, 1265.7104,-793.7453,1084.0078);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerVirtualWorld(playerid, 1);
					GiveWeapon(playerid,1,2);
					return true;
				}
			}
		case 15:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 3);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerPos(playerid,  2496.012939,-1708.923217,1014.742187);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 0.191693);
					SetPlayerVirtualWorld(playerid, 1);
					return true;
				}
			}
		case 17:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerFacingAngle(playerid, 90.4248);
					SetPlayerPos(playerid, -49.7558,1400.3553,1084.4297);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerInterior(playerid,8);
					SetPlayerVirtualWorld(playerid, 36);
					return true;
				}
			}
		case 18:
			{
				if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 8);
					SetPlayerVirtualWorld(playerid, 63);
					SetPlayerPos(playerid, 2808.9631,-1169.0806,1025.5703);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					RemovePlayerAttachedObject(playerid, 1);
					return true;
				}
			}
		case 23:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerVirtualWorld(playerid, 2);
					return true;
				}
			}
		case 24:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerVirtualWorld(playerid, 52);
					return true;
				}
			}
		case 25:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerVirtualWorld(playerid, 4);
					return true;
				}
			}
		case 26:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerVirtualWorld(playerid, 998);
					return true;
				}
			}
		case 27:
			{
				if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerVirtualWorld(playerid, 6);
					return true;
				}
			}
		case 28:
			{
				if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerVirtualWorld(playerid, 7);
					return true;
				}
			}
		case 29:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerVirtualWorld(playerid, 8);
					return true;
				}
			}
		case 30:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerVirtualWorld(playerid, 9);
					return true;
				}
			}
		case 31:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerVirtualWorld(playerid, 10);
					return true;
				}
			}
		case 32:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid, 508.3728,-78.6393,998.9609);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerFacingAngle(playerid, 7.3397);
					SetPlayerVirtualWorld(playerid, 11);
					return true;
				}
			}
		case 34:
			{
			    if(PTEMP[playerid][pSpawnChange][1] != 0)
			    {
					SetPlayerInterior(playerid, 3);
					SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
					SetPlayerVirtualWorld(playerid, 1);
					SetPlayerPos(playerid, 1491.0817,1306.0920,1093.2964);
					return true;
				}
			}
		}
	}
    //if(!GetPVarInt(playerid, "Fraction_Duty") && PTEMP[playerid][pSpawnChange][0] == 1)
	switch (PTEMP[playerid][pLevel])
	{
	case 1:
    {
        if (PTEMP[playerid][pExp] >= 4)
        {
            SetPlayerPos(playerid, 1754.2037,-1920.7112,13.5721);
            SetPlayerFacingAngle(playerid, 270.5025);
            SetPlayerInterior(playerid,0);
            SetPlayerVirtualWorld(playerid, 0);
            return true;
        }
        SetPlayerPos(playerid, 1154.3717, -1769.2594, 16.5938);
        SetPlayerFacingAngle(playerid, 0.6853);
        SetPlayerInterior(playerid,0);
        SetPlayerVirtualWorld(playerid, 0);
    }
	case 2:
    {
        SetPlayerPos(playerid, 2231.3958,-1159.7759,25.8330);
        SetPlayerFacingAngle(playerid,88.0242);
        SetPlayerInterior(playerid,0);
        SetPlayerVirtualWorld(playerid, 0);
    }
	case 3..5:
    {
        SetPlayerPos(playerid, -1967.2679,115.1929,27.6875);
        SetPlayerFacingAngle(playerid, 1.3365);
        SetPlayerInterior(playerid,0);
        SetPlayerVirtualWorld(playerid, 0);
    }
	case 6..1000:
    {
        SetPlayerPos(playerid, 2848.7043,1294.0205,11.3906);
        SetPlayerFacingAngle(playerid, 90.0000);
        SetPlayerInterior(playerid,0);
        SetPlayerVirtualWorld(playerid, 0);
    }
	}
	return true;
}