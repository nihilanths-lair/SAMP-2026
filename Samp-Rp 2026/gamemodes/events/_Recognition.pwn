publics:_Recognition()
{
    print("/--> _Recognition() /-->");

	for (new i = 0; i < SLOTVIBROS; i++)
	{
		if (GetTickCount()-VibrosInfo[i][vTime] <= 60000*20)
		{
			DestroyDynamic3DTextLabel(VibrosInfo[i][vPodnyat]);
			DestroyObject(VibrosInfo[i][vObject]);
			for (new ix = i; ix < SLOTVIBROS-1; ix++)
			{
				VibrosInfo[ix][vModel] = VibrosInfo[ix+1][vModel];
				VibrosInfo[ix][vTime] = VibrosInfo[ix+1][vTime];
				VibrosInfo[ix][vX] = VibrosInfo[ix+1][vX];
				VibrosInfo[ix][vY] = VibrosInfo[ix+1][vY];
				VibrosInfo[ix][vZ] = VibrosInfo[ix+1][vZ];
				DestroyDynamic3DTextLabel(VibrosInfo[ix+1][vPodnyat]);
				DestroyObject(VibrosInfo[ix+1][vObject]);
				if (VibrosInfo[ix][vModel] == 1)
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
		if (!PTEMP[i][pWantedLevel] || !PTEMP[i][pLogin]) continue;
		recognition[i] = 0;
		GetPlayerPos(i,x,y,z);
		for (new idx = 0; idx < players; idx++)
		{
			if (IsPlayerInRangeOfPoint(Players[idx],150,x,y,z) && IsACop(Players[idx]) && Players[idx] != i) recognition[i]++;
		}
		if (!recognition[i])
		{
			SCM(i,-1," Ваша узнаваемость понизилась");
			PTEMP[i][pWantedLevel]--, SetPlayerWantedLevel(i,PTEMP[i][pWantedLevel] );
			if (!PTEMP[i][pWantedLevel])
			{
				if (LabelOn[i] == 1)
				{
					LabelOn[i] = 0;
					Delete3DTextLabel(LabelRecognition[i]);
				}
				PTEMP[i][pRecognition] = 0;
			}
			else
			{
				if (PTEMP[i][pRecognition] > 0) PTEMP[i][pRecognition]--;
			}
		}
		else
		{
			SCM(i,-1," Ваша узнаваемость повысилась");
			if (PTEMP[i][pRecognition] < 3) PTEMP[i][pRecognition]++;
		}
	}

    print("<--/ _Recognition() <--/");
}