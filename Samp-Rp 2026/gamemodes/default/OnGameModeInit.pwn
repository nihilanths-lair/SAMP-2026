public OnGameModeInit()
{
	SendRconCommand("hostname Mod name: Entropy-Rp | Room: "NumberServer"");
	SendRconCommand("gamemodetext RolePlay");
	SendRconCommand("language Russian");
    SendRconCommand("weburl meltrune.com");

    SendRconCommand("password Secret434825");
	
	new rand1 = random(2)+1;
	new rand2 = random(2)+1;
	new rand3 = random(2)+1;
	ZernBuy = 3+rand1;
	UrojSell = 33+rand2;
	NarkSell = 33+rand3;
    SendRconCommand("ackslimit 150000");
    for(new i = 0; i < MAX_VEHICLES; i++)
    {
		jobcar[i] = false;
	}
	BikerZoneCoords[0][zoneX1] = 1937.3152,BikerZoneCoords[0][zoneY1] = 2210.0862,BikerZoneCoords[0][zoneX2] = 2011.1254,BikerZoneCoords[0][zoneY2] = 2266.0305;
	BikerZoneCoords[1][zoneX1] = 808.8674,BikerZoneCoords[1][zoneY1] = -1160.4417,BikerZoneCoords[1][zoneX2] = 928.9384,BikerZoneCoords[1][zoneY2] = -1306.6891;
	BikerZoneCoords[2][zoneX1] = -1875.3832,BikerZoneCoords[2][zoneY1] = 1187.3928,BikerZoneCoords[2][zoneX2] = -1754.3665,BikerZoneCoords[2][zoneY2] = 1287.2761;
	for(new x = 0; x < 3; x++)
	BikerZone[x] = GangZoneCreate(BikerZoneCoords[x][zoneX1],BikerZoneCoords[x][zoneY1],BikerZoneCoords[x][zoneX2],BikerZoneCoords[x][zoneY2]);

	if(GetMaxPlayers() > 1000) return SendRconCommand("exit");
	for(new i = 1; i<MAX_PLAYERS; i++) Sonar[i] = random(2000);
	for(new i=0; i<MAX_PLAYERS; i++) strmid(ExitInfo[i][ExitIP],"None", 0, strlen("None"), 32), ExitInfo[i][ExitTime] = 0;
	exitpodeezd = CreateDynamicPickup(1318, 1, 2238.9285,-1192.6212,1033.7969, -1);
	podeezdils = CreatePickup(1318, 1, 2265.8848,1647.5061,1084.2344, -1);
	new strings[256];
	format(strings, sizeof(strings), "Порт СФ\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[1],Sellugol[1],Sellderevo[1]);
	Doki[1] = Create3DTextLabel(strings, 0xFFFF00FF,-1731.4509,118.9413,3.5547,20.0,0,1);
	format(strings, sizeof(strings), "Порт ЛС\nНефть: %d\nУголь: %d\nДерево: %d",Sellbenz[0],Sellugol[0],Sellderevo[0]);
	Doki[0] = Create3DTextLabel(strings, 0xFFFF00FF,2601.7222,-2226.5867,13.3732,20.0,0,1);
	format(strings, sizeof(strings), "Нефтезавод №1\nЦена за тонну: %d",Benzbuy[0]);
	GasZavod[0] = Create3DTextLabel(strings, 0xFFFF00FF,256.4736,1414.5182,10.7075,20.0,0,1);
	format(strings, sizeof(strings), "Нефтезавод №2\nЦена за тонну: %d",Benzbuy[1]);
	GasZavod[1] = Create3DTextLabel(strings, 0xFFFF00FF,-1046.7723,-670.7208,32.3516,20.0,0,1);
	format(strings, sizeof(strings), "Склад угля №1\nЦена за тонну: %d",ugolbuy[0]);
	Sklad[0] = Create3DTextLabel(strings, 0xFFFF00FF,608.7718,847.8765,-43.1532,20.0,0,1);
	format(strings, sizeof(strings), "Лесопилка №1\nЦена за тонну: %d",Buyderevo[0]);
	Derevobuy[0] = Create3DTextLabel(strings, 0xFFFF00FF,-449.3336,-65.9115,59.4158,20.0,0,1);
	format(strings, sizeof(strings), "Лесопилка №2\nЦена за тонну: %d",Buyderevo[1]);
	Derevobuy[1] = Create3DTextLabel(strings, 0xFFFF00FF,-1978.6846,-2434.8274,30.6250,20.0,0,1);
	format(strings, sizeof(strings), "Склад угля №2\nЦена за тонну: %d",ugolbuy[1]);
	Sklad[1] = Create3DTextLabel(strings, 0xFFFF00FF,-1873.0896,-1720.2430,21.7500,20.0,0,1);
	// Кости
	Bone[0] = TextDrawCreate(595.147888, 142.666656, "usebox");
	TextDrawLetterSize(Bone[0], 0.000000, 18.155559);
	TextDrawTextSize(Bone[0], 519.464111, 0.000000);
	TextDrawAlignment(Bone[0], 1);
	TextDrawColor(Bone[0], 0);
	TextDrawUseBox(Bone[0], true);
	TextDrawBoxColor(Bone[0], 1128481664);
	TextDrawSetShadow(Bone[0], 0);
	TextDrawSetOutline(Bone[0], 0);
	TextDrawBackgroundColor(Bone[0], -1751672960);
	TextDrawFont(Bone[0], 0);

	Bone[1] = TextDrawCreate(557.540405, 251.999969, "SET_BET");
	TextDrawLetterSize(Bone[1], 0.429852, 1.360828);
	TextDrawTextSize(Bone[1], 8.721603, 61.250003);
	TextDrawAlignment(Bone[1], 2);
	TextDrawColor(Bone[1], -1347440641);
	TextDrawUseBox(Bone[1], true);
	TextDrawBoxColor(Bone[1], 555819408);
	TextDrawSetShadow(Bone[1], 0);
	TextDrawSetOutline(Bone[1], 1);
	TextDrawBackgroundColor(Bone[1], 51);
	TextDrawFont(Bone[1], 3);
	TextDrawSetProportional(Bone[1], 1);
	TextDrawSetSelectable(Bone[1], true);

	Bone[2] = TextDrawCreate(557.540710, 270.666656, "DICE");
	TextDrawLetterSize(Bone[2], 0.429852, 1.360828);
	TextDrawTextSize(Bone[2], 8.721603, 61.250003);
	TextDrawAlignment(Bone[2], 2);
	TextDrawColor(Bone[2], -1347440641);
	TextDrawUseBox(Bone[2], true);
	TextDrawBoxColor(Bone[2], 555819392);
	TextDrawSetShadow(Bone[2], 0);
	TextDrawSetOutline(Bone[2], 1);
	TextDrawBackgroundColor(Bone[2], 51);
	TextDrawFont(Bone[2], 3);
	TextDrawSetProportional(Bone[2], 1);
	TextDrawSetSelectable(Bone[2], true);

	Bone[3] = TextDrawCreate(557.540283, 289.333312, "EXIT");
	TextDrawLetterSize(Bone[3], 0.429852, 1.360828);
	TextDrawTextSize(Bone[3], 8.721603, 61.250003);
	TextDrawAlignment(Bone[3], 2);
	TextDrawColor(Bone[3], -1347440641);
	TextDrawUseBox(Bone[3], true);
	TextDrawBoxColor(Bone[3], 555819392);
	TextDrawSetShadow(Bone[3], 0);
	TextDrawSetOutline(Bone[3], 1);
	TextDrawBackgroundColor(Bone[3], 51);
	TextDrawFont(Bone[3], 3);
	TextDrawSetProportional(Bone[3], 1);
	TextDrawSetSelectable(Bone[3], true);
	//
	for(new i; i < MAX_BONE; i++)
	{
		CreateDynamicObject(1824,BoneCoor[i][0],BoneCoor[i][1],BoneCoor[i][2],0,0,BoneCoor[i][3]);
		BoneInfo[i][Crupie] = INVALID_PLAYER_ID;
		for(new idx= 0; idx < 5; idx++) BoneInfo[i][Gamer][idx] = INVALID_PLAYER_ID;
		BoneInfo[i][GameStart] = 0;
	}
	for(new i = 0; i < MAX_ROULET; i++) RouletKrupie[i] = INVALID_PLAYER_ID;
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	ShowNameTags(1);
	AntiDeAMX2();
	AntiDeAMX();
	SetNameTagDrawDistance(30.0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	new tmphour, tmpminute, tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;
	ghour = tmphour;
	SetWorldTime(tmphour);
	addd[0] = 5;
	addd[1] = 5;
	addd[2] = 5;
	licgate = CreateObject(968,-2074.50000000,-94.90000153,35.00000000,0.00000000,90.00000000,90.00000000);
	gruzgate = CreateObject(968,2203.8630371094,-2252.1179199219,13.5,0.00000000,270.00000000,316.00000000);
	Speed = TextDrawCreate(483.217968, 427.333312, "_");
	TextDrawLetterSize(Speed, 0.000000, -5.601846);
	TextDrawTextSize(Speed, 310.998535, 0.000000);
	TextDrawAlignment(Speed, 0);
	TextDrawColor(Speed, 0);
	TextDrawUseBox(Speed, true);
	TextDrawBoxColor(Speed, 102);
	TextDrawSetShadow(Speed, 0);
	TextDrawSetOutline(Speed, 0);
	TextDrawFont(Speed, 0);
	/*Speed = TextDrawCreate(533.000000, 393.000000, "____");
	TextDrawBackgroundColor(Speed, 255);
	TextDrawFont(Speed, 1);
	TextDrawLetterSize(Speed, 1.309998, 4.499999);
	TextDrawColor(Speed, -1);
	TextDrawSetOutline(Speed, 0);
	TextDrawSetProportional(Speed, 1);
	TextDrawSetShadow(Speed, 1);
	TextDrawUseBox(Speed, 1);
	TextDrawBoxColor(Speed, COLOR_BOX);
	TextDrawTextSize(Speed, 348.000000, 27.000000);*/
	BoxPanel = TextDrawCreate(352.000000, 356.000000, "_~n~_");
	TextDrawBackgroundColor(BoxPanel, 255);
	TextDrawFont(BoxPanel, 1);
	TextDrawLetterSize(BoxPanel, 0.500000, 1.000000);
	TextDrawColor(BoxPanel, 943208449);
	TextDrawSetOutline(BoxPanel, 0);
	//****//
	URL = TextDrawCreate(520.000000, 8.000000, "meltrune.com");
	TextDrawFont(URL, 0);
	TextDrawColor(URL, 0x4755B2AA);
	TextDrawLetterSize(URL, 0.3600, 1.400000);
	TextDrawSetOutline(URL, 1);
	/*URL = TextDrawCreate(520.000000, 8.000000, ""NameServer"");
	TextDrawFont(URL, 2);
	TextDrawColor(URL, 0x00FF00AA);
	TextDrawLetterSize(URL, 0.3600, 1.400000);
	TextDrawSetOutline(URL, 1);*/
	CreateObject(1569,2648.10,1185.73,9.82,0,0,0);
	// Домик
	modernhouse[0] = CreateObject(19462, 231.84, 1028.48, 1081.11, 0, 0, 0); // down
 	modernhouse[1] = CreateObject(19443, 231.84, 1034.01, 1081.11, 0, 0, 0);
	modernhouse[2] = CreateObject(19443, 231.84, 1035.60, 1081.11, 0, 0, 0);
	modernhouse[3] = CreateObject(1753, 231.13, 1031.17, 1079.75, 0, 0, -90);
	modernhouse[4] = CreateObject(1754, 231.13, 1033.43, 1079.75, 0, 0, -90);
	modernhouse[5] = CreateObject(1754, 231.13, 1026.95, 1079.75, 0, 0, -90);
	modernhouse[6] = CreateObject(19462, 227.06, 1036.37, 1081.11, 0, 0, 90);
	modernhouse[7] = CreateObject(1754, 229.13, 1035.73, 1079.75, 0, 0, 0);
	modernhouse[8] = CreateObject(1754, 226.16, 1035.73, 1079.75, 0, 0, 0);
	modernhouse[9] = CreateObject(2256, 225.21, 1036.27, 1082.15, 0, 0, 0);
	modernhouse[10] = CreateObject(19825, 231.72, 1030.21, 1081.17, 0, 0, -90);
	
	modernhouse[11] = CreateObject(19462, 218.88, 1036.37, 1087.79, 0, 0, 90); // left
	modernhouse[12] = CreateObject(2267, 220.55, 1036.22, 1088.64, 0, 0, 0);
	
	modernhouse[13] = CreateObject(19462, 230.17, 1026.02, 1092.56, 0, 0, 0); // up
	modernhouse[14] = CreateObject(19462, 230.18, 1033.29, 1092.61, 0, 0, 0);
	modernhouse[15] = CreateObject(19462, 225.47, 1036.37, 1094.90, 0, 0, 90);
	
	modernhouse[16] = CreateObject(2239, 231.39, 1022.07, 1082.98, 0, 0, 42.40);
	//
	// ============================= ACTORS ==============================
	ActorsRob[0] = CreateActor(179, 296.8526,-82.5276,1001.5156,358.8242);
	SetActorVirtualWorld(ActorsRob[0], 0);
	SetActorHealth(ActorsRob[0], 255);
	SetActorInvulnerable(ActorsRob[0], true);
	ActorsRob[1] = CreateActor(179, 295.4810,-40.2167,1001.5156,2.2428);
	SetActorVirtualWorld(ActorsRob[1], 0);
	SetActorHealth(ActorsRob[1], 255);
	SetActorInvulnerable(ActorsRob[1], true);
	ActorsRob[2] = CreateActor(179, 316.1089,-133.7254,999.6016,91.0626);
	SetActorVirtualWorld(ActorsRob[2], 0);
	SetActorHealth(ActorsRob[2], 255);
	SetActorInvulnerable(ActorsRob[2], true);

	ActorsRob[3] = CreateActor(30, 204.8515,-8.1603,1001.2109,268.4108); // ls victim
	SetActorVirtualWorld(ActorsRob[3], 2);
	SetActorHealth(ActorsRob[3], 255);
	SetActorInvulnerable(ActorsRob[3], true);
	ActorsRob[4] = CreateActor(30, 204.8515,-8.1603,1001.2109,268.4108); // sf victim
	SetActorVirtualWorld(ActorsRob[4], 1);
	SetActorHealth(ActorsRob[4], 255);
	SetActorInvulnerable(ActorsRob[4], true);

	ActorsRob[5] = CreateActor(274, 302.2798,180.4841,1214.7949,86.3554); // medic sf
	SetActorVirtualWorld(ActorsRob[5], 3);
	SetActorHealth(ActorsRob[5], 255);
	SetActorInvulnerable(ActorsRob[5], true);
	ActorsRob[6] = CreateActor(274, 302.2798,180.4841,1214.7949,86.3554); // medic ls
	SetActorVirtualWorld(ActorsRob[6], 4);
	SetActorHealth(ActorsRob[6], 255);
	SetActorInvulnerable(ActorsRob[6], true);
	ActorsRob[7] = CreateActor(274, 302.2798,180.4841,1214.7949,86.3554); // medic lv
	SetActorVirtualWorld(ActorsRob[7], 5);
	SetActorHealth(ActorsRob[7], 255);
	SetActorInvulnerable(ActorsRob[7], true);
	ActorsRob[8] = CreateActor(274, 302.2798,180.4841,1214.7949,86.3554); // medic fc
	SetActorVirtualWorld(ActorsRob[8], 6);
	SetActorHealth(ActorsRob[8], 255);
	SetActorInvulnerable(ActorsRob[8], true);
	ActorsRob[9] = CreateActor(274, 302.2798,180.4841,1214.7949,86.3554); // medic ls ghetto
	SetActorVirtualWorld(ActorsRob[9], 7);
	SetActorHealth(ActorsRob[9], 255);
	SetActorInvulnerable(ActorsRob[9], true);
	
	for(new i = 0; i < 10; i++) cdrob[i] = false;
	SetTimer("RobbingTimer", 2000, true);
	
	//=============================Nautosalon==================================
	//AutoSalon
	AutoShopText[0] = TextDrawCreate(527.000000, 230.000000, "<<");
	TextDrawLetterSize(AutoShopText[0], 0.220000, 1.199999);

	AutoShopText[1] = TextDrawCreate(581.000000, 230.000000, ">>");
	TextDrawLetterSize(AutoShopText[1], 0.220000, 1.199999);

	AutoShopText[2] = TextDrawCreate(581.000000, 271.000000, ">");
	TextDrawLetterSize(AutoShopText[2], 0.220000, 0.599999);

	AutoShopText[3] = TextDrawCreate(581.000000, 281.000000, ">");
	TextDrawLetterSize(AutoShopText[3], 0.220000, 0.599999);

	AutoShopText[4] = TextDrawCreate(527.000000, 281.000000, "<");
	TextDrawLetterSize(AutoShopText[4], 0.220000, 0.599999);

	AutoShopText[5] = TextDrawCreate(527.000000, 271.000000, "<");
	TextDrawLetterSize(AutoShopText[5], 0.220000, 0.599999);

	for(new s; s < 6; s++)
	{
		TextDrawTextSize(AutoShopText[s], 10.10, 40.40);
		TextDrawAlignment(AutoShopText[s], 2);
		TextDrawBackgroundColor(AutoShopText[s], 255);
		TextDrawFont(AutoShopText[s], 2);
		TextDrawColor(AutoShopText[s], -1);
		TextDrawSetProportional(AutoShopText[s], 1);
		TextDrawSetShadow(AutoShopText[s], 1);
		TextDrawUseBox(AutoShopText[s], 1);
		TextDrawBoxColor(AutoShopText[s], 555819392);
		TextDrawSetSelectable(AutoShopText[s],true);
	}

	AutoShopText[6] = TextDrawCreate(556.000000, 311.000000, "BUY");
	TextDrawLetterSize(AutoShopText[6], 0.450000, 0.899999);
	TextDrawBoxColor(AutoShopText[6], 144);
	TextDrawTextSize(AutoShopText[6], 10.10, 56.56);
	TextDrawSetSelectable(AutoShopText[6], 1);

	AutoShopText[7] = TextDrawCreate(556.000000, 331.000000, "EXIT");
	TextDrawLetterSize(AutoShopText[7], 0.450000, 0.899999);
	TextDrawBoxColor(AutoShopText[7], 144);
	TextDrawTextSize(AutoShopText[7], 10.10, 56.56);
	TextDrawSetSelectable(AutoShopText[7],true);

	AutoShopText[8] = TextDrawCreate(554.000000, 161.000000, "_");// фон
	TextDrawLetterSize(AutoShopText[8], 0.500000, 22.200017);
	TextDrawSetProportional(AutoShopText[8], 1);
	TextDrawBoxColor(AutoShopText[8], 1128481664);
	TextDrawTextSize(AutoShopText[8], 0.000000, 105.000000);

	for(new e = 6; e < 9; e++)
	{
		TextDrawAlignment(AutoShopText[e], 2);
		TextDrawBackgroundColor(AutoShopText[e], 255);
		TextDrawFont(AutoShopText[e], 1);
		TextDrawColor(AutoShopText[e], -1);
		TextDrawSetProportional(AutoShopText[e], 1);
		TextDrawSetShadow(AutoShopText[e], 1);
		TextDrawUseBox(AutoShopText[e], 1);
	}

	AutoShopText[9] = TextDrawCreate(522.000000, 211.000000, "SELECT CAR");
	AutoShopText[10] = TextDrawCreate(537.000000, 251.000000, "COLOR");
	AutoShopText[11] = TextDrawCreate(541.000000, 165.000000, "INFO");

	for(new r = 9; r < 12; r++)
	{
		TextDrawBackgroundColor(AutoShopText[r], 255);
		TextDrawFont(AutoShopText[r], 2);
		TextDrawSetOutline(AutoShopText[r], 0);
		TextDrawSetShadow(AutoShopText[r], 0);
		TextDrawLetterSize(AutoShopText[r], 0.260000, 1.300000);
		TextDrawColor(AutoShopText[r], -2016477185);
		TextDrawSetProportional(AutoShopText[r], 1);
	}
	//=============================AutoSalon===================================
	DRAP = TextDrawCreate(510.0, 120.0, "~n~~n~\t~b~[]select~n~\t\t\t~g~next: ~w~q ~n~\t\t\t~g~last: ~w~e~n~~n~\t~b~[]select color ~n~\t\t\t~g~next: ~w~num4 ~n~\t\t\t~g~last: ~w~num6~n~~n~\t~b~[]other ~n~\t\t\t~g~switch color: ~w~space~n~~n~\t\t\t~g~accept: ~w~return ~n~\t\t\t~r~cancel: ~w~c ~n~");
	TextDrawFont(DRAP, 2);
	TextDrawLetterSize(DRAP, 0.20,0.80);
	TextDrawColor(DRAP, -1);
	TextDrawSetShadow(DRAP, 1);
	TextDrawBackgroundColor(DRAP, 0x00000044);
	TextDrawSetOutline(DRAP, 0);
	TextDrawSetProportional(DRAP, 3);
	TextDrawAlignment(DRAP, 1);
	TextDrawUseBox(DRAP, 1);
	TextDrawBoxColor(DRAP, COLOR_BOX);
	//==========================================================================
	//
	//gpickup = CreatePickup(2060,23,2225.2063,-2276.5874,14.7647);
	//
	boyidet = false;
	//
	garagexit[0] = CreatePickup(1318,23,252.8194,-110.6712,1004.0859,-1);//
	garagexit[1] = CreatePickup(1318,23,428.7611,469.5622,1003.0859,-1);//
	garagexit[2] = CreatePickup(1318,23,904.5699,22.8954,1004.0859,-1);//
	garagexit[3] = CreatePickup(1318,23,516.2317,511.4258,1002.2659,-1);//
	//
	new prodpick[2];
	prodpick[0] = CreatePickup(1239,23,-1027.4069,-593.4584,32.0126);
	prodpick[1] = CreatePickup(1239,23,-514.4622,-543.0626,25.5234);
	//
	RouletCloakroom[0] = CreatePickup(1275, 23, 1963.7473,1063.2229,994.4688,-1); // Four Dragons
	RouletCloakroom[1] = CreatePickup(1275, 23, 2150.5393,1603.1434,1006.1802,-1); // Caligula
	//
	skills[0] = CreatePickup(1318,23,306.3997,-159.1386,999.5938,-1); // Входы для прокачки скиллов
	skills[1] = CreatePickup(1318,23,305.6985,-159.1157,999.5938,-1); // Выход :)
	ammonac[0] = CreatePickup(1318,23,1368.9360,-1279.7216,13.5469);//
	ammonac[1] = CreatePickup(1318,23,285.4752,-41.7966,1001.5156);//
	ammonac[2] = CreatePickup(1318,23,-2625.8296,208.2379,4.8125);//
	ammonac[3] = CreatePickup(1318,23,285.9187,-86.7644,1001.5229);//
	ammonac[4] = CreatePickup(1318,23,2159.5449,943.2165,10.8203);//
	ammonac[5] = CreatePickup(1318,23,315.8831,-143.6591,999.6016);//
	auctionpic[0] = CreatePickup(19134,23,359.0123,161.2824,1008.3828); // Аукцион в мэрии
	auctionpic[1] = CreatePickup(19134,23,358.7350,168.4931,1008.3828); // Аукцион в мэрии
	monitoring = CreatePickup(1239,23,358.7610,165.3077,1008.3828);
	pickcars[0] = CreatePickup(19134,23,acarsd[0][0],acarsd[0][1],acarsd[0][2]);// Выдача мопеда автоугонщикам.
	pickcars[1] = CreatePickup(19134,23,acarsd[1][0],acarsd[1][1],acarsd[1][2]);// Выдача мопеда автоугонщикам.
	pickcars[2] = CreatePickup(19134,23,acarsd[2][0],acarsd[2][1],acarsd[2][2]);// Выдача мопеда автоугонщикам.
	pickcars[3] = CreatePickup(19134,23,2515.4497,-1465.3451,23.9989);// Выдача мопеда автоугонщикам.
	pickcars[4] = CreatePickup(1239,23,2494.1060,-1464.7142,24.0255);// Работа автоугонщика.
	parashut = CreatePickup(1310,23,2428.0544,-741.8817,1422.5161); // Parachut Admins
	caligula[0] = CreatePickup(19132,23,2233.9912,1714.6836,1012.3828,-1);// Выход Caligula
	caligula[2] = CreatePickup(19132,23,2196.9653,1677.1547,12.3672);// Вход Caligula
	dragons[0] = CreatePickup(19132,23,2019.07,1017.6940,996.8750,-1);// Выход 4'Dragons
	dragons[1] = CreatePickup(19132,23,2019.3192,1007.7440,10.8203);// Вход 4'Dragons
	//===========================[ГРИБЫ]========================================
	mushroom[0] = CreatePickup(1603, 2, -332.3008,-1987.6200,26.1051); //
	CreatePickup(1603, 2, -375.2895,-2004.4412,28.4262); //
	CreatePickup(1603, 2, -420.7345,-1962.1367,20.7989); //
	CreatePickup(1603, 2, -370.9467,-2049.1355,28.5462); //
	CreatePickup(1603, 2, -448.5980,-2072.9041,80.6654); //
	CreatePickup(1603, 2, -490.3048,-2121.0930,89.5054); //
	CreatePickup(1603, 2, -515.2039,-2223.6245,42.7538); //
	CreatePickup(1603, 2, -556.2787,-2223.5444,34.8664); //
	CreatePickup(1603, 2, -653.4810,-2185.8540,14.6571); //
	CreatePickup(1603, 2, -697.4235,-2144.5728,24.7645); //
	CreatePickup(1603, 2, -913.5545,-2281.5803,45.6804); //
	CreatePickup(1603, 2, -924.2963,-2392.5601,63.9710); //
	CreatePickup(1603, 2, -921.2469,-2419.2676,73.1529); //
	CreatePickup(1603, 2, -928.6000,-2452.7974,90.8816); //
	CreatePickup(1603, 2, -1092.1782,-2576.2622,77.2730); //
	CreatePickup(1603, 2, -1114.4218,-2326.8787,44.7146); //
	CreatePickup(1603, 2, -1095.8896,-2317.7642,51.1427); //
	CreatePickup(1603, 2, -1036.0745,-2331.6079,60.0633); //
	CreatePickup(1603, 2, -1823.0471,-2169.1082,77.6051); //
	CreatePickup(1603, 2, -1745.4077,-2018.1677,74.5071); //
	CreatePickup(1603, 2, -1943.8130,-2144.5457,76.9309); //
	CreatePickup(1603, 2, -1955.9766,-2162.8020,75.9688); //
	CreatePickup(1603, 2, -1685.1254,-2385.9275,99.3290); //
	CreatePickup(1603, 2, -1643.7135,-2411.9897,95.7691); //
	CreatePickup(1603, 2, -1551.1573,-2505.1743,90.8708); //
	CreatePickup(1603, 2, -1465.4910,-2556.2893,63.7663); //
	CreatePickup(1603, 2, -1435.4855,-2544.3879,60.4281); //
	CreatePickup(1603, 2, -1401.0656,-2548.1582,55.9067); //
	CreatePickup(1603, 2, -1347.5752,-2507.9780,37.0068); //
	CreatePickup(1603, 2, -1328.0197,-2467.7183,27.8259); //
	CreatePickup(1603, 2, -1290.3135,-2479.8984,16.9108); //
	CreatePickup(1603, 2, -1277.4055,-2498.1367,11.4951); //
	CreatePickup(1603, 2, -568.3260,-2276.3220,27.5938);
	CreatePickup(1603, 2, -653.1019,-2255.4465,23.3936);
	CreatePickup(1603, 2, -614.5738,-2398.0959,28.0911);
	CreatePickup(1603, 2, -620.2932,-2477.4644,52.8450);
	CreatePickup(1603, 2, -673.6429,-2562.6052,58.4840);
	CreatePickup(1603, 2, -797.0350,-2611.4380,85.9543);
	CreatePickup(1603, 2, -814.8298,-2713.2485,90.4954);
	CreatePickup(1603, 2, -900.3575,-2635.6716,96.5351);
	CreatePickup(1603, 2, -908.8201,-2450.1675,86.1361);
	CreatePickup(1603, 2, -564.7324,-2000.7518,48.2172);
	CreatePickup(1603, 2, -514.0831,-1990.8127,46.7821);
	CreatePickup(1603, 2, -386.3437,-1968.6517,25.7109);
	CreatePickup(1603, 2, -285.8642,-2063.6074,34.5075);
	CreatePickup(1603, 2, -1735.6969,-2501.1594,10.1409);
	CreatePickup(1603, 2, -1840.7139,-2382.2207,29.1400);
	CreatePickup(1603, 2, -1906.1353,-2212.6089,77.4492);
	CreatePickup(1603, 2, -1874.5731,-1969.2981,87.2874);
	CreatePickup(1603, 2, -1739.6145,-1950.4650,98.8599);
	CreatePickup(1603, 2, -1613.4684,-1867.4391,86.1701);
	CreatePickup(1603, 2, -1868.5590,-1894.4634,88.9713);
	mushroom[1] = CreatePickup(1603, 2, -2005.6901,-1937.4910,77.0140);
	//========================================[ГРИБЫ]========================================
	medicss[0] = CreatePickup(1318,23,-2664.7141,639.9803,14.4531); // Медики SF Вход
	medicss[1] = CreatePickup(1318,23,281.1904,183.1636,1214.7949,3); // Медики SF Выход
	medicss[2] = CreatePickup(1318,23,1172.0767,-1323.3440,15.4030); // Медики LS Вход
	medicss[3] = CreatePickup(1318,23,281.1904,183.1636,1214.7949,4); // Медики LS Выход
	medicss[4] = CreatePickup(1318,23,1607.2877,1815.2422,10.8203); // Медики LV Вход
	medicss[5] = CreatePickup(1318,23,281.1904,183.1636,1214.7949,5); // Медики LV Выход
	medicss[6] = CreatePickup(1318,23,-320.0217,1048.2347,20.3403); // Медики LV Вход
	medicss[7] = CreatePickup(1318,23,281.1904,183.1636,1214.7949,6); // Медики LV Выход
	medicss[8] = CreatePickup(1318,23,2034.1124,-1401.8556,17.2942); // Медики CGH Вход
	medicss[9] = CreatePickup(1318,23,281.1904,183.1636,1214.7949,7); // Медики CGH Выход
	sportzal[0] = CreatePickup(1318,23,2097.9495,2494.1621,14.8390); // Спортзал LV Вход
	sportzal[1] = CreatePickup(1318,23,772.4290,-5.0806,1000.7289); // Спортзал LV Выход
	lspic[0] = CreatePickup(19130,23,1658.6239,-1691.3878,15.6094); // LSN вход
	lspic[1] = CreatePickup(1318,23,1650.8948,-1654.2299,99.7110,1); // LSN выход
	lvpic[0] = CreatePickup(19130,23,2648.9949,1185.3920,10.8203); // LVN вход на крышу
	lvpic[1] = CreatePickup(1318,23,2643.5535,1193.7731,39.7110,3); // LVN выход на парковку
	rabota1 = CreatePickup(1239,23,2230.4875,-2211.9368,13.5469); // Грузчики инфо
	chekmats[0] = CreatePickup(1239,2,-1294.7273,490.1304,11.1953); // Пикап 1
	chekmats[1] = CreatePickup(1239,2,-1400.6083,491.5404,11.1953); // Пикап 2
	serdce[0] = CreatePickup(1240,23,1160.3256,-1768.5709,16.5938); // Сердце Спавн
	serdce[1] = CreatePickup(1240,23,1753.4606,-1916.4948,13.5698); // Сердце Автовокзал
 	serdce[2] = CreatePickup(1240,23,-2053.3713,-114.0886,1035.2432,1); // Сердце Автошкола
	serdce[3] = CreatePickup(1240,23,359.0540,179.0581,1008.3828); // Сердце Мэрия
	sportfrac = CreatePickup(1275, 23, 756.2290,5.9802,1000.6988);
	FormaFracPic[0] = CreatePickup(1275, 23, 255.1582,78.4345,1003.6406);
	FormaFracPic[1] = CreatePickup(1275, 23, -2461.1140,509.1903,1039.1460,130);
	FormaFracPic[2] = CreatePickup(1275, 23, -1344.0225,490.3044,11.2027);
	FormaFracPic[3] = CreatePickup(1275, 23, 302.7346,171.9863,1214.7949,3);//SFMC
	FormaFracPic[4] = CreatePickup(1275, 23, 364.2415,197.5021,1014.1875);
	FormaFracPic[5] = CreatePickup(1275, 23, -2068.8213,457.6702,191.0859,2);
	FormaFracPic[6] = CreatePickup(1275, 23, 220.2224,111.7548,1010.2118);
	FormaFracPic[7] = CreatePickup(1275, 23, -2054.1152,-107.5294,1035.2432,1);
	FormaFracPic[8] = CreatePickup(1275, 23, 1639.8848,-1638.5664,101.0859,1);
	FormaFracPic[9] = CreatePickup(1275, 23, 240.4291,1860.7698,8.7578);
	FormaFracPic[10] = CreatePickup(1275, 23, 2632.5681,1209.4713,41.0859,3);
	FormaFracPic[11] = CreatePickup(1275, 23, 229.9608,178.1518,1003.0313,122);
	FormaFracPic[12] = CreatePickup(1275, 23, 302.7346,171.9863,1214.7949,4);//LS
	FormaFracPic[13] = CreatePickup(1275, 23, 302.7346,171.9863,1214.7949,5);//LV
	FormaFracPic[14] = CreatePickup(1275, 23, 302.7346,171.9863,1214.7949,6);//FC
	FormaFracPic[15] = CreatePickup(1275, 23, 302.7346,171.9863,1214.7949,7);//CGH
	clothes = CreatePickup(1275, 23, 2137.9661,-2282.2017,20.6719, -1); // Работа Грузчика
	cashs = CreatePickup(1274, 23, 2127.5701,-2275.1938,20.6719, -1); // Зарплата грузчикам
	gunarm[0] = CreatePickup(353,23,245.6338,1859.2839,14.0840); // Оружие Армии
	gunarm[1] = CreatePickup(353,23,311.9774,-165.2273,999.6010,3); // Оружие Армии
	lsamat = CreatePickup(1239,23,2729.3267,-2451.5051,17.5937);
	lsaammo = CreatePickup(353,23,2744.2744,-2453.7742,13.8623);
	skinshop[0] = CreatePickup(1275,23,206.0302,-3.5463,1001.2109,1); // Магагазин Одежды
	skinshop[1] = CreatePickup(1275,23,205.9253,-12.9991,1001.2178,1); // Магагазин Одежды
	skinshop[2] = CreatePickup(1275,23,206.0302,-3.5463,1001.2109,2); // Магагазин Одежды
	skinshop[3] = CreatePickup(1275,23,205.9253,-12.9991,1001.2178,2); // Магагазин Одежды
	Army = GangZoneCreate(-49.979476, 1695.982177, 414.020507, 2175.982177);
	mast[0] = CreatePickup(1318,23,613.4505,3.7427,1000.9219); // Мастеркая LV
	mast[1] = CreatePickup(1318,23,613.4505,3.7427,1000.9219,1); // Мастеркая SF
	mast[2] = CreatePickup(1318,23,613.4505,3.7427,1000.9219,2); // Мастеркая LS
	SFa = GangZoneCreate(-1544.892, 270.5747, -1232.015, 558.5571);
	LSport = GangZoneCreate(2581.279, -2593.79, 2862.689, -2305.605);
	//============================ Инфо дальнобойщики ==========================
	mast[1] = CreatePickup(1318,23,613.4505,3.7427,1000.9219,1); // Мастеркая SF
	mast[2] = CreatePickup(1318,23,613.4505,3.7427,1000.9219,2); // Мастеркая LS
	CreatePickup(1239,23,-1731.4509,118.9413,3.5547);
	CreatePickup(1239,23,2601.7222,-2226.5867,13.3732);
	CreatePickup(1239,23,256.4736,1414.5182,10.7075);
	CreatePickup(1239,23,-1046.7723,-670.7208,32.3516);
	CreatePickup(1239,23,608.7718,847.8765,-43.1532);
	CreatePickup(1239,23,-1978.6846,-2434.8274,30.6250);
	CreatePickup(1239,23,-1873.0896,-1720.2430,21.7500);
	CreatePickup(1239,23,323.0342,1118.5804,1083.8828);
	//==========================================================================
	//CreateDynamic3DTextLabel("{ffa500}Street Racers: {ffffff}Чтобы заправиться/починить машину введите (( {00ff00}/stfill {ffffff}))",COLOR_BLUE,1604.7991,-1806.0012,13.4279,25.0,0,1);
	CreateDynamic3DTextLabel("Регистрация на бой\n{FFFFFF}/fight - зарегестрироваться на бой\n/startfight - начать бой",COLOR_BLUE,765.3245,10.8755,1000.7081+0.8,25.0);
	CreateDynamic3DTextLabel("{218065}~~~~~~~~~~~~~~~~~~~~\nСклад топлива\n{FFFFFF}''/ProdMenu''\n{218065}~~~~~~~~~~~~~~~~~~~~",-1,-1027.4069,-593.4584,32.0126+0.4,25.0);
	CreateDynamic3DTextLabel("{218065}~~~~~~~~~~~~~~~~~~~~\nСклад еды и товаров\n{FFFFFF}''/ProdMenu''\n{218065}~~~~~~~~~~~~~~~~~~~~",-1,-514.4622,-543.0626,25.5234+0.4,25.0);
	format(string,128, "Разгрузка урожая\nСтоимость урожая %i вирт",UrojSell);
	CreateDynamic3DTextLabel(string,0xFF9900FF,1630.0807,2323.3582,10.8203,25.0);
	CreateDynamic3DTextLabel("________________",0xFF9900FF,1630.0807,2323.3582,10.8203,25.0);
	format(string,128, "Разгрузка наркотиков\nСтоимость 1 гр. %i вирт",NarkSell);
	CreateDynamic3DTextLabel(string,0xFF9900FF,2178.3220,-1660.2120,14.9782,25.0);
	CreateDynamic3DTextLabel("____________________",0xFF9900FF,2178.3220,-1660.2120,14.9782,25.0);
	format(string,128, "Загрузка зерна\nСтоимость зерна %i вирт\n{FFFFFF}Посигнальте и шлакбаум поднимется\nили введите /prodopen",ZernBuy);
	CreateDynamic3DTextLabel(string,0xFF9900AA,2203.7983,-2251.9731,14.0000,15.0);
	CreateDynamic3DTextLabel("_______________",0xFF9900AA,2203.7983,-2251.9731,14.0000,15.0);
	//================================= 3D тексты ==============================
	CreateDynamic3DTextLabel("Чтобы воспользоваться лифтом, посигнальте",0xFF8000FF,-2441.0435,527.9462,29.9149,15.0);
	CreateDynamic3DTextLabel("Чтобы воспользоваться лифтом, посигнальте",0xFF8000FF,-2505.4043,529.6075,491.9152,15.0);
	CreateDynamic3DTextLabel("МЭРИЯ",0x6495EDFF,1481.1272,-1771.6830,19.2000,10.0);
	CreateDynamic3DTextLabel("CITY BANK",0x6495EDFF,1411.5237,-1699.5793,13.5395,10.0);
	CreateDynamic3DTextLabel("_________________\nАвто сдача\nна права\n_________________",TEAM_GROVE_COLOR,-2047.4098,-114.6060,1035.4432,10.0);
	CreateDynamic3DTextLabel(" < Приём на работу > ",0xFFFF00FF,359.8466,184.7337,1009.0000,10.0);
	CreateDynamic3DTextLabel("{33AA33}~~~~~~~~~~~~~~~~~\nКупить наркотики:\n{FFFFFF}\"/get drugs\"\n{33AA33}~~~~~~~~~~~~~~~~~",-1,323.0342,1118.5804,1083.8828,10.0);
	CreateDynamic3DTextLabel("~~~~~~~~~~~~~~~\nРегистрация\nна Гонку\n~~~~~~~~~~~~~~~",TEAM_GROVE_COLOR,822.3992,2.7049,1004.1797,10.0);
	CreateDynamic3DTextLabel("Точка наблюдения\n/camera",-1,212.2816,1812.2374,21.8672,10.0);
	CreateDynamic3DTextLabel("CAR SHOP\nclass: Nope",COLOR_REDD,562.4449,-1291.9125,17.2482,7.0);
	CreateDynamic3DTextLabel("CAR SHOP\nclass: C&D",COLOR_REDD,-1952.2794,297.8026,35.4688,7.0);
	CreateDynamic3DTextLabel("CAR SHOP\nclass: A&B",COLOR_REDD,2200.8857,1394.2892,11.0625,7.0);
	CreateDynamic3DTextLabel("CAR SHOP\nclass: A&B",COLOR_REDD,-1657.7015,1210.2267,7.2500,7.0);
	CreateDynamic3DTextLabel("{FFFF00}==== {33AA33}[ Помощь ] {FFFF00}====",COLOR_YELLOW,1160.3744,-1770.2209,17.2938,25.0);
	//========================== Пикапы входы/выходы ===========================
	tpadminhome[0] = CreatePickup(1239,23,47.7949,1001.1465,179.9551); // В здание админ дома
	tpadminhome[1] = CreatePickup(1239,23,-1629.1704,17.7326,178.9659); // Из здания админ дома
	chekmatlva[0] = CreatePickup(1239,2,223.8502,1931.5122,17.6406); // пикап1
	chekmatlva[1] = CreatePickup(1239,2,190.7502,1931.7085,17.6406); // пикап1
	chekmatlva[2] = CreatePickup(1239,2,155.8935,1903.3306,18.6603); // пикап3
	chekmatlva[3] = CreatePickup(1239,2,137.4635,1880.8014,17.8359); // пикап4
	chekmatlva[4] = CreatePickup(1239,2,117.9774,1869.8710,17.8359); // пикап5
	chekmatlva[5] = CreatePickup(1239,2,112.7323,1875.2440,17.8359); // пикап6
	chekmatlva[6] = CreatePickup(1239,2,153.5131,1845.9530,17.6406); // пикап7
	chekmatlva[7] = CreatePickup(1239,2,171.9801,1834.7606,17.6406); // пикап8
	chekmatlva[8] = CreatePickup(1239,2,176.9783,1841.3126,17.6406); // пикап9
	chekmatlva[9]= CreatePickup(1239,2,233.3041,1842.0875,17.6406); // пикап10
	lift = CreatePickup(1318,23,1147.8197,-1318.0120,13.6500); // пикап4
	kauta = CreatePickup(1318,23,-1345.5260,492.3939,18.2344); // пикап5
	kauta2 = CreatePickup(1318,23,-1329.1328,489.7521,24.7138,5); // пикап6
	lift2 = CreatePickup(1318,23,1161.4158,-1330.1571,31.4939); // пикап10
	lift3 = CreatePickup(1318,23,-2705.7395,640.1631,14.4531);
	cerkva = CreatePickup(1318,23,-1989.8993,1117.8569,54.4688);
	cerkva2 = CreatePickup(1318,23,-1938.0405,1118.8585,1332.7010,1);
	wmcvhod = CreatePickup(1318,23,662.8604,1716.4194,7.1875);
	vmcvqhod = CreatePickup(1318,23,502.0459,-67.6832,998.7578,52);
	vmcvhod = CreatePickup(1318,23,681.6075,-473.3458,16.5363);
	//rmspawn[0] = CreatePickup(1318, 23, 960.2988,1683.8674,8.8516);//????
	rmspawn[1] = CreatePickup(1318, 23, 1286.7781,-838.8546,1085.6328,4); // ?????
	lcnspawn[0] = CreatePickup(1318, 23, 1530.2140,751.0493,11.0234);//????
	lcnspawn[1] = CreatePickup(1318, 23, 1260.6464,-785.3956,1091.9063,4); // ?????
	wmcvqhod = CreatePickup(1318,23,501.7259,-67.6832,998.7578,998);
	pmcvhod = CreatePickup(1318,23,-2105.8921,-2480.8372,30.6250);
	pmcvqhod = CreatePickup(1318,23,501.7259,-67.6832,998.7578,8);
	lift4 = CreatePickup(1318,23,-2713.6804,631.2424,34.4028);
	lift5 = CreatePickup(1318,23,1599.6707,1815.2407,10.8203);
	lift6 = CreatePickup(1318,23,1608.3033,1786.1414,30.4688);
	ash = CreatePickup(1318,23,-2026.5331,-102.0650,35.1641);
	ash2 = CreatePickup(1318,23,-2048.6719,-98.5057,1035.2432,1);
	ash3 = CreatePickup(1318,23,-2029.7572,-120.5181,35.1692);
	nikname = CreatePickup(19134,23,359.1942,181.4973,1008.3828); // ????? ?????
	nikname2 = CreatePickup(19134,23,-1970.5245,1112.0775,1333.0092,1); // ????? ?????
	ash4 = CreatePickup(1318,23,-2051.0273,-123.3986,1035.2432,1);
	derbyrace[0] = CreatePickup(19134, 23, -2159.0461,640.3610,1052.3817); // пикап регистрации дерби
	derbyrace[1] = CreatePickup(1318, 23, -2109.9355,-443.3014,38.7344); // вход в дерби
	derbyrace[2] = CreatePickup(1318, 23, -2170.3154,635.4061,1052.3750); // выход
	paints[0] = CreatePickup(353, 23, 294.8574,-38.2151,1001.5156, 1);
	paints[1] = CreatePickup(1318, 23, 2595.8364,2790.6592,10.8203);
	paints[2] = CreatePickup(1318, 23, 285.5204,-41.8050,1001.5156, 1);
	arace = CreatePickup(19134, 23, 822.3992,2.7049,1004.1797); // Регистрация на гонку
	carpick[0] = CreatePickup(19133, 23, 562.4449,-1291.9125,17.2482, 0); // Автосалон 1 Вход
	carpick[1] = CreatePickup(19133, 23, -1952.2794,297.8026,35.4688, 0); // Автосалон 2 Вход
	carpick[2] = CreatePickup(19133, 23, 2200.8857,1394.2892,11.0625, 0); // Автосалон 3 Вход
	carpick[3] = CreatePickup(19133, 23, -1657.6984,1210.2471,7.2500, 0); // Автосалон 3 Вход
	racee[0] = CreatePickup(1318,23,1956.7323,-2183.6260,13.5469); // Гонка вход
	racee[1] = CreatePickup(1318,23,834.6671,7.2752,1004.1870); // Гонка выход
	victim2[0] = CreatePickup(1318,23,461.7025,-1500.7941,31.0454); // Магазин Одежды Вход
	victim2[1] = CreatePickup(1318,23,227.5632,-8.0904,1002.2109,2); // Магазин Одежды Выход
	zip[0] = CreatePickup(1318,23,-1694.1870,951.2703,24.8906); // Магазин ZIPSF Вход
	zip[1] = CreatePickup(1318,23,227.5632,-8.0904,1002.2109,1); // Магазин ZIPSF Выход
 	pdd = CreatePickup(1239,23,-2042.6631,-114.7042,1035.2432,1); // Пикап ПДД
	buygunzakon[0] = CreatePickup(353,23,311.5954,-165.3113,999.6010,130); //gun FBI
	buygunzakon[1] = CreatePickup(353,23,311.9774,-165.2273,999.6010,5); //gun Police
	buygunzakon[2] = CreatePickup(353,23,311.9774,-165.2273,999.6010,1); //gun Police
	buygunzakon[3] = CreatePickup(353,23,302.5668,-127.6718,1004.0625,15); //gun Police
	lspd[0] = CreatePickup(1318,23,1555.1332,-1675.7180,16.1953);//Lspd вход
	lspd[1] = CreatePickup(1318,23,246.7096,62.8786,1003.6406);//Lspd выход
	lspd[4] = CreatePickup(1318,23,316.6778,-170.0422,999.5938,5);//Lspd вых из аммо
	lspd[2] = CreatePickup(1318,23,1524.486938,-1677.990844,6.218750);//Lspd Вход
	lspd[5] = CreatePickup(1318,23,1568.6144,-1689.9901,6.2188);//Lspd Вход из гаража
	lspd[3] = CreatePickup(1318,23,246.4416,87.6784,1003.6406);//Lspd выход в гараже
	sf[4]  = CreatePickup(1318,23,-1606.4298,672.0637,-4.9063);//Lspd выход в гараже
	sf[0]  = CreatePickup(1318,23,316.3047,-170.2971,999.5938,1);//Lspd выход в гараже
	sf[1]  = CreatePickup(1318,23,213.9762,120.8990,999.0156);//Lspd выход в гараже
	sf[2] = CreatePickup(1318,23,-1594.2096,716.1803,-4.9063);//sfpd
	sf[3] = CreatePickup(1318,23,246.4636,107.2969,1003.2188);//сфпд
	sf[5] = CreatePickup(1318,23,-1605.5883,710.2720,13.8672);//сфпд
	lvpdpic[0] = CreatePickup(1318,23,2297.1138,2451.4346,10.8203);//lvpd вход с гаража
	lvpdpic[1] = CreatePickup(1318,23,238.7510,138.6254,1003.0234,122);//lvpd вход в гараж
	lvpdpic[2] = CreatePickup(1318,23,2337.1335,2459.3105,14.9742);//Центральный вход
	lvpdpic[3] = CreatePickup(1318,23,288.8456,166.9235,1007.1719,122);//Центральный выход
	lvpdpic[4] = CreatePickup(1318,23,2297.1165,2468.6892,10.8203);//lvpd оружие вход
	lvpdpic[5] = CreatePickup(1318,23,299.9460,-141.8767,1004.0625,15);//lvpd оружие выход
	lvpdpic[6] = CreatePickup(1318,23,2278.3835,2458.0950,38.6837);//крыша
	sfpdpic[0] = CreatePickup(19130,23,-2046.4412,453.8438,139.7422);
	sfpdpic[1] = CreatePickup(19130,23,-2056.5552,454.0199,35.1719);
	sfpdpic[2] = CreatePickup(1318,23,-2057.8728,441.9805,189.7110,2);
	sfpdpic[3] = CreatePickup(1318,23,-2053.5598,451.6628,35.1719);
	rmpic[0] = CreatePickup(1318,23,1298.7498,-797.0133,1084.0078,1);
	rmpic[1] = CreatePickup(1318,23,937.0892,1733.2124,8.8516);
	rmpic2[0] = CreatePickup(1318,23,1260.6467,-785.4053,1091.9063,1);
	rmpic2[1] = CreatePickup(1318,23,960.3885,1782.6185,8.8516);
	rmpick[0] = CreatePickup(1318,23,1286.8062,-838.8555,1085.6328,1);
	rmpick[1] = CreatePickup(1318,23,960.4630,1683.9728,8.8516);
	yakexit[0] = CreatePickup(1318,23,1298.7498,-797.0133,1084.0078);
	yakexit[1] = CreatePickup(1318,23,1456.1324,2773.4790,10.8203);
	fbi[1] = CreatePickup(1318,23,-2457.5020,516.7563,1039.1460,130); //Вход
	fbi[0] = CreatePickup(1318,23,-2456.1270,503.7910,30.0781); //Выход
	fbi[2] = CreatePickup(1318,23,-2457.0042,520.4381,492.1730); //Вход Крыша
	fbi[3] = CreatePickup(1318,23,-2454.8435,513.2433,45.5625); //Выход Крыша
	fbi[4] = CreatePickup(1318,23,-2477.3184,537.0898,1039.1460,130); //Выход Крыша
	fbi[5] = CreatePickup(1318,23,-2443.0410,494.4877,492.1183); //Выход Крыша
	lcnpic[0] = CreatePickup(1318,23,1298.8684,-797.0115,1084.0078,2);
	lcnpic[1] = CreatePickup(1318,23,1455.9155,751.0115,11.0234);
	lcnpic[2] = CreatePickup(1318,23,1260.6521,-785.4042,1091.9063,2);
	lcnpic[3] = CreatePickup(1318,23,1530.2097,751.0135,11.0234);
	addictionexit = CreatePickup(1318,23,318.6952,1114.5037,1083.8828);
	addictionenter =  CreatePickup(1318,23,2166.0068,-1671.3362,15.0734);
	armijavhod = CreatePickup(1318,23,140.0735,1939.5984,19.2991);
	armijavihod = CreatePickup(1318,23,153.8659,1944.3601,20.0000);
	marenter[0] = CreatePickup(1318,23,1481.1272,-1771.6830,18.7958);// Мэрия
	marenter[1]  = CreatePickup(1318,23,1413.2067,-1790.5966,15.4356);// Чёрный Вход мэрия
	marenter[2]  = CreatePickup(1318,23,368.4227,194.0684,1008.3828);// Чёрный Выход мэрия
	maria = CreatePickup(1318,23,1438.0618,-1790.1196,33.4297);
	marexit = CreatePickup(1318,23,390.1618,173.8988,1008.3828);// Выход из мэрии
	bankpic[0] = CreatePickup(1318,23,1411.5237,-1699.5793,13.5395);//Банк вход
	bankpic[1] = CreatePickup(1318,23,2304.76,-16.0633,26.7422);//Банк выход
	//banksf = CreatePickup(1318,23,-2172.0627,252.1688,35.3385);//Банк SF выход
	ballasvhod[0] = CreatePickup(1318,23,-68.8021,1351.1979,1080.2109,34);//Ballas на улицу
	ballasvhod[1] = CreatePickup(1318,23,2650.6992,-2021.8175,14.1766);//Ballas в интерьр
	rifa[0] = CreatePickup(1318,23,2807.6653,-1174.5896,1025.5703,63);//Рифа вход на улицу
	rifa[1] = CreatePickup(1318,23,2185.8225,-1815.2219,13.5469);//Рифа вход
	vagospic[0] = CreatePickup(1318,23,2770.7471,-1628.7227,12.1775);//Vagos вход
	vagospic[1] = CreatePickup(1318,23,2809.6873,-1603.2987,-36.9231,75);//Vagos выход
	aztecpic[0] = CreatePickup(1318,23,1667.52,-2106.94,14.07);//Aztec вход
	aztecpic[1] = CreatePickup(1318,23,-42.5856,1405.4747,1084.4297,36);//Aztec выход
	grooveexit = CreatePickup(1318,23,2495.7993,-1692.4044,1014.7422,1);//grove spawn выход
	grooveenter = CreatePickup(1318,23,2495.3271,-1690.9893,14.7656);//Дом грув
	zona = CreatePickup(1318,23,279.2340,1833.1393,18.0874);//стрелка2
	zonaa = CreatePickup(1318,23,291.8918,1833.7253,18.1027);//стрелка3
	sklad[0] = CreatePickup(1318,23,340.5722,1949.2020,22.0172);//стрелка4
	sklad[1] = CreatePickup(1318,23,316.3806,-170.2857,999.5938);//стрелка5
	sklad[2] = CreatePickup(1318,23,316.3806,-170.2857,999.5938,3);//стрелка6
	sklad[3] = CreatePickup(1318,23,-1373.0463,498.9842,11.1953);//стрелка7
	skladfbi = CreatePickup(1318,23,-2473.0159,511.5519,1039.1460,130);//стрелка7
	skladfbi2 = CreatePickup(1318,23,316.4419,-170.2977,999.5938,130);//стрелка7
	rob = CreatePickup(1239, 23, 2755.9060,-2515.5491,13.6397, -1);
	PickupRazd[0] = CreatePickup(1275, 23, -70.4734,1365.5361,1080.2109, -1);
	PickupRazd[1] = CreatePickup(1275, 23, 415.1374,2534.9619,10.0000, -1);
	PickupRazd[2] = CreatePickup(1275, 23, 141.1709,1382.5786,1083.8672, -1);
	PickupRazd[3] = CreatePickup(1275, 23, 2311.0996,-1135.9833,1054.3047, -1);
	PickupRazd[4] = CreatePickup(1275, 23, 21.7159,1414.6810,1084.4297, -1);
	PickupRazd[5] = CreatePickup(1275, 23, 264.3949,1285.9189,1080.2578, -1);
	PickupRazd[6] = CreatePickup(1275, 23, -270.5288,1451.5757,1088.8672, -1);
	PickupRazd[7] = CreatePickup(1275, 23, 235.5965,1079.4858,1087.8126, -1);
	PickupRazd[8] = CreatePickup(1275, 23, 23.4715,1349.0693,1088.8750, -1);
	PickupRazd[9] = CreatePickup(1275, 23, 479.2941,1406.1661,1084.4141, -1);
	PickupRazd[10] = CreatePickup(1275, 23, 223.8894,1249.7222,1082.1406, -1);
	PickupRazd[11] = CreatePickup(1275, 23, 2263.0842,-1132.6631,1050.6328, -1);
	PickupRazd[12] = CreatePickup(1275, 23, 308.1529,1120.4374,1083.8828, -1);
	PickupRazd[13] = CreatePickup(1275, 23, 267.1403,303.4059,999.1484, -1);
	PickupRazd[14] = CreatePickup(1275, 23, 2231.7356,-1112.2380,1050.8828, -1);
	PickupRazd[15] = CreatePickup(1275, 23, 224.6360,1152.0380,1082.6168, -1);
	PickupRazd[16] = CreatePickup(1275, 23, 2215.8215,-1074.6964,1050.4844, -1);
	PickupRazd[17] = CreatePickup(1275, 23, 2455.9214,-1700.5446,1013.5078, -1);
	PickupRazd[18] = CreatePickup(1275, 23, 229.0636,1287.0778,1082.1406, -1);
	PickupRazd[19] = CreatePickup(1275, 23, 331.6472,1477.1322,1084.4364, -1);
	PickupRazd[20] = CreatePickup(1275, 23, 377.6802,1461.8710,1080.1875, -1);
	PickupRazd[21] = CreatePickup(1275, 23, -52.5169,1403.8401,1084.4297, -1);
	PickupRazd[22] = CreatePickup(1275, 23, 260.6448,1255.4097,1084.2578, -1);
	PickupRazd[23] = CreatePickup(1275, 23, 2262.7839,-1216.7322,1049.0234, -1);
	PickupRazd[24] = CreatePickup(1275, 23, 304.7436,1471.2416,1080.2651, -1);
	PickupRazd[25] = CreatePickup(1275, 23, 369.9906,1409.3152,1081.3345, -1);
	PickupRazd[26] = CreatePickup(1275, 23, 374.6902,1413.1250,1081.3373, -1);
	PickupRazd[27] = CreatePickup(1275, 23, 443.3055,1399.4373,1084.3132, -1);
	PickupRazd[28] = CreatePickup(1275, 23, 2807.3591,-1165.1394,1025.5703, -1);
	PickupRazd[29] = CreatePickup(1275, 23, 2235.8845,-1073.9330,1049.0234, -1);
	PickupRazd[30] = CreatePickup(1275, 23, 2363.7671,-1127.4722,1050.8826, -1);
	PickupRazd[31] = CreatePickup(1275, 23, 228.3887,1195.7487,1080.2645, -1);
	PickupRazd[32] = CreatePickup(1275, 23, 2316.1655,-1010.7783,1054.7188, -1);
	PickupRazd[33] = CreatePickup(1275, 23, 230.8530,1111.2870,1080.9922, -1);
	PickupRazd[34] = CreatePickup(1275, 23, 234.1553,1047.2032,1084.0155, -1);
	//Руб
	//==========================================================================
	//CreateVehicles();
	Furi[0][gBallas] = 0;
	Furi[0][gVagos] = 0;
	Furi[0][gGrove] = 0;
	Furi[0][gAztek] = 0;
	Furi[0][gRifa] = 0;
	
	PlayerHaul[0][pLoad] = 0;
	PlayersHaul[0][sLoad] = 0;
	MatHaul[0][mCapasity] = 5000;
	MatHaul[1][mCapasity] = 5000;
	MatHaul[2][mCapasity] = 5000;
	//==========================================================================
	gettime(ghour, gminute, gsecond);
	FixHour(ghour);
	ghour = shifthour;
	if(!realtime) SetWorldTime(wtime);
	//==========================================================================
	LimitPlayerMarkerRadius(100.0);
	ManualVehicleEngineAndLights();
	AllowInteriorWeapons(1);
	//==========================================================================
	//==========================================================================
	for(new i = 0; i < sizeof(CreatedCars); i++) CreatedCars[i] = 0;
	//==========================================================================
	for(new i = 0; i <= sizeof(Peds)-1; i++) AddPlayerClass(Peds[i][0],1958.3783,1343.1572,1100.3746,269.1425,-1,-1,-1,-1,-1,-1);
	//============================ Иконки на карте =============================
	CreateDynamicMapIcon(2492.3135,-1461.1936,24.0216, 42, -1, 0, -1, -1, 400.0);//Работа автоугонщика.
	CreateDynamicMapIcon(-2.9803,-363.4466,5.4297,51,0); // Развозчики
	CreateDynamicMapIcon(472.4380,-1515.5332,40.5726,45,0); // Victim LS
	CreateDynamicMapIcon(-1882.5100,866.3918,35.1719,45,0); // Victim SF
	CreateDynamicMapIcon(542.1437,-1272.3624,51.3059,55,0); // AutoSalone LS
	CreateDynamicMapIcon(-1948.4501,278.1562,68.9698,55,0); // AutoSalone SF
	CreateDynamicMapIcon(2200.9758,1394.2899,11.0625,55,0); // AutoSalone LV
	CreateDynamicMapIcon(2196.9663,1677.1544,12.3672,25,0); // Сasino Caligula
	CreateDynamicMapIcon(2019.3177,1007.7430,10.8203,43,0); // Сasino 4 Dragons
	CreateDynamicMapIcon(1657.0205,2254.5571,10.8203,25,0); // Сasino Bellaio
	CreateDynamicMapIcon(1481.2144,-1756.5200,17.5313,56,0); // Goverment
	CreateDynamicMapIcon(1552.8314,-1675.9022,16.1953,30,0); // Police LS
	CreateDynamicMapIcon(-1605.4998,710.2729,13.8672,30,0); // Police SF
	CreateDynamicMapIcon(2340.2075,2459.0200,14.9688,30,0); // Police LV
	CreateDynamicMapIcon(1173.6215,-1323.2500,15.1953,22,0); // Medics LS
	CreateDynamicMapIcon(-2664.6611,637.9663,14.4531,22,0); // Medics SF
	CreateDynamicMapIcon(1607.1716,1817.0586,10.8203,22,0); // Medics LV
	CreateDynamicMapIcon(-2243.8826,-87.9706,35.3203,49,0); // Misty
	CreateDynamicMapIcon(2312.4189,-1641.4185,22.3378,49,0); // Bar Grove Steet
	CreateDynamicMapIcon(1414.0972,-1701.0652,13.5395,52,0); // Bank LS
	CreateDynamicMapIcon(-2172.0627,252.1688,35.3385,52,0); // Bank SF
	CreateDynamicMapIcon(2421.2842,-1221.6509,25.4070,49,0); // Pig Pen
	CreateDynamicMapIcon(1834.7672,-1682.3358,13.4178,49,0); // Alhambra
	CreateDynamicMapIcon(-89.610397,1378.243530,10.469799,49,0); // Lil'Probe'in Bar
	CreateDynamicMapIcon(-2623.7166,1410.6890,7.0938,49,0); // Jizzy
	CreateDynamicMapIcon(-2026.9664,-100.3766,35.1641,36,0); // Autoschool
	CreateDynamicMapIcon(1365.6863,-1279.8872,13.5469,6,0); // Ammo LS
	CreateDynamicMapIcon(-2626.6384,210.3960,4.5971,6,0); // Ammo SF
	CreateDynamicMapIcon(2159.5449,943.2165,10.8203,6,0); // Ammo LV
	CreateDynamicMapIcon(2228.5789,-1721.7820,13.5654,54,0); // Спортзал LS
	CreateDynamicMapIcon(-2270.6406,-155.9734,35.3203,54,0); // Спортзал SF
	CreateDynamicMapIcon(1961.8124,-2189.2671,13.5469,53,0); // Race
	//============================= Zone 51 ====================================
	CreateDynamicMapIcon(212.2816,1812.2374,21.8672,56,0); // Точка наблюдения
	//=========================== Пицерии и Бургеры ============================
	CreateDynamicMapIcon(-1816.5311,618.6709,35.1719,50,0); // Pizza
	CreateDynamicMapIcon(-1911.7004,828.8093,35.1719,50,0); // Burger
	CreateDynamicMapIcon(-2336.1675,-168.1730,35.3203,50,0); // Burger
	CreateDynamicMapIcon(-2671.7808,257.9283,4.6328,50,0); // Pizza
	CreateDynamicMapIcon(2102.0913,-1808.8442,38.0027,50,0); // Pizza
	CreateDynamicMapIcon(2397.4641,-1903.6409,38.0027,50,0); // Pizza
	CreateDynamicMapIcon(800.9893,-1619.9106,38.0027,10,0); // Burger
	CreateDynamicMapIcon(932.5351,-1381.1470,32.0997,50,0); // Pizza
	CreateDynamicMapIcon(183.6340,1175.7919,22.6676,50,0); // Pizza
	CreateDynamicMapIcon(2420.4573,-1508.2711,24.0000,50,0); // Pizza
	CreateDynamicMapIcon(1204.3881,-915.2735,66.4264,50,0); // Burger
	CreateDynamicMapIcon(2391.6345,2041.7228,40.0850,50,0); // Pizza
	CreateDynamicMapIcon(1163.3766,2079.7026,40.0850,50,0); // Burger
	//==========================================================================
	AddVehicleComponent(Roadtrain[0], 1074);
	AddVehicleComponent(Roadtrain[1], 1074);
	AddVehicleComponent(Roadtrain[2], 1074);
	AddVehicleComponent(Roadtrain[3], 1074);
	AddVehicleComponent(Roadtrain[4], 1074);
	AddVehicleComponent(Roadtrain[5], 1074);
	//============================== Таймеры ===================================
	SetTimer("OnCheckTrigger",250,1);
	SetTimer("UpdateFresh", 250,1);
	freshtimer = SetTimer("Fresh", 1000,1);
	SetTimer("UpdateSpeedometr",150,1);
	Hptimer = SetTimer("HPCheck", 40000, 1);
	reklamatimer = SetTimer("ReklamaTimer",1800000,true);
	SetTimer("Recognition", 1500000, 1);
	SetTimer("GzCheck", 1000,1);
	//==========================================================================
	for(new Vehicles = 0; Vehicles < MAX_VEHICLES; Vehicles++) {
		Farmcar_pickup[Vehicles] = 0;
		CarHealth[Vehicles] = float(1000);
		car_pickup[Vehicles] = 0;
		enginebrokened[Vehicles] = 0;
		Fuell[Vehicles] = 200;
		vehcreat[Vehicles] = 0;
		SetVehicleNumberPlate(Vehicles, ""NameServer"");
	 	SetVehicleParamsEx(Vehicles,false,false,false,false,false,false,false);
		SERVERCARID[Vehicles] = true;
	}
	//==========================================================================
	BuyClothes = CreateMenu("Clothes", 1, 50.0, 160.0, 110.0);
	SetMenuColumnHeader(BuyClothes, 0, "Choose Skin");
	AddMenuItem(BuyClothes, 0, "Next >>");
	AddMenuItem(BuyClothes, 0, "<< Previous");
	AddMenuItem(BuyClothes, 0, "Buy");
	AddMenuItem(BuyClothes, 0, "Exit");

	ChoseSkin[0] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
	SetMenuColumnHeader(ChoseSkin[0], 0, "Choose Skin");
	AddMenuItem(ChoseSkin[0], 0, ">> Next");
	AddMenuItem(ChoseSkin[0], 0, "<< Previous");
	AddMenuItem(ChoseSkin[0], 0, "Done");

	ChoseSkin[1] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
	SetMenuColumnHeader(ChoseSkin[1], 0, "Choose Skin");
	AddMenuItem(ChoseSkin[1], 0, "<< Previous");
	AddMenuItem(ChoseSkin[1], 0, ">> Next");
	AddMenuItem(ChoseSkin[1], 0, "Done");

	bomj[0] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
	SetMenuColumnHeader(bomj[0], 0, "Choose Skin");
	AddMenuItem(bomj[0], 0, ">> Next");
	AddMenuItem(bomj[0], 0, "<< Previous");
	AddMenuItem(bomj[0], 0, "Save");

	bomj[2] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
	SetMenuColumnHeader(bomj[2], 0, "Choose Skin");
	AddMenuItem(bomj[2], 0, "<< Previous");
	AddMenuItem(bomj[2], 0, ">> Next");
	AddMenuItem(bomj[2], 0, "Save");

	bomj[3] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
	SetMenuColumnHeader(bomj[3], 0, "Choose Skin");
	AddMenuItem(bomj[3], 0, "<< Previous");
	AddMenuItem(bomj[3], 0, ">> Next");
	AddMenuItem(bomj[3], 0, "Save");

	bomj[1] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
	SetMenuColumnHeader(bomj[1], 0, "Choose Skin");
	AddMenuItem(bomj[1], 0, ">> Next>");
	AddMenuItem(bomj[1], 0, "<< Previous");
	AddMenuItem(bomj[1], 0, "Save");
	/////////////// MySQL загрузка мода ///////////////
	//
	printf("Подождите, пожалуйста, идёт загрузка . . .");
	LoadMySQLSettings();
	//mysql_log();
	DATABASE = mysql_connect(MySQLSettings[HOS7_HOST],MySQLSettings[HOS7_USERNAME],MySQLSettings[HOS7_DB],MySQLSettings[HOS7_PASSWORD]);
	mysql_function_query(DATABASE,"SET NAMES cp1251",false,"","");
	mysql_function_query(DATABASE,"SET SESSION character_set_server='utf8';",false,"","");
	
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_HOUSE"`",true,"OnMySQL_QUERY","iis",11,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_BIZZ"`",true,"OnMySQL_QUERY","iis",6,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_WORKSHOPS"`",true,"OnMySQL_QUERY","iis",7,-1,"");
	// Бонусы
	mysql_function_query(DATABASE,"SELECT * FROM `boost`",true,"OnMySQL_QUERY","iis",34,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `boost`",true,"OnMySQL_QUERY","iis",35,-1,"");
	//===========
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_KVARTIRS"`",true,"OnMySQL_QUERY","iis",8,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_PODEZDS"`",true,"OnMySQL_QUERY","iis",9,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_CASINO"`",true,"OnMySQL_QUERY","iis",10,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_OTHERS"`",true,"OnMySQL_QUERY","iis",0,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_ATM"`",true,"OnMySQL_QUERY","iis",22,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_FARM"`",true,"OnMySQL_QUERY","iis",28,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_STALL"`",true,"OnMySQL_QUERY","iis",31,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_GANGZONE"`",true,"OnMySQL_QUERY","iis",32,-1,"");
	mysql_function_query(DATABASE,"SELECT * FROM `grating`",true,"OnMySQL_QUERY","iis",55,-1,"");
	////////////////  Создание альтернативных команд /////////////////
	// Разбан аккаунтов
	mysql_function_query(DATABASE,"SELECT * FROM `"TABLE_BAN"`",true,"OnMySQL_QUERY","iis",26,-1,"");
	mysql_function_query(DATABASE,"UPDATE `"TABLE_ACCOUNTS"` SET `progolos` = '0', pMin = '0'", false, "","");
	if(!strcmp(GetDay(), "Понедельник", true))
	{
	    mysql_function_query(DATABASE,"UPDATE `"TABLE_ACCOUNTS"` SET pChas = '0'", false, "","");
	}
	
	printf("Загрузка завершена!");
	return true;
}