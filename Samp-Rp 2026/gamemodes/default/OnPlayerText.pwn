public OnPlayerText(playerid, text[])
{
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	new ip[26];
	new giveplayer[MAX_PLAYER_NAME];
	GetPlayerIp(playerid,ip,sizeof(ip));
	if(IsIP(text) || CheckString(text))
	{
		if(PTEMP[playerid][pMuted] > 0)
		{
			format(YCMDstr, sizeof(YCMDstr), " У вас бан чата!");
			SCM(playerid, TEAM_CYAN_COLOR, YCMDstr);
			return true;
		}
		PTEMP[playerid][pMuted] = 10800;
		format(string, 156, "%s",text);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(string, 156, "                    Login: %s  [ID: %i]  IP: %s",sendername,playerid,ip);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(YCMDstr,sizeof(YCMDstr)," Вы получили Бан чата на 3 часа");
		SCM(playerid, COLOR_LIGHTRED, YCMDstr);
		format(YCMDstr,sizeof(YCMDstr)," Используйте ''/mm'' -> ''Администрация'' -> ''Обратная связь'', если бан был выдан по ошибке");
		SCM(playerid, COLOR_LIGHTRED, YCMDstr);
	//	SetPlayerChatBubble(playerid, "Заткнут(а)",COLOR_PURPLE,30.0,10000);
		return false;
	}
	if(TalkingLive[playerid] == 1)
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		format(string, 156, " < [Тел] SF News > %s: %s", sendername, text);
		OOCNews(COLOR_GREEN, string);
		Flood[playerid] = 1;
	}
	if(TalkingLivels[playerid] == 1)
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		format(string, 156, " < [Тел] LS News %s: %s", sendername, text);
		LSNews(0x0073B7AA, string);
		Flood[playerid] = 1;
	}
	if(TalkingLivelv[playerid] == 1)
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		format(string, 156, " < [Тел] LV News > %s: %s", sendername, text);
		LVNews(0xff9db6aa, string);
		Flood[playerid] = 1;
	}
	if(TalkingLive[playerid] == 2)
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		if(PTEMP[playerid][pMember] == 9)
		{
			format(string, 156, " < SF News > %s: %s", sendername, text);
			OOCNews(COLOR_GREEN, string);
			Flood[playerid] = 1;
			return false;
		}
		else
		{
			format(string, 156, " < SF News > %s: %s", sendername, text);
			OOCNews(COLOR_GREEN, string);
			Flood[playerid] = 1;
			return false;
		}
	}
	if(TalkingLivels[playerid] == 2)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		if(PTEMP[playerid][pMember] == 16)
		{
			format(string, 156, " < LS News > %s: %s", sendername, text);
			LSNews(0x0073B7AA, string);
			Flood[playerid] = 1;
			return false;
		}
		else
		{
			format(string, 156, " < LS News > %s: %s", sendername, text);
			LSNews(0x0073B7AA, string);
			Flood[playerid] = 1;
			return false;
		}
	}
	if(TalkingLivelv[playerid] == 2)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		if(PTEMP[playerid][pMember] == 20)
		{
			format(string, 156, " < LV News > %s: %s", sendername, text);
			LVNews(0xff9db6aa, string);
			return false;
		}
		else
		{
			format(string, 156, " < LV News > %s: %s", sendername, text);
			LVNews(0xff9db6aa, string);
			return false;
		}
	}
	if(Tel[playerid] == 1)
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		format(string, 156, " [Телефон] %s: %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		return false;
	}
	if(Mobile[playerid] != 999)
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		format(string, 156, " [Телефон] %s: %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		if(IsPlayerConnected(Mobile[playerid]) && Mobile[Mobile[playerid]] == playerid) SCM(Mobile[playerid], COLOR_YELLOW,string);
		return false;
	}
	if(PEfir[playerid] != 255)
	{
		if(PTEMP[playerid][pMember] == 9 || PTEMP[playerid][pLeader] == 9)
		{
			if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!");return false; }
			format(string, 156, " < SF News > %s: %s", sendername, text);
			OOCNews(COLOR_GREEN, string);
			Flood[playerid] = 1;
		}
		if(PTEMP[playerid][pMember] == 20 || PTEMP[playerid][pLeader] == 20)
		{
			if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
			format(string, 156, " < LV News > %s: %s", sendername, text);
			LVNews(0xff9db6aa, string);
			Flood[playerid] = 1;
		}
		if(PTEMP[playerid][pMember] == 16 || PTEMP[playerid][pLeader] == 16)
		{
			if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
			format(string, 156, " < LS News > %s: %s", sendername, text);
			LSNews(0x0073B7AA, string);
			Flood[playerid] = 1;
		}
		if(Pefir[playerid] == 1)
		{
			if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
			format(string, 156, " < SF News > %s: %s", sendername, text);
			OOCNews(COLOR_GREEN, string);
			Flood[playerid] = 1;
		}
		if(Pefir[playerid] == 2)
		{
			if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
			format(string, 156, " < LS News > %s: %s", sendername, text);
			LSNews(0x0073B7AA, string);
			Flood[playerid] = 1;
		}
		if(Pefir[playerid] == 3)
		{
			if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
			format(string, 156, " < LV News > %s: %s", sendername, text);
			LSNews(0xff9db6aa, string);
			Flood[playerid] = 1;
		}
		return false;
	}
	if(strcmp(text, "ку", true) == 0|| strcmp(text, "й", true) == 0 || strcmp(text, "q", true) == 0)
	{
		new suspect = GetClosestforeach(playerid);
		GetPlayerName(suspect, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(GetDistanceBetweenPlayers(playerid,suspect) < 2 && !IsPlayerInAnyVehicle(suspect) && !IsPlayerInAnyVehicle(playerid) && suspect != -1)
		{
			if(PTEMP[playerid][pMember] == PTEMP[suspect][pMember] && IsAGang(playerid))
			{
				//CallLocalFunction("OnPlayerCommandText", "isi", playerid, "/en", suspect);
			}
		}
		switch(PTEMP[playerid][pMember])
		{
		case 13:
			{
				format(string,156, "Показал(a) распальцовку Los Santos Vagos Gang");
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				format(string, 156, " %s показал(a) распальцовку Los Santos Vagos Gang", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ApplyAnimation(playerid, "GHANDS", "gsign1LH",4.1, 0, 1, 1, 1, 1);
				SetTimerEx("ClearAnim", 2000, false, "d", playerid);
				return false;
			}
		case 15:
			{
				format(string,156, "Показал(a) распальцовку Grove Street Gang");
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				format(string, 156, " %s показал(a) распальцовку Grove Street Gang", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ApplyAnimation(playerid, "GHANDS", "gsign1LH",4.1, 0, 1, 1, 1, 1);
				SetTimerEx("ClearAnim", 2000, false, "d", playerid);
				return false;
			}
		case 17:
			{
				format(string,156, "Показал(a) распальцовку Varios Los Aztecas Gang");
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				format(string, 156, " %s показал(a) распальцовку Varios Los Aztecas Gang", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ApplyAnimation(playerid, "GHANDS", "gsign1LH",4.1, 0, 1, 1, 1, 1);
				SetTimerEx("ClearAnim", 2000, false, "d", playerid);
				return false;
			}
		case 12:
			{
				format(string,156, "Показал(a) распальцовку The Ballas Gang");
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				format(string,156, " %s показал(a) распальцовку The Ballas Gang", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ApplyAnimation(playerid, "GHANDS", "gsign1LH",4.1, 0, 1, 1, 1, 1);
				SetTimerEx("ClearAnim", 2000, false, "d", playerid);
				return false;
			}
		case 18:
			{
				format(string,156, "Показал(a) распальцовку The Rifa Gang");
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				format(string,156, " %s показал(a) распальцовку The Rifa Gang", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ApplyAnimation(playerid, "GHANDS", "gsign1LH",4.1, 0, 1, 1, 1, 1);
				SetTimerEx("ClearAnim", 2000, false, "d", playerid);
				return false;
			}
		case 24:
			{
				format(string,156, "Показал(a) распальцовку Hell Angels MC");
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				format(string,156, " %s показал(a) распальцовку Hell's Angels MC", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ApplyAnimation(playerid, "GHANDS", "gsign1LH",4.1, 0, 1, 1, 1, 1);
				SetTimerEx("ClearAnim", 2000, false, "d", playerid);
				return false;
			}
		case 26:
			{
				format(string,156, "Показал(a) распальцовку Warlocks MC");
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				format(string,156, " %s показал(a) распальцовку Warlocks MC", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ApplyAnimation(playerid, "GHANDS", "gsign1LH",4.1, 0, 1, 1, 1, 1);
				SetTimerEx("ClearAnim", 2000, false, "d", playerid);
				return false;
			}
		case 29:
			{
				format(string,156, "Показал(a) распальцовку Pagans MC");
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				format(string,156, " %s показал(a) распальцовку Pagans MC", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ApplyAnimation(playerid, "GHANDS", "gsign1LH",4.1, 0, 1, 1, 1, 1);
				SetTimerEx("ClearAnim", 2000, false, "d", playerid);
				return false;
			}
		case 3,19:
			{
				if(!GetPVarInt(playerid,"Fraction_Duty")) return false;
				format(string,156, "Выполнил воинское приветствие");
				SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
				format(string,156, " %s выполнил воинское приветствие", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ApplyAnimation(playerid, "VENDING", "VEND_Drink_P",4.1, 0, 1, 1, 1, 1);
				SetTimerEx("ClearAnim", 1300, false, "d", playerid);
				return false;
			}
		}
	}
	else if(strcmp(text, "xD", true) == 0 || strcmp(text, "хД", true) == 0 || strcmp(text, "хД", true) == 0 || strcmp(text, "хД", true) == 0 )
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		format(string,90, " %s смеется", sendername);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SetPlayerChatBubble(playerid, "Смеется", COLOR_PURPLE, 30.0, 10000);
		return false;
	}
	else if(strcmp(text, "чВ", true) == 0 || strcmp(text, "хДД", true) == 0 || strcmp(text, "хДД", true) == 0 || strcmp(text, "xDD", true) == 0)
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		format(string,156, " %s валяется от смеха", sendername);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SetPlayerChatBubble(playerid, "Валяется от смеха",COLOR_PURPLE,30.0,10000);
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
		}
		return false;
	}
	else if(strcmp(text, ")", true) == 0 || strcmp(text, "))", true) == 0)
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		format(string,90, " %s улыбается", sendername);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SetPlayerChatBubble(playerid, "Улыбается",COLOR_PURPLE,30.0,10000);
		return false;
	}
	else if(strcmp(text, ":D", true) == 0)
	{
		if(PTEMP[playerid][pMuted] > 0) { SCM(playerid, TEAM_CYAN_COLOR, " У вас бан чата!"); return false; }
		format(string,156, " %s хохочет во весь голос", sendername);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SetPlayerChatBubble(playerid, "Хохочет во весь голос",COLOR_PURPLE,30.0,10000);
		return false;
	}
	if(GetPVarInt(playerid,"BoneStol"))
	{
		if(PTEMP[playerid][pLogin] == 0) return false;
		if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
		{
			SCM(playerid,0xFFD5BBAA, " Не флуди!");
			SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
			if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
			return false;
		}
		if(PTEMP[playerid][pMuted] > 0)
		{
			format(string,156, " У вас бан чата! До снятия: %i минут",PTEMP[playerid][pMuted]/60);
			SCM(playerid, TEAM_CYAN_COLOR, string);
			return false;
		}
		format(string,156,"- %s: %s",PTEMP[playerid][pName],text);
		foreach(i)
		{
			if(GetPVarInt(i,"BoneStol") == GetPVarInt(playerid,"BoneStol")) SCM(i,0xc175ffaa,string);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			if(PlayerCuffedTime[playerid] == 0) ApplyAnimation(playerid,"PED","IDLE_chat",4.1,0,1,1,1,1);
			if(PlayerCuffedTime[playerid] == 0) SetTimerEx("ClearAnim", 3600, 0, "d", playerid);
		}
		SetPlayerChatBubble(playerid, text, 0x6495EDFF, 20.0, 10000);
		Flood[playerid] = 1;
		SetPVarInt(playerid,"Flood",0);
		return false;
	}
	else if(realchat)
	{
		if(Flood[playerid] > 0 && PTEMP[playerid][pAdmin] <= 6)
		{
			SCM(playerid,0xFFD5BBAA, " Не флуди!");
			SetPVarInt(playerid,"Flood",GetPVarInt(playerid,"Flood")+1);
			if(GetPVarInt(playerid,"Flood") >= 4) kick(playerid);
			return false;
		}
		if(PTEMP[playerid][pLogin] == 0)
		{
			return false;
		}
		if(PTEMP[playerid][pMuted] > 0)
		{
			format(string,156, " У вас бан чата! До снятия: %i минут",PTEMP[playerid][pMuted]/60);
			SCM(playerid, TEAM_CYAN_COLOR, string);
			return false;
		}
		if(PTEMP[playerid][pLevel] <= 1)
		{
			new succ;
			for(new i; i<strlen(text); i++) if(PText[playerid][i] == text[i]) succ++;
			if(succ == strlen(text))
			{
				SCM(playerid,0xFFD5BBAA, " Не флуди!");
				return false;
			}
		}
		strmid(PText[playerid],text,0,256,256);
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			if(PlayerCuffedTime[playerid] == 0) ApplyAnimation(playerid,"PED","IDLE_chat",4.1,0,1,1,1,1);
			if(PlayerCuffedTime[playerid] == 0) SetTimerEx("ClearAnim", 3600, 0, "d", playerid);
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string,156, "- %s: %s", sendername, text);
		SetPlayerChatBubble(playerid, text, 0x6495EDFF, 20.0, 10000);
		ProxDetector(20.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		Flood[playerid] = 1;
		SetPVarInt(playerid,"Flood",0);
		return false;
	}
	return true;
}