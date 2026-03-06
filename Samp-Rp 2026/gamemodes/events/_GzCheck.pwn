publics:_GzCheck()
{
    print("/-- _GzCheck() -->");

	for (new i = 1; i <= TOTALGZ; i++)
	{
		if (!ZoneOnBattle[i]) continue;
		if (GZSafeTime[i] > 0) GZSafeTime[i] --;
		foreach(x)
		{
			if (!PTEMP[x][pLogin]) continue;
			new y = PTEMP[x][pMember];
			if (y == GZInfo[i][gNapad] || y == GZInfo[i][gFrakVlad])
			{
				if (!GetPVarInt(x,"capture_on"))
				{
					PlayerTextDrawShow(x, Capture[x]);
					SetPVarInt(x,"capture_on",1);
					SetPlayerToTeamColor(x);
				}
				format(string,120,"~y~kills~n~~n~~g~%s:~w~ %i~n~~r~%s:~w~ %i",GetGangName(GZInfo[i][gFrakVlad]),CountOnZone[GZInfo[i][gFrakVlad]],GetGangName(GZInfo[i][gNapad]),CountOnZone[GZInfo[i][gNapad]]);
				PlayerTextDrawSetString(x,Capture[x],string);
				if (PlayerToKvadrat(x,GZInfo[i][gCoords][0], GZInfo[i][gCoords][1],GZInfo[i][gCoords][2],GZInfo[i][gCoords][3])) OnZONE[i][y] ++;
			}
		}
		new asd;
		for (new x = 0; x < 20; x++)
		{
			if (OnZONE[i][x] > 0 && IsInAllowedF(x) && GZSafeTime[i] <= 0) asd++;
		}
		if (asd == 1)
		{
			for (new x = 0; x < 20; x++)
			{
				if (OnZONE[i][x] > 0)
				{
					if (GZInfo[i][gFrakVlad] == x)
					{
						SendFamilyMessage(GZInfo[i][gFrakVlad],0x00B953AA," Вы отстояли свою территорию");
						SendFamilyMessage(GZInfo[i][gNapad],0xC56565AA," Вам не удалось захватить территорию");
						CountOnZone[GZInfo[i][gFrakVlad]] = 0;
						CountOnZone[GZInfo[i][gNapad]] = 0;
						foreach(y)
						{
							if (PTEMP[y][pMember] == GZInfo[i][gNapad] || PTEMP[y][pMember] == GZInfo[i][gFrakVlad])
							{
								DeletePVar(y,"capture_on");
								PlayerTextDrawHide(y, Capture[y]);
								for (new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(y,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
							}
						}
					}
					else
					{
						CountOnZone[GZInfo[i][gFrakVlad]] = 0;
						CountOnZone[GZInfo[i][gNapad]] = 0;
						SendFamilyMessage(GZInfo[i][gNapad], 0x00B953AA," Вы взяли под свой контроль новую территорию");
						for (new y = 1; y <= TOTALGZ; y++)
						{
							if (GZInfo[y][gFrakVlad] == 12) TotalGzB++;
							if (GZInfo[y][gFrakVlad] == 13) TotalGzV++;
							if (GZInfo[y][gFrakVlad] == 15) TotalGzG++;
							if (GZInfo[y][gFrakVlad] == 17) TotalGzA++;
							if (GZInfo[y][gFrakVlad] == 18) TotalGzR++;
						}
						switch (GZInfo[i][gNapad])
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
							if (PTEMP[y][pMember] == GZInfo[i][gNapad] || PTEMP[y][pMember] == GZInfo[i][gFrakVlad])
							{
								DeletePVar(y,"capture_on");
								PlayerTextDrawHide(y, Capture[y]);
								for (new i_ = 0; i_ < 5; i_++) { SendDeathMessageToPlayer(y,INVALID_PLAYER_ID-1, INVALID_PLAYER_ID-1, 0); }
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
	for (new i = 1; i <= TOTALGZ; i++)
	{
		for (new z = 0; z < 20; z++)
		{
			OnZONE[i][z] = 0;
		}
	}

    print("<-- _GzCheck() --/");

	return true;
}