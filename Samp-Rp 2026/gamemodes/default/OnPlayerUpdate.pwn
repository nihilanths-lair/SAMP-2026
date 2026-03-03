public OnPlayerUpdate(playerid)
{
	killed[playerid] = false;
	/*
    if(GetPlayerAnimationIndex(playerid))
	{
		new animlib[32],animname[32],string[128];
		GetAnimationName(GetPlayerAnimationIndex(playerid) ,animlib,sizeof(animlib),animname,sizeof(animname) );
		format(string,sizeof(string),"By Gameyer (C) | Библиоте: {EE5555}%s {FFFFFF}| Название Анимации: {EE5555}%s",animlib,animname);
		SCM(playerid,-1,string);
	}
    */
    AnimTheLost[playerid] = GetPlayerAnimationIndex(playerid);
	SetPVarInt(playerid,"AFK_Tick", GetPVarInt(playerid,"AFK_Tick") + 1);
	new Keys,ud,lr;
	GetPlayerKeys(playerid,Keys,ud,lr);
	if(LastReconClick[playerid][0] != ud) LastReconClick[playerid][0] = 0;
	if(LastReconClick[playerid][1] != lr) LastReconClick[playerid][1] = 0;
	if(Spectate[playerid] && lr == KEY_LEFT && !LastReconClick[playerid][1])
	{
		LastReconClick[playerid][1] = lr;
		PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
		SubTextDelete(playerid);
		DisableEnableReconButton(playerid, ReconSelect[playerid], 1);
		return 1;
	}
	if(Spectate[playerid] && lr == KEY_RIGHT && !LastReconClick[playerid][1])
	{
		LastReconClick[playerid][1] = lr;
		PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);

		if(ReconSelectSub[playerid] == INVALID_TEXT_DRAW) OnPlayerClickPlayerTextDraw(playerid, ReconPlayer[ReconSelect[playerid]]);
		else OnPlayerClickPlayerTextDraw(playerid, ReconPlayer[ReconSelectSub[playerid]]);
		return 1;
	}
	if(Spectate[playerid] && ud == KEY_UP && !LastReconClick[playerid][0])
	{
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		LastReconClick[playerid][0] = ud;
		if(ReconSelectSub[playerid] == INVALID_TEXT_DRAW)
		{
			DisableEnableReconButton(playerid, ReconSelect[playerid], 0);
			if(ReconSelect[playerid] <= 7)
			{
				ReconSelect[playerid] = 15;
				DisableEnableReconButton(playerid, ReconSelect[playerid], 1);
			}
			else
			{
				ReconSelect[playerid]--;
				DisableEnableReconButton(playerid, ReconSelect[playerid], 1);
			}
			return 1;
		}
		else
		{
			DisableEnableReconButton(playerid, ReconSelectSub[playerid], 0);
			if(ReconSelectSub[playerid] <= ReconBounds[playerid][0])
			{
				ReconSelectSub[playerid] = ReconBounds[playerid][1];
				DisableEnableReconButton(playerid, ReconSelectSub[playerid], 1);
			}
			else
			{
				ReconSelectSub[playerid]--;
				DisableEnableReconButton(playerid, ReconSelectSub[playerid], 1);
			}
		}
	}
	if(Spectate[playerid] && ud == KEY_DOWN && !LastReconClick[playerid][0])
	{
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		LastReconClick[playerid][0] = ud;
		if(ReconSelectSub[playerid] == INVALID_TEXT_DRAW)
		{
			DisableEnableReconButton(playerid, ReconSelect[playerid], 0);
			if(ReconSelect[playerid] >= 15)
			{
				ReconSelect[playerid] = 7;
				DisableEnableReconButton(playerid, ReconSelect[playerid], 1);
			}
			else
			{
				ReconSelect[playerid]++;
				DisableEnableReconButton(playerid, ReconSelect[playerid], 1);
			}
			return 1;
		}
		else
		{
			DisableEnableReconButton(playerid, ReconSelectSub[playerid], 0);
			if(ReconSelectSub[playerid] >= ReconBounds[playerid][1])
			{
				ReconSelectSub[playerid] = ReconBounds[playerid][0];
				DisableEnableReconButton(playerid, ReconSelectSub[playerid], 1);
			}
			else
			{
				ReconSelectSub[playerid]++;
				DisableEnableReconButton(playerid, ReconSelectSub[playerid], 1);
			}
		}
	}
	if(Spectate[playerid] && SpecAd[playerid] != INVALID_PLAYER_ID) return PlayerTextDrawShow(playerid, ReconPlayer[34]);
	return true;
}