public OnPlayerRequestClass(playerid, classid)
{
	if(GetPVarInt(playerid, "start_menu")) return true;
	if(SERVERTEST) SendMes(playerid,COLOR_BLUE,"REQUEST: PLAYERID - %i, CLASSID - %i",playerid,classid);
	if(PTEMP[playerid][pLogin] == 1)
	{
		SCM(playerid, -1, " Сменить скин можно в магазинах 'Victim'. (( Используйте: /gps >> [3] Магазины ))");
		return SpawnPlayer(playerid);
	}
	//==========================================================================
	ResetNew(playerid);
	LoadRecon(playerid);
	CreateTextDraws(playerid);
	CaptureTextDraws(playerid);
	ShopText[playerid] = CreatePlayerTextDraw(playerid,509.000000,180.000000,"Model: Landstalker");
	PlayerTextDrawBackgroundColor(playerid,ShopText[playerid],255);
	PlayerTextDrawFont(playerid,ShopText[playerid],1);
	PlayerTextDrawSetOutline(playerid,ShopText[playerid],1);
	PlayerTextDrawSetShadow(playerid,ShopText[playerid],0);
	PlayerTextDrawLetterSize(playerid,ShopText[playerid],0.270000,1.200000);
	PlayerTextDrawColor(playerid,ShopText[playerid],-1);
	PlayerTextDrawSetProportional(playerid,ShopText[playerid],1);
	new ip[2][16],x;
	GetPlayerIp(playerid,ip[0],16);
	foreach(i)
	{
		if(i == playerid) continue;
		GetPlayerIp(i,ip[1],16);
		if(!strcmp(ip[0],ip[1],true)) x++;
		if(x > 1) Kick(i), Kick(playerid);
		break;
	}
	SetPlayerInterior(playerid, 0);
	SCM(playerid, 0xEAC700AA, " Добро пожаловать на "FullServName"");
	SetPlayerFacingAngle(playerid, 179.5547);
	SetPlayerCameraPos(playerid, -1826.819336, 1074.619995, 191.185898);
	SetPlayerCameraLookAt(playerid, -1826.819336, 1070.619995, 191.185898);
	//	SetPlayerCameraPos(playerid, -2068.860107, 1063.500000, 370.769989);
	//	SetPlayerCameraLookAt(playerid, -1752.900024, 707.469971, 125.239998);
	TogglePlayerControllable(playerid, 0);
	mysql_format(DATABASE, QUERY, 128, "SELECT * FROM `"TABLE_BANIP"` WHERE `IP` = '%s'", ip[0]);
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",4,playerid,"");
	mysql_format(DATABASE, QUERY, 256, "SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%e'",Name(playerid));
	mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",5,playerid,"");
	SetPVarInt(playerid, "start_menu", 1);
	return true;
}