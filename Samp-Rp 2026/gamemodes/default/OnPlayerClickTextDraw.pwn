public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	//AutoSalon
	if(Spectate[playerid] && PTEMP[playerid][pAdmin] > 1)
	{
		if(clickedid == Text:INVALID_TEXT_DRAW)
		DisableEnableReconButton(playerid, ReconSelect[playerid], 1);
		return 1;
	}
	if(GetPVarInt(playerid, "SelectAvto") != -1)
	{
		if(clickedid == AutoShopText[0]) return BackCar(playerid);
		else if(clickedid == AutoShopText[1]) return NextCar(playerid);
		else if(clickedid == AutoShopText[2]) return NextColor(playerid,0);
		else if(clickedid == AutoShopText[3]) return NextColor(playerid,1);
		else if(clickedid == AutoShopText[4]) return BackColor(playerid,1);
		else if(clickedid == AutoShopText[5]) return BackColor(playerid,0);
		else if(clickedid == AutoShopText[6])
		{
		    if(GetPVarInt(playerid, "chosencar") == -1) SetPVarInt(playerid, "chosencar", 0);
		    new strs[128];
		    for(new i = 0; i < HouseInfo[HGet(playerid)][hKlass]; i++)
		    {
		        new str[32];
		        format(str, sizeof(str), "[%i] %s\n", i, VehicleNames[CarInfo[playerid][carModel][i]-400]);
		        strcat(strs, str, sizeof(strs));
		    }
			return ShowPlayerDialogEx(playerid,14010,DIALOG_STYLE_LIST,"Замена авто",strs,"Купить","Отмена");
		}
		else if(clickedid == AutoShopText[7]) return ShowPlayerDialogEx(playerid,14011,0,"Предупреждение","Вы действительно хотите покинуть магазин?","Да","Нет");
	}
	else if(clickedid == Bone[3]) return ShowPlayerDialogEx(playerid,135,0,"Предупреждение","Если вы сделали ставку и игра уже началась, то деньги вам не вернутся!\nВы точно хотите покинуть стол?","Ок","Отмена");
	else if(clickedid == Bone[1])
	{
		if(GetPVarInt(playerid,"CasinoRank"))
		{
			new null = 0;
			for(new i; i < 5; i++) if(GetPVarInt(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Gamer][i],"BoneStol_")) null++;
			if(null > 0) return SCM(playerid,COLOR_GREY," В данный момент вы не можете изменить ставку!");
			return ShowPlayerDialogEx(playerid,136,1,"Установка ставки для игры:","Ставка должна быть не менее 1000 вирт\nи не более 300000000 вирт. Введите сумму ставки..","Далее","Отмена");
		}
		if(!BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Bet]) return SCM(playerid,COLOR_GREY," Ставка не установлена!");
		if(GetPVarInt(playerid,"BoneStol_")) return SCM(playerid,COLOR_GREY," Ты уже поставил ставку!");
		if(PTEMP[playerid][pCash] < BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Bet]) return SCM(playerid,COLOR_GREY," Недостаточно средств!");
		if(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][GameStart] > 0) return SCM(playerid,COLOR_GREY," Игра уже запущена!");
		PTEMP[playerid][pCash]-=BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Bet];
		BoneInfo[GetPVarInt(playerid,"BoneStol")-1][bBank] += BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Bet];
		SetPVarInt(playerid,"BoneStol_",1);
		UpdateBone(GetPVarInt(playerid,"BoneStol")-1);
	}
	else if(clickedid == Bone[2])
	{
		if(GetPVarInt(playerid,"CasinoRank"))
		{
			new null = 0;
			for(new i; i < 5; i++) if(GetPVarInt(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Gamer][i],"BoneStol_")) null++;
			if(null < 2) return SCM(playerid,COLOR_GREY," Нехватает игроков для старта!");
			if(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][GameStart] > 0) return SCM(playerid,COLOR_GREY," Игра уже запущена!");
			return BoneInfo[GetPVarInt(playerid,"BoneStol")-1][GameStart] = 30;
		}
		else
		{
			if(!GetPVarInt(playerid,"BoneStol_")) return SCM(playerid,COLOR_GREY," Вы не поставили ставку!");
			if(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][GameStart] <= 0) return SCM(playerid,COLOR_GREY," В данный момент нельзя кинуть кости");
			if(GetPVarInt(playerid,"BoneStol_") > 1) return SCM(playerid,COLOR_GREY," Вы уже кидали кубики в этом раунде!");
			new null = 0;
			SetPVarInt(playerid,"BoneStol_",random(11) + 2);
			UpdateBone(GetPVarInt(playerid,"BoneStol")-1);
			foreach(i)
			{
				if(GetPVarInt(i,"BoneStol")-1 == GetPVarInt(playerid,"BoneStol")-1 && GetPVarInt(i,"BoneStol_") == 1) null++;
			}
			if(!null) BoneInfo[GetPVarInt(playerid,"BoneStol")-1][GameStart] = 1;
		}
	}
	else if(_:clickedid == INVALID_TEXT_DRAW)
	{
		if(GetPVarInt(playerid, "SelectAvto") != -1) return ShowPlayerDialogEx(playerid,14011,0,"Предупреждение","Вы действительно хотите покинуть магазин?","Да","Нет");
		/*if(GetPVarInt(playerid,"Tookfaggio"))
		{
			DeletePVar(playerid,"Tookfaggio");
			for(new t; t < 5; t++) TextDrawHideForPlayer(playerid, Tookfaggio[t]);
			return CancelSelectTextDraw(playerid);
		}*/
		if(GetPVarInt(playerid,"BoneStol")) return ShowPlayerDialogEx(playerid,135,0,"Предупреждение","Если вы сделали ставку и игра уже началась, то деньги вам не вернутся!\nВы точно хотите покинуть стол?","Ок","Отмена");
	}
	return 1;
}