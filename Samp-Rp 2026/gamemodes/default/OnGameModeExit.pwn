public OnGameModeExit()
{
	SaveMySQL(0);
	for (new i = 1; i <= TOTALCASINO; i++) SaveMySQL(1,i);
	foreach(i) Kick(i);
	for (new i = 1; i <= TOTALSHOPS; i++) SaveMySQL(3,i);
	for (new i = 1; i <= TotalBizz; i++) SaveMySQL(4,i);
	for (new i = 1; i <= TotalHouse; i++) SaveMySQL(5,i);
	for (new i = 1; i <= ALLKVARTIRI; i++) SaveMySQL(6,i);
	for (new i = 1; i <= AllPODEZD; i++) SaveMySQL(7,i);
	for (new i = 1; i <= TOTALATM; i++) SaveMySQL(8,i);
	for (new i = 0; i <= TOTALFARM; i++) SaveMySQL(9,i);
	ClearReconnect();
	
	KillTimer(Hptimer);
	KillTimer(freshtimer);
	KillTimer(reklamatimer);
	GameModeExit();
	//mysql_close(connectionHandle);
	return true;
}