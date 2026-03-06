public OnPlayerConnect(playerid)
{
	printf("--> OnPlayerConnect(playerid = %d)", playerid);

    EnablePlayerCameraTarget(playerid, true);
	TextDrawShowForPlayer(playerid, URL);
	//================================= ROB's ==================================
	robsdraw[playerid] = CreatePlayerTextDraw(playerid, 200.995651, 391.999938, "~b~[IIIIIIIIIIIIIIIIIIIIIIIIIIIIII~b~]");
	PlayerTextDrawLetterSize(playerid, robsdraw[playerid], 0.584465, 2.889167);
	PlayerTextDrawAlignment(playerid, robsdraw[playerid], 1);
	PlayerTextDrawColor(playerid, robsdraw[playerid], -1);
	PlayerTextDrawSetShadow(playerid, robsdraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid, robsdraw[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, robsdraw[playerid], 51);
	PlayerTextDrawFont(playerid, robsdraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, robsdraw[playerid], 1);
	//==========================================================================
	SetPVarInt(playerid, "chosencar", -1);
	if (rr == 1) return Kick(playerid);
	NewTazer[playerid] = false;
	cuffto[playerid] = 9999;
	Convoi[playerid] = 9999;
	AutoSaloon[playerid] = false;
	AGM[playerid] = false;
	GiveMF[playerid] = false;
	zips[playerid] = false;
	training[playerid] = 0;
	CP[playerid] = 0;
	robscdtimer[playerid] = -1;
	Players[players++] = playerid;
	if (SERVERTEST) SendMes(playerid, COLOR_BLUE, "CONNECT: PLAYERID - %i", playerid);
	format(string,90, "{33AA33}Склад армии ЛВ: {FFFFFF}%i", armmatbi);
	UpdateDynamic3DTextLabelText(LvaLable, 0xFFFF00FF, string);
	SetPVarInt(playerid, "AntiBreik", 500);
	SetPVarInt(playerid, "WarnCarShot", 2);
	CarOffer[playerid] = 999;
	chooses[playerid] = 1000;
	CarPrice[playerid] = 999;
	SetPVarInt(playerid,"CarOffer",9999);
	BoyWin[playerid] = 0;
	BoyOffer[playerid] = 999;
	if (slit > 0) Kick(playerid);
	updatecheck[playerid] = 9999;
	togran[playerid] = 0;
	times[playerid] = true;
	choosebiz[playerid] = 0;
	accept_car_damage[playerid] = 0;
	last_vehicle_health[playerid] = 0;
	//-------------- Триггеры -----------------
	CreateTrigger(-2047.460083, -114.519997, 1033.453115); // autoschool
	CreateTrigger(359.8704, 184.7093, 1006.6128); // mary Z position -1.77
	CreateTrigger(1160.4260, -1770.3188, 14.8238); // helpcheck Z position -1.77
	//-------------- Триггеры -----------------
	CreateObject(19375, 487.86032, -1735.24438, 15.28290,   0.00000, 0.00000, -98.02002);
	CreateObject(19375, 1843.35425, -1854.93701, 10.37142,   0.00000, 0.00000, 0.00000);
	CreateObject(19375, 1042.64954, -1025.81384, 30.47056,   0.00000, 0.00000, -90.23997);
	CreateObject(19375, 1026.93445, -1029.23767, 30.57440,   0.00000, 0.00000, 89.52000);
	CreateObject(19375, 2386.28101, 1043.47778, 12.00083,   0.00000, 0.00000, -90.35997);
	CreateObject(19375, -1935.98901, 238.63142, 32.16383,   0.00000, 0.00000, -90.48000);
	CreateObject(19375, -2716.06567, 216.67769, 2.83182,   0.00000, 0.00000, 0.00000);
	CreateObject(19375, 2071.53809, -1831.58606, 12.15108,   0.00000, 0.00000, 0.00000);
	SDuty[playerid] = 0;
	PTEMP[playerid][pLogin] = 0;
	PTEMP[playerid][pTut] = 0;
	format(PTEMP[playerid][pvIp],16,"no");
	ChatOOC[playerid] = 1;
	shotTime[playerid] = 0;
	ClearAnimations(playerid);
	shot[playerid] = 0;
	peremennn[playerid] = 0;
	SetPlayerHealthAC(playerid, 100);
	GangZoneShowForPlayer(playerid, SFa, COLOR_YELLOW2);
	GangZoneShowForPlayer(playerid, LSport, COLOR_YELLOW2);
	TextDrawHideForPlayer(playerid, Speed);
	TextDrawHideForPlayer(playerid, DRAP);
	GetPlayerName(playerid, PTEMP[playerid][pName], MAX_PLAYER_NAME);
	if (strcmp(PTEMP[playerid][pName],"None",true) == 0) return kick(playerid);
	PlayerArmor[playerid] = 0;
	//new unixtime = GetTickCount();
	new ip[32];
	GetPlayerIp(playerid,ip,32);
	//======================================
	OpustitRuki[playerid] = 0;
	ZapretDice[playerid] = 0;
	KostiName[playerid] = 999;
	KostiMoney[playerid] = 0;
	DiceOffers[playerid] = 999;
	//========================Грузчики
	RemoveBuildingForPlayer(playerid, 3744, 2193.2578, -2286.2891, 14.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2193.2578, -2286.2891, 14.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 5262, 2152.7109, -2256.7813, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2158.0078, -2257.2656, 16.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2167.6641, -2256.7813, 12.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2167.6641, -2256.7813, 13.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2167.6641, -2256.7813, 14.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2167.8047, -2257.3516, 16.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2167.1719, -2257.1250, 16.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 3577, 2170.0781, -2257.6641, 16.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2169.3516, -2258.0703, 17.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2168.8281, -2257.5234, 17.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2150.6641, -2251.5547, 12.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2150.2813, -2250.8516, 12.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2150.6953, -2252.9141, 16.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2149.8125, -2253.3672, 16.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2153.7734, -2253.0859, 14.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2154.5078, -2254.4766, 14.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2158.5703, -2251.0156, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2158.0469, -2250.5078, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 5132, 2163.2891, -2251.6094, 14.1406, 0.25);
	//==================================================================
	RemoveBuildingForPlayer(playerid, 3630, 2217.5859, -2284.6641, 15.2344, 0.25); // У грузчиков
	RemoveBuildingForPlayer(playerid, 17772, 2870.2422, -1589.3906, 16.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 17550, 2870.2229, -1589.3374, 16.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 10575, -2716.3516, 217.4766, 5.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 11313, -1935.8594, 239.5313, 35.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 11319, -1904.5313, 277.8984, 42.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 9625, -2425.7266, 1027.9922, 52.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 9093, 2386.6563, 1043.6016, 11.5938, 0.25);
	// Парковка у мэрии
	RemoveBuildingForPlayer(playerid, 4057, 1479.5547, -1693.1406, 19.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 4210, 1479.5625, -1631.4531, 12.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 713, 1457.9375, -1620.6953, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 713, 1496.8672, -1707.8203, 13.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1430.1719, -1719.4688, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1451.6250, -1727.6719, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1467.9844, -1727.6719, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1485.1719, -1727.6719, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1713.5078, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1479.6953, -1716.7031, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1505.1797, -1727.6719, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1713.7031, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1289, 1504.7500, -1711.8828, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1516.0000, -1748.6016, 13.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1258, 1445.0078, -1704.7656, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1702.3594, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1676.6875, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1258, 1445.0078, -1692.2344, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1656.2500, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1636.2344, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1445.8125, -1650.0234, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1619.0547, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1443.2031, -1592.9453, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 1457.7266, -1710.0625, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1461.6563, -1707.6875, 11.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1704.6406, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1463.0625, -1701.5703, 13.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1479.6953, -1702.5313, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 1457.5547, -1697.2891, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1694.0469, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1479.3828, -1692.3906, 15.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 4186, 1479.5547, -1693.1406, 19.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1461.1250, -1687.5625, 11.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1463.0625, -1690.6484, 13.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 641, 1458.6172, -1684.1328, 11.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1457.2734, -1666.2969, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1682.7188, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1471.4063, -1666.1797, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1479.3828, -1682.3125, 15.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1458.2578, -1659.2578, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1449.8516, -1655.9375, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1477.9375, -1652.7266, 15.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1479.6094, -1653.2500, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1457.3516, -1650.5703, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1454.4219, -1642.4922, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1467.8516, -1646.5938, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1472.8984, -1651.5078, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1465.9375, -1639.8203, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1466.4688, -1637.9609, 15.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1449.5938, -1635.0469, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1467.7109, -1632.8906, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, 1465.8906, -1629.9766, 15.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1472.6641, -1627.8828, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1479.4688, -1626.0234, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 3985, 1479.5625, -1631.4531, 12.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 4206, 1479.5547, -1639.6094, 13.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, 1465.8359, -1608.3750, 15.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1229, 1466.4844, -1598.0938, 14.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1451.3359, -1596.7031, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1471.3516, -1596.7031, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1704.5938, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1494.2109, -1694.4375, 13.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1693.7344, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1496.9766, -1686.8516, 11.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 641, 1494.1406, -1689.2344, 11.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1682.6719, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1480.6094, -1666.1797, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1488.2266, -1666.1797, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1486.4063, -1651.3906, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1491.3672, -1646.3828, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1493.1328, -1639.4531, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1486.1797, -1627.7656, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1491.2188, -1632.6797, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, 1494.4141, -1629.9766, 15.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, 1494.3594, -1608.3750, 15.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1488.5313, -1596.7031, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1229, 1498.0547, -1598.0938, 14.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1288, 1504.7500, -1705.4063, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1287, 1504.7500, -1704.4688, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1286, 1504.7500, -1695.0547, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1285, 1504.7500, -1694.0391, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 1498.9609, -1684.6094, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1504.1641, -1662.0156, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1504.7188, -1670.9219, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1503.1875, -1621.1250, 11.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 1501.2813, -1624.5781, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 1498.3594, -1616.9688, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1504.8906, -1596.7031, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1508.4453, -1668.7422, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1505.6953, -1654.8359, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1508.5156, -1647.8594, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1513.2734, -1642.4922, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1258, 1510.8906, -1607.3125, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1721.6328, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1705.2734, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1693.9688, 14.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1688.0859, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1673.7109, 14.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1668.0781, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1647.6406, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1621.9609, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1525.3828, -1611.1563, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1528.9531, -1605.8594, 15.6250, 0.25);
	//
	RemoveBuildingForPlayer(playerid, 1250, 997.4141, 1707.5234, 10.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 1251, 997.0469, 1710.9531, 11.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 1251, 998.0938, 1755.6875, 11.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 1250, 997.7266, 1759.1250, 10.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 11372, -2076.4375, -107.9297, 36.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 11014, -2076.4375, -107.9297, 36.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 985, 2497.4063, 2777.0703, 11.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 986, 2497.4063, 2769.1094, 11.5313, 0.25);
	//=========================== Удалёные обьекты =============================
	RemoveBuildingForPlayer(playerid, 1411, 347.1953, 1799.2656, 18.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 342.9375, 1796.2891, 18.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 950, -2021.5469, -118.9141, 1034.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2034.8047, -117.4531, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2028.1563, -117.6719, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2028.1563, -117.0391, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2028.1406, -116.4375, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2026.6094, -117.6719, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2025.1250, -117.6719, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2023.4766, -117.6719, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2026.5859, -117.0391, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2025.1250, -117.0391, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2023.4766, -117.0391, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2026.6094, -116.4375, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2025.1563, -116.4375, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2023.4766, -116.4375, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2033.0625, -114.3594, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2028.1563, -115.7813, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2026.6094, -115.7813, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2025.1250, -115.7813, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1721, -2023.4766, -115.7813, 1034.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 950, -2021.5469, -113.8125, 1034.7031, 0.25);
	//
	//
	RemoveBuildingForPlayer(playerid, 2786, 1968.7344, 1029.6641, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1967.4063, 1029.6563, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1968.7344, 1021.6875, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1967.4063, 1021.6875, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1968.7344, 1014.0000, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1967.4063, 1014.0000, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1968.7344, 1006.3438, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1967.4063, 1006.3438, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1941.0234, 1014.2266, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1939.6953, 1014.2188, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1941.0234, 1021.4141, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1939.6953, 1021.4141, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1941.8438, 1029.1328, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1940.5547, 1029.4766, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1942.1250, 1006.5703, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2786, 1940.8828, 1006.1094, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1895, 1938.0469, 986.6250, 992.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 1895, 1940.6875, 989.1719, 992.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1940.8828, 1006.1094, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2098, 1941.5234, 1006.3828, 993.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1942.1250, 1006.5703, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1895, 1943.2188, 986.5234, 992.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1939.6953, 1014.2188, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2098, 1940.3906, 1014.2031, 993.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1941.0234, 1014.2266, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1939.6953, 1021.4141, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2098, 1940.3906, 1021.4141, 993.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1941.0234, 1021.4141, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 14568, 1953.6797, 994.2813, 992.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 14566, 1954.3984, 994.9922, 992.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 14567, 1955.1172, 995.7109, 992.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1957.4453, 987.6719, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1957.7188, 987.1953, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 1978, 1959.3984, 1010.1172, 992.5078, 0.25);
	RemoveBuildingForPlayer(playerid, 2188, 1960.3672, 1015.6641, 992.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 2188, 1960.3672, 1020.1719, 992.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1961.9609, 992.2031, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1962.4063, 991.8750, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2188, 1962.3438, 1015.6641, 992.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 2188, 1962.3438, 1020.1797, 992.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1964.5703, 998.4531, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1965.1016, 998.3047, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 1978, 1963.7109, 1010.1172, 992.5078, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1967.4063, 1014.0000, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1967.4063, 1006.3438, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1968.7344, 1006.3438, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1968.7344, 1014.0000, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1967.4063, 1021.6875, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1968.7344, 1021.6875, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1940.5547, 1029.4766, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2098, 1941.2188, 1029.2969, 993.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1941.8438, 1029.1328, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1978, 1959.3984, 1025.6953, 992.5078, 0.25);
	RemoveBuildingForPlayer(playerid, 1978, 1963.7109, 1025.6953, 992.5078, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1967.4063, 1029.6563, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2785, 1968.7344, 1029.6641, 992.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1964.5469, 1037.2813, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1965.0938, 1037.3516, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1961.9219, 1043.3594, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1962.3984, 1043.6328, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1957.3203, 1047.9766, 992.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2325, 1957.6563, 1048.4141, 992.9844, 0.25);
	//==========================================================================
	/*foreach(i)
	{
		if(!strcmp(ExitInfo[i][ExitIP],ip, true))
		{
			if(unixtime - ExitInfo[i][ExitTime] <= 15000) return Kick(playerid) ,SCM(playerid, COLOR_LIGHTRED, "Повторный вход на сервер возможен не раньше, чем через 15 секунд"), SetTimerEx("NewKick", 100, false, "d", playerid);
			else strmid(ExitInfo[i][ExitIP], "None", 0, strlen("None"), 32), ExitInfo[i][ExitTime] = 0;
		}
	}*/
	//
	SpecAd[playerid] = 65535;
	SpecID[playerid] = 65535;
	TimeNumberShot[playerid] = 0;
	TimeNumberShotTarget[playerid] = 0;
	Spectate[playerid] = 0;
	LastReconClick[playerid][0] = 0;
	LastReconClick[playerid][1] = 0;
	ReconSelect[playerid] = INVALID_TEXT_DRAW;
	ReconSelectSub[playerid] = INVALID_TEXT_DRAW;

	SetPlayerArmourAC(playerid, 0);
	SetPlayerColor(playerid, TEAM_HIT_COLOR);
	PTEMP[playerid][SalonCar] = INVALID_VEHICLE_ID;
	PTEMP[playerid][SalonTime] = 0;
	SetPVarInt(playerid,"SelectAvto",-1);

	//----------------------------------
	SERIU[playerid][sID] = INVALID_PLAYER_ID;
	for (new s; s < 3; s++)
	{
		SERIU[playerid][SShout][s] = 0;
		SERIU[playerid][SAFK][s] = 0;
	}
	SERIU[playerid][SShout][3] = 0;
    LabelRank[playerid] = Create3DTextLabel("",TEAM_GROVE_COLOR, 30.0, 40.0, 50.0, 40.0,0);
	Attach3DTextLabelToPlayer(LabelRank[playerid], playerid, 0.0, 0.0, 0.5);
	//==========================================================================
	new is = false, pIps[32];
	GetPlayerIp(playerid, pIps, sizeof (pIps));
	printf("Подключился %s (%s)", Name(playerid), pIps);
	mysql_format(DATABASE, QUERY, 128, "SELECT * FROM `"TABLE_ADMIN"` WHERE `Name` = '%s' AND `level` = '10'", Name(playerid));
	new Cache:first = mysql_query(DATABASE, QUERY);
	new r = cache_num_rows();
	if (r)
	{
		is = true;
        cache_delete(first);
	}
	if (is)
	{
	    mysql_format(DATABASE, QUERY, 128, "SELECT `pIpReg` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'", Name(playerid));
		mysql_query(DATABASE, QUERY);
		new rrs = cache_num_rows(), pIpRegs[32];
		
		if (rrs)
		{
		    cache_get_field_content(0,"pIpReg",pIpRegs,DATABASE,60);
		    printf("%s: %s, %s", Name(playerid), pIps, pIpRegs);
			new part[2][4],parts[2][32];
			sscanf(pIps, "p<.>iiii", part[0][0], part[0][1], part[0][2], part[0][3]);
			sscanf(pIpRegs, "p<.>iiii", part[1][0], part[1][1], part[1][2], part[1][3]);
			format(parts[0], 32, "%i.%i",part[0][0], part[0][1]);
			format(parts[1], 32, "%i.%i",part[1][0], part[1][1]);
		    if (strcmp(parts[0], parts[1], true))
		    {
		        SCM(playerid, 0x9f0000aa, " Этот ник занят администратором");
		        return Kick(playerid);
		    }
		}
	}
	// Test server mode
	if (onlyOneIp)
	{
	    foreach(i)
	    {
	        if (playerid == i) continue;
	        new ppIps[32];
	        GetPlayerIp(i, ppIps, sizeof (ppIps));
	        if (!strcmp(pIps, ppIps, true))
			{
			    SCM(playerid, COLOR_LIGHTRED, " В данный момент запрещено играть с двух аккаунтов одновременно!");
			    return Kick(playerid);
			}
	    }
	}
	printf("<-- OnPlayerConnect(playerid = %d)", playerid);
	return true;
}