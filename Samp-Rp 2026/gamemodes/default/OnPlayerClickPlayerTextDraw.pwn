public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(Spectate[playerid] && PTEMP[playerid][pAdmin] > 1)
	{
		new httpquery[256];
		if(ReconPlayer[7] == playertextid) return SubTextDelete(playerid),ShowPlayerDialogEx(playerid, 202, DIALOG_STYLE_INPUT, "Ид игрока ", "Введите ид игрока", "Готово", "Отмена");
		else if(ReconPlayer[8] == playertextid)
		{
			DisableEnableReconButton(playerid, ReconSelect[playerid], 0);

			for(new i = 16; i < 35; i++)
			PlayerTextDrawHide(playerid, ReconPlayer[i]);

			for(new i = 16; i < 20; i++)
			PlayerTextDrawShow(playerid, ReconPlayer[i]);

			ReconBounds[playerid][0] = 16;
			ReconBounds[playerid][1] = 19;

			ReconSelectSub[playerid] = ReconBounds[playerid][0];
			DisableEnableReconButton(playerid, ReconSelectSub[playerid], 1);
		}
		else if(ReconPlayer[9] == playertextid)
		{
			DisableEnableReconButton(playerid, ReconSelect[playerid], 0);

			for(new i = 16; i < 35; i++)
			PlayerTextDrawHide(playerid, ReconPlayer[i]);

			for(new i = 20; i < 25; i++)
			PlayerTextDrawShow(playerid, ReconPlayer[i]);

			ReconBounds[playerid][0] = 20;
			ReconBounds[playerid][1] = 24;

			ReconSelectSub[playerid] = ReconBounds[playerid][0];
			DisableEnableReconButton(playerid, ReconSelectSub[playerid], 1);
		}
		else if(ReconPlayer[10] == playertextid)
		{
			DisableEnableReconButton(playerid, ReconSelect[playerid], 0);

			for(new i = 16; i < 35; i++)
			PlayerTextDrawHide(playerid, ReconPlayer[i]);

			PlayerTextDrawShow(playerid, ReconPlayer[25]);
			PlayerTextDrawShow(playerid, ReconPlayer[26]);

			ReconBounds[playerid][0] = 25;
			ReconBounds[playerid][1] = 26;

			ReconSelectSub[playerid] = ReconBounds[playerid][0];
			DisableEnableReconButton(playerid, ReconSelectSub[playerid], 1);

		}
		else if(ReconPlayer[12] == playertextid)
		{
			DisableEnableReconButton(playerid, ReconSelect[playerid], 0);

			for(new i = 16; i < 35; i++)
			PlayerTextDrawHide(playerid, ReconPlayer[i]);

			for(new i = 27; i < 30; i++)
			PlayerTextDrawShow(playerid, ReconPlayer[i]);

			ReconBounds[playerid][0] = 27;
			ReconBounds[playerid][1] = 29;

			ReconSelectSub[playerid] = ReconBounds[playerid][0];
			DisableEnableReconButton(playerid, ReconSelectSub[playerid], 1);
		}
		else if(ReconPlayer[13] == playertextid)
		{
			DisableEnableReconButton(playerid, ReconSelect[playerid], 0);

			for(new i = 16; i < 35; i++)
			PlayerTextDrawHide(playerid, ReconPlayer[i]);

			for(new i = 30; i < 34; i++)
			PlayerTextDrawShow(playerid, ReconPlayer[i]);

			ReconBounds[playerid][0] = 30;
			ReconBounds[playerid][1] = 33;

			ReconSelectSub[playerid] = ReconBounds[playerid][0];
			DisableEnableReconButton(playerid, ReconSelectSub[playerid], 1);
		}
		else if(ReconPlayer[11] == playertextid) return SubTextDelete(playerid),ShowPlayerDialogEx(playerid,101,DIALOG_STYLE_INPUT,"Причина","'             Введите причину             '","Готово","Отмена");
		else if(ReconPlayer[14] == playertextid) return SubTextDelete(playerid),StartSpectate(playerid,SpecAd[playerid]);
		else if(ReconPlayer[15] == playertextid) return SubTextDelete(playerid),CallLocalFunction("OnPlayerCommandText", "is", playerid, "/re OFF");
		else if(ReconPlayer[16] == playertextid)
		{
			new Float:boomx, Float:boomy, Float:boomz;
			GetPlayerPos(SpecAd[playerid],boomx, boomy, boomz);
			return CreateExplosion(boomx, boomy , boomz-8.9, 5, 0.5);
		}
		else if(ReconPlayer[17] == playertextid) return SetPlayerHealthAC(SpecAd[playerid], PTEMP[SpecAd[playerid]][pHP]-10.0);
		else if(ReconPlayer[18] == playertextid)
		{
			new Float: hp;
			GetVehicleHealth(GetPlayerVehicleID(SpecAd[playerid]), hp);
			SetVehicleHealth(GetPlayerVehicleID(SpecAd[playerid]), hp-10.0);
			return 1;
		}
		else if(ReconPlayer[19] == playertextid)
		{
			TimeNumberShotTarget[SpecAd[playerid]] = 0;
			TimeNumberShot[SpecAd[playerid]] = 0;
		}
		else if(ReconPlayer[20] == playertextid)
		{
			format(httpquery, sizeof(httpquery), "/mute %i 300",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
			//return SCM(playerid,COLOR_GREY,"Произошла ошибка. Бан чата не выдался");
		}
		else if(ReconPlayer[21] == playertextid)
		{
			format(httpquery, sizeof(httpquery), "/slap %i",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
		}
		else if(ReconPlayer[22] == playertextid)
		{
			format(httpquery, sizeof(httpquery), "/prison %i 3600",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
		}
		else if(ReconPlayer[23] == playertextid)
		{
			format(httpquery, sizeof(httpquery), "/freeze %i",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
		}
		else if(ReconPlayer[24] == playertextid)
		{
			format(httpquery, sizeof(httpquery), "/unfreeze %i",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
		}
		else if(ReconPlayer[25] == playertextid)
		{
			SubTextDelete(playerid);
			format(httpquery, sizeof(httpquery), "/skick %i",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
		}
		else if(ReconPlayer[26] == playertextid) return SubTextDelete(playerid),ShowPlayerDialogEx(playerid,115,DIALOG_STYLE_INPUT,"Причина","'             Введите причину             '","Готово","Отмена");
		else if(ReconPlayer[27] == playertextid) return SubTextDelete(playerid),ShowPlayerDialogEx(playerid,102,DIALOG_STYLE_INPUT,"Причина","'             Введите причину             '","Готово","Отмена");
		else if(ReconPlayer[28] == playertextid) return SubTextDelete(playerid),ShowPlayerDialogEx(playerid,116,DIALOG_STYLE_INPUT,"Причина","'             Введите причину             '","Готово","Отмена");
		else if(ReconPlayer[29] == playertextid) return SubTextDelete(playerid),ShowPlayerDialogEx(playerid,117,DIALOG_STYLE_INPUT,"Причина","'             Введите причину             '","Готово","Отмена");
		else if(ReconPlayer[30] == playertextid)
		{
			SubTextDelete(playerid);
			format(httpquery, sizeof(httpquery), "/getstats %i",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
		}
		else if(ReconPlayer[31] == playertextid)
		{
			SubTextDelete(playerid);
			format(httpquery, sizeof(httpquery), "/iwep %i",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
		}
		else if(ReconPlayer[32] == playertextid)
		{
			SubTextDelete(playerid);
			format(httpquery, sizeof(httpquery), "/getip %i",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
		}
		else if(ReconPlayer[33] == playertextid)
		{
			SubTextDelete(playerid);
			format(httpquery, sizeof(httpquery), "/getserial %i",SpecAd[playerid]);
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, httpquery);
		}
		else if(playertextid == ReconPlayer[34])
		{
			new stringer[1350];
			strcat(stringer,"{009933}Level:{FFFFFF} Лвл | Количество exp / Кол. exp необходимое для получения след. лвл\n");
			strcat(stringer,"{009933}Warns:{FFFFFF} Количество варнов\n{C0C0C0}\tЕсли число не отрицательное, то у игрока нет варнов, но они были раньше\n");
			strcat(stringer,"{009933}Armour:{FFFFFF} Броня\n{009933}Health:{FFFFFF} Здоровье\n{009933}CarHP:{FFFFFF} Здоровье машины\n{C0C0C0}\tТолько если игрок в транспорте,иначе значение будет 0\n");
			strcat(stringer,"{009933}Speed:{FFFFFF} Скорость транспорта / Макс. Скорость транспорта\n{C0C0C0}\tТолько если игрок в транспорте\n");
			strcat(stringer,"{009933}Ping:{FFFFFF} Пинг\n");
			strcat(stringer,"{009933}Ammo:{FFFFFF} Количество патронов на клиенте | Количество патронов на сервере\n{C0C0C0}\tТо что оображается игроку | Реальнок количество патронов\n");
			strcat(stringer,"{C0C0C0}\tПоказывает патроны оружия, которое у игрока в данный момент в руках\n");
			strcat(stringer,"{009933}Shot:{FFFFFF} Количество выстрелов / Количество попаданий | Процент попаданий\n");
			strcat(stringer,"{C0C0C0}\tСервер подсчитывает количество выстрелов сделанных игроком, пока он онлайн\n\tНа глаз можно определить, использует ли игрок AIM\n");
			strcat(stringer,"{009933}TimeShot:{FFFFFF} Количество выстрелов / Количество попаданий | Процент попаданий\n");
			strcat(stringer,"{C0C0C0}\tТоже самое, что предыдущая строка, но счетчик обнуляется каждые 10 минут\n\tВ меню Recon можно обнулить в любой момент - \"ResetShot\"\n");
			strcat(stringer,"{009933}AFKTime:{FFFFFF} Время игры и время проведенее в афк\n");
			strcat(stringer,"{009933}Engine:{FFFFFF} ON - Двигатель включен / OFF - Выключен");
			return ShowPlayerDialogEx(playerid,9999,0,"Help",stringer,"Закрыть","");
		}
	}
	return 1;
}