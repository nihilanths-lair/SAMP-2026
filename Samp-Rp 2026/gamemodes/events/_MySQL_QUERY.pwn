publics:_MySQL_QUERY(idx, playerid, str[])
{
	new r, f, x;
	cache_get_data(r, f);
	switch (idx){
	case 0:
	{
		if (!r) return print("[Загрузка ...] Данные из Others не получены!");
		FracBank[0][fLsnews] =  cache_get_row_int(0,0, DATABASE);
		FracBank[0][fSfnews] =  cache_get_row_int(0,1, DATABASE);
		FracBank[0][fLvnews] =  cache_get_row_int(0,2, DATABASE);
		FracBank[0][fBallas] =  cache_get_row_int(0,3, DATABASE);
		FracBank[0][fVagos] = 	cache_get_row_int(0,4, DATABASE);
		FracBank[0][fGrove] = 	cache_get_row_int(0,5, DATABASE);
		FracBank[0][fAztek] = 	cache_get_row_int(0,6, DATABASE);
		FracBank[0][fRifa] = 	cache_get_row_int(0,7, DATABASE);
		FracBank[0][fKazna] = 	cache_get_row_int(0,8, DATABASE);
		FracBank[0][fSsmc] = 	cache_get_row_int(0,9, DATABASE);
		FracBank[0][fHamc] = 	cache_get_row_int(0,10, DATABASE);
		FracBank[0][fOmc] = 	cache_get_row_int(0,11, DATABASE);
		FracBank[0][fWmc] = 	cache_get_row_int(0,12, DATABASE);
		FracBank[0][fHwmc] = 	cache_get_row_int(0,13, DATABASE);
		FracBank[0][fFsmc] = 	cache_get_row_int(0,14, DATABASE);
		FracBank[0][fPmc] = 	cache_get_row_int(0,15, DATABASE);
		FracBank[0][fMmc] = 	cache_get_row_int(0,16, DATABASE);
		FracBank[0][fVmc] = 	cache_get_row_int(0,17, DATABASE);
		FracBank[0][fBmc] = 	cache_get_row_int(0,18, DATABASE);
		ballashel = 			cache_get_row_int(0,19, DATABASE);
		groovhel = 				cache_get_row_int(0,20, DATABASE);
		vagoshel = 				cache_get_row_int(0,21, DATABASE);
		aztekhel = 				cache_get_row_int(0,22, DATABASE);
		rifahel = 				cache_get_row_int(0,23, DATABASE);
		addd[0] = 				cache_get_row_int(0,24, DATABASE);
		addd[1] = 				cache_get_row_int(0,25, DATABASE);
		addd[2] = 				cache_get_row_int(0,26, DATABASE);
		healpric = 				cache_get_row_int(0,27, DATABASE);
		yakuzahel = 			cache_get_row_int(0,28, DATABASE);
		lcnhel = 				cache_get_row_int(0,29, DATABASE);
		rmhel = 				cache_get_row_int(0,30, DATABASE);
		lsamatbi = 				cache_get_row_int(0,31, DATABASE);
		armmatbi = 				cache_get_row_int(0,32, DATABASE);
		armmatsf = 				cache_get_row_int(0,33, DATABASE);
		ssmcmatbi = 			cache_get_row_int(0,34, DATABASE);
		hamcmatbi = 			cache_get_row_int(0,35, DATABASE);
		omcmatbi = 				cache_get_row_int(0,36, DATABASE);
		wmcmatbi = 				cache_get_row_int(0,37, DATABASE);
		hwmcmatbi = 			cache_get_row_int(0,38, DATABASE);
		fsmcmatbi = 			cache_get_row_int(0,39, DATABASE);
		vmcmatbi = 				cache_get_row_int(0,40, DATABASE);
		pmcmatbi = 				cache_get_row_int(0,41, DATABASE);
		mmcmatbi = 				cache_get_row_int(0,42, DATABASE);
		bmcmatbi = 				cache_get_row_int(0,43, DATABASE);
		rifamatbi = 			cache_get_row_int(0,44, DATABASE);
		ballasmatbi = 			cache_get_row_int(0,45, DATABASE);
		aztekmatbi = 			cache_get_row_int(0,46, DATABASE);
		vagosmatbi = 			cache_get_row_int(0,47, DATABASE);
		groovmatbi = 			cache_get_row_int(0,48, DATABASE);
		lspdmatbi = 			cache_get_row_int(0,49, DATABASE);
		fbimats = 				cache_get_row_int(0,50, DATABASE);
		yakuzamats = 			cache_get_row_int(0,51, DATABASE);
		rmmats = 				cache_get_row_int(0,52, DATABASE);
		lcnmats = 				cache_get_row_int(0,53, DATABASE);
		sfpdmats = 				cache_get_row_int(0,54, DATABASE);
		lvpdmats = 				cache_get_row_int(0,55, DATABASE);
		MafiaBank[0][nLcn] = 	cache_get_row_int(0,56, DATABASE);
		MafiaBank[0][nYakuza] = cache_get_row_int(0,57, DATABASE);
		MafiaBank[0][nRm] = 	cache_get_row_int(0,58, DATABASE);
		BestGang =              cache_get_row_int(0,59, DATABASE);
		slit =                  cache_get_row_int(0,60, DATABASE);
		new strs[32];
		cache_get_row(0, 61, strs, DATABASE, 32);
		sscanf(strs, "p<,>iii", newsZP[1], newsZP[1], newsZP[2]);
		print("[Загрузка ...] Данные из Others получены!");
		CreateVehicles();
	}
	case 1:
	{
		if (!r) return print(" [Аукцион] Нет аккаунта. Деньги не были зачислены!");
		mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pBank = pBank + %i WHERE Name = '%e'",BizzInfo[bizselect[playerid]][bLastStavka],BizzInfo[bizselect[playerid]][bNameStavka]);
		mysql_function_query(DATABASE, QUERY, false, "", "");
		printf("Игроку %s были зачислены %i вирт за аукцион",BizzInfo[bizselect[playerid]][bNameStavka],BizzInfo[bizselect[playerid]][bLastStavka]);
	}
	case 2:
	{
		if (!r)
		{
			if (GetPVarInt(playerid, "wrongPass") == 2) return SCM(playerid,COLOR_LIGHTRED," Неверный пароль. Используйте /q для выхода."), Kick(playerid);
			SetPVarInt(playerid, "wrongPass", GetPVarInt(playerid, "wrongPass")+1);
			format(QUERY,256, "{FF6347}Внимание!Вы ввели неверный пароль!\n\tУ вас осталось (%i) попытки\nПосле вы будете на время забанены",3-GetPVarInt(playerid, "wrongPass"));
			ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX, "Ошибка!",QUERY, "Повтор", "Выйти");
			PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			printf("Игрок %s ввёл неверный пароль",Name(playerid));
			return true;
		}
		DeletePVar(playerid,"time_logged");

		PTEMP[playerid][pLevel] = 			cache_get_field_content_int(0,"pLevel");
		PTEMP[playerid][pHelper] = 		cache_get_field_content_int(0,"pHelper");
		PTEMP[playerid][pRatingSupport] = cache_get_field_content_int(0, "pRatingSupport");
		PTEMP[playerid][pJobHeal] =		cache_get_field_content_int(0,"pJobHeal");
		PTEMP[playerid][pMestoJail] = 		cache_get_field_content_int(0,"pMestoJail");
		cache_get_field_content(0,	"pIp", 		PTEMP[playerid][pIp],DATABASE,128);
		cache_get_field_content(0,	"pvIp", 	PTEMP[playerid][pvIp],DATABASE,128);
		cache_get_field_content(0,	"pIpReg", 	PTEMP[playerid][pIpReg],DATABASE,128);
		PTEMP[playerid][pHousecash] = 		cache_get_field_content_int(0,"pHousecash");
		PTEMP[playerid][pCheckip] = 		cache_get_field_content_int(0,"pCheckip");
		PTEMP[playerid][pGoogleIP] =        cache_get_field_content_int(0,"pGoogleIP");
		PTEMP[playerid][pText] = 			cache_get_field_content_int(0,"pText");
		cache_get_field_content(0,	"pKeyip", 	PTEMP[playerid][pKeyip],DATABASE,128);
		PTEMP[playerid][pHP] = 			cache_get_field_content_float(0,"pHP");
		PTEMP[playerid][pSatiety] = 		cache_get_field_content_int(0,"pSatiety");
		cache_get_field_content(0,	"pDataReg", PTEMP[playerid][pDataReg],DATABASE,128);
		PTEMP[playerid][pDonateRank] = 	cache_get_field_content_int(0,"pDonateRank");
		PTEMP[playerid][pMats] = 			cache_get_field_content_int(0,"pMats");
		PTEMP[playerid][pSex] = 			cache_get_field_content_int(0,"pSex");
		PTEMP[playerid][pArrested] = 		cache_get_field_content_int(0,"pArrested");
		PTEMP[playerid][pMuted] = 			cache_get_field_content_int(0,"pMuted");
		PTEMP[playerid][pCrimes] = 		cache_get_field_content_int(0,"pCrimes");
		PTEMP[playerid][pExp] = 			cache_get_field_content_int(0,"pExp");
		PTEMP[playerid][pCash] = 			cache_get_field_content_int(0,"pCash");
		PTEMP[playerid][pPHouseKey] = 			cache_get_field_content_int(0,"pPHouseKey");
		PTEMP[playerid][pKvartiraKey] = 			cache_get_field_content_int(0,"pKvartiraKey");
		//PTEMP[playerid][pAdmin] = 			cache_get_field_content_int(0,"pAdmin");
		PTEMP[playerid][pChar][0] = 			cache_get_field_content_int(0,"pChar");
		PTEMP[playerid][pPBizzKey] = 			cache_get_field_content_int(0,"pPBizzKey");
		PTEMP[playerid][pPFarmKey] = 			cache_get_field_content_int(0,"pPFarmKey");
		PTEMP[playerid][pPLimitBank] = 			cache_get_field_content_int(0,"pPLimitBank");
		PTEMP[playerid][pWantedDeaths] = 	cache_get_field_content_int(0,"pWantedDeaths");
		PTEMP[playerid][pPayCheck] = 		cache_get_field_content_int(0,"pPayCheck");
		PTEMP[playerid][pJailTime] =		cache_get_field_content_int(0,"pJailTime");
		PTEMP[playerid][pDrugs] =			cache_get_field_content_int(0,"pDrugs");
		PTEMP[playerid][pLeader] =			cache_get_field_content_int(0,"pLeader");
		PTEMP[playerid][pMember] =			cache_get_field_content_int(0,"pMember");
		PTEMP[playerid][pRank] =			cache_get_field_content_int(0,"pRank");
		PTEMP[playerid][pJob] =			cache_get_field_content_int(0,"pJob");
		PTEMP[playerid][pModel] =			cache_get_field_content_int(0,"pModel");
		PTEMP[playerid][pPnumber] =		cache_get_field_content_int(0,"pPnumber");
		PTEMP[playerid][pDirectory] =		cache_get_field_content_int(0,"pDirectory");
		PTEMP[playerid][pVhoddata] =		cache_get_field_content_int(0,"pVhoddata");
		PTEMP[playerid][pVhodMes] =		cache_get_field_content_int(0,"pVhodMes");
		PTEMP[playerid][pVhodchas] =		cache_get_field_content_int(0,"pVhodchas");
		PTEMP[playerid][pVhodminute] =		cache_get_field_content_int(0,"pVhodminute");
		PTEMP[playerid][pCarLic] =			cache_get_field_content_int(0,"pCarLic");
		PTEMP[playerid][pFlyLic] =			cache_get_field_content_int(0,"pFlyLic");
		PTEMP[playerid][pBoatLic] =		cache_get_field_content_int(0,"pBoatLic");
		PTEMP[playerid][pFishLic] =		cache_get_field_content_int(0,"pFishLic");
		PTEMP[playerid][pGunLic] =			cache_get_field_content_int(0,"pGunLic");
		PTEMP[playerid][pBizLic] =			cache_get_field_content_int(0,"pBizLic");
		PTEMP[playerid][pZakonp] =			cache_get_field_content_int(0,"pZakonp");
		PTEMP[playerid][pAddiction] =		cache_get_field_content_int(0,"pAddiction");
		PTEMP[playerid][pNarcoLomka] =		cache_get_field_content_int(0,"pNarcoLomka");
		PTEMP[playerid][pPayDayHad] =		cache_get_field_content_int(0,"pPayDayHad");
		PTEMP[playerid][pTut] =			cache_get_field_content_int(0,"pTut");
		PTEMP[playerid][pWarns] =			cache_get_field_content_int(0,"pWarns");
		PTEMP[playerid][OffWarns] =			cache_get_field_content_int(0,"OffWarns");
		PTEMP[playerid][punWarns] =		cache_get_field_content_int(0,"punWarns");
		PTEMP[playerid][pFuel] =			cache_get_field_content_int(0,"pFuel");
		cache_get_field_content(0,"pMarriedTo", PTEMP[playerid][pMarriedTo],DATABASE,128);
		cache_get_field_content(0,	"pDrug", 	PTEMP[playerid][pDrug],DATABASE,128);
		PTEMP[playerid][pMushrooms] =		cache_get_field_content_int(0,"pMushrooms");
		PTEMP[playerid][pFishes] =			cache_get_field_content_float(0,"pFishes");
		PTEMP[playerid][pBank] =			cache_get_field_content_int(0,"pBank");
		PTEMP[playerid][pMobile] =			cache_get_field_content_int(0,"pMobile");
		PTEMP[playerid][pDolg] =			cache_get_field_content_int(0,"pDolg");
		PTEMP[playerid][pKrisha] =			cache_get_field_content_int(0,"pKrisha");
		PTEMP[playerid][pUseKrisha] =		cache_get_field_content_int(0,"pUseKrisha");
		PTEMP[playerid][pWantedLevel] =	cache_get_field_content_int(0,"pWantedLevel");
		cache_get_field_content(0,	"pWeapons", PTEMP[playerid][pWeapons],DATABASE,32);
		cache_get_field_content(0,	"pAmmos", 	PTEMP[playerid][pAmmos],DATABASE,32);
		sscanf(PTEMP[playerid][pWeapons], "p<,>a<i>[11]",PTEMP[playerid][pWeapon]);
		sscanf(PTEMP[playerid][pAmmos], "p<,>a<i>[11]",PTEMP[playerid][pAmmo]);
		cache_get_field_content(0,	"pGunSkills", PTEMP[playerid][pGunSkills],DATABASE,32);
		sscanf(PTEMP[playerid][pGunSkills], "p<,>a<i>[6]",PTEMP[playerid][pGunSkill]);
		PTEMP[playerid][ptaxiexp] =		cache_get_field_content_int(0,"ptaxiexp");
		PTEMP[playerid][pQuestL] =		cache_get_field_content_int(0,"pQuestL");
		PTEMP[playerid][pQuest] =		cache_get_field_content_int(0,"pQuest");
		PTEMP[playerid][pQuestF] =		cache_get_field_content_int(0,"pQuestF");
		PTEMP[playerid][pQuestP] =		cache_get_field_content_int(0,"pQuestP");
		PTEMP[playerid][pQuestPF] =		cache_get_field_content_int(0,"pQuestPF");
		PTEMP[playerid][pQuestShow] =		cache_get_field_content_int(0,"pQuestShow");
		PTEMP[playerid][ptaxilvl] =		cache_get_field_content_int(0,"ptaxilvl");
		PTEMP[playerid][pTraining] =		cache_get_field_content_int(0,"pTraining");
		PTEMP[playerid][pBoxSkill] =		cache_get_field_content_int(0,"pBoxSkill");
		PTEMP[playerid][pKongfuSkill] =	cache_get_field_content_int(0,"pKongfuSkill");
		PTEMP[playerid][pKickboxSkill] =	cache_get_field_content_int(0,"pKickboxSkill");
		PTEMP[playerid][pDLevel] =			cache_get_field_content_int(0,"pDLevel");
		PTEMP[playerid][pDExp] =			cache_get_field_content_int(0,"pDExp");
		PTEMP[playerid][pDMgruz] =			cache_get_field_content_int(0,"pDMgruz");
		PTEMP[playerid][pPSkill] =			cache_get_field_content_int(0,"pPSkill");
		PTEMP[playerid][pPProc] =			cache_get_field_content_int(0,"pPProc");
		PTEMP[playerid][pPMGruz] =			cache_get_field_content_int(0,"pPMGruz");
		cache_get_field_content(0,	"pOnline", 	PTEMP[playerid][pOnline],DATABASE,128);
		PTEMP[playerid][pChas] =			cache_get_field_content_int(0,"pChas");
		PTEMP[playerid][pMin] =			cache_get_field_content_int(0,"pMin");
		cache_get_field_content(0,	"pEmail", 	PTEMP[playerid][pEmail],DATABASE,128);
		cache_get_field_content(0,"pOnlineLid", PTEMP[playerid][pOnlineLid],DATABASE,128);
		PTEMP[playerid][pSkilla] =			cache_get_field_content_int(0,"pSkilla");
		PTEMP[playerid][pRecognition] =	cache_get_field_content_int(0,"pRecognition");
		PTEMP[playerid][pRobHouse] =		cache_get_field_content_int(0,"pRobHouse");
		PTEMP[playerid][pFishesPach] =		cache_get_field_content_int(0,"pFishesPach");
		PTEMP[playerid][pActivemail] =		cache_get_field_content_int(0,"activate_mail");
		PTEMP[playerid][pDrivingSkill] =	cache_get_field_content_int(0,"pDrivingSkill");
		PTEMP[playerid][pDonateAccount] =	cache_get_field_content_int(0,"pDonateAccount");
		PTEMP[playerid][pProdsSkill][0] =	cache_get_field_content_int(0,"prods_skill");
		PTEMP[playerid][pProdsSkill][1] =	cache_get_field_content_int(0,"prods_exp");
		new spawns[5];
		cache_get_field_content(0,"pSpawnChange", spawns,DATABASE,128);
		//PTEMP[playerid][pSpawnChange] =		cache_get_field_content_int(0,"pSpawnChange");
		PTEMP[playerid][pGRating] =         cache_get_field_content_int(0,"grating");
		sscanf(spawns, "p<,>ii", PTEMP[playerid][pSpawnChange][0], PTEMP[playerid][pSpawnChange][1]);
		new aprogolos = cache_get_field_content_int(0, "progolos");
		if (aprogolos > 0) PTEMP[playerid][progolos] = true;
		else PTEMP[playerid][progolos] = false;
		cache_get_field_content(0, "pChars", PTEMP[playerid][pChars], DATABASE, 32);
		sscanf(PTEMP[playerid][pChars], "p<,>a<i>[6]",PTEMP[playerid][pChar]);
		if (gettime() >= PTEMP[playerid][OffWarns])
		{
			PTEMP[playerid][pWarns] = 0;
			PTEMP[playerid][OffWarns] = 0;
		}
		/* Загрузка данных */
		HGet(playerid);
		BGet(playerid);
		WGet(playerid);
		KGet(playerid);
		FGet(playerid);
		mysql_format(DATABASE, QUERY, 256, "SELECT * FROM `"TABLE_CARS"` WHERE `owner` = '%s'", PTEMP[playerid][pName]), mysql_function_query(DATABASE, QUERY, true, "_MySQL_QUERY", "iis",33,playerid,"");
		//
		if (PTEMP[playerid][pTut] == 0)
		{
			//PTEMP[playerid][pCash] = 0;
			//format(QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pCash = '0' WHERE name = '%s'",PTEMP[playerid][pName]);
			//mysql_function_query(DATABASE,QUERY,false,"","");
			PTEMP[playerid][pPHouseKey] = 9999;
			PTEMP[playerid][pKvartiraKey] = 9999;
			PTEMP[playerid][pPBizzKey] = 999;
			PTEMP[playerid][pPFarmKey] = 999;
			PTEMP[playerid][pTut] = 1;
			SaveMySQL(2, playerid);
		}
		PTEMP[playerid][pLogin] = 1;
		Convoi[playerid] = 9999;
		// Снятие варнов
		new null = PTEMP[playerid][punWarns];
		if (null < Now() && PTEMP[playerid][pWarns]) PTEMP[playerid][pWarns] = 0, PTEMP[playerid][punWarns] = 0;
		//
		mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pLogin = '1' WHERE name = '%s'", PTEMP[playerid][pName]);
		mysql_function_query(DATABASE,QUERY,false,"","");
		new playersip[40];
		GetPlayerIp(playerid,playersip,sizeof(playersip));
		if (PTEMP[playerid][pCheckip] == 1)
		{
			if (strcmp(playersip, PTEMP[playerid][pIp]) != 0)
			{
				PTEMP[playerid][pLogin] = 0;
				mysql_format(DATABASE, QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pLogin = '0' WHERE name = '%e'",PTEMP[playerid][pName]);
				mysql_function_query(DATABASE,QUERY,false,"","");
				SetPlayerInterior(playerid, 0);
				SetPlayerFacingAngle(playerid, 179.5547);
				SetPlayerCameraPos(playerid, 1357.414428,-1450.705322,252.353897);
				SetPlayerCameraLookAt(playerid, 1365.318969,-1445.091796,249.903198);
				TogglePlayerControllable(playerid, 0);
				ShowPlayerDialogEx(playerid,16,DIALOG_STYLE_INPUT, "Введите ключ безопасности", "    ==== Ваш IP адрес сменился ====\n=== Введите Ваш ключ безопасности ===", "Готово", "Отмена");
				return true;
			}
		}
		else
		{
			mysql_format(DATABASE, QUERY, 256, "UPDATE `"TABLE_ACCOUNTS"` SET pIp = '%s',pvIp = '%s' WHERE name = '%e'",playersip,playersip,PTEMP[playerid][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");
			new year, month, day, hour, minute, second;
			getdate(year, month, day);
			gettime(hour, minute, second);
			mysql_format(DATABASE,QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pLogin = '1', pOnline = '%04i/%02i/%02i %02i:%02i:%02i' WHERE name = '%e'", year, month, day, hour, minute, second, PTEMP[playerid][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");
		}
		/**/
		//if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] != 0 && !IsAGang(playerid) && !IsAMafia(playerid) && !IsABiker(playerid)) PTEMP[playerid][pSpawnChange] = 1;
		if (PTEMP[playerid][pCash] < 0) PTEMP[playerid][pCash] = 0;
		for (new c = 0; c < 5; c++) if(CarInfo[playerid][carPercent][c] <= 3 && CarInfo[playerid][carModel][c] != 462) CarInfo[playerid][carPercent][c] = 4;
		if (PTEMP[playerid][pDonateRank] > 0) SCM(playerid, 0xEAC700AA, " Здравствуйте VIP игрок!");
		format(QUERY, 40, "~w~ Welcome ~n~~b~   %s", PTEMP[playerid][pName]);
		GameTextForPlayer(playerid, QUERY, 5000, 1);
		if (!PTEMP[playerid][pActivemail]) SCM(playerid,-1,"{FFFFFF} У вас не подтвержден Эмейл адрес! Используйте {FFFF00}/mm{FFFFFF} -> Настройки -> Эмейл");
		if (!PTEMP[playerid][pActivemail]) SCM(playerid,-1,"{FFFFFF} Обратите внимание! В случае утери пароля, вы не сможете восстановить доступ с неподтвержденным Эмейл адресом");
		if (PTEMP[playerid][pText] == 10) SCM(playerid, COLOR_YELLOW, " Ваш ранг был изменён"),PTEMP[playerid][pText] = 0;
		if (PTEMP[playerid][pText] == 9) SCM(playerid, COLOR_YELLOW, " Вас выгнали из организации"),PTEMP[playerid][pText] = 0;
		if (PTEMP[playerid][pText] == 8) SCM(playerid, COLOR_LIGHTRED, " Вам было начислено 2 500 000 вирт за победу в рейтинге банд!"), PTEMP[playerid][pText] = 0;
		if (PTEMP[playerid][pText] == 7) format(YCMDstr, sizeof(YCMDstr), " Вы были посажены в форт ДеМорган в оффлайн режиме администратором "NameServer""), SCM(playerid, COLOR_LIGHTRED, YCMDstr), PTEMP[playerid][pText] = 0;
		if (PTEMP[playerid][pText] == 6) SCM(playerid, -1, " Вы приобрели бизнес с аукциона. Управление:{FFFF00} /mm - [3] Команды сервера"), PTEMP[playerid][pText] = 0;
		if (PTEMP[playerid][pText] == 4) SCM(playerid, -1, " Вы сняты с поста лидера оффлайн"), PTEMP[playerid][pText] = 0;
		if (PTEMP[playerid][pText] == 5) SCM(playerid, -1, " Ваша автомастерская была продана государству. Половина стоимости зачислена на ваш счет"), PTEMP[playerid][pText] = 0;
		if (PTEMP[playerid][pText] == 3) PTEMP[playerid][pText] = 0, SCM(playerid, COLOR_GOLD, " Вы получили 100 000 вирт на банковский счет, за приглашённого друга"), PTEMP[playerid][pText] = 0;
		if (PTEMP[playerid][pText] == 1 && PTEMP[playerid][pHousecash] !=0) SCM(playerid, COLOR_LIGHTRED, " Вы были выселены за неуплату квартплаты"), SCM(playerid, COLOR_LIGHTRED, " Деньги за дом вы можете получить в банке \"/GetHouseMoney\""),PTEMP[playerid][pPHouseKey] = 9999;
		if (!HGet(playerid) && PTEMP[playerid][pPHouseKey] !=9999) SCM(playerid, COLOR_LIGHTRED, " Вы были выселены за неуплату квартплаты"), SCM(playerid, COLOR_LIGHTRED, " Деньги за дом вы можете получить в банке \"/GetHouseMoney\""),PTEMP[playerid][pPHouseKey] = 9999;
		if (PTEMP[playerid][pText] == 2) SCM(playerid, COLOR_YELLOW, " Ваш бизнес был продан за неуплату электроэнергии / простаивание"), PTEMP[playerid][pText] = 0;
		if (ZoneID != 0) GangZoneShowForAll(ZoneWar, 0xB2B2B2AA), GangZoneFlashForAll(ZoneWar,COLOR_RED);
		PEfir[playerid] = 255;
		Pefir[playerid] = 999;
		SpawnPlayer(playerid);
		for (new i = 1; i <= TOTALGZ; i++)
		{
			if (!ZoneOnBattle[i]) continue;
			GangZoneStopFlashForAll(GZInfo[i][gZone]);
			GangZoneFlashForAll(GZInfo[i][gZone],COLOR_RED);
		}
		GangZoneShowForPlayer(playerid, Army, COLOR_YELLOW2);
		SetPlayerHealthAC(playerid, PTEMP[playerid][pHP]);
		ResetPlayerMoney(playerid);
		printf("Игрок %s авторизовался", PTEMP[playerid][pName]);
	}
	case 3: strmid(PTEMP[playerid][pDrug], str, 0, strlen(str), strlen(str)+5);
	case 4:
	{
		if (r)
		{
			SCM(playerid, -1,"{C42100} Ваш IP адрес заблокирован");
			return Kick(playerid);
		}
	}
	case 5:
	{
		if (r)
		{
			//SCM(playerid, 0xEAC700AA, " Для восстановления доступа нажмите клавишу 'F6' и введите '/restoreAccess'");
			format(QUERY, 384, "{B4B5B7}______________________________________\n\n Добро пожаловать на сервер "NameServer"{B4B5B7}\n       Этот аккаунт зарегистрирован\n\nЛогин: {BFC0C2}%s{B4B5B7}\nВведите пароль:\n______________________________________",PTEMP[playerid][pName]);
			ShowPlayerDialogEx(playerid, 1, DIALOG_STYLE_PASSWORD, "Авторизация",  QUERY, "Войти", "Отмена");
			SetPVarInt(playerid, "time_logged", 120);
		}
		else
		{
			format(QUERY, 384, "{B4B5B7}______________________________________\n\n Добро пожаловать на сервер "NameServer"{B4B5B7}\n       Регистрация нового персонажа\n\nЛогин: {BFC0C2}%s{B4B5B7}\nВведите пароль:\n______________________________________",PTEMP[playerid][pName]);
			ShowPlayerDialogEx(playerid, 2, DIALOG_STYLE_INPUT, "Регистрация", QUERY, "Готово", "Отмена");
		}
	}
	case 6:
	{
		if (!r) return print("[Загрузка ...] Данные из Bizz не получены!");
		for (x = 1; x <= r; x++)
		{
			BizzInfo[x][bID] = 				cache_get_row_int(x-1,0, DATABASE);
			cache_get_row(x-1, 1, 			BizzInfo[x][bOwner], DATABASE, 64);
			cache_get_row(x-1, 2, 			BizzInfo[x][bMessage], DATABASE, 128);
			BizzInfo[x][bEntranceX] = 		cache_get_row_float(x-1,3, DATABASE);
			BizzInfo[x][bEntranceY] = 		cache_get_row_float(x-1,4, DATABASE);
			BizzInfo[x][bEntranceZ] = 		cache_get_row_float(x-1,5, DATABASE);
			BizzInfo[x][bExitX] = 			cache_get_row_float(x-1,6, DATABASE);
			BizzInfo[x][bExitY] = 			cache_get_row_float(x-1,7, DATABASE);
			BizzInfo[x][bExitZ] = 			cache_get_row_float(x-1,8, DATABASE);
			BizzInfo[x][bBuyPrice] = 		cache_get_row_int(x-1,9, DATABASE);
			BizzInfo[x][bEntranceCost] = 	cache_get_row_int(x-1,10, DATABASE);
			BizzInfo[x][bTill] = 			cache_get_row_int(x-1,11, DATABASE);
			BizzInfo[x][bLocked] = 			cache_get_row_int(x-1,12, DATABASE);
			BizzInfo[x][bInterior] = 		cache_get_row_int(x-1,13, DATABASE);
			BizzInfo[x][bProducts] = 		cache_get_row_int(x-1,14, DATABASE);
			BizzInfo[x][bPrice] = 			cache_get_row_int(x-1,15, DATABASE);
			BizzInfo[x][bBarX] = 			cache_get_row_float(x-1,16, DATABASE);
			BizzInfo[x][bBarY] = 			cache_get_row_float(x-1,17, DATABASE);
			BizzInfo[x][bBarZ] = 			cache_get_row_float(x-1,18, DATABASE);
			BizzInfo[x][bMafia] = 			cache_get_row_int(x-1,19, DATABASE);
			BizzInfo[x][bType] = 			cache_get_row_int(x-1,20, DATABASE);
			BizzInfo[x][bLockTime] = 		cache_get_row_int(x-1,21, DATABASE);
			BizzInfo[x][bLicense] = 		cache_get_row_int(x-1,22, DATABASE);
			BizzInfo[x][bStavka] = 			cache_get_row_int(x-1,23, DATABASE);
			cache_get_row(x-1, 24, 			BizzInfo[x][bNameStavka], DATABASE, 50);
			BizzInfo[x][bLastStavka] = 		cache_get_row_int(x-1,25, DATABASE);
			BizzInfo[x][bTimeStavka] = 		cache_get_row_int(x-1,26, DATABASE);
			BizzInfo[x][bMinStavka] = 		cache_get_row_int(x-1,27, DATABASE);
			BizzInfo[x][bVirtualWorld] = 	cache_get_row_int(x-1,28, DATABASE);
			BizzInfo[x][bLandTax] =         cache_get_row_int(x-1,29, DATABASE);
			BizzInfo[x][bProdPrice] =       cache_get_row_int(x-1,30, DATABASE);

			if (BizzInfo[x][bType] != 4 && BizzInfo[x][bID] != 47 && BizzInfo[x][bID] != 48)
			{
				BizzInfo[x][bEnterPic] = CreatePickup(1318, 23, BizzInfo[x][bEntranceX], BizzInfo[x][bEntranceY], BizzInfo[x][bEntranceZ],-1);
				BizzInfo[x][bExitPic] = CreatePickup(1318, 23, BizzInfo[x][bExitX], BizzInfo[x][bExitY], BizzInfo[x][bExitZ],BizzInfo[x][bVirtualWorld]);
				if (strcmp(BizzInfo[x][bOwner],"None",true) == 0) format(QUERY, 90, "%s\nПродаётся", BizzInfo[x][bMessage], BizzInfo[x][bBuyPrice]), BizzInfo[x][bLocked] = 1;
				else format(QUERY,128, "%s\nВладелец:\n %s", BizzInfo[x][bMessage], BizzInfo[x][bOwner]);
				BizzInfo[x][bLabel] = CreateDynamic3DTextLabel(QUERY,COLOR_GREEN,BizzInfo[x][bEntranceX], BizzInfo[x][bEntranceY], BizzInfo[x][bEntranceZ]+1,20.0);
			}
			if (BizzInfo[x][bType] == 2) BizzInfo[x][bPickup] = CreatePickup(1239, 23, BizzInfo[x][bBarX],BizzInfo[x][bBarY],BizzInfo[x][bBarZ],BizzInfo[x][bVirtualWorld]);
			if (BizzInfo[x][bType] == 4)
			{
				if (strcmp(BizzInfo[x][bOwner],"None",true) == 0) format(QUERY, 90, "%s\nПродаётся", BizzInfo[x][bMessage],BizzInfo[x][bBuyPrice]), BizzInfo[x][bLocked] = 1;
				else format(QUERY,128, "%s\nВладелец:\n%s\nЦена бензина: %i вирт", BizzInfo[x][bMessage], BizzInfo[x][bOwner],BizzInfo[x][bPrice]);
				BizzInfo[x][bLabel] = CreateDynamic3DTextLabel(QUERY,COLOR_GREEN,BizzInfo[x][bEntranceX], BizzInfo[x][bEntranceY], BizzInfo[x][bEntranceZ],5.0);
			}
			switch (BizzInfo[x][bType])
			{
			case 1: BizzMaxProds[x] = 5000, BizzLandTax[x] = 200;
			case 2: BizzMaxProds[x] = 3000, BizzLandTax[x] = 200;
			case 3: BizzMaxProds[x] = 2000, BizzLandTax[x] = 300;
			case 4: BizzMaxProds[x] = 20000, BizzLandTax[x] = 100;
			}
			TotalBizz++;
		}
		printf("[Загрузка ...] Данные из Bizz получены! (%i шт.)", TotalBizz);
	}
	case 7:
	{
		if (!r) return print("[Загрузка ...] Данные из Workshop не получены!");
		for (x = 1; x <= r; x++)
		{
			WorkshopInfo[x][wID] = 			cache_get_row_int(x-1,0, DATABASE);
			cache_get_row(x-1, 1, 			WorkshopInfo[x][wOwner], DATABASE, MAX_PLAYER_NAME);
			WorkshopInfo[x][wEntr][0] = 	cache_get_row_float(x-1,2, DATABASE);
			WorkshopInfo[x][wEntr][1] = 	cache_get_row_float(x-1,3, DATABASE);
			WorkshopInfo[x][wEntr][2] = 	cache_get_row_float(x-1,4, DATABASE);
			WorkshopInfo[x][wExit][0] = 	cache_get_row_float(x-1,5, DATABASE);
			WorkshopInfo[x][wExit][1] = 	cache_get_row_float(x-1,6, DATABASE);
			WorkshopInfo[x][wExit][2] = 	cache_get_row_float(x-1,7, DATABASE);
			WorkshopInfo[x][wMenu][0] = 	cache_get_row_float(x-1,8, DATABASE);
			WorkshopInfo[x][wMenu][1] = 	cache_get_row_float(x-1,9, DATABASE);
			WorkshopInfo[x][wMenu][2] = 	cache_get_row_float(x-1,10, DATABASE);
			WorkshopInfo[x][wBank] = 		cache_get_row_int(x-1,11, DATABASE);
			WorkshopInfo[x][wLandTax] = 	cache_get_row_int(x-1,12, DATABASE);
			WorkshopInfo[x][wProds] = 		cache_get_row_int(x-1,13, DATABASE);
			WorkshopInfo[x][wPriceProds] = 	cache_get_row_int(x-1,14, DATABASE);
			WorkshopInfo[x][wZp] = 			cache_get_row_int(x-1,15, DATABASE);
			cache_get_row(x-1, 16, 			WorkshopInfo[x][wDeputy1], DATABASE, 32);
			cache_get_row(x-1, 17, 			WorkshopInfo[x][wDeputy2], DATABASE, 32);
			cache_get_row(x-1, 18, 			WorkshopInfo[x][wDeputy3], DATABASE, 32);
			cache_get_row(x-1, 19, 			WorkshopInfo[x][wMechanic1], DATABASE, 32);
			cache_get_row(x-1, 20, 			WorkshopInfo[x][wMechanic2], DATABASE, 32);
			cache_get_row(x-1, 21, 			WorkshopInfo[x][wMechanic3], DATABASE, 32);
			cache_get_row(x-1, 22, 			WorkshopInfo[x][wMechanic4], DATABASE, 32);
			cache_get_row(x-1, 23, 			WorkshopInfo[x][wMechanic5], DATABASE, 32);
			cache_get_row(x-1, 24, 			WorkshopInfo[x][wAuctions], DATABASE, 128);
			sscanf(WorkshopInfo[x][wAuctions], "p<,>a<i>[5]",WorkshopInfo[x][wAuction]);
			cache_get_row(x-1, 25, 			WorkshopInfo[x][wAuctionName], DATABASE, MAX_PLAYER_NAME);
			WorkshopInfo[x][wBiker] = 		cache_get_row_int(x-1,26, DATABASE);
			WorkshopInfo[x][wPickup][0] = CreatePickup(1318, 23, WorkshopInfo[x][wEntr][0], WorkshopInfo[x][wEntr][1], WorkshopInfo[x][wEntr][2]);
			WorkshopInfo[x][wPickup][1] = CreatePickup(1318, 23, WorkshopInfo[x][wExit][0], WorkshopInfo[x][wExit][1], WorkshopInfo[x][wExit][2],x);
			WorkshopInfo[x][wPickup][2] = CreatePickup(1275, 23, 1496.0302,1308.6653,1093.2892,x);
			WorkshopInfo[x][wPickup][3] = CreatePickup(1239, 23, 1492.7340,1308.1758,1093.2927,x);
			format(YCMDstr, 160, "Автомастерская ID: {FFFFFF}%i\n{DDB201}Информация: {FFFFFF}/tinfo",x-1);
			WorkshopInfo[x][wLabel] = CreateDynamic3DTextLabel(YCMDstr, 0xDDB201FF,WorkshopInfo[x][wEntr][0], WorkshopInfo[x][wEntr][1], WorkshopInfo[x][wEntr][2]+1,20.0);
			CreateDynamicMapIcon(WorkshopInfo[x][wEntr][0], WorkshopInfo[x][wEntr][1], WorkshopInfo[x][wEntr][2],27,0);

			TOTALSHOPS++;
		}
		for (new x_ = 9; x_ >= 0; x_--)
		{
			WorkshopList[x_][x][wlID] = -1;
			strmid(WorkshopList[x_][x][wlName],"", 0, strlen(""), 5);
		}
		printf("[Загрузка ...] Данные из Workshop получены! (%i шт.)", TOTALSHOPS);
	}
	case 8:
	{
		if (!r) return print("[Загрузка ...] Данные из Kvart не получены!");
		for (x = 1; x <= r; x++)
		{
			kvartinfo[x][kid] = 			cache_get_row_int(x-1,0, DATABASE);
			kvartinfo[x][pXpic] = 			cache_get_row_float(x-1,1, DATABASE);
			kvartinfo[x][pYpic] = 			cache_get_row_float(x-1,2, DATABASE);
			kvartinfo[x][pZpic] = 			cache_get_row_float(x-1,3, DATABASE);
			cache_get_row(x-1, 4, 			kvartinfo[x][vladelec], DATABASE, 32);
			kvartinfo[x][lock] = 			cache_get_row_int(x-1,5, DATABASE);
			kvartinfo[x][aptek] = 			cache_get_row_int(x-1,6, DATABASE);
			kvartinfo[x][plata] = 			cache_get_row_int(x-1,7, DATABASE);
			kvartinfo[x][kCena] = 			cache_get_row_int(x-1,8, DATABASE);
			kvartinfo[x][kInt] = 			cache_get_row_int(x-1,9, DATABASE);
			kvartinfo[x][virtmir] = 		cache_get_row_int(x-1,10, DATABASE);
			kvartinfo[x][kworld] = 			cache_get_row_int(x-1,11, DATABASE);
			if (!strcmp(kvartinfo[x][vladelec],"None",true))
			{
				switch (booston)
				{
				case 0: format(QUERY, sizeof(QUERY),"{0076FC}Комната #%i\nПродается: %i вирт\nЧтобы войти, нажмите клавишу 'ENTER'",x,kvartinfo[x][kCena]);
				case 1: format(QUERY, sizeof(QUERY),"{0076FC}Комната #%i\nПродается: %i вирт\nЧтобы войти, нажмите клавишу 'ENTER'",x,kvartinfo[x][kCena]-kvartinfo[x][kCena]*40/100);
				}
			}
			else format(QUERY, 180,"{FFBF00}Квартира #%i\nВладелец: %s\nЧтобы войти, нажмите клавишу 'ENTER'",x, kvartinfo[x][vladelec]);
			kvartinfo[x][dtext]     =    CreateDynamic3DTextLabel(QUERY,0x0076FCFF,kvartinfo[x][pXpic],kvartinfo[x][pYpic],kvartinfo[x][pZpic]+1,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,kvartinfo[x][kworld]);
			CreateDynamic3DTextLabel("Чтобы выйти, нажмите клавишу '~k~~VEHICLE_ENTER_EXIT~'\nКупить/продать, нажмите клавишу ~k~~SNEAK_ABOUT~",0x0076FCFF,2282.9211,-1140.2861,1050.8984+1,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,x);
			CreateDynamic3DTextLabel("Чтобы выйти, нажмите клавишу '~k~~VEHICLE_ENTER_EXIT~'\nКупить/продать, нажмите клавишу ~k~~SNEAK_ABOUT~",0x0076FCFF,54.8790,-79.7394,1004.2859+1,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,x);
			CreateDynamic3DTextLabel("Чтобы выйти, нажмите клавишу '~k~~VEHICLE_ENTER_EXIT~'\nКупить/продать, нажмите клавишу ~k~~SNEAK_ABOUT~",0x0076FCFF,34.9120,-81.2602,1004.2859+1,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,x);
			ALLKVARTIRI++;
			updatekvar(x);
		}
		printf("[Загрузка ...] Данные из Kvart получены! (%i шт.)",ALLKVARTIRI);
	}
	case 9:
	{
		if (!r) return print("[Загрузка ...] Данные из Podeezd не получены!");
		for (x = 1; x <= r; x++)
		{
			AllPODEZD++;
			PodeezdInfo[x][pid] = 	   cache_get_row_int(x-1,0, DATABASE);
			PodeezdInfo[x][podPicX] =  cache_get_row_float(x-1,1, DATABASE);
			PodeezdInfo[x][podPicY] =  cache_get_row_float(x-1,2, DATABASE);
			PodeezdInfo[x][podPicZ] =  cache_get_row_float(x-1,3, DATABASE);
			PodeezdInfo[x][podEtazi] = cache_get_row_int(x-1,4, DATABASE);
			PodeezdInfo[x][carX] = 	   cache_get_row_float(x-1,5, DATABASE);
			PodeezdInfo[x][carY] = 	   cache_get_row_float(x-1,6, DATABASE);
			PodeezdInfo[x][carZ] = 	   cache_get_row_float(x-1,7, DATABASE);
			PodeezdInfo[x][podInt] =   cache_get_row_int(x-1,8, DATABASE);
			PodeezdInfo[x][carC] = 	   cache_get_row_float(x-1,9, DATABASE);

			format(QUERY, 123,"Многоквартирный дом\nНомер подъезда: %i",AllPODEZD);
			CreateDynamic3DTextLabel(QUERY,0x0076FCFF,PodeezdInfo[x][podPicX],PodeezdInfo[x][podPicY],PodeezdInfo[x][podPicZ]+1,5.0);
			PodeezdInfo[x][podPic]    =    CreatePickup(1318, 1, PodeezdInfo[x][podPicX], PodeezdInfo[x][podPicY], PodeezdInfo[x][podPicZ]);
			for (new b = 1; b <= PodeezdInfo[x][podEtazi]; b++)
			{
				ALLPODEZD++;
				PodeezdInfo[x][podMir][b] = ALLPODEZD;
				//printf("%d",ALLPODEZD);
			}
			ALLPODEZD = 0;
		}
		printf("[Загрузка ...] Данные из Podeezd получены! (%i шт.)", AllPODEZD);
	}
	case 10:
	{
		if (!r) return print("[Загрузка ...] Данные из Casino не получены!");
		for (x = 1; x <= r; x++)
		{
			CasinoInfo[x][caID] = 			cache_get_row_int(x-1,0, DATABASE);
			cache_get_row(x-1, 1, 			CasinoInfo[x][caName], DATABASE, 32);
			CasinoInfo[x][caMafia] = 		cache_get_row_int(x-1,2, DATABASE);
			cache_get_row(x-1, 3, 			CasinoInfo[x][caKrupie], DATABASE, 32);
			cache_get_row(x-1, 4, 			CasinoInfo[x][caKrupie2], DATABASE, 32);
			cache_get_row(x-1, 5, 			CasinoInfo[x][caKrupie3], DATABASE, 32);
			cache_get_row(x-1, 6, 			CasinoInfo[x][caKrupie4], DATABASE, 32);
			cache_get_row(x-1, 7, 			CasinoInfo[x][caKrupie5], DATABASE, 32);
			cache_get_row(x-1, 8, 			CasinoInfo[x][caKrupie6], DATABASE, 32);
			cache_get_row(x-1, 9, 			CasinoInfo[x][caKrupie7], DATABASE, 32);
			cache_get_row(x-1, 10, 			CasinoInfo[x][caKrupie8], DATABASE, 32);
			cache_get_row(x-1, 11, 			CasinoInfo[x][caKrupie9], DATABASE, 32);
			cache_get_row(x-1, 12, 			CasinoInfo[x][caKrupie10], DATABASE, 32);
			cache_get_row(x-1, 13, 			CasinoInfo[x][caManager], DATABASE, 32);
			cache_get_row(x-1, 14, 			CasinoInfo[x][caManager2], DATABASE, 32);
			cache_get_row(x-1, 15, 			CasinoInfo[x][caManager3], DATABASE, 32);
			CasinoInfo[x][caPos][0] = 		cache_get_row_int(x-1,16, DATABASE);
			CasinoInfo[x][caPos][1] = 		cache_get_row_int(x-1,17, DATABASE);
			CasinoInfo[x][caPos][2] = 		cache_get_row_int(x-1,18, DATABASE);
			TOTALCASINO++;
		}
		printf("[Загрузка ...] Данные из Casino получены! (%i шт.)", TOTALCASINO);
	}
	case 11:
	{
		if (!r) return print("[Загрузка ...] Данные из House не получены!");
		for (x = 1; x <= r; x++)
		{
			HouseInfo[x][hID] =             cache_get_row_int(x-1,0, DATABASE);
			HouseInfo[x][hEntrancex] =      cache_get_row_float(x-1,1, DATABASE);
			HouseInfo[x][hEntrancey] =      cache_get_row_float(x-1,2, DATABASE);
			HouseInfo[x][hEntrancez] =      cache_get_row_float(x-1,3, DATABASE);
			HouseInfo[x][hExitx] =          cache_get_row_float(x-1,4, DATABASE);
			HouseInfo[x][hExity] =          cache_get_row_float(x-1,5, DATABASE);
			HouseInfo[x][hExitz] =          cache_get_row_float(x-1,6, DATABASE);
			HouseInfo[x][hCarx] =           cache_get_row_float(x-1,7, DATABASE);
			HouseInfo[x][hCary] =           cache_get_row_float(x-1,8, DATABASE);
			HouseInfo[x][hCarz] =           cache_get_row_float(x-1,9, DATABASE);
			HouseInfo[x][hCarc] =           cache_get_row_float(x-1,10, DATABASE);
			cache_get_row(x-1, 11, 			HouseInfo[x][hOwner], DATABASE, MAX_PLAYER_NAME);
			HouseInfo[x][hValue] =          cache_get_row_int(x-1,12, DATABASE);
			HouseInfo[x][hHel] =            cache_get_row_int(x-1,13, DATABASE);
			HouseInfo[x][hInt] =            cache_get_row_int(x-1,14, DATABASE);
			HouseInfo[x][hLock] =           cache_get_row_int(x-1,15, DATABASE);
			HouseInfo[x][hTakings] =        cache_get_row_int(x-1,16, DATABASE);
			HouseInfo[x][hDate] =           cache_get_row_int(x-1,17, DATABASE);
			HouseInfo[x][hKlass] =          cache_get_row_int(x-1,18, DATABASE);
			HouseInfo[x][hVec] =            cache_get_row_int(x-1,19, DATABASE);
			HouseInfo[x][hVcol1] =          cache_get_row_int(x-1,20, DATABASE);
			HouseInfo[x][hVcol2] =          cache_get_row_int(x-1,21, DATABASE);
			HouseInfo[x][hVehSost] =        cache_get_row_int(x-1,22, DATABASE);
			cache_get_row(x-1, 34, HouseInfo[x][hSafes], DATABASE, 64);
			sscanf(HouseInfo[x][hSafes], "p<,>a<i>[11]",HouseInfo[x][hSafe]);
			if (strcmp(HouseInfo[x][hOwner],"None",true) == 0)
			{
				HouseInfo[x][hPickup] = CreatePickup(1273, 23, HouseInfo[x][hEntrancex], HouseInfo[x][hEntrancey], HouseInfo[x][hEntrancez],-1);
				HouseInfo[x][hMIcon] = CreateDynamicMapIcon(HouseInfo[x][hEntrancex], HouseInfo[x][hEntrancey], HouseInfo[x][hEntrancez], 31, -1, 0, -1, -1,150);
			}
			else
			{
				HouseInfo[x][hPickup] = CreatePickup(1272, 23, HouseInfo[x][hEntrancex], HouseInfo[x][hEntrancey], HouseInfo[x][hEntrancez],-1);
				HouseInfo[x][hMIcon] = CreateDynamicMapIcon(HouseInfo[x][hEntrancex], HouseInfo[x][hEntrancey], HouseInfo[x][hEntrancez], 32, -1, 0, -1, -1,150);
			}
			HouseInfo[x][hExitText] = CreateDynamic3DTextLabel("Чтобы выйти, нажмите клавишу '~k~~VEHICLE_ENTER_EXIT~'\nКупить/продать, нажмите клавишу '~k~~SNEAK_ABOUT~'",0x0076FCFF,HouseInfo[x][hExitx],HouseInfo[x][hExity],HouseInfo[x][hExitz]+1,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,x+50);
			TotalHouse++;
		}
		printf("[Загрузка ...] Данные из House получены! (%i шт.)", TotalHouse);
	}
	case 12:
	{
		BizzInfo[playerid][bLocked] = 0;
		BizzInfo[playerid][bPrice] = 100;
		BizzInfo[playerid][bTill] = 0;
		BizzInfo[playerid][bLandTax] = BizzLandTax[playerid]*12;
		BizzPay[playerid] = 0;
		BizzInfo[playerid][bLicense] = 0;
		BizzInfo[playerid][bStavka] = 0;
		BizzInfo[playerid][bMinStavka] = 0;
		BizzInfo[playerid][bTimeStavka] = 0;
		BizzInfo[playerid][bLastStavka] = 0;
		BizzInfo[playerid][bLockTime] = 0;
		BizzInfo[playerid][bEntranceCost] = 100;
		strmid(BizzInfo[playerid][bOwner],BizzInfo[playerid][bNameStavka], 0, strlen(BizzInfo[playerid][bNameStavka]), 32);
		if(IsPlayerConnected(GetPlayerID(BizzInfo[playerid][bNameStavka]))) BGet(GetPlayerID(BizzInfo[playerid][bNameStavka])), SCM(GetPlayerID(BizzInfo[playerid][bNameStavka]),COLOR_GREEN," Вы приобрели бизнес с аукциона. (( Управление: /mm > Команды сервера ))");
		strmid(BizzInfo[playerid][bNameStavka], "-", 0, strlen("-"), 10);
		UpdateBizz(playerid);
	}
	case 13:
	{
		new Nick[50];
		if (!r) return print("[Получение денег за друга ...] Аккаунт не найден!");
		cache_get_field_content(0,"pDrug",Nick,DATABASE,50);
		mysql_format(DATABASE,QUERY,256, "UPDATE `"TABLE_ACCOUNTS"` SET pCash = pCash + 100000, pText = '3' WHERE name = '%s'",Nick);
		mysql_function_query(DATABASE, QUERY, false, "", "");
		printf("Игроку %s выданы денег за реферала", Nick);
	}
	case 14:
	{
		new query[50], level;
		cache_get_field_content(0,"password",query,DATABASE,50);
		SetPVarString(playerid,"password",query);
		level =	cache_get_field_content_int(0,"level");
		SetPVarInt(playerid,"level",level);
		if (!r) return true;
		if (!strcmp(query, "qwerty", true))
		{
			SetPVarInt(playerid, "Alogin", 1);
			ShowPlayerDialogEx(playerid, 1227, DIALOG_STYLE_PASSWORD, "Админ авторизация", "Введите пароль\n\nПароль должен состоять из латинских букв и цифр\n	размером от 6 до 15 символов", "Вход", "Отмена");
		}
		else ShowPlayerDialogEx(playerid, 1227, DIALOG_STYLE_PASSWORD, "Админ авторизация", "Введите пароль\n\nПароль должен состоять из латинских букв и цифр\n	размером от 6 до 15 символов", "Вход", "Отмена"), SetPVarInt(playerid, "Alogin", 2);
	}
	case 15:
	{
		if(r) return SCM(strval(str),COLOR_RED," Данный ник уже есть в базе данных"), SCM(playerid,COLOR_RED," Невозможно сменить ник. Ник занят");
		SCM(playerid,COLOR_GREEN, " Ваш ник был одобрен");
		nick[playerid] = 1;
		ChangeName(playerid, WantNickChange[playerid]);
	}
	case 16:
	{
		new minags[128];
		if (!r) return SCM(playerid, COLOR_GREY, " Аккаунт не найден!");
		new level,exp,viprank,warn,number,money,bank, leader,member,rank,job,jobskin,house,bizz,farm,pvip[16],don[128],ipk[16],regip[16],refer[24];
		level=cache_get_field_content_int(0,"pLevel");
		exp=cache_get_field_content_int(0,"pExp");
		viprank=cache_get_field_content_int(0,"pDonateRank");
		warn=cache_get_field_content_int(0,"pWarns");
		number=cache_get_field_content_int(0,"pPnumber");
		money=cache_get_field_content_int(0,"pCash");
		bank=cache_get_field_content_int(0,"pBank");
		leader=cache_get_field_content_int(0,"pLeader");
		member=cache_get_field_content_int(0,"pMember");
		rank=cache_get_field_content_int(0,"pRank");
		job=cache_get_field_content_int(0,"pJob");
		jobskin=cache_get_field_content_int(0,"pModel");
		house=cache_get_field_content_int(0,"pPHouseKey");
		bizz=cache_get_field_content_int(0,"pPBizzKey");
		farm=cache_get_field_content_int(0,"pPFarmKey");
		cache_get_field_content(0,"pvIp",pvip,DATABASE,16);
		cache_get_field_content(0,"pEmail",don,DATABASE,128);
		cache_get_field_content(0,"pIpReg",regip,DATABASE,16);
		cache_get_field_content(0,"pDrug",refer,DATABASE,24);
		QUERY="\n";
		format(minags,sizeof(minags),"Name:      \t\t%s\n\nLevel:      \t\t%i\nExp:      \t\t%i\n",str,level,exp); strcat(QUERY,minags);
		format(minags,sizeof(minags),"Vip:      \t\t\t%i\nWarns:      \t\t%i\nPhone:      \t\t%i\n",viprank,warn,number); strcat(QUERY,minags);
		format(minags,sizeof(minags),"Money:      \t\t%i\nBank:      \t\t%i\nLeader:      \t\t%i\n",money,bank,leader); strcat(QUERY,minags);
		format(minags,sizeof(minags),"Member:      \t\t%i\nRank:      \t\t%i\nJob:      \t\t%i\n",member,rank,job); strcat(QUERY,minags);
		format(minags,sizeof(minags),"JobSkin:      \t\t%i\nHouse:      \t\t%i\n",jobskin,house); strcat(QUERY,minags);
		format(minags,sizeof(minags),"Biz:      \t\t%i\nFarm:      \t\t%i\nEmail:      \t\t%s\nsuperKeyIP:      \t%s\n",bizz,farm,don,pvip); strcat(QUERY,minags);
		format(minags,sizeof(minags),"L-IP:      \t\t%s\nR-IP:      \t\t%s\nRefer:      \t\t%s\n\n",ipk,regip,refer); strcat(QUERY,minags);
		strcat(QUERY,"\n{FF6347}* superKeyIP - к которому привязан акк\nЕсли superKeyIP и L-IP не равны,\nто кто-то пытался войти в аккаунт,\nнезная супер ключа");
		ShowPlayerDialogEx(playerid,22815,DIALOG_STYLE_MSGBOX,"OFFLINE Статистика персонажа",QUERY,"Готово","");
		printf("Администратор %s смотрит статистику %s",Name(playerid), str);
	}
	case 17:
	{
		if(r)
		{
			
			if(playerid == 0)
			{
				mysql_format(DATABASE,QUERY, 128, "DELETE FROM "TABLE_ADMIN" WHERE `Name`= '%s'", str);
				mysql_function_query(DATABASE,QUERY,false,"","");
				if(IsPlayerConnected(GetPlayerID(str))) PTEMP[GetPlayerID(str)][pAdmin] = 0;
			}
			else
			{
				mysql_format(DATABASE,QUERY,256, "UPDATE "TABLE_ADMIN" SET  level = '%i' WHERE Name = '%s' LIMIT 1",playerid,str);
				mysql_function_query(DATABASE,QUERY,false,"","");
			}
		}
		else
		{
			if(playerid > 0)
			{
				new year, month,day;
				getdate(year, month, day);
				mysql_format(DATABASE,QUERY, 512, "INSERT INTO "TABLE_ADMIN" (Name, level, LastCon) VALUES ('%s', %i, '%02i.%02i.%04i')",str, playerid,day,month,year);
				mysql_function_query(DATABASE,QUERY,false,"","");
			}
		}
	}
	case 18:
	{
		if(!r) return SCM(playerid,COLOR_GREY," Аккаунт не найден!");
		cache_get_field_content(0,"pOnline",QUERY,DATABASE,30);
		SendMes(playerid,COLOR_BLUE," Ник: %s | Последний вход: %s",str,QUERY);
	}
	case 19:
	{
		if(!r) return SCM(playerid,COLOR_GREY," Не найдено совпадений!");
		for new i=0;i<r;i++ do
		{
			cache_get_field_content(i,"Name",QUERY,DATABASE,MAX_PLAYER_NAME);
			SendMes(playerid,COLOR_BLUE," Ник: %s | Фракция ID: %i",QUERY,strval(str));
		}
	}
	case 20:
	{
		if(!r) return SCM(playerid,COLOR_GREY," Произошла ошибка. Возможно неверно указан ник");
		new ip[32], ipreg[32], pvip[32];
		cache_get_field_content(0,"pIp",ip,DATABASE,30);
		cache_get_field_content(0,"pIpReg",ipreg,DATABASE,30);
		cache_get_field_content(0,"pvIp",pvip,DATABASE,30);
		SendMes(playerid,COLOR_BLUE," Nik [%s]   Register-IP [%s]   Last-IP [%s]",str,ipreg,pvip);
	}
	case 22:
	{
		if(!r) return printf("[Загрузка ...] Данные из Atm не получены!");
		for(x = 1; x <= r; x++)
		{
			ATMInfo[x][aid] = cache_get_row_int(x-1,0, DATABASE);
			ATMInfo[x][aX] = cache_get_row_float(x-1,1, DATABASE);
			ATMInfo[x][aY] = cache_get_row_float(x-1,2, DATABASE);
			ATMInfo[x][aZ] = cache_get_row_float(x-1,3, DATABASE);
			ATMInfo[x][arZ] = cache_get_row_float(x-1,4, DATABASE);
			ATM[x] = CreateDynamicObject(2754, ATMInfo[x][aX], ATMInfo[x][aY], ATMInfo[x][aZ], 0.0, 0.0, ATMInfo[x][arZ]);
			LABELATM[x] = CreateDynamic3DTextLabel("Нажмите: 'ENTER'",0x00D900FF, ATMInfo[x][aX],ATMInfo[x][aY],ATMInfo[x][aZ]+1.1,10.0);
			TOTALATM++;
		}
		printf("[Загрузка ...] Данные из Atm получены! (%i шт.)",TOTALATM);
	}
	case 23:
	{
		if(!r) return printf("[Аукцион СТО/Ферм] Нет аккаунта. Деньги не были зачислены!");
		mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pBank = pBank + %i WHERE Name = '%e'",WorkshopInfo[bizselect[playerid]][wAuction][1],WorkshopInfo[bizselect[playerid]][wAuctionName]);
		mysql_function_query(DATABASE,QUERY,false,"","");
		printf("Игроку %s были зачислены %i вирт за аукцтон СТО/Ферм",WorkshopInfo[bizselect[playerid]][wAuctionName], WorkshopInfo[bizselect[playerid]][wAuction][1]);
	}
	case 24:
	{
		new day, month, year;
		gettime(day,month,year);
		if(IsPlayerConnected(GetPlayerID(WorkshopInfo[playerid][wAuctionName]))) SCM(GetPlayerID(WorkshopInfo[playerid][wAuctionName]),-1," Вы приобрели СТО/Ферму с аукциона!");
		strmid(WorkshopInfo[playerid][wOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[playerid][wDeputy1],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[playerid][wDeputy2],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[playerid][wDeputy3],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[playerid][wMechanic1],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[playerid][wMechanic2],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[playerid][wMechanic3],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[playerid][wMechanic4],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[playerid][wMechanic5],"None",0,strlen("None"),MAX_PLAYER_NAME);
		WorkshopInfo[playerid][wLandTax] = 6000;
		WorkshopInfo[playerid][wBank] = (WorkshopInfo[playerid][wAuction][0]/100)*20;
		WorkshopInfo[playerid][wProds] = 20000;
		WorkshopInfo[playerid][wPriceProds] = 50;
		WorkshopInfo[playerid][wZp] = 5;
		strmid(WorkshopInfo[playerid][wOwner],WorkshopInfo[playerid][wAuctionName], 0, strlen(WorkshopInfo[playerid][wAuctionName]), MAX_PLAYER_NAME);
		if(IsPlayerConnected(GetPlayerID(WorkshopInfo[playerid][wAuctionName]))) WGet(GetPlayerID(WorkshopInfo[playerid][wAuctionName]));
		strmid(WorkshopInfo[playerid][wAuctionName], "None", 0, strlen("None"), 10);
		WorkshopInfo[playerid][wAuction][0] = 0;
		WorkshopInfo[playerid][wAuction][1] = 0;
		WorkshopInfo[playerid][wAuction][2] = 0;
		WorkshopInfo[playerid][wAuction][3] = 0;
		WorkshopInfo[playerid][wAuction][4] = mktimes(0,0,0,day+14,month,year);
	}
	case 25:
	{
		if(r)
		{
			new ban = cache_get_field_content_int(0,"Unban");
			new ddate = cache_get_field_content_int(0,"Date");
			new nameadmin[32], banreason[32];
			cache_get_field_content(0,"NameAdmin", nameadmin);
			cache_get_field_content(0,"Reason", banreason);
			new year, month, day,hour,minute,second;
			new byear, bmonth, bday,bhour,bminute,bsecond;
			TimestampToDates(ban, year, month, day, hour, minute, second, 0);
			TimestampToDates(ddate, byear, bmonth, bday, bhour, bminute, bsecond, 0);
			format(YCMDstr, sizeof(YCMDstr), "{D95A41}Этот аккаунт заблокирован\nЗабанил: %s\nПричина: %s\nДата бана: %i/%02i/%02i %02i:%02i:%02i\nДата разбана: %i/%02i/%02i %02i:%02i:%02i\n\nВведите \"/q\" чтобы выйти\n",nameadmin, banreason, byear,bmonth,bday,bhour,bminute,bsecond, year,month,day,hour,minute,second);
			ShowPlayerDialogEx(playerid,78,0,"{c22000}Внимание",YCMDstr,"Закрыть","");
			return Kick(playerid);
		}
		new Hash[64 + 1];
		SHA256_PassHash(PTEMP[playerid][pKey], "78sdjs", Hash, sizeof Hash);
		mysql_format(DATABASE, QUERY, sizeof(QUERY),"SELECT * FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s' AND `pKey`= '%s'", PTEMP[playerid][pName],Hash);
		mysql_function_query(DATABASE, QUERY, true, "_MySQL_QUERY", "iis", 2, playerid, "");
	}
	case 26:
	{
		new null[2] = 0;
		if (r)
		{
			for (x = 1; x <= r; x++)
			{
				new unban = cache_get_row_int(x-1,5, DATABASE);
				cache_get_field_content(x-1,"Name",QUERY,DATABASE,MAX_PLAYER_NAME);
				if (unban < Now())
				{
					mysql_format(DATABASE, QUERY, 128, "DELETE FROM `"TABLE_BAN"` WHERE `Name` = '%e'", QUERY);
					mysql_function_query(DATABASE, QUERY, false, "", "");
					null[0]++;
				}
				null[1]++;
			}
		}
		printf("[Загрузка ...] Забаненых аккаунтов %i. Разбанено %i аккаунтов", null[1], null[0]);
	}
	case 27:
	{
		if (!r) return ShowPlayerDialogEx(playerid,69,DIALOG_STYLE_MSGBOX, "Ошибка", "Вы ошиблись при вводе кодов", "Готово", ""), DeletePVar(playerid,"d_code1"), DeletePVar(playerid,"d_code2");
		new donate = cache_get_row_int(0,3, DATABASE);
		SCM(playerid, COLOR_GOLD, " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		switch (booston)
		{
		case 0: PTEMP[playerid][pBank] += donate,SendMes(playerid, COLOR_GOLD, " На ваш банковский счет зачислено: %i вирт", donate);
		case 1: PTEMP[playerid][pBank] += donate*2,SendMes(playerid, COLOR_GOLD, " На ваш банковский счет зачислено: %i вирт", donate*2);
		}
		SendMes(playerid, COLOR_GOLD, " Старый баланс: %i вирт", PTEMP[playerid][pBank]);
		SendMes(playerid, COLOR_GOLD, " Новый баланс: %i вирт", PTEMP[playerid][pBank]);
		SCM(playerid, COLOR_GOLD, " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		PTEMP[playerid][pDonateAccount] += donate;
		if (PTEMP[playerid][pDonateAccount] >= 30000000 && PTEMP[playerid][pDonateRank] < 3)
		{
			SCM(playerid, COLOR_GOLD, " Поздравляем! Вы достигли 3 уровня VIP");
			SCM(playerid, COLOR_GOLD, " Используйте /viphelp для просмотра функций VIP аккаунта");
			PTEMP[playerid][pDonateRank] = 3;
		}
		else if (PTEMP[playerid][pDonateAccount] >= 5000000 && PTEMP[playerid][pDonateRank] < 2)
		{
			SCM(playerid, COLOR_GOLD, " Поздравляем! Вы достигли 2 уровня VIP");
			SCM(playerid, COLOR_GOLD, " Используйте /viphelp для просмотра функций VIP аккаунта");
			PTEMP[playerid][pDonateRank] = 2;
		}
		else if (PTEMP[playerid][pDonateAccount] >= 1000000 && PTEMP[playerid][pDonateRank] < 1)
		{
			SCM(playerid, COLOR_GOLD, " Поздравляем! Вы достигли 1 уровня VIP");
			SCM(playerid, COLOR_GOLD, " Используйте /viphelp для просмотра функций VIP аккаунта");
			PTEMP[playerid][pDonateRank] = 1;
		}
		mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_DONATE"` SET name = '%s', used = '1' WHERE code_one = '%i' AND code_two = '%i'",PTEMP[playerid][pName], GetPVarInt(playerid,"d_code1"), GetPVarInt(playerid,"d_code2"));
		mysql_function_query(DATABASE,QUERY,false,"","");
		DeletePVar(playerid,"d_code1"), DeletePVar(playerid,"d_code2");
		printf("Игрок %s ввёл донат-коды",Name(playerid));
	}
	case 28:
	{
		if (!r) return print("[Загрузка ...] Данные из Farms не получены!");
		for (x = 1; x <= r; x++)
		{
			FarmInfo[x][fID] = 				cache_get_row_int(x-1,0, DATABASE);
			cache_get_row(x-1, 1, 			FarmInfo[x][fOwner], DATABASE, MAX_PLAYER_NAME);
			FarmInfo[x][fMenu][0] = 		cache_get_row_float(x-1,2, DATABASE);
			FarmInfo[x][fMenu][1] = 		cache_get_row_float(x-1,3, DATABASE);
			FarmInfo[x][fMenu][2] = 		cache_get_row_float(x-1,4, DATABASE);
			FarmInfo[x][fCloakroom][0] = 	cache_get_row_float(x-1,5, DATABASE);
			FarmInfo[x][fCloakroom][1] = 	cache_get_row_float(x-1,6, DATABASE);
			FarmInfo[x][fCloakroom][2] = 	cache_get_row_float(x-1,7, DATABASE);
			FarmInfo[x][fBank] = 			cache_get_row_int(x-1,8, DATABASE);
			FarmInfo[x][fLandTax] = 		cache_get_row_int(x-1,9, DATABASE);
			FarmInfo[x][fZp] = 				cache_get_row_int(x-1,10, DATABASE);
			FarmInfo[x][fGrain_Price] = 	cache_get_row_int(x-1,11, DATABASE);
			FarmInfo[x][fGrain] = 			cache_get_row_int(x-1,12, DATABASE);
			FarmInfo[x][fGrain_Sown] = 		cache_get_row_int(x-1,13, DATABASE);
			FarmInfo[x][fProds_Selling] = 	cache_get_row_int(x-1,14, DATABASE);
			FarmInfo[x][fProds] = 			cache_get_row_int(x-1,15, DATABASE);
			FarmInfo[x][fProds_Price] = 	cache_get_row_int(x-1,16, DATABASE);
			cache_get_row(x-1, 17, 			FarmInfo[x][fDeputy_1], DATABASE, MAX_PLAYER_NAME);
			cache_get_row(x-1, 18, 			FarmInfo[x][fDeputy_2], DATABASE, MAX_PLAYER_NAME);
			cache_get_row(x-1, 19, 			FarmInfo[x][fDeputy_3], DATABASE, MAX_PLAYER_NAME);
			cache_get_row(x-1, 20, 			FarmInfo[x][fFarmer_1], DATABASE, MAX_PLAYER_NAME);
			cache_get_row(x-1, 21, 			FarmInfo[x][fFarmer_2], DATABASE, MAX_PLAYER_NAME);
			cache_get_row(x-1, 22, 			FarmInfo[x][fFarmer_3], DATABASE, MAX_PLAYER_NAME);
			cache_get_row(x-1, 23, 			FarmInfo[x][fFarmer_4], DATABASE, MAX_PLAYER_NAME);
			cache_get_row(x-1, 24, 			FarmInfo[x][fFarmer_5], DATABASE, MAX_PLAYER_NAME);

			cache_get_row(x-1, 25, 			FarmInfo[x][fAuctions], DATABASE, 128);
			sscanf(FarmInfo[x][fAuctions], "p<,>a<i>[5]",FarmInfo[x][fAuction]);
			cache_get_row(x-1, 26, 			FarmInfo[x][fAuctionName], DATABASE, MAX_PLAYER_NAME);
			FarmInfo[x][fBiker] =			cache_get_row_int(x-1, 27, DATABASE);
			FarmInfo[x][fPickup][0] = CreatePickup(1239, 23, FarmInfo[x][fMenu][0], FarmInfo[x][fMenu][1], FarmInfo[x][fMenu][2]);
			FarmInfo[x][fPickup][1] = CreatePickup(1275, 23, FarmInfo[x][fCloakroom][0], FarmInfo[x][fCloakroom][1], FarmInfo[x][fCloakroom][2]);
			format(YCMDstr, 160, "Ферма ID: {FFFFFF}%i\n{DDB201}Информация: {FFFFFF}/finfo",x-1);
			FarmInfo[x][fLabel] = CreateDynamic3DTextLabel(YCMDstr, 0xDDB201FF,FarmInfo[x][fMenu][0], FarmInfo[x][fMenu][1], FarmInfo[x][fMenu][2]+1,20.0);
			CreateDynamicMapIcon(FarmInfo[x][fMenu][0], FarmInfo[x][fMenu][1], FarmInfo[x][fMenu][2],56,0);
			TOTALFARM++;
		}
		printf("[Загрузка ...] Данные из Farm получены! (%i шт.)", TOTALFARM);
		// Кары у фермы 0
		FarmInfo[1][fSeed_Car][0] = CreateVehicle(478,-367.1718,-1437.3184,25.4536,90,113,1,-1);
		FarmInfo[1][fSeed_Car][1] = CreateVehicle(478,-367.1942,-1441.3794,25.4536,90,113,1,-1);
		FarmInfo[1][fCombine] = CreateVehicle(532,-376.9983,-1450.1539,25.4536,360,-1,-1,-1);
		// Кары у фермы 1
		FarmInfo[2][fSeed_Car][0] = CreateVehicle(478,-112.7682,-30.3074,2.8443,345,113,1,-1);
		FarmInfo[2][fSeed_Car][1] = CreateVehicle(478,-108.8456,-30.3074,2.8443,345,113,1,-1);
		FarmInfo[2][fCombine] = CreateVehicle(532,-99.6833,-21.9806,2.8404,69.9411,-1,-1,-1);
		// Кары у фермы 2
		FarmInfo[3][fSeed_Car][0] = CreateVehicle(478,-1033.8198,-1173.0507,128.9458,92.2105,113,1,-1);
		FarmInfo[3][fSeed_Car][1] = CreateVehicle(478,-1033.9097,-1169.5416,128.9458,92.2105,113,1,-1);
		FarmInfo[3][fCombine] = CreateVehicle(532,-1187.8906,-1062.9275,128.9458,360,-1,-1,-1);
		// Кары у фермы 3
		FarmInfo[4][fSeed_Car][0] = CreateVehicle(478,-18.6129,45.1707,2.8443,248.6538,113,1,-1);
		FarmInfo[4][fSeed_Car][1] = CreateVehicle(478,-19.8854,42.0788,2.8429,248.6538,113,1,-1);
		FarmInfo[4][fCombine] = CreateVehicle(532,-28.4954,44.7194,2.8443,160.1106,-1,-1,-1);
		// Кары у фермы 4
		FarmInfo[5][fSeed_Car][0] = CreateVehicle(478,1949.1245,157.6664,36.6507,340.1,113,1,-1);
		FarmInfo[5][fSeed_Car][1] = CreateVehicle(478,1951.6958,156.7463,36.5491,340.1,113,1,-1);
		FarmInfo[5][fCombine] = CreateVehicle(532,1910.3037,192.0922,36.1344,256.9094,-1,-1,-1);
		for (new z = 1; z <= TOTALFARM; z++)
		{
			Farmcar_pickup[FarmInfo[z][fSeed_Car][0]] = 0;
			Farmcar_pickup[FarmInfo[z][fSeed_Car][1]] = 0;
			SetVehicleParamsEx(FarmInfo[z][fSeed_Car][0],false,false,false,false,false,false,false);
			SetVehicleParamsEx(FarmInfo[z][fSeed_Car][1],false,false,false,false,false,false,false);
			SetVehicleParamsEx(FarmInfo[z][fCombine],false,false,false,false,false,false,false);
			CarHealth[FarmInfo[z][fSeed_Car][0]] = float(1000);
			CarHealth[FarmInfo[z][fSeed_Car][1]] = float(1000);
			CarHealth[FarmInfo[z][fCombine]] = float(1000);
		}
	}
	case 29:
	{
		new day, month, year;
		gettime(day,month,year);
		if (IsPlayerConnected(GetPlayerID(FarmInfo[playerid][fAuctionName]))) SCM(GetPlayerID(FarmInfo[playerid][fAuctionName]),-1," Вы приобрели СТО/Ферму с аукциона!");
		strmid(FarmInfo[playerid][fOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(FarmInfo[playerid][fDeputy_1],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(FarmInfo[playerid][fDeputy_2],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(FarmInfo[playerid][fDeputy_3],"None",0,strlen("None"),MAX_PLAYER_NAME);
		FarmInfo[playerid][fLandTax] = 6000;
		FarmInfo[playerid][fBank] = (FarmInfo[playerid][fAuction][0]/100)*20;
		FarmInfo[playerid][fProds] = 0;
		FarmInfo[playerid][fZp] = 30;
		FarmInfo[playerid][fGrain_Price] = 5;
		FarmInfo[playerid][fGrain] = 0;
		FarmInfo[playerid][fGrain_Sown] = 0;
		FarmInfo[playerid][fProds_Selling] = 1;
		FarmInfo[playerid][fProds_Price] = 21;
		strmid(FarmInfo[playerid][fOwner],FarmInfo[playerid][fAuctionName], 0, strlen(FarmInfo[playerid][fAuctionName]), MAX_PLAYER_NAME);
		if (IsPlayerConnected(GetPlayerID(FarmInfo[playerid][fAuctionName]))) FGet(GetPlayerID(FarmInfo[playerid][fAuctionName]));
		strmid(FarmInfo[playerid][fAuctionName], "None", 0, strlen("None"), 10);
		FarmInfo[playerid][fAuction][0] = 0;
		FarmInfo[playerid][fAuction][1] = 0;
		FarmInfo[playerid][fAuction][2] = 0;
		FarmInfo[playerid][fAuction][3] = 0;
		FarmInfo[playerid][fAuction][4] = mktimes(0,0,0,day+14,month,year);
	}
	case 30:
	{
		if (!r) return print("[Аукцион СТО/Ферм] Нет аккаунта. Деньги не были зачислены!");
		mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pBank = pBank + %i WHERE Name = '%e'",FarmInfo[bizselect[playerid]][fAuction][1],FarmInfo[bizselect[playerid]][fAuctionName]);
		mysql_function_query(DATABASE,QUERY,false,"","");
		printf("Игроку %s зачислено %i вирт за аукцион СТО/Ферм",FarmInfo[bizselect[playerid]][fAuctionName], FarmInfo[bizselect[playerid]][fAuction][1]);
	}
	case 31:
	{
		if (!r) return print("[Загрузка ...] Данные из Stall не получены!");
		for (x = 1; x <= r; x++)
		{
			StallInfo[x][stID] = 				cache_get_row_int(x-1,0, DATABASE);
			StallInfo[x][stPos][0] = 			cache_get_row_float(x-1,1, DATABASE);
			StallInfo[x][stPos][1] = 			cache_get_row_float(x-1,2, DATABASE);
			StallInfo[x][stPos][2] = 			cache_get_row_float(x-1,3, DATABASE);
			StallInfo[x][stPos][3] = 			cache_get_row_float(x-1,4, DATABASE);
			TOTALSTALL++;

			CreateDynamicObject(1340, StallInfo[x][stPos][0], StallInfo[x][stPos][1], StallInfo[x][stPos][2], 0, 0, StallInfo[x][stPos][3]);
			StallInfo[x][stText] = CreateDynamic3DTextLabel( "Не работает", 0xFF8C37FF, StallInfo[x][stPos][0], StallInfo[x][stPos][1], StallInfo[x][stPos][2], 8.0 );
		}
		printf("[Загрузка ...] Данные из Stall получены! (%i шт.)", TOTALSTALL);
	}
	case 32:
	{
		if (!r) return print("[Загрузка ...] Данные из Gangzone не получены!");
		for (x = 1; x <= r; x++)
		{
			GZInfo[x][gID] = 					cache_get_row_int(x-1,0, DATABASE);
			GZInfo[x][gCoords][0] = 			cache_get_row_float(x-1,1, DATABASE);
			GZInfo[x][gCoords][1] = 			cache_get_row_float(x-1,2, DATABASE);
			GZInfo[x][gCoords][2] = 			cache_get_row_float(x-1,3, DATABASE);
			GZInfo[x][gCoords][3] = 			cache_get_row_float(x-1,4, DATABASE);
			GZInfo[x][gFrakVlad] = 				cache_get_row_int(x-1,5, DATABASE);
			TOTALGZ++;

			GZInfo[x][gZone] = GangZoneCreate(GZInfo[x][gCoords][0],GZInfo[x][gCoords][1],GZInfo[x][gCoords][2],GZInfo[x][gCoords][3]);
		}
		printf("[Загрузка ...] Данные из Gangzone получены! (%i шт.)", TOTALGZ);
	}
	case 33:
	{
		if (!r)
		{
			for (new i = 0; i < 5; i++)
			{
				mysql_format(DATABASE, QUERY, sizeof (QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`,`model`,`fuel`,`color_one`,`color_two`) VALUES ('%s','%i','462','100','1','1')" ,PTEMP[playerid][pName],i);
				mysql_function_query(DATABASE, QUERY, false, "", "");
			}
			/*mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`) VALUES ('%s','0')" ,PTEMP[playerid][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`) VALUES ('%s','1')" ,PTEMP[playerid][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`) VALUES ('%s','2')" ,PTEMP[playerid][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`) VALUES ('%s','3')" ,PTEMP[playerid][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`) VALUES ('%s','4')" ,PTEMP[playerid][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");*/
			return SCM(playerid,COLOR_GREY," Информация о ваших автомобилях не была найдена. Перезайдите на сервер!");
		}
		for (x = 0; x < r; x++)
		{
			CarInfo[playerid][carID][x] =          	cache_get_row_int(x,0, DATABASE);
			cache_get_row(x, 1, 			string, DATABASE, MAX_PLAYER_NAME);
			CarInfo[playerid][carModel][x] =       	cache_get_row_int(x,2, DATABASE);
			CarInfo[playerid][carColor_one][x] =   	cache_get_row_int(x,3, DATABASE);
			CarInfo[playerid][carColor_two][x] =   	cache_get_row_int(x,4, DATABASE);
			CarInfo[playerid][carPercent][x] =   	cache_get_row_int(x,5, DATABASE);
			CarInfo[playerid][carFuel][x] =   		cache_get_row_float(x,6, DATABASE);
			CarInfo[playerid][carVehcom_1][x] =   		cache_get_row_int(x,7, DATABASE);
			CarInfo[playerid][carVehcom_2][x] =   		cache_get_row_int(x,8, DATABASE);
			CarInfo[playerid][carVehcom_3][x] =   		cache_get_row_int(x,9, DATABASE);
			CarInfo[playerid][carVehcom_4][x] =   		cache_get_row_int(x,10, DATABASE);
			CarInfo[playerid][carVehcom_5][x] =   		cache_get_row_int(x,11, DATABASE);
			CarInfo[playerid][carVehcom_6][x] =   		cache_get_row_int(x,12, DATABASE);
			CarInfo[playerid][carVehcom_7][x] =   		cache_get_row_int(x,13, DATABASE);
			CarInfo[playerid][carVehcom_8][x] =   		cache_get_row_int(x,14, DATABASE);
			CarInfo[playerid][carVehcom_9][x] =   		cache_get_row_int(x,15, DATABASE);
			CarInfo[playerid][carVehcom_10][x] =   		cache_get_row_int(x,16, DATABASE);
			CarInfo[playerid][carVehcom_11][x] =   		cache_get_row_int(x,17, DATABASE);
			CarInfo[playerid][carVehcom_12][x] =   		cache_get_row_int(x,18, DATABASE);
			CarInfo[playerid][carVehcom_13][x] =   		cache_get_row_int(x,19, DATABASE);
			CarInfo[playerid][carVehcom_14][x] =   		cache_get_row_int(x,20, DATABASE);
		}
		if (CarInfo[playerid][carModel][0] == 0 || CarInfo[playerid][carModel][1] == 0 || CarInfo[playerid][carModel][2] == 0
		|| CarInfo[playerid][carModel][3] == 0 || CarInfo[playerid][carModel][4] == 0)
		{
			for (new i = 0; i < 5; i++)
			{
				CarInfo[playerid][carModel][i] = 462;
				CarInfo[playerid][carColor_one][i] = 1;
				CarInfo[playerid][carColor_two][i] = 1;
				CarInfo[playerid][carPercent][i] = 100;
			}
		}
		printf("[Загрузка ...] Автомобили игрока %s были загружены: %i, %i, %i, %i, %i",Name(playerid), CarInfo[playerid][carModel][0],CarInfo[playerid][carModel][1],CarInfo[playerid][carModel][2],CarInfo[playerid][carModel][3],CarInfo[playerid][carModel][4]);
		if (HGet(playerid))
		{
			new house = PTEMP[playerid][pPHouseKey];
			switch(HouseInfo[house][hKlass])
			{
				case 0..1:
				{
					garage_car[playerid][0] = CreateVehicle(CarInfo[playerid][carModel][0], HouseInfo[house][hCarx], HouseInfo[house][hCary], HouseInfo[house][hCarz], HouseInfo[house][hCarc] , CarInfo[playerid][carColor_one][0] ,CarInfo[playerid][carColor_two][0], 86400);
					SetVehicleParamsEx(garage_car[playerid][0],false,false,false,true,false,false,false);
					CarHealth[garage_car[playerid][0]] = float(1000);
					createdcar ++;
					Fuell[garage_car[playerid][0]] = CarInfo[playerid][carFuel][0];
					LoadTuning(playerid,garage_car[playerid][0],0);
					house_car[playerid] = garage_car[playerid][0];
				}
				case 2: // house C Class
				{
					SpawnCarOne(playerid, 248.1234,-110.5993,1003.6578,90.6935); // Load car #2
					LinkVehicleToInterior(garage_car[playerid][0], 19);
					SetVehicleVirtualWorld(garage_car[playerid][0], house+100);
					//----------------------
					SpawnCarTwo(playerid, 248.3368,-104.4114,1003.6582,86.1593); // Load car #1
					LinkVehicleToInterior(garage_car[playerid][1], 19);
					SetVehicleVirtualWorld(garage_car[playerid][1], house+100);
				}
				case 3: // house B Class
				{
					SpawnCarOne(playerid, 435.5904,468.6050,1002.6595,358.6705); // Load car #1
					LinkVehicleToInterior(garage_car[playerid][0], 19);
					SetVehicleVirtualWorld(garage_car[playerid][0], house+100);
					//----------------------
					SpawnCarTwo(playerid, 441.7249,468.3962,1002.6600,360.0000); // Load car #2
					LinkVehicleToInterior(garage_car[playerid][1], 19);
					SetVehicleVirtualWorld(garage_car[playerid][1], house+100);
					//----------------------
					SpawnCarThree(playerid, 447.4809,468.1860,1002.6586,358.1951); // Load car #3
					LinkVehicleToInterior(garage_car[playerid][2], 19);
					SetVehicleVirtualWorld(garage_car[playerid][2], house+100);
				}
				case 4: // house A Class
				{
					SpawnCarOne(playerid, 893.5298,31.7400,1004.1795,333.8575); // Load car #1
					LinkVehicleToInterior(garage_car[playerid][0], 19);
					SetVehicleVirtualWorld(garage_car[playerid][0], house+100);
					//----------------------
					SpawnCarTwo(playerid, 897.6765,31.8136,1004.1783,0.9835); // Load car #2
					LinkVehicleToInterior(garage_car[playerid][1], 19);
					SetVehicleVirtualWorld(garage_car[playerid][1], house+100);
					//----------------------
					SpawnCarThree(playerid, 902.9612,31.9576,1004.1783,1.5516); // Load car #3
					LinkVehicleToInterior(garage_car[playerid][2], 19);
					SetVehicleVirtualWorld(garage_car[playerid][2], house+100);
					//----------------------
					SpawnCarFour(playerid, 907.1154,32.3961,1004.1783,30.6716); // Load car #4
					LinkVehicleToInterior(garage_car[playerid][3], 19);
					SetVehicleVirtualWorld(garage_car[playerid][3], house+100);
				}
				case 5: // house S Class
				{
					SpawnCarOne(playerid, 511.2867,505.0032,1002.3588,47.6021); // Load car #1
					LinkVehicleToInterior(garage_car[playerid][0], 19);
					SetVehicleVirtualWorld(garage_car[playerid][0], house+100);
					//----------------------
					SpawnCarTwo(playerid, 504.8487,503.1697,1002.3583,90.2742); // Load car #3
					LinkVehicleToInterior(garage_car[playerid][1], 19);
					SetVehicleVirtualWorld(garage_car[playerid][1], house+100);
					//----------------------
					SpawnCarThree(playerid, 504.5507,512.3398,1002.3583,91.0430); // Load car #4
					LinkVehicleToInterior(garage_car[playerid][2], 19);
					SetVehicleVirtualWorld(garage_car[playerid][2], house+100);
					//----------------------
					SpawnCarFour(playerid, 504.7199,521.3282,1002.3588,90.3364); // Load car #5
					LinkVehicleToInterior(garage_car[playerid][3], 19);
					SetVehicleVirtualWorld(garage_car[playerid][3], house+100);
					//----------------------
					SpawnCarFive(playerid, 511.4334,518.2543,1002.3597,126.6747); // Load car #2
					LinkVehicleToInterior(garage_car[playerid][4], 19);
					SetVehicleVirtualWorld(garage_car[playerid][4], house+100);
				}
			}
			//SetPVarInt(playerid,"chosencar",0);
		}
	}
	case 34:
	{
		new null[2] = 0;
		if(r)
		{
			for(x = 1; x <= r; x++)
			{
				new unban = cache_get_row_int(x-1,1, DATABASE);
				if(unban < Now())
				{
					mysql_format(DATABASE,QUERY,128, "DELETE FROM `boost` WHERE `Text` = 'BoostTime'");
					mysql_function_query(DATABASE,QUERY,false,"","");
					null[0]++;
					booston = 0;
				}
				else null[1]++,booston = 1;
			}
		}
		printf("[Загрузка ...] Бонусы включены %i. Бонусы выключены %i",null[1],null[0]);
	}
	case 35:
	{
		if(r)
		{
			new ban = cache_get_field_content_int(0,"boosttime");
			new year, month, day,hour,minute,second;
			TimestampToDates(ban, year, month, day, hour, minute, second, 0);
			booston = 1;
		}
	}
	case 36:
	{
		if(r)
		{
			new dialog[510];
			strcat(dialog,"Бонус\t\tМножитель\n");
			strcat(dialog,"Опыт\t\t3.0000\n");
			strcat(dialog,"Донат\t\t2.0000\n");
			strcat(dialog,"Патронов в Аммо\t\t3.0000\n");
			strcat(dialog,"Патронов у Мафий\t\t3.0000\n");
			strcat(dialog,"Патронов у Банд\t\t3.0000\n");
			strcat(dialog,"Патронов у Байкеров\t\t3.0000\n");
			strcat(dialog,"Опыт Такси\t\t3.0000\n");
			strcat(dialog,"Опыт Продуктовозов\t\t2.0000\n");
			strcat(dialog,"Опыт Дальнобойщиков\t\t3.0000\n");
			strcat(dialog,"Опыт Автоугонщиков\t\t3.0000\n");
			strcat(dialog,"Скилл Ударов\t\t3.0000\n");
			strcat(dialog,"Скилл Оружия\t\t3.0000\n");
			strcat(dialog,"Скидка в Автосалоне\t\t0.8000\n");
			strcat(dialog,"Скидка на Скины\t\t0.8000\n");
			strcat(dialog,"Скидка на Квартиры\t\t0.6000\n");
			strcat(dialog,"Процент в Костях\t\t0.5000\n");
			strcat(dialog,"Приз в Гонках\t\t3.0000\n");
			strcat(dialog,"Приз в Пейнтболе\t\t3.0000\n");
			strcat(dialog,"Таймер на Ферме\t\t0.3300\n");
			strcat(dialog,"Таймер на Нарко\t\t0.3300\n");
			strcat(dialog,"Промокод\t\t2.0000\n");
			new btime = cache_get_field_content_int(0,"boosttime");
			new year, month, day, hour, minute, second;
			TimestampToDates(btime, year, month, day, hour, minute, second, 0);
			format(YCMDstr, sizeof(YCMDstr), "Действует до: %02i/%02i/%02i  %02i:%02i",day,month,year,hour,minute);
			ShowPlayerDialog(playerid, 9922, DIALOG_STYLE_TABLIST_HEADERS, YCMDstr,dialog,"Закрыть", "");
		}
	}
	case 37:
	{
		if (!r) return print("[Error] Информация о машинах игрока в БД не найдена");

		new temp[0x9e];
		for (x = 0; x < r; x++)
		{
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_CARS"` SET ");
			format(temp,sizeof(temp),"`model`= '%i',",CarInfo[playerid][carModel][x]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`color_one`= '%i',",CarInfo[playerid][carColor_one][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`color_two`= '%i',",CarInfo[playerid][carColor_two][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`percent`= '%i',",CarInfo[playerid][carPercent][x]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`fuel`= '%f',",CarInfo[playerid][carFuel][x]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_1`= '%i',",CarInfo[playerid][carVehcom_1][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_2`= '%i',",CarInfo[playerid][carVehcom_2][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_3`= '%i',",CarInfo[playerid][carVehcom_3][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_4`= '%i',",CarInfo[playerid][carVehcom_4][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_5`= '%i',",CarInfo[playerid][carVehcom_5][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_6`= '%i',",CarInfo[playerid][carVehcom_6][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_7`= '%i',",CarInfo[playerid][carVehcom_7][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_8`= '%i',",CarInfo[playerid][carVehcom_8][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_9`= '%i',",CarInfo[playerid][carVehcom_9][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_10`= '%i',",CarInfo[playerid][carVehcom_10][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_11`= '%i',",CarInfo[playerid][carVehcom_11][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_12`= '%i',",CarInfo[playerid][carVehcom_12][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_13`= '%i',",CarInfo[playerid][carVehcom_13][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vehcom_14`= '%i'",CarInfo[playerid][carVehcom_14][x]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp)," WHERE id = '%i' AND owner = '%s'",x,PTEMP[playerid][pName]),		strcat(QUERY,temp,sizeof(QUERY));
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
		printf("[Сохранение] Автомобили %s | %i,%i,%i,%i,%i сохранены",PTEMP[playerid][pName],CarInfo[playerid][carModel][0],CarInfo[playerid][carModel][1],CarInfo[playerid][carModel][2],CarInfo[playerid][carModel][3],CarInfo[playerid][carModel][4]);
	}
	case 55:
	{
		if(!r) return true;
		gRating[Rifa] = cache_get_field_content_int(0, "mark");
		gRating[Grove] = cache_get_field_content_int(1, "mark");
		gRating[Ballas] = cache_get_field_content_int(2, "mark");
		gRating[Vagos] = cache_get_field_content_int(3, "mark");
		gRating[Aztec] = cache_get_field_content_int(4, "mark");
		printf("[Загрузка ...] Данные про рейтинг банд получены: %i %i %i %i %i", gRating[Rifa], gRating[Grove], gRating[Ballas], gRating[Vagos], gRating[Aztec]);
		//
		new day, month, year;
		getdate(year, month, day);
		if(day == 1)
		{
			mysql_format(DATABASE, QUERY, 62, "SELECT `Name`,`grating` FROM `"TABLE_ACCOUNTS"` WHERE `grating` > '0'");
			mysql_query(DATABASE, QUERY);
			new rs = cache_num_rows();
			new labelName[32], label;
			if(rs)
			{
				cache_get_field_content(0,"Name",labelName,DATABASE,60);
				label = cache_get_field_content_int(0, "grating");
				new labels;
				for(new i = 0; i < rs; i++)
				{
					labels = cache_get_field_content_int(i, "grating");
					if(label < labels)
					{
						label = labels;
						cache_get_field_content(i,"Name",labelName,DATABASE,60);
					}
				}
			}
			else
			{
				labelName = "Нет"; //strmid(labelName, "Нет", 0, strlen("Нет"), sizeof(labelName));
				label = 0;
			}
			mysql_format(DATABASE,QUERY, 300, "INSERT INTO `gratinghistory` (`date`, `player`, `playerMark`, `Grove street`, `Ballas`, `Rifa`, `Aztec`, `Vagos`) VALUES ('%02i/%02i/%02i', '%s', '%i', '%i', '%i', '%i', '%i', '%i')",
						year, month, day, labelName, label, gRating[Grove], gRating[Ballas], gRating[Rifa], gRating[Aztec], gRating[Vagos]);
			mysql_function_query(DATABASE,QUERY,false,"","");
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET `grating` = '0'");
			mysql_function_query(DATABASE,QUERY,false,"","");
			mysql_format(DATABASE, QUERY, 128, "UPDATE `grating` SET `mark` = '0'");
			mysql_function_query(DATABASE,QUERY,false,"","");
			mysql_format(DATABASE, QUERY, 62, "SELECT pCash FROM `"TABLE_ACCOUNTS"` WHERE Name = '%s'",labelName);
			mysql_query(DATABASE, QUERY);
			new cashes = cache_get_field_content_int(0,"pCash");
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET `pCash` = '%i', `pText` = '8' WHERE Name = '%s'", cashes+2500000, labelName);
			mysql_function_query(DATABASE,QUERY,false,"","");
			new jq1, jq2, jq3, jqr;
			jqr = 0;
			if(jqr < gRating[Grove])
			{
				jq1 = 15;
				jqr = gRating[Grove];
			}
			if(jqr < gRating[Ballas])
			{
				jq1 = 12;
				jqr = gRating[Ballas];
			}
			if(jqr < gRating[Vagos])
			{
				jq1 = 13;
				jqr = gRating[Vagos];
			}
			if(jqr < gRating[Aztec])
			{
				jq1 = 17;
				jqr = gRating[Aztec];
			}
			if(jqr < gRating[Rifa])
			{
				jq1 = 18;
				jqr = gRating[Rifa];
			}
			if(jq1 != 0)
			{
				mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_OTHERS"` SET `best_gang` = '%i'", jq1);
				mysql_function_query(DATABASE,QUERY,false,"","");
			}
			BestGang = jq1;
			new fqs[32];
			switch(BestGang)
			{
				case 15: FracBank[0][fGrove]  += 5000000, fqs = "Grove";
				case 12: FracBank[0][fBallas] += 5000000, fqs = "Ballas";
				case 13: FracBank[0][fVagos]  += 5000000, fqs = "Vagos";
				case 17: FracBank[0][fAztek]  += 5000000, fqs = "Aztec";
				case 18: FracBank[0][fRifa]   += 5000000, fqs = "Rifa";
			}
			if(jq1 > 0) printf("Банде %s зачислено 5 000 000 за первое место", fqs);
			else printf("Лучшая банда не определена");
			jqr = 0;
			if(jqr < gRating[Grove] && jq1 != 15)
			{
				jq2 = 15;
				jqr = gRating[Grove];
			}
			if(jqr < gRating[Ballas] && jq1 != 12)
			{
				jq2 = 12;
				jqr = gRating[Ballas];
			}
			if(jqr < gRating[Vagos] && jq1 != 13)
			{
				jq2 = 13;
				jqr = gRating[Vagos];
			}
			if(jqr < gRating[Aztec] && jq1 != 17)
			{
				jq2 = 17;
				jqr = gRating[Aztec];
			}
			if(jqr < gRating[Rifa] && jq1 != 18)
			{
				jq2 = 18;
				jqr = gRating[Rifa];
			}
			switch(jq2)
			{
				case 15: FracBank[0][fGrove]  += 2000000, fqs = "Grove";
				case 12: FracBank[0][fBallas] += 2000000, fqs = "Ballas";
				case 13: FracBank[0][fVagos]  += 2000000, fqs = "Vagos";
				case 17: FracBank[0][fAztek]  += 2000000, fqs = "Aztec";
				case 18: FracBank[0][fRifa]   += 2000000, fqs = "Rifa";
			}
			if(jq2 > 0) printf("Банде %s зачислено 2 000 000 за второе место", fqs);
			else printf("Вторая банда не определена");
			jqr = 0;
			if(jqr < gRating[Grove] && jq1 != 15 && jq2 != 15)
			{
				jq3 = 15;
				jqr = gRating[Grove];
			}
			if(jqr < gRating[Ballas] && jq1 != 12 && jq2 != 12)
			{
				jq3 = 12;
				jqr = gRating[Ballas];
			}
			if(jqr < gRating[Vagos] && jq1 != 13 && jq2 != 13)
			{
				jq3 = 13;
				jqr = gRating[Vagos];
			}
			if(jqr < gRating[Aztec] && jq1 != 17 && jq2 != 17)
			{
				jq3 = 17;
				jqr = gRating[Aztec];
			}
			if (jqr < gRating[Rifa] && jq1 != 18 && jq2 != 18)
			{
				jq3 = 18;
				jqr = gRating[Rifa];
			}
			switch (jq3)
			{
				case 15: FracBank[0][fGrove]  += 1000000, fqs = "Grove";
				case 12: FracBank[0][fBallas] += 1000000, fqs = "Ballas";
				case 13: FracBank[0][fVagos]  += 1000000, fqs = "Vagos";
				case 17: FracBank[0][fAztek]  += 1000000, fqs = "Aztec";
				case 18: FracBank[0][fRifa]   += 1000000, fqs = "Rifa";
			}
			if (jq3 > 0) printf("Банде %s зачислено 1 000 000 за третье место", fqs);
			else printf("Третья банда не определена");
			gRating[Grove] = 0, gRating[Ballas] = 0, gRating[Vagos] = 0, gRating[Aztec] = 0, gRating[Rifa] = 0;
		}
	}}
	return true;
}