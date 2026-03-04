#pragma warning disable 214
#pragma warning disable 239
//==========================================
AntiDeAMX2()
{
	new a[][] =
	{
		"Unarmed (Fist)",
		"Brass K"
	};
	#pragma unused a
}
//==========================================
#include  <a_samp>
#include  <a_mail>
#include  <a_mysql>
#include  <sscanf2>
#include  <streamer>
#include  <dc_cmd>
#include  <objects>
#include  <acuf>
#include  <a_http>

#include  <mxdate>
#include  <Timestamp>
#include  <TOTP>
#include  <mxINI>
//==========================================

#define SCM SendClientMessage
new format_string[128];
#define SendMes(%0,%1,%2,%3)    format(format_string, sizeof(format_string),%2,%3) && SCM(%0, %1, format_string)

//==========================================
new bool:SERVERTEST = false;
new QUERY[4096];
new DATABASE;
//==========================================

#define  FullServName  "Entropy RolePlay"
#define  NameServer    "Entropy-Rp"
#define  NumberServer  "0"

enum MYSQL_SETTINGS
{
	HOS7_HOST,
	HOS7_USERNAME,
	HOS7_PASSWORD,
 	HOS7_DB
}
new MySQLSettings[MYSQL_SETTINGS][30];

new ActorsRob[10];
new bool:cdrob[10];
new robscdtimer[MAX_PLAYERS];
new PlayerText:robsdraw[MAX_PLAYERS];
new RobTickRTC[MAX_PLAYERS];
new RobInts[MAX_PLAYERS];

// Таблицы мускл
#define 	TABLE_ACCOUNTS  	"accounts"
#define 	TABLE_ADMIN 		"admin"
#define 	TABLE_OTHERS 		"others"
#define 	TABLE_CASINO 		"casino"
#define 	TABLE_BANIP     	"banip"
#define 	TABLE_BIZZ      	"bizz"
#define 	TABLE_WORKSHOPS 	"workshops"
#define 	TABLE_HOUSE     	"house"
#define 	TABLE_KVARTIRS  	"kvart"
#define 	TABLE_PODEZDS  		"podezd"
#define 	TABLE_ATM       	"atm"
#define 	TABLE_BAN       	"ban"
#define 	TABLE_DONATE    	"donate"
#define 	TABLE_FARM      	"farms"
#define 	TABLE_STALL     	"stall"
#define 	TABLE_GANGZONE  	"gangzone"
#define 	TABLE_CARS      	"cars"

// DEFINE

#define 	publics:%0(%1)			forward %0(%1); public %0(%1)
#define 	DIALOG_STYLE_MSGBOX 	0
#define 	DIALOG_STYLE_INPUT 		1
#define 	DIALOG_STYLE_LIST 		2
#define 	DIALOG_STYLE_PASSWORD 	3
#define 	NUMBER_OF_ARMYTRUCKS   7
#define 	Ammo_SDPISTOL 			10
#define 	Ammo_DEAGLE 			7
#define 	Ammo_SHOTGUN			5
#define 	Ammo_MP5				25
#define 	Ammo_AK47				35
#define 	Ammo_M4A1				35
#define 	KEY_AIM 				128
#define 	TAZE_LOSEHP 			0
// COLORS
#define     COLOR_CMD           	0x7AADA8FF
#define 	COLOR_GOLD 				0xEAC700FF
#define 	COLOR_BOX 				0x00000070
#define 	COLOR_BBLUE 			0x20A9FFFF
#define 	COLOR_CLUB 				0x00AFF6AA
#define 	COLOR_ORANGE 			0xFF9900AA
#define 	COLOR_ISPOLZUY 			0x7FB151FF
#define 	COLOR_GRAD1 			0xB4B5B7FF
#define 	COLOR_SINIY 			0x00004FAA
#define 	COLOR_LG 				0x7FFF00FF
#define 	COLOR_BLUE 				0x6ab1ffaa
#define 	COLOR_SALMON 			0xFA8072AA
#define 	COLOR_SYSTEM 			0xEFEFF7AA
#define 	COLOR_KHAKI 			0xF0E68CAA
#define 	COLOR_TEAL 				0x008080FF
#define 	COLOR_GRAD2 			0xBFC0C2FF
#define 	COLOR_INDIGO 			0x4B00B0AA
#define 	COLOR_IVORY 			0xFFFF82AA
#define 	COLOR_TEAL 				0x008080FF
#define 	COLOR_GRAD3 			0xCBCCCEFF
#define 	COLOR_GRAD4 			0xD8D8D8FF
#define 	COLOR_GRAD5 			0xE3E3E3FF
#define 	COLOR_GRAD6 			0xF0F0F0FF
#define 	COLOR_GRAD7 			0xF0F0F0FF
#define 	COLOR_GRAD8 			0xF0F0F0FF
#define 	COLOR_BLACK 			0x000000AA
#define 	COLOR_GREY 				0xAFAFAFAA
#define 	COLOR_GREEN 			0x2cc72caa
#define 	COLOR_BLUEGREEN   		0x46BBAA00
#define 	COLOR_ORANGE 			0xFF9900AA
#define 	COLOR_RED 				0xbc2c2caa
#define 	COLOR_LIGHTRED 			0xFF6347AA
#define 	COLOR_LIGHTBLUE 		0x33CCFFFF
//#define 	COLOR_LLIGHTBLUE 		COLOR_BLUE
#define 	COLOR_LIGHTGREEN 		0x8bb717aa
#define 	COLOR_YELLOW			0xFFFF00FF
#define 	COLOR_YELLOW2 			0xF5DEB3AA
//#define 	COLOR_WHITE 			0xFFFFFFAA
#define 	COLOR_REDD 				0xFF0000AA
#define 	COLOR_BROW 				0xA85400AA
#define 	COLOR_FADE1 			0xE6E6E6E6
#define 	COLOR_FADE2 			0xC8C8C8C8
#define 	COLOR_FADE3 			0xAAAAAAAA
#define 	COLOR_FADE4 			0x8C8C8C8C
#define 	COLOR_FADE5 			0x6E6E6E6E
#define 	COLOR_PURPLE 			0xC2A2DAAA
#define 	COLOR_DBLUE 			0x2641FEAA
#define 	COLOR_ALLDEPT 			0xFF8282AA
#define 	COLOR_NEWS 				0xFFA500AA
#define 	COLOR_OOC 				0xE0FFFFAA
#define 	TEAM_HIT_COLOR 			0xFFFFFF00
#define 	TEAM_BLUE_COLOR 		0x8D8DFF00
#define 	COLOR_ADD 				0x63FF60AA
#define 	TEAM_GROVE_COLOR 		0x00D900C8
#define 	TEAM_VAGOS_COLOR 		0xFFC801C8
#define 	TEAM_BALLAS_COLOR 		0xD900D3C8
#define 	TEAM_AZTECAS_COLOR 		0x01FCFFC8
#define 	TEAM_CYAN_COLOR 		0xFF8282AA
#define 	TEAM_ORANGE_COLOR 		0xFF830000
#define 	COLOR_INVIS 			0xAFAFAF00
#define 	COLOR_SPEC 				0xBFC0C200
#define 	COLOR_STROKA 			0xFD0A9FF
//==========
new bool:serverRestart = true;
new bool:onlyOneIp = false;
new slit;
new derbyrace[3];
//
new googleauth[32][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y","Z","2", "3", "4", "5", "6", "7"};
new bool:killed[MAX_PLAYERS];
enum grating
{
	Rifa,
	Grove,
	Ballas,
	Vagos,
	Aztec
};
new gRating[grating];
new BestGang;
new limitgang[grating];
new limitmafia[3];
// Циклы
new bool:Goto[MAX_PLAYERS];
new garage_car[MAX_PLAYERS][5];
new TriggerStatus[MAX_PLAYERS];
new Float:TriggerPos[MAX_PLAYERS][3];
new bool:SERVERCARID[MAX_VEHICLES];
enum bikerss
{
	hells,
	warloks,
	pagans
}
new bool:IsCapted[bikerss];
enum robbing
{
	pickup,
	robCar,
	bikerCar,
	robType,
	bresult
}
new RobbingBiker[robbing];
new Text3D:Rob3DText;
new bool:BikerRobbedBizz[50];
enum bikercapt
{
	atack,
	other,
	reasons
}
new BikerCapture[bikercapt];
new Text3D:BikerText[MAX_PLAYERS];
new ZoneCaptureBiker;
enum zoneinfo
{
	Float:zoneX1,
	Float:zoneY1,
	Float:zoneX2,
	Float:zoneY2
}
new BikerZoneCoords[3][zoneinfo];
new BikerZone[3];
new BikerKills[bikercapt];
new bool:GiveMF[MAX_PLAYERS];
new bool:NewTazer[MAX_PLAYERS];
new cuffto[MAX_PLAYERS];
new TimerForPlayer[MAX_PLAYERS];
new Convoi[MAX_PLAYERS];
new AnimTheLost[MAX_PLAYERS];
new rr = 0;
new bool:AutoSaloon[MAX_PLAYERS];
new ZernBuy;
new UrojSell;
new NarkSell;
new bool:boyidet;
new bool:zips[MAX_PLAYERS];
new bool:AGM[MAX_PLAYERS];
new training[MAX_PLAYERS];
new Text:URL;
new bool:times[MAX_PLAYERS];
new booston = 0;
enum votes
{
	vcaption[32],
	vquestion[100],
	vlevel,
	variants[32],
	vactive
}
enum news
{
	sfn,
	lsn,
	lvn
}
new VoteNews[news][10][votes];
enum vars
{
	vname[32],
	vnumber
}
new VoteNewsVariants_LS[10][10][vars];
new VoteNewsVariants_SF[10][10][vars];
new VoteNewsVariants_LV[10][10][vars];
new choosebiz[MAX_PLAYERS];
new chooses[MAX_PLAYERS];
new sportfrac;
new Online[MAX_PLAYERS];
new Float:accept_car_damage[MAX_PLAYERS],
Float:last_vehicle_health[MAX_PLAYERS];
new CarOffer[MAX_PLAYERS];
new CarPrice[MAX_PLAYERS];
new BoyOffer[MAX_PLAYERS];
new BoyWin[MAX_PLAYERS];
new togran[MAX_PLAYERS];
new garagexit[4];
new peremennn[MAX_PLAYERS];
new Players[500];
new players;
#define SPD ShowPlayerDialog
#define  foreach(%0)  for (new st, %0 = Players[st]; st < players; %0 = Players[++st])
new monitoring;
enum workshoplistInfo
{
	wlID,
	wlName[MAX_PLAYER_NAME]
}
new WorkshopList[10][5][workshoplistInfo];
#define MAX_VEHICLE_COMPONENT 171
new AwtomasMassiveID[MAX_PLAYERS][MAX_VEHICLE_COMPONENT];
enum AllComponents
{
	idcomp,
	Type[20],
	Name[20],
	Cost
}
new AllTuningComponentsInfo[MAX_VEHICLE_COMPONENT][AllComponents] =
{
	{1008, "Nitro"         , "Nos 5x"       , 2000},
	{1009, "Nitro"         , "Nos 2x"       , 1000},
	{1010, "Nitro"         , "Nos 10x"      , 3000},
	{1073, "Wheels"        , "Shadow"       , 5000},
	{1074, "Wheels"        , "Mega"         , 5000},
	{1075, "Wheels"        , "Rimshine"     , 5000},
	{1076, "Wheels"        , "Wires"        , 5000},
	{1077, "Wheels"        , "Classic"      , 5000},
	{1078, "Wheels"        , "Twist"        , 5000},
	{1079, "Wheels"        , "Cutter"       , 5000},
	{1080, "Wheels"        , "Switch"       , 5000},
	{1081, "Wheels"        , "Grove"        , 5000},
	{1082, "Wheels"        , "Import"       , 5000},
	{1083, "Wheels"        , "Dollar"       , 5000},
	{1084, "Wheels"        , "Trance"       , 5000},
	{1085, "Wheels"        , "Atomic"       , 5000},
	{1025, "Wheels"        , "Offroad"      , 5000},
	{1096, "Wheels"        , "Ahab"         , 5000},
	{1097, "Wheels"        , "Virtual"      , 5000},
	{1098, "Wheels"        , "Access"       , 5000},
	{1086, "Stero"         , "Sony"         ,  500},
	{1087, "Hydraulics"    , "LowRider"     , 4000},
	{1000, "Spoiler"       , "Pro"          , 2000},
	{1001, "Spoiler"       , "Win"          , 2000},
	{1002, "Spoiler"       , "Drag"         , 2000},
	{1003, "Spoiler"       , "Alpha"        , 2000},
	{1014, "Spoiler"       , "Champ"        , 2000},
	{1015, "Spoiler"       , "Race"         , 2000},
	{1016, "Spoiler"       , "Worx"         , 2000},
	{1049, "Spoiler"       , "Alien"        , 2000},
	{1050, "Spoiler"       , "X-Flow"       , 2000},
	{1058, "Spoiler"       , "Alien"        , 2000},
	{1023, "Spoiler"       , "Fury"         , 2000},
	{1158, "Spoiler"       , "X-Flow"       , 2000},
	{1146, "Spoiler"       , "X-Flow"       , 2000},
	{1147, "Spoiler"       , "Alien"        , 2000},
	{1138, "Spoiler"       , "Alien"        , 2000},
	{1139, "Spoiler"       , "X-Flow"       , 2000},
	{1060, "Spoiler"       , "X-Flow"       , 2000},
	{1162, "Spoiler"       , "Alien"        , 2000},
	{1163, "Spoiler"       , "X-Flow"       , 2000},
	{1164, "Spoiler"       , "Alien"        , 2000},
	{1004, "Hood"          , "Champ Scoop"  , 1000},
	{1005, "Hood"          , "Fury Scoop"   , 1000},
	{1011, "Hood"          , "Race Scoop"   , 1000},
	{1012, "Hood"          , "Worx Scoop"   , 1000},
	{1100, "Bullbars"      , "Chrome Grill" , 1000},
	{1123, "Bullbars"      , "Chrome Bars"  , 1000},
	{1125, "Bullbars"      , "Chrome Lights", 1000},
	{1117, "Front Bumper"  , "Chrome"       , 2000},
	{1152, "Front Bumper"  , "X-Flow"       , 2000},
	{1153, "Front Bumper"  , "Alien"        , 2000},
	{1155, "Front Bumper"  , "Alien"        , 2000},
	{1157, "Front Bumper"  , "X-Flow"       , 2000},
	{1160, "Front Bumper"  , "Alien"        , 2000},
	{1165, "Front Bumper"  , "X-Flow"       , 2000},
	{1166, "Front Bumper"  , "Alien"        , 2000},
	{1169, "Front Bumper"  , "Alien"        , 2000},
	{1170, "Front Bumper"  , "X-Flow"       , 2000},
	{1171, "Front Bumper"  , "Alien"        , 2000},
	{1172, "Front Bumper"  , "X-Flow"       , 2000},
	{1173, "Front Bumper"  , "X-Flow"       , 2000},
	{1174, "Front Bumper"  , "Chrome"       , 2000},
	{1176, "Rear Bumper"   , "Chrome"       , 2000},
	{1179, "Front Bumper"  , "Chrome"       , 2000},
	{1181, "Front Bumper"  , "Slamin"       , 2000},
	{1182, "Front Bumper"  , "Chrome"       , 2000},
	{1185, "Front Bumper"  , "Slamin"       , 2000},
	{1188, "Front Bumper"  , "Slamin"       , 2000},
	{1189, "Front Bumper"  , "Chrome"       , 2000},
	{1190, "Front Bumper"  , "Slamin"       , 2000},
	{1191, "Front Bumper"  , "Chrome"       , 2000},
	{1140, "Rear Bumper"   , "X-Flow"       , 2000},
	{1141, "Rear Bumper"   , "Alien"        , 2000},
	{1148, "Rear Bumper"   , "X-Flow"       , 2000},
	{1149, "Rear Bumper"   , "Alien"        , 2000},
	{1150, "Rear Bumper"   , "Alien"        , 2000},
	{1151, "Rear Bumper"   , "X-Flow"       , 2000},
	{1154, "Rear Bumper"   , "Alien"        , 2000},
	{1156, "Rear Bumper"   , "X-Flow"       , 2000},
	{1159, "Rear Bumper"   , "Alien"        , 2000},
	{1161, "Rear Bumper"   , "X-Flow"       , 2000},
	{1167, "Rear Bumper"   , "X-Flow"       , 2000},
	{1168, "Rear Bumper"   , "Alien"        , 2000},
	{1175, "Rear Bumper"   , "Slamin"       , 2000},
	{1177, "Rear Bumper"   , "Slamin"       , 2000},
	{1178, "Rear Bumper"   , "Slamin"       , 2000},
	{1180, "Rear Bumper"   , "Chrome"       , 2000},
	{1183, "Rear Bumper"   , "Slamin"       , 2000},
	{1184, "Rear Bumper"   , "Chrome"       , 2000},
	{1186, "Rear Bumper"   , "Slamin"       , 2000},
	{1187, "Rear Bumper"   , "Chrome"       , 2000},
	{1192, "Rear Bumper"   , "Chrome"       , 2000},
	{1193, "Rear Bumper"   , "Slamin"       , 2000},
	{1143, "Vents"         , "Oval"         , 1000},
	{1145, "Vents"         , "Square"       , 1000},
	{1032, "Roof"          , "Alien"        , 2000},
	{1006, "Roof"          , "Scoop"        , 2000},
	{1038, "Roof"          , "Alien"        , 2000},
	{1035, "Roof"          , "X-Flow"       , 2000},
	{1033, "Roof"          , "X-Flow"       , 2000},
	{1053, "Roof"          , "X-Flow"       , 2000},
	{1054, "Roof"          , "Alien"        , 2000},
	{1055, "Roof"          , "Alien"        , 2000},
	{1061, "Roof"          , "X-Flow"       , 2000},
	{1067, "Roof"          , "Alien"        , 2000},
	{1068, "Roof"          , "X-Flow"       , 2000},
	{1088, "Roof"          , "Alien"        , 2000},
	{1091, "Roof"          , "X-Flow"       , 2000},
	{1103, "Roof"          , "Covertible"   , 2000},
	{1128, "Roof"          , "Vinyl Hardtop", 2000},
	{1130, "Roof"          , "Hardtop"      , 2000},
	{1131, "Roof"          , "Softtop"      , 2000},
	{1013, "Lamps"         , "Round Fog"    , 1000},
	{1024, "Lamps"         , "Square Fog"   , 1000},
	{1109, "Rear Bullbars" , "Chrome"       , 1000},
	{1110, "Rear Bullbars" , "Slamin"       , 1000},
	{1115, "Front Bullbars", "Chrome"       , 1000},
	{1116, "Front Bullbars", "Slamin"       , 1000},
	{1018, "Exhaust"       , "Upswept"      , 2000},
	{1019, "Exhaust"       , "Twin"         , 2000},
	{1020, "Exhaust"       , "Large"        , 2000},
	{1021, "Exhaust"       , "Medium"       , 2000},
	{1022, "Exhaust"       , "Small"        , 2000},
	{1028, "Exhaust"       , "Alien"        , 2000},
	{1029, "Exhaust"       , "X-Flow"       , 2000},
	{1034, "Exhaust"       , "Alien"        , 2000},
	{1037, "Exhaust"       , "X-Flow"       , 2000},
	{1043, "Exhaust"       , "Slamin"       , 2000},
	{1044, "Exhaust"       , "Chrome"       , 2000},
	{1045, "Exhaust"       , "X-Flow"       , 2000},
	{1046, "Exhaust"       , "Alien"        , 2000},
	{1059, "Exhaust"       , "X-Flow"       , 2000},
	{1064, "Exhaust"       , "Alien"        , 2000},
	{1065, "Exhaust"       , "Alien"        , 2000},
	{1066, "Exhaust"       , "X-Flow"       , 2000},
	{1092, "Exhaust"       , "Alien"        , 2000},
	{1089, "Exhaust"       , "X-Flow"       , 2000},
	{1126, "Exhaust"       , "Chrome"       , 2000},
	{1127, "Exhaust"       , "Slamin"       , 2000},
	{1129, "Exhaust"       , "Chrome"       , 2000},
	{1113, "Exhaust"       , "Chrome"       , 2000},
	{1114, "Exhaust"       , "Slamin"       , 2000},
	{1104, "Exhaust"       , "Chrome"       , 2000},
	{1105, "Exhaust"       , "Slamin"       , 2000},
	{1132, "Exhaust"       , "Slamin"       , 2000},
	{1135, "Exhaust"       , "Slamin"       , 2000},
	{1136, "Exhaust"       , "Chrome"       , 2000},
	{1007, "Sideskirt"     , "Sideskirt"    , 2000},
	{1026, "Sideskirt"     , "Alien"        , 2000},
	{1031, "Sideskirt"     , "X-Flow"       , 2000},
	{1036, "Sideskirt"     , "Alien"        , 2000},
	{1039, "Sideskirt"     , "X-Flow"       , 2000},
	{1041, "Sideskirt"     , "X-Flow"       , 2000},
	{1042, "Sideskirt"     , "Chrome"       , 2000},
	{1047, "Sideskirt"     , "Alien"        , 2000},
	{1048, "Sideskirt"     , "X-Flow"       , 2000},
	{1056, "Sideskirt"     , "Alien"        , 2000},
	{1057, "Sideskirt"     , "X-Flow"       , 2000},
	{1069, "Sideskirt"     , "Alien"        , 2000},
	{1070, "Sideskirt"     , "X-Flow"       , 2000},
	{1090, "Sideskirt"     , "Alien"        , 2000},
	{1093, "Sideskirt"     , "X-Flow"       , 2000},
	{1095, "Sideskirt"     , "X-Flow"       , 2000},
	{1106, "Sideskirt"     , "Chrome Arches", 2000},
	{1108, "Sideskirt"     , "Chrome Strip" , 2000},
	{1118, "Sideskirt"     , "Chrome Trim"  , 2000},
	{1119, "Sideskirt"     , "Wheelcovers"  , 2000},
	{1122, "Sideskirt"     , "Chrome Flames", 2000},
	{1133, "Sideskirt"     , "Chrome Strip" , 2000},
	{1134, "Sideskirt"     , "Chrome Strip" , 2000}
};
// Vote
new LPick[20];
new idgols;
enum IGolos
{
	Variant[128],
	Golosov
}
new Golosovan[10][IGolos];
new Text3D:GLT[20];
enum GG
{
	NameGolos[128],
	bool:goloson
}
new pickupalla;
new GL2[GG];
// Рулетка
#define MAX_ROULET 13
new bool:RouletPrize[MAX_ROULET];
new RouletNumber[MAX_ROULET];
new RouletKrupie[MAX_ROULET];
new RouletTimer[MAX_ROULET][3];
new bool:RouletPlay[MAX_ROULET];
new PlayerText:RouletText[MAX_PLAYERS];
new RouletCloakroom[2];
//==================================
new OpustitRuki[MAX_PLAYERS];
new ZapretDice[MAX_PLAYERS];
new DiceOffers[MAX_PLAYERS];
new dicetime;
new KostiName[MAX_PLAYERS];
new KostiMoney[MAX_PLAYERS];
// Кости
#define MAX_BONE 14
new Text:Bone[4];
new PlayerText:PlayerBone[MAX_PLAYERS][4];
new
Float:BoneCoor[MAX_BONE][4] =
{
	{1944.19,1010.90,992.00,90.00},
	{1944.19,1017.70,992.00,90.00},
	{1944.19,1025.00,992.00,90.00},
	{1938.19,1010.90,992.00,90.00},
	{1938.19,1017.70,992.00,90.00},
	{1938.19,1025.00,992.00,90.00},
	{2251.01,1589.78,1005.70,90.00},
	{2257.01,1589.78,1005.70,90.00},
	{2251.01,1595.78,1005.70,90.00},
	{2257.01,1595.78,1005.70,90.00},
	{2266.01,1589.78,1005.70,90.00},
	{2272.01,1589.78,1005.70,90.00},
	{2266.01,1595.78,1005.70,90.00},
	{2272.01,1595.78,1005.70,90.00}
};
enum Bones
{
	Gamer[5],
	Bet,
	bBank,
	Crupie,
	GameStart
}
new BoneInfo[MAX_BONE+1][Bones];

new MaxSpeedCar[212] = 
{
	87,81,103,-1,73,91,-1,-1,-1,-1,-1,123,93,-1,-1,106,-1,-1,64,82,93,82,82,-1,75,-1,94,-1,
	-1,112,-1,-1,-1,-1,92,-1,85,-1,-1,93,-1,-1,-1,-1,62,90,-1,-1,-1,-1,-1,107,-1,-1,-1,-1,-1,-1,87,-1,-1,88 ,-1,79 ,-1,-1,
	87,87,79,-1,-1,61,-1,-1,82,96,-1,103,75,77,102,-1,-1,-1,-1,-1,-1,-1,-1,77,-1,82,78,-1,119,97,90,-1,-1,-1,-1,-1,119,119,-1,-1,99,92,-1,-1,-1,-1,
	-1,-1,-1,-1,87,87,91,-1,-1,88,115,-1,-1,-1,-1,87,82,-1,82,-1,-1,-1,90,93,87,96,-1,-1,-1,82,112,91,73,-1,81,82,79,-1,85,80,87,-1,-1,84,87,-1,-1,86,98,94,
	85,98,-1,-1,91,88,96,-1,-1,-1,-1,-1,-1,-1,87,87,-1,-1,87,85,88,-1,-1,-1,87,87,91,-1,90,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,82,-1,93,95,87,73,-1
};
enum _spectator
{
	sID,
	SShout[4],
	SAFK[3],
    Float:sPos[4],
	sVirt,
	sInt
}
new SERIU[MAX_PLAYERS][_spectator];

new UseSound[MAX_PLAYERS];
new Sounds;
new stream[256];
new Float:rads;
new Float:streampos[3];

new PlayerText:Seriu[MAX_PLAYERS][2];
new
 PlayerText:ReconPlayer[35],
 ReconBounds[MAX_PLAYERS][2],
 ReconSelect[MAX_PLAYERS],
 SpecAd[MAX_PLAYERS],
 Float:SpecPlayer[MAX_PLAYERS][3],
 SpecPlayerInt[MAX_PLAYERS],
 SpecPlayerWorld[MAX_PLAYERS],
 SpecID[MAX_PLAYERS],
 Spectate[MAX_PLAYERS],
 NumberShot[MAX_PLAYERS],
 DisallowSpawn[MAX_PLAYERS],
 TimeNumberShot[MAX_PLAYERS],
 NumberShotTarget[MAX_PLAYERS],
 TimeNumberShotTarget[MAX_PLAYERS],
 Float:SpecPlayerAngle[MAX_PLAYERS],
 LastReconClick[MAX_PLAYERS][2],
 ReconSelectSub[MAX_PLAYERS];

new Text:AutoShopText[12];
new PlayerText:ShopText[MAX_PLAYERS];

new ShopCar[86][2] =
{
	{400,130000},//n 0
	{567,200000},
	{549,120000},
	{547,110000},
	{546,140000},
	{543,100000},
	{527,100000},
	{526,110000},
	{518,170000},
	{517,150000},
	{516,140000},
	{492,140000},
	{479,110000},
	{478,100000},
	{475,190000},
	{466,110000},
	{458,120000},
	{439,150000},
	{436,100000},
	{404,100000}, //n 19
	{419,800000},//c 20
	{586,800000},
	{581,1000000},
	{461,1000000},
	{418,700000},
	{603,750000},
	{589,770000},
	{580,1000000},
	{579,940000},
	{561,910000},
	{555,940000},
	{554,840000},
	{534,760000},
	{533,920000},
	{505,880000},
	{491,800000},
	{489,880000},
	{445,810000},
	{421,830000},//c 38
	{401,340000},//d 39
	{600,420000},
	{585,360000},
	{576,350000},
	{575,460000},
	{566,340000},
	{551,480000},
	{550,480000},
	{540,330000},
	{536,400000},
	{529,440000},
	{507,450000},
	{474,370000},
	{467,390000},
	{426,420000},
	{422,310000},
	{412,390000},
	{405,400000},//d 56
	{477,2200000},//b 57
	{471,2100000},
	{468,1900000},
	{463,2000000},
	{521,1900000},
	{602,2000000},
	{587,2100000},
	{565,2100000},
	{562,2200000},
	{560,2250000},
	{559,2200000},
	{558,2100000},
	{545,1900000},
	{535,2000000},
	{480,2400000},//b 71
	{402,4800000},//a 72
	{503,6000000},
	{502,6000000},
	{494,6000000},
	{495,5800000},
	{424,5000000},
	{434,4800000},
	{522,4600000},
	{541,6000000},
	{506,5100000},
	{451,6000000},
	{429,5400000},
	{415,5600000},
	{411,6000000}//a 85
};
new spys[5][2] =
{
	{-1,-1},
	{-1,-1},
	{-1,-1},
	{-1,-1},
	{-1,-1}
};
new shotTime[MAX_PLAYERS];
new shot[MAX_PLAYERS];

new tipster = -1;
new tipsteron = -1;
new tipsterplayer = -1;
new getgunsid[MAX_PLAYERS];
new tipsterlisten[MAX_PLAYERS];
new vehicleidtp[MAX_PLAYERS];
new reklamatimer;
new PlayerText:FishingText[MAX_PLAYERS];
new Float:Sonar[MAX_PLAYERS];
new ammonac[6];
new skills[2];
new Text3D:LabelRank[MAX_PLAYERS];
new Text3D:LabelRecognition[MAX_PLAYERS];
new LabelOn[MAX_PLAYERS];
new recognition[MAX_PLAYERS];
new enginebrokened[MAX_VEHICLES];
new engine,lights,alarm,doors,bonnet,boot,objective;
new IsSmoking[MAX_PLAYERS];
enum exInfo
{
	ExitIP[MAX_PLAYER_NAME],
	ExitTime
}
new ExitInfo[MAX_PLAYERS][exInfo];
new auctionpic[2];
new police[MAX_VEHICLES];
new bizname[MAX_PLAYERS][100];
new auction_info[10];
new bizselect[MAX_PLAYERS];
new KeysOffer[MAX_PLAYERS];
new KeysPrice[MAX_PLAYERS];
new KeysGram[MAX_PLAYERS];
new FreezePlayer[MAX_PLAYERS];
new Rvanka[MAX_PLAYERS];

SetPlayerToFacePlayer(playerid, targetid)
{
    new Float:pX, Float:pY, Float:pZ, Float:X, Float:Y, Float:Z, Float:ang;
    if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;
    GetPlayerPos(targetid, X, Y, Z);
    GetPlayerPos(playerid, pX, pY, pZ);
    if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
    else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
    else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
    if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
    else ang = (floatabs(ang) - 180.0);
    SetPlayerFacingAngle(playerid, ang);
    return 0;
}
CreateTrigger(Float:x,Float:y,Float:z)
{
	new Trigger = CreateObject(1317,x,y,z,0.0,0.0,0.0);
	SetObjectMaterial(Trigger,0,18646,"matcolours","blue",0xAA80FFDD);
	return Trigger;
}
TogglePlayerControllableEx(playerid,toggle)
{
	FreezePlayer[playerid] = toggle;
	TogglePlayerControllable(playerid, toggle);
	return true;
}
#define TogglePlayerControllable TogglePlayerControllableEx
new Float:CarHealth[MAX_VEHICLES];
new TimeHealth[MAX_VEHICLES];

SetVehHealth(vehicleid, Float:health)
{
	CarHealth[vehicleid] = health;
	TimeHealth[vehicleid] = 2;
	return SetVehicleHealth(vehicleid,health);
}
#define SetVehicleHealth SetVehHealth

#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

new Float:acarsd[][3] =
{
	{2120.0693,2718.2942,10.8203},
	{-1931.6606,271.5569,41.0469},
	{2507.9807,-2113.6448,13.5469}
};
new gangzonesa[MAX_PLAYERS];
new rabotaon[MAX_PLAYERS];
new nachalvzlom[MAX_PLAYERS];
new caroff[MAX_VEHICLES];
new idcarv[MAX_PLAYERS];
new timervzlom[MAX_PLAYERS];
new avtocar[MAX_PLAYERS];
new timecar[MAX_PLAYERS];
new tookmoped[MAX_PLAYERS];
new pickcars[5];
new Float:GMARMOUR[MAX_PLAYERS][1];
new Float:GMHP[MAX_PLAYERS][2];
new Float:VEHHP[MAX_PLAYERS][2];
new Text3D:JobText3D[MAX_VEHICLES];
new buscar[8];
new pPressed[MAX_PLAYERS];

new Float:BusCityLV[][] =
{
	{2827.7122,1287.5374,10.4960, 2828.5979,1349.7295,10.4851},
	{2828.5979,1349.7295,10.4851, 2830.2490,1453.5867,10.4380},
	{2830.2490,1453.5867,10.4380, 2810.9434,1475.6493,10.4112},
	{2810.9434,1475.6493,10.4112, 2701.4114,1475.5786,13.2682},
	{2701.4114,1475.5786,13.2682, 2565.3254,1475.9387,10.5693},
	{2565.3254,1475.9387,10.5693, 2425.1672,1458.8348,10.3990},
	{2425.1672,1458.8348,10.3990, 2425.0232,1388.2212,10.3990},
	{2425.0232,1388.2212,10.3990, 2402.9827,1375.8306,10.3990}, ////////
	{2402.9827,1375.8306,10.3990, 2328.8313,1375.2654,10.4004},
	{2328.8313,1375.2654,10.4004, 2227.2595,1375.5146,10.5165},
	{2227.2595,1375.5146,10.5165, 2141.0669,1375.8522,10.3990},
	{2141.0669,1375.8522,10.3990, 2069.4941,1412.9413,10.3990}, ////////////
	{2069.4941,1412.9413,10.3990, 2069.3545,1555.6749,10.3985},
	{2069.3545,1555.6749,10.3985, 2074.2522,1691.2032,10.3990},
	{2074.2522,1691.2032,10.3990, 2083.3120,1731.3164,10.3990},
	{2083.3120,1731.3164,10.3990, 2137.4177,1838.8073,10.3990},
	{2137.4177,1838.8073,10.3990, 2149.4041,1949.7141,10.4067},
	{2149.4041,1949.7141,10.4067, 2154.9656,2006.7346,10.3990},
	{2154.9656,2006.7346,10.3990, 2149.2458,2047.8812,10.4067}, ///////////////////
	{2149.2458,2047.8812,10.4067, 2150.0891,2212.5806,10.3990},
	{2150.0891,2212.5806,10.3990, 2198.8176,2333.1411,10.3990},
	{2198.8176,2333.1411,10.3990, 2229.5842,2400.6025,10.3990},
	{2229.5842,2400.6025,10.3990, 2229.9485,2442.6384,10.4123},
	{2229.9485,2442.6384,10.4123, 2083.1667,2455.8521,10.399},
	{2083.1667,2455.8521,10.399, 2040.5520,2455.6323,10.3989}, /////////////
	{2040.5520,2455.6323,10.3989, 2025.2017,2409.2336,10.4048},
	{2025.2017,2409.2336,10.4048, 2010.3225,2395.3706,10.3990},
	{2010.3225,2395.3706,10.3990, 1939.4858,2395.5569,10.3990},
	{1939.4858,2395.5569,10.3990, 1925.0082,2362.3936,10.3990},
	{1925.0082,2362.3936,10.3990, 1924.9097,2314.9290,10.3990},
	{1924.9097,2314.9290,10.3990, 1925.1405,2190.0247,10.4048},
	{1925.1405,2190.0247,10.4048, 1924.7076,2116.0227,10.4982},
	{1924.7076,2116.0227,10.4982, 1924.9579,2054.0154,10.3990}, /////////////
	{1924.9579,2054.0154,10.3990, 1901.8656,2044.4187,10.3990},
	{1901.8656,2044.4187,10.3990, 1841.7213,2055.7852,10.5195},
	{1841.7213,2055.7852,10.5195, 1716.1443,2055.5381,10.4394},
	{1716.1443,2055.5381,10.4394, 1704.8038,2030.0398,10.4049},
	{1704.8038,2030.0398,10.4049, 1705.0792,1965.8193,10.3990},
	{1705.0792,1965.8193,10.3990, 1705.4348,1884.1003,10.3990},
	{1705.4348,1884.1003,10.3990, 1660.3359,1875.4397,10.3990},
	{1660.3359,1875.4397,10.3990, 1644.6434,1817.6515,10.4047},
	{1644.6434,1817.6515,10.4047, 1645.2438,1726.5471,10.3990}, /////////////////
	{1645.2438,1726.5471,10.3990, 1705.5009,1711.1305,10.3990},
	{1705.5009,1711.1305,10.3990, 1727.8558,1663.9143,9.7931},
	{1727.8558,1663.9143,9.7931, 1730.0469,1611.1600,9.5889},
	{1730.0469,1611.1600,9.5889, 1727.0743,1543.9349,10.3989},
	{1727.0743,1543.9349,10.3989, 1712.6594,1454.8257,10.4624},
	{1712.6594,1454.8257,10.4624, 1720.0021,1380.0167,10.2193},
	{1720.0021,1380.0167,10.2193, 1726.6637,1288.2371,10.3990},
	{1726.6637,1288.2371,10.3990, 1756.3873,1271.1761,11.7470},
	{1756.3873,1271.1761,11.7470, 1882.8234,1270.9567,10.3994},
	{1882.8234,1270.9567,10.3994, 2032.3241,1270.8514,10.3990},
	{2032.3241,1270.8514,10.3990, 2040.4423,1155.8553,10.3990}, ///////////////
	{2040.4423,1155.8553,10.3990, 2045.7813,1094.8022,10.3990},
	{2045.7813,1094.8022,10.3990, 2051.9490,980.1622,10.3478},
	{2051.9490,980.1622,10.3478, 2103.6660,970.9399,10.3455},
	{2103.6660,970.9399,10.3990, 2145.1384,925.0372,10.3989},
	{2145.1384,925.0372,10.3989, 2144.9375,721.4338,10.4355},
	{2144.9375,721.4338,10.4355, 2179.9919,710.7172,10.3990},
	{2179.9919,710.7172,10.3990, 2274.3362,711.1173,10.3990},
	{2274.3362,711.1173,10.3990, 2376.8376,710.9398,10.3990},
	{2376.8376,710.9398,10.3990, 2417.7654,710.7748,10.4140},
	{2417.7654,710.7748,10.4140, 2430.0789,737.1588,10.3990},
	{2430.0789,737.1588,10.3990, 2463.8088,770.4927,10.3990},
	{2463.8088,770.4927,10.3990, 2533.7329,770.6903,10.4068}, //////////////////
	{2533.7329,770.6903,10.4068, 2549.5715,813.9160,11.1068},
	{2549.5715,813.9160,11.1068, 2549.5967,941.5245,10.4065},
	{2549.5967,941.5245,10.4065, 2549.2029,1001.5764,10.3978},
	{2549.2029,1001.5764,10.3978, 2573.9358,1010.4851,10.4699},
	{2573.9358,1010.4851,10.4699, 2609.8220,1048.8676,10.3990},
	{2609.8220,1048.8676,10.3990, 2610.5010,1122.4563,10.3990},
	{2610.5010,1122.4563,10.3990, 2609.2266,1239.9553,10.3990}, ////////////////////////
	{2609.2266,1239.9553,10.3990, 2629.4099,1298.8424,10.3990},
	{2629.4099,1298.8424,10.3990, 2673.0471,1311.2069,11.5071},
	{2673.0471,1311.2069,11.5071, 2792.4287,1310.6711,10.4771},
	{2792.4287,1310.6711,10.4771, 2785.6804,1275.5779,10.4771},
	{2785.6804,1275.5779,10.4771, 2764.9609,1234.9835,10.4771},
	{2764.9609,1234.9835,10.4771, 2800.6440,1230.2970,10.4977},
	{2800.6440,1230.2970,10.4977, 2827.7122,1287.5374,10.4960},
	{2827.7122,1287.5374,10.4960, 0.0, 0.0, 0.0}
};
new Float:BusCitySF[][] =
{
	{-1988.0446,140.1014,27.2661, -2003.4841,214.1351,27.2661},
	{-2003.4841,214.1351,27.2661, -2000.5131,313.4200,34.7426},
	{-2000.5131,313.4200,34.7426, -1998.5398,471.8105,34.7427},
	{-1998.5398,471.8105,34.7427, -2000.0660,589.2780,34.7443}, ///////////////
	{-2000.0660,589.2780,34.7443, -1983.1162,601.5040,34.7447},
	{-1983.1162,601.5040,34.7447, -1765.3795,600.4207,27.5781},
	{-1765.3795,600.4207,27.5781, -1708.5352,638.9060,24.4615},
	{-1708.5352,638.9060,24.4615, -1709.2012,713.6660,24.4673},
	{-1709.2012,713.6660,24.4673, -1686.2982,726.0994,21.9807},
	{-1686.2982,726.0994,21.9807, -1584.0829,725.0784,7.6853},
	{-1584.0829,725.0784,7.6853, -1539.4480,751.1326,6.7661}, ///////////////
	{-1539.4480,751.1326,6.7661, -1526.3699,902.7177,6.7661},
	{-1526.3699,902.7177,6.7661, -1566.6733,1008.7411,6.7661},
	{-1566.6733,1008.7411,6.7661, -1583.1990,1175.9945,6.7720},
	{-1583.1990,1175.9945,6.7720, -1657.7933,1278.0837,6.7703},
	{-1657.7933,1278.0837,6.7703, -1759.8112,1370.0012,6.7661},
	{-1759.8112,1370.0012,6.7661, -1893.3424,1340.7925,6.7662},
	{-1893.3424,1340.7925,6.7662, -2017.5878,1313.2760,6.7661},
	{-2017.5878,1313.2760,6.7661, -2124.4597,1335.1978,6.7739},
	{-2124.4597,1335.1978,6.7739, -2270.4126,1338.5504,6.7661},
	{-2270.4126,1338.5504,6.7661, -2457.7053,1353.1648,6.7688}, ///////////////////
	{-2457.7053,1353.1648,6.7688, -2459.7207,1222.8270,34.7824},
	{-2459.7207,1222.8270,34.7824, -2509.7961,1189.8923,39.7203},
	{-2509.7961,1189.8923,39.7203, -2647.5432,1209.3071,54.9540},
	{-2647.5432,1209.3071,54.9540, -2670.1223,1220.7137,55.1568},
	{-2670.1223,1220.7137,55.1568, -2701.2837,1216.6837,54.8801},
	{-2701.2837,1216.6837,54.8801, -2751.0327,1165.2881,51.2197},
	{-2751.0327,1165.2881,51.2197, -2732.4473,1097.7551,46.1041},
	{-2732.4473,1097.7551,46.1041, -2736.0510,1076.3564,46.6157},
	{-2736.0510,1076.3564,46.6157, -2753.1973,989.3776,54.0414},
	{-2753.1973,989.3776,54.0414, -2752.8333,889.3956,65.9159},
	{-2752.8333,889.3956,65.9159, -2753.9016,769.2898,53.9614},
	{-2753.9016,769.2898,53.9614, -2753.8579,704.6906,40.8521}, ////////////////
	{-2753.8579,704.6906,40.8521, -2752.6665,583.9778,15.5260},
	{-2752.6665,583.9778,15.5260, -2629.1440,559.9763,14.1880},
	{-2629.1440,559.9763,14.1880, -2609.3816,550.2076,14.1880}, //////////////////////////
	{-2609.3816,550.2076,14.1880, -2609.2786,419.0351,14.1443},
	{-2609.2786,419.0351,14.1443, -2623.4963,332.2929,3.9100},
	{-2623.4963,332.2929,3.9100, -2694.1890,337.3127,3.9130},
	{-2694.1890,337.3127,3.9130, -2709.2107,310.5451,3.9068},
	{-2709.2107,310.5451,3.9068, -2708.7454,265.6249,3.9068}, ////////////////////////
	{-2708.7454,265.6249,3.9068, -2708.4983,137.9188,3.9068},
	{-2708.4983,137.9188,3.9068, -2708.3228,61.5767,3.9068},
	{-2708.3228,61.5767,3.9068, -2708.6318,5.2428,3.9068},
	{-2708.6318,5.2428,3.9068, -2708.3984,-57.2606,3.9068},
	{-2708.3984,-57.2606,3.9068, -2676.2898,-72.9829,3.9068},
	{-2676.2898,-72.9829,3.9068, -2588.9204,-72.8143,3.9952}, /////////////////////
	{-2588.9204,-72.8143,3.9952, -2468.8010,-72.3784,30.7145},
	{-2468.8010,-72.3784,30.7145, -2389.8684,-72.2215,34.8912},
	{-2389.8684,-72.2215,34.8912, -2298.3589,-72.0373,34.8912},
	{-2298.3589,-72.0373,34.8912, -2199.7261,-72.9877,34.8990},
	{-2199.7261,-72.9877,34.8990, -2097.7122,-73.0991,34.8989},
	{-2097.7122,-73.0991,34.8989, -2027.6685,-73.1562,34.8990},
	{-2027.6685,-73.1562,34.8990, -2004.3160,-47.7378,34.8920}, /////////////////
	{-2004.3160,-47.7378,34.8920, -2003.9662,82.7331,27.2662},
	{-2003.9662,82.7331,27.2662, -1988.0446,140.1014,27.2661},
	{-1988.0446,140.1014,27.2661, 0.0, 0.0, 0.0}
};
new Float:BusCityLS[][] =
{
	{1238.5247,-1832.1951,13.5304, 1214.3824,-1842.2007,13.5149},
	{1214.3824,-1842.2007,13.5149, 1195.2499,-1849.5330,13.5300},
	{1195.2499,-1849.5330,13.5300, 1076.8751,-1850.1189,13.5237},
	{1076.8751,-1850.1189,13.5237, 1060.6364,-1834.8591,13.6470},
	{1060.6364,-1834.8591,13.6470, 1038.0361,-1785.1960,13.68850},
	{1038.0361,-1785.1960,13.6885, 1039.8900,-1731.7588,13.5161},
	{1039.8900,-1731.7588,13.5161, 1147.0249,-1714.6013,13.9146},
	{1147.0249,-1714.6013,13.9146, 1280.5072,-1714.8085,13.5162}, // peatus
	{1280.5072,-1714.8085,13.5162, 1294.9458,-1728.1792,13.5161},
	{1294.9458,-1728.1792,13.5161, 1294.8989,-1836.0220,13.5162},
	{1294.8989,-1836.0220,13.5162, 1317.0968,-1854.8313,13.5166},
	{1317.0968,-1854.8313,13.5166, 1371.0465,-1873.2445,13.5163},
	{1371.0465,-1873.2445,13.5163, 1391.5786,-1856.0959,13.5160},
	{1391.5786,-1856.0959,13.5160, 1391.3907,-1748.5936,13.5162}, ///////////
	{1391.3907,-1748.5936,13.5162, 1481.3625,-1734.5426,13.5161},
	{1481.3625,-1734.5426,13.5161, 1514.0380,-1734.8099,13.5162}, // peatus
	{1514.0380,-1734.8099,13.5162, 1532.1124,-1715.9408,13.5138},
	{1532.1124,-1715.9408,13.5138, 1531.8948,-1609.0205,13.5159},
	{1531.8948,-1609.0205,13.5159, 1542.8218,-1594.7335,13.5161},
	{1542.8218,-1594.7335,13.5161, 1708.0238,-1595.8610,13.5001},
	{1708.0238,-1595.8610,13.5001, 1805.0760,-1614.4507,13.4869}, //////////
	{1805.0760,-1614.4507,13.4869, 1818.6862,-1681.7240,13.5161},
	{1818.6862,-1681.7240,13.5161, 1819.1482,-1627.8978,13.5161},
	{1819.1637,-1768.6271,13.5163, 1818.9535,-1917.4446,13.5157},
	{1818.9535,-1917.4446,13.5157, 1843.2506,-1934.8319,13.5140},
	{1843.2506,-1934.8319,13.5140, 1944.7305,-1934.4397,13.5162},
	{1944.7305,-1934.4397,13.5162, 1959.1595,-1948.0632,13.7346},
	{1959.1595,-1948.0632,13.7346, 1958.9994,-2124.9451,13.5161},
	{1958.9994,-2124.9451,13.5161, 1958.9464,-2150.8484,13.5161},
	{1958.9464,-2150.8484,13.5161, 1980.8533,-2169.1074,13.5130},
	{1980.8533,-2169.1074,13.5130, 2127.4326,-2210.9990,13.5161}, ////////////////
	{2127.4326,-2210.9990,13.5161, 2154.9214,-2212.8267,13.5179},
	{2154.9214,-2212.8267,13.5179, 2188.4197,-2178.9497,13.5114},
	{2188.4197,-2178.9497,13.5114, 2208.3721,-2178.8171,13.4993},
	{2208.3721,-2178.8171,13.4993, 2239.5859,-2210.0459,13.4596},
	{2239.5859,-2210.0459,13.4596, 0.0,0.0,0.0},
	{2281.9973,-2252.0698,13.6036, 2318.6899,-2256.4153,13.5084}, ///////////////////
	{2318.6899,-2256.4153,13.5084, 2413.6458,-2180.0645,13.5084},
	{2413.6458,-2180.0645,13.5084, 2621.3723,-2169.8599,11.7886},
	{2621.3723,-2169.8599,11.7886, 2796.0964,-2144.5806,11.0631},
	{2796.0964,-2144.5806,11.0631, 2837.8245,-1984.7358,11.0710},
	{2837.8245,-1984.7358,11.0710, 2870.6658,-1681.5833,11.0122},
	{2870.6658,-1681.5833,11.0122, 2841.0391,-1654.7875,10.9174},
	{2841.0391,-1654.7875,10.9174, 2661.2539,-1654.8489,10.8343},
	{2661.2539,-1654.8489,10.8343, 2640.6577,-1712.9298,10.8611}, ////////////////// два выше
	{2640.6577,-1712.9298,10.8611, 2613.0627,-1730.1464,12.0208},
	{2613.0627,-1730.1464,12.0208, 2449.7312,-1730.1978,13.6528},
	{2449.7312,-1730.1978,13.6528, 2433.1511,-1616.1829,27.0375},
	{2433.6008,-1460.0776,23.9579, 2448.9790,-1440.3479,23.9634},
	{2448.9790,-1440.3479,23.9634, 2453.5325,-1419.5775,23.9615},
	{2453.5325,-1419.5775,23.9615, 2412.3574,-1253.8340,23.9558},
	{2412.3574,-1253.8340,23.9558, 2661.2539,-1654.8489,10.8343},
	{2386.9873,-1253.6946,23.9559, 2368.4519,-1281.3727,23.9688},
	{2368.9080,-1368.3611,23.9780, 2350.8696,-1381.9030,23.9650},
	{2350.8696,-1381.9030,23.9650, 2089.6267,-1381.9432,23.9619}, ////////////////////////
	{2089.6267,-1381.9432,23.9619, 2073.4641,-1363.4091,23.9588},
	{2073.4641,-1363.4091,23.9588, 2073.3997,-1152.9436,23.8472},
	{2073.3997,-1152.9436,23.8472, 2020.2545,-1133.2900,24.8908},
	{2020.2545,-1133.2900,24.8908, 1885.3809,-1132.9916,24.0794},
	{1885.3809,-1132.9916,24.0794, 1864.2970,-1160.1176,23.8199},
	{1864.2970,-1160.1176,23.8199, 1832.4225,-1178.3257,23.7677},
	{1832.4225,-1178.3257,23.7677, 1658.9194,-1158.1030,23.8722},
	{1658.9194,-1158.1030,23.8722, 1658.9194,-1158.1030,23.8722}, ///////////////////
	{1596.3362,-1158.4154,24.0396, 1580.1649,-1142.5476,23.8254},
	{1580.1649,-1142.5476,23.8254, 1528.9998,-1039.5239,23.7696},
	{1528.9998,-1039.5239,23.7696, 1501.2731,-1032.4484,23.7743},
	{1501.2731,-1032.4484,23.7743, 1479.5311,-1051.1530,23.7892},
	{1479.5311,-1051.1530,23.7892, 1479.7573,-1142.5359,24.0396},
	{1479.7573,-1142.5359,24.0396, 1501.3533,-1163.2172,24.0473},
	{1501.3533,-1163.2172,24.0473, 1668.5289,-1163.5801,23.7890},
	{1668.5289,-1163.5801,23.7890, 1528.9998,-1039.5239,23.7696}, ///////////////////
	{1768.7809,-1169.9598,23.7872, 1827.3875,-1183.2314,23.7641},
	{1827.3875,-1183.2314,23.7641, 1845.5515,-1197.3513,22.9131},
	{1845.5515,-1197.3513,22.9131, 1845.7029,-1242.4534,14.7945},
	{1845.7029,-1242.4534,14.7945, 1868.1499,-1263.3727,13.5212},
	{1868.1499,-1263.3727,13.5212, 2049.1936,-1263.4569,23.9537},
	{2049.1936,-1263.4569,23.9537, 2065.7383,-1277.3209,23.9537},
	{2065.7383,-1277.3209,23.9537, 2065.7378,-1369.0361,23.9440}, ///////////////////
	{2065.7378,-1369.0361,23.9440, 2092.4697,-1386.9020,23.9601},
	{2092.4697,-1386.9020,23.9601, 2354.2454,-1387.0751,23.9699},
	{2354.2454,-1387.0751,23.9699, 2373.5449,-1367.9800,23.9656},
	{2373.5449,-1367.9800,23.9656, 2373.5110,-1272.2000,23.9698},
	{2373.5110,-1272.2000,23.9698, 2387.1821,-1259.2478,23.9637},
	{2387.1821,-1259.2478,23.9637,2427.7188,-1259.3298,23.9650},
	{2427.7188,-1259.3298,23.9650,1528.9998,-1039.5239,23.7696},
	{2448.7603,-1273.6116,23.9544,2448.7754,-1425.4390,23.9616}, ///////////////////
	{2448.7754,-1425.4390,23.9616,2437.4160,-1444.3368,23.9731},
	{2437.4160,-1444.3368,23.9731,2428.6941,-1466.4805,23.9613},
	{2428.6941,-1466.4805,23.9613,2428.7791,-1603.5916,26.17700},
	{2428.7791,-1603.5916,26.1770,2428.4851,-1713.3696,14.6449},
	{2428.4851,-1713.3696,14.6449,2448.9460,-1734.9404,13.6589},
	{2448.9460,-1734.9404,13.6589,2626.2710,-1734.6022,11.2428},
	{2626.2710,-1734.6022,11.2428,2640.2214,-1749.5358,10.8608}, ///////////////////
	{2640.2214,-1749.5358,10.8608,2676.4072,-1875.9507,11.0216},
	{2676.4072,-1875.9507,11.0216,2804.3679,-1893.3619,11.0543},
	{2804.3679,-1893.3619,11.0543,2822.9373,-1917.5231,11.0709},
	{2822.9373,-1917.5231,11.0709,2812.1682,-2100.1853,11.0651},
	{2812.1682,-2100.1853,11.0651,2690.8582,-2155.5874,11.0599},
	{2690.8582,-2155.5874,11.0599,2410.2681,-2165.5828,13.5078},
	{2410.2681,-2165.5828,13.5078,2305.7051,-2248.0249,13.5083}, ///////////////////
	{2305.7051,-2248.0249,13.5083,2279.8718,-2243.1921,13.7707},
	{2279.8718,-2243.1921,13.7707,2248.0229,-2211.1538,13.4549},
	{2248.0229,-2211.1538,13.4549,2448.9460,-1734.9404,13.6589},
	{2183.5237,-2146.8306,13.5025,2107.5442,-2108.1975,13.4346},
	{2107.5442,-2108.1975,13.4346,1981.2144,-2107.4551,13.4836},
	{1981.2144,-2107.4551,13.4836,1964.3152,-2092.0791,13.5240},
	{1964.3152,-2092.0791,13.5240,2428.7791,-1603.5916,26.1770},
	{1964.3152,-2092.0791,13.5240,1964.3492,-1951.3857,13.8093},
	{1964.3492,-1951.3857,13.8093,1942.7271,-1929.8000,13.5161},
	{1942.7271,-1929.8000,13.5161,1837.5028,-1930.1250,13.5169},
	{1837.5028,-1930.1250,13.5169,1824.1443,-1915.5752,13.5119},
	{1824.1443,-1915.5752,13.5119,1823.7717,-1682.7144,13.5162},
	{1823.7717,-1682.7144,13.5162,1824.1844,-1630.6477,13.5161},
	{1824.1844,-1630.6477,13.5161,1804.4215,-1609.5674,13.4862},
	{1804.4215,-1609.5674,13.4862,1681.2842,-1590.0104,13.5160},
	{1681.2842,-1590.0104,13.5160,1548.2252,-1589.9628,13.5163},
	{1548.2252,-1589.9628,13.5163,1527.2129,-1620.1754,13.5163},
	{1527.2129,-1620.1754,13.5163,1527.1331,-1714.0327,13.5162},
	{1527.1331,-1714.0327,13.5162,1514.6785,-1729.6405,13.5163},
	{1514.6785,-1729.6405,13.5163,1477.5608,-1729.8918,13.5162},
	{1477.5608,-1729.8918,13.5162,2428.7791,-1603.5916,26.1770},
	{1413.1190,-1729.7999,13.5242,1386.6285,-1749.7579,13.5160},
	{1386.6285,-1749.7579,13.5160,1386.6914,-1854.3090,13.5161},
	{1386.6914,-1854.3090,13.5161,1370.8682,-1868.1794,13.5164},
	{1370.8682,-1868.1794,13.5164,1304.9640,-1849.7131,13.5199},
	{1304.9640,-1849.7131,13.5199,1268.2179,-1839.4244,13.5244},
	{1268.2179,-1839.4244,13.5244,1238.5247,-1832.1951,13.5304},
	{1238.5247,-1832.1951,13.5304,2626.2710,-1734.6022,11.2428},
	{1238.5247,-1832.1951,13.5304,2626.2710,-1734.6022,11.2428}
};
new Float:BusSchool[][] =
{
	{1603.0409,-1158.1918,24.0066, 1375.5563,-1139.8900,23.7568},
	{1375.5563,-1139.8900,23.7568, 1343.1094,-1159.3662,23.8041},
	{1343.1094,-1159.3662,23.8041, 1339.5063,-1398.3763,13.4274},
	{1339.5063,-1398.3763,13.4274, 1328.4043,-1480.9446,13.4835},
	{1328.4043,-1480.9446,13.4835, 1301.1501,-1547.1753,13.4845},
	{1301.1501,-1547.1753,13.4845, 1296.5106,-1690.7666,13.4845},
	{1296.5106,-1690.7666,13.4845, 1191.1615,-1710.6499,13.5039},
	{1191.1615,-1710.6499,13.5039, 1171.7720,-1745.2683,13.4984},
	{1171.7720,-1745.2683,13.4984, 1172.5651,-1832.8263,13.5012},
	{1172.5651,-1832.8263,13.5012, 1079.4225,-1850.4327,13.4923},
	{1079.4225,-1850.4327,13.4923, 1041.1807,-1810.7709,13.7337},
	{1041.1807,-1810.7709,13.7337, 1038.5695,-1585.4709,13.4837}, /////////////////////
	{1038.5695,-1585.4709,13.4837, 1043.2693,-1398.1222,13.4600},
	{1043.2693,-1398.1222,13.4600, 660.2036,-1395.9253,13.5005},
	{660.2036,-1395.9253,13.5005, 628.2453,-1193.4976,18.4277},
	{628.2453,-1193.4976,18.4277, 82.3714,-1257.8467,14.4748},
	{82.3714,-1257.8467,14.4748, -245.9801,-1584.6241,15.9544},
	{-245.9801,-1584.6241,15.9544, -370.6366,-1966.7914,28.2431},
	{-370.6366,-1966.7914,28.2431, -310.5305,-2225.6050,29.0027},
	{-310.5305,-2225.6050,29.0027, -103.6279,-2482.1733,37.9837},
	{-103.6279,-2482.1733,37.9837, -38.7617,-2599.2607,43.8138},
	{-38.7617,-2599.2607,43.8138, -148.6527,-2822.5200,40.2211},
	{-148.6527,-2822.5200,40.2211, -492.2774,-2758.7148,66.1703},
	{-492.2774,-2758.7148,66.1703, -910.1223,-2836.0840,70.0783}, ////////////////////
	{-910.1223,-2836.0840,70.0783, -1024.5665,-2854.1021,67.8104},
	{-1024.5665,-2854.1021,67.8104, -1313.9917,-2872.4587,58.2093},
	{-1313.9917,-2872.4587,58.2093, -1675.5028,-2681.6897,48.6797},
	{-1675.5028,-2681.6897,48.6797, -1747.6259,-2600.4617,50.0625},
	{-1747.6259,-2600.4617,50.0625, -2092.4756,-2640.7991,53.7694},
	{-2092.4756,-2640.7991,53.7694, -2376.8628,-2556.3992,44.3193},
	{-2376.8628,-2556.3992,44.3193, -2524.9465,-2165.6970,30.0705},
	{-2524.9465,-2165.6970,30.0705, -2905.8152,-1681.0071,18.7631},
	{-2905.8152,-1681.0071,18.7631, -2933.3191,-1395.1686,11.5176},
	{-2933.3191,-1395.1686,11.5176, -2865.2195,-920.1004,9.5882},
	{-2865.2195,-920.1004,9.5882, -2777.1616,-476.5119,7.2808},
	{-2777.1616,-476.5119,7.2808, -2507.3289,-342.9320,29.6137},
	{-2507.3289,-342.9320,29.6137, -2317.6519,-344.9995,39.9120},
	{-2317.6519,-344.9995,39.9120, -2072.2759,-351.5080,35.4039},
	{-2072.2759,-351.5080,35.4039, -2023.4122,-311.4927,35.4296},
	{-2023.4122,-311.4927,35.4296, -2042.3379,-290.4153,35.4915},
	{-2042.3379,-290.4153,35.4915, -2191.2529,-293.1540,35.4503},
	{-2191.2529,-293.1540,35.4503, -2198.3242,-189.7529,35.2763},
	{-2198.3242,-189.7529,35.2763, -2173.5134,-175.8506,35.2716},
	{-2173.5134,-175.8506,35.2716, -2166.2654,-92.0829,35.2821},
	{-2032.8879,-73.8608,35.2716, -2032.7073,-73.8643,35.2484},
	{-2032.7073,-73.8643,35.2484, -2006.3911,-52.6238,35.2704},
	{-2006.3911,-52.6238,35.2704, -2005.1267,81.1522,27.7284},
	{-2005.1267,81.1522,27.7284, -1989.7633,129.5122,27.6399},
	{-1989.7633,129.5122,27.6399, -1986.2164,182.6150,27.7386},
	{-1986.2164,182.6150,27.7386, -2008.8680,153.4529,27.6392},
	{-2008.8680,153.4529,27.6392, -2007.9268,-48.7648,35.2708},
	{-2007.9268,-48.7648,35.2708, -2007.5714,-86.8649,35.4429},
	{-2007.5714,-86.8649,35.4429, -2006.6643,-272.5722,35.4339},
	{-2006.6643,-272.5722,35.4339, -2046.1627,-326.3444,35.4048},
	{-2046.1627,-326.3444,35.4048, -2267.3201,-333.9951,39.5207},
	{-2267.3201,-333.9951,39.5207, -2569.2500,-333.4581,23.8381},
	{-2569.2500,-333.4581,23.8381, -2871.9785,-817.5627,7.1436},
	{-2871.9785,-817.5627,7.1436, -2913.3682,-1154.2468,9.5926}, ///////////////
	{-2913.3682,-1154.2468,9.5926, -2944.0874,-1421.8760,11.0036},
	{-2944.0874,-1421.8760,11.0036, -2873.8486,-1932.1017,36.7978},
	{-2873.8486,-1932.1017,36.7978, -2682.2700,-2065.9888,35.0296},
	{-2682.2700,-2065.9888,35.0296, -2463.1123,-2502.5300,44.1078},
	{-2463.1123,-2502.5300,44.1078, -2188.5176,-2683.3191,56.9562},
	{-2188.5176,-2683.3191,56.9562, -1819.7305,-2604.8577,55.3396},
	{-1819.7305,-2604.8577,55.3396, -1650.0139,-2729.6946,47.0341},
	{-1650.0139,-2729.6946,47.0341, -1475.8119,-2892.1995,47.0225},
	{-1475.8119,-2892.1995,47.0225, -1371.2446,-2927.9302,47.4409},
	{-1371.2446,-2927.9302,47.4409, -947.9971,-2869.8306,66.7587},
	{-947.9971,-2869.8306,66.7587, -707.9083,-2788.6650,51.9978},
	{-707.9083,-2788.6650,51.9978, -194.1682,-2871.2712,39.2822},
	{-194.1682,-2871.2712,39.2822, -1.8479,-2756.8240,40.6794},
	{-1.8479,-2756.8240,40.6794, -86.2643,-2462.9468,33.8937},
	{-86.2643,-2462.9468,33.8937, -188.5853,-2350.8984,29.3682},
	{-188.5853,-2350.8984,29.3682, -327.8987,-2072.2246,27.2352},
	{-327.8987,-2072.2246,27.2352, -239.0778,-1609.7271,15.6402},
	{-239.0778,-1609.7271,15.6402, -62.5916,-1412.4728,12.0027},
	{-62.5916,-1412.4728,12.0027, 90.8736,-1287.7268,13.8016},
	{90.8736,-1287.7268,13.8016, 415.2348,-1142.6877,30.3734},
	{415.2348,-1142.6877,30.3734, 620.9048,-1231.2452,18.1559},
	{620.9048,-1231.2452,18.1559, 649.9189,-1396.6401,13.5180},
	{649.9189,-1396.6401,13.5180, 1315.4454,-1404.1787,13.3932},
	{1315.4454,-1404.1787,13.3932, 1336.8890,-1457.1638,13.4858},
	{1336.8890,-1457.1638,13.4858, 1300.9177,-1541.2573,13.4843},
	{1300.9177,-1541.2573,13.4843, 1296.1965,-1821.1320,13.4835},
	{1296.1965,-1821.1320,13.4835, 1209.7904,-1851.5548,13.4835},
	{1209.7904,-1851.5548,13.4835, 1183.1213,-1777.6486,13.4988},
	{1183.1213,-1777.6486,13.4988, 1182.4337,-1733.9489,13.5076},
	{1182.4337,-1733.9489,13.5076, 1163.9393,-1713.9647,13.8430}, //////////////////
	{1163.9393,-1713.9647,13.8430, 1056.2832,-1712.1915,13.4836},
	{1056.2832,-1712.1915,13.4836, 1040.4452,-1567.7225,13.4811},
	{1040.4452,-1567.7225,13.4811, 1061.6090,-1432.1150,13.4626},
	{1061.6090,-1432.1150,13.4626, 1354.4844,-1406.0000,13.4208},
	{1354.4844,-1406.0000,13.4208, 1395.0216,-1428.9286,13.4851},
	{1395.0216,-1428.9286,13.4851, 1432.8265,-1443.9072,13.4855},
	{1432.8265,-1443.9072,13.4855, 1457.6628,-1196.4583,19.8684},
	{1457.6628,-1196.4583,19.8684, 1613.9203,-1163.7047,23.9937},
	{1613.9203,-1163.7047,23.9937, 1640.3938,-1126.9946,24.0055}
};
new Float:BusLSZavodi[][] =
{
	{1626.6134,-1157.9778,23.9838, 1438.9491,-1158.1682,23.7565},
	{1438.9491,-1158.1682,23.7565, 1371.1659,-1141.6920,23.7575},
	{1371.1659,-1141.6920,23.7575, 1156.3663,-1142.7145,23.7581},
	{1156.3663,-1142.7145,23.7581, 1060.3214,-1161.7843,23.8253},
	{1060.3214,-1161.7843,23.8253, 1057.4797,-1369.3597,13.4901},
	{1057.4797,-1369.3597,13.4901, 1059.5537,-1415.6218,13.4781},
	{1059.5537,-1415.6218,13.4781, 1047.9326,-1496.2870,13.4866},
	{1047.9326,-1496.2870,13.4866, 1036.2673,-1656.0790,13.4838},
	{1036.2673,-1656.0790,13.4838, 1049.6667,-1711.8562,13.4826},
	{1049.6667,-1711.8562,13.4826, 1130.1522,-1713.4314,13.5866}, /////////////////
	{1130.1522,-1713.4314,13.5866, 1265.5109,-1713.5775,13.4836},
	{1265.5109,-1713.5775,13.4836, 1294.7024,-1724.8502,13.5243},
	{1294.7024,-1724.8502,13.5243, 1309.5178,-1833.7739,13.4840},
	{1309.5178,-1833.7739,13.4840, 1312.6914,-1663.8285,13.4837},
	{1312.6914,-1663.8285,13.4837, 1315.0392,-1560.2806,13.4898},
	{1315.0392,-1560.2806,13.4898, 1340.8297,-1494.3445,13.4874},
	{1340.8297,-1494.3445,13.4874, 1360.3828,-1125.4598,23.7805},
	{1360.3828,-1125.4598,23.7805, 1395.3101,-948.5587,34.7014},
	{1395.3101,-948.5587,34.7014, 1534.1229,-993.1343,42.2408},
	{1534.1229,-993.1343,42.2408, 1706.8365,-765.2202,52.9134},
	{1706.8365,-765.2202,52.9134, 1696.4478,-428.3773,34.2487},
	{1696.4478,-428.3773,34.2487, 1671.1747,-91.4483,35.7530},
	{1671.1747,-91.4483,35.7530, 1653.3126,243.5643,30.0597},
	{1653.3126,243.5643,30.0597, 1758.7390,552.5330,25.9447},
	{1758.7390,552.5330,25.9447, 1807.9695,812.0594,10.9973},
	{1807.9695,812.0594,10.9973, 1866.2555,831.4418,9.1772},
	{1866.2555,831.4418,9.1772, 2100.0452,832.0826,6.8356},
	{2100.0452,832.0826,6.8356, 2301.5449,835.6395,6.8435},
	{2301.5449,835.6395,6.8435, 2677.1301,963.5281,6.8355},
	{2677.1301,963.5281,6.8355, 2744.8875,1366.6559,6.8214},
	{2744.8875,1366.6559,6.8214, 2793.1299,1448.3379,10.7282},
	{2793.1299,1448.3379,10.7282, 2820.1904,1466.8337,10.8467},
	{2820.1904,1466.8337,10.8467, 2820.9973,1359.1929,10.8510},
	{2820.9973,1359.1929,10.8510, 2764.8262,1254.7311,10.8544},
	{2764.8262,1254.7311,10.8544, 2782.9355,1229.9468,10.8570},
	{2782.9355,1229.9468,10.8570, 2829.0437,1282.5835,10.8818},
	{2829.0437,1282.5835,10.8818, 2827.6799,1451.7260,10.8118},
	{2827.6799,1451.7260,10.8118, 2658.8022,1473.1030,10.9049},
	{2658.8022,1473.1030,10.9049, 2639.7986,1452.9443,10.7581},
	{2639.7986,1452.9443,10.7581, 2696.7070,1343.2480,6.8374},
	{2696.7070,1343.2480,6.8374, 2704.1851,1106.0325,6.8354},
	{2704.1851,1106.0325,6.8354, 2655.3137,966.9592,6.8367},
	{2655.3137,966.9592,6.8367, 2604.7678,911.7582,6.8396},
	{2604.7678,911.7582,6.8396, 2474.0730,859.2693,6.8459},
	{2474.0730,859.2693,6.8459, 1949.6083,851.5674,6.8313},
	{1949.6083,851.5674,6.8313, 1787.6935,806.8473,11.1060},
	{1787.6935,806.8473,11.1060, 1634.2479,226.0851,30.7790}, //////////////////
	{1634.2479,226.0851,30.7790, 1610.2744,124.0676,36.9908},
	{1610.2744,124.0676,36.9908, 1640.1609,-38.5060,36.6895},
	{1640.1609,-38.5060,36.6895, 1664.2051,-340.3452,40.3461},
	{1664.2051,-340.3452,40.3461, 1703.0380,-593.9151,38.1101},
	{1703.0380,-593.9151,38.1101, 1673.0964,-781.1240,54.6800},
	{1673.0964,-781.1240,54.6800, 1427.4979,-941.3197,36.2182},
	{1427.4979,-941.3197,36.2182, 1363.2279,-959.3282,34.0392},
	{1363.2279,-959.3282,34.0392, 1350.8372,-1053.6084,26.7221},
	{1350.8372,-1053.6084,26.7221, 1340.8602,-1427.0399,13.4789},
	{1340.8602,-1427.0399,13.4789, 1316.3042,-1505.8967,13.4840},
	{1316.3042,-1505.8967,13.4840, 1296.3157,-1679.8788,13.4839},
	{1296.3157,-1679.8788,13.4839, 1286.2415,-1711.3412,13.4832},
	{1286.2415,-1711.3412,13.4832, 1128.2864,-1709.4812,13.5523},
	{1128.2864,-1709.4812,13.5523, 1056.2510,-1710.3544,13.4836},
	{1056.2510,-1710.3544,13.4836, 1040.9821,-1555.0303,13.4632},
	{1040.9821,-1555.0303,13.4632, 1058.4032,-1474.1971,13.4791},
	{1058.4032,-1474.1971,13.4791, 1060.8860,-1395.2904,13.5821},
	{1060.8860,-1395.2904,13.5821, 1059.6604,-1175.7849,23.1790},
	{1059.6604,-1175.7849,23.1790, 1079.6471,-1151.8898,23.7576},
	{1079.6471,-1151.8898,23.7576, 1362.8177,-1143.9968,23.7570},
	{1362.8177,-1143.9968,23.7570, 1405.0570,-1152.2969,23.7612},
	{1405.0570,-1152.2969,23.7612, 1622.4208,-1162.8495,23.9980},
	{1622.4208,-1162.8495,23.9980, 1641.7179,-1125.3340,24.0071},
	{1641.7179,-1125.3340,24.0071, 1626.6134,-1157.9778,23.9838}
};
new Float:BusLSLV[][] =
{
	{1626.6134,-1157.9778,23.9838, 1438.9491,-1158.1682,23.7565},
	{1438.9491,-1158.1682,23.7565, 1371.1659,-1141.6920,23.7575},
	{1371.1659,-1141.6920,23.7575, 1156.3663,-1142.7145,23.7581},
	{1156.3663,-1142.7145,23.7581, 1060.3214,-1161.7843,23.8253},
	{1060.3214,-1161.7843,23.8253, 1057.4797,-1369.3597,13.4901},
	{1057.4797,-1369.3597,13.4901, 1059.5537,-1415.6218,13.4781},
	{1059.5537,-1415.6218,13.4781, 1047.9326,-1496.2870,13.4866},
	{1047.9326,-1496.2870,13.4866, 1036.2673,-1656.0790,13.4838},
	{1036.2673,-1656.0790,13.4838, 1049.6667,-1711.8562,13.4826},
	{1049.6667,-1711.8562,13.4826, 1130.1522,-1713.4314,13.5866}, /////////////////
	{1130.1522,-1713.4314,13.5866, 1265.5109,-1713.5775,13.4836},
	{1265.5109,-1713.5775,13.4836, 1294.7024,-1724.8502,13.5243},
	{1294.7024,-1724.8502,13.5243, 1309.5178,-1833.7739,13.4840},
	{1309.5178,-1833.7739,13.4840, 1312.6914,-1663.8285,13.4837},
	{1312.6914,-1663.8285,13.4837, 1315.0392,-1560.2806,13.4898},
	{1315.0392,-1560.2806,13.4898, 1340.8297,-1494.3445,13.4874},
	{1340.8297,-1494.3445,13.4874, 1360.3828,-1125.4598,23.7805},
	{1360.3828,-1125.4598,23.7805, 1395.3101,-948.5587,34.7014},
	{1395.3101,-948.5587,34.7014, 1534.1229,-993.1343,42.2408},
	{1534.1229,-993.1343,42.2408, 1706.8365,-765.2202,52.9134},
	{1706.8365,-765.2202,52.9134, 1696.4478,-428.3773,34.2487},
	{1696.4478,-428.3773,34.2487, 1671.1747,-91.4483,35.7530},
	{1671.1747,-91.4483,35.7530, 1653.3126,243.5643,30.0597},
	{1653.3126,243.5643,30.0597, 1758.7390,552.5330,25.9447},
	{1758.7390,552.5330,25.9447, 1807.9695,812.0594,10.9973},
	{1807.9695,812.0594,10.9973, 1866.2555,831.4418,9.1772},
	{1866.2555,831.4418,9.1772, 2100.0452,832.0826,6.8356},
	{2100.0452,832.0826,6.8356, 2301.5449,835.6395,6.8435},
	{2301.5449,835.6395,6.8435, 2677.1301,963.5281,6.8355},
	{2677.1301,963.5281,6.8355, 2744.8875,1366.6559,6.8214},
	{2744.8875,1366.6559,6.8214, 2793.1299,1448.3379,10.7282},
	{2793.1299,1448.3379,10.7282, 2820.1904,1466.8337,10.8467},
	{2820.1904,1466.8337,10.8467, 2820.9973,1359.1929,10.8510},
	{2820.9973,1359.1929,10.8510, 2764.8262,1254.7311,10.8544},
	{2764.8262,1254.7311,10.8544, 2782.9355,1229.9468,10.8570},
	{2782.9355,1229.9468,10.8570, 2829.0437,1282.5835,10.8818},
	{2829.0437,1282.5835,10.8818, 2827.6799,1451.7260,10.8118},
	{2827.6799,1451.7260,10.8118, 2658.8022,1473.1030,10.9049},
	{2658.8022,1473.1030,10.9049, 2639.7986,1452.9443,10.7581},
	{2639.7986,1452.9443,10.7581, 2696.7070,1343.2480,6.8374},
	{2696.7070,1343.2480,6.8374, 2704.1851,1106.0325,6.8354},
	{2704.1851,1106.0325,6.8354, 2655.3137,966.9592,6.8367},
	{2655.3137,966.9592,6.8367, 2604.7678,911.7582,6.8396},
	{2604.7678,911.7582,6.8396, 2474.0730,859.2693,6.8459},
	{2474.0730,859.2693,6.8459, 1949.6083,851.5674,6.8313},
	{1949.6083,851.5674,6.8313, 1787.6935,806.8473,11.1060},
	{1787.6935,806.8473,11.1060, 1634.2479,226.0851,30.7790}, //////////////////
	{1634.2479,226.0851,30.7790, 1610.2744,124.0676,36.9908},
	{1610.2744,124.0676,36.9908, 1640.1609,-38.5060,36.6895},
	{1640.1609,-38.5060,36.6895, 1664.2051,-340.3452,40.3461},
	{1664.2051,-340.3452,40.3461, 1703.0380,-593.9151,38.1101},
	{1703.0380,-593.9151,38.1101, 1673.0964,-781.1240,54.6800},
	{1673.0964,-781.1240,54.6800, 1427.4979,-941.3197,36.2182},
	{1427.4979,-941.3197,36.2182, 1363.2279,-959.3282,34.0392},
	{1363.2279,-959.3282,34.0392, 1350.8372,-1053.6084,26.7221},
	{1350.8372,-1053.6084,26.7221, 1340.8602,-1427.0399,13.4789},
	{1340.8602,-1427.0399,13.4789, 1316.3042,-1505.8967,13.4840},
	{1316.3042,-1505.8967,13.4840, 1296.3157,-1679.8788,13.4839},
	{1296.3157,-1679.8788,13.4839, 1286.2415,-1711.3412,13.4832},
	{1286.2415,-1711.3412,13.4832, 1128.2864,-1709.4812,13.5523},
	{1128.2864,-1709.4812,13.5523, 1056.2510,-1710.3544,13.4836},
	{1056.2510,-1710.3544,13.4836, 1040.9821,-1555.0303,13.4632},
	{1040.9821,-1555.0303,13.4632, 1058.4032,-1474.1971,13.4791},
	{1058.4032,-1474.1971,13.4791, 1060.8860,-1395.2904,13.5821},
	{1060.8860,-1395.2904,13.5821, 1059.6604,-1175.7849,23.1790},
	{1059.6604,-1175.7849,23.1790, 1079.6471,-1151.8898,23.7576},
	{1079.6471,-1151.8898,23.7576, 1362.8177,-1143.9968,23.7570},
	{1362.8177,-1143.9968,23.7570, 1405.0570,-1152.2969,23.7612},
	{1405.0570,-1152.2969,23.7612, 1622.4208,-1162.8495,23.9980},
	{1622.4208,-1162.8495,23.9980, 1641.7179,-1125.3340,24.0071},
	{1641.7179,-1125.3340,24.0071, 1626.6134,-1157.9778,23.9838}
};

//////////////////////////////

new lift;
new kolvovsklade;
new kolvovfure;
new kauta;
new Text3D:LvaLable;
new kauta2;
new skladfbi;
new skladfbi2;
new nikname;
new nikname2;
new cerkva;
new cerkva2;
new lift2;
new SDuty[MAX_PLAYERS];
new lift3;
new lift4;
new lift5;
new ChatOOC[MAX_PLAYERS];
new lift6;
new ash;
new ash2;
new ash3;
new ash4;
new maria;
new rmspawn[2];
new lcnspawn[2];

new paints[3];
new paintguns[4];

new SlotAttach[51];
new SlotObject[250];
new SlotActor[50];
new vidachagun[12][MAX_PLAYERS];
new string[1000];
new YCMDstr[256];
new Menu:BuyClothes;
new PlayerText:FULLRECON[MAX_PLAYERS];
new ChosenPlayer[MAX_PLAYERS];
new PickupRazd[35];
new strR[255][255];
new SkinMen[][2] =
{
	{66,1000},
	{15,1000},
	{36,1000},
	{50,1000},
	{95,1000},
	{96,1000},
	{136,1000},
	{143,1000},
	{155,1000},
	{2,50000},
	{14,50000},
	{24,50000},
	{58,100000},
	{7,300000},
	{23,300000},
	{33,300000},
	{60,500000},
	{67,500000},
	{73,500000},
	{184,500000},
	{21,700000},
	{22,700000},
	{30,700000},
	{183,700000},
	{255,700000},
	{4,700000},
	{6,700000},
	{8,700000},
	{42,700000},
	{273,700000},
	{17,1000000},
	{45,1000000},
	{82,1000000},
	{83,1000000},
	{185,1000000},
	{290,1000000},
	{291,1000000},
	{28,1200000},
	{29,1200000},
	{248,1200000},
	{247,1200000},
	{254,1200000},
	{249,1200000},
	{18,1500000},
	{19,1500000},
	{47,1500000},
	{48,1500000},
	{101,1500000},
	{299,1500000},
	{289,1500000},
	{61,2000000},
	{121,2000000},
	{227,2000000},
	{228,2000000},
	{292,2000000},
	{293,2000000},
	{297,2000000},
	{122,2500000},
	{111,3000000},
	{117,3500000},
	{118,3500000},
	{126,4000000},
	{127,4000000},
	{296,4000000},
	{3,4000000},
	{119,4000000},
	{208,4000000},
	{295,4500000},
	{46,5000000},
	{294,5000000}

};
new SkinMale[][2] =
{
	{65, 1000},
	{192, 10000},
	{219, 1000000},
	{93, 2000000},
	{211, 2000000},
	{233, 2000000},
	{148, 3000000},
	{169, 4000000},
	{141, 5000000},
	{76, 5000000},
	{150, 5000000},
	{214, 5000000}
};
new TotalHouse = 0;
new TotalBizz = 0;
new ChangeSkin[MAX_PLAYERS];
new HealthOn[MAX_PLAYERS];
new vehcreat[MAX_VEHICLES];
new radioall;
new Float:PickupX[MAX_PLAYERS],Float:PickupY[MAX_PLAYERS];
new oldpickup[MAX_PLAYERS];
new timepickup[MAX_PLAYERS];
// WareLock
new bool:wareAztecLock = false;
new bool:wareGrooveLock = false;
new bool:wareBallasLock = false;
new bool:wareRifaLock = false;
new bool:wareVagosLock = false;
new bool:wareLcnLock = false;
new bool:wareYakuzaLock = false;
new bool:wareRmLock = false;
new bool:wareHAMLock = false;
new bool:warePMCLock = false;
new bool:wareWCMLock = false;
new AdvertTime;
new Weapons[MAX_PLAYERS][47];

GiveWeapon(playerid,weaponid,ammo)
{
	SetPVarInt(playerid, "GunCheckTime", 2);
	new ammow = 0;
	switch(weaponid)
	{
	case 1..9: GetPlayerWeaponData(playerid, 1, ammow, ammow);
	case 10..15: GetPlayerWeaponData(playerid, 10, ammow, ammow);
	case 16..19: GetPlayerWeaponData(playerid, 8, ammow, ammow);
	case 22..24: GetPlayerWeaponData(playerid, 2, ammow, ammow);
	case 25..27: GetPlayerWeaponData(playerid, 3, ammow, ammow);
	case 28..29,32: GetPlayerWeaponData(playerid, 4, ammow, ammow);
	case 30..31: GetPlayerWeaponData(playerid, 5, ammow, ammow);
	case 33..34: GetPlayerWeaponData(playerid, 6, ammow, ammow);
	case 35..38: GetPlayerWeaponData(playerid, 7, ammow, ammow);
	case 41..43: GetPlayerWeaponData(playerid, 9, ammow, ammow);
	}
	Weapons[playerid][weaponid] += (ammo+ammow);
	GivePlayerWeapon(playerid,weaponid,ammo);
	if(weaponid == 17 && ammo == 17)
	{
	    SCM(playerid, COLOR_LIGHTRED, " Вы были кикнуты по подозрению в читерстве! (#002)");
        Kick(playerid);
	}
	return true;
}
new TOTALADVERT[3];
new rob;
new ReportQ[MAX_PLAYERS][144];
enum adInfo
{
	adPhone,
	adText[128],
	adName[50],
	bool:edited,
	editName[50]
}
new AdvertInfo[30][3][adInfo];
enum vibrosilInfo
{
	vModel,
	vTime,
    Float:vX,
    Float:vY,
    Float:vZ,
    Text3D:vPodnyat,
	vKol,
	vObject
}
new VibrosInfo[999][vibrosilInfo], SLOTVIBROS = 0;
enum atm
{
	aid,
    Float:aX,
    Float:aY,
    Float:aZ,
    Float:arZ
}
new ATMInfo[100][atm], TOTALATM = 0;
new ATM[100], ATMADVERTISE[20][150];
new Text3D:LABELATM[100], bool:LABELATM_;
enum wInfo
{
	wID,
	wOwner[MAX_PLAYER_NAME],
    Float:wEntr[3],
    Float:wExit[3],
    Float:wMenu[3],
	wBank,
	wLandTax,
	wProds,
	wPriceProds,
	wZp,
	wDeputy1[32],
	wDeputy2[32],
	wDeputy3[32],
	wMechanic1[32],
	wMechanic2[32],
	wMechanic3[32],
	wMechanic4[32],
	wMechanic5[32],
	wAuction[5],
	wAuctions[128],
	wAuctionName[MAX_PLAYER_NAME],
    Text3D:wLabel,
	wPickup[4],
	wBiker,
    bool:isCaptured
}
new WorkshopInfo[5][wInfo], TOTALSHOPS = 0;
// Развозчики продуктов на ферму
new car_grain[MAX_VEHICLES][3];
new car_prods[MAX_VEHICLES][4];
new car_pickup[MAX_VEHICLES];
new Text3D:car_text[MAX_VEHICLES];
//
enum fInfo
{
	fID,
	fOwner[MAX_PLAYER_NAME],
    Float:fMenu[3],
    Float:fCloakroom[3],
	fBank,
	fLandTax,
	fZp,
	fGrain_Price,
	fGrain,
	fGrain_Sown,
	fProds_Selling,
	fProds,
	fProds_Price,
	fDeputy_1[MAX_PLAYER_NAME],
	fDeputy_2[MAX_PLAYER_NAME],
	fDeputy_3[MAX_PLAYER_NAME],
	fFarmer_1[MAX_PLAYER_NAME],
	fFarmer_2[MAX_PLAYER_NAME],
	fFarmer_3[MAX_PLAYER_NAME],
	fFarmer_4[MAX_PLAYER_NAME],
	fFarmer_5[MAX_PLAYER_NAME],
	fAuction[5],
	fAuctions[64],
	fAuctionName[MAX_PLAYER_NAME],
    Text3D:fLabel,
	fPickup[2],
	fSeed_Car[2],
	fCombine,
	fBiker,
    bool:isCaptured
}
new FarmInfo[6][fInfo], TOTALFARM = 0;
new Farmtimer[MAX_PLAYERS];
new bool:Farmcar_works[MAX_VEHICLES];
new Farmcar_pickup[MAX_VEHICLES];
new Text3D:Farmcar_text[MAX_VEHICLES];
new Farmcar_prods[MAX_VEHICLES];
new Float:Farmcombine_coord_one[16][3] =
{
	{-320.8694,-1365.4385,9.8428},
	{-324.8013,-1401.0339,13.2010},
	{-301.7462,-1425.4576,13.9760},
	{-287.7421,-1391.3496,10.4911},
	{-284.4016,-1344.1929,7.2467},
	{-257.3175,-1316.2000,9.9445},
	{-245.2030,-1356.5045,8.7477},
	{-243.9296,-1388.2174,9.6420},
	{-228.3160,-1422.7065,5.0133},
	{-206.5894,-1394.1740,5.8277},
	{-204.5860,-1330.3910,9.8077},
	{-182.5080,-1311.5313,5.9209},
	{-180.3449,-1365.8169,3.8640},
	{-214.0825,-1415.8950,4.5256},
	{-264.4544,-1426.5730,9.1420},
	{-324.6056,-1428.9579,14.8003}
};
new Float:Farmcombine_coord_two[15][3] =
{
	{-130.7027,44.7220,2.8443},
	{-145.5741,61.2925,2.8443},
	{-165.2465,43.3439,2.8443},
	{-175.8336,7.8020,2.8365},
	{-191.4658,-42.5760,2.8443},
	{-228.0420,-69.5110,2.8442},
	{-230.8085,-30.8695,2.8443},
	{-209.9449,29.5974,2.8443},
	{-208.8271,91.6010,2.5696},
	{-241.8963,57.9227,1.9067},
	{-257.0153,8.2201,1.9814},
	{-271.7077,-37.9002,2.1155},
	{-250.0249,-67.0826,2.8443},
	{-191.2002,-74.9127,2.8443},
	{-150.3399,-6.1474,2.8443}
};
new Float:Farmcombine_coord_three[15][3] =
{
	{-1187.8000,-1051.3243,128.9458},
	{-1187.5616,-1020.7885,128.9458},
	{-1187.0750,-958.0953,128.9390},
	{-1157.4517,-927.2670,128.9458},
	{-1131.6406,-968.0543,128.9458},
	{-1132.7548,-1022.1390,128.9458},
	{-1094.4727,-1055.9808,128.9388},
	{-1070.3040,-1008.1692,128.9458},
	{-1069.8025,-946.7182,128.9458},
	{-1041.3453,-919.6816,128.9458},
	{-1020.2495,-958.0220,128.9458},
	{-1018.5430,-1018.1034,128.9397},
	{-1055.0632,-1054.2510,128.9390},
	{-1110.2307,-1055.0585,128.9465},
	{-1182.4001,-1058.6345,128.9458}
};
new Float:Farmcombine_coord_four[10][3] =
{
	{-8.9009,-7.1966,2.8443},
	{-25.3066,-51.6468,2.8443},
	{-25.7014,-107.4654,2.8443},
	{-1.5358,-79.6419,2.8446},
	{21.8522,-43.6649,2.8443},
	{18.2182,-75.2312,1.8680},
	{24.0178,-112.9527,0.3364},
	{38.4268,-77.6550,0.4112},
	{20.3284,-42.6540,2.8424},
	{-7.0064,-7.9382,2.8443}
};
new Float:Farmcombine_coord_five[11][3] =
{
	{1916.7062,194.0659,34.2542},
	{1917.7260,216.1904,29.9047},
	{1936.3885,233.2233,28.5738},
	{1942.2996,205.0887,31.2080},
	{1958.4962,183.6927,33.7993},
	{1970.1038,203.6444,29.6427},
	{1988.0249,228.8007,27.1248},
	{1999.4275,204.8942,26.9487},
	{1979.3251,179.1305,32.0967},
	{1933.9193,187.5078,34.8203},
	{1918.4210,191.2246,34.7327}
};
new Float:Farmcar_coord_one[4][3] =
{
	{-305.3935,-1334.0796,8.2550},
	{-311.4154,-1359.4165,9.0605},
	{-256.1160,-1385.5819,10.0414},
	{-191.2922,-1380.0945,5.0030}
};
new Float:Farmcar_coord_two[4][3] =
{
	{-167.5728,-4.7965,3.1172},
	{-194.6789,49.8787,3.1172},
	{-236.7553,-9.5347,3.1172},
	{-227.7488,-52.3213,3.1172}
};
new Float:Farmcar_coord_three[4][3] =
{
	{-1183.0190,-1058.6979,129.1978},
	{-1154.6866,-1046.9103,129.2095},
	{-1075.6294,-930.5206,129.2089},
	{-1028.6787,-973.0988,129.2091}
};
new Float:Farmcar_coord_four[4][3] =
{
	{-5.4270,-44.5476,2.8443},
	{-0.9173,-95.1931,2.3333},
	{37.3381,-77.9443,0.4641},
	{-22.6910,-59.8679,2.8443}
};
new Float:Farmcar_coord_five[4][3] =
{
	{1921.2250,204.1377,32.3460},
	{1966.3246,198.3651,31.0604},
	{1985.4440,183.7903,31.270},
	{1993.8384,224.2885,27.1094}
};
enum stallInfo
{
	stID,
    Float:stPos[4],
    Text3D:stText
}
new StallInfo[50][stallInfo], TOTALSTALL = 0;
enum caInfo
{
	caID,
	caName[64],
	caMafia,
	caManager[32],
	caManager2[32],
	caManager3[32],
	caKrupie[32],
	caKrupie2[32],
	caKrupie3[32],
	caKrupie4[32],
	caKrupie5[32],
	caKrupie6[32],
	caKrupie7[32],
	caKrupie8[32],
	caKrupie9[32],
	caKrupie10[32],
    Float:caPos[3]
}
new CasinoInfo[3][caInfo], TOTALCASINO = 0;
new FormaFracPic[16];
new freshtimer;
new war = 0;
new rabota1;
new IPMSG[5][] =
{
	{"IP проверка обезопасит Ваш аккаунт от взлома!\n"},
	{"Если Ваш IP адрес будет изменён, система потребуют ключ безопасности\n\n"},
	{"Для того чтобы включить/отключить защиту \n"},
	{"Введите /mm - [10] Безопасность\n\n"},
	{"Обязательно установите ключ безопасности!\n"}
};
new tpadminhome[2];
new parashut;
new dinamicashs[MAX_PLAYERS];
new modernhouse[17];
new bool:modern = false;
new licgate;
new gruzgate;
new bool:Prorab[MAX_PLAYERS];
new caligula[3];
new dragons[2];
new wmcvhod;
new wmcvqhod;
new pmcvhod;
new pmcvqhod;
new vmcvhod;
new vmcvqhod;
new Text3D:GasZavod[2];
new Text3D:Doki[2];
new Text3D:Sklad[2];
new Text3D:Derevobuy[2];
new PetrolTanker[6];
new Linerunner[2];
new Tanker[12];
new Roadtrain[6];
new bGruz[MAX_PLAYERS];
new levelDexp = 20000;
new Gruz[MAX_PLAYERS];
new Benzbuy[2] = {500,500};
new ugolbuy[2] = {500,500};
new Buyderevo[2] = {500,500};
new Sellugol[2] = {800,800};
new Sellderevo[2] = {800,800};
new Sellbenz[2] = {800,800};
new bool:DriverJob[MAX_PLAYERS];
new bool:jobcar[MAX_VEHICLES];
new Tune[MAX_PLAYERS];
new MehJob[MAX_PLAYERS];
new sellzone[MAX_PLAYERS];
new mesh[MAX_PLAYERS];
new usemesh[MAX_PLAYERS];
new play[MAX_PLAYERS];
new PText[MAX_PLAYERS][128];
new timer2[MAX_PLAYERS];
new Flood[MAX_PLAYERS];
new seans[MAX_PLAYERS];
new taxiexpp[MAX_PLAYERS];
new medicss[10];
new ProposeOffer[MAX_PLAYERS];
new Krisha[MAX_PLAYERS];
new KrishaOffer[MAX_PLAYERS];
new ProposedTo[MAX_PLAYERS];
new GotProposedBy[MAX_PLAYERS];
new chekmatlva[10];
new chekmats[2];
new tex[MAX_PLAYERS];
new tex2[MAX_PLAYERS];
new addd[3];
new nick[MAX_PLAYERS];
new TicketOffer[MAX_PLAYERS];
new TicketMoney[MAX_PLAYERS];
new enterbiz[MAX_PLAYERS];
new Hptimer;
new gSpectateID[MAX_PLAYERS];
new zvonok[3] = {-1, -1, -1};
new PlayerDrunk[MAX_PLAYERS];
new mast[3];
new startaddiction[MAX_PLAYERS];
new chet[MAX_PLAYERS];
new arace;
new PicCP[MAX_PLAYERS];
new Text:DRAP;
new createdvehs;
new house_car[MAX_PLAYERS];
new createdcar;
new creatcar[MAX_PLAYERS];
enum admveh
{
	createdveh,
	vehid,
	color1,
	color2
}
new AdminVehicle[MAX_PLAYERS][admveh];
new carpick[4];
new VehicleNames[212][] =
{
	"Landstalker","Bravura","Buffalo","Linerunner","Perrenial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr.Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Barron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","Zr-350","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring A","Hotring B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","Roadtrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car","Police Car",
	"Police Car","Police Ranger","Picador","S.W.A.T.","Alpha","Phoenix","Glendale","Sadler","L Trailer A","L Trailer B",
	"Stair Trailer","Boxville","Farm Plow","U Trailer"
};
new PEfir[MAX_PLAYERS];
new Pefir[MAX_PLAYERS];
new bool:robhouse[999];
new bool:robh[MAX_PLAYERS];
new WantNickChange[MAX_PLAYERS][MAX_PLAYER_NAME];
new zd[MAX_PLAYERS];
new Text:Speed;
new Text:BoxPanel;
new MafiaKills[15];
new PlayerText:SpeedShow[MAX_PLAYERS];
new PlayerText:FuelShow[MAX_PLAYERS];
new PlayerText:Capture[MAX_PLAYERS];
new PlayerText:StatusShow[MAX_PLAYERS];
new PlayerText:KMShow[MAX_PLAYERS];
new PlayerText:FillShow[MAX_PLAYERS];
new PlayerText:LimitShow[MAX_PLAYERS];
new str1[64],str2[64];
new Float:Fuell[MAX_VEHICLES], Refueling[MAX_PLAYERS], OldFuel[MAX_PLAYERS];
new HealOffer[MAX_PLAYERS];
new HealPrice[MAX_PLAYERS];
new InviteOffer[MAX_PLAYERS];
new healpric = 1;
new WantSms[MAX_PLAYERS][MAX_PLAYERS];
new smspricesf = 50;
new smspricels = 50;
new smspricelv = 50;
new smssf = -1;
new smsls = -1;
new smslv = -1;
new snyatosf = 0;
new snyatols = 0;
new snyatolv = 0;
new newsZP[3];
new gcontract[MAX_PLAYERS];
new cenabenza[MAX_PLAYERS];
new CountOnZone[40];
new Text3D:Meh3d[MAX_VEHICLES];
new PCash[MAX_PLAYERS];
new DrugOffer[MAX_PLAYERS];
new DrugPrice[MAX_PLAYERS];
new DrugGram[MAX_PLAYERS];
new ZoneOffer[MAX_PLAYERS];
new ZonePrice[MAX_PLAYERS];
new FreeOffer[MAX_PLAYERS];
new SposobOffer[MAX_PLAYERS];
new FreePrice[MAX_PLAYERS];
new TakingLesson[MAX_PLAYERS];
new Menu:ChoseSkin[2];
new Menu:bomj[4];
new useguns[MAX_PLAYERS];
new gLastCar[MAX_PLAYERS];
new bool:Works[MAX_PLAYERS];
new JobCP[MAX_PLAYERS];
new GruzCP[MAX_PLAYERS];
new usemats[MAX_PLAYERS];
new JobAmmount[MAX_PLAYERS];
new OldSkin[MAX_PLAYERS];
new JobOffer[MAX_PLAYERS];
new Employer[MAX_PLAYERS];
new ConsumingMoney[MAX_PLAYERS];
new Float: Armour[MAX_PLAYERS];
new dostup[MAX_PLAYERS];
new forma[MAX_PLAYERS];
new proverkaforma[MAX_PLAYERS];
new Army;
new SFa;
new LSport;
new TieTime[MAX_PLAYERS];
new Rekl[MAX_PLAYERS];
new TranPlayer[MAX_PLAYERS];
new Report[MAX_PLAYERS];
new CreatedCars[100];
new CreatedCar = 0;
new RegistrationStep[MAX_PLAYERS];
new WatchingTV[MAX_PLAYERS];
new MatsHolding[MAX_PLAYERS];
new DivorceOffer[MAX_PLAYERS];
new MarriageCeremoney[MAX_PLAYERS];
new MarryWitness[MAX_PLAYERS];
new MarryWitnessOffer[MAX_PLAYERS];
new SpawnChange[MAX_PLAYERS];
new TutTime[MAX_PLAYERS];
new PlayerTazeTime[MAX_PLAYERS];
new ConnectedToPC[MAX_PLAYERS];
new PlayerTied[MAX_PLAYERS];
new PlayerCuffed[MAX_PLAYERS];
new PlayerCuffedTime[MAX_PLAYERS];
new LiveOffer[MAX_PLAYERS];
new LiveOfferls[MAX_PLAYERS];
new LiveOfferlv[MAX_PLAYERS];
new TalkingLive[MAX_PLAYERS];
new TalkingLivels[MAX_PLAYERS];
new TalkingLivelv[MAX_PLAYERS];
new SelectChar[MAX_PLAYERS];
new SelectCharID[MAX_PLAYERS];
new SelectCharPlace[MAX_PLAYERS];
new CharPrice[MAX_PLAYERS];
new ChosenSkin[MAX_PLAYERS];
new InviteSkin[MAX_PLAYERS];
new CallLawyer[MAX_PLAYERS];
new CurrentMoney[MAX_PLAYERS];
new KickPlayer[MAX_PLAYERS];
new CP[MAX_PLAYERS];
new RaceCP[MAX_PLAYERS];
new RepairOffer[MAX_PLAYERS];
new RepairPrice[MAX_PLAYERS];
new RefillOffer[MAX_PLAYERS];
new RefillPrice[MAX_PLAYERS];
new RepairCar[MAX_PLAYERS];
new gPlayerCheckpointStatus[MAX_PLAYERS];
new gPlayerLogTries[MAX_PLAYERS];
new gPlayerSpawned[MAX_PLAYERS];
new gNews[MAX_PLAYERS];
new lNews[MAX_PLAYERS];
new LvNews[MAX_PLAYERS];
new gLog[MAX_PLAYERS];
new BigEar[MAX_PLAYERS];
new CellTime[MAX_PLAYERS];
new StartTime[MAX_PLAYERS];
new PhoneOnline[MAX_PLAYERS];
new gDice[MAX_PLAYERS];
new FirstSpawn[MAX_PLAYERS];
new Locator[MAX_PLAYERS];
new Mobile[MAX_PLAYERS];
new Tel[MAX_PLAYERS];
new noooc;
new antiooc;
new antioocsend;
new ghour = 0;
new gminute = 0;
new gsecond = 0;
new realtime = 1;
new wtime = 15;
new callcost = 10;
new realchat = 1;
new timeshift = 0;
new shifthour;
new MzCheckTimer;
new levelexp = 4;
new cchargetime = 60;
new MatsArmyCar[MAX_PLAYERS];
new VertMats[MAX_PLAYERS];
new VertMatslsa[MAX_PLAYERS];
new vertmatbi[MAX_VEHICLES][1];
new vertmatbilsa[MAX_VEHICLES][1];
new armmatbi = 300000;
new armmatsf = 300000;
new lspdmatbi = 100000;
new sfpdmats = 100000;
new lvpdmats = 100000;
new fbimats = 100000;
new yakuzamats = 100000;
new rmmats = 100000;
new lcnmats = 100000;
new ssmcmatbi = 50000;
new hamcmatbi = 100000;
new omcmatbi = 50000;
new wmcmatbi = 100000;
new hwmcmatbi = 50000;
new fsmcmatbi = 50000;
new vmcmatbi = 50000;
new pmcmatbi = 100000;
new mmcmatbi = 50000;
new bmcmatbi = 50000;
new rifamatbi = 100000;
new ballasmatbi = 100000;
new groovmatbi = 100000;
new vagosmatbi = 100000;
new aztekmatbi = 100000;
new lsamatbi = 100000;
new ballashel = 500;
new groovhel = 500;
new vagoshel = 500;
new aztekhel = 500;
new rifahel = 500;
new yakuzahel = 500, rmhel = 500, lcnhel;
new lsamat;
new lsaammo;
new lsacarvertexit[MAX_PLAYERS];
new Float:TeleportDest[MAX_PLAYERS][3];
new Float:TelePos[MAX_PLAYERS][6];
/*
new GunNames[48][] =
{
	"Нет",
	"Кастет",
	"Клюшка для гольфа",
	"Полиц. дубинка",
	"Ножик",
	"Бейсбольная бита",
	"Лопата",
	"Кий",
	"Катана",
	"Бензопила",
	"Розовый Дилдо",
	"Маленький Белый Дилдо",
	"Длинный Белый Дилдо",
	"Вибратор",
	"Цветы",
	"Трость",
	"Граната",
	"Слезот. газ",
	"Коктейль Молотова",
	"Vehicle Missile",
	"Hydra Flare",
	"Jetpack",
	"Глок",
	"Пистолет с глушителем",
	"Пустынный орёл",
	"Дробовик",
	"Обрез",
	"Боевой дробовик",
	"Узи",
	"MP5",
	"AK47",
	"M4",
	"Tec9",
	"Винтовка",
	"Снайперская винтовка",
	"Базука",
	"Базука с самонаводкой",
	"Огнемёт",
	"Миниган",
	"Satchel Charge",
	"Детонатор",
	"Балончик с краской",
	"Fire Extinguisher",
	"Фотоапарат",
	"Очки Ночного Видения",
	"Infrared Vision",
	"Парашют",
	"Fake Pistol"
};
*/
new legalmods[48][22] =
{
	{400, 1024,1021,1020,1019,1018,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{401, 1145,1144,1143,1142,1020,1019,1017,1013,1007,1006,1005,1004,1003,1001,0000,0000,0000,0000},
	{404, 1021,1020,1019,1017,1016,1013,1007,1002,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{405, 1023,1021,1020,1019,1018,1014,1001,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{410, 1024,1023,1021,1020,1019,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
	{415, 1023,1019,1018,1017,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{418, 1021,1020,1016,1006,1002,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{420, 1021,1019,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{421, 1023,1021,1020,1019,1018,1016,1014,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{422, 1021,1020,1019,1017,1013,1007,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{426, 1021,1019,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{436, 1022,1021,1020,1019,1017,1013,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
	{439, 1145,1144,1143,1142,1023,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
	{477, 1021,1020,1019,1018,1017,1007,1006,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{478, 1024,1022,1021,1020,1013,1012,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{489, 1024,1020,1019,1018,1016,1013,1006,1005,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
	{491, 1145,1144,1143,1142,1023,1021,1020,1019,1018,1017,1014,1007,1003,0000,0000,0000,0000,0000},
	{492, 1016,1006,1005,1004,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{496, 1143,1142,1023,1020,1019,1017,1011,1007,1006,1003,1002,1001,0000,0000,0000,0000,0000,0000},
	{500, 1024,1021,1020,1019,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{516, 1021,1020,1019,1018,1017,1016,1015,1007,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
	{517, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1016,1007,1003,1002,0000,0000,0000,0000,0000},
	{518, 1145,1144,1143,1142,1023,1020,1018,1017,1013,1007,1006,1005,1003,1001,0000,0000,0000,0000},
	{527, 1021,1020,1018,1017,1015,1014,1007,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{529, 1023,1020,1019,1018,1017,1012,1011,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000},
	{534, 1185,1180,1179,1178,1127,1126,1125,1124,1123,1122,1106,1101,1100,0000,0000,0000,0000,0000},
	{535, 1121,1120,1119,1118,1117,1116,1115,1114,1113,1110,1109,0000,0000,0000,0000,0000,0000,0000},
	{536, 1184,1183,1182,1181,1128,1108,1107,1105,1104,1103,0000,0000,0000,0000,0000,0000,0000,0000},
	{540, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1004,1001,0000,0000,0000,0000},
	{542, 1145,1144,1021,1020,1019,1018,1015,1014,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{546, 1145,1144,1143,1142,1024,1023,1019,1018,1017,1007,1006,1004,1002,1001,0000,0000,0000,0000},
	{547, 1143,1142,1021,1020,1019,1018,1016,1003,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{549, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1012,1011,1007,1003,1001,0000,0000,0000,0000},
	{550, 1145,1144,1143,1142,1023,1020,1019,1018,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000},
	{551, 1023,1021,1020,1019,1018,1016,1006,1005,1003,1002,0000,0000,0000,0000,0000,0000,0000,0000},
	{558, 1168,1167,1166,1165,1164,1163,1095,1094,1093,1092,1091,1090,1089,1088,0000,0000,0000,0000},
	{559, 1173,1162,1161,1160,1159,1158,1072,1071,1070,1069,1068,1067,1066,1065,0000,0000,0000,0000},
	{560, 1170,1169,1141,1140,1139,1138,1033,1032,1031,1030,1029,1028,1027,1026,0000,0000,0000,0000},
	{561, 1157,1156,1155,1154,1064,1063,1062,1061,1060,1059,1058,1057,1056,1055,1031,1030,1027,1026},
	{562, 1172,1171,1149,1148,1147,1146,1041,1040,1039,1038,1037,1036,1035,1034,0000,0000,0000,0000},
	{565, 1153,1152,1151,1150,1054,1053,1052,1051,1050,1049,1048,1047,1046,1045,0000,0000,0000,0000},
	{567, 1189,1188,1187,1186,1133,1132,1131,1130,1129,1102,0000,0000,0000,0000,0000,0000,0000,0000},
	{575, 1177,1176,1175,1174,1099,1044,1043,1042,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{576, 1193,1192,1191,1190,1137,1136,1135,1134,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{580, 1023,1020,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{589, 1145,1144,1024,1020,1018,1017,1016,1013,1007,1006,1005,1004,1000,0000,0000,0000,0000,0000},
	{600, 1022,1020,1018,1017,1013,1007,1006,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000},
	{603, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000}
};

//////////////////////////////

new comptruck[10];
new matsfuravagos[1], matsfuragrove[1], matsfuraactek[1], matsfurarifa[1], matsfura[1];
new lsnewscar[6], lvnewscar[8], lvpdcar[21];//, rentmot[6];
new liccar[10], hotdogcar[2], taxicar[69],taxi5lvlcar[10],taxi10lvlcar[11],taxi40lvlcar[7], mehanik[13], rentcarvip[9], rentcarsf[7], rentcarls[9], rentcarlv[18], medicsls[10],medicsls1[6], medicslv[9],medicsfc[8];
new sapdcar[27], fbicar[17],cnncar[5],sfpdcar[29],medmav,mavlic,cnnmav,armycarsf[29], yakcar[15],ruscar[15],govcar[8], lcncar[15], medicssf[15],medicssf1[6], armcar[27], faggio[6], gunscar[NUMBER_OF_ARMYTRUCKS], grovecar[7], ballascar[7], coronoscar[7], vagoscar[7],rifacar[7];
new arenda[MAX_PLAYERS];
new lsacar[16], lsacarvert[1];
new hamccar[11], wmccar[11], pmccar[11];

//////////////////////////////

new ebanksf[MAX_PLAYERS];
new victim2[2];
new sportzal[2];
new racee[2];
new lspic[2];
new lvpic[2];
new rmpic[2];
new rmpick[2];
new rmpic2[2];
new addictionenter;
new addictionexit;
new lcnpic[4];
new yakexit[2];
new sfpdpic[4];
new pdd;
new buygunzakon[4];
new fbi[6];
new lspd[6];
new sf[6];
new lvpdpic[7];
new armijavhod;
new armijavihod;
new sms_timer[MAX_PLAYERS];
new marexit;
new marenter[3];
new bankpic[2];
new serdce[4];
new ballasvhod[2];
new rifa[2];
new vagospic[2];
new aztecpic[2];
new grooveexit;
new grooveenter;
new clothes,cashs;
new mushroom[2];
new skinshop[4];
new gunarm[2];
new zip[2];
new zona;
new zonaa;
new sklad[4];
new Float: PlayerArmor[MAX_PLAYERS];
new TeleportDestNoFloat[MAX_PLAYERS][2];

//////////////////////////////
new FarmStatPay[5][9];
new FarmStatPayS[5][9];
new FarmStatDay[5][9];
//
//-----------------------------

enum nInfo
{
	nLcn,
	nYakuza,
	nRm
}
enum frInfo
{
	fLsnews,
	fSfnews,
	fLvnews,
	fBallas,
	fVagos,
	fGrove,
	fAztek,
	fRifa,
	fKazna,
	fSsmc,
	fHamc,
	fOmc,
	fWmc,
	fHwmc,
	fFsmc,
	fPmc,
	fMmc,
	fVmc,
	fBmc
}
new MafiaBank[1][nInfo];
new FracBank[1][frInfo];
enum bInfo
{
	bID,
	bOwner[MAX_PLAYER_NAME],
	bMessage[128],
    Float:bEntranceX,
    Float:bEntranceY,
    Float:bEntranceZ,
    Float:bExitX,
    Float:bExitY,
    Float:bExitZ,
	bBuyPrice,
	bEntranceCost,
	bTill,
	bLandTax,
	bLocked,
	bInterior,
	bProducts,
    Text3D:bLabel,
	bPrice,
	bProdPrice,
    Float:bBarX,
    Float:bBarY,
    Float:bBarZ,
	bMafia,
	bCapture,
	bType,
	bPickup,
	bEnterPic,
	bExitPic,
	bLockTime,
	bLicense,
	bStavka,
	bNameStavka[50],
	bLastStavka,
	bTimeStavka,
	bMinStavka,
	bVirtualWorld
}
new BizzInfo[100][bInfo];
new BizzPay[100];
new BizzMaxProds[100];
new BizzLandTax[100];
new updatecheck[MAX_PLAYERS];
enum painfo
{
	paName[32],
	paKills,
	paDeaths
}
new PaintStats[15][painfo], Painlist = 0;
enum cainfo
{
    Float:callx,
    Float:cally,
    Float:callz,
	callused
}
new CallInfo[MAX_PLAYERS][cainfo];
//////////////////////////////
publics:ConvoiToPlayer(playerid)
{
	static AnimShot[MAX_PLAYERS];
	if(!IsPlayerConnected(Convoi[playerid]))
	{
		KillTimer(TimerForPlayer[playerid]);
		TimerForPlayer[playerid] = INVALID_PLAYER_ID;
		Convoi[playerid] = 9999;
		TogglePlayerControllable(playerid, 1);
		ClearAnimations(playerid);
		AnimShot[playerid] = false;
		return 1;
	}
	else if(!IsPlayerConnected(playerid))
	{
		SetPVarInt(Convoi[playerid], "TempConvoi", -1);
		KillTimer(TimerForPlayer[playerid]);
		TimerForPlayer[playerid] = INVALID_PLAYER_ID;
		AnimShot[playerid] = false;
		Convoi[playerid] = 9999;
		return 1;
	}
	else if(GetPlayerVirtualWorld(Convoi[playerid]) != GetPlayerVirtualWorld(playerid) || GetPlayerInterior(Convoi[playerid]) != GetPlayerInterior(playerid))
	{
		new Float: X, Float: Y, Float: Z;
		GetPlayerPos(Convoi[playerid], X, Y, Z);
		SetPlayerPos(playerid, X, Y, Z);
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(Convoi[playerid]));
		SetPlayerInterior(playerid, GetPlayerInterior(Convoi[playerid]));
		TogglePlayerControllable(playerid, 0);
		AnimShot[playerid] = false;
		return 1;
	}
	new Float:GotDistance = GetDistanceBetweenPlayers(playerid, Convoi[playerid]);
	if(GotDistance < 1.0)
	{
		TogglePlayerControllable(playerid, 0);
		SetPlayerToFacePlayer(playerid, Convoi[playerid]);
		AnimShot[playerid] = false;
		return 1;
	}
	else if(GotDistance > 3.5)
	{
		TogglePlayerControllable(playerid, 1);
		SetPlayerToFacePlayer(playerid, Convoi[playerid]);
		ApplyAnimation(playerid, "PED", "SPRINT_PANIC", 6.0, 1, 1, 1, 1, 0, 1);
		return 1;
	}
	else
	{
		TogglePlayerControllable(playerid, 1);
		SetPlayerToFacePlayer(playerid, Convoi[playerid]);
		ApplyAnimation(playerid, "ped", "WALK_civi", 6.0, 1, 1, 1, 1, 0, 1);
	}
	return 1;
}
publics:UnFreeze(playerid) return TogglePlayerControllable(playerid, 1);
publics:kekovich(playerid)
{
	if(updatecheck[playerid] == 9999) return true;
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(updatecheck[playerid], X, Y, Z);
	SetPlayerCheckpoint(playerid, X, Y, Z, 5);
	return true;
}
publics:IsVehicleOccupied(vehicleid)
{
	foreach(i)
	{
		if(IsPlayerInVehicle(i,vehicleid)) return i;
	}
	return -1;
}
publics:DiceOff()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(OpustitRuki[i] == 1)
		{
			OpustitRuki[i] = 0;
			if(IsPlayerAttachedObjectSlotUsed(i,1)) RemovePlayerAttachedObject(i,1);
		}
	}
}
publics:AddictionTimer(playerid) return SetPlayerWeather(playerid,10);
ShowPlayerDialogEx(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
	SetPVarInt(playerid, "USEDIALOGID", dialogid);
	return ShowPlayerDialog(playerid, dialogid, style,caption, info, button1, button2);
}
CaptureTextDraws(playerid)
{
	Capture[playerid] = CreatePlayerTextDraw(playerid,39.824317, 223.416671, "~y~kills~n~~n~~g~Rifa:~w~0~n~~r~Aztec:~w~0");
	PlayerTextDrawLetterSize(playerid,Capture[playerid], 0.372224, 1.372497);
	PlayerTextDrawTextSize(playerid,Capture[playerid], 300.405562, 60.833334);
	PlayerTextDrawAlignment(playerid,Capture[playerid], 1);
	PlayerTextDrawColor(playerid,Capture[playerid], -1);
	PlayerTextDrawSetShadow(playerid,Capture[playerid], 0);
	PlayerTextDrawSetOutline(playerid,Capture[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,Capture[playerid], 255);
	PlayerTextDrawFont(playerid,Capture[playerid], 3);
	PlayerTextDrawSetProportional(playerid,Capture[playerid], 1);
}
new Float:gInviteSpawns[4] = {222.3489, -8.5845, 1002.2109, 266.7302};
new LessonCar[MAX_PLAYERS];
new LessonStat[MAX_PLAYERS];
new pLessonCar[MAX_PLAYERS];
enum
{
	CHECKPOINT_1,
	CHECKPOINT_2,
	CHECKPOINT_3,
	CHECKPOINT_4,
	CHECKPOINT_5,
	CHECKPOINT_6,
	CHECKPOINT_7,
	CHECKPOINT_8,
	CHECKPOINT_9,
	CHECKPOINT_10,
	CHECKPOINT_11,
	CHECKPOINT_13,
	CHECKPOINT_14,
	CHECKPOINT_15,
	CHECKPOINT_16,
	CHECKPOINT_17,
	CHECKPOINT_18,
	CHECKPOINT_19,
	CHECKPOINT_20,
	CHECKPOINT_21,
	CHECKPOINT_22,
	CHECKPOINT_23,
	CHECKPOINT_24,
	CHECKPOINT_25,
	CHECKPOINT_26,
	CHECKPOINT_27,
	CHECKPOINT_28,
	CHECKPOINT_29,
	CHECKPOINT_30,
	CHECKPOINT_31,
	CHECKPOINT_32,
	CHECKPOINT_33,
	CHECKPOINT_34,
	CHECKPOINT_35,
	CHECKPOINT_36,
	CHECKPOINT_37,
	CHECKPOINT_38,
	CHECKPOINT_40,
	CHECKPOINT_41,
	CHECKPOINT_42,
	CHECKPOINT_43,
	CHECKPOINT_44,
	CHECKPOINT_45,
	CHECKPOINT_46,
	CHECKPOINT_47,
	CHECKPOINT_48,
	CHECKPOINT_49,
	CHECKPOINT_50,
	CHECKPOINT_51,
	CHECKPOINT_52,
	CHECKPOINT_53,
	CHECKPOINT_54,
	CHECKPOINT_55,
	CHECKPOINT_56,
	CHECKPOINT_57,
	CHECKPOINT_58,
	CHECKPOINT_59,
	CHECKPOINT_60,
	CHECKPOINT_61,
	CHECKPOINT_62,
	CHECKPOINT_63,
	CHECKPOINT_64,
	CHECKPOINT_65,
	CHECKPOINT_66,
	CHECKPOINT_67,
	CHECKPOINT_68,
	CHECKPOINT_69,
	CHECKPOINT_70,
	CHECKPOINT_71,
	CHECKPOINT_72,
	CHECKPOINT_73,
	CHECKPOINT_74,
	CHECKPOINT_75,
	CHECKPOINT_76,
	CHECKPOINT_77,
	CHECKPOINT_78,
	CHECKPOINT_79,
	CHECKPOINT_80,
	CHECKPOINT_81,
	CHECKPOINT_82,
	CHECKPOINT_83,
	CHECKPOINT_84,
	CHECKPOINT_85,
	CHECKPOINT_86,
	CHECKPOINT_87,
	CHECKPOINT_88,
	CHECKPOINT_89,
	CHECKPOINT_90,
	CHECKPOINT_91,
	CHECKPOINT_92,
	CHECKPOINT_93,
	CHECKPOINT_94,
	CHECKPOINT_95,
	CHECKPOINT_96,
	CHECKPOINT_97,
	CHECKPOINT_98,
	CHECKPOINT_99,
	CHECKPOINT_100,
	CHECKPOINT_101,
	CHECKPOINT_103,
	CHECKPOINT_104,
	CHECKPOINT_105,
	CHECKPOINT_106,
	CHECKPOINT_107,
	CHECKPOINT_108,
	CHECKPOINT_109,
	CHECKPOINT_110,
	CHECKPOINT_111,
	CHECKPOINT_112,
	CHECKPOINT_113,
	CHECKPOINT_114,
	CHECKPOINT_115,
	CHECKPOINT_116,
	CHECKPOINT_117,
	CHECKPOINT_118,
	CHECKPOINT_119,
	CHECKPOINT_120,
	CHECKPOINT_121,
	CHECKPOINT_122,
	CHECKPOINT_123,
	CHECKPOINT_124,
	CHECKPOINT_125,
	CHECKPOINT_126,
	CHECKPOINT_127,
	CHECKPOINT_128,
	CHECKPOINT_129,
	CHECKPOINT_130,
	CHECKPOINT_131,
	CHECKPOINT_132
}
//new PaintGun[] = {24,31,25,29,30,23};
new Float:PaintballSpawns[6][3] =
{
	{2563.6877,2807.0288,10.8203},
	{2554.0505,2837.7419,10.8203},
	{2585.6748,2848.5283,10.8203},
	{2598.7083,2843.5200,10.8203},
	{2546.7622,2830.9004,14.2559},
	{2575.9900,2839.3103,19.9922}
};
new paint_info[2];
//
new race_info[2];
enum rainfo
{
	rName[32],
	rCar
}
new RaceInfo[13][rainfo], RaceList = 0;
new RaceCar[] = {411,562,560,522};
new Float:RaceGonka[32][3] =
{
	{1504.0450,-2494.1909,13.2818},
	{1581.0055,-2494.1929,13.2818},
	{1670.5765,-2494.4583,13.2818},
	{1791.9033,-2494.0471,13.2818},
	{1933.1456,-2494.2715,13.2663},
	{2030.5284,-2494.5786,13.2665},
	{2092.1445,-2506.2756,13.2656},
	{2104.7827,-2561.6477,13.2741},
	{2029.8335,-2593.1196,13.2740},
	{1916.6111,-2592.9927,13.2740},
	{1786.7148,-2592.7122,13.2740},
	{1659.3461,-2593.0691,13.2740},
	{1516.1382,-2593.6577,13.2740},
	{1436.4548,-2574.5940,13.2740},
	{1417.7380,-2524.5232,13.2740},
	{1445.3351,-2497.3611,13.2818},
	{1504.0450,-2494.1909,13.2818},
	{1581.0055,-2494.1929,13.2818},
	{1670.5765,-2494.4583,13.2818},
	{1791.9033,-2494.0471,13.2818},
	{1933.1456,-2494.2715,13.2663},
	{2030.5284,-2494.5786,13.2665},
	{2092.1445,-2506.2756,13.2656},
	{2104.7827,-2561.6477,13.2741},
	{2029.8335,-2593.1196,13.2740},
	{1916.6111,-2592.9927,13.2740},
	{1786.7148,-2592.7122,13.2740},
	{1659.3461,-2593.0691,13.2740},
	{1516.1382,-2593.6577,13.2740},
	{1436.4548,-2574.5940,13.2740},
	{1417.7380,-2524.5232,13.2740},
	{1413.7960,-2467.0986,13.5547}
};
new Float:RaceSpawns[12][4] =
{
	{1488.8,-2481.6,13.2818,270.0},
	{1488.8,-2491.6,13.2818,270.0},
	{1488.8,-2501.6,13.2818,270.0},
	{1481.8,-2487.9,13.2818,270.0},
	{1481.8,-2497.9,13.2818,270.0},
	{1481.8,-2507.9,13.2818,270.0},
	{1474.8,-2483.6,13.2818,270.0},
	{1474.8,-2493.6,13.2818,270.0},
	{1474.8,-2503.6,13.2818,270.0},
	{1467.8,-2488.2,13.2818,270.0},
	{1467.8,-2498.2,13.2818,270.0},
	{1467.8,-2508.2,13.2818,270.0}
};
new rabotaMSG[12][] =
{
	{"Здесь вы можете подработать грузчиком\n"},
	{"\n"},
	{"В здании на против, вы найдете раздевалку,\n"},
	{"А так же кассу, где Вы будете получать деньги за работу.\n\n"},
	{"\n"},
	{"Чтобы начать работу, необходимо переодеться в рабочую форму.\n"},
	{"Далее, берите в вагоне мешок, и несите его на склад.\n"},
	{"За один мешок, Вам будут платить 25 вирт.\n"},
	{"\n"},
	{"Как только вы захотите завершить рабочий день,\n"},
	{"Пройдите к кассе.\n"},
	{"\n"}
};
new pdddialogMSG[13][] =
{
	{"<< 1. Общие правила >>\n\n"},
	{"Обгон транспортного средства разрешен только с левой стороны,\n"},
	{"при этом водители обязаны убедиться, что встречная полоса свободна на достаточном для обгона расстояние.\n"},
	{"При ДТП водители обязаны позвонить в полицию, и дождаться ДПС\n\n"},
	{"<< 2. Скорость движения >> \n\n"},
	{"В переделах города разрешается движение транспортных средств со скоростью не более 50 км/ч.\n"},
	{"В жилых зонах и на дворовых территориях не более 30 км/ч\n\n"},
	{"<< 3. Остановка и стоянка >>\n\n"},
	{"Остановка и стоянка транспортных средств разрешаются на правой стороне дороги на обочине.\n"},
	{"В специальных отведённых для этого местах\n\n"},
	{"<< 4. ДПС >> \n\n"},
	{"При виде автомобиля с включённой сереной, водитель обязан сбавить скорость и прижаться к обочине.\n"},
	{"Водитель обязан предъявить паспорт/лицензии, если тот попросил"}
};
new RulesMSG[17][] =
{
	{"1. Игровой процесс\n"},
	{"Запрещено:\n"},
	{"- Использование любых программ скриптов читов и.т.п. дающие нечестное преймущество в игре.\n"},
	{"- Использование багов (Ошибок, Неисправностей мода).\n"},
	{"- Использовать ESC в целях ухода от погони/смерти.\n"},
	{"- Убивать игроков на спавне (Место возрождения, базы организаций).\n"},
	{"- Убивать игроков при помощи транспорта (Давить, Стрелять с водительского места).\n"},
	{"- Убийство/нанесение физического вреда игрокам без причины (ДМ - Death Match).\n"},
	{"- Злоупотребление игровыми возможностями для создания неудобств игрокам.\n\n"},
	{"2. Ник в игре:\n"},
	{"- (сменить ник можно через /mm >> Сменить ник)\n"},
	{"- Ник должен состоять из Имени_Фамилии с заглавных букв.\n"},
	{"Запрещено:\n"},
	{"- Запрещено использовать чужие (уже кем-то занятые) ники.\n"},
	{"- Запрещено использовать ники, содержащие нецензурные или оскорбительные слова.\n"},
	{"- Отправлять более одной заявки в час (Исключение: Просьба Администрации).\n"},
	{"- Если вам отказали в смене ника, Значит нельзя.\n"}
};
new RulesMSGG[22][] =
{
	{"3. Чат:\n"},
	{"- OOC (Out Of Charter) - это всё, что касается реального мира.\n"},
	{"- IC (In Charter) - это всё, что касается виртульного мира, то есть игры.\n"},
	{"Запрещено:\n"},
	{"- Ругательство, оскорбления или нецензурная речь.\n"},
	{"- Угрозы игрокам (Не относящиеся к игровому процессу).\n"},
	{"- Писать сообщения в верхнем регистре (Caps Lock).\n"},
	{"- Писать в чат объявлений сообщения не относящихся к Role Play.\n"},
	{"- Писать одно и тоже сообщение слишком часто.\n"},
	{"- Обсуждать, критиковать действия администрации.\n"},
	{"- Реклама сторонних ресурсов.\n\n"},
	{"4. Администрация сервера:\n"},
	{"- Необходимо сообщать администрации о каких либо нарушениях из данных правил (/mm > Репорт).\n"},
	{"- Администрация самостоятельно выбирает штрафные санкции для каждого из случаев.\n"},
	{"- Запрещено препятствовать администрации в работе.\n"},
	{"- Решение администрации является окончательным и не подлежит обсуждению.\n\n"},
	{"5. Торговля:\n"},
	{"- Запрещены любые денежные махинации.\n"},
	{"- Запрещена продажа / покупка чего либо, за реальные деньги.\n"},
	{"- Запрещен обмен внеигровых предметов в любой форме, на игровые.\n"},
	{"- Запрещен обмен чего либо между игровыми серверами.\n"},
	{"- Запрещена продажа / передача аккаунтов.\n"}
};
enum carInfo
{
	carID[5],
	carModel[5],
	carColor_one[5],
	carColor_two[5],
	carPercent[5],
    Float:carFuel[5],
	carVehcom_1[5],
	carVehcom_2[5],
	carVehcom_3[5],
	carVehcom_4[5],
	carVehcom_5[5],
	carVehcom_6[5],
	carVehcom_7[5],
	carVehcom_8[5],
	carVehcom_9[5],
	carVehcom_10[5],
	carVehcom_11[5],
	carVehcom_12[5],
	carVehcom_13[5],
	carVehcom_14[5]
}
new CarInfo[MAX_PLAYERS][carInfo];
enum pInfo
{
	pName[50],
	pKey[128],
	pChas,
	pMin,
	pLogin,
	pEmail[128],
	pLevel,
	pAdmin,
	pHelper,
	pRatingSupport,
	pJobHeal,
	pJobHealLeader,
	pMestoJail,
	pIp[128],
	pvIp[128],
	pIpReg[128],
	pHousecash,
	pCheckip,
	pGoogleKey[17],
	pGoogleIP,
	pText,
	pKeyip[128],
    Float:pHP,
    Float:pArmour,
	pKeys,
	pPKeys,
	pSatiety,
	pDataReg[128],
	pDonateRank,
	pMats,
	pSex,
	pArrested,
	pMuted,
	pCrimes,
	pExp,
	pCash,
	pWantedDeaths,
	pPayCheck,
	pJailTime,
	pDrugs,
	pLeader,
	pMember,
	pRank,
	pChar[6],
	pChars[32],
	pJob,
	pModel,
	pPnumber,
	pDirectory,
	pVhoddata,
	pVhodMes,
	pVhodchas,
	pVhodminute,
	pCarLic,
	pFlyLic,
	pBoatLic,
	pFishLic,
	pGunLic,
	pBizLic,
	pNkeys,
	pAvtomas,
	pZakonp,
	pAddiction,
	pNarcoLomka,
	pPayDayHad,
	pTut,
	pWarns,
	OffWarns,
	punWarns,
	pFuel,
	pMarriedTo[128],
	pDrug[128],
	pMushrooms,
    Float:pFishes,
	pFishesPach,
	pBank,
	pDonateAccount,
	pMobile,
	pDolg,
	pKrisha,
	pUseKrisha,
	pWantedLevel,
	pWeapon[11],
	pWeapons[32],
	pAmmo[11],
	pAmmos[32],
	pGunSkill[6],
	pGunSkills[32],
	ptaxiexp,
	ptaxilvl,
	pTraining,
	pBoxSkill,
	pKongfuSkill,
	pKickboxSkill,
	pDLevel,
	pDExp,
	pKvartiraKey,
	pPHouseKey,
	pPBizzKey,
	pPFarmKey,
	pPLimitBank,
	pDMgruz,
	pPSkill,
	pPProc,
	pPMGruz,
	pQuestL,
	pQuest,
	pQuestP,
	pQuestF,
	pQuestPF,
	pQuestShow,
	pDgruz,
	pOnline[128],
	pOnlineLid[128],
    Float:pPos_x,
    Float:pPos_y,
    Float:pPos_z,
	pSkilla,
	pRecognition,
	pRobHouse,
	pActivemail,
	SalonCar,
	SalonTime,
	pDrivingSkill,
	pProdsSkill[2],
	pSpawnChange[2],
	bool:progolos,
	pGRating
}
new PTEMP[MAX_PLAYERS][pInfo];
#define Name(%1) PTEMP[%1][pName]

SetPlayerCheckpointEx(playerid,Float:x,Float:y,Float:z,Float:r)
{
	SetPVarInt(playerid,"checkpoint",1);
	return SetPlayerCheckpoint(playerid,x,y,z,r);
}
DisablePlayerCheckpointEx(playerid)
{
	DeletePVar(playerid,"checkpoint");
	return DisablePlayerCheckpoint(playerid);
}
#define SetPlayerCheckpoint SetPlayerCheckpointEx
#define DisablePlayerCheckpoint DisablePlayerCheckpointEx

ResetPlayerWeaponsEx(playerid)
{
	for(new i = 1; i < 46; i++) Weapons[playerid][i] = 0;
	ResetPlayerWeapons(playerid);
	SetTimerEx("AntiNopResetPlayerWeapon" , 3000, false, "i", playerid);
}
PutPlayerInVehicleEx(playerid,vehicleid,seatid)
{
	vehicleidtp[playerid] = vehicleid;
	PutPlayerInVehicle(playerid,vehicleid,seatid);
}
t_SetPlayerPos( playerid, Float:x, Float:y, Float:z )
{
	SetPVarInt(playerid, "AntiBreik", 2);
	PTEMP[ playerid ][ pPos_x ] = x;
	PTEMP[ playerid ][ pPos_y ] = y;
	PTEMP[ playerid ][ pPos_z ] = z;
	return SetPlayerPos( playerid, x, y, z );
}
new Float:car_coord[MAX_VEHICLES][4], bool:car_ex[MAX_VEHICLES];

t_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z)
{
	foreach(i)
	{
		if(IsPlayerInVehicle(i, vehicleid))
		{
			SetPVarInt(i, "AntiBreik", 2);
			PTEMP[ i ][ pPos_x ] = x;
			PTEMP[ i ][ pPos_y ] = y;
			PTEMP[ i ][ pPos_z ] = z;
		}
	}
	car_coord[vehicleid][0] = x;
	car_coord[vehicleid][1] = y;
	car_coord[vehicleid][2] = z;
	car_ex[vehicleid] = true;
	return SetVehiclePos(vehicleid, x, y, z);
}
#define SetPlayerPos t_SetPlayerPos
#define SetVehiclePos t_SetVehiclePos
enum PickInfo
{
    Float: PickX,
    Float: PickY,
    Float: PickZ
}
new PickupInfo[MAX_PICKUPS][PickInfo];

CreatePickupAC(model, type, Float:X, Float:Y, Float:Z, virtualworld = 0)
{
	new TempID = CreateDynamicPickup(model, type, X, Y, Z, virtualworld);
	PickupInfo[TempID][PickX] = X;
	PickupInfo[TempID][PickY] = Y;
	PickupInfo[TempID][PickZ] = Z;
	return TempID;
}
#define CreatePickup CreatePickupAC
/***************************** АНТИЧИТ НА СПАВН КАРОВ ***********************/
CreateVehicleAC(model, Float:x,Float:y,Float:z,Float:r, c, c_, spawn, siren = 0)
{
	new TempID = CreateVehicle(model,x,y,z,r,c,c_,spawn, siren);
	car_ex[TempID] = true;
	car_coord[TempID][0] = x;
	car_coord[TempID][1] = y;
	car_coord[TempID][2] = z;
	car_coord[TempID][3] = r;
	return TempID;
}
#define CreateVehicle CreateVehicleAC

SetVehicleZAngleEx(vehicleid,Float:z)
{
	SetVehicleZAngle(vehicleid,z);
	car_ex[vehicleid] = true;
	car_coord[vehicleid][3] = z;
	return true;
}
#define SetVehicleZAngle SetVehicleZAngleEx
/******************************************************************************/
publics: kick(giveplayerid)
{
	if(PTEMP[giveplayerid][pLogin] == 1) SaveMySQL(2, giveplayerid);
	Kick(giveplayerid);
	return false;
}
#define Kick(%0) SetTimerEx("kick", 70, false, "i", %0)

enum hInfo
{
    Float:hEntrancex,
    Float:hEntrancey,
    Float:hEntrancez,
    Float:hExitx,
    Float:hExity,
    Float:hExitz,
    Float:hCarx,
    Float:hCary,
    Float:hCarz,
    Float:hCarc,
	hOwner[MAX_PLAYER_NAME],
	hValue,
	hHel,
	hInt,
	hLock,
	hTakings,
	hDate,
	hKlass,
	hVec,
	hVcol1,
	hVcol2,
	hPickup,
	hMIcon,
	hVehSost,
	hSafe[11],
	hSafes[128],
	hID,
    Text3D:hExitText
}
new HouseInfo[990][hInfo];
new global[MAX_PLAYERS];
new podeezdi;
new exitpodeezd;
new podeezdils;
// *************************** Система квартир Samp-Rp **************************
enum podInfo
{
	pid,
    Float:podPicX,
    Float:podPicY,
    Float:podPicZ,
	podEtazi,
	podInt,
	podMir[11],
	podPic,
    Float:carX,
    Float:carY,
    Float:carZ,
    Float:carC
}
new PodeezdInfo[1000][podInfo], AllPODEZD, ALLPODEZD;
enum kInfo
{
	kid,
    Float:pXpic,
    Float:pYpic,
    Float:pZpic,
	vladelec[MAX_PLAYER_NAME],
    Text3D:dtext,
	lock,
	kworld,
	aptek,
	plata,
	kCena,
	kInt,
	virtmir
}
new kvartinfo[1000][kInfo], ALLKVARTIRI;
enum pHaul
{
	pLoad
}
enum sHaul
{
	sLoad
}
enum pMatss
{
	gBallas,
	gVagos,
	gGrove,
	gAztek,
	gRifa
}
new Furi[1][pMatss];
new maxMats[pMatss];
enum pMat
{
	mCapasity,
	mLoad
}
new MatHaul[NUMBER_OF_ARMYTRUCKS][pMat];
new PlayerHaul[18][pHaul];
new PlayersHaul[10][sHaul];
enum pCrime
{
	pAccusedof[32],
	pVictim[32]
}
new PlayerCrime[MAX_PLAYERS][pCrime];
new JoinPed[] = // = 110
{
    // LSPD 1-8
	280, 281, 282, 283, 284, 285, 288, 76,
	// FBI 1-6
	286, 163, 164, 165, 166, 141,
	// SFA 1-2
	287, 191,
	// Mediks 1-5
	70, 274, 275, 276, 219,
	// LCN 1-4
    223, 124, 113, 214,
	// YAKUZA 1-4
	120, 123, 169, 186,
	// Goverment 1-5
	57, 150, 98, 187, 147,
	// SFPD 1-8
	280, 281, 282, 283, 284, 285, 288, 76,
	// SFN 1-4
	250, 261, 211, 217,
	// Casino 1-2
	171, 11,
	// Instructors 1-4
	59, 172, 189, 240,
	// LVPD 1-8
	280, 281, 282, 283, 284, 285, 288, 76,
	// Russian Mafia 1-5
	112, 111, 125, 272, 214,
	// Groove 1-6
	105, 106, 107, 269, 270, 271,
	// Aztecas 1-3
	114, 115, 116,
	// Ballas 1-3
	102, 103, 104,
	// Rifa 1-3
	173, 174, 175,
	// Vagos 1-3
    108, 109, 110,
	// LVA 1-2
	287, 191,
	// LSN 1-4
	250, 261, 211, 217,
	// Ped 1-16
	287, 287, 191, 287, 287, 191, 287, 200, 230, 137, 212, 79, 78, 96, 90, 55,
	// Bikers 1-5
	247, 248, 254, 298, 201
};
new FishNames[18][20] =
{
	{"Камболу"},
	{"Скумбрия"},
	{"Карась"},
	{"Форель"},
	{"Треска"},
	{"Горбыль"},
	{"Красноперка"},
	{"Щука"},
	{"Парус"},
	{"Тунец"},
	{"Ель"},
	{"Дельфин"},
	{"Окула"},
	{"Черепаха"},
	{"Сом"},
	{"Рыба-меч"},
	{"Катран"},
	{"Сайда"}
};
new GribNames[3][20] =
{
	{"Белый"},
	{"Мухомор"},
	{"Гроздь"}
};
publics: NoNalog(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	new leader = PTEMP[playerid][pLeader];
	new member = PTEMP[playerid][pMember];
	new job = PTEMP[playerid][pJob];
	new krish = PTEMP[playerid][pKrisha];
	if(member == 5 || member == 6 || member == 12 || member==13 || member == 14|| member == 15|| member == 17 || member == 18 || member == 23 || member == 24 || member == 25 || member == 26 || member == 22 || member == 28 || member == 29 || member == 30 || member == 31 || member == 33) return true;
	if(leader == 5 || leader == 6 || leader == 12 || leader==13 || leader == 14|| leader == 15|| leader == 17 || leader == 18 || leader == 23 || leader == 24 || leader == 25 || leader == 26 || leader == 22 || leader == 28 || leader == 29 || leader == 30 || leader == 31 || leader == 33) return true;
	if(member==0 && job == 0) return true;
	if(member==0 && krish > 0) return true;
	return false;
}
publics: IsASafe(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	if(PlayerToPoint(2.0,playerid,230.39050, 1074.91089, 1084.22534) ||
        PlayerToPoint(2.0,playerid,247.94943, 1118.25439, 1080.44409) ||
        PlayerToPoint(2.0,playerid,94.42898, 1331.83606, 1088.04138) ||
        PlayerToPoint(2.0,playerid,147.13652, 1369.42163, 1088.24805) ||
        PlayerToPoint(2.0,playerid,2339.87964, -1143.09265, 1054.03723) ||
        PlayerToPoint(2.0,playerid,228.54663, 1202.83069, 1080.44629) ||
        PlayerToPoint(2.0,playerid,257.16074, 1243.07251, 1084.11511) ||
        PlayerToPoint(2.0,playerid,20.01370, 1409.36584, 1084.25842) ||
        PlayerToPoint(2.0,playerid,484.40237, 1398.02075, 1080.37439) ||
        PlayerToPoint(2.0,playerid,376.05988, 1414.69226, 1081.01965) ||
        PlayerToPoint(2.0,playerid,377.13617, 1468.84985, 1080.19617) ||
        PlayerToPoint(2.0,playerid,292.74359, 1471.77417, 1080.11719) ||
        PlayerToPoint(2.0,playerid,2457.05884, -1701.78662, 1013.04858) ||
        PlayerToPoint(2.0,playerid,-44.66017, 1403.76001, 1084.56116) ||
        PlayerToPoint(2.0,playerid,-72.16850, 1359.06702, 1080.08374) ||
        PlayerToPoint(2.0,playerid,-272.09415, 1454.00806, 1084.17139) ||
        PlayerToPoint(2.0,playerid,258.62341, 1285.05847, 1080.10437) ||
        PlayerToPoint(2.0,playerid,443.57379, 1397.04810, 1084.39709) ||
        PlayerToPoint(2.0,playerid,422.28943, 2539.07520, 9.84995) ||
        PlayerToPoint(2.0,playerid,274.48193, 303.70056, 998.57611) ||
        PlayerToPoint(2.0,playerid,250.11301, 301.71036, 998.65039) ||
        PlayerToPoint(2.0,playerid,228.62782, 1285.73279, 1081.87048) ||
        PlayerToPoint(2.0,playerid,225.97635, 1238.43115, 1081.76917) ||
        PlayerToPoint(2.0,playerid,220.46881, 1286.62891, 1082.49561) ||
        PlayerToPoint(2.0,playerid,2230.42480, -1109.80933, 1051.33984) ||
        PlayerToPoint(2.0,playerid,228.83421, 1154.15857, 1083.08423) ||
        PlayerToPoint(2.0,playerid,2212.18799, -1073.90381, 1051.21570) ||
        PlayerToPoint(2.0,playerid,335.99869, 1476.61987, 1084.93628) ||
        PlayerToPoint(2.0,playerid,2263.10010, -1220.13806, 1049.82166) ||
        PlayerToPoint(2.0,playerid,2813.21899, -1166.67578, 1026.27979) ||
        PlayerToPoint(2.0,playerid,2245.88379, -1070.92590, 1049.95911) ||
        PlayerToPoint(2.0,playerid,2368.42041, -1119.34619, 1051.42432) ||
        PlayerToPoint(2.0,playerid,2328.59790, -1016.68817, 1055.17456) ||
        PlayerToPoint(2.0,playerid,225.63176, 1039.91479, 1085.00623) ||
        PlayerToPoint(2.0,playerid,147.42175, 1365.36816, 1084.83923))
	{
		return true;
	}
	return false;
}
publics:IsAMafia(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	new leader = PTEMP[playerid][pLeader];
	new member = PTEMP[playerid][pMember];
	if(member == 5 || member == 6 || member == 14) return true;
	if(leader == 5|| leader == 6 || leader == 14) return true;
	return false;
}
publics:IsABiker(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	new leader = PTEMP[playerid][pLeader];
	new member = PTEMP[playerid][pMember];
	if(member==24 || member==26 || member==29) return true;
	if(leader==24 || leader==26 || leader==29) return true;
	return false;
}
publics:IsAGang(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	new leader = PTEMP[playerid][pLeader];
	new member = PTEMP[playerid][pMember];
	if(member==12 || member==13 || member==15 || member==17 || member==18) return true;
	if(leader==12 || leader==13 || leader==15 || leader==17 || leader==18) return true;
	return false;
}
new Peds[57][1] =
{
	{79},
	{254},{259},{249},{248},{247},{242},{239},{228},
	{185},{184},{160},{155},{135},{126},{122},{121},{101},
	{100},{96},{82},{83},{84},{294},{94},{73},{67},
	{28},{29},{24},{23},{22},{21},
	{20},{19},{18},{17},{15},
	{7},{2},{299},{297},{296},{293},{46},
	{198},{197},{196},
	{190},{193},{243},{178},{192},{199},{201},{214},
	{224}
};
publics:PrintBizInfo(playerid,targetid)
{
	new mafiatext[10];
	switch(BizzInfo[targetid][bMafia])
	{
	case 5: mafiatext = "LCN"; case 6: mafiatext = "Yakuza";
	case 14: mafiatext = "RM"; default: mafiatext = "Нет";
	}
	format(string,304, "Название\t\t%s\nМафия\t\t\t%s\nБаланс\t\t\t%i вирт\nПрибыль за час\t%i вирт\nПродукты\t\t%i/%i\nЦена за товар\t\t%i вирт\nЦена за продукт\t%i вирт\nЦена за вход\t\t%i вирт\nСостояние\t\t%s\nЭлектроенергия\t%i/96000 вирт\nНалог за электроэнергию: %i вирт\nЛицензия\t%s\nЧасов закрыт/без продуктов: %i",
	BizzInfo[targetid][bMessage],mafiatext,BizzInfo[targetid][bTill],BizzPay[targetid],BizzInfo[targetid][bProducts],BizzMaxProds[targetid],BizzInfo[targetid][bPrice],BizzInfo[targetid][bProdPrice],BizzInfo[targetid][bEntranceCost],(!BizzInfo[targetid][bLocked])?("Открыт") : ("Закрыт"),BizzInfo[targetid][bLandTax],BizzLandTax[targetid],(!BizzInfo[targetid][bLicense])?("Нет") : ("Есть"),BizzInfo[targetid][bLockTime]);
	return ShowPlayerDialogEx(playerid,10349,DIALOG_STYLE_LIST, "Статистика бизнеса",string, "Закрыть", "");
}
BuyHouse(h)
{
	DestroyDynamicMapIcon(HouseInfo[h][hMIcon]);
	DestroyDynamicPickup(HouseInfo[h][hPickup]);
	DestroyDynamic3DTextLabel(HouseInfo[h][hExitText]);
	HouseInfo[h][hExitText] = CreateDynamic3DTextLabel("Чтобы выйти, нажмите клавишу '~k~~VEHICLE_ENTER_EXIT~'\nКупить/продать, нажмите клавишу '~k~~SNEAK_ABOUT~'",0x0076FCFF,HouseInfo[h][hExitx],HouseInfo[h][hExity],HouseInfo[h][hExitz]+1,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,h+50);
	if(strcmp(HouseInfo[h][hOwner],"None",true) == 0)
	{
		HouseInfo[h][hPickup] = CreatePickup(1273, 23, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez],-1);
		HouseInfo[h][hMIcon] = CreateDynamicMapIcon(HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez], 31, -1, 0, -1, -1,150);
	}
	else
	{
		HouseInfo[h][hPickup] = CreatePickup(1272, 23, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez],-1);
		HouseInfo[h][hMIcon] = CreateDynamicMapIcon(HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez], 32, -1, 0, -1, -1,150);
	}
	return true;
}
Vehicleforeach(vehicleid)
{
	foreach(i)
	{
		if(house_car[i] == vehicleid) return i;
	}
	return -1;
}
publics:HPCheck()
{
	foreach(i)
	{
		if(PTEMP[i][pLogin] == 0) continue;
		GetVehicleParamsEx(GetPlayerVehicleID(i),engine,lights,alarm,doors,bonnet,boot,objective);
		if(!IsAPlane(GetPlayerVehicleID(i)) && !IsABoat(GetPlayerVehicleID(i)) && !IsABike(GetPlayerVehicleID(i)) && IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER && engine == 1)
		{
		    new h = GetPVarInt(i, "chosencar");
			if(Vehicleforeach(GetPlayerVehicleID(i)) != -1)
			{
				if(GetVehicleModel(GetPlayerVehicleID(i)) >= ShopCar[0][0] && GetVehicleModel(GetPlayerVehicleID(i)) <= ShopCar[56][0])
				{
					switch(CarInfo[Vehicleforeach(GetPlayerVehicleID(i))][carPercent][h])
					{
					case 51..100: Fuell[GetPlayerVehicleID(i)] -= 1.0000;
					case 5..50: Fuell[GetPlayerVehicleID(i)] -= 2.0000;
					default: Fuell[GetPlayerVehicleID(i)] -= 4.0000;
					}
				}
				else
				{
					switch(CarInfo[Vehicleforeach(GetPlayerVehicleID(i))][carPercent][h])
					{
					case 51..100: Fuell[GetPlayerVehicleID(i)] -= 2.0000;
					case 5..50: Fuell[GetPlayerVehicleID(i)] -= 4.0000;
					default: Fuell[GetPlayerVehicleID(i)] -= 8.0000;
					}
				}
				CarInfo[Vehicleforeach(GetPlayerVehicleID(i))][carFuel][h] = Fuell[GetPlayerVehicleID(i)];
			}
			else Fuell[GetPlayerVehicleID(i)] -= 1.0000;
		}
		new Float:health;
		GetPlayerHealth(i,health);
		//if(PTEMP[i][pTut] != 0 && health <= 10.0) SCM(i, COLOR_YELLOW, " У вас сильно ухудшилось здоровье, вылечитесь у медика!");
		if(PTEMP[i][pSatiety] > 0) PTEMP[i][pSatiety] -= 1;
		if(PTEMP[i][pSatiety] == 49 || PTEMP[i][pSatiety] == 24) SCM(i,COLOR_LIGHTGREEN, " Вы проголодались! Посетите бар, закусочную или купите ХотДог. Узнать свою «Сытость» можно командой /satiety");
		if(PTEMP[i][pSatiety] < 50) SetPlayerHealthAC(i, health - 1.0);
		else if(PTEMP[i][pSatiety] < 25) SetPlayerHealthAC(i, health - 2.0);
		PTEMP[i][pMin]++;
		if(PTEMP[i][pMin] >= 60) PTEMP[i][pChas]++, PTEMP[i][pMin] = 0;
	}
	return true;
}
DollahScoreUpdate(playerid) return SetPlayerScore(playerid, PTEMP[playerid][pLevel]);
GivePlayerPPCash(playerid, money)
{
	PCash[playerid] = PCash[playerid] + money;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,PCash[playerid]);
	return PCash[playerid];
}
Float:GetDistanceBetweenPlayers(p1, p2)
{
	new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2;
	if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2)) return -1.00;
	GetPlayerPos(p1, x1, y1, z1);
	GetPlayerPos(p2, x2, y2, z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
publics:MyHttpResponse(index, response_code, data[])
{
    // Запрос успешен (да/нет) ?
    if (response_code == 200) SCM(index, COLOR_YELLOW, " На текущий E-mail отправлен код подтверждения");
    else SCM(index, COLOR_GREY, " Произошла ошибка в отправке!");
}
publics:MyHttpResponse2(index, response_code, data[])
{
    // Запрос успешен (да/нет) ?
    if (response_code == 200) SCM(index, COLOR_YELLOW, " Новый пароль выслан на E-mail");
    else SCM(index, COLOR_GREY, " Произошла ошибка в отправке!");
}

#include "..\gamemodes\default\OnPlayerClickMap.pwn"
#include "..\gamemodes\default\OnPlayerEnterVehicle.pwn"

publics:IsAMedic(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	new leader = PTEMP[playerid][pLeader];
	new member = PTEMP[playerid][pMember];
	if(member == 4 || member == 22 || member == 23 || member == 33) return true;
	else if(leader == 4 || leader == 22 || leader == 23 || leader == 33) return true;
	return false;
}
publics:IsAMayor(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	new leader = PTEMP[playerid][pLeader];
	new member = PTEMP[playerid][pMember];
	if(member == 7 || leader == 7) return true;
	return false;
}
publics:IsALicenser(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	new leader = PTEMP[playerid][pLeader];
	new member = PTEMP[playerid][pMember];
	if(member == 11 || leader == 11) return true;
	return false;
}
publics:IsACop(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	new leader = PTEMP[playerid][pLeader];
	new member = PTEMP[playerid][pMember];
	if(member == 1 || member == 2 || member == 10 || member == 21) return true;
	else if(leader == 1 || leader == 2 || leader == 10 || leader == 21) return true;
	return false;
}
publics:IsAArm(playerid)
{
	if(!IsPlayerConnected(playerid)) return false;
	new leader = PTEMP[playerid][pLeader];
	new member = PTEMP[playerid][pMember];
	if(member == 3 || member == 19) return true;
	else if(leader == 3 || leader == 19) return true;
	return false;
}
IsAAntidm(playerid)
{
	if(PlayerToPoint(90.0,playerid,1154.3456,-1769.5636,16.5938)
			||PlayerToPoint(50.0,playerid,829.0444,5.0235,1004.1870)
			||PlayerToPoint(70.0,playerid,1480.9207,-1747.6909,15.3086)
			||PlayerToPoint(10.0,playerid,263.6395,78.5962,1001.0391)
			||PlayerToPoint(35.0,playerid,-2036.2848,-112.6223,496.5230)
			||PlayerToPoint(50.0,playerid,1310.2367,-1369.0114,13.5568)
			||PlayerToPoint(50.0,playerid,2850.9866,1291.0491,11.3906)
			||PlayerToPoint(70.0,playerid,-1967.6156,117.4343,27.6875)
			||PlayerToPoint(100.0,playerid,1995.1815,1017.2842,994.8906)
			||PlayerToPoint(100.0,playerid,2238.6624,1631.8488,1008.3594)
			||PlayerToPoint(60.0,playerid,1545.7631,-1290.8684,15.9647)
			||PlayerToPoint(60.0,playerid,1130.5286,-1.7705,1000.6797)
			||PlayerToPoint(70.0,playerid,2215.5352,-1157.3821,25.7266)
			||PlayerToPoint(70.0,playerid,370.5885,173.6026,1008.3828)
			||PlayerToPoint(70.0,playerid,1779.3578,-1912.4808,13.3888))
	{
		return true;
	}
	return false;
}
IsATerra(playerid)
{
	if(PTEMP[playerid][pMember] == 12 && PlayerToPoint(20.0,playerid,2651.4746,-2004.3387,13.3828) // Ballas
			||PTEMP[playerid][pMember] == 13 && PlayerToPoint(20.0,playerid,2770.7471,-1628.7227,12.1775) // Vagos
			||PTEMP[playerid][pMember] == 15 && PlayerToPoint(20.0,playerid,2492.7532,-1676.3687,13.3380) // Groove
			||PTEMP[playerid][pMember] == 17 && PlayerToPoint(20.0,playerid,1668.5664,-2112.9648,13.5469) // Aztecas
			||PTEMP[playerid][pMember] == 18 && PlayerToPoint(20.0,playerid,2184.1218,-1803.6334,13.3693)) return true; // Rifa
	else return false;
}
IsAMedKit(playerid)
{
	if(PTEMP[playerid][pMember] == 12 && PlayerToPoint(20.0,playerid,-61.2984,1364.5847,1080.2109) // Ballas Base
			||PTEMP[playerid][pMember] == 13 && PlayerToPoint(20.0,playerid,2794.1233,-1607.5570,-36.5231) // Vagos Base
			||PTEMP[playerid][pMember] == 15 && PlayerToPoint(20.0,playerid,2496.0129,-1708.9232,1014.7422) // Groove Base
			||PTEMP[playerid][pMember] == 17 && PlayerToPoint(20.0,playerid,-49.7558,1400.3553,1084.4297) // Aztecas Base
			||PTEMP[playerid][pMember] == 18 && PlayerToPoint(20.0,playerid,2808.9631,-1169.0806,1025.5703) // rifa
			||PTEMP[playerid][pMember] == 5 && PlayerToPoint(70.0,playerid,1265.7104,-793.7453,1084.0078) && GetPlayerVirtualWorld(playerid) == 2
			||PTEMP[playerid][pMember] == 6 && PlayerToPoint(70.0,playerid,1265.7104,-793.7453,1084.0078) && GetPlayerVirtualWorld(playerid) == 0
			||PTEMP[playerid][pMember] == 14 && PlayerToPoint(70.0,playerid,1235.7234,-823.1919,1083.1563) && GetPlayerVirtualWorld(playerid) == 1) return true;
	else return false;
}
IsARespawn(playerid)
{
	if(PlayerToKvadrat(playerid,1642.71, -2174.57, 1770.71, -2073.57)
	|| PlayerToKvadrat(playerid,2538.71, -2073.57, 2794.71, -1972.57)
	|| PlayerToKvadrat(playerid,2154.71, -1871.57, 2282.71, -1770.57)
	|| PlayerToKvadrat(playerid,2410.71, -1770.57, 2666.71, -1669.57)
	|| PlayerToKvadrat(playerid,2666.71, -1669.57, 2794.71, -1568.57))
	{
		return true;
	}
	return false;
}
IsABank(playerid)
{
	if(GetPVarInt(playerid, "in_bank")) return true;
	/*
    if(PlayerToPoint(10.0,playerid,2307.65,-15.7474,26))
	{
		return true;
	}
    */
	return false;
}
IsPlayerNearVehicle(playerid, vehicleid, Float:range)
{
    new Float:X, Float:Y, Float:Z;
    GetVehiclePos(vehicleid, X, Y, Z);
    if(IsPlayerInRangeOfPoint(playerid, range, X, Y, Z))return true;
    else return false;
}
IsNearOurCar(playerid)
{
	if(//IsPlayerNearVehicle(playerid, house_car[playerid], 3.0)
	IsPlayerNearVehicle(playerid, CarInfo[playerid][carID][0], 3.0)
	||IsPlayerNearVehicle(playerid, CarInfo[playerid][carID][1], 3.0)
	||IsPlayerNearVehicle(playerid, CarInfo[playerid][carID][2], 3.0)
	||IsPlayerNearVehicle(playerid, CarInfo[playerid][carID][3], 3.0)
	||IsPlayerNearVehicle(playerid, CarInfo[playerid][carID][4], 3.0))
	{
		return true;
	}
	return false;
}
IsAFoods(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2, -2420.219, 984.578, 44.297)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2420.180, 985.945, 44.297)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2225.203, -1153.422, 1025.906)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2576.703, -1284.430, 1061.094)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2155.906, 1606.773, 1000.055)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2209.906, 1607.195, 1000.055)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2222.203, 1606.773, 1000.055)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 495.969, -24.320, 1000.734)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 501.828, -1.430, 1000.734)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 373.828, -178.141, 1000.734)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 330.680, 178.500, 1020.070)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 331.922, 178.500, 1020.070)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 350.906, 206.086, 1008.477)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 361.563, 158.617, 1008.477)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 371.594, 178.453, 1020.070)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 374.891, 188.977, 1008.477)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2155.844, 1607.875, 1000.063)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2202.453, 1617.008, 1000.063)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2209.242, 1621.211, 1000.063)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2222.367, 1602.641, 1000.063)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 500.563, -1.367, 1000.734)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 379.039, -178.883, 1000.734)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2480.86,-1959.27,12.9609)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1634.11,-2237.53,12.8906)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2139.52,-1161.48,23.3594)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2153.23,-1016.15,62.2344)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -1350.12,493.859,10.5859)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2229.19,286.414,34.7031)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1659.46,1722.86,10.2188)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2647.7,1129.66,10.2188)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2845.73,1295.05,10.7891)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1398.84,2222.61,10.4219)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -1455.12,2591.66,55.2344)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -76.0312,1227.99,19.125)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 662.43,-552.164,15.7109)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -253.742,2599.76,62.2422)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2271.73,-76.4609,25.9609)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1789.21,-1369.27,15.1641)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1729.79,-1943.05,12.9453)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2060.12,-1897.64,12.9297)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1928.73,-1772.45,12.9453)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2325.98,-1645.13,14.2109)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2352.18,-1357.16,23.7734)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1154.73,-1460.89,15.1562)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -1350.12,492.289,10.5859)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2118.97,-423.648,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2118.62,-422.414,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2097.27,-398.336,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2092.09,-490.055,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2063.27,-490.055,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2005.65,-490.055,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2034.46,-490.055,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2068.56,-398.336,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2039.85,-398.336,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2011.14,-398.336,34.7266)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -1980.79,142.664,27.0703)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2319.99,2532.85,10.2188)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1520.15,1055.27,10.00)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2503.14,1243.7,10.2188)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2085.77,2071.36,10.4531)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -862.828,1536.61,21.9844)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -14.7031,1175.36,18.9531)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, -253.742,2597.95,62.2422)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 201.016,-107.617,0.898438)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1277.84,372.516,18.9531)) return true;
	else return false;
}
IsABoat(carid){switch(GetVehicleModel(carid)){case 472,473,493,595,484,430,452..454,446:return true;}return false;}
IsABike(carid){switch(GetVehicleModel(carid)){case 448,435,449,450,457,462,464,465,481,485,501,509,510,530,564,569,570,584,594,606,607,608,610,611:return true;}return false;}
IsAtWormPlace(playerid)
{
	if(PlayerToPoint(350.0,playerid,-256.47,-1353.23,8.39)) return 1;
	else if(PlayerToPoint(200.0,playerid,1942.10,211.14,30.32)) return 2;
	else if(PlayerToPoint(250.0,playerid,-1104.82,-989.44,129.22)) return 3;
	else if(PlayerToPoint(250.0,playerid,-11.38,-69,3.12)) return 3;
	else if(PlayerToPoint(40.0,playerid,-207.20,-5.28,3.11)) return 3;
	return false;
}
IsAtFishPlace(playerid)
{
	if(PlayerToPoint(40.0,playerid,403.8266,-2088.7598,7.8359)) return 1;
	else if(PlayerToPoint(40.0,playerid,1628.1157,577.1617,1.7578)) return 2;
	else if(PlayerToPoint(40.0,playerid,834.62,-2067.49,12.98)) return 3;
	return false;
}
IsAtTPlace(playerid)
{
	if(PlayerToPoint(10.0,playerid,256.4736,1414.5182,10.7075)) return 1;
	else if(PlayerToPoint(10.0,playerid,-1046.7723,-670.7208,32.3516)) return 2;
	else if(PlayerToPoint(10.0,playerid,608.7718,847.8765,-43.1532)) return 3;
	else if(PlayerToPoint(10.0,playerid,-1873.0896,-1720.2430,21.7500)) return 4;
	else if(PlayerToPoint(10.0,playerid,-449.3336,-65.9115,59.4158)) return 5;
	else if(PlayerToPoint(10.0,playerid,-1978.6846,-2434.8274,30.6250)) return 6;
	else if(PlayerToPoint(10.0,playerid,2601.7222,-2226.5867,13.3732)) return 7;
	else if(PlayerToPoint(10.0,playerid,-1731.4509,118.9413,3.5547)) return 8;
	return false;
}
IsAtTTPlace(playerid)
{
	if(PlayerToPoint(10.0,playerid,2601.7222,-2226.5867,13.3732)) return 1;
	else if(PlayerToPoint(10.0,playerid,-1731.4509,118.9413,3.5547)) return 2;
	return false;
}
GetXYInBackOfPlayer(const playerid, &Float:x, &Float:y, const Float:distance)
{
	new Float:a; GetPlayerPos(playerid, x, y, a); GetPlayerFacingAngle(playerid, a);
	if (IsPlayerInAnyVehicle(playerid))
	{
		new vid=GetPlayerVehicleID(playerid);
		if (vid > 0 && vid <= MAX_VEHICLES)GetVehicleZAngle(vid, a);
	}
	x -= (distance * floatsin(-a, degrees)); y -= (distance * floatcos(-a, degrees));
}
// /bizwar
new WarStart;
new MFrakCD[20];
new ZoneWar;
new ZoneID;
new ZoneTimer;

new TotalGzR;
new TotalGzA;
new TotalGzB;
new TotalGzG;
new TotalGzV;
new OnZONE[131][20];
new ZoneOnBattle[131];
new allowedfactions[] = {12,13,15,17,18};
new GZSafeTime[131];
enum GzoneInfo
{
	gID,
	gZone,
    Float:gCoords[4],
	gFrakVlad,
	gNapad
}
new GZInfo[131][GzoneInfo], TOTALGZ;
new FrakCD[20];
publics: MzCheck()
{
	for(new i = 1;i <= TotalBizz; i++)
	{
		new strs[32],sss[32];
		switch(BizzInfo[i][bCapture])
		{
		    case 5: strs = "LCN";
		    case 6: strs = "Yakuza";
		    case 14: strs ="Russian Mafia";
		}
		switch(BizzInfo[i][bMafia])
		{
		    case 5: sss = "LCN";
		    case 6: sss = "Yakuza";
		    case 14: sss ="Russian Mafia";
		}
		foreach(x)
		{
			if(BizzInfo[i][bCapture] == 0) break;
		    if(PTEMP[x][pMember] == BizzInfo[i][bCapture] || PTEMP[x][pMember] == BizzInfo[i][bMafia])
		    {
				if(!GetPVarInt(x,"mafia_war"))
				{
					PlayerTextDrawShow(x, Capture[x]);
					SetPVarInt(x,"mafia_war",1);
					SetPlayerToTeamColor(x);
				}
				format(string,120,"~y~kills~n~~n~~g~%s:~w~ %i~n~~r~%s:~w~ %i", strs, MafiaKills[BizzInfo[i][bCapture]] ,sss, MafiaKills[BizzInfo[i][bMafia]]);
				PlayerTextDrawSetString(x,Capture[x],string);
		    }
		}
		if(BizzInfo[i][bCapture] == 0 || MFrakCD[BizzInfo[i][bCapture]] != 1) continue;
		ZoneTimer--;
		if(ZoneTimer <= 0)
		{
			MFrakCD[BizzInfo[i][bMafia]] = 0;
			MFrakCD[BizzInfo[i][bCapture]] = 0;
			SendFamilyMessage(BizzInfo[i][bMafia],COLOR_GREEN, " Вы отстояли свой бизнес");
			SendFamilyMessage(BizzInfo[i][bCapture],COLOR_RED, " Вам не удалось завоевать ещё один бизнес");
			foreach(y)
			{
				if(PTEMP[y][pMember] == BizzInfo[i][bMafia] || PTEMP[y][pMember] == BizzInfo[i][bCapture])
				{
					DeletePVar(y,"mafia_war");
					PlayerTextDrawHide(y, Capture[y]);
					for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(y,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
				}
			}
			BizzInfo[i][bCapture] = 0;
			WarStart = 7200;
			ZoneID = 0;
			ZoneTimer = 0;
			GangZoneStopFlashForAll(ZoneWar);
			GangZoneHideForAll(ZoneWar);
			KillTimer(MzCheckTimer);
		}
		else
		{
			new ZonePlayer[20] = 0;
			foreach(x)
			{
				if(ZoneID == 1 && IsAMafia(x))
				{
					if(PlayerToKvadrat(x,351.314666, 2455.576416, 439.314666, 2551.576416)) ZonePlayer[PTEMP[x][pMember]] ++;
				}
				else if(ZoneID == 2 && IsAMafia(x))
				{
					if(PlayerToKvadrat(x,393.8914,983.9361, 324.6188,833.3795)) ZonePlayer[PTEMP[x][pMember]] ++;
				}
				else if(ZoneID == 3 && IsAMafia(x))
				{
					if(PlayerToKvadrat(x,-789.8281,2015.9144, -662.7654,2083.9297)) ZonePlayer[PTEMP[x][pMember]] ++;
				}
			}
			new asd[0x2];
			for(new x = 0; x < 20; x++) if(ZonePlayer[x] > 0) asd[0x0]++,asd[0x1] = x;
			if(asd[0x0] == 1)
			{
				if(BizzInfo[i][bMafia] == asd[0x1])
				{
					MFrakCD[BizzInfo[i][bMafia]] = 0;
					MFrakCD[BizzInfo[i][bCapture]] = 0;
					SendFamilyMessage(BizzInfo[i][bMafia],COLOR_GREEN, " Вы отстояли свой бизнес");
					SendFamilyMessage(BizzInfo[i][bCapture],COLOR_RED, " Вам не удалось завоевать ещё один бизнес");
					foreach(y)
					{
						if(PTEMP[y][pMember] == BizzInfo[i][bMafia] || PTEMP[y][pMember] == BizzInfo[i][bCapture])
						{
							DeletePVar(y,"mafia_war");
							PlayerTextDrawHide(y, Capture[y]);
							for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(y,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
						}
					}
					BizzInfo[i][bCapture] = 0;
				}
				else
				{
					MFrakCD[BizzInfo[i][bMafia]] = 0;
					MFrakCD[BizzInfo[i][bCapture]] = 0;
					SendFamilyMessage(BizzInfo[i][bCapture],COLOR_GREEN, " Вы завоевали новый бизнес");
					SendFamilyMessage(BizzInfo[i][bMafia],COLOR_RED, " Вы потеряли контроль над одним из своих бизнесов");
					foreach(y)
					{
						if(PTEMP[y][pMember] == BizzInfo[i][bMafia] || PTEMP[y][pMember] == BizzInfo[i][bCapture])
						{
							DeletePVar(y,"mafia_war");
							PlayerTextDrawHide(y, Capture[y]);
							for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(y,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
						}
					}
					BizzInfo[i][bMafia] = BizzInfo[i][bCapture];
					BizzInfo[i][bCapture] = 0;
				}
			}
			WarStart = 7200;
			ZoneID = 0;
			ZoneTimer = 0;
			GangZoneStopFlashForAll(ZoneWar);
			GangZoneHideForAll(ZoneWar);
			KillTimer(MzCheckTimer);
			break;
		}
	}
	return true;
}
publics: GzCheck()
{
	for(new i = 1; i <= TOTALGZ; i++)
	{
		if(!ZoneOnBattle[i]) continue;
		if(GZSafeTime[i] > 0) GZSafeTime[i] --;
		foreach(x)
		{
			if(!PTEMP[x][pLogin]) continue;
			new y = PTEMP[x][pMember];
			if(y == GZInfo[i][gNapad] || y == GZInfo[i][gFrakVlad])
			{
				if(!GetPVarInt(x,"capture_on"))
				{
					PlayerTextDrawShow(x, Capture[x]);
					SetPVarInt(x,"capture_on",1);
					SetPlayerToTeamColor(x);
				}
				format(string,120,"~y~kills~n~~n~~g~%s:~w~ %i~n~~r~%s:~w~ %i",GetGangName(GZInfo[i][gFrakVlad]),CountOnZone[GZInfo[i][gFrakVlad]],GetGangName(GZInfo[i][gNapad]),CountOnZone[GZInfo[i][gNapad]]);
				PlayerTextDrawSetString(x,Capture[x],string);
				if(PlayerToKvadrat(x,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3])) OnZONE[i][y] ++;
			}
		}
		new asd;
		for(new x =0;x<20;x++)
		{
			if(OnZONE[i][x] > 0 && IsInAllowedF(x) && GZSafeTime[i] <= 0) asd++;
		}
		if(asd == 1)
		{
			for(new x =0;x<20;x++)
			{
				if(OnZONE[i][x] > 0)
				{
					if(GZInfo[i][gFrakVlad] == x)
					{
						SendFamilyMessage(GZInfo[i][gFrakVlad],0x00B953AA," Вы отстояли свою территорию");
						SendFamilyMessage(GZInfo[i][gNapad],0xC56565AA," Вам не удалось захватить территорию");
						CountOnZone[GZInfo[i][gFrakVlad]] = 0;
						CountOnZone[GZInfo[i][gNapad]] = 0;
						foreach(y)
						{
							if(PTEMP[y][pMember] == GZInfo[i][gNapad] || PTEMP[y][pMember] == GZInfo[i][gFrakVlad])
							{
								DeletePVar(y,"capture_on");
								PlayerTextDrawHide(y, Capture[y]);
								for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(y,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
							}
						}
					}
					else
					{
						CountOnZone[GZInfo[i][gFrakVlad]] = 0;
						CountOnZone[GZInfo[i][gNapad]] = 0;
						SendFamilyMessage(GZInfo[i][gNapad], 0x00B953AA," Вы взяли под свой контроль новую территорию");
						for(new y = 1; y <= TOTALGZ; y++)
						{
							if(GZInfo[y][gFrakVlad] == 12) TotalGzB++;
							if(GZInfo[y][gFrakVlad] == 13) TotalGzV++;
							if(GZInfo[y][gFrakVlad] == 15) TotalGzG++;
							if(GZInfo[y][gFrakVlad] == 17) TotalGzA++;
							if(GZInfo[y][gFrakVlad] == 18) TotalGzR++;
						}
						switch(GZInfo[i][gNapad])
						{
						case 12: format(string, 144, " Теперь ваша банда будет получать каждый час %i вирт",TotalGzB*300), gRating[Ballas] += 5000;
						case 13: format(string, 144, " Теперь ваша банда будет получать каждый час %i вирт",TotalGzV*300), gRating[Vagos] += 5000;
						case 15: format(string, 144, " Теперь ваша банда будет получать каждый час %i вирт",TotalGzG*300), gRating[Grove] += 5000;
						case 17: format(string, 144, " Теперь ваша банда будет получать каждый час %i вирт",TotalGzA*300), gRating[Aztec] += 5000;
						case 18: format(string, 144, " Теперь ваша банда будет получать каждый час %i вирт",TotalGzR*300), gRating[Rifa] += 5000;
						}
						SendFamilyMessage(GZInfo[i][gFrakVlad], 0xC56565AA," Вы потеряли контроль одной из своих территорий");
						foreach(y)
						{
							if(PTEMP[y][pMember] == GZInfo[i][gNapad] || PTEMP[y][pMember] == GZInfo[i][gFrakVlad])
							{
								DeletePVar(y,"capture_on");
								PlayerTextDrawHide(y, Capture[y]);
								for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(y,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
							}
						}
						GZInfo[i][gFrakVlad] = GZInfo[i][gNapad];
						SendFamilyMessage(GZInfo[i][gNapad], 0x00B953AA, string);
					}
					ClearTotalGz();
					ZoneOnBattle[i] = 0;
					GangZoneStopFlashForAll(GZInfo[i][gZone]);
					GangZoneHideForAll(GZInfo[i][gZone]);
					GangZoneShowForAll(GZInfo[i][gZone],GetGangZoneColor(i));
					GZInfo[i][gNapad] = 0;
					UpdateTable(TABLE_GANGZONE,"gang_owner",GZInfo[i][gFrakVlad],"id",GZInfo[i][gID]);
					break;
				}
			}
		}
	}
	for(new i = 1; i <= TOTALGZ; i++)
	{
		for(new z = 0;z<20;z++)
		{
			OnZONE[i][z] =0;
		}
	}
	return true;
}
IsInAllowed(playerid)
{
	for(new i = 0; i < sizeof(allowedfactions); i++)
	{
		if(PTEMP[playerid][pMember] == allowedfactions[i]&&PTEMP[playerid][pRank] >= 7) return true;
	}
	return false;
}
IsAPlane(carid){switch(GetVehicleModel(carid)){case 592,577,511,512,593,520,553,476,519,460,513,548,417,487,488,497,563,447,469:return true;}return false;}
publics: IsAGunsCar(carid)
{
	if(carid == gunscar[0]
			||carid == gunscar[1]
			||carid == gunscar[2]
			||carid == gunscar[3]
			||carid == gunscar[4]
			||carid == gunscar[5]
			||carid == gunscar[6])
	{
		return true;
	}
	return false;
}
CreateTextDraws(playerid)
{
	RouletText[playerid] = CreatePlayerTextDraw(playerid,434.000000, 318.000000,"");
	PlayerTextDrawBackgroundColor(playerid,RouletText[playerid], 255);
	PlayerTextDrawAlignment(playerid,RouletText[playerid], 0);
	PlayerTextDrawLetterSize(playerid,RouletText[playerid],0.500000, 2.100000);
	PlayerTextDrawFont(playerid,RouletText[playerid],0);
	PlayerTextDrawColor(playerid,RouletText[playerid],0xE1E1E1AA);
	PlayerTextDrawSetOutline(playerid,RouletText[playerid],0);
	PlayerTextDrawSetProportional(playerid,RouletText[playerid],2);
	PlayerTextDrawHide(playerid,RouletText[playerid]);
	// Кости
	PlayerBone[playerid][0] = CreatePlayerTextDraw(playerid, 556.603332, 142.333358, "Table_1");
	PlayerTextDrawLetterSize(playerid, PlayerBone[playerid][0], 0.491228, 1.524165);
	PlayerTextDrawAlignment(playerid, PlayerBone[playerid][0], 2);
	PlayerTextDrawColor(playerid, PlayerBone[playerid][0], 548012031);
	PlayerTextDrawUseBox(playerid, PlayerBone[playerid][0], true);
	PlayerTextDrawBoxColor(playerid, PlayerBone[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, PlayerBone[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PlayerBone[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerBone[playerid][0], 51);
	PlayerTextDrawFont(playerid, PlayerBone[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, PlayerBone[playerid][0], 1);

	PlayerBone[playerid][1] = CreatePlayerTextDraw(playerid, 527.309020, 163.916000, "_");
	PlayerTextDrawLetterSize(playerid, PlayerBone[playerid][1], 0.175188, 1.010665);
	PlayerTextDrawAlignment(playerid, PlayerBone[playerid][1], 1);
	PlayerTextDrawColor(playerid, PlayerBone[playerid][1], -1347440641);
	PlayerTextDrawUseBox(playerid, PlayerBone[playerid][1], true);
	PlayerTextDrawBoxColor(playerid, PlayerBone[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, PlayerBone[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PlayerBone[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerBone[playerid][1], 51);
	PlayerTextDrawFont(playerid, PlayerBone[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PlayerBone[playerid][1], 1);

	PlayerBone[playerid][2] = CreatePlayerTextDraw(playerid, 585.057067, 165.082687, "++~n~--~n~++~n~--~n~--");
	PlayerTextDrawLetterSize(playerid, PlayerBone[playerid][2], 0.175188, 1.010665);
	PlayerTextDrawAlignment(playerid, PlayerBone[playerid][2], 2);
	PlayerTextDrawColor(playerid, PlayerBone[playerid][2], -1347440641);
	PlayerTextDrawUseBox(playerid, PlayerBone[playerid][2], true);
	PlayerTextDrawBoxColor(playerid, PlayerBone[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, PlayerBone[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, PlayerBone[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerBone[playerid][2], 51);
	PlayerTextDrawFont(playerid, PlayerBone[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, PlayerBone[playerid][2], 1);

	PlayerBone[playerid][3] = CreatePlayerTextDraw(playerid, 527.086486, 214.666687, "Bet:_100000~n~Bank:_200000~n~Money:_330500");
	PlayerTextDrawLetterSize(playerid, PlayerBone[playerid][3], 0.186432, 1.115664);
	PlayerTextDrawAlignment(playerid, PlayerBone[playerid][3], 1);
	PlayerTextDrawColor(playerid, PlayerBone[playerid][3], -1347440641);
	PlayerTextDrawSetShadow(playerid, PlayerBone[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, PlayerBone[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerBone[playerid][3], 51);
	PlayerTextDrawFont(playerid, PlayerBone[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, PlayerBone[playerid][3], 1);

	FishingText[playerid] = CreatePlayerTextDraw(playerid,49.194732, 245.583328, "~y~Press: ~w~L.Alt~n~~n~~y~Tackle: ~w~0~n~~y~Worms: ~w~0~n~~y~Sonar: ~w~0");
	PlayerTextDrawAlignment(playerid,FishingText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,FishingText[playerid], 255);
	PlayerTextDrawFont(playerid,FishingText[playerid], 1);
	PlayerTextDrawLetterSize(playerid,FishingText[playerid], 0.388624, 1.220832);
	PlayerTextDrawColor(playerid,FishingText[playerid], 0xFFFF1FAA);
	PlayerTextDrawSetOutline(playerid,FishingText[playerid], 0);
	PlayerTextDrawSetProportional(playerid,FishingText[playerid], 1);
	PlayerTextDrawSetShadow(playerid,FishingText[playerid], 0);
	PlayerTextDrawSetSelectable(playerid,FishingText[playerid], 0);
	PlayerTextDrawHide(playerid,FishingText[playerid]);
	//========================================================================== Спидометр
	SpeedShow[playerid] = CreatePlayerTextDraw(playerid,327.054473, 394.333343, "_");
	PlayerTextDrawBackgroundColor(playerid,SpeedShow[playerid], 96);
	PlayerTextDrawAlignment(playerid,SpeedShow[playerid], 1);
	PlayerTextDrawLetterSize(playerid,SpeedShow[playerid],0.496852, 1.716667);
	PlayerTextDrawFont(playerid,SpeedShow[playerid],0);
	PlayerTextDrawColor(playerid,SpeedShow[playerid], 208117759);
	PlayerTextDrawSetOutline(playerid,SpeedShow[playerid],1);
	PlayerTextDrawSetProportional(playerid,SpeedShow[playerid],1);
	PlayerTextDrawSetShadow(playerid,SpeedShow[playerid],0);
	PlayerTextDrawHide(playerid, SpeedShow[playerid]);
	//==========================================================================
	StatusShow[playerid] = CreatePlayerTextDraw(playerid,414.199462, 405.416809, "_");
	PlayerTextDrawBackgroundColor(playerid,StatusShow[playerid], 255);
	PlayerTextDrawLetterSize(playerid,StatusShow[playerid],0.463586, 1.168333);
	PlayerTextDrawFont(playerid,StatusShow[playerid], 1);
	PlayerTextDrawColor(playerid,StatusShow[playerid], -16776961);
	PlayerTextDrawSetOutline(playerid,StatusShow[playerid], 1);
	PlayerTextDrawSetProportional(playerid,StatusShow[playerid],1);
	PlayerTextDrawSetShadow(playerid,StatusShow[playerid],0);
	PlayerTextDrawHide(playerid, StatusShow[playerid]);
	//==========================================================================
	KMShow[playerid] = CreatePlayerTextDraw(playerid,357.976928, 396.666717, "KM/H");
	PlayerTextDrawBackgroundColor(playerid,KMShow[playerid], 128);
	PlayerTextDrawLetterSize(playerid,KMShow[playerid],0.278052, 1.185832);
	PlayerTextDrawFont(playerid,KMShow[playerid], 2);
	PlayerTextDrawColor(playerid,KMShow[playerid], 208117604);
	PlayerTextDrawSetOutline(playerid,KMShow[playerid], 1);
	PlayerTextDrawSetProportional(playerid,KMShow[playerid],1);
	PlayerTextDrawSetShadow(playerid,KMShow[playerid],0);
	PlayerTextDrawHide(playerid, KMShow[playerid]);
	/////////////////////////
	LimitShow[playerid] = CreatePlayerTextDraw(playerid,364.067504, 410.083374, "MAX");
	PlayerTextDrawLetterSize(playerid,LimitShow[playerid], 0.187159, 0.713333);
	PlayerTextDrawAlignment(playerid,LimitShow[playerid], 1);
	PlayerTextDrawColor(playerid,LimitShow[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid,LimitShow[playerid], 51);
	PlayerTextDrawFont(playerid,LimitShow[playerid], 1);
	PlayerTextDrawSetProportional(playerid,LimitShow[playerid], 1);
	PlayerTextDrawSetOutline(playerid,LimitShow[playerid], 0);
	PlayerTextDrawSetShadow(playerid,LimitShow[playerid],0);
	//==========================================================================
	FuelShow[playerid] = CreatePlayerTextDraw(playerid,402.017822, 389.083312, "_");
	PlayerTextDrawBackgroundColor(playerid,FuelShow[playerid], 80);
	PlayerTextDrawLetterSize(playerid,FuelShow[playerid],0.530584, 1.016667);
	PlayerTextDrawFont(playerid,FuelShow[playerid], 0);
	PlayerTextDrawColor(playerid,FuelShow[playerid], -1);
	PlayerTextDrawSetOutline(playerid,FuelShow[playerid], 1);
	PlayerTextDrawSetProportional(playerid,FuelShow[playerid],1);
	PlayerTextDrawSetShadow(playerid,FuelShow[playerid],0);
	PlayerTextDrawShow(playerid, FuelShow[playerid]);
	//==========================================================================
	FillShow[playerid] = CreatePlayerTextDraw(playerid,434.814239, 387.333526, " FUEL");
	PlayerTextDrawBackgroundColor(playerid,FillShow[playerid], 255);
	PlayerTextDrawFont(playerid,FillShow[playerid], 2);
	PlayerTextDrawLetterSize(playerid,FillShow[playerid], 0.301010, 1.308333);
	PlayerTextDrawColor(playerid,FillShow[playerid], -2147483393);
	PlayerTextDrawSetOutline(playerid,FillShow[playerid], 1);
	PlayerTextDrawSetProportional(playerid,FillShow[playerid], 1);
	PlayerTextDrawHide(playerid, FillShow[playerid]);
	//==========================================================================
	// Спидометр
	FULLRECON[playerid] = CreatePlayerTextDraw(playerid,510.000000, 120.000000, "_");
	PlayerTextDrawColor(playerid,FULLRECON[playerid], -1);
	PlayerTextDrawSetShadow(playerid,FULLRECON[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,FULLRECON[playerid], 0x00000044);
	PlayerTextDrawSetProportional(playerid,FULLRECON[playerid], 3);
	PlayerTextDrawAlignment(playerid,FULLRECON[playerid], 1);
	PlayerTextDrawFont(playerid,FULLRECON[playerid], 2);
	PlayerTextDrawSetOutline(playerid,FULLRECON[playerid], 0);
	PlayerTextDrawLetterSize(playerid,FULLRECON[playerid], 0.300000, 1.200000);
}
ResetNew(playerid)
{
	PreloadAnimLib(playerid,"CARRY");
	PreloadAnimLib(playerid,"BOMBER");
	PreloadAnimLib(playerid,"FOOD");
	PreloadAnimLib(playerid,"BAR");
	PreloadAnimLib(playerid,"CRACK");
	PreloadAnimLib(playerid,"SMOKING");
	creatcar[playerid] = -1;
	PTEMP[playerid][pAdmin] = 0;
	PTEMP[playerid][pHelper] = 0;
	tipster = -1;
	CallInfo[playerid][callused] = 0;
	tipsterlisten[playerid] = 0;
	vehicleidtp[playerid] = INVALID_VEHICLE_ID;
	DelGun(playerid);
	recognition[playerid] = 0;
	IsSmoking[playerid] = 0;
	for(new i; i < 11; i++) vidachagun[i][playerid] = 0;
	Rvanka[playerid] = 0;
	dostup[playerid] = 0;
	rabotaon[playerid] = 0;
	FreezePlayer[playerid] = 1;
	nachalvzlom[playerid] = 0;
	idcarv[playerid] = 0;
	timervzlom[playerid] = 0;
	avtocar[playerid] = 0;
	timecar[playerid] = 0;
	tookmoped[playerid] = 0;
	house_car[playerid] = -1;
	mesh[playerid] = 999;
	usemesh[playerid] = 0;
	Tune[playerid] = 0;
	ZoneOffer[playerid] = 999;
	ZonePrice[playerid] = 0;
	Armour[playerid] = 0;
	robh[playerid] = false;
	play[playerid] = 0;
	KeysOffer[playerid] = 999;
	KeysGram[playerid]= 999;
	KeysPrice[playerid]= 999;
	DrugOffer[playerid] = 999;
	DrugPrice[playerid]= 999;
	DrugGram[playerid]= 999;
	ZoneOffer[playerid]= 999;
	ZonePrice[playerid]= 999;
	FreeOffer[playerid]= 999;
	TicketOffer[playerid] = 999;
	TicketMoney[playerid] = 0;
	ProposeOffer[playerid] = 999;
	MarryWitness[playerid] = 999;
	MarryWitnessOffer[playerid] = 999;
	InviteOffer[playerid] = 999;
	MarriageCeremoney[playerid] = 0;
	ProposedTo[playerid] = 999;
	GotProposedBy[playerid] = 999;
	DivorceOffer[playerid] = 999;
	PTEMP[playerid][pChas] = 0;
	PTEMP[playerid][pMin] = 0;
	lsacarvertexit[playerid] = 0;
	MatsArmyCar[playerid]= 0;
	//PTEMP[playerid][pSpawnChange] = 1;
	CharPrice[playerid] = 0;
	SelectCharID[playerid] = 0;
	chet[playerid] = 0;
	RaceCP[playerid] = 0;
	PicCP[playerid] = 0;
	SelectChar[playerid] = 0;
	PhoneOnline[playerid] = 0;
	ChosenSkin[playerid] = 0;
	InviteSkin[playerid] = 0;
	PEfir[playerid] = 255;
	Pefir[playerid] = 0;
	Works[playerid] = false;
	JobCP[playerid] = 0;
	GruzCP[playerid] = 0;
	JobAmmount[playerid] = 0;
	OldSkin[playerid] = 320;
	TakingLesson[playerid] = 0;
	JobOffer[playerid] = 999;
	Employer[playerid] = 999;
	ConsumingMoney[playerid] = 0;
	CallLawyer[playerid] = 0;
	KickPlayer[playerid] = 0;
	CurrentMoney[playerid] = 0;
	CP[playerid] = 0;
	RaceCP[playerid] = 0;
	//PTEMP[playerid][pSpawnChange] = 1;
	TalkingLive[playerid] = 255;
	TalkingLivels[playerid] = 255;
	TalkingLivelv[playerid] = 255;
	LiveOffer[playerid] = 999;
	LiveOfferlv[playerid] = 999;
	LiveOfferls[playerid] = 999;
	TranPlayer[playerid] = 999;
	RepairOffer[playerid] = 999;
	RepairPrice[playerid] = 0;
	RepairCar[playerid] = 0;
	TieTime[playerid] = 0;
	RefillOffer[playerid] = 999;
	RefillPrice[playerid] = 0;
	PlayerCuffed[playerid] = 0;
	PlayerCuffedTime[playerid] = 0;
	RegistrationStep[playerid] = 0;
	DrugGram[playerid] = 0;
	ConnectedToPC[playerid] = 0;
	PlayerTied[playerid] = 0;
	Mobile[playerid] = 999;
	Tel[playerid] = 255;
	Rekl[playerid] = 1;
	gLastCar[playerid] = 0;
	FirstSpawn[playerid] = 0;
	Report[playerid] = 0;
	gNews[playerid] = 1;
	lNews[playerid] = 1;
	LvNews[playerid] = 1;
	BigEar[playerid] = 0;
	gDice[playerid] = 0;
	PTEMP[playerid][pLogin] = 0;
	gPlayerLogTries[playerid] = 0;
	gLog[playerid] = 1;
	gPlayerSpawned[playerid] = 0;
	PlayerTazeTime[playerid] = 0;
	StartTime[playerid] = 0;
	MatsHolding[playerid] = 0;
	TutTime[playerid] = 0;
	Locator[playerid] = 0;
	PlayerDrunk[playerid] = 0;
	WatchingTV[playerid] = 0;
	MarryWitness[playerid] = 999;
	MarryWitnessOffer[playerid] = 999;
	MarriageCeremoney[playerid] = 0;
	KrishaOffer[playerid] = 999;
	PTEMP[playerid][pDLevel] = 0;
	PTEMP[playerid][pDExp] = 0;
	PTEMP[playerid][pDgruz] = 0;
	PTEMP[playerid][pPSkill] = 0;
	PTEMP[playerid][pPProc] = 0;
	PTEMP[playerid][pPMGruz] = 0;
	DriverJob[playerid] = false;
	GivePlayerPPCash(playerid,PTEMP[playerid][pCash]);
	OldSkin[playerid] = GetPlayerSkin(playerid);
	ChosenSkin[playerid] = OldSkin[playerid];
	InviteSkin[playerid] = OldSkin[playerid];
	//
	for(new i = 1; i <= TOTALGZ; i++) GangZoneShowForPlayer(playerid,GZInfo[i][gZone],GetGangZoneColor(i));
	for(new i = 0; i < 46; i++) Weapons[playerid][i] = 0;
	Goto[playerid] = true;
	AdminVehicle[playerid][createdveh] = -1;
	AdminVehicle[playerid][vehid] = 522;
	AdminVehicle[playerid][color1] = 0;
	AdminVehicle[playerid][color2] = 0;
}
#include "..\gamemodes\default\OnPlayerWeaponShot.pwn"
#include "..\gamemodes\default\OnPlayerConnect.pwn"
CMD:onlyoneip(playerid, params[])
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 10) return true;
	if(onlyOneIp)
	{
	    onlyOneIp = false;
	    SCM(playerid, COLOR_REDD, " Success!");
	}
	else
	{
		onlyOneIp = true;
	    SCM(playerid, COLOR_GREEN, " Success!");
	}
	printf("Администратор %s включил вход на сервер только с одного аккаунта",Name(playerid));
	return true;
}
LoadRecon(playerid)
{
	ReconPlayer[0] = CreatePlayerTextDraw(playerid,530.000000, 180.000000, "x");
	PlayerTextDrawBackgroundColor(playerid, ReconPlayer[0], 0x000000AA);
	PlayerTextDrawFont(playerid, ReconPlayer[0], 3);
	PlayerTextDrawLetterSize(playerid,ReconPlayer[0], 0.000000, 20.600000);
	PlayerTextDrawColor(playerid,ReconPlayer[0], 0xE1E1E1AA);
	PlayerTextDrawSetOutline(playerid,ReconPlayer[0], 1);
	PlayerTextDrawSetProportional(playerid,ReconPlayer[0], 1);
	PlayerTextDrawSetShadow(playerid,ReconPlayer[0], 2);
	PlayerTextDrawUseBox(playerid,ReconPlayer[0], 1);
	PlayerTextDrawBoxColor(playerid,ReconPlayer[0], 0x00000055);
	PlayerTextDrawTextSize(playerid,ReconPlayer[0], 640.000, 0.000000);
	ReconPlayer[1] = CreatePlayerTextDraw(playerid,529.000000, 179.000000, "x");
	PlayerTextDrawBackgroundColor(playerid,ReconPlayer[1], 0x000000AA);
	PlayerTextDrawFont(playerid,ReconPlayer[1], 3);
	PlayerTextDrawLetterSize(playerid,ReconPlayer[1], 0.000000, 20.600000);
	PlayerTextDrawColor(playerid,ReconPlayer[1], 0xE1E1E1AA);
	PlayerTextDrawSetOutline(playerid,ReconPlayer[1], 1);
	PlayerTextDrawSetProportional(playerid,ReconPlayer[1], 1);
	PlayerTextDrawSetShadow(playerid,ReconPlayer[1], 2);
	PlayerTextDrawUseBox(playerid,ReconPlayer[1], 1);
	PlayerTextDrawBoxColor(playerid,ReconPlayer[1], 0xAAAAAA33);
	PlayerTextDrawTextSize(playerid,ReconPlayer[1], 641.000000, 0.000000);
	ReconPlayer[2] = CreatePlayerTextDraw(playerid,0.000, 180.000, "x");
	PlayerTextDrawBackgroundColor(playerid,ReconPlayer[2], 0x000000AA);
	PlayerTextDrawFont(playerid,ReconPlayer[2], 3);
	PlayerTextDrawLetterSize(playerid,ReconPlayer[2], 0.000000, 18.540);
	PlayerTextDrawColor(playerid,ReconPlayer[2], 0xE1E1E1AA);
	PlayerTextDrawSetOutline(playerid,ReconPlayer[2], 1);
	PlayerTextDrawSetProportional(playerid,ReconPlayer[2], 1);
	PlayerTextDrawSetShadow(playerid,ReconPlayer[2], 2);
	PlayerTextDrawUseBox(playerid,ReconPlayer[2], 1);
	PlayerTextDrawBoxColor(playerid,ReconPlayer[2], 0x00000055);
	PlayerTextDrawTextSize(playerid,ReconPlayer[2], 70.000, 0.000000);
	ReconPlayer[3] = CreatePlayerTextDraw(playerid,0.000, 179.000, "x");
	PlayerTextDrawBackgroundColor(playerid,ReconPlayer[3], 0x000000AA);
	PlayerTextDrawFont(playerid,ReconPlayer[3], 3);
	PlayerTextDrawLetterSize(playerid,ReconPlayer[3], 0.000000, 18.746);
	PlayerTextDrawColor(playerid,ReconPlayer[3], 0xE1E1E1AA);
	PlayerTextDrawSetOutline(playerid,ReconPlayer[3], 1);
	PlayerTextDrawSetProportional(playerid,ReconPlayer[3], 1);
	PlayerTextDrawSetShadow(playerid,ReconPlayer[3], 2);
	PlayerTextDrawUseBox(playerid,ReconPlayer[3], 1);
	PlayerTextDrawBoxColor(playerid,ReconPlayer[3], 0xAAAAAA33);
	PlayerTextDrawTextSize(playerid,ReconPlayer[3], 71.000, 0.000000);
	ReconPlayer[4] = CreatePlayerTextDraw(playerid,535.000, 210.000, "~n~~g~::Level:~n~~g~::Warns:~n~~r~::Armour:~n~~r~::Health:~n~~b~::CarHP:~n~~b~::Speed:~n~~y~::Ping:~n~~y~::Ammo:~n~~p~::Shot:~n~~p~::TimeShot:~n~~g~::AFKTime:~n~~g~::Engine:");
	PlayerTextDrawBackgroundColor(playerid,ReconPlayer[4], 0x000000AA);
	PlayerTextDrawSetProportional(playerid,ReconPlayer[4], 1);
	PlayerTextDrawLetterSize(playerid,ReconPlayer[4], 0.200, 1.100);
	PlayerTextDrawColor(playerid,ReconPlayer[4], 0xFFFFFFAA);
	PlayerTextDrawFont(playerid,ReconPlayer[4], 1);
	PlayerTextDrawSetShadow(playerid,ReconPlayer[4], 2);
	PlayerTextDrawSetOutline(playerid,ReconPlayer[4], 1);
	PlayerTextDrawUseBox(playerid,ReconPlayer[4], 0);
	ReconPlayer[5] = CreatePlayerTextDraw(playerid,575.000, 210.000, " ");
	PlayerTextDrawBackgroundColor(playerid,ReconPlayer[5], 0x000000AA);
	PlayerTextDrawSetProportional(playerid,ReconPlayer[5], 1);
	PlayerTextDrawLetterSize(playerid,ReconPlayer[5], 0.200, 1.100);
	PlayerTextDrawColor(playerid,ReconPlayer[5], 0xFFFFFFAA);
	PlayerTextDrawFont(playerid,ReconPlayer[5], 1);
	PlayerTextDrawSetShadow(playerid,ReconPlayer[5], 2);
	PlayerTextDrawSetOutline(playerid,ReconPlayer[5], 1);
	PlayerTextDrawUseBox(playerid,ReconPlayer[5], 0);
	ReconPlayer[6] = CreatePlayerTextDraw(playerid,585.000000, 190.000000, " ");
	PlayerTextDrawBackgroundColor(playerid,ReconPlayer[6], 0x000000AA);
	PlayerTextDrawSetProportional(playerid,ReconPlayer[6], 1);
	PlayerTextDrawLetterSize(playerid,ReconPlayer[6], 0.300, 1.400);
	PlayerTextDrawColor(playerid,ReconPlayer[6], 0xFFFFFFAA);
	PlayerTextDrawFont(playerid,ReconPlayer[6], 1);
	PlayerTextDrawAlignment(playerid,ReconPlayer[6], 2);
	PlayerTextDrawSetShadow(playerid,ReconPlayer[6], 2);
	PlayerTextDrawSetOutline(playerid,ReconPlayer[6], 1);
	PlayerTextDrawUseBox(playerid,ReconPlayer[6], 0);
	CreateReconButtonn(playerid,35.000, 195.000, "Change", 7);
	CreateReconButtonn(playerid,35.000, 212.000, "Check >>", 8);
	CreateReconButtonn(playerid,35.000, 229.000, "Drop >>", 9);
	CreateReconButtonn(playerid,35.000, 246.000, "Kick >>", 10);
	CreateReconButtonn(playerid,35.000, 263.000, "Warn", 11);
	CreateReconButtonn(playerid,35.000, 280.000, "Ban >>", 12);
	CreateReconButtonn(playerid,35.000, 297.000, "Stats >>", 13);
	CreateReconButtonn(playerid,35.000, 314.000, "Refresh", 14);
	CreateReconButtonn(playerid,35.000, 331.000, "Exit", 15);
	CreateReconButtonn(playerid,100.000, 212.000, "Check-GM", 16);//Check >>
	CreateReconButtonn(playerid,100.000, 229.000, "Check-GM2", 17);//Check >>
	CreateReconButtonn(playerid,100.000, 246.000, "Check-GMCar", 18);//Check >>
	CreateReconButtonn(playerid,100.000, 263.000, "ResetShot", 19);//Check >>
	CreateReconButtonn(playerid,100.000, 229.000, "Mute", 20);//Drop >>
	CreateReconButtonn(playerid,100.000, 246.000, "Slap", 21);//Drop >>
	CreateReconButtonn(playerid,100.000, 263.000, "Prison", 22);//Drop >>
	CreateReconButtonn(playerid,100.000, 280.000, "Freeze", 23);//Drop >>
	CreateReconButtonn(playerid,100.000, 297.000, "UnFreeze", 24);//Drop >>
	CreateReconButtonn(playerid,100.000, 246.000, "SKick", 25);//Kick >>
	CreateReconButtonn(playerid,100.000, 263.000, "Kick", 26);//Kick >>
	CreateReconButtonn(playerid,100.000, 280.000, "Ban", 27);//Ban >>
	CreateReconButtonn(playerid,100.000, 297.000, "SBan", 28);//Ban >>
	CreateReconButtonn(playerid,100.000, 314.000, "IBan", 29);//Ban >>
	CreateReconButtonn(playerid,100.000, 297.000, "Stats", 30);//Stats >>
	CreateReconButtonn(playerid,100.000, 314.000, "IWep", 31);//Stats >>
	CreateReconButtonn(playerid,100.000, 331.000, "GetIP", 32);//Stats >>
	CreateReconButtonn(playerid,100.000, 348.000, "Serial/S0b", 33);//Stats >>
	CreateReconButtonn(playerid,585.00, 350.00, "Help", 34); // Рекон клавиша
	Seriu[playerid][0] = CreatePlayerTextDraw(playerid,589.00, 145.00, "Nik Anson~n~ID: 666");
	PlayerTextDrawAlignment(playerid,Seriu[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid,Seriu[playerid][0],  0.240000, 0.899999);
	Seriu[playerid][1] = CreatePlayerTextDraw(playerid,578.00, 165.00, "1 : 1 / 8~n~0~n~0~n~50~n~0~n~0 / 0~n~86~n~0 : 0 ~n~0 / 0 : 0%~n~0 / 0 : 0%~n~23 : 0");
	PlayerTextDrawLetterSize(playerid,Seriu[playerid][1], 0.199999, 0.899999);
	for(new h; h < 2; h ++)
	{
		PlayerTextDrawBackgroundColor(playerid,Seriu[playerid][h], 255);
		PlayerTextDrawFont(playerid,Seriu[playerid][h], 1);
		PlayerTextDrawColor(playerid,Seriu[playerid][h], -1);
		PlayerTextDrawSetOutline(playerid,Seriu[playerid][h], 1);
		PlayerTextDrawSetProportional(playerid,Seriu[playerid][h], 1);
		PlayerTextDrawSetShadow(playerid,Seriu[playerid][h],0);
	}
}
UpdateFish(playerid)
{
	if(GetPVarInt(playerid,"fish_sonar")) format(string,128,"~y~Tackle: ~w~%i~n~~y~Worms: ~w~%i~n~~y~Sonar: ~w~%.2f~n~~n~~y~Press: ~g~L.ALT",GetPVarInt(playerid,"fish_gear"),GetPVarInt(playerid,"fish_worms"),Sonar[IsAtFishPlace(playerid)]);
	else format(string,128,"~y~Tackle: ~w~%i~n~~y~Worms: ~w~%i~n~~n~~y~Press: ~g~L.ALT",GetPVarInt(playerid,"fish_gear"),GetPVarInt(playerid,"fish_worms"));
	PlayerTextDrawSetString(playerid,FishingText[playerid],string);
	return true;
}
publics: SpMenu(playerid)
{
 	CallLocalFunction("OnPlayerCommandText", "is", playerid, "/spmenu");
}
publics: AdmMenu(playerid)
{
	CallLocalFunction("OnPlayerCommandText", "is", playerid, "/admmenu");
}
publics: ServerBonus(playerid)
{
	CallLocalFunction("OnPlayerCommandText", "is", playerid, "/serverbonus");
}
GetNameOfBiker(idx)
{
	switch(idx)
	{
	    case 24: string = "Hell's Angels MC";
	    case 26: string = "Warlocks MC";
	    case 29: string = "Pagans MC";
	    default: string = "Нет";
	}
	return string;
}
BikerCapt(atacks, others)
{
	if(atacks == 24) { if(IsCapted[hells]) return false; }
	if(atacks == 26) { if(IsCapted[warloks]) return false; }
	if(atacks == 29) { if(IsCapted[pagans]) return false; }
	new rand = random(3);
	GangZoneShowForAll(BikerZone[rand], 0xFF0000AA);
    GangZoneFlashForAll(BikerZone[rand], 0x0000FFAA);
	foreach(i)
	{
	    if(PTEMP[i][pMember] == atacks || PTEMP[i][pMember] == others)
	    {
	        SetPVarInt(i, "biker_capt", 1);
	        PlayerTextDrawShow(i, Capture[i]);
			SetPlayerToTeamColor(i);
			if(PTEMP[i][pMember] == atacks)
				BikerText[i] = Create3DTextLabel("Захват",0xFF0000AA, 30.0, 40.0, 50.0, 50.0,1);
			else
				BikerText[i] = Create3DTextLabel("Оборона",0x0000FFAA, 30.0, 40.0, 50.0, 50.0,1);
			Attach3DTextLabelToPlayer(BikerText[i], i, 0.0, 0.0, 0.4);
	    }
	    format(string,120,"~y~kills~n~~n~~g~%s:~w~ %i~n~~r~%s:~w~ %i", GetNameOfBiker(atacks), BikerKills[atack] , GetNameOfBiker(others), BikerKills[other]);
		PlayerTextDrawSetString(i,Capture[i],string);
	}
	ZoneCaptureBiker = BikerZone[rand];
	SetTimer("UpdateBikers", 2000, true);
	return true;
}
publics: UpdateBikers()
{
	foreach(i)
	{
	    if(PTEMP[i][pMember] == BikerCapture[atack] || PTEMP[i][pMember] == BikerCapture[other])
	    {
	        if(!GetPVarInt(i, "biker_capt"))
	        {
				SetPVarInt(i, "biker_capt",1);
				PlayerTextDrawShow(i, Capture[i]);
				SetPlayerToTeamColor(i);
				if(PTEMP[i][pMember] == BikerCapture[atack])
					BikerText[i] = Create3DTextLabel("Захват",0xFF0000FF, 30.0, 40.0, 50.0, 50.0,1);
				else
					BikerText[i] = Create3DTextLabel("Оборона",0x0000FFFF, 30.0, 40.0, 50.0, 50.0,1);
				Attach3DTextLabelToPlayer(BikerText[i], i, 0.0, 0.0, 0.4);
			}
			format(string,120,"~y~kills~n~~n~~g~%s:~w~ %i~n~~r~%s:~w~ %i", GetNameOfBiker(BikerCapture[atack]), BikerKills[atack] , GetNameOfBiker(BikerCapture[other]), BikerKills[other]);
			PlayerTextDrawSetString(i,Capture[i],string);
		}
	}
	SetTimer("UpdateBikers", 2000, true);
}
publics: CanCaptBiker()
{
	IsCapted[hells] = false;
	IsCapted[warloks] = false;
	IsCapted[pagans] = false;
	return true;
}
publics: StopCaptureBiker()
{
	if(BikerKills[atack] > BikerKills[other])
	{
        SendFamilyMessage(BikerKills[atack], COLOR_GREEN, " Ваш клуб выиграл!");
        SendFamilyMessage(BikerKills[atack], 0x954F4FFF, " Ваш клуб проиграл!");
        if(BikerCapture[reasons] >= 0 && BikerCapture[reasons] <= 4)
        {
            FarmInfo[BikerCapture[reasons]+1][fBiker] = BikerCapture[atack];
        }
        else if(BikerCapture[reasons] >= 5 && BikerCapture[reasons] <= 7)
        {
            WorkshopInfo[BikerCapture[reasons]+1][wBiker] = BikerCapture[atack];
        }
	}
	else if(BikerKills[other] > BikerKills[atack])
	{
		SendFamilyMessage(BikerKills[other], COLOR_GREEN, " Ваш клуб выиграл!");
		SendFamilyMessage(BikerKills[atack], 0x954F4FFF, " Ваш клуб выиграл!");
        /*if(BikerCapture[reasons] >= 0 && BikerCapture[reasons] <= 4)
        {
            FarmInfo[BikerCapture[reasons]][fBiker] = BikerCapture[other];
        }
        else if(BikerCapture[reasons] >= 5 && BikerCapture[reasons] <= 7)
        {
            WorkshopInfo[BikerCapture[reasons]][wBiker] = BikerCapture[other];
        }*/
	}
	else if(BikerKills[other] == BikerKills[atack])
	{
	    SendFamilyMessage(BikerCapture[atack], COLOR_BLUE, " У вас есть ещё 3 минуты чтобы решить какой клуб лучше!");
	    SendFamilyMessage(BikerCapture[other], COLOR_BLUE, " У вас есть ещё 3 минуты чтобы решить какой клуб лучше!");
	    SetTimer("StopCaptureBiker", 180000, true);
		return false;
	}
	foreach(i)
	{
		if(PTEMP[i][pMember] == BikerCapture[atack] || PTEMP[i][pMember] == BikerCapture[other])
		{
		    DeletePVar(i,"biker_capt");
			PlayerTextDrawHide(i, Capture[i]);
			DestroyDynamic3DTextLabel(BikerText[i]);
			for(new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(i,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
		}
	}
	BikerCapture[atack] = 0;
	BikerCapture[other] = 0;
	BikerCapture[reasons] = -1;
	BikerKills[atack] = 0;
	BikerKills[other] = 0;
	KillTimer(SetTimer("updateBikers",2000,true));
    GangZoneStopFlashForAll(ZoneCaptureBiker);
	GangZoneHideForAll(ZoneCaptureBiker);
	return true;
}
IsCaptedBiker(memberfrac)
{
	switch(memberfrac)
	{
		case 24: return IsCapted[hells]?1:0;
		case 26: return IsCapted[warloks]?1:0;
		case 29: return IsCapted[pagans]?1:0;
	}
	return 0;
}
publics: Kicking(playerid)
{
	Kick(playerid);
	return 1;
}
GetGunsDialog(playerid)
{
	return ShowPlayerDialogEx(playerid, 5225, DIALOG_STYLE_TABLIST_HEADERS, "Взять оружие",
	"Оружие\tПатроны\t\n\
	Desert Eagle\t[21п]\t\n\
	Shotgun\t[30п]\t\n\
	SMG\t[90п]\t\n\
	M4A1\t[150п]\t\n\
	Rifle\t[30п]\t\n\
	Броня\t\t\n\
	Спец оружие\t\t\n\
	Снять броню\t\t",
	"Взять", "Отмена");
}
#include "..\gamemodes\default\OnDialogResponse.pwn"
#include "..\gamemodes\default\OnPlayerDisconnect.pwn"
publics: SetPlayerSpawn(playerid)
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
	/*	switch(PTEMP[playerid][pMember])
		{
		    case 1,3,10,19,21:
		    {
				if(GetPVarInt(playerid, "Fraction_Duty") == 1)
				{
					Update3DTextLabelText(LabelRank[playerid], TEAM_GROVE_COLOR, GetRank(playerid));
					//SendMes(playerid, -1, " Ты %s", GetRank(playerid));
				}
				else
				{
					Update3DTextLabelText(LabelRank[playerid], TEAM_GROVE_COLOR, "");
				}
		    }
		    default:
		    {
				Update3DTextLabelText(LabelRank[playerid], TEAM_GROVE_COLOR, "");
				//SCM(playerid, -1, " Ты никто");
		    }
		}*/
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
//	if(!GetPVarInt(playerid, "Fraction_Duty") && PTEMP[playerid][pSpawnChange][0] == 1)
	switch(PTEMP[playerid][pLevel])
	{
	case 1:
		{
			if(PTEMP[playerid][pExp] >= 4)
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
#include "..\gamemodes\default\OnPlayerDeath.pwn"
#include "..\gamemodes\default\OnPlayerSpawn.pwn"
#include "..\gamemodes\default\OnPlayerEnterCheckpoint.pwn"
public OnPlayerLeaveCheckpoint(playerid) return true;
#include "..\gamemodes\default\OnPlayerEnterRaceCheckpoint.pwn"
public OnPlayerLeaveRaceCheckpoint(playerid) return true;
public OnRconCommand(cmd[]) return true;
public OnRconLoginAttempt(ip[], password[], success) return false;
#include "..\gamemodes\default\OnPlayerPickUpDynamicPickup.pwn"
#include "..\gamemodes\default\OnPlayerSelectedMenuRow.pwn"
#include "..\gamemodes\default\OnPlayerExitedMenu.pwn"
publics: SetAllPlayerCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi, num)
{
	foreach(i)
	{
		SetPlayerCheckpoint(i,allx,ally,allz, radi);
		if (num != 255) gPlayerCheckpointStatus[i] = num;
	}
}
publics: SetAllCopCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi)
{
	foreach(i)
	{
		if(IsAArm(i))
		{
			SetPlayerCheckpoint(i,allx,ally,allz, radi);
		}
	}
	return true;
}
publics: UnSurfCar(carid)
{
	foreach(i)
	{
		new model = GetVehicleModel(carid);
		if(model != 430 && model != 454 &&
				model != 478 && model != 446 &&
				model != 452 && model != 453 &&
				model != 454 && model != 472 &&
				model != 473 && model != 484 &&
				model != 493 && model != 539 &&
				model != 595)
		if(GetPlayerSurfingVehicleID(i) == carid)
		{
			new Float:p[0x3]; GetPlayerPos(IsVehicleOccupied(GetPlayerSurfingVehicleID(i)),p[0x0],p[0x1],p[0x2]);
			GetXYInBackOfPlayer(i,p[0x0],p[0x1],3.0);
			t_SetPlayerPos(i,p[0x0],p[0x1],p[0x2]);
		}
	}
	return;
}
#include "..\gamemodes\default\OnPlayerStateChange.pwn"
LockCar(playerid,carid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(!IsAPlane(carid) && !IsABoat(carid) && !IsABike(carid) && AutoSaloon[playerid] != true)
		{
			PlayerTextDrawColor(playerid,StatusShow[playerid], -16776961);
			PlayerTextDrawSetString(playerid,StatusShow[playerid],"Lock");
			PlayerTextDrawShow(playerid,StatusShow[playerid]);
		}
	}
	GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
	return SetVehicleParamsEx(carid,engine,lights,alarm,true,bonnet,boot,objective);
}
#include "..\gamemodes\default\OnPlayerExitVehicle.pwn"
#include "..\gamemodes\default\OnPlayerRequestClass.pwn"
SetPlayerCriminal(playerid, killerid[], reason[])
{
	PTEMP[playerid][pCrimes]++;
	strmid(PlayerCrime[playerid][pVictim], killerid, 0, strlen(killerid), 50);
	strmid(PlayerCrime[playerid][pAccusedof], reason, 0, strlen(reason), 50);
	if(PTEMP[playerid][pWantedLevel] > 6)
	{
		PTEMP[playerid][pWantedLevel] = 6;
	}
	foreach(i)
	{
		if(PTEMP[i][pMember] == 1 || PTEMP[i][pLeader] == 1 || PTEMP[i][pMember] == 10 || PTEMP[i][pLeader] == 10 || PTEMP[i][pMember] == 2 ||PTEMP[i][pLeader] == 2 || PTEMP[i][pMember] == 21 || PTEMP[i][pLeader] == 21)
		{
		    if(GetPVarInt(i, "Fraction_Duty"))
		    {
				format(string, 144, " [Wanted %i: %s] [Сообщает: %s] [%s]",PTEMP[playerid][pWantedLevel], PTEMP[playerid][pName],killerid,reason);
				SCM(i, 0xffc801c8,string);
			}
		}
	}
	SendMes(playerid, COLOR_LIGHTRED, " [Wanted %i: %s] [Сообщает: %s] [%s]",PTEMP[playerid][pWantedLevel], PTEMP[playerid][pName],killerid,reason);
	return 1;
}
GetPlayerSpeed(playerid)
{
    new Float:Coord[4];
    GetPlayerVelocity(playerid, Coord[0], Coord[1], Coord[2]);
    Coord[3] = floatsqroot(floatpower(floatabs(Coord[0]), 2.0) + floatpower(floatabs(Coord[1]), 2.0) + floatpower(floatabs(Coord[2]), 2.0)) * 213.3;
    return floatround(Coord[3]);
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
publics: UpdateFresh()
{
	foreach(i)
	{
	    if(IsABank(i))
		{
		    GameTextForPlayer(i, "~n~~n~~n~~n~~n~~n~~n~~n~~g~PRESS  ~w~~k~~VEHICLE_ENTER_EXIT~",1300,4);
		}
		new carid = GetPlayerVehicleID(i);
		if(GetPVarInt(i,"BoneStol")) SelectTextDraw(i,0x33AAFFFF);
		if(GetPVarInt(i, "SelectAvto") != -1) SelectTextDraw(i,0x0080FFFF);
		if(GetRoulet(i) && !GetPVarInt(i,"RStol") && !GetPVarInt(i,"CasinoRank")) GameTextForPlayer(i,"~g~PRESS ENTER",1300,4);
		if(IsPlayerNearGarage(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER && IsPlayerInVehicle(i, house_car[i])) GameTextForPlayer(i,"~g~PRESS ~k~~VEHICLE_HORN~",1300,4);
		if(!GetPVarInt(i,"BoneStol") && IsPlayerNearBone(i) != -1) GameTextForPlayer(i,"~g~PRESS ENTER",1300,4);
		SetPVarInt(i, "NewPlayerAmmo", GetPlayerAmmo(i));
		if(GetPVarInt(i, "NewPlayerAmmo") != GetPVarInt(i, "PlayerAmmo"))
		{
			OnPlayerAmmoChange(i, GetPVarInt(i, "NewPlayerAmmo"), GetPVarInt(i, "PlayerAmmo"));
			SetPVarInt(i, "PlayerAmmo", GetPVarInt(i, "NewPlayerAmmo"));
		}
		if(!IsPlayerApplyAnimation(i, "KO_skid_front") && PlayerCuffedTime[i])
		{
		    ApplyAnimation(i,"PED","KO_skid_front",6.0,0,1,1,1,0);
		}
		if(Works[i])
		{
			if(JobCP[i] != 2 && usemesh[i] != 1) return true;
			if(IsPlayerInAnyVehicle(i)) return true;
			if(IsPlayerApplyAnimation(i, "FALL_back") ||
					IsPlayerApplyAnimation(i, "FALL_collapse") ||
					IsPlayerApplyAnimation(i, "FALL_fall") ||
					IsPlayerApplyAnimation(i, "FALL_front") ||
					IsPlayerApplyAnimation(i, "FALL_glide") ||
					IsPlayerApplyAnimation(i, "FALL_land") ||
					IsPlayerApplyAnimation(i, "FALL_skyDive"))
			{
				SCM(i, COLOR_LIGHTRED, " Вы уронили ящик");
				DisablePlayerCheckpoint(i);
				mesh[i] = 0;
				usemesh[i] = 0;
				if(IsPlayerAttachedObjectSlotUsed(i,1)) RemovePlayerAttachedObject(i,1);
				SetPlayerCheckpoint(i,2230.3528,-2286.1353,14.3751,1.5);
				JobCP[i] = 1;
			}
		}
        if(GetPVarInt(i, "matovoz_rob"))
		{
			if(IsPlayerApplyAnimation(i, "FALL_back") ||
					IsPlayerApplyAnimation(i, "FALL_collapse") ||
					IsPlayerApplyAnimation(i, "FALL_fall") ||
					IsPlayerApplyAnimation(i, "FALL_front") ||
					IsPlayerApplyAnimation(i, "FALL_glide") ||
					IsPlayerApplyAnimation(i, "FALL_land") ||
					IsPlayerApplyAnimation(i, "FALL_skyDive"))
			{
				SCM(i, COLOR_LIGHTRED, " Вы уронили ящик");
				DisablePlayerCheckpoint(i);
		        MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad] += 250;
				format(string, sizeof(string), "Кол-во груза\n%i", MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad]);
        		UpdateDynamic3DTextLabelText(Rob3DText, 0xEDEA9FAA, string);
				RemovePlayerAttachedObject(i, 1);
				SetPlayerSpecialAction (i, SPECIAL_ACTION_NONE);
				DeletePVar(i, "matovoz_rob");
			}
		}
		new currentveh;
		currentveh = GetPlayerVehicleID(i);
		new Float:vehx, Float:vehy, Float:vehz;
		GetVehiclePos(currentveh, vehx, vehy, vehz);
		new vehicleid = GetPlayerVehicleID(i);
		new vehiclemodel = GetVehicleModel(vehicleid);
		if(vehiclemodel == 514 || vehiclemodel == 515 || vehiclemodel == 403)
		{
			if(GetVehicleTrailer(GetPlayerVehicleID(i)) != 0 && GetPlayerState(i) == PLAYER_STATE_DRIVER && vehz < 0)
			{
				SCM(i, 0xFF6347AA, " Вы потеряли свой грузовик");
				SCM(i, 0xFF6347AA, " Вы потеряли свой груз");
				peremennn[i] = 0;
				SetVehicleToRespawn(GetPlayerVehicleID(i));
				DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(i)));
				DriverJob[i] = false;
				PTEMP[i][pDgruz] = 0;
				Gruz[i] = 0;
				bGruz[i] = 0;
			}
		}
		if(vehiclemodel == 514 || vehiclemodel == 515 || vehiclemodel == 403)
		{
			if(GetVehicleTrailer(GetPlayerVehicleID(i)) == 0 && GetPlayerState(i) == PLAYER_STATE_DRIVER && vehz < 0)
			{
				SCM(i, 0xFF6347AA, " Вы потеряли свой грузовик");
				SetVehicleToRespawn(GetPlayerVehicleID(i));
				DriverJob[i] = false;
			}
		}
		GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
		new Keys,ud;
		new up,dn;
		GetPlayerKeys(i,Keys,up,dn);
		if(GetPVarInt(i,"RStol") && !GetPVarInt(i,"RStavka"))
		{
			new Float:p;
			GetPlayerFacingAngle(i,p);
			switch(GetPVarInt(i,"RStol"))
			{
			case 1..4:
				{
					if(p >= 0 && p <= 190)
					{
						if(dn < 0) Down(i);
						else if(dn > 0) Up(i);
						else if(up < 0) Left(i);
						else if(up > 0) Right(i);
					}
					else
					{
						if(dn > 0) Down(i);
						else if(dn < 0) Up(i);
						else if(up > 0) Left(i);
						else if(up < 0) Right(i);
					}
				}
			default:
				{
					if(p >= 0 && p <= 130 || p >= 290 && p <= 360)
					{
						if(dn > 0) Down(i);
						else if(dn < 0) Up(i);
						else if(up > 0) Left(i);
						else if(up < 0) Right(i);
					}
					else
					{
						if(dn < 0) Down(i);
						else if(dn > 0) Up(i);
						else if(up < 0) Left(i);
						else if(up > 0) Right(i);
					}
				}
			}
		}
		if(IsAAntidm(i) && GetPlayerWeapon(i) > 1)
		{
		    if(!IsAArm(i) && !IsACop(i) && PTEMP[i][pAdmin] < 1)
			SetPlayerArmedWeapon(i,0);
		}
		if(Spectate[i] && ud == KEY_DOWN && !LastReconClick[i][0])
		{
			PlayerPlaySound(i, 1083, 0.0, 0.0, 0.0);
			LastReconClick[i][0] = ud;
			if(ReconSelectSub[i] == INVALID_TEXT_DRAW)
			{
				DisableEnableReconButton(i, ReconSelect[i], 0);
				if(ReconSelect[i] >= 15)
				{
					ReconSelect[i] = 7;
					DisableEnableReconButton(i, ReconSelect[i], 1);
				}
				else
				{
					ReconSelect[i]++;
					DisableEnableReconButton(i, ReconSelect[i], 1);
				}
				return 1;
			}
			else
			{
				DisableEnableReconButton(i, ReconSelectSub[i], 0);
				if(ReconSelectSub[i] >= ReconBounds[i][1])
				{
					ReconSelectSub[i] = ReconBounds[i][0];
					DisableEnableReconButton(i, ReconSelectSub[i], 1);
				}
				else
				{
					ReconSelectSub[i]++;
					DisableEnableReconButton(i, ReconSelectSub[i], 1);
				}
			}
		}
		if(Spectate[i] && SpecAd[i] != INVALID_PLAYER_ID) return PlayerTextDrawShow(i, ReconPlayer[34]);
		if(SERVERTEST)
		{
			SendMes(i,COLOR_BLUE,"i - %i, CAMERAMODE - %i",i,GetPlayerCameraMode(i));
			new Float:XS, Float:YS, Float:ZS;
			GetPlayerPos(i,XS,YS,ZS);
			SendMes(i,COLOR_BLUE,"i - %i, X - %.1f, Y - %.1f, Z - %.1f",i,XS,YS,ZS);
			new Float:xw, Float:yw, Float:zw;
			GetPlayerVelocity(i,xw,yw,zw);
			SendMes(i,COLOR_BLUE,"i - %i, X - %.1f, Y - %.1f, Z - %.1f",i,xw,yw,zw);
		}
		if(Sounds == 1)
		{
			new distance = floatround( GetPlayerDistanceFromPoint( i, streampos[0], streampos[1], streampos[2]) );
			if(UseSound[i] == 0 && distance <= rads)
			{
				PlayAudioStreamForPlayer(i, stream, streampos[0], streampos[1], streampos[2], rads, 1);
				UseSound[i] = 1;
			}
			if(UseSound[i] == 1 && distance > rads)
			{
				UseSound[i] = 0;
			}
		}
		if(IsPlayerInAnyVehicle(i)) SetPlayerArmedWeapon(i,0);
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER && (GetPlayerWeapon(i) == WEAPON_DEAGLE || GetPlayerWeapon(i) == WEAPON_SHOTGSPA || GetPlayerWeapon(i) == WEAPON_SAWEDOFF || GetPlayerWeapon(i) == WEAPON_MINIGUN || GetPlayerWeapon(i) == WEAPON_MP5  )) SetPlayerArmedWeapon(i,0);
	}
	return true;
}
publics: Fresh()
{
	if(players > 1000) return SendRconCommand("exit");
	new hour, minute, second;
	gettime(hour, minute, second);
	FixHour(hour);
	hour = shifthour;
	for(new i = GetVehiclePoolSize(); i >= 0; i--)
	{
		if(!GetVehicleModel(i)) continue;
		new Float:health;
		GetVehicleHealth(i, health);
		if(health != 1000 && health < CarHealth[i]) CarHealth[i] = health;
		if(CarHealth[i] < health && CarHealth[i] != 0 && !TimeHealth[i]) SetVehHealth(i,CarHealth[i]);
		if(TimeHealth[i]) TimeHealth[i]--;
	}
	for(new i;i<MAX_BONE;i++)
	{
		if(BoneInfo[i][GameStart] > 0)
		{
			BoneInfo[i][GameStart] --;
			foreach(g)
			{
				if(GetPVarInt(g,"BoneStol")-1 == i && (GetPVarInt(g,"BoneStol_") || BoneInfo[i][Crupie] == g))
				{
					if(BoneInfo[i][GameStart] == 0 && GetPVarInt(g,"BoneStol_") == 1) SetPVarInt(g,"BoneStol_",random(11) + 2), UpdateBone(i);
					else if(BoneInfo[i][GameStart] > 0)
					{
						format(YCMDstr,18,"~g~%i",BoneInfo[i][GameStart]);
						GameTextForPlayer(g,YCMDstr,1200,6);
					}
				}
			}
			if(BoneInfo[i][GameStart] == 0) return ShowItog(i);
		}
	}
	if(random(5) == 1) {
		for(new i = 1; i <= TOTALATM; i++)
		{
			if(!LABELATM_) UpdateDynamic3DTextLabelText(LABELATM[i],COLOR_LIGHTBLUE,"Введите: \"/ATM\"");
			else UpdateDynamic3DTextLabelText(LABELATM[i],0x00D900FF,"Нажмите: \"ENTER\"");
		}
		if(!LABELATM_) LABELATM_ = true;
		else LABELATM_ = false; }
	foreach(i)
	{
		if(!PTEMP[i][pLogin])
		{
			if(GetPVarInt(i,"time_logged") > 0)
			{
				SetPVarInt(i,"time_logged",GetPVarInt(i,"time_logged")-1);
				if(GetPVarInt(i,"time_logged") == 0)
				{
					SCM(i, COLOR_LIGHTRED," Время на ввод пароля ограничено!");
					ShowPlayerDialogEx(i, -1, 0, "f", "f", "f", "");
					Kick(i);
				}
			}
		}
		else
		{
			if(GetPVarInt(i,"h_stall") && !IsPlayerInRangeOfPoint(i, 5, StallInfo[GetPVarInt(i,"h_stall")][stPos][0], StallInfo[GetPVarInt(i,"h_stall")][stPos][1], StallInfo[GetPVarInt(i,"h_stall")][stPos][2]))
			{
				UpdateDynamic3DTextLabelText(StallInfo[GetPVarInt(i,"h_stall")][stText], 0xFF8C37FF,"Не работает");
				DeletePVar(i,"h_stall");
				SetPlayerSkin(i,PTEMP[i][pChar][0]);
			}
			if(PTEMP[i][pNarcoLomka] > 0) { new ttt = random(2); if(ttt == 1) { ApplyAnimation(i, "CRACK", "crckdeth1", 4.0, 0, 0, 1, 1, 1); } else { ApplyAnimation(i, "CRACK", "crckdeth3", 4.0, 0, 0, 1, 1, 1); } }
			onCheckAirBrk(i);
			if(Spectate[i] && SpecAd[i] != INVALID_PLAYER_ID)
			{
				//***********************************************
				new thewarns = 0;
				new sid = SpecAd[i];
				if(PTEMP[sid][pWarns] == 0) thewarns = 0;
				if(PTEMP[sid][pWarns] != 0 && PTEMP[sid][pWarns] != 0) thewarns = thewarns-PTEMP[sid][pWarns];
				if(PTEMP[sid][pWarns] != 0 && PTEMP[sid][pWarns] == 0) thewarns = PTEMP[sid][pWarns];
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
				if(GetPVarInt(SpecAd[i], "AFK_Time") > 2)
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
				if(GetPlayerState(SpecAd[i]) == PLAYER_STATE_DRIVER) GetVehicleParamsEx(GetPlayerVehicleID(SpecAd[i]), engine, lights, alarm, doors, bonnet, boot, objective);
				if(GetPlayerState(SpecAd[i]) != PLAYER_STATE_DRIVER) e_status = "-";
				else if(engine) e_status = "On";
				else e_status = "Off";
				new maxspeed = 0;
				if(IsPlayerInAnyVehicle(SpecAd[i])) maxspeed = MaxSpeedCar[GetVehicleModel(GetPlayerVehicleID(SpecAd[i]))-400];
				//format(sobtest,sizeof(sobtest),"~n~%s / %s",(ACCCheck[SpecAd[i]] == 10 ? ("On"):("Off")),(PTEMP[SpecAd[i]][Rassa] == 16 ? ("On"):("Off")));
				format(httpquery, sizeof(httpquery), "~n~%i : %i / %i~n~%i~n~%.0f~n~%.0f~n~%.0f~n~%i / %i~n~%i~n~%i : %i~n~%i / %i : %i%%~n~%i / %i : %i%%~n~%i : %i~n~%s",
				PTEMP[SpecAd[i]][pLevel], PTEMP[SpecAd[i]][pExp], (PTEMP[SpecAd[i]][pLevel]+1)*4, thewarns, aermor,hppp,health,SpeedVehicle(SpecAd[i]), maxspeed,GetPlayerPing(SpecAd[i]),tttgtg,Weapons[SpecAd[i]][GetPlayerWeapon(SpecAd[i])],NumberShot[SpecAd[i]],NumberShotTarget[SpecAd[i]],percentshot,TimeNumberShot[SpecAd[i]],TimeNumberShotTarget[SpecAd[i]],tpercentshot,GetPVarInt(SpecAd[i], "AFK_Time"), 1000, e_status);
				PlayerTextDrawSetString(i, ReconPlayer[5],httpquery);
				//format(strr1, sizeof(strr1), "%s~n~(%i)  %s~n~~n~~r~]Armour: ~w~%.0f~n~~g~]Hp: ~w~%.0f~n~~g~]CarHp: ~w~%.0f~n~~r~]Money: ~w~%i~n~~b~]Ammo: ~w~%i~n~~p~]Warns: ~w~%i~n~~y~]Ping: ~w~%i~n~~b~]Speed: ~w~%i",getName(SpecAd[i]),SpecAd[i],afktext,aermor,hppp,health,PTEMP[SpecAd[i]][Cash],tttgtg,thewarns,GetPlayerPing(SpecAd[i]),SpeedVehicle(SpecAd[i]));
				//PlayerTextDrawSetString(i, NikPlayer,strr1);
			}
			if(GetPVarInt(i, "w_time") < gettime() && GetPVarInt(i,"w_id") && !GetPVarInt(i,"InWorkshop"))
			{
				new x = GetPVarInt(i,"w_id");
				for(new x_ = 0; x_ < 9; x_++)
				{
					WorkshopList[x_][x][wlID] = WorkshopList[x_+1][x][wlID];
					strmid(WorkshopList[x_][x][wlName],WorkshopList[x_+1][x][wlName],0,strlen(WorkshopList[x_][x][wlName]), MAX_PLAYER_NAME);
					WorkshopList[x_+1][x][wlID] = -1;
					strmid(WorkshopList[x_+1][x][wlName],"", 0, strlen(""), 5);
				}
				if(WorkshopList[0][x][wlID] != -1 && strlen(WorkshopList[0][x][wlName]))
				{
					SCM(WorkshopList[0][x][wlID],COLOR_BLUE,"Подошла ваша очередь. У вас есть 2 минуты что бы прибыть к гаражу!");
					SetPVarInt(WorkshopList[0][x][wlID],"w_time", gettime() + 120);
					SetPlayerCheckpoint(WorkshopList[0][x][wlID],WorkshopInfo[x][wMenu][0],WorkshopInfo[x][wMenu][1],WorkshopInfo[x][wMenu][2], 10.0);
				}
				DisablePlayerCheckpoint(i);
				DeletePVar(i,"w_time");
				DeletePVar(i,"w_id");
			}
			if(GetPVarInt(i, "AntiBreik") > 0) SetPVarInt(i, "AntiBreik", GetPVarInt(i, "AntiBreik") - 1);
			if(timecar[i] > 0)
			{
				timecar[i]--;
				if(nachalvzlom[i] == 0) format(YCMDstr,10,"~r~%s",Convert(timecar[i]));
				else format(YCMDstr,10,"~g~BREAK");
				GameTextForPlayer(i, YCMDstr, 2000, 6);
				if(timecar[i] == 1)
				{
					if(PTEMP[i][pSkilla] > 0) PTEMP[i][pSkilla]--;
					SCM(i, COLOR_BLUE, " SMS: Ты нас разочаровал! Миссия провалена");
					avtocar[i] = 0;
					rabotaon[i] = 0;
					GangZoneDestroy(gangzonesa[i]);
				}
			}
			if(TriggerStatus[i] != 0) if(!PlayerToPoint(2.0,i,TriggerPos[i][0],TriggerPos[i][1],TriggerPos[i][2])) TriggerStatus[i] = 0; // Устанавливаем 0 что бы снова взять триггер
			if(sms_timer[i] > 0) sms_timer[i]--;
			if(GetPVarInt(i,"fish_ready") == 3 && GetPVarInt(i,"fish_began") && GetPVarInt(i,"fish_time") < gettime())
			{
				ApplyAnimation(i,"SWORD","sword_IDLE",50.0,0,1,1,1,1);
				if(Sonar[IsAtFishPlace(i)] > 0) SetPVarInt(i,"fish_chanse",random(20));
				if(IsABoat(i)) SetPVarInt(i,"fish_chanse",random(10));
				if(GetPVarInt(i,"fish_chanse") == 0) GameTextForPlayer(i,"~g~~n~!", 5000, 6), SetPVarInt(i,"fish_time", gettime() + random(5) + 2);
				else if(GetPVarInt(i,"fish_chanse") == 1) GameTextForPlayer(i,"~n~~n~~y~!", 5000, 6), SetPVarInt(i,"fish_time", gettime() + random(5) + 2);
				else if(GetPVarInt(i,"fish_chanse") == 2) GameTextForPlayer(i,"~n~~n~~r~~n~!", 5000, 6), SetPVarInt(i,"fish_time", gettime() + random(3) + 2);
				else GameTextForPlayer(i,"~b~!",11000,6);
			}
			if(startaddiction[i] == 1 && PTEMP[i][pAddiction] > 2000 && PTEMP[i][pNarcoLomka] == 0)
			{
				if(GetPVarInt(i,"player_paint") == 2) return true;
				SCM(i, 0x9F0000AA, " ~~~~~~~~ У вас началась ломка ~~~~~~~~");
				SCM(i, -1, " (( Вызвать медика - /call => [2] Скорая помощь || Принять наркотик - /usedrugs ))");
				PTEMP[i][pNarcoLomka] = 1;
			}
			//
			if(PTEMP[i][pDrivingSkill] > 1 && GetPlayerState(i) == PLAYER_STATE_DRIVER && !IsANoLimiter(GetPlayerVehicleID(i)))
			{
				PTEMP[i][pDrivingSkill]--;
				switch(PTEMP[i][pDrivingSkill])
				{
				case 1: SCM(i, COLOR_GREEN, " Ваш навык вождения повышен. (( Нажмите клавишу \"CTRL\" для выключения ограничителя скорости ))"),accept_car_damage[i] = 0;
				case 300,600,900,1200: SCM(i, COLOR_GREEN, " Ваш навык вождения повышен."),accept_car_damage[i] = 0;
				}
			}
			if(PTEMP[i][pDrivingSkill] > 0 && GetPlayerState(i) == PLAYER_STATE_DRIVER && !IsANoLimiter(GetPlayerVehicleID(i)))
			{
				new Float:veh[3];
				GetVehicleVelocity(GetPlayerVehicleID(i),veh[0],veh[1],veh[2]);
				switch(PTEMP[i][pDrivingSkill])
				{
				case 1..300: if(SpeedVehicle(i) > 50) setVehicleSpeed(GetPlayerVehicleID(i),50);
				case 301..600: if(SpeedVehicle(i) > 45) setVehicleSpeed(GetPlayerVehicleID(i),45);
				case 601..900: if(SpeedVehicle(i) > 40) setVehicleSpeed(GetPlayerVehicleID(i),40);
				case 901..1200: if(SpeedVehicle(i) > 35) setVehicleSpeed(GetPlayerVehicleID(i),35);
				}
			}
			if(CellTime[i] > 0)
			{
				if (CellTime[i] == cchargetime)
				{
					CellTime[i] = 1;
					if(Mobile[Mobile[i]] == i) PTEMP[i][pMobile] = PTEMP[i][pMobile]+callcost;
					CellTime[i] = CellTime[i] +1;
					if (Mobile[Mobile[i]] == 999 && CellTime[i] == 5)
					{
						if(IsPlayerConnected(Mobile[i]))
						{
							format(string, 90, "У %s звонит мобильник",Name(Mobile[i]));
							ProxDetector(30.0, Mobile[i], string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						}
					}
				}
				if(CellTime[i] == 0 && PTEMP[i][pMobile] > 0)
				{
					format(string, 64, "~w~Phone~n~~r~%i", PTEMP[i][pMobile]);
					GameTextForPlayer(i, string, 5000, 1);
				}
			}
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(i)) && peremennn[i] == 0) // если  прицеп есть
			{
				peremennn[i] = 1;
			}
			else if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(i)) && peremennn[i] == 1)
			{
				if(bGruz[i] == 0) return true;
				PTEMP[i][pDgruz] -= 3;
				SCM(i, 0xFF6347AA, " Вы потеряли часть груза");
				peremennn[i] = 0;
				if(PTEMP[i][pDgruz] < 0) PTEMP[i][pDgruz] = 1;
			}
			if(GetPVarInt(i, "GunCheckTime") == 0 && PTEMP[i][pAdmin] == 0)
			{
				new weaponid, ammo;
				for (new it = 1; it < 11; it++)
				{
					GetPlayerWeaponData(i, it, weaponid, ammo);
					if(ammo > Weapons[i][weaponid] && weaponid != 46)
					{
						DelGun(i);
						CheatKick(i, 029);
					}
					else if(PTEMP[i][pLogin]) Weapons[i][weaponid] = ammo;
				}
			}
			if(GetPVarInt(i, "GunCheckTime") > 0) SetPVarInt(i, "GunCheckTime", GetPVarInt(i, "GunCheckTime") - 1);
			if(PTEMP[i][pSatiety] > 100) PTEMP[i][pSatiety] = 100;
			if(PTEMP[i][pWantedLevel] > 6) PTEMP[i][pWantedLevel] = 6, SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel] );
			if(PTEMP[i][pZakonp] > 100) PTEMP[i][pZakonp] = 100;
			if(PTEMP[i][pZakonp] < -100) PTEMP[i][pZakonp] = -100;
			if(LabelOn[i] == 0 && PTEMP[i][pWantedLevel] >= 0)
			{
				LabelOn[i] = 1;
    			LabelRecognition[i] = Create3DTextLabel("Преступник!",0xFF000044, 30.0, 40.0, 50.0, 40.0,0);
				Attach3DTextLabelToPlayer(LabelRecognition[i], i, 0.0, 0.0, 0.4);
			}
			if(PTEMP[i][pWantedLevel] >= 0)
			{
				switch(PTEMP[i][pWantedLevel])
				{
						case 0..2:Update3DTextLabelText(LabelRecognition[i], 0xFF000044, "Преступник!");
						case 3..4:Update3DTextLabelText(LabelRecognition[i], 0xFF000099, "Преступник!");
						case 5..6:Update3DTextLabelText(LabelRecognition[i], 0xFF0000FF, "Преступник!");
				}
			}
			if(LabelOn[i] == 1 && PTEMP[i][pWantedLevel] <= 1) Delete3DTextLabel(LabelRecognition[i]), LabelOn[i] = 0;
			if(GetPVarInt(i, "BusTime") > 0)
			{
				SetPVarInt(i, "BusTime", GetPVarInt(i, "BusTime") - 1);
				format(string,10,"~r~%i",GetPVarInt(i, "BusTime"));
				GameTextForPlayer(i, string, 2000, 6);
				if(GetPVarInt(i, "BusTime") == 0)
				{
					if(GetPVarInt(i,"BusRepairMoney") > GetPVarInt(i, "BusMoney")) SetPVarInt(i,"BusRepairMoney",PTEMP[i][pPayCheck]);
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
			if(GetPVarInt(i, "TimeBus") > 0)
			{
				SetPVarInt(i, "TimeBus", GetPVarInt(i, "TimeBus") - 1);
				format(string,32,"~r~%i",GetPVarInt(i, "TimeBus"));
				GameTextForPlayer(i, string, 2000, 6);
				if(GetPVarInt(i, "TimeBus") == 0)
				{
					DeletePVar(i, "TimeBus");
					new type = GetPVarInt(i, "TypeBus"), p = pPressed[i];
					SetPVarInt(i, "BusStop", 1);
					if(type == 1) SetPlayerRaceCheckpoint(i,0,BusCityLS[p][0],BusCityLS[p][1],BusCityLS[p][2],BusCityLS[p][3],BusCityLS[p][4],BusCityLS[p][5],5.0);
					if(type == 2) SetPlayerRaceCheckpoint(i,0,BusCitySF[p][0],BusCitySF[p][1],BusCitySF[p][2],BusCitySF[p][3],BusCitySF[p][4],BusCitySF[p][5],5.0);
					if(type == 3) SetPlayerRaceCheckpoint(i,0,BusCityLV[p][0],BusCityLV[p][1],BusCityLV[p][2],BusCityLV[p][3],BusCityLV[p][4],BusCityLV[p][5],5.0);
					if(type == 4) SetPlayerRaceCheckpoint(i,0,BusSchool[p][0],BusSchool[p][1],BusSchool[p][2],BusSchool[p][3],BusSchool[p][4],BusSchool[p][5],5.0);
					if(type == 5) SetPlayerRaceCheckpoint(i,0,BusLSLV[p][0],BusLSLV[p][1],BusLSLV[p][2],BusLSLV[p][3],BusLSLV[p][4],BusLSLV[p][5],5.0);
					if(type == 6) SetPlayerRaceCheckpoint(i,0,BusLSZavodi[p][0],BusLSZavodi[p][1],BusLSZavodi[p][2],BusLSZavodi[p][3],BusLSZavodi[p][4],BusLSZavodi[p][5],5.0);
				}
			}
			if(IsSmoking[i] == 1)
			{
				format(YCMDstr, sizeof(YCMDstr), " %s докуривает сигарету.", Name(i));
				ProxDetector(30.0, i, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				new Float:PlayerHeal;
				GetPlayerHealth(i, PlayerHeal);
				if(PlayerHeal < 120) SetPlayerHealth(i, PlayerHeal+3);
				SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
			}
			if(IsSmoking[i] == 51 || IsSmoking[i] == 31 || IsSmoking[i] == 11)
			{
				format(YCMDstr, sizeof(YCMDstr), " %s курит сигарету.", Name(i));
				ProxDetector(30.0, i, YCMDstr, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				new Float:PlayerHeal;
				GetPlayerHealth(i, PlayerHeal);
				if(PlayerHeal < 120) SetPlayerHealthAC(i, PlayerHeal+3);
			}
			if(IsSmoking[i] > 0) IsSmoking[i] -= 1;
			if(Works[i] == true && JobCP[i] == 2) if(usemesh[i] == 1) mesh[i] +=1;
			if(Flood[i] > 0) Flood[i] -=1;
			if(hour >= 12 && minute == 10 && second == 0) startaddiction[i] = 1;
			if(PTEMP[i][pMuted] > 1) PTEMP[i][pMuted] --;
			if(PTEMP[i][pMuted] == 1) PTEMP[i][pMuted] = 0, SCM(i,COLOR_LIGHTRED, " Вам включили чат. Пожалуйста соблюдайте правила");
			if(PTEMP[i][pJailTime] > 0)
			{
				if(PTEMP[i][pJailTime] > 1) PTEMP[i][pJailTime]--;
				if(PTEMP[i][pJailTime] == 1)
				{
					if(PTEMP[i][pMestoJail] == 1) SetPlayerInterior(i, 0), SetPlayerPos(i,1553.4962,-1675.2714,16.1953), SetPlayerFacingAngle(i, 95.0636);
					if(PTEMP[i][pMestoJail] == 2) SetPlayerInterior(i, 0), SetPlayerPos(i,-1607.1873,721.3649,12.2721), SetPlayerFacingAngle(i, 2.3026);
					if(PTEMP[i][pMestoJail] == 3) SetPlayerInterior(i, 0), SetPlayerPos(i,2334.8467,2454.9456,14.9688), SetPlayerFacingAngle(i, 115.7874);
					if(PTEMP[i][pMestoJail] == 4) SetPlayerWorldBounds(i,20000.0000,-20000.0000,20000.0000,-20000.0000), SetPlayerInterior(i, 0), SetPlayerPos(i, 86.9821,1181.0541,18.6641);
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
			if(PlayerTazeTime[i] >= 1) PlayerTazeTime[i] += 1;
			if(PlayerTazeTime[i] >= 10) PlayerTazeTime[i] = 0, TogglePlayerControllable(i, 1);
			if(TieTime[i] > 0) TieTime[i]--;
			if(PlayerCuffed[i] == 1)
			{
				if(PlayerCuffedTime[i] <= 0)
				{
					TogglePlayerControllable(i, 1);
					PlayerCuffed[i] = 0;
					PlayerCuffedTime[i] = 0;
					PlayerTazeTime[i] = 1;
					ClearAnimations(i);
				}
				else PlayerCuffedTime[i] -= 1;
			}
			if(PlayerCuffed[i] == 2)
			{
				if(PlayerCuffedTime[i] <= 0)
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
	if(paint_info[0] > 0) GetPaintball();
	if(race_info[0] > 0) GetRace();
	if(WarStart > 0) WarStart--;
	for(new i = 0; i < 20; i++)
	{
		if(MFrakCD[i] > 1)
		{
			MFrakCD[i] --;
			if(MFrakCD[i] == 900) SendFamilyMessage(i,0x114D71AA, " У вас осталось 15 минут на подготовку!");
			else if(MFrakCD[i] == 600) SendFamilyMessage(i,0x114D71AA, " У вас осталось 10 минут на подготовку!");
			else if(MFrakCD[i] == 180) SendFamilyMessage(i,COLOR_RED, " Пора решать кому будет пренадлежать бизнес. Осталось 3 минуты");
		}
	}
	if(war > 0) war -=1;
	if ((hour > ghour) || (hour == 0 && ghour == 23))
	{
		format(string, 90, " Сейчас времени %i:00 часов",hour);
		BroadCast(-1,string);
		ghour = hour;
		PayDay();
		SaveMySQL(0);
		for(new i = 1; i <= TOTALCASINO; i++) SaveMySQL(1,i);
		for(new i = 1; i <= TOTALSHOPS; i++) SaveMySQL(3,i);
		for(new i = 1; i <= TotalBizz; i++) SaveMySQL(4,i);
		for(new i = 1; i <= TotalHouse; i++) SaveMySQL(5,i);
		for(new i = 1; i <= ALLKVARTIRI; i++) SaveMySQL(6,i);
		for(new i = 1; i <= AllPODEZD; i++) SaveMySQL(7,i);
		for(new i = 1; i <= TOTALATM; i++) SaveMySQL(8,i);
		for(new i = 0; i <= TOTALFARM; i++) SaveMySQL(9,i);
		for(new i = 0; i < 20; i++) strmid(ATMADVERTISE[i],"", 0, strlen(""),150);
		for(new i = 1; i < MAX_PLAYERS; i++) Sonar[i] = random(2000);
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
	return true;
}
LeaderList(playerid)
{
	ShowPlayerDialogEx(playerid, 22813, DIALOG_STYLE_MSGBOX, "ID FRACTION", "[0] Гражданский\n[1] LSPD\n[2] FBI\n[3] ARMY SF\n[4] MEDIC SF\n[5] LCN\n[6] YAKUZA\n[7] MAYOR\n[8] CASINO CALIGULA\n[9] SFN\n[10] SFPD\n[11] INSTRUCTOR\n[12] BALLAS\n[13] VAGOS\n[14] RUS MAFIA\n[15] GROVE\n[16] LSN\n[17] AZTEC\n[18] RIFA\n[19] LVA\n[20] LVN\n[21] LVPD\n[22] MEDIC LS\n[23-32] BIKERS\n[23] MEDIC LV", "Закрыть", "");
}
kShowStats(playerid, targetid)
{
	new tempstring[100];
	new httpquery[2500];
	format(httpquery, sizeof(httpquery),"");
	new stringersqw[30],stringersqx[35],teampstringds[30],teampstringd[30],teampstring[70];
	format(stringersqw,sizeof(stringersqw),"Имя:\t\t\t\t%s\n\n",Name(targetid));
	strcat(httpquery,stringersqw);

	format(stringersqx,sizeof(stringersqx),"Уровень:\t\t\t%d\n",PTEMP[targetid][pLevel]);
	strcat(httpquery,stringersqx);
	new nxtlevlel = PTEMP[targetid][pLevel]+1;
	new expert = nxtlevlel*4;
	format(teampstringds,sizeof(teampstringds),"Exp:\t\t\t\t%d/%d\n",PTEMP[targetid][pExp],expert);
	strcat(httpquery,teampstringds);

	format(teampstringd,sizeof(teampstringd),"Деньги:\t\t\t%d",PTEMP[targetid][pCash]);
	strcat(httpquery,teampstringd);

	format(teampstring,sizeof(teampstring),"\nВарнов:\t\t\t%d",PTEMP[targetid][pWarns]);
	strcat(httpquery,teampstring);

	if(PTEMP[targetid][OffWarns] && PTEMP[targetid][pWarns])
	{
		new strisaq[35];
		format(strisaq,sizeof(strisaq),"\nВарн до: %s",date("%dd/%mm/%yyyy  %hh:%ii",PTEMP[targetid][OffWarns]));
		strcat(httpquery,strisaq);
	}

	new qdqwdsds[35],tempstringessrd[35],tempstringessr[35],tempstringesdr[35],tempstringesr[35];
	new tempstringe[35],tempstrings[35],tempstringq[35],tempstringqs[35],tempstringer[35];
	format(qdqwdsds,sizeof(qdqwdsds),"\nЗаконопослушность:\t\t%d\n",PTEMP[targetid][pZakonp]);
	strcat(httpquery,qdqwdsds);

	format(tempstringessr,sizeof(tempstringessr),"Преступлений:\t\t%d\n",PTEMP[targetid][pCrimes]);
	strcat(httpquery,tempstringessr);

	format(tempstringesdr,sizeof(tempstringesdr),"Смертей в розыске:\t\t%d\n",PTEMP[targetid][pWantedDeaths]);
	strcat(httpquery,tempstringesdr);

	format(tempstringesr,sizeof(tempstringesr),"Арестов:\t\t\t%d\n",PTEMP[targetid][pArrested]);
	strcat(httpquery,tempstringesr);

	format(tempstringer,sizeof(tempstringer),"Уровень розыска:\t\t%d\n",PTEMP[targetid][pWantedLevel]);
	strcat(httpquery,tempstringer);

	format(tempstringqs,sizeof(tempstringqs),"Дата регистрации:\t\t%s\n",PTEMP[targetid][pDataReg]);
	strcat(httpquery,tempstringqs);

	format(tempstringq,sizeof(tempstringq),"Зависимость:\t\t\t%d\n",PTEMP[targetid][pAddiction]);
	strcat(httpquery,tempstringq);

	format(tempstringe,sizeof(tempstringe),"Наркотики:\t\t\t%d\n",PTEMP[targetid][pDrugs]);
	strcat(httpquery,tempstringe);

	format(tempstrings,sizeof(tempstrings),"Материалы:\t\t\t%d\n",PTEMP[targetid][pMats]);
	strcat(httpquery,tempstrings);

	format(tempstringessrd,sizeof(tempstringessrd),"Рыбы поймано:\t\t\t%.2f кг\n",PTEMP[targetid][pFishes]);
	strcat(httpquery,tempstringessrd);

	new tempisoo[70];
	switch(PTEMP[targetid][pMember])
	{
	case 0: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tНет\n");
	case 1: strcat(httpquery,"Организиция:\t\t\tPolice LS\n");
	case 2: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tFBI\n");
	case 3: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tArmy SF\n");
	case 4: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tМедики SF\n");
	case 5: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tLa Cosa Nostra\n");
	case 6: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tYakuza\n");
	case 7: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tМэрия\n");
	case 8: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tCasino\n");
	case 9: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tSF News\n");
	case 10: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tPolice SF\n");
	case 11: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tИнструкторы\n");
	case 12: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tBallas Gang\n");
	case 13: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tVagos Gang\n");
	case 14: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tРусская Мафия\n");
	case 15: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tGrove Street\n");
	case 16: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tLS News\n");
	case 17: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tAztecas Gang\n");
	case 18: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tRifa Gang\n");
	case 19: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tArmy LV\n");
	case 20: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tLV News\n");
	case 21: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tPolice LV\n");
	case 24: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tHell's Angels MC\n");
	case 26: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tWarlocks MC\n");
	case 29: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tPagans MC\n");
	case 22: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tМедики LS\n");
	case 33: format(tempisoo,sizeof(tempisoo),"Организиция:\t\t\tМедики ЛВ\n");
	}
	strcat(httpquery,tempisoo);

	switch(PTEMP[targetid][pMember])
	{
	case 0: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\t-\n");
	case 1,10,21:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКадет\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tОфицер\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМл. Сержант\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСержант\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПрапорщик\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСт. Прапорщик\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМл. Лейтенант\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЛейтенант\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСт. Лейтенант\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКапитан\n");
			case 11: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМайор\n");
			case 12: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПодполковник\n");
			case 13: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПолковник\n");
			case 14: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tШериф\n");

			}
		}
	case 19:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tРядовой\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЕфрейтор\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМл. Сержант\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСержант\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСтаршина\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПрапорщик\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСт. Прапорщик\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМл. Лейтенант\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЛейтенант\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСт. Лейтенант\n");
			case 11: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКапитан\n");
			case 12: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМайор\n");
			case 13: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПодполковник\n");
			case 14: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПолковник\n");
			case 15: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГенерал\n");
			}
		}
	case 3:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЮнга\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМатрос\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСт. Матрос\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСтаршина\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМл.Мичман\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМичман\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tCт.Мичман\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМл.Лейтенант\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЛейтенант\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСт. Лейтенант\n");
			case 11: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКапитан-Лейтенант\n");
			case 12: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКапитан 1-го ранга\n");
			case 13: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКонтр-Адмирал\n");
			case 14: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tВице-Адмирал\n");
			case 15: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tАдмирал\n");
			}
		}
	case 9,16,20:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСтажер\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЗвукооператор\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЗвукорежиссер\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tРепортер\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tВедущий\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tРедактор\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГл.Редактор\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tТех.Директор\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПрограмный Директор\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГен.Директор\n");
			}
		}
	case 7:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring, sizeof(tempstring), "Должность:\t\t\t\tСекретарь\n");
			case 2: format(tempstring, sizeof(tempstring), "Должность:\t\t\t\tАдвокат\n");
			case 3: format(tempstring, sizeof(tempstring), "Должность:\t\t\t\tОхранник\n");
			case 4: format(tempstring, sizeof(tempstring), "Должность:\t\t\t\tНач.Охранны\n");
			case 5: format(tempstring, sizeof(tempstring), "Должность:\t\t\t\tЗам.Мэра\n");
			case 6: format(tempstring, sizeof(tempstring), "Должность:\t\t\t\tМэр\n");
			}
		}
	case 11:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСтажер\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКонсультант\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЭкзаменатор\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\tМл.Инструктор\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tИнструктор\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКоординатор\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМл.Менеджер\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСт.Менеджер\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tДиректор\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tУправляющий\n");
			}
		}
	case 2:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСтажер\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tДежурный\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМладший Агент\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\tАгент отдела ГНК\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tАгент отдела CID\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГлава отдела ГНК\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГлава отдела CID\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tИнспектор FBI\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЗам. Директора FBI\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tДиректор FBI\n");
			}
		}
	case 15:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПлейя\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tХастла\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКилла\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЮонг Г\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГангста\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tО.Г\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМобста\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tДе Кинг\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЛегенд\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМэд Дог\n");
			}
		}
	case 12:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tБлайд\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tБастер\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКрекер\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГун бро\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tАп бро\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГангстер\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tФедерал блок\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tФолкс\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tРайч нигга\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tБиг Вилли\n");
			}
		}
	case 17:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГринго\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tНовато\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЕстимадо\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tАмиго\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЕрмано\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСолдато\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tБандито\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tАджунто\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЕмпинадо\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПадре\n");
			}
		}
	case 13:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tНовато\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tОрдинарио\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЛокал\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tВерификадо\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tБандито\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tV.E.G.\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tАссесино\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЛидер V.E.G.\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПадрино\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПадре\n");
			}
		}
	case 18:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПерро\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tТирадор\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГеттор\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЛас Геррас\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМирандо\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСабио\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tИнвасор\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tТесорреро\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tНестро\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПадре\n");
			}
		}
	case 5:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tНовичок\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tАссосиато\n");
			case 3: format(tempstring,sizeof(tempstring),"Должность:\t\tСомбаттенте\n");
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСолдато\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tБоец\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСото-капо\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКапо\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМладший Босс\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tКоньсельери\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tДон\n");
			}
		}
	case 4,22,33:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 1: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tИнтерн\n");
			case 2: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСанитар\n");
			case 3:
				{
					if(PTEMP[targetid][pSex] == 1) format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМед.Брат\n");
					else if(PTEMP[targetid][pSex] == 2) format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tМед.Сестра\n");
				}
			case 4: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tСпасатель\n");
			case 5: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tНарколог\n");
			case 6: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tДоктор\n");
			case 7: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tПсихолог\n");
			case 8: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tХирург\n");
			case 9: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tЗам Глав.Врача\n");
			case 10: format(tempstring,sizeof(tempstring),"Должность:\t\t\t\tГлав.Врач\n");
			}
		}
	}
	strcat(httpquery,tempstring);

	switch(PTEMP[targetid][pJob])
	{
	case 0: format(tempstring,sizeof(tempstring),"Работа:\t\t\tБезработный\n");
	case 1: format(tempstring,sizeof(tempstring),"Работа:\t\t\tВодитель автобуса\n");
	case 2: format(tempstring,sizeof(tempstring),"Работа:\t\t\tМеханик\n");
	case 3: format(tempstring,sizeof(tempstring),"Работа:\t\t\tПродавец хотдогов\n");
	case 4: format(tempstring,sizeof(tempstring),"Работа:\t\t\tТаксист\n");
	case 5: format(tempstring,sizeof(tempstring),"Работа:\t\t\tРазвозчик продуктов\n");
	case 6: format(tempstring,sizeof(tempstring),"Работа:\t\t\tТренер\n");
	case 8: format(tempstring,sizeof(tempstring),"Работа:\t\t\tИнкассатор\n");
	case 9: format(tempstring,sizeof(tempstring),"Работа:\t\t\tПрораб\n");
	case 99: format(tempstring,sizeof(tempstring),"Работа:\t\t\tДальнобойщик\n");
	}
	strcat(httpquery,tempstring);

	switch(PTEMP[targetid][pDonateRank])
	{
	case 0:
		{
			switch(PTEMP[targetid][pLevel])
			{
			case 1: format(tempstring,sizeof(tempstring),"Статус:\t\t\t\tНовичок\n");
			case 2,3: format(tempstring,sizeof(tempstring),"Статус:\t\t\t\tОсвоившийся\n");
			case 4,5: format(tempstring,sizeof(tempstring),"Статус:\t\t\t\tОсвоившийся\n");
			case 10: format(tempstring,sizeof(tempstring),"Статус:\t\t\t\tПостоянный игрок\n");
			case 6,7,8,9: format(tempstring,sizeof(tempstring),"Статус:\t\t\t\tОсвоившийся\n");
			default: format(tempstring,sizeof(tempstring),"Статус:\t\t\t\tДед\n");
			}
		}
	case 1: format(tempstring,sizeof(tempstring),"Статус:\t\t\t\tBRONZE VIP\n");
	case 2: format(tempstring,sizeof(tempstring),"Статус:\t\t\t\tSILVER VIP\n");
	case 3: format(tempstring,sizeof(tempstring),"Статус:\t\t\t\tGOLD VIP\n");
	}
	strcat(httpquery,tempstring);

	format(tempstring,sizeof(tempstring),"Жена/Муж:\t\t\t%s\n",PTEMP[targetid][pMarriedTo]);
	strcat(httpquery,tempstring);

	if(PTEMP[targetid][pSex]==1)format(tempstring,sizeof(tempstring),"Пол:\t\t\t\tМужчина\n");
	else format(tempstring,sizeof(tempstring),"Пол:\t\t\t\tЖенщина\n");
	strcat(httpquery,tempstring);


	if(PTEMP[playerid][pAdmin] >= 2)
	{
		format(tempstring,sizeof(tempstring),"\n\nБанк:\t\t\t\t%d\n",PTEMP[targetid][pBank]);
		strcat(httpquery,tempstring);
		format(tempstring,sizeof(tempstring),"Дом:\t\t\t\t%d\n",PTEMP[targetid][pPHouseKey]);
		strcat(httpquery,tempstring);
		format(tempstring,sizeof(tempstring),"Бизнес:\t\t\t%d\n",PTEMP[targetid][pPBizzKey]);
		strcat(httpquery,tempstring);
		format(tempstring,sizeof(tempstring),"Квартира:\t\t\t%d\n",PTEMP[targetid][pKvartiraKey]);
		strcat(httpquery,tempstring);
		format(tempstring,sizeof(tempstring),"Скин:\t\t\t\t%d\n",PTEMP[targetid][pChar]);
		strcat(httpquery,tempstring);
		format(tempstring,sizeof(tempstring),"СкинФр:\t\t\t%d\n",PTEMP[targetid][pModel]);
		strcat(httpquery,tempstring);

	}
	ShowPlayerDialogEx(playerid,9999,0,"Статистика персонажа",httpquery,"Готово","");
	return 1;
}
GetFracName(i)
{
	new ttext[32];
    switch(i)
	{
	case 1: ttext = "Police LS";
	case 2: ttext = "FBI";
	case 3: ttext = "Army SF";
	case 4: ttext = "Медики";
	case 5: ttext = "La Cosa Nostra";
	case 6: ttext = "Yakuza";
	case 7: ttext = "Мэрия";
	case 8: ttext = "Casino";
	case 9: ttext = "News SF";
	case 10: ttext = "Police SF";
	case 11: ttext = "Автошкола";
	case 12: ttext = "Ballas Gang";
	case 13: ttext = "Vagos Gang";
	case 14: ttext = "Русская Мафия";
	case 15: ttext = "Grove Street";
	case 16: ttext = "News LS";
	case 17: ttext = "Aztecas Gang";
	case 18: ttext = "Rifa Gang";
	case 19: ttext = "Army LV";
	case 20: ttext = "News LV";
	case 21: ttext = "Police LV";
	case 24: ttext = "Hell's Angels MC";
	case 26: ttext = "Warlocks MC";
	case 29: ttext = "Pagans MC";
	default: ttext = "Нет";
	}
	return ttext;
}
ShowStats(playerid,targetid)
{
	if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new atext[32];
		new jtext[20];
		new drank[20];
		switch(PTEMP[targetid][pSex])
		{
		case 1: atext = "Мужчина";
		default: atext = "Женщина";
		}
		
		switch(PTEMP[targetid][pJob])
		{
		case 1: jtext = "Водитель автобуса";
		case 2: jtext = "Механик";
		case 3: jtext = "Продавец хотдогов";
		case 4: jtext = "Таксист";
		case 5: jtext = "Развозчик продуктов";
		case 6: jtext = "Тренер";
		case 8: jtext = "Инкассатор";
		case 9: jtext = "Прораб";
		case 99: jtext = "Дальнобойщик";
		default: jtext = "Нет";
		}
		switch(PTEMP[targetid][pDonateRank])
		{
		case 1: drank = "BRONZE";
		case 2: drank = "SILVER";
		case 3: drank = "GOLD";
		default: drank = "Нет";
		}
		new marry[32];
		if(!strcmp(PTEMP[targetid][pMarriedTo], "NULL", true))
		{
		    marry = "-";
		}
		else format(marry, 32, "%s", PTEMP[targetid][pMarriedTo]);
		new name[MAX_PLAYER_NAME];
		new wdeaths = PTEMP[targetid][pWantedDeaths];
		new level = PTEMP[targetid][pLevel];
		new exp = PTEMP[targetid][pExp];
		new nxtlevel = PTEMP[targetid][pLevel]+1;
		new expamount = nxtlevel*levelexp;
		new pnumber = PTEMP[targetid][pPnumber];
		new warns = PTEMP[targetid][pWarns];
		new zakon = PTEMP[targetid][pZakonp];
		new addiction = PTEMP[targetid][pAddiction];
		new crimes = PTEMP[targetid][pCrimes];
		new arrests = PTEMP[targetid][pArrested];
		GetPlayerName(targetid, name, sizeof(name));
		new coordsstring[2400];
		new msg[] = "[0] Имя\t\t\t\t%s\n[1] Уровень\t\t\t%i\n[2] Exp\t\t\t\t%i/%i\n[3] VIP\t\t\t\t%s\n[4] Пол\t\t\t\t%s\n[5] Организация\t\t%s\n[6] Ранг\t\t\t\t%s\n[7] Работа\t\t\t%s\n[8] Жена/Муж\t\t\t%s\n[9] Телефон\t\t\t%i\n[10] Дата регистрации\t\t%s\n[11] Законопослушность\t%i\n[12] Преступлений\t\t%i\n[13] Арестов\t\t\t%i\n[14] Смертей в розыске\t%i\n[15] Зависимость\t\t%i\n[16] Варнов\t\t\t%i";
		format(coordsstring, 2400, msg, name,level,exp,expamount,drank,atext,GetFracName(PTEMP[playerid][pMember]),GetRank(targetid),jtext,marry,pnumber,PTEMP[targetid][pDataReg],zakon,crimes,arrests,wdeaths,addiction,warns);
		ShowPlayerDialogEx(playerid,10004,DIALOG_STYLE_LIST, "Статистика персонажа",coordsstring, "Выбрать", "Назад");
	}
	return true;
}
QuestStats(playerid,targetid)
{
	if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new gaatext[64];
		switch(PTEMP[playerid][pQuestL])
		{
		case 0: gaatext ="Нет";
		case 1: gaatext ="Гость";
		case 2: gaatext ="Трудоголик";
		}
		new aatext[256];
		switch(PTEMP[playerid][pQuestL])
		{
		case 0: aatext = "{E39C0E}[Завершенные линии]\n\t{FBB431}Гость\n\t{7F7E7B}Трудоголик\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование";
		case 1: aatext = "{E39C0E}[Завершенные линии]\n\t{7F7E7B}Гость\n\t{7F7E7B}Трудоголик\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование\n\t{7F7E7B}Тестирование";
		}
		new name[MAX_PLAYER_NAME];
		new Quest = PTEMP[playerid][pQuest];
		new QuestP = PTEMP[playerid][pQuestP];
		new QuestF = PTEMP[playerid][pQuestF];
		new QuestPF = PTEMP[playerid][pQuestPF];
		GetPlayerName(targetid, name, sizeof(name));
		new coordsstring[1200];
		new msg[] = "{E09A18}===============================\n\t{FFFFFF}Имя: {FBB431}%s\n{E09A18}===============================\n\n{E39C0E}[Выполняется]\n\t{FFFFFF}С.линия: {FBB431}%s\n\t{FFFFFF}Квест: {FBB431}%d / %d\n\t{FFFFFF}Прогресс: {FBB431}%d / %d\n\n%s\n{E09A18}===============================";
		format(coordsstring, 1000, msg, name,gaatext,Quest,QuestF,QuestP,QuestPF,aatext);
		ShowPlayerDialogEx(playerid,10005,DIALOG_STYLE_MSGBOX, "Статистика",coordsstring, "Готово", "");
	}
	return true;
}
publics:SetPlayerToTeamColor(playerid)
{
	switch (PTEMP[playerid][pMember])
	{
	case 0:	SetPlayerColor(playerid, TEAM_HIT_COLOR);
	case 1: SetPlayerColor(playerid, 0x110CE7FF);
	case 2: SetPlayerColor(playerid, 0x313131AA);
	case 3: SetPlayerColor(playerid, COLOR_GREEN);
	case 4: SetPlayerColor(playerid, 0x954F4FFF);
	case 5: SetPlayerColor(playerid, 0xDDA701FF);
	case 6: SetPlayerColor(playerid, COLOR_REDD);
	case 7: SetPlayerColor(playerid, 0x114D71FF);
	case 8: SetPlayerColor(playerid, 0xB313E7FF);
	case 9: SetPlayerColor(playerid, 0x49E789FF);
	case 10: SetPlayerColor(playerid, 0x110CE7FF);
	case 11: SetPlayerColor(playerid, 0x139BECFF);
	case 12: SetPlayerColor(playerid, 0xB313E7FF);
	case 13: SetPlayerColor(playerid, 0xDBD604AA);
	case 14: SetPlayerColor(playerid, COLOR_GRAD1);
	case 15: SetPlayerColor(playerid, 0x009F00AA);
	case 16: SetPlayerColor(playerid, 0x40848BAA);
	case 17: SetPlayerColor(playerid, TEAM_AZTECAS_COLOR);
	case 18: SetPlayerColor(playerid, 0x2A9170FF);
	case 19: SetPlayerColor(playerid, COLOR_GREEN);
	case 20: SetPlayerColor(playerid, 0xE6284EFF);
	case 21: SetPlayerColor(playerid, 0x110CE7FF);
	case 22: SetPlayerColor(playerid, 0x954F4FFF);
	case 23: SetPlayerColor(playerid, 0x9ED201FF);
	case 24: SetPlayerColor(playerid, 0xB30000FF);
	case 25: SetPlayerColor(playerid, 0x49E789FF);
	case 26: SetPlayerColor(playerid, 0xF45000FF);
	case 27: SetPlayerColor(playerid, 0xF45000FF);
	case 28: SetPlayerColor(playerid, 0xFFEE8AFF);
	case 29: SetPlayerColor(playerid, 0x114D71FF);
	case 30: SetPlayerColor(playerid, 0xE6284EFF);
	case 31: SetPlayerColor(playerid, 0xB30000FF);
	case 32: SetPlayerColor(playerid, 0xFF9DB6FF);
	case 33: SetPlayerColor(playerid, 0x954F4FFF);
	case 34: SetPlayerColor(playerid, 0x7df9ffFF);
	}
	return true;
}
publics:GameModeExitFunc()
{
	KillTimer(Hptimer);
	KillTimer(freshtimer);
	KillTimer(reklamatimer);
	GameModeExit();
	//	mysql_close(connectionHandle);
	return true;
}

#include "..\gamemodes\default\OnGameModeExit.pwn"
#include "..\gamemodes\default\OnGameModeInit.pwn"
#include "..\gamemodes\custom\CreateVehicles.pwn"

GetClosestforeach(p1)
{
	new Float:dis, Float:dis2, player;
	player = -1;
	dis = 99999.99;
	foreach(x)
	{
		if (x != p1)
		{
			dis2 = GetDistanceBetweenPlayers(x, p1);
			if (dis2 < dis && dis2 != -1.00)
			{
				dis = dis2;
				player = x;
			}
		}
	}
	return player;
}
PayChecks(i)
{
	if(PTEMP[i][pZakonp] < 100) PTEMP[i][pZakonp]++;
	if(!GetPVarInt(i,"Fraction_Duty")) return 0;
	switch(PTEMP[i][pMember])
	{
	case 1..4,7,10,11,19,22,21:
		{
			if(FracBank[0][fKazna] <=0)
			{
				SCM(i, COLOR_GREY, " [Мэрия] Казна штата пуста, зарплаты нет...");
				return 0;
			}
		}
	}
	if(PTEMP[i][pMember] == 7)
	{
		switch(PTEMP[i][pRank])
		{
		case 1,2: return 6000; case 3: return 8000;
		case 4: return 10000; case 5: return 16000;
		case 6: return 20000;
		}
	}
	else if(PTEMP[i][pMember] == 2)
	{
		switch(PTEMP[i][pRank])
		{
		case 1: return 6000;
		case 2..10: return 6000+(PTEMP[i][pRank]*1000);
		}
	}
	else if(PTEMP[i][pMember] == 1 || PTEMP[i][pMember] == 10 || PTEMP[i][pMember] == 21) return 4500+(PTEMP[i][pRank]*500);
	else if(PTEMP[i][pMember] == 3 || PTEMP[i][pMember] == 19) return 2500+(PTEMP[i][pRank]*500);
	else if(PTEMP[i][pMember] == 4)
	{
		switch(PTEMP[i][pRank])
		{
		case 1..8: return 2000+(PTEMP[i][pRank]*500);
		case 9: return 8000;
		case 10: return 10000;
		}
	}
	else if(IsAMafia(i)) return 2500+(PTEMP[i][pRank]*1000);
	else if(PTEMP[i][pMember] == 11) return 1500*PTEMP[i][pRank];
	else if(IsAGang(i))
	{
		new null = 0;
		for(new idx = 1; idx <= TOTALGZ; idx++) if(GZInfo[idx][gFrakVlad] == PTEMP[i][pMember]) null++;
		return null*50;
	}
	else if(PTEMP[i][pMember] == 9 || PTEMP[i][pMember] == 16 || PTEMP[i][pMember] == 20)
	{
	    new null = 0;
	    switch(PTEMP[i][pMember])
	    {
	        case 9: null = newsZP[1];
	        case 16: null = newsZP[0];
			case 20: null = newsZP[2];
	    }
		return (PTEMP[i][pRank] * null + null);
	}
	return 0;
}
PayDay()
{
	for(new i = 0; i < 20; i++) FrakCD[i] = 0;
	for(new i = 1; i <= TOTALGZ; i++)
	{
		if(GZInfo[i][gFrakVlad] == 12) TotalGzB++;
		if(GZInfo[i][gFrakVlad] == 13) TotalGzV++;
		if(GZInfo[i][gFrakVlad] == 15) TotalGzG++;
		if(GZInfo[i][gFrakVlad] == 17) TotalGzA++;
		if(GZInfo[i][gFrakVlad] == 18) TotalGzR++;
	}
	FracBank[0][fBallas] += TotalGzB*50;
	FracBank[0][fVagos] += TotalGzV*50;
	FracBank[0][fGrove] += TotalGzG*50;
	FracBank[0][fRifa] += TotalGzR*50;
	FracBank[0][fAztek] += TotalGzA*50;
	ClearTotalGz();
	SetSVarInt("capture", gettime() + 600);
	//
	GetBizz();
	GetHome();
	GetShop();
	GetKvart();
	GetFarm();
	//
	if(armmatbi < 0) armmatbi = 0;
	if(armmatsf < 0) armmatsf = 0;
	foreach(i)
	{
		if(!IsPlayerConnected(i)) return true;
		if(PTEMP[i][pLogin] == 0) continue;
		new b = PTEMP[i][pPBizzKey];
		PTEMP[i][pPayCheck] = PayChecks(i);
		DeletePVar(i,"_Hel");
		new exp = PTEMP[i][pExp];
		new nxtlevel = PTEMP[i][pLevel]+1;
		new expamount = nxtlevel*levelexp;
		PTEMP[i][ptaxiexp] += taxiexpp[i];
		if(booston == 0) PTEMP[i][pExp]++;
		else if(booston == 1)
		{
			PTEMP[i][pExp] += 3;
			if(PTEMP[i][pExp] > expamount)
			PTEMP[i][pExp] = expamount;
		}
		//if(PTEMP[i][pMember] == 3 && armmatbi <= 0) PTEMP[i][pPayCheck] = 0, SCM(i, COLOR_GRAD1, "Склад Армии LV пуст!");
		//if(PTEMP[i][pMember] == 19 && armmatsf <= 0) PTEMP[i][pPayCheck] = 0, SCM(i, COLOR_GRAD1, "Склад Армии SF пуст!");
		new checks = PTEMP[i][pPayCheck];
		if(PTEMP[i][pDonateRank] > 0) format(string, 20, "PayDay");
		else format(string, 20, "~w~PayDay");
		GameTextForPlayer(i, string, 5000, 1);
		if(PTEMP[i][pAdmin] > 0) PTEMP[i][pBank] += 60000;
		if(PTEMP[i][pHelper] == 1 && SDuty[i] == 1) PTEMP[i][pBank] += 30000;
		if(PTEMP[i][pDonateRank] > 0) SCM(i, COLOR_GOLD, "--------===[ VIP КЛИЕНТ БАНКА SA ]===-------");
		else SCM(i, COLOR_GRAD1, "--------===[ КЛИЕНТ БАНКА SA ]===-------");
		if(PTEMP[i][pPayCheck] >= 500)
		{
			format(string, 128, "***** Налог государству: -%i вирт *****",PTEMP[i][pPayCheck]/10);
			SCM(i, 0xFF8C37AA, string);
			PTEMP[i][pBank] -= PTEMP[i][pPayCheck]/10;
			FracBank[0][fKazna] += checks/10;
		}
		else if(PTEMP[i][pPayCheck] <= 500)
		{
			format(string, 128, "***** Налог государству: -0 вирт *****"),
			SCM(i, 0xFF8C37AA, string);
		}
		if(PTEMP[i][pBank] > 50 && PTEMP[i][pKrisha] != 0) PTEMP[i][pBank] -= 50, PTEMP[i][pDolg] += 50;
		if(PTEMP[i][pCash] > 50 && PTEMP[i][pKrisha] != 0) PTEMP[i][pCash] -= 50, PTEMP[i][pDolg] += 50;
		format(string, 128, " Счёт за телефон: -%i вирт", PTEMP[i][pMobile]);
		SCM(i, 0xFF8C37AA, string);
		PTEMP[i][pBank]-=PTEMP[i][pMobile];
		PTEMP[i][pMobile] = 0;
		if(PTEMP[i][pDonateRank]) SCM(i, COLOR_GOLD, " ");
		else SCM(i, -1, " ");
		switch(PTEMP[i][pMember])
		{
		case 1,10,21: format(string, 128, " Зарплата Полиции: %i вирт", checks);
		case 3,19: format(string, 128, " Зарплата Армии: %i вирт", checks);
		case 2: format(string, 128, " Зарплата ФБР: %i вирт", checks);
		case 7: format(string, 128, " Зарплата Мэрии: %i вирт", checks);
		case 4,22: format(string, 128, " Зарплата Медиков: %i вирт", checks);
		case 11: format(string, 128, " Зарплата Автошколы: %i вирт", checks);
		case 5,6,14: format(string, 128, " Зарплата организации: %i вирт", checks);
		case 12,13,15,17,18: format(string, 128, " Зарплата Бандитов: %i вирт", checks);
		default: format(string, 128, " Зарплата: %i вирт", checks);
		}
		if(PTEMP[i][pDonateRank] > 0) SCM(i, COLOR_GOLD, string);
		else SCM(i, -1, string);
		PTEMP[i][pBank] += checks;
		checks = 0;
		if(PTEMP[i][pDonateRank] > 0) format(string, 128, " Текущий баланс: %i вирт", PTEMP[i][pBank]), SCM(i, COLOR_GOLD, string);
		else format(string, 128, " Текущий баланс: %i вирт", PTEMP[i][pBank]), SCM(i, -1, string);
		if(HGet(i))
		{
			if(PTEMP[i][pDonateRank]) SendMes(i,COLOR_GOLD," Домашний счёт: %i вирт", HouseInfo[PTEMP[i][pPHouseKey]][hTakings]);
			else SendMes(i,-1," Домашний счёт: %i вирт", HouseInfo[PTEMP[i][pPHouseKey]][hTakings]);
		}
		if(BGet(i))
		{
			if(PTEMP[i][pDonateRank]) SendMes(i,COLOR_GOLD," Плата за электроэнергию: %i вирт",BizzLandTax[b]);
			else SendMes(i,-1," Плата за электроэнергию: %i вирт",BizzLandTax[b]);
			BizzInfo[b][bLandTax] -= BizzLandTax[b];
			BizzPay[b] = 0;
		}
		if(FGet(i))
		{
			FarmStatPayS[PTEMP[i][pPFarmKey]][0] = FarmStatPay[PTEMP[i][pPFarmKey]][0];
			FarmStatPayS[PTEMP[i][pPFarmKey]][1] = FarmStatPay[PTEMP[i][pPFarmKey]][1];
			FarmStatPayS[PTEMP[i][pPFarmKey]][2] = FarmStatPay[PTEMP[i][pPFarmKey]][2];
			FarmStatPayS[PTEMP[i][pPFarmKey]][3] = FarmStatPay[PTEMP[i][pPFarmKey]][3];
			FarmStatPayS[PTEMP[i][pPFarmKey]][4] = FarmStatPay[PTEMP[i][pPFarmKey]][4];
			FarmStatPayS[PTEMP[i][pPFarmKey]][5] = FarmStatPay[PTEMP[i][pPFarmKey]][5];
			FarmStatPayS[PTEMP[i][pPFarmKey]][6] = FarmStatPay[PTEMP[i][pPFarmKey]][6];
			FarmStatPayS[PTEMP[i][pPFarmKey]][7] = FarmStatPay[PTEMP[i][pPFarmKey]][7]; // ZP
			FarmStatPayS[PTEMP[i][pPFarmKey]][8] = FarmStatPay[PTEMP[i][pPFarmKey]][8];
			FarmStatPay[PTEMP[i][pPFarmKey]][0] = 0;
			FarmStatPay[PTEMP[i][pPFarmKey]][1] = 0;
			FarmStatPay[PTEMP[i][pPFarmKey]][2] = 0;
			FarmStatPay[PTEMP[i][pPFarmKey]][3] = 0;
			FarmStatPay[PTEMP[i][pPFarmKey]][4] = 0;
			FarmStatPay[PTEMP[i][pPFarmKey]][5] = 0;
			FarmStatPay[PTEMP[i][pPFarmKey]][6] = 0;
			FarmStatPay[PTEMP[i][pPFarmKey]][7] = 0;
			FarmStatPay[PTEMP[i][pPFarmKey]][8] = 0;
		}
		if(PTEMP[i][pDonateRank] >= 1) SCM(i, COLOR_GOLD, "===================================");
		else SCM(i,COLOR_GRAD1, "===================================");
		if(exp >= expamount-1)
		{
			PTEMP[i][pLevel] += 1, PTEMP[i][pExp] = 0, DollahScoreUpdate(i), SCM(i, COLOR_LIGHTGREEN, " Поздравляем! Ваш лвл повысился");
		}
		if(PTEMP[i][pPBizzKey] != 999 && BizzInfo[b][bProducts] < 0)
		{
			SCM(i, COLOR_LIGHTRED, " Ваш бизнес был продан за неуплату электроэнергии / простаивание");
			SCM(i, COLOR_LIGHTRED, " Если по истечению {ffffff}12 {FF6347}часов бизнес будет закрыт, он будет продан гос-ву");
			BizzInfo[b][bLockTime] = 1;
		}
		if(PTEMP[i][pPBizzKey] != 999 && BizzInfo[b][bLockTime] > 1 && BizzInfo[b][bProducts] < 0)
		{
			format(string, 160, " Ваш бизнес закрыт уже {ffffff}%i {FF6347}час(а/ов)",BizzInfo[b][bLockTime]);
			SCM(i, COLOR_LIGHTRED,string);
			SCM(i, COLOR_LIGHTRED, " Если по истечению {ffffff}12 {FF6347}часов бизнес будет закрыт, он будет продан гос-ву");
		}
		if(PTEMP[i][pPBizzKey] != 999 && BizzInfo[b][bLockTime] > 12 && BizzInfo[b][bProducts] < 0)
		{
			SCM(i, COLOR_LIGHTRED," Ваш бизнес был продан за неуплату электроэнергии / простаивание");
			SCM(i, COLOR_LIGHTRED," Ваши деньги за бизнес были перечислены на ваш счет");
			BizzInfo[b][bLocked] = 1;
			BizzInfo[b][bProducts] = 0;
			strmid(BizzInfo[b][bOwner], "None", 0, strlen("None"), 32);
			PTEMP[i][pBank] +=BizzInfo[b][bTill]+BizzInfo[b][bLandTax];
			BizzInfo[b][bTill] = 0;
			BizzInfo[b][bPrice] = 0;
			BizzInfo[b][bMafia] = 0;
			BizzInfo[b][bLandTax] = 0;
			BizzPay[b] = 0;
			BizzInfo[b][bLicense] = 0;
			BGet(i);
			format(YCMDstr, sizeof(YCMDstr), "%s\nПродаётся", BizzInfo[b][bMessage],BizzInfo[b][bBuyPrice]);
			UpdateDynamic3DTextLabelText(BizzInfo[b][bLabel], COLOR_GREEN, YCMDstr);
			PTEMP[i][pPBizzKey] = 999;
		}
		if(PTEMP[i][pPBizzKey] != 999 && BizzInfo[b][bLandTax] < 0)
		{
			SCM(i, COLOR_LIGHTRED," Ваш бизнес был продан за неуплату электроэнергии / простаивание");
			SCM(i, COLOR_LIGHTRED," Ваши деньги за бизнес были перечислены на ваш счет");
			BizzInfo[b][bLocked] = 1;
			BizzInfo[b][bProducts] = 0;
			strmid(BizzInfo[b][bOwner], "None", 0, strlen("None"), 32);
			PTEMP[i][pBank] +=BizzInfo[b][bTill]+BizzInfo[b][bLandTax];
			BizzInfo[b][bTill] = 0;
			BizzInfo[b][bPrice] = 0;
			BizzInfo[b][bMafia] = 0;
			BizzInfo[b][bLandTax] = 0;
			BizzPay[b] = 0;
			BizzInfo[b][bLicense] = 0;
			BGet(i);
			format(YCMDstr, sizeof(YCMDstr), "%s\nПродаётся", BizzInfo[b][bMessage],BizzInfo[b][bBuyPrice]);
			UpdateDynamic3DTextLabelText(BizzInfo[b][bLabel], COLOR_GREEN, YCMDstr);
			PTEMP[i][pPBizzKey] = 999;
		}
		if(GetPVarInt(i, "GetHome") > 0)
		{
			SCM(i, COLOR_LIGHTRED," Вы были выселены за неуплату квартплаты");
			SCM(i, COLOR_LIGHTRED," Деньги за дом вы можете получить в банке \"/GetHouseMoney\"");
			DeletePVar(i, "GetHome");
			PTEMP[i][pPHouseKey] = 9999;
			PTEMP[i][pText] = 1;
			SpawnChange[i] = 0;
		}
		if(GetPVarInt(i, "GetKvart") > 0)
		{
			SCM(i, COLOR_LIGHTRED," Вы были выселены за неуплату квартплаты");
			DeletePVar(i, "GetKvart");
			PTEMP[i][pKvartiraKey] = 9999;
			SpawnChange[i] = 0;
		}
		if(GetPVarInt(i, "GetShop") > 0)
		{
			SCM(i, COLOR_LIGHTRED," Ваша автомастерская была выставлена на аукцион за неуплату налогов");
			SCM(i, COLOR_LIGHTRED," Деньги с банка автомастерской были перечислены на ваш счет");
			DeletePVar(i, "wShop");
			DeletePVar(i, "GetShop");
		}
		if(GetPVarInt(i, "GetFarm") > 0)
		{
			SCM(i, COLOR_LIGHTRED," Ваша ферма была выставлена на аукцион за неуплату налогов");
			SCM(i, COLOR_LIGHTRED," Деньги с банка автомастерской были перечислены на ваш счет");
			PTEMP[i][pPFarmKey] = 999;
			DeletePVar(i, "GetFarm");
		}
		if(PTEMP[i][pLevel] == 5 && PTEMP[i][pExp] == 0)
		{
		    // #promo
			mysql_format(DATABASE,QUERY, 256, "SELECT pDrug FROM `"TABLE_ACCOUNTS"` WHERE name = '%s'",PTEMP[i][pName]);
			mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",13,i,"");
			if(strcmp(PTEMP[i][pDrug], "#newlife", true) == 0)
			{
				SCM(i,COLOR_BLUE," Спасибо за то, что приняли участие в развитии проекта");
				switch(booston)
				{
				case 0: SCM(i,COLOR_BLUE," Вам зачисленно 300000 вирт"),PTEMP[i][pCash] += 300000;
				case 1: SCM(i,COLOR_BLUE," Вам зачисленно 600000 вирт"),PTEMP[i][pCash] += 600000;
				}
				SCM(i,COLOR_GREEN," Рекомендуется: Сменить пароль на более сложный ( /mm >>> [6] Смена пароля )");
				SCM(i,COLOR_GREEN," Рекомендуется: Поставить проверку по IP и SuperKey ( /mm >>> [10] Безопасность )");
			}
		}
		seans[i] = 0;
		PTEMP[i][pRobHouse] = 0;
		PTEMP[i][pPayCheck] = 0;
		PTEMP[i][pPayDayHad] ++;
		PTEMP[i][pPLimitBank] = 0;
		Online[i]++;
		SaveMySQL(2, i);
	}
	return true;
}
GetDay()
{
	new saturday = 1310155200;
	new w = gettime();
	new days;
	while(w - saturday > 60*60*24)
	{
		w-=60*60*24;
		days++;
	}
	while (days >= 7) days -= 7;
	new data[12];
	switch (days)
	{
		case 0: format(data,12,"Суббота");
		case 1: format(data,12,"Воскресенье");
		case 2: format(data,12,"Понедельник");
		case 3: format(data,12,"Вторник");
		case 4: format(data,12,"Среда");
		case 5: format(data,12,"Четверг");
		case 6: format(data,12,"Пятница");
		default: format(data,12,"Что-то пошло не так");
	}
	return data;
}
split(const strsrc[], strdest[][], delimiter)
{
	new i, li, aNum, len;
	while(i <= strlen(strsrc))
	{
		if(strsrc[i] == delimiter || i == strlen(strsrc))
		{
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return true;
}
BroadCast(color, const str[])
{
	SendClientMessageToAll(color, str);
	return true;
}
ABroadCast(color, const str[], level)
{
	foreach(i)
	{
		if (PTEMP[i][pAdmin] < level || !dostup[i]) continue;
		SCM(i, color, str);
	}
}
OOCOff(color, const str[])
{
	foreach(i)
	{
		if (!GetPVarInt(i,"ooc_chat")) SCM(i, color, str);
	}
}
LSNews(color, const str[])
{
	foreach(i)
	{
		if (!lNews[i] || PTEMP[i][pMember] == 16 && lNews[i] == 1) SCM(i, color, str);
	}
}
LVNews(color, const str[])
{
	foreach(i)
	{
		if (!LvNews[i] || PTEMP[i][pMember] == 20 && LvNews[i] == 1) SCM(i, color, str);
	}
}
OOCNews(color, const str[])
{
	foreach(i)
	{
		if (!gNews[i] || PTEMP[i][pMember] == 9 && gNews[i] == 1) SCM(i, color, str);
	}
}
SendTeamMessage(color, str[])
{
	foreach(i)
	{
		if (IsAArm(i) && GetPVarInt(i,"Fraction_Duty") || IsAMedic(i) && GetPVarInt(i,"Fraction_Duty") || IsAMayor(i) && GetPVarInt(i,"Fraction_Duty") || IsACop(i) && GetPVarInt(i,"Fraction_Duty") || PTEMP[i][pMember] == 11 && GetPVarInt(i,"Fraction_Duty")) SCM(i, color, str);
	}
}
SendRadioMessage(member, color, str[])
{
	foreach(i)
	{
		if (PTEMP[i][pMember] == member || PTEMP[i][pLeader] == member) SCM(i, color, str);
	}
}
SendFamilyMessage(family, color, str[])
{
	foreach(i)
	{
		if(GetPVarInt(i,"Fraction_Duty"))
		{
			if(GetPVarInt(i,"chats") != 1)
			{
				if(PTEMP[i][pMember] == family || GetPVarInt(i,"Atisper") == family)
				{
					SCM(i, color, str);
				}
			}
		}
		else if(GetPVarInt(i,"Atisper") == family)
		{
			SCM(i, color, str);
		}
	}
}
publics: SendGangMessage(family, color, str[])
{
	foreach(i)
	{
		if(GetPVarInt(i,"Atisper") == family || PTEMP[i][pMember] == 12 || PTEMP[i][pMember] == 13 || PTEMP[i][pMember] == 15 || PTEMP[i][pMember] == 17 || PTEMP[i][pMember] == 18 )
		{
			if(!GetPVarInt(i,"family_chat")) SCM(i, color, str);
		}
	}
}
publics: SendMafiaMessage(family, color, str[])
{
	foreach(i)
	{
		if((PTEMP[i][pMember] == 5 || PTEMP[i][pMember] == 6 || PTEMP[i][pMember] == 14) && !GetPVarInt(i,"family_chat")) SCM(i, color, str);
	}
}
publics: SendCopsMessage(family, color, str[])
{
	foreach(i)
	{
		if((PTEMP[i][pMember] == 1 || PTEMP[i][pMember] == 2 || PTEMP[i][pMember] == 10 || PTEMP[i][pMember] == 21) && !GetPVarInt(i,"family_chat")) SCM(i, color, str);
	}
}
SendAdminMessage(color, str[])
{
	foreach(i)
	{
		if(!PTEMP[i][pAdmin] || !dostup[i]) continue;
		SCM(i, color, str);
	}
	return true;
}
HelperMessage(color,const str[])
{
	foreach(i)
	{
		if(!SDuty[i]) continue;
		SCM(i, color, str);
	}
}
IsPlayerNearGarage(playerid) // Если игрок у своего гаража, то...
{
	new house = PTEMP[playerid][pPHouseKey];
	if(HGet(playerid) && HouseInfo[house][hKlass] > 1)
	{
		if(PlayerToPoint(6.0,playerid,HouseInfo[house][hCarx], HouseInfo[house][hCary], HouseInfo[house][hCarz]))
		{
			return true;
		}
	}
	return false;
}
IsPlayerInGarage(playerid) // Если игрок в своем гараже, то...
{
	if(PlayerToPoint(20.0,playerid,246.3624,-104.2272,1004.0859)
			||PlayerToPoint(20.0,playerid,447.32,459.3,1002.00)
			||PlayerToPoint(20.0,playerid,897.2116,32.8244,1004.0160)
			||PlayerToPoint(30.0,playerid,504.5519,511.1329,1002.2659))
	{
		return true;
	}
	return false;
}
MovePlayerFromGarage(playerid) // телепорт игрока из гаража с машиной
{
	if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6) return SCM(playerid, 0xFFD5BBAA, " Не флуди!");
 	if(GetPVarInt(playerid,"CarsInGarage") == -1) return SCM(playerid,COLOR_GREY," Все ваши автомобили должны находиться в гараже"), Flood[playerid] = 1;
	new house = PTEMP[playerid][pPHouseKey];
	if(GetPlayerVirtualWorld(playerid) != (100+house)) return SCM(playerid, COLOR_GREY, " Вы не в своём гараже!");
	if(IsPlayerInVehicle(playerid, CarInfo[playerid][carID][0]))//garage_car[playerid][0]))
	{
 		SetPVarInt(playerid,"chosencar",0); // Выставляем игроку значение (Выбрана машина №0)
	}
	else if(IsPlayerInVehicle(playerid, CarInfo[playerid][carID][1]))//garage_car[playerid][1]))
	{
		SetPVarInt(playerid,"chosencar",1); // Выставляем игроку значение (Выбрана машина №1)
	}
	else if(IsPlayerInVehicle(playerid, CarInfo[playerid][carID][2]))//garage_car[playerid][2]))
	{
		SetPVarInt(playerid,"chosencar",2); // Выставляем игроку значение (Выбрана машина №2)
	}
	else if(IsPlayerInVehicle(playerid, CarInfo[playerid][carID][3]))//garage_car[playerid][3]))
	{
		SetPVarInt(playerid,"chosencar",3); // Выставляем игроку значение (Выбрана машина №3)
	}
	else if(IsPlayerInVehicle(playerid, CarInfo[playerid][carID][4]))//garage_car[playerid][4]))
	{
   		SetPVarInt(playerid,"chosencar",4); // Выставляем игроку значение (Выбрана машина №4)
	} else return SCM(playerid, COLOR_GREY, " Вы не в совём автомобиле");
	house_car[playerid] = GetPlayerVehicleID(playerid); // Выставим значение машине игрока (house_car)
 	SetPVarInt(playerid, "CarsInGarage", -1); // Выставим значение игроку (Не все машины игрока в гараже)
	SetVehiclePos(house_car[playerid], HouseInfo[house][hCarx], HouseInfo[house][hCary], HouseInfo[house][hCarz]);
	LinkVehicleToInterior(house_car[playerid], 0);
	SetVehicleVirtualWorld(house_car[playerid], 0);
	SetPlayerPos(playerid, HouseInfo[house][hCarx], HouseInfo[house][hCary], HouseInfo[house][hCarz]);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	PutPlayerInVehicleEx(playerid, house_car[playerid], 0);
	SetVehicleZAngle(house_car[playerid], HouseInfo[house][hCarc]);
 	return true;
}
MovePlayerToGarageFootOut(playerid) // телепорт игрока в гараж без машины с улицы
{
	for(new i = 1; i <= TotalHouse; i++)
	{
 		if(PlayerToPoint(4,playerid,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez])) // Телепорт с улицы
        {
            switch(HouseInfo[i][hKlass])
            {
				case 2: // Дом C Klass
				{
    				SetPlayerInterior(playerid,19);
                    SetPlayerPos(playerid,249.6394,-113.2962,1004.0859);
                    SetPlayerFacingAngle(playerid, 90.00);
				}
				case 3: // Дом B Klass
				{
    				SetPlayerInterior(playerid,19);
                    SetPlayerPos(playerid,431.6059,469.4640,1003.0859);
                    SetPlayerFacingAngle(playerid, 270.00);
                }
                case 4: // Дом A Klass
                {
                    SetPlayerInterior(playerid,19);
                    SetPlayerPos(playerid,902.0135,22.8806,1004.0859);
                    SetPlayerFacingAngle(playerid, 0.00);
				}
				case 5: // Дом S Klass
				{
    				SetPlayerInterior(playerid,19);
                    SetPlayerPos(playerid,513.3862,511.5307,1002.2700);
                    SetPlayerFacingAngle(playerid, 90.00);
                }
            }
            return SetPlayerVirtualWorld(playerid,i+100);
        }
    }
    return true;
}
MovePlayerToGarageFootIn(playerid) // телепорт игрока в гараж без машины с дома
{
	for(new i = 1; i <= TotalHouse; i++)
	{
		if (PlayerToPoint(4, playerid,HouseInfo[i][hExitx], HouseInfo[i][hExity], HouseInfo[i][hExitz]))
		{
  			if(GetPlayerVirtualWorld(playerid) == i+50) // Телепорт с дома
  			{
	            switch(HouseInfo[i][hKlass])
	            {
					case 2: // Дом C Klass
					{
	    				SetPlayerInterior(playerid,19);
	                    SetPlayerPos(playerid,249.6394,-113.2962,1004.0859);
	                    SetPlayerFacingAngle(playerid, 90.00);
					}
					case 3: // Дом B Klass
					{
	    				SetPlayerInterior(playerid,19);
	                    SetPlayerPos(playerid,431.6059,469.4640,1003.0859);
	                    SetPlayerFacingAngle(playerid, 270.00);
	                }
	                case 4: // Дом A Klass
	                {
	                    SetPlayerInterior(playerid,19);
	                    SetPlayerPos(playerid,902.0135,22.8806,1004.0859);
	                    SetPlayerFacingAngle(playerid, 0.00);
					}
					case 5: // Дом S Klass
					{
	    				SetPlayerInterior(playerid,19);
	                    SetPlayerPos(playerid,513.3862,511.5307,1002.2700);
	                    SetPlayerFacingAngle(playerid, 90.00);
	                }
	            }
	            return SetPlayerVirtualWorld(playerid,i+100);
	        }
        }
    }
    return true;
}
MovePlayerToGarageCar(playerid) // телепорт игрока в гараж с машиной
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true; // Если игрок не в машине - сбрасываем
	if(!IsPlayerInVehicle(playerid,house_car[playerid])) return true; // Если игрок не в своей машине - сбрасываем
	new i = PTEMP[playerid][pPHouseKey];
	new h = GetPVarInt(playerid,"chosencar");
	SetPVarInt(playerid, "CarsInGarage", 1); // Выставляем игроку значение "все машине в гараже"
	SetPVarInt(playerid,"chosencar",-1); // по умолчанию - выбрана машина № 0 (carModel[0])
	SetPVarInt(playerid,"not_engine",0);
	SetPVarInt(playerid,"not_engine_",0);
	GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(GetPlayerVehicleID(playerid),false,false,alarm,doors,bonnet,boot,objective);
	switch(HouseInfo[i][hKlass])
	{
	    case 2: // Дом C Klass
	    {
	        switch(h) // Проверка на значение игрока (Какая машина не находится в гараже)
	        {
	        	case 0: MoveVehicleToGarage(playerid, house_car[playerid],248.1234,-110.5993,1003.6578,90.6935,19,i+100);
	            case 1: MoveVehicleToGarage(playerid, house_car[playerid],248.3368,-104.4114,1003.6582,86.1593,19,i+100);
			}
		}
		case 3: // B Klass
		{
			switch(h) // Проверка на значение игрока (Какая машина не находится в гараже)
	        {
	            case 0: MoveVehicleToGarage(playerid, house_car[playerid],435.5904,468.6050,1002.6595,358.6705,19,i+100);
    			case 1: MoveVehicleToGarage(playerid, house_car[playerid],441.7249,468.3962,1002.6600,360.0000,19,i+100);
 				case 2: MoveVehicleToGarage(playerid, house_car[playerid],447.4809,468.1860,1002.6586,358.1951,19,i+100);
			}
		}
		case 4: // A Klass
		{
			switch(h) // Проверка на значение игрока (Какая машина не находится в гараже)
	        {
	            case 0: MoveVehicleToGarage(playerid, house_car[playerid],893.5298,31.7400,1004.1795,333.8575,19,i+100);
    			case 1: MoveVehicleToGarage(playerid, house_car[playerid],897.6765,31.8136,1004.1783,0.9835,19,i+100);
 				case 2: MoveVehicleToGarage(playerid, house_car[playerid],902.9612,31.9576,1004.1783,1.5516,19,i+100);
 				case 3: MoveVehicleToGarage(playerid, house_car[playerid],907.1154,32.3961,1004.1783,30.6716,19,i+100);
			}
		}
		case 5: // S Klass
		{
			switch(h) // Проверка на значение игрока (Какая машина не находится в гараже)
	        {
	            case 0: MoveVehicleToGarage(playerid, house_car[playerid],511.2867,505.0032,1002.3588,47.6021,19,i+100);
	            case 1: MoveVehicleToGarage(playerid, house_car[playerid],504.8487,503.1697,1002.3583,90.2742,19,i+100);
 				case 2: MoveVehicleToGarage(playerid, house_car[playerid],504.5507,512.3398,1002.3583,91.0430,19,i+100);
 				case 3: MoveVehicleToGarage(playerid, house_car[playerid],504.7199,521.3282,1002.3588,90.3364,19,i+100);
    			case 4: MoveVehicleToGarage(playerid, house_car[playerid],511.4334,518.2543,1002.3597,126.6747,19,i+100);
			}
		}
	}
	return house_car[playerid] = -1;
}
MoveVehicleToGarage(playerid, vehicleid,Float:x,Float:y,Float:z,Float:angle,interiorid,virtualworld)
{
	SetVehicleZAngle(vehicleid, angle);
	SetVehiclePos(vehicleid,x,y,z);
	LinkVehicleToInterior(vehicleid, interiorid);
	SetVehicleVirtualWorld(vehicleid, virtualworld);
	SetPlayerInterior(playerid, interiorid);
	SetPlayerVirtualWorld(playerid,virtualworld);
	SetPlayerPos(vehicleid, x,y,z);
	
	PutPlayerInVehicle(playerid, vehicleid, 0);
	TelePos[playerid][0] = 0.0;
	TelePos[playerid][1] = 0.0;
	return true;
}
#include "..\gamemodes\command\cmd.pwn"
restartServer(sw)
{
	if (sw == 1)
	{
		OOCOff(COLOR_RED, "");
		OOCOff(COLOR_RED, "");
		OOCOff(COLOR_RED, "");
		OOCOff(COLOR_RED, "");
		OOCOff(COLOR_RED, "  ----------------=======[ Внимание! Рестарт сервера через 30 секунд ]=======----------------");
		OOCOff(COLOR_RED, "");
		OOCOff(COLOR_RED, "");
		OOCOff(COLOR_RED, "");
		OOCOff(COLOR_RED, "");
	}
	SaveMySQL(0);
	for(new i = 1; i <= TOTALCASINO; i++) SaveMySQL(1,i);
	for(new i = 1; i <= TOTALSHOPS; i++) SaveMySQL(3,i);
	for(new i = 1; i <= TotalBizz; i++) SaveMySQL(4,i);
	for(new i = 1; i <= TotalHouse; i++) SaveMySQL(5,i);
	for(new i = 1; i <= ALLKVARTIRI; i++) SaveMySQL(6,i);
	for(new i = 1; i <= AllPODEZD; i++) SaveMySQL(7,i);
	for(new i = 1; i <= TOTALATM; i++) SaveMySQL(8,i);
	for(new i = 0; i <= TOTALFARM; i++) SaveMySQL(9,i);
	mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pLogin = '0'");
	mysql_function_query(DATABASE,QUERY,false,"","");
	rr = 1;
	if(sw == 1)
	{
		foreach(i)
		{
			GameTextForPlayer(i,"~r~RESTART", 1000, 0);
			ShowPlayerDialogEx(i,556,DIALOG_STYLE_MSGBOX,"{D95A41}Рестарт сервера","{D95A41}В данный момент проходит рестарт сервера\nПерезайдите через минуту","ENTER","");
			Kick(i);
		}
	}
	else
	{
	    foreach(i)
		{
			GameTextForPlayer(i,"~r~RESTART", 1000, 0);
   			SaveMySQL(2, i);
		}
	}
	SetTimer("gmx_command", 10000, true);
	
	return true;
}
publics: gmx_command()
{
    SendRconCommand("gmx");
    return false;
}
publics: AddKvartira(Float:x,Float:y,Float:z,interior,world,virtmirs)
{
	new price = 0;
	switch(interior)
	{
	    case 1: price = 300000;
	    case 15: price = 100000;
	    default: return false;
	}
	mysql_format(DATABASE, QUERY, 128, "INSERT INTO `kvart` (`pXpic`) VALUES ('%f')",x);
	mysql_function_query(DATABASE,QUERY,false,"","");
	ALLKVARTIRI ++;
	kvartinfo[ALLKVARTIRI][pXpic] = x;
	kvartinfo[ALLKVARTIRI][kid] = ALLKVARTIRI;
	kvartinfo[ALLKVARTIRI][pYpic] = y;
	kvartinfo[ALLKVARTIRI][pZpic] = z;
	strmid(kvartinfo[ALLKVARTIRI][vladelec], "None", 0, 5, 5);
	kvartinfo[ALLKVARTIRI][lock] = 0;
	kvartinfo[ALLKVARTIRI][kworld] = world;
	kvartinfo[ALLKVARTIRI][virtmir] = virtmirs;
	kvartinfo[ALLKVARTIRI][kCena] = price;
	kvartinfo[ALLKVARTIRI][kInt] = 0;
	format(YCMDstr, 200,"{0076FC}Комната #%i\nПродается: %i вирт\nЧтобы войти, нажмите клавишу 'ENTER'",ALLKVARTIRI,kvartinfo[ALLKVARTIRI][kCena]);
	kvartinfo[ALLKVARTIRI][dtext] = CreateDynamic3DTextLabel(YCMDstr,0x0076FCFF,x,y,z+1,3.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,world);
	updatekvar(ALLKVARTIRI);
	return true;
}
GetCoordBootVehicle(vehicleid, &Float:x, &Float:y, &Float:z)
{
    new Float:angle,Float:distance;
    GetVehicleModelInfo(GetVehicleModel(vehicleid), 1, x, distance, z);
    distance = distance/2 + 0.1;
	GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, angle);
    x += (distance * floatsin(-angle+180, degrees));
    y += (distance * floatcos(-angle+180, degrees));
    return 1;
}
IsAZapravka(zpid)
{
	switch(zpid)
	{
	    case 20, 21, 27..34, 36, 38..45: return true;
	    default: return false;
	}
	return false;
}
IsInCopCar(playerid)
{
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 596
	&& GetVehicleModel(GetPlayerVehicleID(playerid)) != 597
	&& GetVehicleModel(GetPlayerVehicleID(playerid)) != 598
	&& (GetPlayerVehicleID(playerid) < fbicar[0] || GetPlayerVehicleID(playerid) < fbicar[15])) return false;
	return true;
}
CanInvite(playerid)
{
	new rankk = PTEMP[playerid][pRank];
	switch(PTEMP[playerid][pMember])
	{
	    case 3,19:
	    {
	        switch(rankk) { case 14,15: return true; }
	    }
	    case 4,5,6,9,11,12,13,14,15,16,17,18,20,24,26,29:
	    {
	        switch(rankk) { case 9, 10: return true; }
	    }
	    case 7:
	    {
	    	switch(rankk) { case 5,  6: return true; }
	    }
	}
	return false;
}
CanGiveRanker(playerid)
{
	new rankk = PTEMP[playerid][pRank];
	switch(PTEMP[playerid][pMember])
	{
	    case 1,10,21: { switch(rankk) { case 11..14: return true; } }
	    case 2,4,5,6,9,11,12,13,14,15,16,17,18,20,24,26,29: { switch(rankk) { case 7..10: return true; } }
	    case 3,19: { switch(rankk) { case 12..15: return true; } }
	    case 7: { switch(rankk) { case 5..6: return true; } }
	}
	return false;
}
CanGiveRank(playerid, giveplayerid, giverank)
{
	new rankk = PTEMP[playerid][pRank];
	if(PTEMP[giveplayerid][pRank] >= rankk) SCM(playerid, COLOR_GREY, " Вы не можете повысить/понизить этого игрока");
	switch(PTEMP[playerid][pMember])
	{
	    case 1,10,21:
		{
			switch(giverank) { case 1..13: {} default: { SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 13"); return false; } }
			switch(rankk)
			{
				case 11..13:
				{
					if(giverank >= 11 && giverank <= 13)
					{
						SCM(playerid, COLOR_GREY, " Вы не можете назначить на руководящую должность");
						return false;
					}
				}
			}
		}
	    case 2,4,5,6,9,11,12,13,14,15,16,17,18,20,24,26,29:
		{
            switch(giverank) { case 1..9: {} default: { SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 9"); return false; } }
   			switch(rankk) {	case 7..9: { if(giverank >= 7 && giverank <= 9) { SCM(playerid, COLOR_GREY, " Вы не можете назначить на руководящую должность"); return false; } } }
		}
	    case 3,19:
		{
		    switch(giverank) { case 1..14: {} default: { SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 14"); return false; } }
			switch(rankk) {	case 12..14: { if(giverank >= 12 && giverank <= 14) { SCM(playerid, COLOR_GREY, " Вы не можете назначить на руководящую должность"); return false; } } }
		}
	    case 7:
		{
			switch(giverank) { case 1..9: {} default: { SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 9"); return false; } }
			switch(rankk) {	case 5: { if(giverank == 5) { SCM(playerid, COLOR_GREY, " Вы не можете назначить на руководящую должность"); return false; } } }
		}
	}
	return false;
}
CanBan(giveplayername[])
{
    mysql_format(DATABASE, QUERY, 100, "SELECT `level` FROM `"TABLE_ADMIN"` WHERE `Name` = '%s'", giveplayername);
	mysql_query(DATABASE, QUERY);
	new r = cache_num_rows();
	if(r)//cache_num_rows(r))
	{
		new levels = cache_get_field_content_int(0,"level");
		if(levels > 6)
		{
		    return false;
		}
	}
	return true;
}
mktimes(uhour,uminute,usecond,uday,umonth,uyear)
{
	new timestamp2;
	timestamp2 = usecond + (uminute * 60) + (uhour * 3600);
	new days_of_month[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };
	if (((uyear % 4 == 0) && (uyear % 100 != 0)) || (uyear % 400 == 0)) days_of_month[1] = 29;
	else days_of_month[1] = 28;
	new days_this_year = 0;
	days_this_year = --uday;
	if(umonth > 1)
	{
		for(new i=0; i<umonth-1;i++)
		{
			days_this_year += days_of_month[i];
		}
	}
	timestamp2 += days_this_year * 86400;
	for(new j=1970;j<uyear;j++)
	{
		timestamp2 += 31536000;
		if ( ((j % 4 == 0) && (j % 100 != 0)) || (j % 400 == 0) ) timestamp2 += 86400;
	}
	return timestamp2;
}
publics:GunTimer(playerid)
{
	SetPVarInt(playerid, "Hour_Gun", 0);
}
publics:DrugsTimer(playerid)
{
	SetPVarInt(playerid, "Hour_Drugs", 0);
}
isService(playerid)
{
	if((PTEMP[playerid][pJob] == 2) || (PTEMP[playerid][pJob] == 4 && GetPVarInt(playerid,"TaxiDuty"))
	|| (PTEMP[playerid][pMember] == 4 || PTEMP[playerid][pMember] == 22 && GetPVarInt(playerid,"Fraction_Duty"))
	|| ((PTEMP[playerid][pMember] == 21 || PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pMember] == 1)
	&& GetPVarInt(playerid,"Fraction_Duty")))
		return true;
	return false;
}
#include "..\gamemodes\default\OnPlayerCommandText.pwn"
publics:ProxDetector(Float:radi, playerid, str[], col1, col2, col3, col4, col5)
{
	if (IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		foreach(i)
		{
			if(IsPlayerConnected(i))
			{
				if(!BigEar[i])
				{
					if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
					{
						GetPlayerPos(i, posx, posy, posz);
						tempposx = (oldposx -posx);
						tempposy = (oldposy -posy);
						tempposz = (oldposz -posz);
						if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
						{
							SCM(i, col1, str);
						}
						else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
						{
							SCM(i, col2, str);
						}
						else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
						{
							SCM(i, col3, str);
						}
						else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
						{
							SCM(i, col4, str);
						}
						else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
						{
							SCM(i, col5, str);
						}
					}
				}
				else
				{
					SCM(i, col1, str);
				}
			}
		}
	}
	return true;
}
publics:ProxDetectorS(Float:radi, playerid, targetid)
{
	if (IsPlayerConnected(playerid) && IsPlayerConnected(targetid))
	{
	    if (Spectate[targetid] == 1) return false;
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return true;
		}
	}
	return false;
}
publics:ClearMarriage(playerid)
{
	if(!IsPlayerConnected(playerid))
	{
		mysql_format(DATABASE,QUERY, 128, "UPDATE accounts SET pMarriedTo = '-' WHERE name = '%s'",PTEMP[playerid][pName]);
		mysql_function_query(DATABASE,QUERY,false,"","");
	}
	else strmid(PTEMP[playerid][pMarriedTo],"-", 0, strlen("-"), 32);
	return true;
}
#include "..\gamemodes\default\OnPlayerText.pwn"
/*
forward ClickOff(playerid);
public ClickOff(playerid)
{
	ClickReconButton[playerid] = false;
	return 1;
}
*/
publics:ClearAnim(playerid)
{
	ApplyAnimation(playerid,"CARRY","crry_prtial",2.5,0,0,0,0,0,0);
	return 1;
}
#include "..\gamemodes\default\OnPlayerUpdate.pwn"
publics:FixHour(hour)
{
	hour = timeshift+hour;
	if (hour < 0) hour = hour+24;
	else if (hour > 23) hour = hour-24;
	shifthour = hour;
	return true;
}
#include "..\gamemodes\default\OnPlayerKeyStateChange.pwn"
#include "..\gamemodes\default\OnPlayerClickPlayer.pwn"
publics:GiveMoney(playerid, amount)
{
	PTEMP[playerid][pCash] += amount;
	GivePlayerMoney(playerid, amount);
}
publics:ResetMoney(playerid)
{
	PTEMP[playerid][pCash] = 0;
	ResetPlayerMoney(playerid);
}
IsAnAmbulance(carid)
{
	if(carid >= medicssf[0] && carid <= medicssf[7] || carid >= medicssf1[0] || carid == medmav || carid >= medicsls[0] && carid <= medicsls[9] || carid >= medicsls1[0] && carid <= medicsls1[5] || carid >= medicslv[0] && carid <= medicslv[7] || carid >= medicsfc[0] && carid <= medicsfc[7]) return true;
	return false;
}
CarLic(carid)
{
	switch (GetVehicleModel(carid))
	{
	case 400..416,418..424,426..429,431..445,449,451,455,456,458,459,461: return true;
	case 463,466..468,470,471,474,475,477..480,482,483,485,486,489..492,494..496,498..508: return true;
	case 514..518,521..531,533..537,539..547,549..551,554..562,564..568,572..576,578..583,585..589,596..605,609: return true;
	}
	return false;
}
publics:PlayerToKvadrat(playerid,Float:min_x,Float:min_y,Float:max_x,Float:max_y)
{
	new Float:xxp,Float:yyp,Float:zzp;
	GetPlayerPos(playerid, xxp, yyp, zzp);
	if((xxp <= max_x && xxp >= min_x) && (yyp <= max_y && yyp >= min_y)) return true;
	return false;
}
GetGangZoneColor(gangzonex)
{
	new zx;
	switch(GZInfo[gangzonex][gFrakVlad])
	{
	case 12: zx = 0xd200ff99;
	case 13: zx = 0xcfbe0899;
	case 15: zx = 0x06b50699;
	case 17: zx = 0x03c3b899;
	case 18: zx = 0x007fffAA;
	default: zx = 0xFEFEFEAA;
	}
	return zx;
}
GetGZColorF(fnumber)
{
	new zx;
	switch(fnumber)
	{
	case 12: zx = 0xFF0000AA;
	case 13: zx = 0xFF0000AA;
	case 15: zx = 0xFF0000AA;
	case 17: zx = 0xFF0000AA;
	case 18: zx = 0xFF0000AA;
	}
	return zx;
}
GetNearestVehicle(playerid)
{
	for(new i = GetVehiclePoolSize(); i >= 0; i--)
	{
		if(GetVehicleModel(i))
		{
			new Float:X,Float:Y,Float:Z;
			GetVehiclePos(i,X,Y,Z);
			if(PlayerToPoint(4.0, playerid, X, Y, Z))return i;
		}
	}
	return -1;
}
IsInAllowedF(fnumbers)
{
	for(new i =0;i<sizeof(allowedfactions);i++) if(fnumbers == allowedfactions[i]) return true;
	return false;
}
GetGangName(fnumbwer)
{
	new str[30];
	switch(fnumbwer)
	{
	case 12: format(str,sizeof(str), "BALLAS");
	case 13: format(str,sizeof(str), "VAGOS");
	case 15: format(str,sizeof(str), "GROVE");
	case 17: format(str,sizeof(str), "AZTECAS");
	case 18: format(str,sizeof(str), "RIFA");
	}
	return str;
}
GetMafiaName(fnumbwer)
{
	new str[25];
	switch(fnumbwer)
	{
	case 5: format(str,sizeof(str), "LCN");
	case 6: format(str,sizeof(str), "Yakuza");
	case 14: format(str,sizeof(str), "Russian Mafia");
	}
	return str;
}
WarningSP(playerid)
{
	if(GetPVarInt(playerid,"WarningCheat") < 1)
	{
		format(string,144," <Warning> %s[%d]: Возможно Car Spawn",PTEMP[playerid][pName],playerid);
		ABroadCast(COLOR_REDD,string,2);
		SetPVarInt(playerid, "WarningCheat", 15);
		SetPVarInt(playerid,"CarSpWarn",0);
	}
	return 1;
}

#include "..\gamemodes\default\OnVehicleDeath.pwn"
#include "..\gamemodes\default\OnVehicleSpawn.pwn"

publics:Random(min, max)
{
	return random(max - min) + min;
}
publics:PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) return true;
	return false;
}
GetSRVMoney(playerid) return PTEMP[playerid][pCash];
publics:DelGun(playerid)
{
	SetPVarInt(playerid, "GunCheckTime",5);
	for(new i = 0; i < 46; i++) Weapons[playerid][i] = 0;
	for(new i = 0; i < 10; i++) PTEMP[playerid][pWeapon][i] = 0, PTEMP[playerid][pAmmo] = 0;
	ResetPlayerWeaponsEx(playerid);
	return true;
}
RemovePlayerFromVehicleAC(playerid)
{
	car_ex[GetPlayerVehicleID(playerid)] = true;
	GetVehiclePos(GetPlayerVehicleID(playerid),car_coord[GetPlayerVehicleID(playerid)][0],car_coord[GetPlayerVehicleID(playerid)][1],car_coord[GetPlayerVehicleID(playerid)][2]);
	GetVehicleZAngle(GetPlayerVehicleID(playerid),car_coord[GetPlayerVehicleID(playerid)][3]);
	RemovePlayerFromVehicle(playerid);
	SetTimerEx("AntiRemovePlayerFromVehicle", 3800, 0, "d",playerid);
	return true;
}
publics:AntiRemovePlayerFromVehicle(playerid)
{
	if(PTEMP[playerid][pAdmin] == 0 && GetPlayerState(playerid) == 2)
	{
		CheatKick(playerid, 031);
	}
}
publics:GetMoney()
{
	foreach(i)
	{
		if(PTEMP[i][pCash] != GetPlayerMoney(i)) ResetPlayerMoney(i), GivePlayerMoney(i, PTEMP[i][pCash]);
	}
	return ;
}
UnLockCar(playerid,carid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(!IsAPlane(carid) && !IsABoat(carid) && !IsABike(carid) && AutoSaloon[playerid] != true)
		{
			PlayerTextDrawColor(playerid,StatusShow[playerid], 0x20B220AA);
			PlayerTextDrawSetString(playerid,StatusShow[playerid],"Unlock");
			PlayerTextDrawShow(playerid,StatusShow[playerid]);
		}
	}
	GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
	return SetVehicleParamsEx(carid,engine,lights,alarm,false,bonnet,boot,objective);
}
SpeedVehicle(playerid)
{
	new Float:ST[4];
	if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
	else return 0;
	//GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
	ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 100.3;
	return floatround(ST[3]);
}
publics:UpdateSpeedometr()
{
	foreach(playerid)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) continue;
		if(IsAPlane(GetPlayerVehicleID(playerid)) || IsABoat(GetPlayerVehicleID(playerid)) || IsABike(GetPlayerVehicleID(playerid))) continue;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		UnSurfCar(vehicleid);
		format(str1,5,"%i",SpeedVehicle(playerid));
		if(PTEMP[playerid][pDrivingSkill] > 0 && !IsANoLimiter(vehicleid))
		{
			switch(PTEMP[playerid][pDrivingSkill])
			{
			case 1..300: if(SpeedVehicle(playerid) > 50) format(str1, 5, "50");
			case 301..600: if(SpeedVehicle(playerid) > 45) format(str1, 5, "45");
			case 601..900: if(SpeedVehicle(playerid) > 40) format(str1, 5, "40");
			case 901..1200: if(SpeedVehicle(playerid) > 35) format(str1, 5, "35");
			}
		}
		PlayerTextDrawSetString(playerid,SpeedShow[playerid],str1);
		if(Fuell[vehicleid] <= 0 && engine)
		{
			Fuell[vehicleid] = 0;
			GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			SetVehicleParamsEx(vehicleid,false,false,alarm,doors,bonnet,boot,objective);
			GameTextForPlayer(playerid,"~r~FUEL HAS ENDED", 5000, 3);
			SCM(playerid, COLOR_GREEN, " {00A86B}Используйте телефон {FFFFFF}(( /call )) {00A86B}чтобы вызвать механика / таксиста");
			SCM(playerid, COLOR_GREEN, " {00A86B}Если у вас есть канистра с бензином, введите {FFFFFF}(( /fillcar ))");
		}
		if(Fuell[vehicleid] <= 45) format(str2, sizeof(str2), "~r~%.0f", Fuell[vehicleid]);
		else if(Fuell[vehicleid] <= 100) format(str2, sizeof(str2), "~y~%.0f", Fuell[vehicleid]);
		else format(str2, sizeof(str2), "~g~%.0f", Fuell[vehicleid]);
		PlayerTextDrawSetString(playerid,FuelShow[playerid],str2);
		if(vehicleid == house_car[playerid]) CarInfo[playerid][carFuel][GetPVarInt(playerid, "chosencar")] = Fuell[vehicleid];
		if(!engine && SpeedVehicle(playerid) > 20 && GetPVarInt(playerid,"not_engine") < gettime() && GetPVarInt(playerid, "AFK_Time") < 2)
		{
			if(GetPVarInt(playerid,"not_engine") > 0 && GetPVarInt(playerid,"not_engine_") < SpeedVehicle(playerid))
			{
				return CheatKick(playerid, 033);
			}
			SetPVarInt(playerid,"not_engine", gettime() + 5);
			SetPVarInt(playerid,"not_engine_", SpeedVehicle(playerid));
		}
	}
	return true;
}
new WebSites[][] ={".ws", ".ru", ".tk", ".com", "www.", ".org", ".net", ".cc", ".рф", ".by", ".biz", ".su", ".info"};
CheckString(str[])
{
	for(new i = 0;i<sizeof(WebSites);i++) if(strfind(str,WebSites[i],true) != -1) return true;
	return false;
}
new delimiters[]={'.', ' ', ',', '*', '/', ';', '\\', '|'};
IsIP(const str[])
{
	for(new cIP[4]; cIP[0] != strlen(str)+1; cIP[0]++)
	{
		switch(str[cIP[0]])
		{
		case '.', ' ', ':', ',', '*', '/', ';', '\\', '|' : continue;
		case '0' .. '9': cIP[1]++;
		}
		if(cIP[1] ==1){ cIP[2] = cIP[0];}
		if(cIP[1] >= 8)
		{
			new strx[16];
			new l[4][4];
			cIP[3] = cIP[0]+8;
			strmid(strx,str,cIP[2],cIP[3],16);
			for(new i = strlen(strx); i > 8; i--)
			{
				switch(strx[i])
				{
				case '0' .. '9','.', ' ', ':', ',', '*', '/', ';', '\\', '|': continue;
				default: strx[i] =0;
				}
			}
			for(new i = 0 ; i < sizeof(delimiters); i++)
			{
				split(strx,l,delimiters[i]);
				if(strlen(l[0]) == 1 ||strlen(l[1]) == 1 ||strlen(l[2]) == 1 ||strlen(l[3]) == 1)
				{
					continue;
				}
				if(strlen(l[0]) >3 ||strlen(l[1]) >3 ||strlen(l[2]) >3)
				{
					continue;
				}
				else
				{
					return true;
				}
			}
		}
	}
	return false;
}
#include "..\gamemodes\default\OnVehicleDamageStatusUpdate.pwn"
publics:TeleportTimer(playerid)
{
	SetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
	SetPlayerInterior(playerid, TeleportDestNoFloat[playerid][0]);
	SetPlayerVirtualWorld(playerid, TeleportDestNoFloat[playerid][1]);
	return true;
}
publics:ChangeName(playerid,str[])
{
	mysql_format(DATABASE, QUERY, 256, "UPDATE `accounts` SET `Name`='%s' WHERE `Name` = '%s'",str,Name(playerid));
	mysql_function_query(DATABASE,QUERY,false,"","");
	mysql_format(DATABASE, QUERY, 256, "UPDATE `admin` SET `Name`='%s' WHERE `Name` = '%s'",str,Name(playerid));
	mysql_function_query(DATABASE,QUERY,false,"","");
	mysql_format(DATABASE, QUERY, 256, "UPDATE `cars` SET `owner`='%s' WHERE `owner` = '%s'",str,Name(playerid));
	mysql_function_query(DATABASE,QUERY,false,"","");
	for(new i = 1; i <= TOTALCASINO; i++)
	{
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caManager],true) == 0) strmid(CasinoInfo[i][caManager], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caManager2],true) == 0) strmid(CasinoInfo[i][caManager2], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caManager3],true) == 0) strmid(CasinoInfo[i][caManager3], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie],true) == 0) strmid(CasinoInfo[i][caKrupie], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie2],true) == 0) strmid(CasinoInfo[i][caKrupie2], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie3],true) == 0) strmid(CasinoInfo[i][caKrupie3], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie4],true) == 0) strmid(CasinoInfo[i][caKrupie4], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie5],true) == 0) strmid(CasinoInfo[i][caKrupie5], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie6],true) == 0) strmid(CasinoInfo[i][caKrupie6], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie7],true) == 0) strmid(CasinoInfo[i][caKrupie7], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie8],true) == 0) strmid(CasinoInfo[i][caKrupie8], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie9],true) == 0) strmid(CasinoInfo[i][caKrupie9], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],CasinoInfo[i][caKrupie10],true) == 0) strmid(CasinoInfo[i][caKrupie10], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
	}
	for(new i = 1; i <= TOTALSHOPS; i++)
	{
		if(strcmp(PTEMP[playerid][pName],WorkshopInfo[i][wDeputy1],true) == 0) strmid(WorkshopInfo[i][wDeputy1], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],WorkshopInfo[i][wDeputy2],true) == 0) strmid(WorkshopInfo[i][wDeputy2], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],WorkshopInfo[i][wDeputy3],true) == 0) strmid(WorkshopInfo[i][wDeputy3], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],WorkshopInfo[i][wMechanic1],true) == 0) strmid(WorkshopInfo[i][wMechanic1], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],WorkshopInfo[i][wMechanic2],true) == 0) strmid(WorkshopInfo[i][wMechanic2], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],WorkshopInfo[i][wMechanic3],true) == 0) strmid(WorkshopInfo[i][wMechanic3], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],WorkshopInfo[i][wMechanic4],true) == 0) strmid(WorkshopInfo[i][wMechanic4], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],WorkshopInfo[i][wMechanic5],true) == 0) strmid(WorkshopInfo[i][wMechanic5], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
	}
	for(new i = 1; i <= TOTALFARM; i++)
	{
		if(strcmp(PTEMP[playerid][pName],FarmInfo[i][fDeputy_1],true) == 0) strmid(FarmInfo[i][fDeputy_1], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],FarmInfo[i][fDeputy_2],true) == 0) strmid(FarmInfo[i][fDeputy_2], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],FarmInfo[i][fDeputy_3],true) == 0) strmid(FarmInfo[i][fDeputy_3], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],FarmInfo[i][fFarmer_1],true) == 0) strmid(FarmInfo[i][fFarmer_1], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],FarmInfo[i][fFarmer_2],true) == 0) strmid(FarmInfo[i][fFarmer_2], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],FarmInfo[i][fFarmer_3],true) == 0) strmid(FarmInfo[i][fFarmer_3], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],FarmInfo[i][fFarmer_4],true) == 0) strmid(FarmInfo[i][fFarmer_4], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
		if(strcmp(PTEMP[playerid][pName],FarmInfo[i][fFarmer_5],true) == 0) strmid(FarmInfo[i][fFarmer_5], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50);
	}
	if(HGet(playerid)) strmid(HouseInfo[PTEMP[playerid][pPHouseKey]][hOwner], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), MAX_PLAYER_NAME);
	if(BGet(playerid)) strmid(BizzInfo[PTEMP[playerid][pPBizzKey]][bOwner], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), MAX_PLAYER_NAME);
	if(WGet(playerid)) strmid(WorkshopInfo[GetPVarInt(playerid,"wShop")][wOwner], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), MAX_PLAYER_NAME);
	if(KGet(playerid)) strmid(kvartinfo[PTEMP[playerid][pKvartiraKey]][vladelec], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), MAX_PLAYER_NAME);
	if(FGet(playerid)) strmid(FarmInfo[PTEMP[playerid][pPFarmKey]][fOwner], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), MAX_PLAYER_NAME);
	for(new i = 1; i <= TotalBizz; i++) if(!strcmp(Name(playerid), BizzInfo[i][bNameStavka], true)) { strmid(BizzInfo[i][bNameStavka], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50); }
	for(new i = 1; i <= TOTALSHOPS; i++) if(!strcmp(Name(playerid), WorkshopInfo[i][wAuctionName], true)) { strmid(WorkshopInfo[i][wAuctionName], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50); }
	for(new i = 1; i <= TOTALFARM; i++) if(!strcmp(Name(playerid), FarmInfo[i][fAuctionName], true)) { strmid(FarmInfo[i][fAuctionName], WantNickChange[playerid], 0, strlen(WantNickChange[playerid]), 50); }
	SetPlayerName(playerid, str);
	PTEMP[playerid][pCheckip] = 0;
	Kick(playerid);
	return true;
}
Convert(number)
{
	new hours = 0, mins = 0, secs = 0, str[100];
	hours = floatround(number / 3600);
	mins = floatround((number / 60) - (hours * 60));
	secs = floatround(number - ((hours * 3600) + (mins * 60)));
	if(hours > 0) format(str, 100, "%i:%02d:%02d", hours, mins, secs);
	else format(str, 100, "%i:%02d", mins, secs);
	return str;
}
SetPlayerHealthAC(playerid, Float: Health)
{
	if(IsPlayerConnected(playerid)) PTEMP[playerid][pHP] = Health, SetPlayerHealth(playerid, Health), HealthOn[playerid] = 1;
	return true;
}
SetPlayerArmourAC(playerid, Float: Arm)
{
	if(IsPlayerConnected(playerid)) PTEMP[playerid][pArmour] = Arm, Armour[playerid] = Arm, SetPlayerArmour(playerid, Arm);
	return true;
}
AnRepairVehicle(vehicleid)
{
	CarHealth[vehicleid] = float(1000);
	TimeHealth[vehicleid] = 2;
	RepairVehicle(vehicleid);
	return true;
}
publics:LicClose() return MoveObject(licgate, -2074.50000000,-94.90000153,35.00000000-0.020,0.020, 0.00,90.00,90.00);
publics:GruzClose() return MoveObject(gruzgate, 2203.8630371094,-2252.1179199219,13.5-0.120,0.120, 0.00,270.00,316.00);
GetPlayerID(str[])
{
	foreach(i)
	{
		new testname[MAX_PLAYER_NAME];
		GetPlayerName(i, testname, sizeof(testname));
		if(strcmp(testname, str, true, strlen(str)) == 0) return i;
	}
	return INVALID_PLAYER_ID;
}
Expirence(playerid)
{
	new exp = PTEMP[playerid][pDExp];
	new nxtlevel = PTEMP[playerid][pDLevel];
	new expamount = nxtlevel*levelDexp;
	if(exp >= expamount && PTEMP[playerid][pDLevel] != 26)
	{
		PTEMP[playerid][pDLevel] += 1;
		PTEMP[playerid][pDMgruz]++;
		if(PTEMP[playerid][pDLevel] == 5) PTEMP[playerid][pDMgruz] = 21;
		if(PTEMP[playerid][pDLevel] == 15) PTEMP[playerid][pDMgruz] = 35;
		if(PTEMP[playerid][pDLevel] == 25) PTEMP[playerid][pDMgruz] = 50;
		PTEMP[playerid][pDExp] = 0;
		format(YCMDstr, sizeof(YCMDstr), " {00D26D}Поздравляем! Ваш навык дальнобойщика улучшился.");
		SCM(playerid, 0x66FBA6FF, YCMDstr);
	}
	return true;
}
ExpExp(playerid)
{
	switch(PTEMP[playerid][pPProc])
	{
	case 10,20,30,40,50,60,70,80,90,100:
		{
			if(PTEMP[playerid][pPSkill] == 12) return true;
			PTEMP[playerid][pPSkill] += 1;
			PTEMP[playerid][pPMGruz] += 200;
			format(YCMDstr, sizeof(YCMDstr), " {00D26D}Поздравляем! Ваш навык развозчика улучшился.");
			SCM(playerid, 0x66FBA6FF, YCMDstr);
		}
	}
	return true;
}
ToDevelopSkills(Slashes,Points)
{
	new SlashesAndPoints[200];
	new Slash[2] = "|";
	new Point[2] = "'";
	for(new i = 0; i < Slashes; i++) strcat(SlashesAndPoints, Slash);
	for(new i = 0; i < Points; i++) strcat(SlashesAndPoints, Point);
	return SlashesAndPoints;
}
SetPlayerSkills(playerid)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, PTEMP[playerid][pGunSkill][0]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, PTEMP[playerid][pGunSkill][1]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, PTEMP[playerid][pGunSkill][2]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, PTEMP[playerid][pGunSkill][3]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, PTEMP[playerid][pGunSkill][4]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, PTEMP[playerid][pGunSkill][5]*10);
	return true;
}
OnPlayerAmmoChange(playerid, newammo, oldammo)
{
	if(newammo < oldammo)
	{
		if(newammo >= 0 && newammo <= 1) SetPVarInt(playerid, "GunCheckTime", 3);
		switch(GetPlayerWeapon(playerid))
		{
		case 24:
			{
				switch(booston)
				{
				case 0:
					{
						SetPVarInt(playerid, "SkillD",GetPVarInt(playerid, "SkillD") +1);
						if(GetPVarInt(playerid, "SkillD") >= Ammo_DEAGLE)
						{
							PTEMP[playerid][pGunSkill][1]++;
							SetPVarInt(playerid, "SkillD",0);
							if(PTEMP[playerid][pGunSkill][1] > 100) return PTEMP[playerid][pGunSkill][1] = 100,SetPlayerSkills(playerid);
						}
					}
				case 1:
					{
						SetPVarInt(playerid, "SkillD",GetPVarInt(playerid, "SkillD") +3);
						if(GetPVarInt(playerid, "SkillD") >= Ammo_DEAGLE)
						{
							PTEMP[playerid][pGunSkill][1]+=3;
							SetPVarInt(playerid, "SkillD",0);
							if(PTEMP[playerid][pGunSkill][1] > 100) return PTEMP[playerid][pGunSkill][1] = 100,SetPlayerSkills(playerid);
						}
					}
				}
			}
		case 23:
			{
				switch(booston)
				{
				case 0:
					{
						SetPVarInt(playerid, "SkillSD",GetPVarInt(playerid, "SkillSD") +1);
						if(GetPVarInt(playerid, "SkillSD")>= Ammo_SDPISTOL)
						{
							PTEMP[playerid][pGunSkill][0]++;
							SetPVarInt(playerid, "SkillSD",0);
							if(PTEMP[playerid][pGunSkill][0] > 100) return PTEMP[playerid][pGunSkill][0] = 100,SetPlayerSkills(playerid);
						}
					}
				case 1:
					{
						SetPVarInt(playerid, "SkillSD",GetPVarInt(playerid, "SkillSD") +3);
						if(GetPVarInt(playerid, "SkillSD")>= Ammo_SDPISTOL)
						{
							PTEMP[playerid][pGunSkill][0]+=3;
							SetPVarInt(playerid, "SkillSD",0);
							if(PTEMP[playerid][pGunSkill][0] > 100) return PTEMP[playerid][pGunSkill][0] = 100,SetPlayerSkills(playerid);
						}
					}
				}
			}
		case 25:
			{
				switch(booston)
				{
				case 0:
					{
						SetPVarInt(playerid, "SkillShot",GetPVarInt(playerid, "SkillShot") +1);
						if(GetPVarInt(playerid, "SkillShot") >= Ammo_SHOTGUN)
						{
							PTEMP[playerid][pGunSkill][2]++;
							SetPVarInt(playerid, "SkillShot",0);
							if(PTEMP[playerid][pGunSkill][2] > 100) return PTEMP[playerid][pGunSkill][2] = 100,SetPlayerSkills(playerid);
						}
					}
				case 1:
					{
						SetPVarInt(playerid, "SkillShot",GetPVarInt(playerid, "SkillShot") +3);
						if(GetPVarInt(playerid, "SkillShot") >= Ammo_SHOTGUN)
						{
							PTEMP[playerid][pGunSkill][2]+=3;
							SetPVarInt(playerid, "SkillShot",0);
							if(PTEMP[playerid][pGunSkill][2] > 100) return PTEMP[playerid][pGunSkill][2] = 100,SetPlayerSkills(playerid);
						}
					}
				}
			}
		case 29:
			{
				switch(booston)
				{
				case 0:
					{
						SetPVarInt(playerid, "SkillMP5",GetPVarInt(playerid, "SkillMP5") +1);
						if(GetPVarInt(playerid, "SkillMP5") >= Ammo_MP5)
						{
							PTEMP[playerid][pGunSkill][3]++;
							SetPVarInt(playerid, "SkillMP5",0);
							if(PTEMP[playerid][pGunSkill][3] > 100) return PTEMP[playerid][pGunSkill][3] = 100,SetPlayerSkills(playerid);
						}
					}
				case 1:
					{
						SetPVarInt(playerid, "SkillMP5",GetPVarInt(playerid, "SkillMP5") +3);
						if(GetPVarInt(playerid, "SkillMP5") >= Ammo_MP5)
						{
							PTEMP[playerid][pGunSkill][3]+=3;
							SetPVarInt(playerid, "SkillMP5",0);
							if(PTEMP[playerid][pGunSkill][3] > 100) return PTEMP[playerid][pGunSkill][3] = 100,SetPlayerSkills(playerid);
						}
					}
				}
			}
		case 30:
			{
				switch(booston)
				{
				case 0:
					{
						SetPVarInt(playerid, "SkillAk47",GetPVarInt(playerid, "SkillAk47") +1);
						if(GetPVarInt(playerid, "SkillAk47") >= Ammo_AK47)
						{
							PTEMP[playerid][pGunSkill][4]++;
							SetPVarInt(playerid, "SkillAk47",0);
							if(PTEMP[playerid][pGunSkill][4] > 100) return PTEMP[playerid][pGunSkill][4] = 100,SetPlayerSkills(playerid);
						}
					}
				case 1:
					{
						SetPVarInt(playerid, "SkillAk47",GetPVarInt(playerid, "SkillAk47") +3);
						if(GetPVarInt(playerid, "SkillAk47") >= Ammo_AK47)
						{
							PTEMP[playerid][pGunSkill][4]+=3;
							SetPVarInt(playerid, "SkillAk47",0);
							if(PTEMP[playerid][pGunSkill][4] > 100) return PTEMP[playerid][pGunSkill][4] = 100,SetPlayerSkills(playerid);
						}
					}
				}
			}
		case 31:
			{
				switch(booston)
				{
				case 0:
					{
						SetPVarInt(playerid, "SkillM4",GetPVarInt(playerid, "SkillM4") +1);
						if(GetPVarInt(playerid, "SkillM4") >= Ammo_M4A1)
						{
							PTEMP[playerid][pGunSkill][5]++;
							SetPVarInt(playerid, "SkillM4",0);
							if(PTEMP[playerid][pGunSkill][5] > 100) return PTEMP[playerid][pGunSkill][5] = 100,SetPlayerSkills(playerid);
						}
					}
				case 1:
					{
						SetPVarInt(playerid, "SkillM4",GetPVarInt(playerid, "SkillM4") +3);
						if(GetPVarInt(playerid, "SkillM4") >= Ammo_M4A1)
						{
							PTEMP[playerid][pGunSkill][5]+=3;
							SetPVarInt(playerid, "SkillM4",0);
							if(PTEMP[playerid][pGunSkill][5] > 100) return PTEMP[playerid][pGunSkill][5] = 100,SetPlayerSkills(playerid);
						}
					}
				}
			}
		}
	}
	return true;
}
ClearTotalGz()
{
	TotalGzR = 0;
	TotalGzA = 0;
	TotalGzB = 0;
	TotalGzG = 0;
	TotalGzV = 0;
}
IsWheelModel(modelid)
{
	new wheelmodels[17] = {1025,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098};
	for(new i=0;i<17;i++)
	{
		if (modelid == wheelmodels[i])
		return true;
	}
	return false;
}
IsLegalCarNitroIde(carmodel)
{
	new illegalvehs[29] = { 581, 523, 462, 521, 463, 522, 461, 448, 468, 586, 509, 481, 510, 472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 590, 569, 537, 538, 570, 449 };
	for(new i=0;i<29;i++)
	{
		if (carmodel == illegalvehs[i])
		return true;
	}
	return false;
}
IsLegalCarMod(vehicleide, componentid)
{
	new modok = false;
	if((IsWheelModel(componentid)) || (componentid == 1086) || (componentid == 1087) || ((componentid >= 1008) && (componentid <= 1010)))
	{
		new nosblocker = IsLegalCarNitroIde(vehicleide);
		if (!nosblocker)
		modok = true;
	}
	else
	{
		for(new I=0;I<48;I++)
		{
			if (legalmods[I][0] == vehicleide)
			{
				for(new J = 1; J < 22; J++)
				{
					if (legalmods[I][J] == componentid)
					modok = true;
				}
			}
		}
	}
	return modok;
}
public OnVehiclePaintjob(playerid, vehicleid, paintjobid) return true;
#include "..\gamemodes\default\OnVehicleMod.pwn"
/*
NewsBank(playerid)
{
	new full;
	switch(PTEMP[playerid][pMember])
	{
	    case 16: full = 0; break; // LS
	    case 9: full = 1; break;// SF
	    case 20: full = 2; break; // LV
	}
	
	return true;
}
*/
AdvertList(playerid)
{
	new full, str[90], strrr[600];
	switch(PTEMP[playerid][pMember])
	{
	case 16: full = 0; // LS
	case 9: full = 1; // SF
	case 20: full = 2; // LV
	}
	for(new i = 1; i <= TOTALADVERT[full];i++)
	{
		if(AdvertInfo[i][full][edited] == false) format(str, sizeof(str), "%i Имя: %s \n",i, AdvertInfo[i][full][adName]);
		else format(str, sizeof(str), "%i Имя: %s {00FF00} Проверил: %s\n",i, AdvertInfo[i][full][adName], AdvertInfo[i][full][editName]);
		strcat(strrr, str);
	}
	if(TOTALADVERT[full] == 0) return ShowPlayerDialogEx(playerid, 69, 0, "Объявления", "    Новых объявлений нет", "Назад", "");
	ShowPlayerDialogEx(playerid, 11518, 2, "Объявления", strrr, "Принять", "Отмена");
	return true;
}
publics:AntiBunny(playerid)
{
	ApplyAnimation(playerid, "PED", "getup_front",4.0,0,0,0,0,0);
	SetTimerEx("AntiBunnyHop",1500,false, "i",playerid);
	return true;
}
GetPlayerCameraLookAt(playerid, &Float:rX, &Float:rY, &Float:rZ, Float:dist = 10.0)
{
	new Float: locAt[6];
	GetPlayerCameraFrontVector(playerid, locAt[0], locAt[1], locAt[2]);
	GetPlayerCameraPos(playerid, locAt[3], locAt[4], locAt[5]);
	rX = locAt[0] * dist + locAt[3];
	rY = locAt[1] * dist + locAt[4];
	rZ = locAt[2] * dist + locAt[5];
}
AntiDeAMX()
{
	new a[][] =
	{
		"Unarmed (Fist)",
		"Brass K"
	};
	#pragma unused a
}
CanUninviteforeach(playerid,playerid2)
{
	if(PTEMP[playerid][pLeader] >= 1) return true;
	new rank = PTEMP[playerid][pRank];
	if(PTEMP[playerid][pMember] > 0 && PTEMP[playerid2][pMember] > 0 &&
			rank < PTEMP[playerid2][pRank] || !GetPVarInt(playerid,"Fraction_Duty")) return false;
	switch(PTEMP[playerid][pMember])
	{
	case 1:
		{
			switch(rank)
			{
			case 15:return true;
			case 14:return true;
			case 13:return true;
			}
		}
	case 2:
		{
			switch(rank)
			{
			case 10:return true;
			case 9:return true;
			case 8:return true;
			}
		}
	case 3:
		{
			switch(rank)
			{
			case 16:return true;
			case 15:return true;
			case 14:return true;
			}
		}
	case 4:
		{
			switch(rank)
			{
			case 10:return true;
			case 9:return true;
			case 8:return true;
			}
		}
	case 5:
		{
			switch(rank)
			{
			case 10:return true;
			case 9:return true;
			case 8:return true;
			}
		}
	case 6:
		{
			switch(rank)
			{
			case 10:return true;
			case 9:return true;
			case 8:return true;
			}
		}
	case 7:
		{
			switch(rank)
			{
			case 6:return true;
			case 5:return true;
			case 4:return true;
			}
		}
	case 8:
		{
			switch(rank)
			{
			case 2:return true;
			}
		}
	case 9:
		{
			switch(rank)
			{
			case 10:return true;
			case 9:return true;
			case 8:return true;
			}
		}
	case 10:
		{
			switch(rank)
			{
			case 15:return true;
			case 14:return true;
			case 13:return true;
			}
		}
	case 11..18:
		{
			switch(rank)
			{
			case 10:return true;
			case 9:return true;
			case 8:return true;
			}
		}
	case 19:
		{
			switch(rank)
			{
			case 16:return true;
			case 15:return true;
			case 14:return true;
			}
		}
	case 20:
		{
			switch(rank)
			{
			case 10:return true;
			case 9:return true;
			case 8:return true;
			}
		}
	case 21:
		{
			switch(rank)
			{
			case 15:return true;
			case 14:return true;
			case 13:return true;
			}
		}
	case 22:
		{
			switch(rank)
			{
			case 10:return true;
			case 9:return true;
			case 8:return true;
			}
		}
	case 23..32:
		{
			switch(rank)
			{
			case 8:return true;
			case 7:return true;
			}
		}
	case 33:
		{
			switch(rank)
			{
			case 10:return true;
			case 9:return true;
			case 8:return true;
			}
		}
	case 34:
		{
			switch(rank)
			{
			case 5:return true;
			case 4:return true;
			}
		}
	}
	return false;
}
#include "..\gamemodes\custom\Preload...pwn"
updatekvar(i)
{
	new textt[156];
	if(!strcmp(kvartinfo[i][vladelec],"None",true))
	{
		switch(booston)
		{
		case 0:format(textt, sizeof(textt),"{0076FC}Комната #%i\nПродается: %i вирт\nЧтобы войти, нажмите клавишу 'ENTER'",i,kvartinfo[i][kCena]);
		case 1:format(textt, sizeof(textt),"{0076FC}Комната #%i\nПродается: %i вирт\nЧтобы войти, нажмите клавишу 'ENTER'",i,kvartinfo[i][kCena]-kvartinfo[i][kCena]*40/100);
		}
	}
	else format(textt, sizeof(textt),"{FFBF00}Квартира #%i\nВладелец: %s\nЧтобы войти, нажмите клавишу 'ENTER'",i, kvartinfo[i][vladelec]);
	UpdateDynamic3DTextLabelText(kvartinfo[i][dtext],0x0076FCFF,textt);
}

#include "..\gamemodes\default\OnPlayerClickPlayerTextDraw.pwn"
#include "..\gamemodes\default\OnPlayerClickTextDraw.pwn"

publics:GETHP(playerid)
{
	GetPlayerHealth(playerid,GMHP[playerid][1]);
	GetVehicleHealth(GetPlayerVehicleID(playerid),VEHHP[playerid][1]);
	new stringer[80];
	if(!IsPlayerInAnyVehicle(playerid))
	{
		if(GMHP[playerid][1] >= 100.0)
		{
			format(stringer, sizeof(stringer), " {ff0000}[ANTI-GM]: {bbbbbb}%s[%i] использует гм/клео скрипты", PTEMP[playerid][pName],playerid);
			ABroadCast(COLOR_REDD,stringer,2);
			SetPlayerHealthAC(playerid, GMHP[playerid][0]);
			SetPlayerArmourAC(playerid, GMARMOUR[playerid][0]);
			return true;
		}
		else
		{
			format(stringer, sizeof(stringer), " {34c924}[ANTI-GM] {bbbbbb}%s[%i] не использует гм/клео скрипты", PTEMP[playerid][pName],playerid);
			ABroadCast(COLOR_YELLOW,stringer,2);
			SetPlayerHealthAC(playerid, GMHP[playerid][0]);
			SetPlayerArmourAC(playerid, GMARMOUR[playerid][0]);
			return true;
		}
	}
	else
	{
		if(VEHHP[playerid][1] >= 9999.0)
		{
			format(stringer, sizeof(stringer), " {ff0000}[ANTI-GM]: {bbbbbb}%s[%i] использует гм/клео скрипты", PTEMP[playerid][pName],playerid);
			ABroadCast(COLOR_REDD,stringer,2);
			SetVehicleHealth(GetPlayerVehicleID(playerid),VEHHP[playerid][0]);
			return true;
		}
		else
		{
			format(stringer, sizeof(stringer), " {34c924}[ANTI-GM] {bbbbbb}%s[%i] не использует гм/клео скрипты", PTEMP[playerid][pName],playerid);
			ABroadCast(COLOR_YELLOW,stringer,2);
			SetVehicleHealth(GetPlayerVehicleID(playerid),VEHHP[playerid][0]);
			return true;
		}
	}
}
ClearBizz(i)
{
	BizzInfo[i][bLocked] = 1;
	BizzInfo[i][bProducts] = 0;
	BizzInfo[i][bTill] = 0;
	BizzInfo[i][bPrice] = 0;
	BizzInfo[i][bMafia] = 0;
	BizzInfo[i][bLandTax] = 0;
	BizzPay[i] = 0;
	BizzInfo[i][bLockTime] = 0;
	BizzInfo[i][bLicense] = 0;
	format(YCMDstr, sizeof(YCMDstr), "%s\nПродаётся", BizzInfo[i][bMessage],BizzInfo[i][bBuyPrice]);
	UpdateDynamic3DTextLabelText(BizzInfo[i][bLabel], COLOR_GREEN, YCMDstr);
	if(IsPlayerConnected(GetPlayerID(BizzInfo[i][bOwner]))) PTEMP[GetPlayerID(BizzInfo[i][bOwner])][pBank] += BizzInfo[i][bBuyPrice] / 2, SetPVarInt(GetPlayerID(BizzInfo[i][bOwner]), "GetBizz", 1);
	else mysql_format(DATABASE,QUERY, 256, "UPDATE accounts SET pBank = pBank + 50000, pText = '2' WHERE name = '%s'",BizzInfo[i][bOwner]), mysql_function_query(DATABASE,QUERY,false,"","");
	strmid(BizzInfo[i][bOwner], "None", 0, strlen("None"), 50);
	return true;
}
IsANope(carid)
{
	switch(GetVehicleModel(carid))
	{
	case 400,404,436,439,458,466,475,478,479,492,516,517,518,526,527,542,543,546,547,549,567: return true;
	default: return false;
	}
	return false;
}
IsAB(carid)
{
	switch(GetVehicleModel(carid))
	{
	case 419,421,445,489,491,533,534,554,555,561,579,580,589,603,418,461,581,586,401,405,412,422,426,467,474,496,507,529,536,540,550,551,566,575,576,585,600: return true;
	default: return false;
	}
	return false;
}
IsAA(carid)
{
	switch(GetVehicleModel(carid))
	{
	case 541,522,434,477,480,535,545,558,559,560,562,565,587,602,521,463,468,402,411,415,429,451,506: return true;
	default: return false;
	}
	return false;
}
publics:Ugon(playerid)
{
	nachalvzlom[playerid] = 0;
	PTEMP[playerid][pWantedLevel] +=1;
	PTEMP[playerid][pZakonp] -= 1;
	SetPlayerWantedLevel(playerid,PTEMP[playerid][pWantedLevel]);
	SetPlayerCriminal(playerid,"Неизвестный", "Угон автомобиля");
	SCM(playerid,COLOR_BLUE,"Замок автомобиля открыт, пора уносить ноги!");
	ClearAnimations(playerid, 1);
	UnLockCar(playerid,idcarv[playerid]);
	return 1;
}
IsPlayerApplyAnimation(playerid, animation[])
{
	if(!GetPlayerAnimationIndex(playerid)) return 0;
	else
	{
		new animlib[64], animname[64];
		GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, sizeof(animlib), animname, sizeof(animname));
		if(!strcmp(animname, animation, true)) return 1;
	}
	return 0;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success) return false;
/*
public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	SendMes(playerid,COLOR_BLUE,"VID %i | PID %i | SEAT %i | nx %f | ny %f | nz %f\
| vx %f | vy %f | vz %f",vehicleid,playerid,passenger_seat,new_x,new_y,new_z,vel_x,vel_y,vel_z);
}
*/
#include "..\gamemodes\custom\ChosePlayerSkin.pwn"

publics:AntiNopResetPlayerWeapon(playerid)
{
	new Guns[13][2];
	for (new i = 1; i < 13; i++)
	{
		GetPlayerWeaponData(playerid, i, Guns[i][0], Guns[i][1]);
		if(Guns[i][0] > 0 && GetPVarInt(playerid, "GunCheckTime") == 0)
		{
			CheatKick(playerid, 034);
		}
	}
}
publics:Recognition()
{
	for(new i = 0; i < SLOTVIBROS; i++)
	{
		if(GetTickCount()-VibrosInfo[i][vTime] <= 60000*20)
		{
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
		}
	}
	new Float:x,Float:y,Float:z;
	foreach(i)
	{
		if(!PTEMP[i][pWantedLevel] || !PTEMP[i][pLogin]) continue;
		recognition[i] = 0;
		GetPlayerPos(i,x,y,z);
		for(new idx=0;idx<players;idx++)
		{
			if(IsPlayerInRangeOfPoint(Players[idx],150,x,y,z) && IsACop(Players[idx]) && Players[idx] != i) recognition[i]++;
		}
		if(!recognition[i])
		{
			SCM(i,-1," Ваша узнаваемость понизилась");
			PTEMP[i][pWantedLevel]--, SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel] );
			if(!PTEMP[i][pWantedLevel])
			{
				if(LabelOn[i] == 1)
				{
					LabelOn[i] = 0;
					Delete3DTextLabel(LabelRecognition[i]);
				}
				PTEMP[i][pRecognition] = 0;
			}
			else
			{
				if(PTEMP[i][pRecognition] > 0) PTEMP[i][pRecognition]--;
			}
		}
		else
		{
			SCM(i,-1," Ваша узнаваемость повысилась");
			if(PTEMP[i][pRecognition] < 3) PTEMP[i][pRecognition]++;
		}
	}
}
ClearReconnect()
{
	for(new i=0; i<MAX_PLAYERS; i++) strmid(ExitInfo[i][ExitIP],"None", 0, strlen("None"), 32), ExitInfo[i][ExitTime] = 0;
	return 1;
}
publics:SetDamage(playerid, issuerid, Float:damage, weaponid)
{
	if(GetPVarInt(playerid,"AFK_Time") > 2) return true;
	if(PTEMP[playerid][pArmour] > 0.0)
    {
        if((PTEMP[playerid][pArmour]-damage) <= 0.0)
        {
        	SetPlayerArmourAC(playerid, 0.0);
        	PTEMP[playerid][pArmour] = 0.0;
        }
        else if((PTEMP[playerid][pArmour]-damage) > 0.0)
        {
       		SetPlayerArmourAC(playerid, PTEMP[playerid][pArmour]-damage);
       		PTEMP[playerid][pArmour] -= damage;
        }
    }
    else
    {
        if((PTEMP[playerid][pHP]-damage) <= 0.0 && !killed[playerid])
        {
			PTEMP[playerid][pHP] = 0.0;
        	SetPlayerHealthAC(playerid, 0.0);
        	OnPlayerDeath(playerid, issuerid, weaponid);
        	PTEMP[playerid][pHP] = 100;
        	killed[playerid] = true;
        }
        else if((PTEMP[playerid][pHP]-damage) > 0.0)
        {
			PTEMP[playerid][pHP] -= damage;
           	SetPlayerHealthAC(playerid, PTEMP[playerid][pHP]);
        }
    }
    return true;
}

#include "..\gamemodes\default\OnPlayerGiveDamage.pwn"
#include "..\gamemodes\default\OnPlayerTakeDamage.pwn"

ConvertSeconds(time)
{
	new str[128];
	if(time < 3600) format(str, sizeof(str), "%i", time);
	return str;
}
onCheckAirBrk(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:currentPos[3],
		Float:distance;
		GetPlayerPos( playerid, currentPos[ 0 ], currentPos[1], currentPos[2]);
		distance = floatround( GetPlayerDistanceFromPoint(playerid, PTEMP[playerid][pPos_x], PTEMP[playerid][pPos_y], PTEMP[playerid][pPos_z]));
		if(GetPVarInt(playerid, "AntiBreik") == 0 && GetPVarInt(playerid, "SpecBool") == 0 && GetPVarInt(playerid, "AFK_Time") < 2 && !GetPVarInt(playerid, "Nokick"))
		{
			if(PTEMP[playerid][pAdmin] < 2 || !dostup[playerid])
			{
				if(distance < 250 && distance > 70)
				{
				    if(GetPVarInt(playerid, "air_times") >= 3)
				    {
				        if((GetPVarInt(playerid, "air_time")+30) > gettime())
				    	CheatKick(playerid, 001);
				    	else
				    	SetPVarInt(playerid, "air_times", 0);
			    	}
				    else
				    {
						format(string, 256, " <Warning> %s[%i]: Возможно Airbreak", Name(playerid), playerid);
						ABroadCast(COLOR_REDD,string,2);
						SetPVarInt(playerid, "air_times", GetPVarInt(playerid, "air_times"));
						SetPVarInt(playerid, "air_time", gettime());
					}
				}
				else if(distance > 150)
				{
					CheatKick(playerid, 001);
				}
			}
		}
		PTEMP[ playerid ][ pPos_x ] = currentPos[ 0 ];
		PTEMP[ playerid ][ pPos_y ] = currentPos[ 1 ];
		PTEMP[ playerid ][ pPos_z ] = currentPos[ 2 ];
	}
	return true;
}

#include "..\gamemodes\default\OnPlayerEditAttachedObject.pwn"

AntiReklama(playerid,text[],test[])
{
	for(new txt; txt < strlen(text); txt++)
	{
		if(text[txt] >= '0' && text[txt] <= '9')
		{
			SetPVarInt(playerid,"Text",GetPVarInt(playerid,"Text")+1);
			if(GetPVarInt(playerid,"Text")==10)
			{
				if(PTEMP[playerid][pMuted] > 0)
				{
					format(YCMDstr, sizeof(YCMDstr), " У вас бан чата!");
					SCM(playerid, TEAM_CYAN_COLOR, YCMDstr);
					return true;
				}
		 	 	new ip[26];
				GetPlayerIp(playerid,ip,sizeof(ip));
				format(string, 156, "%s %s: %s",Name(playerid),test,text);
				ABroadCast(COLOR_LIGHTRED,string,1);
				format(string, 156, "                    Login: %s  [ID: %i]  IP: %s",Name(playerid),playerid,ip);
				ABroadCast(COLOR_LIGHTRED,string,1);
				format(YCMDstr,sizeof(YCMDstr)," Вы получили Бан чата на 3 часа");
				SCM(playerid, COLOR_LIGHTRED, YCMDstr);
				format(YCMDstr,sizeof(YCMDstr)," Используйте ''/mm'' -> ''Администрация'' -> ''Обратная связь'', если бан был выдан по ошибке");
				SCM(playerid, COLOR_LIGHTRED, YCMDstr);
				PTEMP[playerid][pMuted] = 10800;
				SetPVarInt(playerid, "antireklamka", 1);
			}
		}
	}
	if(Rekl[playerid] == 1 && strfind(text,"www.",true)!=-1 || Rekl[playerid] == 1 && strfind(text,":7",true)!=-1
			|| Rekl[playerid] == 1 && strfind(text,"7777",true)!=-1 || Rekl[playerid] == 1 && strfind(text,".ru",true)!=-1
			|| Rekl[playerid] == 1 && strfind(text,".net",true)!=-1 || Rekl[playerid] == 1 && strfind(text,".com",true)!=-1
			|| Rekl[playerid] == 1 && strfind(text,".su",true)!=-1 || Rekl[playerid] == 1 && strfind(text,"77.",true)!=-1
			|| Rekl[playerid] == 1 && strfind(text,":7777",true)!=-1 || Rekl[playerid] == 1 && strfind(text,"176.",true)!=-1
			|| Rekl[playerid] == 1 && strfind(text,".ru",true)!=-1 || Rekl[playerid] == 1 && strfind(text,".RU",true)!=-1
			|| Rekl[playerid] == 1 && strfind(text,".COM",true)!=-1 || Rekl[playerid] == 1 && strfind(text,".com",true)!=-1)
	{
		if(PTEMP[playerid][pMuted] > 0)
		{
			format(YCMDstr, sizeof(YCMDstr), " У вас бан чата!");
			SCM(playerid, TEAM_CYAN_COLOR, YCMDstr);
			return true;
		}
 		new ip[26];
		GetPlayerIp(playerid,ip,sizeof(ip));
		format(string, 156, "%s %s: %s!!",Name(playerid),test,text);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(string, 156, "                    Login: %s  [ID: %i]  IP: %s",Name(playerid),playerid,ip);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(YCMDstr,sizeof(YCMDstr)," Вы получили Бан чата на 3 часа");
		SCM(playerid, COLOR_LIGHTRED, YCMDstr);
		format(YCMDstr,sizeof(YCMDstr)," Используйте ''/mm'' -> ''Администрация'' -> ''Обратная связь'', если бан был выдан по ошибке");
		SCM(playerid, COLOR_LIGHTRED, YCMDstr);
		PTEMP[playerid][pMuted] = 10800;
		SetPVarInt(playerid, "antireklamka", 1);
	}
	return true;
}
//AutoSalon
NextCar(playerid)
{
	if(PTEMP[playerid][SalonTime] > gettime()) return GameTextForPlayer(playerid,"Loading...",1000,3);
	SetPVarInt(playerid, "SelectAvto", GetPVarInt(playerid, "SelectAvto") +1);
	switch(GetPVarInt(playerid,"CarShop"))
	{
	case 0:if(GetPVarInt(playerid, "SelectAvto") > 19) SetPVarInt(playerid, "SelectAvto", 0);//nope
	case 1:if(GetPVarInt(playerid, "SelectAvto") > 38) SetPVarInt(playerid, "SelectAvto", 20);//c
	case 2:if(GetPVarInt(playerid, "SelectAvto") > 56) SetPVarInt(playerid, "SelectAvto", 39);//d
	case 3:if(GetPVarInt(playerid, "SelectAvto") > 85) SetPVarInt(playerid, "SelectAvto", 72);//a
	case 4:if(GetPVarInt(playerid, "SelectAvto") > 71) SetPVarInt(playerid, "SelectAvto", 57);//b
	}
	return ShowingCar(playerid);
}
BackCar(playerid)
{
	if(PTEMP[playerid][SalonTime] > gettime()) return GameTextForPlayer(playerid,"Loading...",1000,3);
	SetPVarInt(playerid, "SelectAvto", GetPVarInt(playerid, "SelectAvto")-1);
	switch(GetPVarInt(playerid,"CarShop"))
	{
	case 0:if(GetPVarInt(playerid, "SelectAvto") < 0) SetPVarInt(playerid, "SelectAvto", 19);//nope
	case 1:if(GetPVarInt(playerid, "SelectAvto") < 20) SetPVarInt(playerid, "SelectAvto", 38);//c
	case 2:if(GetPVarInt(playerid, "SelectAvto") < 39) SetPVarInt(playerid, "SelectAvto", 56);//d
	case 3:if(GetPVarInt(playerid, "SelectAvto") < 72) SetPVarInt(playerid, "SelectAvto", 85);//a
	case 4:if(GetPVarInt(playerid, "SelectAvto") < 57) SetPVarInt(playerid, "SelectAvto", 71);//b
	}
	return ShowingCar(playerid);
}
ShowingCar(playerid)
{
	if(PTEMP[playerid][SalonCar] != INVALID_VEHICLE_ID) DestroyVehicle(PTEMP[playerid][SalonCar]);
	PTEMP[playerid][SalonCar] = CreateVehicle(ShopCar[GetPVarInt(playerid, "SelectAvto")][0],-1658.7123,1212.8981,20.9499,285.2443,1,1,-1);
	SetPVarInt(playerid, "Nokick",1);
	SetVehicleParamsEx(PTEMP[playerid][SalonCar],false,false,false,false,false,false,false);
	CarHealth[PTEMP[playerid][SalonCar]] = float(1000);
	SetVehicleVirtualWorld(PTEMP[playerid][SalonCar], playerid+1);
	PutPlayerInVehicle(playerid,PTEMP[playerid][SalonCar],0);
	SetPlayerCameraPos(playerid,-1654.097045,1218.596679,22.708799);
	SetPlayerCameraLookAt(playerid,-1659.106201,1210.380737,19.987318);
	SetPVarInt(playerid,"BuyColor",0);
	SetPVarInt(playerid,"BuyColor1",0);
	switch(booston)
	{
	case 0:
		{
			format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~b~NAME: ~w~%s~n~~g~COST: ~w~%i~n~~y~COLOR1: ~w~-1 ~y~COLOR2: ~w~-1",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1]);
		}
	case 1:
		{
			format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~b~NAME: ~w~%s~n~~g~COST: ~w~%i~n~~y~COLOR1: ~w~-1 ~y~COLOR2: ~w~-1",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1]-ShopCar[GetPVarInt(playerid, "SelectAvto")][1]*20/100);
		}
	}
	GameTextForPlayer(playerid,string, 5000, 3);
	if(booston == 0) format(string,128,"Model: %s~n~Cost: %i",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1]);
	else if(booston == 1) format(string,128,"Model: %s~n~Cost: %i",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1]-ShopCar[GetPVarInt(playerid, "SelectAvto")][1]*20/100);
	PlayerTextDrawSetString(playerid,ShopText[playerid],string);
	PTEMP[playerid][SalonTime] = gettime()+1;
	return 1;
}
NextColor(playerid,whocolor)
{
	if(whocolor == 0)
	{
		SetPVarInt(playerid,"BuyColor",GetPVarInt(playerid,"BuyColor")+1);
		if(GetPVarInt(playerid,"BuyColor") > 125) SetPVarInt(playerid,"BuyColor",0);
	}
	else
	{
		SetPVarInt(playerid,"BuyColor1",GetPVarInt(playerid,"BuyColor1")+1);
		if(GetPVarInt(playerid,"BuyColor1") > 125) SetPVarInt(playerid,"BuyColor1",0);
	}
	ChangeVehicleColor(GetPlayerVehicleID(playerid),GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	if(booston == 0) format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~b~NAME: ~w~%s~n~~g~COST: ~w~%i~n~~y~COLOR1: ~w~%i ~y~COLOR2: ~w~%i",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1],GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	else if(booston == 1) format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~b~NAME: ~w~%s~n~~g~COST: ~w~%i~n~~y~COLOR1: ~w~%i ~y~COLOR2: ~w~%i",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1]-ShopCar[GetPVarInt(playerid, "SelectAvto")][1]*20/100,GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	GameTextForPlayer(playerid,string, 5000, 3);
	return 1;
}
BackColor(playerid,whocolor)
{
	if(whocolor == 0)
	{
		SetPVarInt(playerid,"BuyColor",GetPVarInt(playerid,"BuyColor")-1);
		if(GetPVarInt(playerid,"BuyColor") < 0) SetPVarInt(playerid,"BuyColor",125);
	}
	else
	{
		SetPVarInt(playerid,"BuyColor1",GetPVarInt(playerid,"BuyColor1")-1);
		if(GetPVarInt(playerid,"BuyColor1") < 0) SetPVarInt(playerid,"BuyColor1",125);
	}
	ChangeVehicleColor(GetPlayerVehicleID(playerid), GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	if(booston == 0) format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~b~NAME: ~w~%s~n~~g~COST: ~w~%i~n~~y~COLOR1: ~w~%i ~y~COLOR2: ~w~%i",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1],GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	else if(booston == 1) format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~b~NAME: ~w~%s~n~~g~COST: ~w~%i~n~~y~COLOR1: ~w~%i ~y~COLOR2: ~w~%i",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1]-ShopCar[GetPVarInt(playerid, "SelectAvto")][1]*20/100,GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	GameTextForPlayer(playerid,string, 5000, 3);
	return 1;
}
ShowBuyCar(playerid)
{
	SetPVarInt(playerid, "SelectAvto", 0);
	switch(GetPVarInt(playerid,"CarShop"))
	{
	case 0: SetPVarInt(playerid, "SelectAvto", 0);//nope
	case 1: SetPVarInt(playerid, "SelectAvto", 20);//c
	case 2: SetPVarInt(playerid, "SelectAvto", 39);//d
	case 3: SetPVarInt(playerid, "SelectAvto", 72);//a
	case 4: SetPVarInt(playerid, "SelectAvto", 57);//b
	}
	PlayerTextDrawShow(playerid, ShopText[playerid]);
	for(new x; x < 12; x++) TextDrawShowForPlayer(playerid, AutoShopText[x]);
	SetPlayerVirtualWorld(playerid,playerid+1);
	SelectTextDraw(playerid, 0x0080FFFF);
	AutoSaloon[playerid] = true;
	return ShowingCar(playerid);
}
ExitCar(playerid)
{
	for(new x; x < 12; x++) TextDrawHideForPlayer(playerid, AutoShopText[x]);
	PlayerTextDrawHide(playerid, ShopText[playerid]);
	if(PTEMP[playerid][SalonCar] != INVALID_VEHICLE_ID) DestroyVehicle(PTEMP[playerid][SalonCar]);
	PTEMP[playerid][SalonCar] = INVALID_VEHICLE_ID;
	SetPVarInt(playerid,"SelectAvto",-1);
	CancelSelectTextDraw(playerid);
	if(GetPVarInt(playerid,"AutoShop") != 0)
	{
		switch(GetPVarInt(playerid,"AutoShop"))
		{
		case 1: return SetPosAutos(playerid,556.5716,-1292.6392,17.2482,0,0,0);
		case 2: return SetPosAutos(playerid,-1951.2544,293.6375,35.4688,0,0,0);
		case 3: return SetPosAutos(playerid,-1657.7015,1210.2267,7.2500,0,0,0);
		case 4: return SetPosAutos(playerid, 2200.8857,1394.2892,11.0625,0,0,0);
		}
	}
	DeletePVar(playerid,"AutoShop");
	DeletePVar(playerid,"CarShop");
	DeletePVar(playerid,"Nokick");
	AutoSaloon[playerid] = false;
	return true;
}
SetPosAutos(playerid,Float:x,Float:y,Float:z,Float:angle,Interiorid,worldid)
{
	SetPlayerPos(playerid,x,y,z);
	SetPlayerInterior(playerid,Interiorid);
	SetPlayerVirtualWorld(playerid,worldid);
	SetPlayerFacingAngle(playerid,angle);
	SetCameraBehindPlayer(playerid);
	return 1;
}
publics:ReklamaTimer()
{
	SendClientMessageToAll(0x8bb717aa," ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessageToAll(0x2cc72caa," Задайте ваш вопрос в поддержку сервера - /question");
	SendClientMessageToAll(0x2cc72caa," Ознакомьтесь с правилами игры на сайте meltrune.com");
	SendClientMessageToAll(0x8bb717aa," ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
}
DisableEnableReconButton(playerid, button, enable, show = 1)
{
	PlayerTextDrawHide(playerid, ReconPlayer[button]);

	if(!enable) PlayerTextDrawBoxColor(playerid,ReconPlayer[button], 0x00000055);
	else PlayerTextDrawBoxColor(playerid,ReconPlayer[button], 0xD97700AA);

	if(show) PlayerTextDrawShow(playerid, ReconPlayer[button]);
	return 1;
}
publics:SpecPlayers(playerid)
{
	StartSpectate(playerid, SpecAd[playerid]);
}
StartSpectate(playerid, specid)
{
	new httpquery[150], spName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, spName, sizeof(spName));
	DisallowSpawn[playerid] = 1;
	format(httpquery, sizeof(httpquery), "%s~n~ID: %i", spName, specid);
	PlayerTextDrawSetString(playerid, ReconPlayer[6],httpquery);
	if(IsPlayerInAnyVehicle(specid))
	{
		SetPlayerInterior(playerid,GetPlayerInterior(specid));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(specid));
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specid));
	}
	else
	{
		SetPlayerInterior(playerid,GetPlayerInterior(specid));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(specid));
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectatePlayer(playerid, specid);
	}
	return true;
}
StopSpectate(playerid)
{
	if(!Spectate[playerid]) return true;
	DisallowSpawn[playerid] = 0;
	if(SpecAd[playerid] != INVALID_PLAYER_ID) SpecID[SpecAd[playerid]] = 65535;
	SpecAd[playerid] = 65535;
	PlayerTextDrawHide(playerid, ReconPlayer[34]);
	TogglePlayerSpectating(playerid, 0);

	for(new i = 0; i < sizeof(ReconPlayer); i++)
	PlayerTextDrawHide(playerid, ReconPlayer[i]);

	for(new i = 7; i < sizeof(ReconPlayer); i++)
	DisableEnableReconButton(playerid, i, 0, 0);

	CancelSelectTextDraw(playerid);
	PlayerTextDrawSetString(playerid, ReconPlayer[5],"");
	PlayerTextDrawSetString(playerid, ReconPlayer[6],"");
	return true;
}
SubTextDelete(playerid)
{
	for(new i = 16; i < 35; i++)
	PlayerTextDrawHide(playerid, ReconPlayer[i]),DisableEnableReconButton(playerid, i, 0, 0);

	ReconSelectSub[playerid] = INVALID_TEXT_DRAW;

	DisableEnableReconButton(playerid, ReconSelect[playerid], 1);
	return 1;
}
/*
publics: OnPlayerInteriorChange(playerid)
{
	if(Spectate[SpecID[playerid]] == 1 && SpecAd[SpecID[playerid]] == playerid && SpecID[playerid] != INVALID_PLAYER_ID) StartSpectate(SpecID[playerid],playerid);
	return 1;
}
*/
CreateReconButtonn(playerid, Float:Xpos, Float:Ypos, button_text[], txtInit)
{
	ReconPlayer[txtInit] = CreatePlayerTextDraw(playerid,Xpos, Ypos, button_text);
	PlayerTextDrawBackgroundColor(playerid,ReconPlayer[txtInit], 0x000000AA);
	PlayerTextDrawFont(playerid,ReconPlayer[txtInit], 1);
	PlayerTextDrawLetterSize(playerid,ReconPlayer[txtInit], 0.200, 1.100);
	PlayerTextDrawColor(playerid,ReconPlayer[txtInit], 0xAAAAAAAA);
	PlayerTextDrawSetOutline(playerid,ReconPlayer[txtInit], 0);
	PlayerTextDrawAlignment(playerid,ReconPlayer[txtInit], 2);
	PlayerTextDrawSetProportional(playerid,ReconPlayer[txtInit], 1);
	PlayerTextDrawSetShadow(playerid,ReconPlayer[txtInit], 0);
	PlayerTextDrawUseBox(playerid,ReconPlayer[txtInit], 1);
	PlayerTextDrawBoxColor(playerid,ReconPlayer[txtInit], 0x00000055);
	PlayerTextDrawTextSize(playerid,ReconPlayer[txtInit], 11.000, 60.000);
	PlayerTextDrawSetSelectable(playerid, ReconPlayer[txtInit], 1);
	return 1;
}
GetNumberThisIP(test_ip[])
{
	new against_ip[32+1]; new ip_count = 0;
	foreach(x)
	{
		GetPlayerIp(x,against_ip,32);
		if(!strcmp(against_ip,test_ip))
		{
			ip_count++;
		}
	}
	return ip_count;
}
GetCasinoNumber(playerid)
{
	switch(GetPVarInt(playerid,"RNumber"))
	{
	case 0: SetPVarString(playerid,"RNumbers","0"), SetPVarInt(playerid,"RNumber_",1);
	case 1: SetPVarString(playerid,"RNumbers","1"), SetPVarInt(playerid,"RNumber_",1);
	case 3: SetPVarString(playerid,"RNumbers","2"), SetPVarInt(playerid,"RNumber_",1);
	case 5: SetPVarString(playerid,"RNumbers","3"), SetPVarInt(playerid,"RNumber_",1);
	case 11: SetPVarString(playerid,"RNumbers","4"), SetPVarInt(playerid,"RNumber_",1);
	case 13: SetPVarString(playerid,"RNumbers","5"), SetPVarInt(playerid,"RNumber_",1);
	case 15: SetPVarString(playerid,"RNumbers","6"), SetPVarInt(playerid,"RNumber_",1);
	case 21: SetPVarString(playerid,"RNumbers","7"), SetPVarInt(playerid,"RNumber_",1);
	case 23: SetPVarString(playerid,"RNumbers","8"), SetPVarInt(playerid,"RNumber_",1);
	case 25: SetPVarString(playerid,"RNumbers","9"), SetPVarInt(playerid,"RNumber_",1);
	case 31: SetPVarString(playerid,"RNumbers","10"), SetPVarInt(playerid,"RNumber_",1);
	case 33: SetPVarString(playerid,"RNumbers","11"), SetPVarInt(playerid,"RNumber_",1);
	case 35: SetPVarString(playerid,"RNumbers","12"), SetPVarInt(playerid,"RNumber_",1);
	case 41: SetPVarString(playerid,"RNumbers","13"), SetPVarInt(playerid,"RNumber_",1);
	case 43: SetPVarString(playerid,"RNumbers","14"), SetPVarInt(playerid,"RNumber_",1);
	case 45: SetPVarString(playerid,"RNumbers","15"), SetPVarInt(playerid,"RNumber_",1);
	case 51: SetPVarString(playerid,"RNumbers","16"), SetPVarInt(playerid,"RNumber_",1);
	case 53: SetPVarString(playerid,"RNumbers","17"), SetPVarInt(playerid,"RNumber_",1);
	case 55: SetPVarString(playerid,"RNumbers","18"), SetPVarInt(playerid,"RNumber_",1);
	case 61: SetPVarString(playerid,"RNumbers","19"), SetPVarInt(playerid,"RNumber_",1);
	case 63: SetPVarString(playerid,"RNumbers","20"), SetPVarInt(playerid,"RNumber_",1);
	case 65: SetPVarString(playerid,"RNumbers","21"), SetPVarInt(playerid,"RNumber_",1);
	case 71: SetPVarString(playerid,"RNumbers","22"), SetPVarInt(playerid,"RNumber_",1);
	case 73: SetPVarString(playerid,"RNumbers","23"), SetPVarInt(playerid,"RNumber_",1);
	case 75: SetPVarString(playerid,"RNumbers","24"), SetPVarInt(playerid,"RNumber_",1);
	case 81: SetPVarString(playerid,"RNumbers","25"), SetPVarInt(playerid,"RNumber_",1);
	case 83: SetPVarString(playerid,"RNumbers","26"), SetPVarInt(playerid,"RNumber_",1);
	case 85: SetPVarString(playerid,"RNumbers","27"), SetPVarInt(playerid,"RNumber_",1);
	case 91: SetPVarString(playerid,"RNumbers","28"), SetPVarInt(playerid,"RNumber_",1);
	case 93: SetPVarString(playerid,"RNumbers","29"), SetPVarInt(playerid,"RNumber_",1);
	case 95: SetPVarString(playerid,"RNumbers","30"), SetPVarInt(playerid,"RNumber_",1);
	case 101: SetPVarString(playerid,"RNumbers","31"), SetPVarInt(playerid,"RNumber_",1);
	case 103: SetPVarString(playerid,"RNumbers","32"), SetPVarInt(playerid,"RNumber_",1);
	case 105: SetPVarString(playerid,"RNumbers","33"), SetPVarInt(playerid,"RNumber_",1);
	case 111: SetPVarString(playerid,"RNumbers","34"), SetPVarInt(playerid,"RNumber_",1);
	case 113: SetPVarString(playerid,"RNumbers","35"), SetPVarInt(playerid,"RNumber_",1);
	case 115: SetPVarString(playerid,"RNumbers","36"), SetPVarInt(playerid,"RNumber_",1);
	case 2: SetPVarString(playerid,"RNumbers","1, 2"), SetPVarInt(playerid,"RNumber_",2);
	case 4: SetPVarString(playerid,"RNumbers","2, 3"), SetPVarInt(playerid,"RNumber_",2);
	case 6: SetPVarString(playerid,"RNumbers","1, 4"), SetPVarInt(playerid,"RNumber_",2);
	case 7: SetPVarString(playerid,"RNumbers","1, 2, 4, 5"), SetPVarInt(playerid,"RNumber_",4);
	case 8: SetPVarString(playerid,"RNumbers","2, 5"), SetPVarInt(playerid,"RNumber_",2);
	case 9: SetPVarString(playerid,"RNumbers","2, 3, 5, 6"), SetPVarInt(playerid,"RNumber_",4);
	case 10: SetPVarString(playerid,"RNumbers","3, 6"), SetPVarInt(playerid,"RNumber_",2);
	case 12: SetPVarString(playerid,"RNumbers","4, 5"), SetPVarInt(playerid,"RNumber_",2);
	case 14: SetPVarString(playerid,"RNumbers","5, 6"), SetPVarInt(playerid,"RNumber_",2);
	case 16: SetPVarString(playerid,"RNumbers","4, 7"), SetPVarInt(playerid,"RNumber_",2);
	case 17: SetPVarString(playerid,"RNumbers","4, 5, 7, 8"), SetPVarInt(playerid,"RNumber_",4);
	case 18: SetPVarString(playerid,"RNumbers","5, 8"), SetPVarInt(playerid,"RNumber_",2);
	case 19: SetPVarString(playerid,"RNumbers","5, 6, 8, 9"), SetPVarInt(playerid,"RNumber_",4);
	case 20: SetPVarString(playerid,"RNumbers","6, 9"), SetPVarInt(playerid,"RNumber_",2);
	case 22: SetPVarString(playerid,"RNumbers","7, 8"), SetPVarInt(playerid,"RNumber_",2);
	case 24: SetPVarString(playerid,"RNumbers","8, 9"), SetPVarInt(playerid,"RNumber_",2);
	case 26: SetPVarString(playerid,"RNumbers","7, 10"), SetPVarInt(playerid,"RNumber_",2);
	case 27: SetPVarString(playerid,"RNumbers","7, 8, 10, 11"), SetPVarInt(playerid,"RNumber_",4);
	case 28: SetPVarString(playerid,"RNumbers","8, 10"), SetPVarInt(playerid,"RNumber_",2);
	case 29: SetPVarString(playerid,"RNumbers","8, 9, 11, 12"), SetPVarInt(playerid,"RNumber_",4);
	case 30: SetPVarString(playerid,"RNumbers","9, 12"), SetPVarInt(playerid,"RNumber_",2);
	case 32: SetPVarString(playerid,"RNumbers","10, 11"), SetPVarInt(playerid,"RNumber_",2);
	case 34: SetPVarString(playerid,"RNumbers","11, 12"), SetPVarInt(playerid,"RNumber_",2);
	case 36: SetPVarString(playerid,"RNumbers","10, 13"), SetPVarInt(playerid,"RNumber_",2);
	case 37: SetPVarString(playerid,"RNumbers","10, 11, 13, 14"), SetPVarInt(playerid,"RNumber_",4);
	case 38: SetPVarString(playerid,"RNumbers","11, 14"), SetPVarInt(playerid,"RNumber_",2);
	case 39: SetPVarString(playerid,"RNumbers","11, 12, 14, 15"), SetPVarInt(playerid,"RNumber_",4);
	case 40: SetPVarString(playerid,"RNumbers","12, 15"), SetPVarInt(playerid,"RNumber_",2);
	case 42: SetPVarString(playerid,"RNumbers","13, 14"), SetPVarInt(playerid,"RNumber_",2);
	case 44: SetPVarString(playerid,"RNumbers","14, 15"), SetPVarInt(playerid,"RNumber_",2);
	case 46: SetPVarString(playerid,"RNumbers","13, 16"), SetPVarInt(playerid,"RNumber_",2);
	case 47: SetPVarString(playerid,"RNumbers","13, 14, 16, 17"), SetPVarInt(playerid,"RNumber_",4);
	case 48: SetPVarString(playerid,"RNumbers","14, 17"), SetPVarInt(playerid,"RNumber_",2);
	case 49: SetPVarString(playerid,"RNumbers","14, 15, 17, 18"), SetPVarInt(playerid,"RNumber_",4);
	case 50: SetPVarString(playerid,"RNumbers","15, 18"), SetPVarInt(playerid,"RNumber_",2);
	case 52: SetPVarString(playerid,"RNumbers","16, 17"), SetPVarInt(playerid,"RNumber_",2);
	case 54: SetPVarString(playerid,"RNumbers","17, 18"), SetPVarInt(playerid,"RNumber_",2);
	case 56: SetPVarString(playerid,"RNumbers","16, 19"), SetPVarInt(playerid,"RNumber_",2);
	case 57: SetPVarString(playerid,"RNumbers","16, 17, 19, 20"), SetPVarInt(playerid,"RNumber_",4);
	case 58: SetPVarString(playerid,"RNumbers","17, 20"), SetPVarInt(playerid,"RNumber_",2);
	case 59: SetPVarString(playerid,"RNumbers","17, 18, 20, 21"), SetPVarInt(playerid,"RNumber_",4);
	case 60: SetPVarString(playerid,"RNumbers","18, 21"), SetPVarInt(playerid,"RNumber_",2);
	case 62: SetPVarString(playerid,"RNumbers","19, 20"), SetPVarInt(playerid,"RNumber_",2);
	case 64: SetPVarString(playerid,"RNumbers","20, 21"), SetPVarInt(playerid,"RNumber_",2);
	case 66: SetPVarString(playerid,"RNumbers","19, 22"), SetPVarInt(playerid,"RNumber_",2);
	case 67: SetPVarString(playerid,"RNumbers","19, 20, 22, 23"), SetPVarInt(playerid,"RNumber_",4);
	case 68: SetPVarString(playerid,"RNumbers","20, 23"), SetPVarInt(playerid,"RNumber_",2);
	case 69: SetPVarString(playerid,"RNumbers","20, 21, 23, 24"), SetPVarInt(playerid,"RNumber_",4);
	case 70: SetPVarString(playerid,"RNumbers","21, 24"), SetPVarInt(playerid,"RNumber_",2);
	case 72: SetPVarString(playerid,"RNumbers","22, 23"), SetPVarInt(playerid,"RNumber_",2);
	case 74: SetPVarString(playerid,"RNumbers","23, 24"), SetPVarInt(playerid,"RNumber_",2);
	case 76: SetPVarString(playerid,"RNumbers","22, 25"), SetPVarInt(playerid,"RNumber_",2);
	case 77: SetPVarString(playerid,"RNumbers","22, 23, 25, 26"), SetPVarInt(playerid,"RNumber_",4);
	case 78: SetPVarString(playerid,"RNumbers","23, 26"), SetPVarInt(playerid,"RNumber_",2);
	case 79: SetPVarString(playerid,"RNumbers","23, 24, 26, 27"), SetPVarInt(playerid,"RNumber_",4);
	case 80: SetPVarString(playerid,"RNumbers","24, 27"), SetPVarInt(playerid,"RNumber_",2);
	case 82: SetPVarString(playerid,"RNumbers","25, 26"), SetPVarInt(playerid,"RNumber_",2);
	case 84: SetPVarString(playerid,"RNumbers","26, 27"), SetPVarInt(playerid,"RNumber_",2);
	case 86: SetPVarString(playerid,"RNumbers","25, 28"), SetPVarInt(playerid,"RNumber_",2);
	case 87: SetPVarString(playerid,"RNumbers","25, 26, 28, 29"), SetPVarInt(playerid,"RNumber_",4);
	case 88: SetPVarString(playerid,"RNumbers","26, 29"), SetPVarInt(playerid,"RNumber_",2);
	case 89: SetPVarString(playerid,"RNumbers","26, 27, 29, 30"), SetPVarInt(playerid,"RNumber_",4);
	case 90: SetPVarString(playerid,"RNumbers","27, 30"), SetPVarInt(playerid,"RNumber_",2);
	case 92: SetPVarString(playerid,"RNumbers","28, 29"), SetPVarInt(playerid,"RNumber_",2);
	case 94: SetPVarString(playerid,"RNumbers","29, 30"), SetPVarInt(playerid,"RNumber_",2);
	case 96: SetPVarString(playerid,"RNumbers","28, 31"), SetPVarInt(playerid,"RNumber_",2);
	case 97: SetPVarString(playerid,"RNumbers","28, 29, 31, 32"), SetPVarInt(playerid,"RNumber_",4);
	case 98: SetPVarString(playerid,"RNumbers","29, 32"), SetPVarInt(playerid,"RNumber_",2);
	case 99: SetPVarString(playerid,"RNumbers","29, 30, 32, 33"), SetPVarInt(playerid,"RNumber_",4);
	case 100: SetPVarString(playerid,"RNumbers","30, 33"), SetPVarInt(playerid,"RNumber_",2);
	case 102: SetPVarString(playerid,"RNumbers","31, 32"), SetPVarInt(playerid,"RNumber_",2);
	case 104: SetPVarString(playerid,"RNumbers","32, 33"), SetPVarInt(playerid,"RNumber_",2);
	case 106: SetPVarString(playerid,"RNumbers","31, 34"), SetPVarInt(playerid,"RNumber_",2);
	case 107: SetPVarString(playerid,"RNumbers","31, 32, 34, 35"), SetPVarInt(playerid,"RNumber_",4);
	case 108: SetPVarString(playerid,"RNumbers","32, 35"), SetPVarInt(playerid,"RNumber_",2);
	case 109: SetPVarString(playerid,"RNumbers","32, 33, 35, 36"), SetPVarInt(playerid,"RNumber_",4);
	case 110: SetPVarString(playerid,"RNumbers","33, 36"), SetPVarInt(playerid,"RNumber_",2);
	case 112: SetPVarString(playerid,"RNumbers","34, 35"), SetPVarInt(playerid,"RNumber_",2);
	case 114: SetPVarString(playerid,"RNumbers","35, 36"), SetPVarInt(playerid,"RNumber_",2);
	case 116: SetPVarString(playerid,"RNumbers","1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34"), SetPVarInt(playerid,"RNumber_",12);
	case 118: SetPVarString(playerid,"RNumbers","2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35"), SetPVarInt(playerid,"RNumber_",12);
	case 120: SetPVarString(playerid,"RNumbers","3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36"), SetPVarInt(playerid,"RNumber_",12);
	case 121: SetPVarString(playerid,"RNumbers","1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12"), SetPVarInt(playerid,"RNumber_",12);
	case 122: SetPVarString(playerid,"RNumbers","13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24"), SetPVarInt(playerid,"RNumber_",12);
	case 123: SetPVarString(playerid,"RNumbers","25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36"), SetPVarInt(playerid,"RNumber_",12);
	case 124: SetPVarString(playerid,"RNumbers","1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18"), SetPVarInt(playerid,"RNumber_",18);
	case 125: SetPVarString(playerid,"RNumbers","2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36"), SetPVarInt(playerid,"RNumber_",18);
	case 126: SetPVarString(playerid,"RNumbers","1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36"), SetPVarInt(playerid,"RNumber_",18);
	case 127: SetPVarString(playerid,"RNumbers","2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35"), SetPVarInt(playerid,"RNumber_",18);
	case 128: SetPVarString(playerid,"RNumbers","1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35"), SetPVarInt(playerid,"RNumber_",18);
	case 129: SetPVarString(playerid,"RNumbers","19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36"), SetPVarInt(playerid,"RNumber_",18);
	}
	return true;
}
publics:RouletCheck(idx)
{
	new strings[50];
	if(RouletPlay[idx])
	{
		if(RouletTimer[idx][0x1] < RouletTimer[idx][0x2])
		{
			RouletTimer[idx][0x1]++;
			RouletNumber[idx] = random(37);
			foreach(i)
			{
				if(GetPVarInt(i,"RStol") != idx && RouletKrupie[idx] != i) continue;
				switch(RouletNumber[idx])
				{
				case 0: format(strings, 20, "~g~%i", RouletNumber[idx]);
				case 1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36: format(strings, 20, "~r~%i", RouletNumber[idx]);
				default: format(strings, 20, "%i", RouletNumber[idx]);
				}
				GameTextForPlayer(i, strings, 4000, 6);
			}
		}
		else RouletPlay[idx] = false, RouletTimer[idx][0x1] = 0, RouletTimer[idx][0x2] = 0, RouletPrize[idx] = true;
	}
	foreach(i)
	{
		if(!RouletPrize[idx]) continue;
		if(GetPVarInt(i,"RStol") == idx || RouletKrupie[idx] == i)
		{
			if(!GetPVarInt(i,"RStavka") || RouletKrupie[idx] == i) SendMes(i,COLOR_YELLOW, " Выпало число %i.",RouletNumber[idx]);
			else if(GetPVarInt(i,"RStavka"))
			{
				new str[300], number[20], bool:null, null_;
				GetPVarString(i,"RNumbers",str,sizeof(str));
				sscanf(str,"p<,>a<i>[20]",number);
				null = false;
				for(new n = 0; n < GetPVarInt(i,"RNumber_"); n++) if(number[n] == RouletNumber[idx]) { null = true; break; }
				if(null == false) SendMes(i,COLOR_YELLOW," Выпало число %i. Ваша ставка проиграла!",RouletNumber[idx]), SetPlayerChatBubble(i,"Проиграл",COLOR_LIGHTRED,30.0,3000);
				else
				{
					switch(GetPVarInt(i,"RNumber_")) { case 1: null_ = 36; case 2: null_ = 8; case 4: null_ = 6; case 12: null_ = 3; case 18: null_ = 2; }
					SendMes(i,COLOR_YELLOW," Выпало число %i. Вы выиграли %i вирт!",RouletNumber[idx], GetPVarInt(i,"RStavka")*null_);
					PTEMP[i][pCash]+=GetPVarInt(i,"RStavka")*null_;
					SetPlayerChatBubble(i,"Выйграл",COLOR_LIGHTGREEN,30.0,3000);
				}
			}
		}
	}
	if(RouletPrize[idx])
	{
		RouletPrize[idx] = false;
		RouletPlay[idx] = false;
		RouletNumber[idx] = 0;
		KillTimer(RouletTimer[idx][0x0]);
		foreach(l)
		{
			if(!IsPlayerConnected(l) || IsPlayerNPC(l)) continue;
			if(GetPVarInt(l,"RStol") != idx || !GetPVarInt(l,"RStavka")) continue;
			switch(idx)
			{
			case 1..4:
				{
					if(CasinoInfo[1][caMafia] == 6) MafiaBank[0][nYakuza]+= GetPVarInt(l,"RStavka")/97;
					else if(CasinoInfo[1][caMafia] == 14) MafiaBank[0][nRm]+= GetPVarInt(l,"RStavka")/97;
					else if(CasinoInfo[1][caMafia] == 5) MafiaBank[0][nLcn]+= GetPVarInt(l,"RStavka")/97;
				}
			default:
				{
					if(CasinoInfo[2][caMafia] == 6) MafiaBank[0][nYakuza]+= GetPVarInt(l,"RStavka")/97;
					else if(CasinoInfo[2][caMafia] == 14) MafiaBank[0][nRm]+= GetPVarInt(l,"RStavka")/97;
					else if(CasinoInfo[2][caMafia] == 5) MafiaBank[0][nLcn]+= GetPVarInt(l,"RStavka")/97;
				}
			}
			PTEMP[RouletKrupie[idx]][pPayCheck]+=100;
			DestroyObject(GetPVarInt(l,"RObj"));
			new obj = CreateObject(random(5) + 1912,GetPVarFloat(l,"RXONE"),GetPVarFloat(l,"RYONE"),GetPVarFloat(l,"RZONE"),0.00,0.00,0.00);
			SetPVarFloat(l,"RX",GetPVarFloat(l,"RXONE"));
			SetPVarFloat(l,"RY",GetPVarFloat(l,"RYONE"));
			SetPVarFloat(l,"RZ",GetPVarFloat(l,"RZONE"));
			SetPlayerCameraLookAt(l,GetPVarFloat(l,"RXONE"),GetPVarFloat(l,"RYONE"),GetPVarFloat(l,"RZONE"));
			SetPVarInt(l,"RNumber",0);
			SetPVarInt(l,"RObj",obj);
			DeletePVar(l,"RStavka");
			DeletePVar(l,"RNumbers");
			DeletePVar(l,"RNumber_");
			PlayerTextDrawSetString(l,RouletText[l],"~<~~>~~up~~down~~n~~g~Money: none~n~~y~Bet: none");
		}
		DeletePVar(RouletKrupie[idx],"Roulet");
		RouletKrupie[idx] = INVALID_PLAYER_ID;
	}
	return true;
}
GetRoulet(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2, 1962.8666,1026.0941,993.3957)) return true;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1957.9739,1026.1073,993.3957)) return 2;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1958.1686,1008.0011,993.3957)) return 3;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1962.8086,1007.9399,993.3957)) return 4;
	//
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2230.8989,1619.5001,1006.2346)) return 5;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2242.4980,1619.5001,1006.2346)) return 6;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2230.8989,1613.5001,1006.2346)) return 7;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2242.4980,1613.5001,1006.2346)) return 8;
	//
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2230.8989,1594.5001,1006.2346)) return 9;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2242.4980,1594.5001,1006.2346)) return 10;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2230.8989,1588.5001,1006.2346)) return 11;
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2242.4980,1588.5001,1006.2346)) return 12;
	else return false;
}
GetCasino(playerid, idx)
{
	if(strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caManager],true) == 0 || strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caManager2],true) == 0 || strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caManager3],true) == 0) return 2;
	if(strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie],true) == 0 || strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie2],true) == 0 || strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie3],true) == 0
			|| strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie4],true) == 0 || strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie5],true) == 0 || strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie6],true) == 0 || strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie7],true) == 0
			|| strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie8],true) == 0 || strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie9],true) == 0 || strcmp(PTEMP[playerid][pName],CasinoInfo[idx][caKrupie10],true) == 0) return true;
	return false;
}
IsPlayerNearBone(playerid)
{
	for(new i; i <sizeof(BoneCoor); i++) if(IsPlayerInRangeOfPoint(playerid, 2.0, BoneCoor[i][0],BoneCoor[i][1],BoneCoor[i][2])) return i;
	return -1;
}
UpdateBone(idx)
{
	new strings[200], str[256];
	foreach(i)
	{
		if(GetPVarInt(i,"BoneStol")-1 == idx)
		{
			str = "";
			format(strings,40,"Table:_%i",idx+1);
			PlayerTextDrawSetString(i,PlayerBone[i][0],strings);
			format(strings,128,"Bet:_%i~n~Bank:_%i~n~Money:_%i",BoneInfo[idx][Bet],BoneInfo[idx][bBank],PTEMP[i][pCash]);
			PlayerTextDrawSetString(i,PlayerBone[i][3],strings);
			for(new i_ = 0; i_ < 5; i_++)
			{
				if(BoneInfo[idx][Gamer][i_] != INVALID_PLAYER_ID) format(strings,128,"%s~n~",PTEMP[BoneInfo[idx][Gamer][i_]][pName]);
				else format(strings,30,"--~n~");
				strcat(str,strings);
			}
			PlayerTextDrawSetString(i,PlayerBone[i][1],str);
			str = "";
			for(new i_ = 0; i_ < 5; i_++)
			{
				if(BoneInfo[idx][Gamer][i_] != INVALID_PLAYER_ID && GetPVarInt(BoneInfo[idx][Gamer][i_],"BoneStol_"))
				{
					if(GetPVarInt(BoneInfo[idx][Gamer][i_],"BoneStol_") == 1) format(strings,128,"++~n~");
					else format(strings,128,"%i~n~",GetPVarInt(BoneInfo[idx][Gamer][i_],"BoneStol_"));
				}
				else format(strings,30,"--~n~");
				strcat(str,strings);
			}
			PlayerTextDrawSetString(i,PlayerBone[i][2],str);
		}
	}
	return true;
}
ExitBone(playerid)
{
	new null[2] = 0;
	if(GetPVarInt(playerid,"BoneStol_") && BoneInfo[GetPVarInt(playerid,"BoneStol")-1][GameStart] <= 0)
	{
		PTEMP[playerid][pCash]+=BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Bet];
		BoneInfo[GetPVarInt(playerid,"BoneStol")-1][bBank]-=BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Bet];
	}
	foreach(i)
	{
		if(GetPVarInt(i,"BoneStol") == GetPVarInt(playerid,"BoneStol") && i != playerid && GetPVarInt(i,"BoneStol_") == 1) null[0]++;
		if(GetPVarInt(i,"BoneStol") == GetPVarInt(playerid,"BoneStol") && i != playerid && GetPVarInt(i,"BoneStol_") > 1) null[1]++;
	}
	if(null[0] == 0 && null[1] > 0) ShowItog(GetPVarInt(playerid,"BoneStol")-1);
	if(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Crupie] == playerid) BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Crupie] = INVALID_PLAYER_ID;
	for(new i; i != 4; i++) TextDrawHideForPlayer(playerid,Bone[i]), PlayerTextDrawHide(playerid,PlayerBone[playerid][i]);
	for(new i_ = 0; i_ != 5; i_++) if(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Gamer][i_] == playerid) BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Gamer][i_] = INVALID_PLAYER_ID;
	UpdateBone(GetPVarInt(playerid,"BoneStol")-1);
	DeletePVar(playerid,"BoneStol");
	DeletePVar(playerid,"BoneStol_");
	CancelSelectTextDraw(playerid);
	return true;
}
ShowItog(idx)
{
	new itog[3] = -1; itog[0] = -1; itog[1] = -1; itog[2] = -1;
	foreach(i)
	{
		if(GetPVarInt(i,"BoneStol")-1 == idx && GetPVarInt(i,"BoneStol_") > 1 && GetPVarInt(i,"BoneStol_") > itog[0]) itog[0] = GetPVarInt(i,"BoneStol_"), itog[1] = i;
		if(GetPVarInt(i,"BoneStol")-1 == idx && GetPVarInt(i,"BoneStol_") > 1 && i != itog[1] && GetPVarInt(i,"BoneStol_") == itog[0]) itog[2] = i;
	}
	if(itog[2] > -1)
	{
		foreach(i)
		{
			if(GetPVarInt(i,"BoneStol")-1 == idx && GetPVarInt(i,"BoneStol_") > 1 && GetPVarInt(i,"BoneStol_") == itog[0]) SetPVarInt(i,"BoneStol_",1), BoneInfo[idx][GameStart] = 30, SCM(i,0x4B00B0AA," Вы попали в следующий раунд. У вас есть 30 секунд, чтобы бросить кости");
			else if(GetPVarInt(i,"BoneStol")-1 == idx) DeletePVar(i,"BoneStol_");
		}
		UpdateBone(idx);
	}
	else if(itog[1] > -1)
	{
		format(string,128," Игра окончена. Победитель игры: %s",PTEMP[itog[1]][pName]);
		switch(idx)
		{
		case 0..5:
			{
				if(CasinoInfo[1][caMafia] == 6) MafiaBank[0][nYakuza]+= BoneInfo[idx][bBank]-(BoneInfo[idx][bBank]/100*90);
				else if(CasinoInfo[1][caMafia] == 14) MafiaBank[0][nRm]+= BoneInfo[idx][bBank]-(BoneInfo[idx][bBank]/100*90);
				else if(CasinoInfo[1][caMafia] == 5) MafiaBank[0][nLcn]+= BoneInfo[idx][bBank]-(BoneInfo[idx][bBank]/100*90);
			}
		default:
			{
				if(CasinoInfo[2][caMafia] == 6) MafiaBank[0][nYakuza]+= BoneInfo[idx][bBank]-(BoneInfo[idx][bBank]/100*90);
				else if(CasinoInfo[2][caMafia] == 14) MafiaBank[0][nRm]+= BoneInfo[idx][bBank]-(BoneInfo[idx][bBank]/100*90);
				else if(CasinoInfo[2][caMafia] == 5) MafiaBank[0][nLcn]+= BoneInfo[idx][bBank]-(BoneInfo[idx][bBank]/100*90);
			}
		}
		if(BoneInfo[idx][Crupie] != INVALID_PLAYER_ID) PTEMP[BoneInfo[idx][Crupie]][pPayCheck]+=150;
		PTEMP[itog[1]][pCash]+=BoneInfo[idx][bBank]-(BoneInfo[idx][bBank]/100*10);
		BoneInfo[idx][GameStart] = 0;
		BoneInfo[idx][Bet] = 0;
		BoneInfo[idx][bBank] = 0;
		foreach(i)
		{
			if(GetPVarInt(i,"BoneStol")-1 == idx)
			{
				SCM(i,0x4B00B0AA,string);
				DeletePVar(i,"BoneStol_");
			}
		}
		foreach(i)
		{
			if(GetPVarInt(i,"BoneStol")-1 == idx && IsPlayerNearBone(i) != idx) ExitBone(i);
		}
		UpdateBone(idx);
	}
	return true;
}
Up(playerid)
{
	new str[0x5];
	switch(GetPVarInt(playerid,"RStol"))
	{
	case 1..4:
		{
			str = "RY";
			switch(GetPVarInt(playerid,"RNumber"))
			{
			case 1..5: {
					SetPVarFloat(playerid,"RX",GetPVarFloat(playerid,"RXONE"));
					SetPVarFloat(playerid,"RY",GetPVarFloat(playerid,"RYONE"));
					SetPVarFloat(playerid,"RZ",GetPVarFloat(playerid,"RZONE"));
					SetPVarInt(playerid,"RNumber",0); }
			case 6..115: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.076), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-5);
			case 116,118,120: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.152), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-5);
			case 123,122: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.608), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-1);
			case 121: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-1.216), SetPVarInt(playerid,"RNumber",123);
			case 125..129: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.304), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-1);
			case 124: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-1.520), SetPVarInt(playerid,"RNumber",129);
			}
		}
	default:
		{
			str = "RX";
			switch(GetPVarInt(playerid,"RNumber"))
			{
			case 1..5: {
					SetPVarFloat(playerid,"RX",GetPVarFloat(playerid,"RXONE"));
					SetPVarFloat(playerid,"RY",GetPVarFloat(playerid,"RYONE"));
					SetPVarFloat(playerid,"RZ",GetPVarFloat(playerid,"RZONE"));
					SetPVarInt(playerid,"RNumber",0); }
			case 6..115: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.076), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-5);
			case 116,118,120: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.152), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-5);
			case 123,122: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.608), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-1);
			case 121: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+1.216), SetPVarInt(playerid,"RNumber",123);
			case 125..129: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.304), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-1);
			case 124: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+1.520), SetPVarInt(playerid,"RNumber",129);
			}
		}
	}
	SetObjectPos(GetPVarInt(playerid,"RObj"),GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"));
	return SetPlayerCameraLookAt(playerid,GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"));
}
Right(playerid)
{
	new str[0x5], str_[0x5];
	switch(GetPVarInt(playerid,"RStol"))
	{
	case 1..4: str = "RX", str_ = "RY";
	default: str = "RY", str_ = "RX";
	}
	switch(GetPVarInt(playerid,"RNumber"))
	{
	case 1..4,6..9,11..14,16..19,21..24,26..29,31..34,36..39,41..44,46..49,51..54,56..59,61..64,66..69,71..74,76..79,81..84,86..89,91..94,96..99,101..104,106..109,111..114: {
			SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.110);
			SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+1); }
	case 116,118: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+2);
	case 120: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.440), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-4);
	case 121: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarInt(playerid,"RNumber",16);
	case 122: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarInt(playerid,"RNumber",56);
	case 123: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarInt(playerid,"RNumber",96);
	case 129:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",123);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",123);
			}
		}
	case 128:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",123);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",123);
			}
		}
	case 127:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",122);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",122);
			}
		}
	case 126:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",122);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",122);
			}
		}
	case 125:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",121);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",121);
			}
		}
	case 124:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",121);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",121);
			}
		}
	}
	SetObjectPos(GetPVarInt(playerid,"RObj"),GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"));
	return SetPlayerCameraLookAt(playerid,GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"));
}
Left(playerid)
{
	new str[0x5], str_[0x5];
	switch(GetPVarInt(playerid,"RStol"))
	{
	case 1..4: str = "RX", str_ = "RY";
	default: str = "RY", str_ = "RX";
	}
	switch(GetPVarInt(playerid,"RNumber"))
	{
	case 2..5,7..10,12..15,17..20,22..25,27..30,32..35,37..40,42..45,47..50,52..55,57..60,62..65,67..70,72..75,77..80,82..85,87..90,92..95,97..100,102..105,107..110,112..115: {
			SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.110);
			SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-1); }
	case 118,120: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")-2);
	case 116: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.440), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+4);
	case 31:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.228), SetPVarInt(playerid,"RNumber",121);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.228), SetPVarInt(playerid,"RNumber",121);
			}
		}
	case 36:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.304), SetPVarInt(playerid,"RNumber",122);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.304), SetPVarInt(playerid,"RNumber",122);
			}
		}
	case 76:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.304), SetPVarInt(playerid,"RNumber",123);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.304), SetPVarInt(playerid,"RNumber",123);
			}
		}
	case 81:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.228), SetPVarInt(playerid,"RNumber",123);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.228), SetPVarInt(playerid,"RNumber",123);
			}
		}
	case 86:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",123);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",123);
			}
		}
	case 91:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.076), SetPVarInt(playerid,"RNumber",123);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.076), SetPVarInt(playerid,"RNumber",123);
			}
		}
	case 96: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarInt(playerid,"RNumber",123);
	case 101:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.076), SetPVarInt(playerid,"RNumber",123);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.076), SetPVarInt(playerid,"RNumber",123);
			}
		}
	case 106:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",123);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",123);
			}
		}
	case 111:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.228), SetPVarInt(playerid,"RNumber",123);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.228), SetPVarInt(playerid,"RNumber",123);
			}
		}
	case 71:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.228), SetPVarInt(playerid,"RNumber",122);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.228), SetPVarInt(playerid,"RNumber",122);
			}
		}
	case 26:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",121);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",121);
			}
		}
	case 66:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",122);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",122);
			}
		}
	case 21:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.076), SetPVarInt(playerid,"RNumber",121);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.076), SetPVarInt(playerid,"RNumber",121);
			}
		}
	case 61:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.076), SetPVarInt(playerid,"RNumber",122);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.076), SetPVarInt(playerid,"RNumber",121);
			}
		}
	case 16: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarInt(playerid,"RNumber",121);
	case 56: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarInt(playerid,"RNumber",122);
	case 11:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.076), SetPVarInt(playerid,"RNumber",121);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.076), SetPVarInt(playerid,"RNumber",121);
			}
		}
	case 51:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.076), SetPVarInt(playerid,"RNumber",122);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.076), SetPVarInt(playerid,"RNumber",122);
			}
		}
	case 6:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",121);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",121);
			}
		}
	case 46:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",122);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",122);
			}
		}
	case 1:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.228), SetPVarInt(playerid,"RNumber",121);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.228), SetPVarInt(playerid,"RNumber",121);
			}
		}
	case 41:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.228), SetPVarInt(playerid,"RNumber",122);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.228), SetPVarInt(playerid,"RNumber",122);
			}
		}
	case 121:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",124);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",124);
			}
		}
	case 122:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",126);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",126);
			}
		}
	case 123:
		{
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1..4: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.152), SetPVarInt(playerid,"RNumber",128);
			default: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.220), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.152), SetPVarInt(playerid,"RNumber",128);
			}
		}
	}
	SetObjectPos(GetPVarInt(playerid,"RObj"),GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"));
	return SetPlayerCameraLookAt(playerid,GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"));
}
Down(playerid)
{
	new str[0x5], str_[0x5];
	switch(GetPVarInt(playerid,"RStol"))
	{
	case 1..4:
		{
			str = "RY", str_ = "RX";
			switch(GetPVarInt(playerid,"RNumber"))
			{
			case 0: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.152), SetPVarInt(playerid,"RNumber",3);
			case 111,113,115: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.152), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+5);
			case 1..110: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.076), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+5);
			case 114: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.152), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.110), SetPVarInt(playerid,"RNumber",118);
			case 112: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.152), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.110), SetPVarInt(playerid,"RNumber",118);
			case 122,121: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.608), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+1);
			case 123: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+1.216), SetPVarInt(playerid,"RNumber",121);
			case 124..128: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-0.304), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+1);
			case 129: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+1.520), SetPVarInt(playerid,"RNumber",124);
			}
		}
	default:
		{
			str = "RX", str_ = "RY";
			switch(GetPVarInt(playerid,"RNumber"))
			{
			case 0: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.152), SetPVarInt(playerid,"RNumber",3);
			case 111,113,115: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.152), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+5);
			case 1..110: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.076), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+5);
			case 114: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.152), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)-0.110), SetPVarInt(playerid,"RNumber",118);
			case 112: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.152), SetPVarFloat(playerid,str_,GetPVarFloat(playerid,str_)+0.110), SetPVarInt(playerid,"RNumber",118);
			case 122,121: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.608), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+1);
			case 123: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-1.216), SetPVarInt(playerid,"RNumber",121);
			case 124..128: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)+0.304), SetPVarInt(playerid,"RNumber",GetPVarInt(playerid,"RNumber")+1);
			case 129: SetPVarFloat(playerid,str,GetPVarFloat(playerid,str)-1.520), SetPVarInt(playerid,"RNumber",124);
			}
		}
	}
	SetObjectPos(GetPVarInt(playerid,"RObj"),GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"));
	return SetPlayerCameraLookAt(playerid,GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"));
}

#include "..\gamemodes\OnMySQL_QUERY.pwn"

SpawnCarOne(playerid, Float:x, Float:y, Float:z, Float:range)
{
	garage_car[playerid][0] = CreateVehicle(CarInfo[playerid][carModel][0], x, y, z, range , CarInfo[playerid][carColor_one][0] ,CarInfo[playerid][carColor_two][0], 86400);
	SetVehicleParamsEx(garage_car[playerid][0],false,false,false,true,false,false,false);
	CarHealth[garage_car[playerid][0]] = float(1000);
	createdcar ++;
	Fuell[garage_car[playerid][0]] = CarInfo[playerid][carFuel][0];
	LoadTuning(playerid,garage_car[playerid][0],0);
	SetPVarInt(playerid,"CarsInGarage",1);
	CarInfo[playerid][carID][0] = garage_car[playerid][0];
}
SpawnCarTwo(playerid, Float:x, Float:y, Float:z, Float:range)
{
	garage_car[playerid][1] = CreateVehicle(CarInfo[playerid][carModel][1], x, y, z, range , CarInfo[playerid][carColor_one][1] ,CarInfo[playerid][carColor_two][1], 86400);
	SetVehicleParamsEx(garage_car[playerid][1],false,false,false,true,false,false,false);
	CarHealth[garage_car[playerid][1]] = float(1000);
	createdcar ++;
	Fuell[garage_car[playerid][1]] = CarInfo[playerid][carFuel][0];
	LoadTuning(playerid,garage_car[playerid][1],1);
	SetPVarInt(playerid,"CarsInGarage",1);
	CarInfo[playerid][carID][1] = garage_car[playerid][1];
}
SpawnCarThree(playerid, Float:x, Float:y, Float:z, Float:range)
{
	garage_car[playerid][2] = CreateVehicle(CarInfo[playerid][carModel][2], x, y, z, range , CarInfo[playerid][carColor_one][2] ,CarInfo[playerid][carColor_two][2], 86400);
	SetVehicleParamsEx(garage_car[playerid][0],false,false,false,true,false,false,false);
	CarHealth[garage_car[playerid][2]] = float(1000);
	createdcar ++;
	Fuell[garage_car[playerid][2]] = CarInfo[playerid][carFuel][2];
	LoadTuning(playerid,garage_car[playerid][2],2);
	SetPVarInt(playerid,"CarsInGarage",1);
	CarInfo[playerid][carID][2] = garage_car[playerid][2];
}
SpawnCarFour(playerid, Float:x, Float:y, Float:z, Float:range)
{
	garage_car[playerid][3] = CreateVehicle(CarInfo[playerid][carModel][3], x, y, z, range , CarInfo[playerid][carColor_one][3] ,CarInfo[playerid][carColor_two][3], 86400);
	SetVehicleParamsEx(garage_car[playerid][3],false,false,false,true,false,false,false);
	CarHealth[garage_car[playerid][3]] = float(1000);
	createdcar ++;
	Fuell[garage_car[playerid][3]] = CarInfo[playerid][carFuel][3];
	LoadTuning(playerid,garage_car[playerid][3],3);
	SetPVarInt(playerid,"CarsInGarage",1);
	CarInfo[playerid][carID][3] = garage_car[playerid][3];
}
SpawnCarFive(playerid, Float:x, Float:y, Float:z, Float:range)
{
	garage_car[playerid][4] = CreateVehicle(CarInfo[playerid][carModel][4], x, y, z, range , CarInfo[playerid][carColor_one][4] ,CarInfo[playerid][carColor_two][4], 86400);
	SetVehicleParamsEx(garage_car[playerid][4],false,false,false,true,false,false,false);
	CarHealth[garage_car[playerid][4]] = float(1000);
	createdcar ++;
	Fuell[garage_car[playerid][4]] = CarInfo[playerid][carFuel][4];
	LoadTuning(playerid,garage_car[playerid][4],4);
	SetPVarInt(playerid,"CarsInGarage",1);
	CarInfo[playerid][carID][4] = garage_car[playerid][4];
}

#include "..\gamemodes\custom\SaveMySQL.pwn"
#include "..\gamemodes\custom\PlayerRegister.pwn"

GetHouseOplata(idx)
{
	switch(HouseInfo[idx][hKlass])
	{
	case 0,4: return 50;
	case 1,3: return 100;
	case 2: return 150;
	case 5: return 0;
	}
	return -1;
}
IsANoLimiter(carid)
{
	if(IsABoat(carid) || IsAPlane(carid) || GetVehicleModel(carid) == 462 || GetVehicleModel(carid) == 481 || GetVehicleModel(carid) == 509 || GetVehicleModel(carid) == 510) return true;
	return false;
}
setVehicleSpeed(vehicleid, speed_mph)
{
	if (speed_mph < 1) speed_mph = 1;
	new Float: v[3], cur_speed_mph;
	GetVehicleVelocity(vehicleid, v[0], v[1], v[2]);
	cur_speed_mph = floatround(100.3 *floatsqroot(v[0]*v[0] + v[1]*v[1] + v[2]*v[2]),floatround_floor);
	if (cur_speed_mph <= 0)
	{
		new Float: zAngle;
		GetVehicleZAngle(vehicleid, zAngle);
		new Float:newVelX = floatcos((zAngle -= 270.0), degrees) *speed_mph / 100.3;
		SetVehicleVelocity(vehicleid, newVelX, floattan(zAngle,degrees) *newVelX, 0.0);
		return;
	}
	new Float: vMultiplier = float(speed_mph) / float(cur_speed_mph);
	SetVehicleVelocity(vehicleid, v[0] *vMultiplier, v[1] *vMultiplier, v[2] *vMultiplier);
}
publics:DellAccount(playerid, stringg[])
{
	new r, f, null = 0;
	cache_get_data(r, f);
	if(!r) return SCM(playerid,COLOR_GREY," Аккаунт не найден");
	for(new i = 1; i <= TotalHouse;i++) if(strcmp(HouseInfo[i][hOwner],stringg,false) == 0 && strcmp(HouseInfo[i][hOwner],"None",true) != 0) null = i;
	if(null != 0)
	{
		HouseInfo[null][hTakings] = 0;
		strmid(HouseInfo[null][hOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
		HouseInfo[null][hLock] = 1;
		HouseInfo[null][hHel] = 0;
	}
	null = 0;
	for(new i = 1; i <= TotalBizz;i++) if(strcmp(BizzInfo[i][bOwner],stringg,false) == 0 && strcmp(BizzInfo[i][bOwner],"None",true) != 0) null = i;
	if(null != 0) ClearBizz(null);
	null = 0;
	for(new i = 1; i <= ALLKVARTIRI; i++) if(strcmp(kvartinfo[i][vladelec],stringg,false) == 0) null = i;
	if(null != 0)
	{
		kvartinfo[null][aptek] = 0;
		kvartinfo[null][lock] = 0;
		kvartinfo[null][plata] = 0;
		strmid(kvartinfo[null][vladelec], "None", 0, strlen("None"), 10);
		updatekvar(null);
	}
	null = 0;
	for(new i = 1; i <= TOTALSHOPS; i++) if(strcmp(WorkshopInfo[i][wOwner],stringg,false) == 0) null = i;
	if(null != 0)
	{
		strmid(WorkshopInfo[null][wOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[null][wDeputy1],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[null][wDeputy2],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[null][wDeputy3],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[null][wMechanic1],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[null][wMechanic2],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[null][wMechanic3],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[null][wMechanic4],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(WorkshopInfo[null][wMechanic5],"None",0,strlen("None"),MAX_PLAYER_NAME);
		WorkshopInfo[null][wAuction][0] = 0;
		WorkshopInfo[null][wAuction][1] = 0;
		WorkshopInfo[null][wAuction][2] = 0;
		WorkshopInfo[null][wAuction][3] = 0;
		WorkshopInfo[null][wAuction][4] = 0;
		WorkshopInfo[null][wLandTax] = 0;
		WorkshopInfo[null][wBank] = 0;
		WorkshopInfo[null][wProds] = 0;
		WorkshopInfo[null][wPriceProds] = 50;
		WorkshopInfo[null][wZp] = 5;
	}
	null = 0;
	for(new i = 1; i <= TOTALFARM; i++) if(strcmp(FarmInfo[i][fOwner],stringg,false) == 0) null = i;
	if(null != 0)
	{
		strmid(FarmInfo[null][fOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(FarmInfo[null][fDeputy_1],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(FarmInfo[null][fDeputy_2],"None",0,strlen("None"),MAX_PLAYER_NAME);
		strmid(FarmInfo[null][fDeputy_3],"None",0,strlen("None"),MAX_PLAYER_NAME);
		FarmInfo[null][fAuction][0] = 0;
		FarmInfo[null][fAuction][1] = 0;
		FarmInfo[null][fAuction][2] = 0;
		FarmInfo[null][fAuction][3] = 0;
		FarmInfo[null][fAuction][4] = 0;
		FarmInfo[null][fLandTax] = 0;
		FarmInfo[null][fBank] = 0;
		FarmInfo[null][fProds] = 0;
		FarmInfo[null][fZp] = 30;
		FarmInfo[null][fGrain_Price] = 5;
		FarmInfo[null][fGrain] = 0;
		FarmInfo[null][fGrain_Sown] = 0;
		FarmInfo[null][fProds_Selling] = 1;
		FarmInfo[null][fProds_Price] = 21;
	}
	format(string, sizeof(string), " Администратор %s удалил аккаунт %s", PTEMP[playerid][pName], stringg);
	ABroadCast(COLOR_LIGHTRED,string,7);
	printf("Администратор %s удалил аккаунт %s",Name(playerid), stringg);
	mysql_format(DATABASE, QUERY, sizeof(QUERY), "DELETE FROM `"TABLE_ADMIN"` WHERE name = '%s'",stringg);
	mysql_function_query(DATABASE, QUERY, false, "", "");
	mysql_format(DATABASE, QUERY, sizeof(QUERY), "DELETE FROM `"TABLE_CARS"` WHERE owner = '%s'",stringg);
	mysql_function_query(DATABASE, QUERY, false, "", "");
	mysql_format(DATABASE, QUERY, sizeof(QUERY), "DELETE FROM `"TABLE_ACCOUNTS"` WHERE name = '%s'",stringg);
	return mysql_function_query(DATABASE, QUERY, false, "", "");
}
HGet(playerid)
{
	new house = 0;
	for(new i = 1; i <= TotalHouse;i++)
	{
		if(strcmp(HouseInfo[i][hOwner],PTEMP[playerid][pName],false) == 0 && strcmp(HouseInfo[i][hOwner],"None",true) != 0) house++, PTEMP[playerid][pPHouseKey] = i;
	}
	return house;
}
BGet(playerid)
{
	new house = 0;
	for(new i = 1; i <= TotalBizz;i++)
	{
		if(strcmp(BizzInfo[i][bOwner],PTEMP[playerid][pName],false) == 0 && strcmp(BizzInfo[i][bOwner],"None",true) != 0) house++, PTEMP[playerid][pPBizzKey] = i;
	}
	return house;
}
WGet(playerid)
{
	new house = 0;
	for(new i = 1; i <= TOTALSHOPS;i++)
	{
		if(strcmp(WorkshopInfo[i][wOwner],PTEMP[playerid][pName],false) == 0 && strcmp(WorkshopInfo[i][wOwner],"None",true) != 0) house++, SetPVarInt(playerid, "wShop", i);
	}
	return house;
}
KGet(playerid)
{
	new house = 0;
	for(new i = 1; i <= ALLKVARTIRI; i++)
	{
		if(strcmp(kvartinfo[i][vladelec],PTEMP[playerid][pName],false) == 0 && strcmp(kvartinfo[i][vladelec],"None",true) != 0) house++, PTEMP[playerid][pKvartiraKey] = i;
	}
	return house;
}
FGet(playerid)
{
	new house = 0;
	for(new i = 1; i <= TOTALFARM; i++)
	{
		if(strcmp(FarmInfo[i][fOwner],PTEMP[playerid][pName],false) == 0 && strcmp(FarmInfo[i][fOwner],"None",true) != 0) house++, PTEMP[playerid][pPFarmKey] = i;
	}
	return house;
}
GetKvart()
{
	for(new k = 1; k <= ALLKVARTIRI; k++)
	{
		if(!strcmp(kvartinfo[k][vladelec],"None",true)) continue;
		if(kvartinfo[k][plata] < 100)
		{
			if(GetPlayerID(kvartinfo[k][vladelec]) != INVALID_PLAYER_ID) SetPVarInt(GetPlayerID(kvartinfo[k][vladelec]), "GetKvart", 1);
			kvartinfo[k][aptek] = 0;
			kvartinfo[k][lock] = 0;
			kvartinfo[k][plata] = 0;
			strmid(kvartinfo[k][vladelec], "None", 0, strlen("None"), 10);
			updatekvar(k);
		}
		else kvartinfo[k][plata]-=100;
	}
	return true;
}
GetBizz()
{
	for(new i = 1; i <= TotalBizz; i++)
	{
		if(BizzInfo[i][bStavka] > 0 && strcmp(BizzInfo[i][bOwner],"None",true) == 0 && BizzInfo[i][bTimeStavka] > 0) BizzInfo[i][bTimeStavka]--;
		if(BizzInfo[i][bTimeStavka] == 0 && BizzInfo[i][bStavka] > 0)
		{
			mysql_format(DATABASE,QUERY,256,"SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'",BizzInfo[i][bNameStavka]);
			mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",12,i,"");
		}
		if(strcmp(BizzInfo[i][bOwner],"None",true) != 0) continue;
		if(BizzInfo[i][bLandTax] < BizzLandTax[i] || BizzInfo[i][bLocked] == 1 && BizzInfo[i][bLockTime] > 12) ClearBizz(i);
		else
		{
			if(BizzInfo[i][bProducts] <= 0)
			{
				BizzInfo[i][bLocked] = 1;
				if(IsPlayerConnected(GetPlayerID(BizzInfo[i][bOwner])))
				{
					if(BizzInfo[i][bLockTime] == 0) SetPVarInt(GetPlayerID(BizzInfo[i][bOwner]), "_GetBizz_", 1);
				}
			}
			if(BizzInfo[i][bLocked] == 1)BizzInfo[i][bLockTime]++;
			if(BizzInfo[i][bLockTime] > 1 && BizzInfo[i][bLockTime] < 12)if(IsPlayerConnected(GetPlayerID(BizzInfo[i][bOwner]))) SetPVarInt(GetPlayerID(BizzInfo[i][bOwner]), "GetBizz_", 1);
			if(BizzInfo[i][bMafia] == 6) MafiaBank[0][nYakuza] += 500;
			if(BizzInfo[i][bMafia] == 14) MafiaBank[0][nRm] += 500;
			if(BizzInfo[i][bMafia] == 5) MafiaBank[0][nLcn] += 500;
		}
	}
	return true;
}
GetHome()
{
	for(new i = 1; i <= TotalHouse; i++)
	{
		if(strcmp("None",HouseInfo[i][hOwner],true) == 0) continue;
		if(HouseInfo[i][hTakings] < GetHouseOplata(i))
		{
			if(GetPlayerID(HouseInfo[i][hOwner]) != INVALID_PLAYER_ID)
			{
				PTEMP[GetPlayerID(HouseInfo[i][hOwner])][pHousecash] += HouseInfo[i][hValue];
				SetPVarInt(GetPlayerID(HouseInfo[i][hOwner]), "GetHome", 1);
			}
			else
			{
				mysql_format(DATABASE,QUERY,300, "UPDATE "TABLE_ACCOUNTS"  SET pHousecash = 'pHousecash+%i', pText = '1' WHERE Name = '%s'",HouseInfo[i][hValue],HouseInfo[i][hOwner]);
				mysql_function_query(DATABASE, QUERY, true, "", "");
			}
			strmid(HouseInfo[i][hOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
			HouseInfo[i][hTakings] = 0;
			HouseInfo[i][hLock] = 1;
			HouseInfo[i][hHel] = 0;
			for(new h = 0; h < 10; h++) HouseInfo[i][hSafe][h] = 0;
			BuyHouse(i);
		}
		else HouseInfo[i][hTakings] -= GetHouseOplata(i);
		robhouse[i] = false;
	}
	return true;
}
GetShop()
{
	for(new i = 1; i <= TOTALSHOPS; i++)
	{
		if(WorkshopInfo[i][wAuction][0] > 0 && strcmp(WorkshopInfo[i][wOwner],"None",true) == 0 && WorkshopInfo[i][wAuction][2] > 0) WorkshopInfo[i][wAuction][2]--;
		if(WorkshopInfo[i][wAuction][2] == 0 && WorkshopInfo[i][wAuction][0] > 0)
		{
			mysql_format(DATABASE,QUERY,256,"SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'",WorkshopInfo[i][wAuctionName]);
			mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",24,i,"");
		}
		if(strcmp("None",WorkshopInfo[i][wOwner],true) == 0) continue;
		new null = WorkshopInfo[i][wAuction][4];
		if(WorkshopInfo[i][wLandTax] < 500 || (null < Now() && null != 0))
		{
			if(GetPlayerID(WorkshopInfo[i][wOwner]) != INVALID_PLAYER_ID)
			{
				if(null > Now()) SetPVarInt(GetPlayerID(WorkshopInfo[i][wOwner]), "GetShop", 1);
				PTEMP[GetPlayerID(WorkshopInfo[i][wOwner])][pBank] += WorkshopInfo[i][wBank]+WorkshopInfo[i][wLandTax];
			}
			else
			{
				mysql_format(DATABASE,QUERY,300, "UPDATE "TABLE_ACCOUNTS"  SET pBank = 'pBank+%i' WHERE Name = '%s'",WorkshopInfo[i][wBank]+WorkshopInfo[i][wLandTax],WorkshopInfo[i][wOwner]);
				mysql_function_query(DATABASE, QUERY, true, "", "");
			}
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
		}
		else
		{
			WorkshopInfo[i][wLandTax] -= 500;
			if(WorkshopInfo[i][wProds] < 20000 && WorkshopInfo[i][wBank] > 2*(20000-WorkshopInfo[i][wProds])) WorkshopInfo[i][wProds] = 20000, WorkshopInfo[i][wBank]-=2*(20000-WorkshopInfo[i][wProds]);
			WorkshopInfo[i][wBank] -= 4000;
			switch(WorkshopInfo[i][wBiker])
			{
				case 24:
				{
					FracBank[0][fHamc] += 4000;
				}
				case 26:
				{
					FracBank[0][fWmc] += 4000;
				}
				case 29:
				{
					FracBank[0][fPmc] += 4000;
				}
			}
		}
	}
	return true;
}
GetFarm()
{
	for(new i = 1; i <= TOTALFARM; i++)
	{
		if(FarmInfo[i][fAuction][0] > 0 && strcmp(FarmInfo[i][fOwner],"None",true) == 0 && FarmInfo[i][fAuction][2] > 0) FarmInfo[i][fAuction][2]--;
		if(FarmInfo[i][fAuction][2] == 0 && FarmInfo[i][fAuction][0] > 0)
		{
			mysql_format(DATABASE,QUERY,256,"SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'",FarmInfo[i][fAuctionName]);
			mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",29,i,"");
		}
		if(strcmp("None",FarmInfo[i][fOwner],true) == 0) continue;
		new null = FarmInfo[i][fAuction][4];
		if(FarmInfo[i][fLandTax] < 500 || (null < Now() && null != 0))
		{
			if(GetPlayerID(FarmInfo[i][fOwner]) != INVALID_PLAYER_ID)
			{
				if(null > Now()) SetPVarInt(GetPlayerID(FarmInfo[i][fOwner]), "GetFarm", 1);
				PTEMP[GetPlayerID(FarmInfo[i][fOwner])][pBank] += FarmInfo[i][fBank]+FarmInfo[i][fLandTax];
			}
			else
			{
				mysql_format(DATABASE,QUERY,300, "UPDATE "TABLE_ACCOUNTS"  SET pBank = 'pBank+%i' WHERE Name = '%s'",FarmInfo[i][fBank]+FarmInfo[i][fLandTax],FarmInfo[i][fOwner]);
				mysql_function_query(DATABASE, QUERY, true, "", "");
			}
			strmid(FarmInfo[i][fOwner],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(FarmInfo[i][fDeputy_1],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(FarmInfo[i][fDeputy_2],"None",0,strlen("None"),MAX_PLAYER_NAME);
			strmid(FarmInfo[i][fDeputy_3],"None",0,strlen("None"),MAX_PLAYER_NAME);
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
		}
		else
		{
			FarmInfo[i][fLandTax] -= 500;
			FarmInfo[i][fBank] -= 4000;
            switch(FarmInfo[i][fBiker])
			{
				case 24:
				{
					FracBank[0][fHamc] += 4000;
				}
				case 26:
				{
					FracBank[0][fWmc] += 4000;
				}
				case 29:
				{
					FracBank[0][fPmc] += 4000;
				}
			}
		}
	}
	return true;
}
ShowDetals(playerid,targetid,idx)
{
	new dstirng[90],str[1500],count = 3;
	new till = WorkshopInfo[idx][wPriceProds];
	SetPVarInt(playerid,"installation_",targetid);
	strcat(str, "Услуга\tНазвание\tЦена\n");
	format(dstirng, sizeof(dstirng), "[0] Удалить тюнинг\n");
	strcat(str, dstirng);
	strcat(str,"[1] Ремонт двигателя\n");
	format(dstirng, sizeof(dstirng),"[2] Перекраска\t\t\"%i вирт\"\n",till*500);
	strcat(str,dstirng);
	
	for(new i;i<MAX_VEHICLE_COMPONENT;i++)
	{
		if(!IsVehicleUpgradeCompatible(GetVehicleModel(house_car[targetid]),AllTuningComponentsInfo[i][idcomp])) continue;
		format(dstirng, sizeof(dstirng), "[%i] %s\t\"%s\"\t\"%i вирт\"\n",count,AllTuningComponentsInfo[i][Type], AllTuningComponentsInfo[i][Name], till*AllTuningComponentsInfo[i][Cost]);
		strcat(str,dstirng);
		AwtomasMassiveID[playerid][count-3] = i;
		count++;
	}
	ShowPlayerDialogEx(playerid,6500,DIALOG_STYLE_TABLIST_HEADERS,"Доступные детали",str,"Далее","Закрыть");
	return 1;
}
GetFarmjob(playerid, idx)
{
	if(strcmp(PTEMP[playerid][pName],FarmInfo[idx][fDeputy_1],true) == 0 || strcmp(PTEMP[playerid][pName],FarmInfo[idx][fDeputy_2],true) == 0 || strcmp(PTEMP[playerid][pName],FarmInfo[idx][fDeputy_3],true) == 0) return 2;
	if(strcmp(PTEMP[playerid][pName],FarmInfo[idx][fFarmer_1],true) == 0 || strcmp(PTEMP[playerid][pName],FarmInfo[idx][fFarmer_2],true) == 0 || strcmp(PTEMP[playerid][pName],FarmInfo[idx][fFarmer_3],true) == 0
			|| strcmp(PTEMP[playerid][pName],FarmInfo[idx][fFarmer_4],true) == 0 || strcmp(PTEMP[playerid][pName],FarmInfo[idx][fFarmer_5],true) == 0) return true;
	return false;
}
GetWorkshop(playerid, idx)
{
	if(strcmp(PTEMP[playerid][pName],WorkshopInfo[idx][wDeputy1],true) == 0 || strcmp(PTEMP[playerid][pName],WorkshopInfo[idx][wDeputy2],true) == 0 || strcmp(PTEMP[playerid][pName],WorkshopInfo[idx][wDeputy3],true) == 0) return 2;
	if(strcmp(PTEMP[playerid][pName],WorkshopInfo[idx][wMechanic1],true) == 0 || strcmp(PTEMP[playerid][pName],WorkshopInfo[idx][wMechanic2],true) == 0 || strcmp(PTEMP[playerid][pName],WorkshopInfo[idx][wMechanic3],true) == 0
			|| strcmp(PTEMP[playerid][pName],WorkshopInfo[idx][wMechanic4],true) == 0 || strcmp(PTEMP[playerid][pName],WorkshopInfo[idx][wMechanic5],true) == 0) return true;
	return false;
}
GetWorkshopW(playerid, idx)
{
	if(strcmp(PTEMP[playerid][pName],WorkshopInfo[idx][wOwner],true) == 0) return true;
	return false;
}
LoadTuning(c,carid,index)
{
		if(CarInfo[c][carVehcom_1][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_1][index]);
		if(CarInfo[c][carVehcom_2][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_2][index]);
		if(CarInfo[c][carVehcom_3][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_3][index]);
		if(CarInfo[c][carVehcom_4][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_4][index]);
		if(CarInfo[c][carVehcom_5][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_5][index]);
		if(CarInfo[c][carVehcom_6][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_6][index]);
		if(CarInfo[c][carVehcom_7][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_7][index]);
		if(CarInfo[c][carVehcom_8][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_8][index]);
		if(CarInfo[c][carVehcom_9][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_9][index]);
		if(CarInfo[c][carVehcom_10][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_10][index]);
		if(CarInfo[c][carVehcom_11][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_11][index]);
		if(CarInfo[c][carVehcom_12][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_12][index]);
		if(CarInfo[c][carVehcom_13][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_13][index]);
		if(CarInfo[c][carVehcom_14][index]!=0) AddVehicleComponent(carid, CarInfo[c][carVehcom_14][index]);
}
SaveTuning(playerid,i)
{
	CarInfo[playerid][carVehcom_1][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_SPOILER);
	CarInfo[playerid][carVehcom_2][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_HOOD);
	CarInfo[playerid][carVehcom_3][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_ROOF);
	CarInfo[playerid][carVehcom_4][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_SIDESKIRT);
	CarInfo[playerid][carVehcom_5][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_LAMPS);
	CarInfo[playerid][carVehcom_6][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_NITRO);
	CarInfo[playerid][carVehcom_7][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_EXHAUST);
	CarInfo[playerid][carVehcom_8][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_WHEELS);
	CarInfo[playerid][carVehcom_9][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_STEREO);
	CarInfo[playerid][carVehcom_10][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_HYDRAULICS);
	CarInfo[playerid][carVehcom_11][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_FRONT_BUMPER);
	CarInfo[playerid][carVehcom_12][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_REAR_BUMPER);
	CarInfo[playerid][carVehcom_13][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_VENT_RIGHT);
	CarInfo[playerid][carVehcom_14][GetPVarInt(playerid, "chosencar")]=GetVehicleComponentInSlot(i, CARMODTYPE_VENT_LEFT);
}
RemoveTuning(c,carid)
{
	new s = GetPVarInt(c, "chosencar");
	if(CarInfo[c][carVehcom_1][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_1][s]), CarInfo[c][carVehcom_1][s] = 0;
	if(CarInfo[c][carVehcom_2][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_2][s]), CarInfo[c][carVehcom_2][s] = 0;
	if(CarInfo[c][carVehcom_3][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_3][s]), CarInfo[c][carVehcom_3][s] = 0;
	if(CarInfo[c][carVehcom_4][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_4][s]), CarInfo[c][carVehcom_4][s] = 0;
	if(CarInfo[c][carVehcom_5][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_5][s]), CarInfo[c][carVehcom_5][s] = 0;
	if(CarInfo[c][carVehcom_6][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_6][s]), CarInfo[c][carVehcom_6][s] = 0;
	if(CarInfo[c][carVehcom_7][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_7][s]), CarInfo[c][carVehcom_7][s] = 0;
	if(CarInfo[c][carVehcom_8][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_8][s]), CarInfo[c][carVehcom_8][s] = 0;
	if(CarInfo[c][carVehcom_9][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_9][s]), CarInfo[c][carVehcom_9][s] = 0;
	if(CarInfo[c][carVehcom_10][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_10][s]), CarInfo[c][carVehcom_10][s] = 0;
	if(CarInfo[c][carVehcom_11][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_11][s]), CarInfo[c][carVehcom_11][s] = 0;
	if(CarInfo[c][carVehcom_12][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_12][s]), CarInfo[c][carVehcom_12][s] = 0;
	if(CarInfo[c][carVehcom_13][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_13][s]), CarInfo[c][carVehcom_13][s] = 0;
	if(CarInfo[c][carVehcom_14][s]!=0) RemoveVehicleComponent(carid, CarInfo[c][carVehcom_14][s]), CarInfo[c][carVehcom_14][s] = 0;
}
WorkshopStats(playerid, idx)
{
	new str[768];
	format(YCMDstr,90," Автомастерская: %i\n",idx); strcat(str,YCMDstr);
	format(YCMDstr,90," Владелец: %s\n",WorkshopInfo[idx][wOwner]); strcat(str,YCMDstr);
	format(YCMDstr,90," Баланс банка: %i вирт\n",WorkshopInfo[idx][wBank]); strcat(str,YCMDstr);
	format(YCMDstr,90," Баланс счета 'LandTax': %i вирт\n",WorkshopInfo[idx][wLandTax]); strcat(str,YCMDstr);
	format(YCMDstr,90," Цена продукта: %i вирт\n",WorkshopInfo[idx][wPriceProds]); strcat(str,YCMDstr);
	format(YCMDstr,90," Продукта: %i / 20000\n",WorkshopInfo[idx][wProds]); strcat(str,YCMDstr);
	format(YCMDstr,90," Плата рабочим: %i процентов\n\n",WorkshopInfo[idx][wZp]); strcat(str,YCMDstr);
	format(YCMDstr,90," Заместитель: %s\n",WorkshopInfo[idx][wDeputy1]); strcat(str,YCMDstr);
	format(YCMDstr,90," Заместитель: %s\n",WorkshopInfo[idx][wDeputy2]); strcat(str,YCMDstr);
	format(YCMDstr,90," Заместитель: %s\n\n",WorkshopInfo[idx][wDeputy3]); strcat(str,YCMDstr);
	format(YCMDstr,90," Механик: %s\n",WorkshopInfo[idx][wMechanic1]); strcat(str,YCMDstr);
	format(YCMDstr,90," Механик: %s\n",WorkshopInfo[idx][wMechanic2]); strcat(str,YCMDstr);
	format(YCMDstr,90," Механик: %s\n",WorkshopInfo[idx][wMechanic3]); strcat(str,YCMDstr);
	format(YCMDstr,90," Механик: %s\n",WorkshopInfo[idx][wMechanic4]); strcat(str,YCMDstr);
	format(YCMDstr,90," Механик: %s\n",WorkshopInfo[idx][wMechanic5]); strcat(str,YCMDstr);
	return ShowPlayerDialogEx(playerid,0,DIALOG_STYLE_MSGBOX, "Информ. об Автомастерской",str, "Скрыть", "");
}
FarmStats(playerid, idx)
{
	new str[32];
	string = "";
	switch(FarmInfo[idx][fProds_Selling]) { case 1: str = "Картофель"; default: str = "Веселая трава"; }
	format(YCMDstr,90," Владелец: %s\n",FarmInfo[idx][fOwner]); strcat(string,YCMDstr);
	format(YCMDstr,90," Баланс банка: %i\n",FarmInfo[idx][fBank]); strcat(string,YCMDstr);
	format(YCMDstr,90," Баланс счета 'LandTax': %i\n",FarmInfo[idx][fLandTax]); strcat(string,YCMDstr);
	format(YCMDstr,90," Цена за работу: %i\n\n",FarmInfo[idx][fZp]); strcat(string,YCMDstr);
	format(YCMDstr,90," Цена зерна: %i\n",FarmInfo[idx][fGrain_Price]); strcat(string,YCMDstr);
	format(YCMDstr,90," Зерна закуплено: %i / 10000\n",FarmInfo[idx][fGrain]); strcat(string,YCMDstr);
	format(YCMDstr,90," Зерна засеяно: %i / 5000\n",FarmInfo[idx][fGrain_Sown]); strcat(string,YCMDstr);
	format(YCMDstr,90," Продаваемый продукт: %s\n",str); strcat(string,YCMDstr);
	format(YCMDstr,90," Количество на складе: %i / 10000\n",FarmInfo[idx][fProds]); strcat(string,YCMDstr);
	format(YCMDstr,90," Цена продукта: %i\n\n",FarmInfo[idx][fProds_Price]); strcat(string,YCMDstr);
	format(YCMDstr,90," Заместитель: %s\n",FarmInfo[idx][fDeputy_1]); strcat(string,YCMDstr);
	format(YCMDstr,90," Заместитель: %s\n",FarmInfo[idx][fDeputy_2]); strcat(string,YCMDstr);
	format(YCMDstr,90," Заместитель: %s\n\n",FarmInfo[idx][fDeputy_3]); strcat(string,YCMDstr);
	format(YCMDstr,90," Фермер: %s\n",FarmInfo[idx][fFarmer_1]); strcat(string,YCMDstr);
	format(YCMDstr,90," Фермер: %s\n",FarmInfo[idx][fFarmer_2]); strcat(string,YCMDstr);
	format(YCMDstr,90," Фермер: %s\n",FarmInfo[idx][fFarmer_3]); strcat(string,YCMDstr);
	format(YCMDstr,90," Фермер: %s\n",FarmInfo[idx][fFarmer_4]); strcat(string,YCMDstr);
	format(YCMDstr,90," Фермер: %s\n",FarmInfo[idx][fFarmer_5]); strcat(string,YCMDstr);
	return ShowPlayerDialogEx(playerid,0,DIALOG_STYLE_MSGBOX, "Информация о Ферме",string, "Скрыть", "");
}
FarmStatsPay(playerid, idx)
{
	string = "";
	format(YCMDstr,90,"{FFFFFF}Рабочих: {FFEA06}%i\n",FarmStatPayS[idx][0]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Фермеров: {FFEA06}%i\n",FarmStatPayS[idx][1]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Собрано урожая: {FFEA06}%i\n",FarmStatPayS[idx][2]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Доставлено урожая на склад: {FFEA06}%i\n",FarmStatPayS[idx][3]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Куплено зерна: {FFEA06}%i\n",FarmStatPayS[idx][4]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Продано урожая: {FFEA06}%i\n\n",FarmStatPayS[idx][5]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Потрачено на покупку зерна: {D80000}%i\n",FarmStatPayS[idx][6]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Зарплата рабочим и фермерам: {D80000}%i\n",FarmStatPayS[idx][7]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Заработано на продаже урожая: {55C713}%i\n\n",FarmStatPayS[idx][8]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Всего заработано: {55C713}%i\n",FarmStatPayS[idx][8]-(FarmStatPayS[idx][7]+FarmStatPayS[idx][6])); strcat(string,YCMDstr);
	return ShowPlayerDialogEx(playerid,0,DIALOG_STYLE_MSGBOX, "Статистика за прошлый час",string, "Закрыть", "");
}
FarmStatsDay(playerid, idx)
{
	string = "";
	format(YCMDstr,90,"{FFFFFF}Рабочих: {FFEA06}%i\n",FarmStatDay[idx][0]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Фермеров: {FFEA06}%i\n",FarmStatDay[idx][1]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Собрано урожая: {FFEA06}%i\n",FarmStatDay[idx][2]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Доставлено урожая на склад: {FFEA06}%i\n",FarmStatDay[idx][3]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Куплено зерна: {FFEA06}%i\n",FarmStatDay[idx][4]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Продано урожая: {FFEA06}%i\n\n",FarmStatDay[idx][5]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Потрачено на покупку зерна: {D80000}%i\n",FarmStatDay[idx][6]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Зарплата рабочим и фермерам: {D80000}%i\n",FarmStatDay[idx][7]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Заработано на продаже урожая: {55C713}%i\n\n",FarmStatDay[idx][8]); strcat(string,YCMDstr);
	format(YCMDstr,90,"{FFFFFF}Всего заработано: {55C713}%i\n",FarmStatDay[idx][8]-(FarmStatDay[idx][7]+FarmStatDay[idx][6])); strcat(string,YCMDstr);
	return ShowPlayerDialogEx(playerid,0,DIALOG_STYLE_MSGBOX, "Статистика за весь день",string, "Закрыть", "");
}
ShowHelpDialog(playerid, dialog)
{
	string = "";
	if(dialog+2 != 19) SetPVarInt(playerid, "help_dialog", dialog + 2);
	else SetPVarInt(playerid, "help_dialog", 2);
	switch(dialog)
	{
	case 0:
		{
			ShowPlayerDialogEx(playerid,1467,2,"Помощь","[1] Общение\n[2] Список игроков\n[3] Транспорт\n[4] Транспорт часть 2\n[5] Общее\n[6] Оружие и Убийство\n[7] Role Play\n[8] Первые шаги\n[9] Первые шаги часть 2\n[10] Первые шаги часть 3\n[11] Часовая зарплата\n[12] Зарплата фракции\n[13] Бизнес\n[14] Местность\n[15] Законопослушность\n[16] Дома\n[17] Дом часть 2","Далее","Выход");
			return SetPVarInt(playerid,"help_dialog", 1);
		}
	case 1:
		{
			strcat(string,"<< Общение >>\n\n");
			strcat(string,"Вы можете обращаться с другими игроками через чат в левом верхнем углу.\n");
			strcat(string,"Чтобы напечатать сообщение нажмите клавишу \"F6\" или \"T\"(на латинеце).\n");
			strcat(string,"Так же с помощью чата используются все команды сервера, к примеру \"/mm\".\n\n\n");
			strcat(string,"Используйте \"/mm\" для просмотра команд...\n");
			strcat(string,"Более подробное описание вы найдете на нашем сайте meltrune.com");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Общение",string,"Далее","Меню");
		}
	case 2:
		{
			strcat(string,"<< Список игроков >>\n\n");
			strcat(string,"Данный список можно посмотреть нажав клавишу \"TAB\".\n");
			strcat(string,"Там вы увидете:\n\n");
			strcat(string,"\"ID\" игрока(используется в командах)\n");
			strcat(string,"\"Ник(РП имя игрока)\"\n");
			strcat(string,"\"Уровень(lvl)\" в графе score(Повышается автоматически каждый отыгранный час)\n");
			strcat(string,"\"Пинг\" это не слишком важно, поэтому я не буду нагружать вас лишней информацией.\n\n");
			strcat(string,"Для просмотра списка полностью, используйте прокрутку с право.\n");
			strcat(string,"Вы в этой табличке всегда отображаетесь первым, независимо от ID.");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Список игроков",string,"Далее","Меню");
		}
	case 3:
		{
			strcat(string,"<< Транспорт >>\n\n");
			strcat(string,"Я надеюсь вы умеете ездить, но даже если нет, наши Авто Инструкторы вас научат.\n");
			strcat(string,"В Автошколу вам придется идти в любом случае, поскольку езда разрешена только\n");
			strcat(string,"с правами. Ну а пока вы можете воспользоваться мотороллером,\n");
			strcat(string,"Или же общественным транспортом\n\n");
			strcat(string,"Для того чтобы сесть на пассажирское место используйте клавишу \"G\"");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Транспорт",string,"Далее","Меню");
		}
	case 4:
		{
			strcat(string,"<< Общее >>\n\n");
			strcat(string,"Играя на сервере ваш лвл повышается автоматически.\n");
			strcat(string,"После получения определенного левла открываются новые возможности\n\n");
			strcat(string,"Но уровень персонажа не главное! На нашем сервере можно зарабатывать\n");
			strcat(string,"деньги, после покупать дома, машины и т.д Можно вступить в банду и воевать за\n");
			strcat(string,"территории, тем самым расширяя бизнес. Или стать членом мафии.\n\n");
			strcat(string,"Можно работать полицейским защищая гражданских. И это только малая часть доступного!");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Общее",string,"Далее","Меню");
		}
	case 5:
		{
			strcat(string,"<< Транспорт >>\n\n");
			strcat(string,"Для управления автомобилем необходимы водительские права, а для пилотирования самолета\n");
			strcat(string,"лицензия пилота. Транспорту нужен бензин, которым можно заправиться на любой заправке.\n");
			strcat(string,"При нарушении Правил дорожного движения(превышение скорости...), вас могут оштрафовать.\n\n");
			strcat(string,"<< Работа >>\n\n");
			strcat(string,"Многие профессии доступны каждому гражданскому. Устроиться на работу можно в Мэрии.\n");
			strcat(string,"К примеру Водитель автобуса, Таксист, Механик.");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Транспорт часть 2",string,"Далее","Меню");
		}
	case 6:
		{
			strcat(string,"<< Оружие и Убийство >>\n\n");
			strcat(string,"Для ношения оружия необходима лицензия, без нее вас не впустят в магазин.\n");
			strcat(string,"Но оружие можно достать и другими способами.\n\n");
			strcat(string,"За убийcтво человека вы будете объявлены в розыск, как опасный преступник,\n");
			strcat(string,"а при аресте вы лишитесь крупной суммы денег и сядете в тюрьму!\n");
			strcat(string,"Изначально ваши навыки владения оружием будут малы, но со временем вы сможете\n");
			strcat(string,"стать элитным стрелком, и относиться к вам будут с уважением!");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Оружие и Убийство",string,"Далее","Меню");
		}
	case 7:
		{
			strcat(string,"Role Play - Ролевая игра, игра по ролям.\n");
			strcat(string,"Я объясню более понятно. Вам предоставлены уже готовые роли, к примеру\n");
			strcat(string,"Бандит, Полицейский.\n");
			strcat(string,"Состоя в банде вы продаете наркотики, оружие. Грабите военные склады и т.п.\n");
			strcat(string,"Состоя в Полиции вы следите за порядком, и пытаетесь посадить тех же бандитов.\n");
			strcat(string,"Если вам не нравиться выше написанное, то можете стать к примеру репортером, и\n");
			strcat(string,"вести собственную передачу по радио.");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Role Play",string,"Далее","Меню");
		}
	case 8:
		{
			strcat(string,"<< Первые шаги (Первые деньги) >>\n\n");
			strcat(string,"Вам потребуются деньги, заработать немного денег вы можете на заводе, работая грузчиком.\n");
			strcat(string,"Добраться на завод вы можете на автобусе \'Внутригородской LS\' или на такси,\n");
			strcat(string,"таксист отвезет вас бесплатно, просто сядьте в свободное такси.\n");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Первые шаги",string,"Далее","Меню");
		}
	case 9:
		{
			strcat(string,"<< Первые шаги (Водительские права) >>\n\n");
			strcat(string,"Как только вы заработаете немного денег, отправляйтесь в автошколу.\n");
			strcat(string,"Автошкола находиться в Сан Фиерро (2ой город).\n");
			strcat(string,"Стоимость сдачи экзамена состовляет 500 вирт.\n");
			strcat(string,"Добраться вы можете на автобусе \'Лос Сантос - Сан Фиерро\'.");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Первые шаги часть 2",string,"Далее","Меню");
		}
	case 10:
		{
			strcat(string,"<< Первые шаги (Постоянная работа) >>\n\n");
			strcat(string,"После того как вы заработаете денег и получите права,\n");
			strcat(string,"вы сможете устроиться на официальную работу.\n");
			strcat(string,"Устроиться на работу, и ознакомиться со списком профессий, вы можете в мэрии.\n");
			strcat(string,"Добирайтесь на \'Внутригородском LS\'");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Первые шаги часть 3",string,"Далее","Меню");
		}
	case 11:
		{
			strcat(string,"<< Часовая зарплата >>\n\n");
			strcat(string,"Каждый час в 00 игроки получают банковский чек, в котором указаны все доходы и\n");
			strcat(string,"расходы.\n");
			strcat(string,"Доходы: Зарплата с работы.\n");
			strcat(string,"Расходы: Налог государству (после 5 лвл), Счет за телефон (если вы звонили),\n");
			strcat(string,"Кварплата (если вы владелец дома).");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Часовая зарплата",string,"Далее","Меню");
		}
	case 12:
		{
			strcat(string,"<< Зарплата фракции >>\n\n");
			strcat(string,"В некоторых фракциях вы получаете Зарплату каждый час от государства.\n");
			strcat(string,"В других эта зарплата выдается лидером. Все организации на сервере имеют\n");
			strcat(string,"свой заработок. Где то нелегальный бизнес, где то постоянная зарплата.\n\n");
			strcat(string,"Банды: Бизнес(Нелегальный), Оружие и Наркотики, Ограбление.\n");
			strcat(string,"Репортеры: Бизнес(Легальный), Реклама.\n");
			strcat(string,"Мэрия: От адвоката до Управления казной.");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Зарплата фракции",string,"Далее","Меню");
		}
	case 13:
		{
			strcat(string,"<< Бизнес >>\n\n");
			strcat(string,"Все клубы, бары, забегаловки являются бизнесами, которые можно арендовать.\n");
			strcat(string,"По мимо этого еще есть Бензоправки и Магазины.\n");
			strcat(string,"Чтобы заработать на бизнесе нужен начальный капитал. Для лицензии,\n");
			strcat(string,"Аренды помещения, Продуктов.");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Бизнес",string,"Далее","Меню");
		}
	case 14:
		{
			strcat(string,"<< Местность >>\n\n");
			strcat(string,"Лос Сантос(1 город) самый опасный город, так как здесь большое количество\n");
			strcat(string,"бандитов. Районы банд выделены на карте особыми цветами, но только там\n");
			strcat(string,"можно купить оружие по дешевле и ни кто не спросит у вас лицензии\n\n");
			strcat(string,"Сан Фиерро(2 город). Если не хотите каждый день сталкиваться с беззаконием,\n");
			strcat(string,"то поселитесь в этом городе.\n\n");
			strcat(string,"Лас Вентурас(3 город). Город азарта, город богачей. Конечно здесь не такие раскошные\n");
			strcat(string,"особняки как на VINEWOOD, но улицы самые красивые.");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Местность",string,"Далее","Меню");
		}
	case 15:
		{
			strcat(string,"<< Законопослушность >>\n\n");
			strcat(string,"У каждого игрока есть индикатор, который показывает как вы относитесь к закону.\n");
			strcat(string,"-100 и +100 Минимум и максимум. Узнать можно заглянув в ваш пасспорт \"/showpass [ид]\"\n");
			strcat(string,"С плохим отношением к закону вас могут не принять во многии Фракции, но в банду\n");
			strcat(string,"попасть легче.\n\n");
			strcat(string,"Законопослушность повышается каждый час на 1, однако может резко упасть если\n");
			strcat(string,"совершите преступление");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Законопослушность",string,"Далее","Меню");
		}
	case 16:
		{
			strcat(string,"<< Дома >>\n\n");
			strcat(string,"Вы можете в любой момент купить себе дом, тогда при смерти или входе в игру\n");
			strcat(string,"вы будете появляться там. По мимо этого у вас появиться место для парковки машины,\n");
			strcat(string,"а значит вы можете купить себе красивое авто.\n");
			strcat(string,"Дома поделенны по классам - [Nope] [D] [C] [B] [A] [S]. Класс говорит о цене и красоте\n");
			strcat(string,"дома как внутри, так и снаружи.");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Дома",string,"Далее","Меню");
		}
	case 17:
		{
			strcat(string,"После покупки дома с вашего банковского счета будут сниматься Кварплата, она зависит от класса дома.\n");
			strcat(string,"Важное примечание! Деньги снимаются каждый час даже когда вы оффлайн.\n\n");
			strcat(string,"<< Личный транспорт >>\n\n");
			strcat(string,"У нас есть несколько Автосалонов, где вы можете приобрести себе машину. Все они\n");
			strcat(string,"указаны в \"/GPS\". Транспорт как и дома разделены по классам.\n");
			strcat(string,"Чтобы выбрать себе машину, воспользуйтесь командой \"/Buycar\". Далее вы\n");
			strcat(string,"увидете подсказку по клавишам с правой стороны, а снизу цену и цвет.");
			return ShowPlayerDialogEx(playerid, 1467, 0,"Дома часть 2",string,"Далее","Меню");
		}
	}
	return true;
}
publics:Farmduty(playerid)
{
	DisablePlayerRaceCheckpoint(playerid);
	SetVehicleParamsEx(GetPlayerVehicleID(playerid),false,false,false,false,false,false,false);
	new Float:X12, Float:Y12, Float:Z12;
	new carid = GetPlayerVehicleID(playerid);
	SetVehicleVelocity(carid, 0.0, 0.0, 0.0);
	GetVehiclePos(carid, X12, Y12, Z12);
	GetXYInBackOfPlayer(playerid, X12, Y12,3.0);
	Farmcar_pickup[GetPlayerVehicleID(playerid)] = CreatePickup(19197,23,X12,Y12,Z12+0.3);
	format(string, sizeof(string), "Загружено\n{ffffff}%d / 1000",Farmcar_prods[GetPlayerVehicleID(playerid)]);
	Farmcar_text[GetPlayerVehicleID(playerid)] = Create3DTextLabel(string, 0x5CABBDAA, X12, Y12, Z12+1.0, 40.0, 0, 0);
	Farmcar_works[GetPlayerVehicleID(playerid)] = true;
	SCM(playerid, 0x0073B7AA, " Машина на месте. Теперь вы и и ваши рабочие могут загружать ее");
	SCM(playerid, 0x0073B7AA, " Если решите завершить сбор урожая, сядьте снова в машину");
	RemovePlayerFromVehicleAC(playerid);
	TogglePlayerControllable(playerid, 1);
	return true;
}
publics:FarmDuty(playerid)
{
	DeletePVar(playerid,"farm_status");
	if(!FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown]) return SCM(playerid,COLOR_RED,"На поле недостаточно урожая");
	if(FarmInfo[GetPVarInt(playerid,"farm_id")][fBank] < FarmInfo[GetPVarInt(playerid,"farm_id")][fZp]) return SCM(playerid,COLOR_RED,"На балансе фермы недостаточно средств");
	if(IsPlayerInCheckpoint(playerid))
	{

		SetPVarInt(playerid,"farm_status",2);
		SetPlayerAttachedObject(playerid, 3, 856, 6, 0.086999, 0.036999, 0.000000, 0.000000, 0.000000, 0.000000, 0.010999, 0.009000, 0.085999);
		TogglePlayerControllable(playerid, 1);
		ClearAnim(playerid);
		oldpickup[playerid] = -1;
		KillTimer(Farmtimer[playerid]);
		DisablePlayerCheckpoint(playerid);
	}
	return true;
}
CheatKick(playerid,number)
{
	if(PTEMP[playerid][pAdmin] && PTEMP[playerid][pLogin]) return true;
	if(GetPVarInt(playerid,"CheatKick") > 0) return true;
	SetPVarInt(playerid,"CheatKick",1);
	SendMes(playerid,COLOR_LIGHTRED," Вы были кикнуты по подозрению в читерстве! (#%i)",number);
	format(string, 150, " <KICK> <ERROR #%i> %s(%i): Был отсоединен от сервера!",number,PTEMP[playerid][pName], playerid);
	SendAdminMessage(COLOR_RED,string);
	return Kick(playerid);
}
public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ) return EditObject(playerid,objectid);
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(response) SetDynamicObjectPos(objectid,x, y, z), SetDynamicObjectRot(objectid,rx,ry,rz);
	if(response == 1) SendMes(playerid,-1," Позиция объекта изменена. [X: %.2f] [Y: %.2f] [Z: %.2f] [RX: %.2f] [RY: %.2f] [RZ: %.2f]",x,y,z,rx,ry,rz);
	return true;
}
public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z) return EditDynamicObject(playerid,objectid);
public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	if(response) SetObjectPos(objectid,fX,fY,fZ), SetObjectRot(objectid,fRotX,fRotY,fRotZ);
	if(response == 1) SendMes(playerid,-1," Позиция объекта изменена. [X: %.2f] [Y: %.2f] [Z: %.2f] [RX: %.2f] [RY: %.2f] [RZ: %.2f]",fX,fY,fZ,fRotX,fRotY,fRotZ);
	return true;
}
GetRank(targetid)
{
	new rangz[40];
	switch(PTEMP[targetid][pMember])
	{
	case 0: rangz = "";
	case 1,10,21:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 14: { rangz = "Шериф"; }
			case 13: { rangz = "Полковник"; }
			case 12: { rangz = "Подполковник";}
			case 11: { rangz = "Майор"; }
			case 10: { rangz = "Капитан"; }
			case 9: { rangz = "Ст. Лейтенант"; }
			case 8: { rangz = "Лейтенант"; }
			case 7: { rangz = "Мл. Лейтенант"; }
			case 6: { rangz = "Ст. Прапорщик"; }
			case 5: { rangz = "Прапорщик"; }
			case 4: { rangz = "Сержант"; }
			case 3: { rangz = "Мл. Сержант"; }
			case 2: { rangz = "Офицер"; }
			case 1: { rangz = "Кадет"; }
			}
		}
	case 2:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Директор FBI"; }
			case 9: { rangz = "Зам.Директора FBI"; }
			case 8: { rangz = "Инспектор FBI"; }
			case 7: { rangz = "Глава CID"; }
			case 6: { rangz = "Глава GNK"; }
			case 5: { rangz = "Агент CID"; }
			case 4: { rangz = "Агент GNK"; }
			case 3: { rangz = "Мл.Агент"; }
			case 2: { rangz = "Дежурный"; }
			case 1: { rangz = "Стажёр"; }
			}
		}
	case 19:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 15: { rangz = "Генерал"; }
			case 14: { rangz = "Полковник"; }
			case 13: { rangz = "Подполковник"; }
			case 12: { rangz = "Майор";}
			case 11: { rangz = "Капитан"; }
			case 10: { rangz = "Старший лейтенант"; }
			case 9: { rangz = "Лейтенант"; }
			case 8: { rangz = "Младший лейтенант"; }
			case 7: { rangz = "Прапорщик"; }
			case 6: { rangz = "Старшина"; }
			case 5: { rangz = "Ст. Сержант"; }
			case 4: { rangz = "Сержант"; }
			case 3: { rangz = "Мл. Сержант"; }
			case 2: { rangz = "Ефрейтор"; }
			case 1: { rangz = "Рядовой"; }
			}
		}
	case 3:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 15: { rangz = "Адмирал"; }
			case 14: { rangz = "Вице-Адмирал"; }
			case 13: { rangz = "Контр-Адмирал"; }
			case 12: { rangz = "Каптин 1-го ранга";}
			case 11: { rangz = "Капитан-Лейтенант"; }
			case 10: { rangz = "Ст.Лейтенант"; }
			case 9: { rangz = "Лейтенант"; }
			case 8: { rangz = "Мл.Лейтенант"; }
			case 7: { rangz = "Ст.Мичман"; }
			case 6: { rangz = "Мичман"; }
			case 5: { rangz = "Мл.Мичман"; }
			case 4: { rangz = "Старшина"; }
			case 3: { rangz = "Ст.Матрос"; }
			case 2: { rangz = "Матрос"; }
			case 1: { rangz = "Юнга"; }
			}
		}
	case 4,22,33:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Глав.Врач"; }
			case 9: { rangz = "Зам Глав.Врача"; }
			case 8: { rangz = "Хирург"; }
			case 7: { rangz = "Психолог"; }
			case 6: { rangz = "Доктор"; }
			case 5: { rangz = "Нарколог"; }
			case 4: { rangz = "Спасатель"; }
			case 3: { rangz = "Мед.Брат"; }
			case 2: { rangz = "Санитар"; }
			case 1: { rangz = "Интерн"; }
			}
		}
	case 5:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Дон"; }
			case 9: { rangz = "Консильери"; }
			case 8: { rangz = "Младший Босс"; }
			case 7: { rangz = "Капо"; }
			case 6: { rangz = "Сотто-Капо"; }
			case 5: { rangz = "Боец"; }
			case 4: { rangz = "Солдато"; }
			case 3: { rangz = "Сомбаттенте"; }
			case 2: { rangz = "Ассосиато"; }
			case 1: { rangz = "Новицио"; }
			}
		}
	case 6:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Кумите"; }
			case 9: { rangz = "Оядзи"; }
			case 8: { rangz = "Cайко-Комон"; }
			case 7: { rangz = "Камбу"; }
			case 6: { rangz = "Со-Хомбуте"; }
			case 5: { rangz = "Вагакасира"; }
			case 4: { rangz = "Фуку-Комбуте"; }
			case 3: { rangz = "Кедай"; }
			case 2: { rangz = "Сятей"; }
			case 1: { rangz = "Вакасю"; }
			}
		}
	case 7:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 6: { rangz = "Мэр"; }
			case 5: { rangz = "Зам. мэра"; }
			case 4: { rangz = "Начальник охраны"; }
			case 3: { rangz = "Охранник"; }
			case 2: { rangz = "Адвокат"; }
			case 1: { rangz = "Секретарь"; }
			}
		}
	case 9,16,20:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Ген.Директор"; }
			case 9: { rangz = "Програмный директор"; }
			case 8: { rangz = "Тех.Директор"; }
			case 7: { rangz = "Гл.Редактор"; }
			case 6: { rangz = "Редактор"; }
			case 5: { rangz = "Ведущий"; }
			case 4: { rangz = "Репортер"; }
			case 3: { rangz = "Звукорижессер"; }
			case 2: { rangz = "Звукооператор"; }
			case 1: { rangz = "Стажер"; }
			}
		}
	case 11:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Управляющий"; }
			case 9: { rangz = "Директор"; }
			case 8: { rangz = "Ст.Менеджер "; }
			case 7: { rangz = "Мл.Менеджер"; }
			case 6: { rangz = "Кординатор"; }
			case 5: { rangz = "Инструктор"; }
			case 4: { rangz = "Мл.Инструктор"; }
			case 3: { rangz = "Экзаменатор"; }
			case 2: { rangz = "Консультант"; }
			case 1: { rangz = "Стажёр"; }
			}
		}
	case 12:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Биг Вилли"; }
			case 9: { rangz = "Райч Нига"; }
			case 8: { rangz = "Фолкс"; }
			case 7: { rangz = "Федерал Блок"; }
			case 6: { rangz = "Гангстер"; }
			case 5: { rangz = "Ап Бро"; }
			case 4: { rangz = "Гун брo"; }
			case 3: { rangz = "Крэкер"; }
			case 2: { rangz = "Младший Нига"; }
			case 1: { rangz = "Блайд"; }
			}
		}
	case 26:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 9: { rangz = "Президент"; }
			case 8: { rangz = "Вице президент"; }
			case 7: { rangz = "Treasurer"; }
			case 6: { rangz = "Sergeant-at-arms"; }
			case 5: { rangz = "Road captain"; }
			case 4: { rangz = "Member"; }
			case 3: { rangz = "Prospect"; }
			case 2: { rangz = "Hang around"; }
			case 1: { rangz = "Support"; }
			}
		}
	case 24:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 9: { rangz = "Президент"; }
			case 8: { rangz = "Вице президент"; }
			case 7: { rangz = "Treasurer"; }
			case 6: { rangz = "Sergeant-at-arms"; }
			case 5: { rangz = "Road captain"; }
			case 4: { rangz = "Member"; }
			case 3: { rangz = "Prospect"; }
			case 2: { rangz = "Hang around"; }
			case 1: { rangz = "Support"; }
			}
		}
	case 29:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 9: { rangz = "Президент"; }
			case 8: { rangz = "Вице президент"; }
			case 7: { rangz = "Treasurer"; }
			case 6: { rangz = "Sergeant-at-arms"; }
			case 5: { rangz = "Road captain"; }
			case 4: { rangz = "Member"; }
			case 3: { rangz = "Prospect"; }
			case 2: { rangz = "Hang around"; }
			case 1: { rangz = "Support"; }
			}
		}
	case 13:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Падре"; }
			case 9: { rangz = "Падрино"; }
			case 8: { rangz = "Лидер V.E.G."; }
			case 7: { rangz = "Ассесино"; }
			case 6: { rangz = "V.E.G."; }
			case 5: { rangz = "Бандито"; }
			case 4: { rangz = "Верификадо"; }
			case 3: { rangz = "Локал"; }
			case 2: { rangz = "Ординарио"; }
			case 1: { rangz = "Новатто"; }
			}
		}
	case 14:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Авторитет"; }
			case 9: { rangz = "Вор в законе"; }
			case 8: { rangz = "Вор"; }
			case 7: { rangz = "Браток"; }
			case 6: { rangz = "Свояк"; }
			case 5: { rangz = "Блатной"; }
			case 4: { rangz = "Барыга"; }
			case 3: { rangz = "Бык"; }
			case 2: { rangz = "Фраер"; }
			case 1: { rangz = "Шнырь"; }
			}
		}
	case 15:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Мэд Дог"; }
			case 9: { rangz = "Легенд"; }
			case 8: { rangz = "Де Кинг"; }
			case 7: { rangz = "Мобста"; }
			case 6: { rangz = "О.Г."; }
			case 5: { rangz = "Гангста"; }
			case 4: { rangz = "Юонг"; }
			case 3: { rangz = "Килла"; }
			case 2: { rangz = "Хастла"; }
			case 1: { rangz = "Плэйя"; }
			}
		}
	case 17:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Падре"; }
			case 9: { rangz = "Нестро"; }
			case 8: { rangz = "Тесосеро"; }
			case 7: { rangz = "Инвасор"; }
			case 6: { rangz = "Сабио"; }
			case 5: { rangz = "Мирандо"; }
			case 4: { rangz = "Лас Геррас"; }
			case 3: { rangz = "Геттор"; }
			case 2: { rangz = "Тирадор"; }
			case 1: { rangz = "Перро"; }
			}
		}
	case 18:
		{
			switch(PTEMP[targetid][pRank])
			{
			case 10: { rangz = "Падре"; }
			case 9: { rangz = "Аджунто"; }
			case 8: { rangz = "Ауторидад"; }
			case 7: { rangz = "Бандидо"; }
			case 6: { rangz = "Эрмано"; }
			case 5: { rangz = "Джуниор"; }
			case 4: { rangz = "Мачo"; }
			case 3: { rangz = "Амиго"; }
			case 2: { rangz = "Ладрон"; }
			case 1: { rangz = "Новато"; }
			}
		}
	default: rangz = "Нет";
	}
	return rangz;
}
UpdateBizz(x)
{
	if(BizzInfo[x][bType] != 4)
	{
		if(strcmp(BizzInfo[x][bOwner],"None",true) == 0) format(string, 90, "%s\nПродаётся", BizzInfo[x][bMessage], BizzInfo[x][bBuyPrice]), BizzInfo[x][bLocked] = 1;
		else format(string,128, "%s\nВладелец:\n%s", BizzInfo[x][bMessage], BizzInfo[x][bOwner]);
	}
	else
	{
		if(strcmp(BizzInfo[x][bOwner],"None",true) == 0) format(string, 90, "%s\nПродаётся", BizzInfo[x][bMessage],BizzInfo[x][bBuyPrice]), BizzInfo[x][bLocked] = 1;
		else format(string,128, "%s\nВладелец:\n%s\nЦена бензина: %i вирт", BizzInfo[x][bMessage], BizzInfo[x][bOwner],BizzInfo[x][bPrice]);
	}
	UpdateDynamic3DTextLabelText(BizzInfo[x][bLabel], COLOR_GREEN, string);
	return true;
}
GetPaintball()
{
	new null[3];
	paint_info[0]--;
	if(paint_info[1] == 1 && paint_info[0] == 120) SendClientMessageToAll(0xffaaffff," Внимание! Начало пейнтбола через 2 минуты. Место проведения: военный завод K.A.C.C.");
	if(paint_info[1] == 1 && paint_info[0] == 1)
	{
		foreach(i) if(GetPVarInt(i,"player_paint")) null[2]++;
		if(null[2] > 2)
		{
			Painlist = 0;
			SendClientMessageToAll(0xffaaffff," Внимание! Пейнтболл начался");
			paint_info[1] = 2; paint_info[0] = 300;
			foreach(x) if(GetPVarInt(x, "player_paint") == 1) SetPVarInt(x, "player_paint", 2), SpawnPlayer(x);
		}
		else SendClientMessageToAll(0xffaaffff," Внимание! Пейнтбол был прерван из-за отсутствия участников"), paint_info[1] = 0, paint_info[0] = 0;
	}
	else if(paint_info[1] == 2 && paint_info[0] == 1)
	{
		SendClientMessageToAll(0xffaaffff," Внимание! Пейнтбол окончен. (( Список победителей: /painlist ))");
		paint_info[1] = 0; paint_info[0] = 0, null[2] = 0;
		foreach(x)
		{
			if(GetPVarInt(x, "player_paint") == 2)
			{
				PaintStats[Painlist][paKills] = GetPVarInt(x,"paintkills");
				PaintStats[Painlist][paDeaths] = GetPVarInt(x,"paintdeaths");
				strmid(PaintStats[Painlist][paName],Name(x), 0, strlen(Name(x)), 32);
				Painlist++;
				if(GetPVarInt(x,"paintkills") > null[0]) null[0] = GetPVarInt(x,"paintkills"); null[1] = x;
				DelGun(x);
				SetPlayerPos(x, 286.1364,-30.7176,1001.5156);
				SetPlayerFacingAngle(x, 181.0381);
				SetPlayerVirtualWorld(x, 1);
				SetPlayerInterior(x, 1);
			}
			DeletePVar(x,"player_paint");
		}
		if(null[1] != -1)
		{
			switch(booston == 0)
			{
			case 0:
				{
					PTEMP[null[1]][pCash]+=5000;
					GameTextForPlayer(null[1],"~g~+$5000", 5000, 1);
					SCM(null[1], TEAM_AZTECAS_COLOR, " Поздравляем вы заняли 1-е место.");
				}
			case 1:
				{
					PTEMP[null[1]][pCash]+=15000;
					GameTextForPlayer(null[1],"~g~+$15000", 5000, 1);
					SCM(null[1], TEAM_AZTECAS_COLOR, " Поздравляем вы заняли 1-е место.");
				}
			}
		}
	}
	return true;
}
GetRace()
{
	if(race_info[0] > 0)
	{
		race_info[0]--;
		if(race_info[1] == 1 && race_info[0] == 120) SendClientMessageToAll(0xB9B900AA," Внимание! Начало гонок через 2 минуты. Трасса: Аэропорт Лос Сантос. Регистрация у въезда");
		if(race_info[1] == 1 && race_info[0] == 1)
		{
			new null;
			foreach(i) if(GetPVarInt(i,"gonka")) null++;
			if(null >= 3)
			{
				SendClientMessageToAll(0xB9B900AA," Внимание! Гонки начались. Трасса: Аэропорт Лос Сантос");
				race_info[1] = 2; race_info[0] = 10;
				new rand = random(sizeof(RaceCar));
				foreach(x)
				{
					if(GetPVarInt(x, "gonka") == 1)
					{
						RaceInfo[RaceList][rCar] = CreateVehicle(RaceCar[rand], RaceSpawns[RaceList][0], RaceSpawns[RaceList][1], RaceSpawns[RaceList][2], RaceSpawns[RaceList][3], random(128), random(128),7200);
						CarHealth[RaceInfo[RaceList][rCar]] = float(1000);
						Fuell[RaceInfo[RaceList][rCar]] = float(100);
						GetVehicleParamsEx(RaceInfo[RaceList][rCar],engine,lights,alarm,doors,bonnet,boot,objective);
						SetVehicleParamsEx(RaceInfo[RaceList][rCar],1,1,alarm,0,bonnet,boot,objective);
						t_SetPlayerPos(x,RaceSpawns[RaceList][0], RaceSpawns[RaceList][1], RaceSpawns[RaceList][2]);
						PutPlayerInVehicleEx(x, RaceInfo[RaceList][rCar], 0);
						SetPlayerInterior(x, 0);
						SetPlayerVirtualWorld(x, 0);
						RaceList++;
						TogglePlayerControllableEx(x, false);
						SetPVarInt(x, "gonka", RaceList);
					}
				}
				RaceList = 0;
			}
			else
			{
				SendClientMessageToAll(0xB9B900AA," Гонка отменена из - за не достаточного количества участников");
				race_info[1] = 0; race_info[0] = 0;
				foreach(x) DeletePVar(x,"gonka");
			}
		}
		if(race_info[1] == 2 && race_info[0] <= 5) foreach(x) if(GetPVarInt(x, "gonka") > 0) format(string,64,"~g~RACE STARTED~n~~w~%i",race_info[0]), GameTextForPlayer(x,string, 5000, 4);
		if(race_info[1] == 2 && race_info[0] == 1)
		{
			race_info[1] = 3, race_info[0] = 300;
			foreach(x)
			{
				GameTextForPlayer(x,"~g~GO GO GO", 2000, 4);
				TogglePlayerControllableEx(x, true);
				SetPVarInt(x,"gonkaid",0);
				SetPlayerRaceCheckpoint(x, 0, RaceGonka[GetPVarInt(x,"gonkaid")][0],RaceGonka[GetPVarInt(x,"gonkaid")][1],RaceGonka[GetPVarInt(x,"gonkaid")][2],RaceGonka[GetPVarInt(x,"gonkaid")+1][0],RaceGonka[GetPVarInt(x,"gonkaid")+1][1],RaceGonka[GetPVarInt(x,"gonkaid")+1][2], 8.0);
			}
		}
		if(race_info[1] == 3 && race_info[0] == 120) foreach(x) if(GetPVarInt(x,"gonka") > 0) GameTextForPlayer(x,"~g~RACE ENDED TO 2 MIN", 3000, 4);
		if(race_info[1] == 3 && race_info[0] == 1)
		{
			SendClientMessageToAll(0xB9B900AA," Внимание! Гонки окончены. (( Список победителей: /racelist ))");
			race_info[0] = 0, race_info[1] = 0;
			foreach(x)
			{
				if(GetPVarInt(x, "gonka") > 0)
				{
					SetPlayerInterior(x,3);
					SetPlayerPos(x,831.7769,6.8750,1004.1797);
					SetPlayerFacingAngle(x,108.1610);
					DestroyVehicle(RaceInfo[GetPVarInt(x,"gonka")-1][rCar]);
					DeletePVar(x,"gonka");
				}
			}
		}
	}
}
UpdateTable(table[], set[], set_, where[], where_)
{
	mysql_format(DATABASE,QUERY,300,"UPDATE `%s` SET %s = %i WHERE %s = %i",table,set,set_,where,where_);
	return mysql_function_query(DATABASE,QUERY,false,"","");
}
Now()
{
	new hour,minute,second;
	new year, month,day;
	gettime(hour, minute, second);
	getdate(year, month, day);
	return mktimes(hour,minute,second,day,month,year);
}
#include "..\gamemodes\custom\OnCheckTrigger.pwn"
publics:RobTickRTSC(playerid, tip ,member, Robsid, act)
{
	if(RobTickRTC[playerid] != -1)
	{
        RobTickRTC[playerid]--;
        if(RobTickRTC[playerid] == -1)
        {
		    if(robscdtimer[playerid] != -1)
		    {
			    KillTimer(robscdtimer[playerid]);
			    robscdtimer[playerid] = -1;
			    RobTickRTC[playerid] = 0;
		    }
		    PlayerTextDrawHide(playerid,robsdraw[playerid]);
            RobSuccessFilly(playerid, tip ,member, Robsid, act);
        }
        else
        {
            PlayerTextDrawShow(playerid,robsdraw[playerid]);
            ApplyActorAnimation(act, "INT_HOUSE", "wash_up",4.1,0,0,0,1,0);
			switch(RobTickRTC[playerid])
			{
                case 29: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIIIIIIIIIIII~w~I~b~]");
                case 28: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIIIIIIIIIII~w~II~b~]");
                case 27: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIIIIIIIIII~w~III~b~]");
                case 26: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIIIIIIIII~w~IIII~b~]");
                case 25: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIIIIIIII~w~IIIII~b~]");
                case 24: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIIIIIII~w~IIIIII~b~]");
                case 23: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIIIIII~w~IIIIIII~b~]");
                case 22: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIIIII~w~IIIIIIII~b~]");
                case 21: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIIII~w~IIIIIIIII~b~]");
                case 20: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIIII~w~IIIIIIIIII~b~]");
                case 19: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIIII~w~IIIIIIIIIII~b~]");
                case 18: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIIII~w~IIIIIIIIIIII~b~]");
                case 17: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIIII~w~IIIIIIIIIIIII~b~]");
                case 16: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIIII~w~IIIIIIIIIIIIII~b~]");
                case 15: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIIII~w~IIIIIIIIIIIIIII~b~]");
                case 14: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIIII~w~IIIIIIIIIIIIIIII~b~]");
                case 13: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIIII~w~IIIIIIIIIIIIIIIII~b~]");
                case 12: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIIII~w~IIIIIIIIIIIIIIIIII~b~]");
                case 11: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIIII~w~IIIIIIIIIIIIIIIIIII~b~]");
                case 10: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIIII~w~IIIIIIIIIIIIIIIIIIII~b~]");
                 case 9: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIIII~w~IIIIIIIIIIIIIIIIIIIII~b~]");
                 case 8: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIIII~w~IIIIIIIIIIIIIIIIIIIIII~b~]");
                 case 7: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIIII~w~IIIIIIIIIIIIIIIIIIIIIII~b~]");
                 case 6: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIIII~w~IIIIIIIIIIIIIIIIIIIIIIII~b~]");
                 case 5: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIIII~w~IIIIIIIIIIIIIIIIIIIIIIIII~b~]");
                 case 4: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[IIII~w~IIIIIIIIIIIIIIIIIIIIIIIIII~b~]");
                 case 3: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[III~w~IIIIIIIIIIIIIIIIIIIIIIIIIII~b~]");
                 case 2: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[II~w~IIIIIIIIIIIIIIIIIIIIIIIIIIII~b~]");
                 case 1: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[I~w~IIIIIIIIIIIIIIIIIIIIIIIIIIIII~b~]");
                 case 0: PlayerTextDrawSetString(playerid,robsdraw[playerid], "~b~[~w~IIIIIIIIIIIIIIIIIIIIIIIIIIIIII~b~]");
            }
        }
    }
    return 0;
}
RobSuccessFilly(pids, tip ,member, robin, act)
{
    ClearActorAnimations(ActorsRob[act]);
	if(tip == 0)
	{
		new maxform;
		foreach(i)
		{
			if(maxform >= 4) break;
		    else if(PlayerToPoint(30,i,204.8515,-8.1603,1001.2109) && PTEMP[i][pMember] == member && RobInts[i] == robin)
		    {
	            if(PTEMP[i][pSex] == 2) SetPlayerSkin(i, 191);
	            else SetPlayerSkin(i, 287);
	            proverkaforma[i] = 1;
	            maxform++;
			}
		}
	}
	else if(tip == 1)
	{
		if(PTEMP[pids][pMember] == 5)
		{
			lcnmats += 2500;
			if(lcnmats > 100000) lcnmats = 100000;
		}
		else if(PTEMP[pids][pMember] == 6)
		{
			yakuzamats += 2500;
			if(yakuzamats > 100000) yakuzamats = 100000;
		}
		else if(PTEMP[pids][pMember] == 14)
		{
			rmmats += 2500;
			if(rmmats > 100000) rmmats = 100000;
		}
		SendClientMessage(pids, -1, " На склад вашей мафии добавлено 2500 материалов");
	}
	else if(tip == 2)
	{
	    foreach(i)
		{
		    if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && PTEMP[i][pMember] == member && RobInts[i] == robin)
		    {
				PTEMP[i][pDrugs] = 150;
				SCM(i, 0x6495EDFF, " Вы получили 150 грам наркотиков");
			}
		}
	}
	return 0;
}
publics:RobsEnabledCD(ids)
{
    if(cdrob[ids] != true) return 0;
    cdrob[ids] = false;
    return 0;
}
wantedsrobfriend(fraks, reason, introb)
{
	foreach(i)
	{
		if(reason == 0)
		{
			if(PlayerToPoint(30,i,204.8515,-8.1603,1001.2109) && PTEMP[i][pMember] == fraks && RobInts[i] == introb)
			{
    			if(PTEMP[i][pWantedLevel] > 3) PTEMP[i][pWantedLevel] += 1;
    			else PTEMP[i][pWantedLevel] += 3;
				SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel]);
				SetPlayerCriminal(i,"Неизвестный", "Ограбление Victim LS");
			}
		}
		else if(reason == 1)
		{
			if(PlayerToPoint(30,i,204.8515,-8.1603,1001.2109) && PTEMP[i][pMember] == fraks && RobInts[i] == introb)
			{
    			if(PTEMP[i][pWantedLevel] > 3) PTEMP[i][pWantedLevel] += 1;
    			else PTEMP[i][pWantedLevel] += 3;
				SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel]);
				SetPlayerCriminal(i,"Неизвестный", "Ограбление Victim SF");
			}
		}
		else if(reason == 2)
		{
			if(PlayerToPoint(30,i,316.1089,-133.7254,999.6016) && PTEMP[i][pMember] == fraks && RobInts[i] == introb)
			{
    			if(PTEMP[i][pWantedLevel] > 3) PTEMP[i][pWantedLevel] += 1;
    			else PTEMP[i][pWantedLevel] += 3;
				SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel]);
				SetPlayerCriminal(i,"Неизвестный", "Ограбление Ammo LV");
			}
		}
		else if(reason == 3)
		{
			if(PlayerToPoint(30,i,295.4810,-40.2167,1001.5156) && PTEMP[i][pMember] == fraks && RobInts[i] == introb)
			{
    			if(PTEMP[i][pWantedLevel] > 3) PTEMP[i][pWantedLevel] += 1;
    			else PTEMP[i][pWantedLevel] += 3;
				SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel]);
				SetPlayerCriminal(i,"Неизвестный", "Ограбление Ammo SF");
			}
		}
		else if(reason == 5)
		{
			if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && PTEMP[i][pMember] == fraks && RobInts[i] == introb)
			{
    			if(PTEMP[i][pWantedLevel] > 3) PTEMP[i][pWantedLevel] += 1;
    			else PTEMP[i][pWantedLevel] += 3;
				SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel]);
				SetPlayerCriminal(i,"Неизвестный", "Ограбление больницы [SFMC]");
			}
		}
		else if(reason == 6)
		{
			if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && PTEMP[i][pMember] == fraks && RobInts[i] == introb)
			{
    			if(PTEMP[i][pWantedLevel] > 3) PTEMP[i][pWantedLevel] += 1;
    			else PTEMP[i][pWantedLevel] += 3;
				SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel]);
				SetPlayerCriminal(i,"Неизвестный", "Ограбление больницы [ASGH]");
			}
		}
		else if(reason == 7)
		{
			if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && PTEMP[i][pMember] == fraks && RobInts[i] == introb)
			{
    			if(PTEMP[i][pWantedLevel] > 3) PTEMP[i][pWantedLevel] += 1;
    			else PTEMP[i][pWantedLevel] += 3;
				SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel]);
				SetPlayerCriminal(i,"Неизвестный", "Ограбление больницы [LVMC]");
			}
		}
		else if(reason == 8)
		{
			if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && PTEMP[i][pMember] == fraks && RobInts[i] == introb)
			{
    			if(PTEMP[i][pWantedLevel] > 3) PTEMP[i][pWantedLevel] += 1;
    			else PTEMP[i][pWantedLevel] += 3;
				SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel]);
				SetPlayerCriminal(i,"Неизвестный", "Ограбление больницы [FCMC]");
			}
		}
		else if(reason == 9)
		{
			if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && PTEMP[i][pMember] == fraks && RobInts[i] == introb)
			{
    			if(PTEMP[i][pWantedLevel] > 3) PTEMP[i][pWantedLevel] += 1;
    			else PTEMP[i][pWantedLevel] += 3;
				SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel]);
				SetPlayerCriminal(i,"Неизвестный", "Ограбление больницы [CGH]");
			}
		}
	}
	return 0;
}
publics:RobbingTimer()
{
	for(new ac = 0; ac < 9; ac++) SetActorHealth(ActorsRob[ac], 255);
    new pl[10][8];
	foreach(i)
	{
		if(GetPlayerInterior(i) == 5)
		{
			if(PlayerToPoint(30,i,204.8515,-8.1603,1001.2109) && RobInts[i] == 3)// Victim SF
			{
           	 	if(cdrob[1] == false)
                {
            		switch(PTEMP[i][pMember])
            		{
						case 12: pl[1][0]++;
						case 13: pl[1][1]++;
						case 15: pl[1][2]++;
						case 17: pl[1][3]++;
						case 18: pl[1][4]++;
						default: continue;
            		}
		    		new PTA = GetPlayerCameraTargetActor(i),
						keys,
						updown,
						leftright;
                	GetPlayerKeys(i, keys, updown, leftright);
    	    		if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    		{
						if(PTA != ActorsRob[4]) continue;
                		new PW = GetPlayerWeapon(i);
                		if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                		{
							if(pl[1][0] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
							else if(pl[1][1] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
							else if(pl[1][2] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
							else if(pl[1][3] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
							else if(pl[1][4] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
                        	else
                        	{
                        		SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        	}
                		}
            		}
            	}
            	continue;
			}
			else if(PlayerToPoint(30,i,204.8515,-8.1603,1001.2109) && RobInts[i] == 4) // Victim LS
			{
                if(cdrob[0] == false)
                {
            		switch(PTEMP[i][pMember])
            		{
						case 12: pl[0][0]++;
						case 13: pl[0][1]++;
						case 15: pl[0][2]++;
						case 17: pl[0][3]++;
						case 18: pl[0][4]++;
						default: continue;
            		}
		    		new PTA = GetPlayerCameraTargetActor(i),
		    		    keys,
						updown,
						leftright;
                	GetPlayerKeys(i, keys, updown, leftright);
    	    		if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    		{
                        if(PTA != ActorsRob[3]) continue;
                		new PW = GetPlayerWeapon(i);
                		if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                		{
							if(pl[0][0] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
							else if(pl[0][1] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
							else if(pl[0][2] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
							else if(pl[0][3] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
							else if(pl[0][4] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
                        	else
                        	{
                        		SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        	}
                		}
            		}
            	}
            	continue;
			}
		}
		else if(PlayerToPoint(30,i,316.1089,-133.7254,999.6016) && RobInts[i] == 0)
		{
            if(cdrob[2] == false)
            {
            	switch(PTEMP[i][pMember])
            	{
					case 5: pl[2][5]++;
					case 6: pl[2][6]++;
					case 14: pl[2][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i),
		    		keys,
					updown,
					leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if(PTA != ActorsRob[2]) continue;
                	new PW = GetPlayerWeapon(i);
                	if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if(pl[2][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[2] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",2);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 0, ActorsRob[2]);
                            wantedsrobfriend(PTEMP[i][pMember], 2, 0);
                        }
						else if(pl[2][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[2] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",2);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 0, ActorsRob[2]);
                            wantedsrobfriend(PTEMP[i][pMember], 2, 0);
                        }
						else if(pl[2][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[2] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",2);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 0, ActorsRob[2]);
                            wantedsrobfriend(PTEMP[i][pMember], 2, 0);
                        }
                        else
                        {
                        	SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        }
                	}
            	}
            }
            continue;
		}
		else if(PlayerToPoint(30,i,295.4810,-40.2167,1001.5156) && RobInts[i] == 1)
		{
            if(cdrob[3] == false)
            {
            	switch(PTEMP[i][pMember])
            	{
					case 5: pl[3][5]++;
					case 6: pl[3][6]++;
					case 14: pl[3][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i),
		    		keys,
					updown,
					leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if(PTA != ActorsRob[1]) continue;
                	new PW = GetPlayerWeapon(i);
                    if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if(pl[3][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[3] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",3);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 1, ActorsRob[1]);
                            wantedsrobfriend(PTEMP[i][pMember], 3, 1);
                        }
						else if(pl[3][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[3] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",3);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 1, ActorsRob[1]);
                            wantedsrobfriend(PTEMP[i][pMember], 3, 1);
                        }
						else if(pl[3][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[3] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",3);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 1, ActorsRob[1]);
                            wantedsrobfriend(PTEMP[i][pMember], 3, 1);
                        }
                        else
                        {
                        	SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        }
                	}
            	}
            }
            continue;
		}
		else if(PlayerToPoint(30,i,296.8526,-82.5276,1001.5156) && RobInts[i] == 2)
		{
            if(cdrob[4] == false)
            {
            	switch(PTEMP[i][pMember])
            	{
					case 5: pl[4][5]++;
					case 6: pl[4][6]++;
					case 14: pl[4][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i),
		    		keys,
					updown,
					leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if(PTA != ActorsRob[0]) continue;
                	new PW = GetPlayerWeapon(i);
                	if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if(pl[4][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[4] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",4);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 2, ActorsRob[0]);
                            wantedsrobfriend(PTEMP[i][pMember], 4, 2);
                        }
						else if(pl[4][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[4] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",4);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 2, ActorsRob[0]);
                            wantedsrobfriend(PTEMP[i][pMember], 4, 2);
                        }
						else if(pl[4][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[4] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",4);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 2, ActorsRob[0]);
                            wantedsrobfriend(PTEMP[i][pMember], 4, 2);
                        }
                        else
                        {
                        	SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        }
                	}
            	}
            }
            continue;
		}
		else if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 5) // [Bikers] - Medic SF
		{
            if(cdrob[5] == false)
            {
            	switch(PTEMP[i][pMember])
            	{
					case 24: pl[5][5]++;
					case 26: pl[5][6]++;
					case 29: pl[5][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i),
		    		keys,
					updown,
					leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if(PTA != ActorsRob[5]) continue;
                	new PW = GetPlayerWeapon(i);
                	if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if(pl[5][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[5] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",5);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 5, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 5, 5);
                        }
						else if(pl[5][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[5] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",5);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 5, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 5, 5);
                        }
						else if(pl[5][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[5] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",5);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 5, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 5, 5);
                        }
                        else
                        {
                        	SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        }
                	}
            	}
            }
            continue;
		}
		else if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 6) // [Bikers] - Medic LS
		{
            if(cdrob[6] == false)
            {
            	switch(PTEMP[i][pMember])
            	{
					case 24: pl[6][5]++;
					case 26: pl[6][6]++;
					case 29: pl[6][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i),
		    		keys,
					updown,
					leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if(PTA != ActorsRob[6]) continue;
                	new PW = GetPlayerWeapon(i);
                	if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if(pl[6][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[6] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",6);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 6, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 6, 6);
                        }
						else if(pl[6][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[6] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",6);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 6, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 6, 6);
                        }
						else if(pl[6][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[6] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",6);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 6, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 6, 6);
                        }
                        else
                        {
                        	SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        }
                	}
            	}
            }
            continue;
		}
		else if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 7) // [Bikers] - Medic LV
		{
            if(cdrob[7] == false)
            {
            	switch(PTEMP[i][pMember])
            	{
					case 24: pl[7][5]++;
					case 26: pl[7][6]++;
					case 29: pl[7][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i),
		    		keys,
					updown,
					leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if(PTA != ActorsRob[7]) continue;
                	new PW = GetPlayerWeapon(i);
                	if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if(pl[7][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[7] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",7);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 7, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 7, 7);
                        }
						else if(pl[7][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[7] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",7);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 7, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 7, 7);
                        }
						else if(pl[7][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[7] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",7);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 7, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 7, 7);
                        }
                        else
                        {
                        	SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        }
                	}
            	}
            }
            continue;
		}
		else if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 8) // [Bikers] - Medic FC
		{
            if(cdrob[8] == false)
            {
            	switch(PTEMP[i][pMember])
            	{
					case 24: pl[8][5]++;
					case 26: pl[8][6]++;
					case 29: pl[8][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i),
		    		keys,
					updown,
					leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if(PTA != ActorsRob[8]) continue;
                	new PW = GetPlayerWeapon(i);
                	if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if(pl[8][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[8] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",8);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 8, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 8, 8);
                        }
						else if(pl[8][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[8] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",8);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 8, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 8, 8);
                        }
						else if(pl[8][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[8] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",8);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 8, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 8, 8);
                        }
                        else
                        {
                        	SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        }
                	}
            	}
            }
            continue;
		}
		else if(PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 9) // [Bikers] - Medic LS Ghetto
		{
            if(cdrob[9] == false)
            {
            	switch(PTEMP[i][pMember])
            	{
					case 24: pl[9][5]++;
					case 26: pl[9][6]++;
					case 29: pl[9][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i),
		    		keys,
					updown,
					leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if(PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if(PTA != ActorsRob[9]) continue;
                	new PW = GetPlayerWeapon(i);
                	if(PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if(pl[9][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[9] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",9);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 9, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 9, 9);
                        }
						else if(pl[9][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[9] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",9);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 9, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 9, 9);
                        }
						else if(pl[9][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[9] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",9);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 9, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 9, 9);
                        }
                        else
                        {
                        	SendClientMessage(i, COLOR_GREY, " Для начала ограбления нужно минимум 2 напарника");
                        }
                	}
            	}
            }
            continue;
		}
	}
}
LoadMySQLSettings()
{
	new FileID = ini_openFile("mysql_settings.ini"), errCode;
	if (FileID < 0)
	{
		printf("Error while opening MySQL settings file. Error code: %d", FileID);
		return 0;
	}
	errCode = ini_getString(FileID, "host", MySQLSettings[HOS7_HOST]);
	if (errCode < 0) printf("Error while reading MySQL settings file (host). Error code: %d", errCode);
	errCode = ini_getString(FileID, "username", MySQLSettings[HOS7_USERNAME]);
	if (errCode < 0) printf("Error while reading MySQL settings file (username). Error code: %d", errCode);
	errCode = ini_getString(FileID, "password", MySQLSettings[HOS7_PASSWORD]);
	if (errCode < 0) printf("Error while reading MySQL settings file (password). Error code: %d", errCode);
	errCode = ini_getString(FileID, "database", MySQLSettings[HOS7_DB]);
	if (errCode < 0) printf("Error while reading MySQL settings file (database). Error code: %d", errCode);
	ini_closeFile(FileID);
	return 1;
}
main(){}