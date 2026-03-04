public OnPlayerSpawn(playerid)
{
    if(robscdtimer[playerid] != -1)
	{
		KillTimer(robscdtimer[playerid]);
		robscdtimer[playerid] = -1;
	}
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 1000, playerid);
	RobInts[playerid] = -1;
	RobTickRTC[playerid] = 0;
	if(SERVERTEST) SendMes(playerid,COLOR_BLUE,"SPAWN: SPAWN - %i",playerid);
	if(PTEMP[playerid][pLogin] == 0 && GetPVarInt(playerid,"Register") == 0) return SCM(playerid, -1, " Необходимо авторизоваться!");
	new GotPVar = GetPVarInt(playerid, "TempConvoi");
    if(Convoi[playerid] != 9999)
    {
        SetPVarInt(Convoi[playerid], "TempConvoi", -1);
        KillTimer(TimerForPlayer[playerid]);
        TimerForPlayer[playerid] = INVALID_PLAYER_ID;
        Convoi[playerid] = 9999;
    }
    else if(GotPVar != -1)
    {
        SetPVarInt(playerid, "TempConvoi", -1);
        KillTimer(TimerForPlayer[GotPVar]);
        TimerForPlayer[GotPVar] = INVALID_PLAYER_ID;
        Convoi[GotPVar] = 9999;
    }
	DeletePVar(playerid,"CasinoRank");
	ResetPlayerWeapons(playerid);
	SetPVarInt(playerid,"K_Times",0);
	SetPVarInt(playerid, "AntiBreik", 2);
	SetPVarInt(playerid, "GunCheckTime", 2);
	PTEMP[playerid][pHP] = 100;
	SetPlayerHealthAC(playerid, 100.0);
	if(PTEMP[playerid][pSex] > 0 && PTEMP[playerid][pTut] == 0) return ChosePlayerSkin(playerid);
	TogglePlayerControllableEx(playerid, 0);
	SetTimerEx("_UnFreeze" , 400, false, "i", playerid);
	switch(PTEMP[playerid][pMember]) { case 5,6,14,13,12,15,17,18,24,26,29: SetPVarInt(playerid,"Fraction_Duty",1); }
	if(PTEMP[playerid][pMember] > 0 && GetPVarInt(playerid, "Fraction_Duty")) SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
	else SetPlayerSkin(playerid, PTEMP[playerid][pChar][0]);
	if(PTEMP[playerid][pMember] <= 0) SetPlayerSkin(playerid, PTEMP[playerid][pChar][0]);
	SetPlayerSkills(playerid);
	for(new idx = 0; idx < 10; idx++)
	{
		GiveWeapon(playerid, PTEMP[playerid][pWeapon][idx], PTEMP[playerid][pAmmo][idx]);
		vidachagun[idx][playerid] = 1;
	}
	if(Spectate[playerid])
	{
		Spectate[playerid] = 0;
		SetPlayerPos(playerid,SpecPlayer[playerid][0],SpecPlayer[playerid][1],SpecPlayer[playerid][2]);
		SetPlayerInterior(playerid,SpecPlayerInt[playerid]);
		SetPlayerVirtualWorld(playerid,SpecPlayerWorld[playerid]);
		SetPlayerFacingAngle(playerid, SpecPlayerAngle[playerid]);
		PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		SetPlayerHealth(playerid, 255.0);
		for(new i; i < 35; i++) PlayerTextDrawHide(playerid, ReconPlayer[i]);
		for(new idx = 0; idx < 10; idx++)
		{
			if(PTEMP[playerid][pWeapon][idx] && !vidachagun[idx][playerid])
			{
				GiveWeapon(playerid, PTEMP[playerid][pWeapon][idx], PTEMP[playerid][pAmmo][idx]);
				vidachagun[idx][playerid] = 1;
			}
		}
		return 1;
	}
	for(new i = 0; i < 5; i++)
	{
		if(spys[i][0] == playerid)
		{
			spys[i][0] = -1;
			spys[i][1] = -1;
			SCM(playerid, -1, " Вы потеряли маскировку");
		}
	}
	if(tipster == playerid) tipster = -1;
	SetPlayerSpawn(playerid);
	PreloadAllAnimLibs(playerid);
	
	dinamicashs[playerid] = CreateDynamicCP(-2026.6854,-114.3436,1035.1719,1.5, 1, 3, playerid,5.0);
	return true;
}