ChosePlayerSkin(playerid)
{
	SetPlayerHealthAC(playerid, 100);

	SCM(playerid, 0xBC2C2CFF, " Используйте клавишу 'Быстрый бег' (пробел по умолчанию)");
	SCM(playerid, 0xBC2C2CFF, " Используйте клавишу 'Вверх, вниз' (W, S по умолчанию)");

	if (PTEMP[playerid][pSex] == 1 && PTEMP[playerid][pTut] == 0)
	{
		SetPlayerPos         (playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
		SetPlayerFacingAngle (playerid, gInviteSpawns[3]                                      );
		SetPlayerCameraPos   (playerid, gInviteSpawns[0]+3, gInviteSpawns[1], gInviteSpawns[2]);
		SetPlayerCameraLookAt(playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);

		PTEMP[playerid][pTut]     =   0;
		PTEMP[playerid][pChar][0] =  79;
		PTEMP[playerid][pModel]   = 255;
		PTEMP[playerid][pMember]  =   0;
		PTEMP[playerid][pLeader]  =   0;
		PTEMP[playerid][pRank]    =   1;

		SetPlayerInterior(playerid, 5);

		if (!IsValidMenu(bomj[0]))
		{
			bomj[0] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
			SetMenuColumnHeader(bomj[0], 0, "Choose Skin");
			AddMenuItem(bomj[0], 0, ">> Next");
			AddMenuItem(bomj[0], 0, "<< Previous");
			AddMenuItem(bomj[0], 0, "Save");
		}
		ShowMenuForPlayer(bomj[0], playerid);
		ChosenSkin[playerid] = 79;
		TutTime[playerid] = 0;
		TogglePlayerControllable(playerid, 0);
		SetPlayerSkin(playerid, PTEMP[playerid][pChar][0]);
		SelectChar[playerid] = 255;
		SelectCharPlace[playerid] = 1;
		PTEMP[playerid][pChar][0] = ChosenSkin[playerid];

		SetPlayerVirtualWorld(playerid, 2+random(100));
		SetPlayerPos         (playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
		SetPlayerFacingAngle (playerid, gInviteSpawns[3]                                      );
		SetPlayerCameraPos   (playerid, gInviteSpawns[0]+3, gInviteSpawns[1], gInviteSpawns[2]);
		SetPlayerCameraLookAt(playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
	}
	else if (PTEMP[playerid][pSex] == 2 && PTEMP[playerid][pTut] == 0)
	{
		SetPlayerPos         (playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
		SetPlayerFacingAngle (playerid, gInviteSpawns[3]                                      );
		SetPlayerCameraPos   (playerid, gInviteSpawns[0]+3, gInviteSpawns[1], gInviteSpawns[2]);
		SetPlayerCameraLookAt(playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);

		PTEMP[playerid][pSex]     =   2;
		PTEMP[playerid][pTut]     =   0;
		PTEMP[playerid][pChar][0] =  90;
		PTEMP[playerid][pModel]   = 255;
		PTEMP[playerid][pMember]  =   0;
		PTEMP[playerid][pLeader]  =   0;
		PTEMP[playerid][pRank]    =   1;
		ChosenSkin[playerid]      =  90;

		SetPlayerInterior(playerid, 5);

		if (!IsValidMenu(bomj[1]))
		{
			bomj[1] = CreateMenu("Victim", 1, 50.0, 160.0, 110.0);
			SetMenuColumnHeader(bomj[1], 0, "Choose Skin");
			AddMenuItem(bomj[1], 0, ">> Next>");
			AddMenuItem(bomj[1], 0, "<< Previous");
			AddMenuItem(bomj[1], 0, "Save");
		}
		ShowMenuForPlayer(bomj[1], playerid);
		TutTime[playerid] = 0;
		TogglePlayerControllable(playerid, 0);
		SetPlayerSkin(playerid, PTEMP[playerid][pChar][0]);
		SelectChar[playerid]      = 255;
		SelectCharPlace[playerid] =   1;
		PTEMP[playerid][pChar][0] = ChosenSkin[playerid];
		SetPlayerVirtualWorld(playerid, 2+random(100));
		SetPlayerPos         (playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
		SetPlayerFacingAngle (playerid, gInviteSpawns[3]                                      );
		SetPlayerCameraPos   (playerid, gInviteSpawns[0]+3, gInviteSpawns[1], gInviteSpawns[2]);
		SetPlayerCameraLookAt(playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
	}
	return true;
}