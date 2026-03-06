publics:PlayerRegister(playerid)
{
	PTEMP[playerid][pChar][0] = ChosenSkin[playerid];
	SelectCharPlace[playerid] = 0;
	CharPrice[playerid] = 0;
	SelectCharID[playerid] = 0;
	SelectChar[playerid] = 0;
	PicCP[playerid] = 0;
	SCM(playerid, -1, " Поздравляем Вас с успешной регистрацией!");
	SCM(playerid, 0x9b000ff, " Подсказка: Направляйтесь на работу грузчика (( Используйте /GPS >> [26] Работа грузчика ))");
	SCM(playerid, 0x9b000ff, " Подсказка: Грузчиком вы сможете заработать денег на водительские права");
	SCM(playerid, 0x9b000ff, " Подсказка: Рядом с вами есть остановка, где можно дождаться автобус ( Внутри Городской )");
	SCM(playerid, 0x9b000ff, " Подсказка: А также любой таксист отвезет вас на работу бесплатно");
	SCM(playerid, -1, " Подсказка: Мы настоятельно рекомендуем вам прочесть \"Помощь\"");
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
	SetSpawnInfo(playerid, 0, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	mysql_format(DATABASE,QUERY,128,"SELECT * FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%e'",PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,true,"_MySQL_QUERY","iis",2,playerid,"");
	mysql_format(DATABASE, QUERY, sizeof(QUERY), "DELETE FROM `"TABLE_CARS"` WHERE Name = '%e'" ,PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	for(new i=0;i<5;i++)
	{
		mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`,`model`,`fuel`,`color_one`,`color_two`) VALUES ('%e','%i','462','100','1','1')" ,PTEMP[playerid][pName],i);
		mysql_function_query(DATABASE,QUERY,false,"","");
	}
	new playersip[32];
	mysql_format(DATABASE,QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pIp = '%s' WHERE name = '%e'",playersip, PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	/*
    mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`) VALUES ('%s','1')" ,PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`) VALUES ('%s','2')" ,PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`) VALUES ('%s','3')" ,PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
	mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_CARS"` (`owner`,`id`) VALUES ('%s','4')" ,PTEMP[playerid][pName]);
	mysql_function_query(DATABASE,QUERY,false,"","");
    */
	SaveMySQL(1, playerid);
	SaveMySQL(2, playerid);
	SaveMySQL(3, playerid);
	SaveMySQL(4, playerid);
	SaveMySQL(5, playerid);
	SaveMySQL(6, playerid);
	SaveMySQL(9, playerid);
	//SaveMySQL(10, playerid);
}