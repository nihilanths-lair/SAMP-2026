public OnPlayerSelectedMenuRow(playerid, row)
{
	if(GetPlayerMenu(playerid) == bomj[0])
	{
		switch(row)
		{
		case 0: // next
			{
				if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, 137); SelectCharPlace[playerid] = 2; ChosenSkin[playerid] = 137; }
				else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, 212); SelectCharPlace[playerid] = 3; ChosenSkin[playerid] = 212; }
				else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, 230); SelectCharPlace[playerid] = 4; ChosenSkin[playerid] = 230; }
				else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 78); SelectCharPlace[playerid] = 5; ChosenSkin[playerid] = 78; }
				else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, 200); SelectCharPlace[playerid] = 6; ChosenSkin[playerid] = 200; }
				else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, 79); SelectCharPlace[playerid] = 1; ChosenSkin[playerid] = 79; }
				ShowMenuForPlayer(bomj[0],playerid);
			}
		case 1: // previous
			{
				if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, 200); SelectCharPlace[playerid] = 6; ChosenSkin[playerid] = 200; }
				else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, 79); SelectCharPlace[playerid] = 1; ChosenSkin[playerid] = 79; }
				else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, 137); SelectCharPlace[playerid] = 2; ChosenSkin[playerid] = 137; }
				else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 212); SelectCharPlace[playerid] = 3; ChosenSkin[playerid] = 212; }
				else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, 230); SelectCharPlace[playerid] = 4; ChosenSkin[playerid] = 230; }
				else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, 78); SelectCharPlace[playerid] = 5; ChosenSkin[playerid] = 78; }
				HideMenuForPlayer(bomj[0],playerid),ShowMenuForPlayer(bomj[2],playerid);
			}
		case 2:
			{
				new year, month, day;
				getdate(year, month, day);
				format(PTEMP[playerid][pDataReg],32, "%02i/%02i/%02i",day,month,year);
				GetPlayerIp(playerid,YCMDstr,32);
				strmid(PTEMP[playerid][pIpReg],YCMDstr, 0, strlen(YCMDstr), 32);
				PTEMP[playerid][pPnumber] = 100000 + random(899999);
    			new Hash[64 + 1];
    			SHA256_PassHash(PTEMP[playerid][pKey], "78sdjs", Hash, sizeof Hash);
				mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_ACCOUNTS"` (`Name`, `pKey`, `pEmail`, `pSex`, `pDataReg`, `pIpReg`, `pDrug`,`pChars`, `pPnumber`, `pTut`, `pPHouseKey`, `pKvartiraKey`, `pPBizzKey`, `pPFarmKey`,`pPLimitBank`, `pAdmin`, `pChar`) VALUES ('%s', '%s', '%s', '%i', '%s', '%s', '%s', '%i, %i, %i, %i, %i, %i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i')"
				,PTEMP[playerid][pName],Hash,PTEMP[playerid][pEmail],PTEMP[playerid][pSex],PTEMP[playerid][pDataReg],PTEMP[playerid][pIpReg],PTEMP[playerid][pDrug],ChosenSkin[playerid], ChosenSkin[playerid], ChosenSkin[playerid],
				ChosenSkin[playerid], ChosenSkin[playerid], ChosenSkin[playerid], PTEMP[playerid][pPnumber], PTEMP[playerid][pTut], PTEMP[playerid][pPHouseKey], PTEMP[playerid][pKvartiraKey], PTEMP[playerid][pPBizzKey], PTEMP[playerid][pPFarmKey], PTEMP[playerid][pPLimitBank], PTEMP[playerid][pAdmin], PTEMP[playerid][pChar][0]);
				mysql_function_query(DATABASE,QUERY,true,"PlayerRegister","i",playerid);
			}
		}
	}
	else if(GetPlayerMenu(playerid) == bomj[2]) // на первом месте previous
	{
		switch(row)
		{
			case 0: // previous
			{
				if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, 200); SelectCharPlace[playerid] = 6; ChosenSkin[playerid] = 200; }
				else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, 79); SelectCharPlace[playerid] = 1; ChosenSkin[playerid] = 79; }
				else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, 137); SelectCharPlace[playerid] = 2; ChosenSkin[playerid] = 137; }
				else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 212); SelectCharPlace[playerid] = 3; ChosenSkin[playerid] = 212; }
				else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, 230); SelectCharPlace[playerid] = 4; ChosenSkin[playerid] = 230; }
				else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, 78); SelectCharPlace[playerid] = 5; ChosenSkin[playerid] = 78; }
				ShowMenuForPlayer(bomj[2],playerid);
			}
			case 1: // next
			{
				if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, 137); SelectCharPlace[playerid] = 2; ChosenSkin[playerid] = 137; }
				else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, 212); SelectCharPlace[playerid] = 3; ChosenSkin[playerid] = 212; }
				else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, 230); SelectCharPlace[playerid] = 4; ChosenSkin[playerid] = 230; }
				else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 78); SelectCharPlace[playerid] = 5; ChosenSkin[playerid] = 78; }
				else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, 200); SelectCharPlace[playerid] = 6; ChosenSkin[playerid] = 200; }
				else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, 79); SelectCharPlace[playerid] = 1; ChosenSkin[playerid] = 79; }
				ShowMenuForPlayer(bomj[0],playerid);
			}
		case 2:
			{
				new year, month, day;
				getdate(year, month, day);
				format(PTEMP[playerid][pDataReg],32, "%02i/%02i/%02i",day,month,year);
				GetPlayerIp(playerid,YCMDstr,32);
				strmid(PTEMP[playerid][pIpReg],YCMDstr, 0, strlen(YCMDstr), 32);
				PTEMP[playerid][pPnumber] = 100000 + random(899999);
				new Hash[64 + 1];
    			SHA256_PassHash(PTEMP[playerid][pKey], "78sdjs", Hash, sizeof Hash);
				mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_ACCOUNTS"` (`Name`, `pKey`, `pEmail`, `pSex`, `pDataReg`, `pIpReg`, `pDrug`,`pChars`, `pPnumber`, `pTut`, `pPHouseKey`, `pKvartiraKey`, `pPBizzKey`, `pPFarmKey`,`pPLimitBank`, `pAdmin`, `pChar`) VALUES ('%s', '%s', '%s', '%i', '%s', '%s', '%s', '%i, %i, %i, %i, %i, %i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i')"
				,PTEMP[playerid][pName],Hash,PTEMP[playerid][pEmail],PTEMP[playerid][pSex],PTEMP[playerid][pDataReg],PTEMP[playerid][pIpReg],PTEMP[playerid][pDrug],ChosenSkin[playerid], ChosenSkin[playerid], ChosenSkin[playerid],
				ChosenSkin[playerid], ChosenSkin[playerid], ChosenSkin[playerid], PTEMP[playerid][pPnumber], PTEMP[playerid][pTut], PTEMP[playerid][pPHouseKey], PTEMP[playerid][pKvartiraKey], PTEMP[playerid][pPBizzKey], PTEMP[playerid][pPFarmKey], PTEMP[playerid][pPLimitBank], PTEMP[playerid][pAdmin], PTEMP[playerid][pChar][0]);
				mysql_function_query(DATABASE,QUERY,true,"PlayerRegister","i",playerid);
			}
		}
	}
	if(GetPlayerMenu(playerid) == bomj[1])
	{
		switch(row)
		{
		case 0:
			{
				if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[103][0]); SelectCharPlace[playerid] = 2; ChosenSkin[playerid] = JoinPed[103][0]; }
				else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[104][0]); SelectCharPlace[playerid] = 1; ChosenSkin[playerid] = JoinPed[104][0]; }
				ShowMenuForPlayer(bomj[1],playerid);
			}
		case 1:
			{
				if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[103][0]); SelectCharPlace[playerid] = 2; ChosenSkin[playerid] = JoinPed[103][0]; }
				else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[104][0]); SelectCharPlace[playerid] = 1; ChosenSkin[playerid] = JoinPed[104][0]; }
				ShowMenuForPlayer(bomj[3],playerid);
			}
		case 2:
			{
				new year, month, day;
				getdate(year, month, day);
				format(PTEMP[playerid][pDataReg],32, "%02i/%02i/%02i",day,month,year);
				GetPlayerIp(playerid,YCMDstr,32);
				strmid(PTEMP[playerid][pIpReg],YCMDstr, 0, strlen(YCMDstr), 32);
				PTEMP[playerid][pPnumber] = 100000 + random(899999);
				new Hash[64 + 1];
    			SHA256_PassHash(PTEMP[playerid][pKey], "78sdjs", Hash, sizeof Hash);
				mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_ACCOUNTS"` (`Name`, `pKey`, `pEmail`, `pSex`, `pDataReg`, `pIpReg`, `pDrug`,`pChars`, `pPnumber`, `pTut`, `pPHouseKey`, `pKvartiraKey`,`pPBizzKey`, `pPFarmKey`,`pPLimitBank`, `pAdmin`, `pChar`) VALUES ('%s', '%s', '%s', '%i', '%s', '%s', '%s', '%i, %i, %i, %i, %i, %i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i')"
				,PTEMP[playerid][pName],Hash,PTEMP[playerid][pEmail],PTEMP[playerid][pSex],PTEMP[playerid][pDataReg],PTEMP[playerid][pIpReg],PTEMP[playerid][pDrug],ChosenSkin[playerid], ChosenSkin[playerid], ChosenSkin[playerid],
				ChosenSkin[playerid], ChosenSkin[playerid], ChosenSkin[playerid], PTEMP[playerid][pPnumber], PTEMP[playerid][pTut], PTEMP[playerid][pPHouseKey], PTEMP[playerid][pKvartiraKey],PTEMP[playerid][pPBizzKey], PTEMP[playerid][pPFarmKey], PTEMP[playerid][pPLimitBank], PTEMP[playerid][pAdmin], PTEMP[playerid][pChar][0]);
				mysql_function_query(DATABASE,QUERY,true,"PlayerRegister","i",playerid);
			}
		}
	}
	else if(GetPlayerMenu(playerid) == bomj[3])
	{
		switch(row)
		{
		case 0: // prev
			{
				if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[103][0]); SelectCharPlace[playerid] = 2; ChosenSkin[playerid] = JoinPed[103][0]; }
				else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[104][0]); SelectCharPlace[playerid] = 1; ChosenSkin[playerid] = JoinPed[104][0]; }
				ShowMenuForPlayer(bomj[3],playerid);
			}
		case 1: // next
			{
				if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[103][0]); SelectCharPlace[playerid] = 2; ChosenSkin[playerid] = JoinPed[103][0]; }
				else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[104][0]); SelectCharPlace[playerid] = 1; ChosenSkin[playerid] = JoinPed[104][0]; }
				ShowMenuForPlayer(bomj[1],playerid);
			}
		case 2:
			{
				new year, month, day;
				getdate(year, month, day);
				format(PTEMP[playerid][pDataReg],32, "%02i/%02i/%02i",day,month,year);
				GetPlayerIp(playerid,YCMDstr,32);
				strmid(PTEMP[playerid][pIpReg],YCMDstr, 0, strlen(YCMDstr), 32);
				PTEMP[playerid][pPnumber] = 100000 + random(899999);
				new Hash[64 + 1];
    			SHA256_PassHash(PTEMP[playerid][pKey], "78sdjs", Hash, sizeof Hash);
				mysql_format(DATABASE, QUERY, sizeof(QUERY), "INSERT INTO `"TABLE_ACCOUNTS"` (`Name`, `pKey`, `pEmail`, `pSex`, `pDataReg`, `pIpReg`, `pDrug`,`pChars`, `pPnumber`, `pTut`, `pPHouseKey`, `pKvartiraKey`,`pPBizzKey`, `pPFarmKey`,`pPLimitBank`, `pAdmin`, `pChar`) VALUES ('%s', '%s', '%s', '%i', '%s', '%s', '%s', '%i, %i, %i, %i, %i, %i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i')"
				,PTEMP[playerid][pName],Hash,PTEMP[playerid][pEmail],PTEMP[playerid][pSex],PTEMP[playerid][pDataReg],PTEMP[playerid][pIpReg],PTEMP[playerid][pDrug],ChosenSkin[playerid], ChosenSkin[playerid], ChosenSkin[playerid],
				ChosenSkin[playerid], ChosenSkin[playerid], ChosenSkin[playerid], PTEMP[playerid][pPnumber], PTEMP[playerid][pTut], PTEMP[playerid][pPHouseKey], PTEMP[playerid][pKvartiraKey],PTEMP[playerid][pPBizzKey], PTEMP[playerid][pPFarmKey], PTEMP[playerid][pPLimitBank], PTEMP[playerid][pAdmin], PTEMP[playerid][pChar][0]);
				mysql_function_query(DATABASE,QUERY,true,"PlayerRegister","i",playerid);
			}
		}
	}
	if(GetPlayerMenu(playerid) == ChoseSkin[0])
	{
		switch(row)
		{
		case 0: // next
			{
				switch (SelectCharID[playerid])
				{
				case 1:
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[0][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[0][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[1][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[1][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[2][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[2][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[3][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[3][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[4][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[4][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[5][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[5][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[6][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[6][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[7][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[7][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 2:
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[8][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[8][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[9][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[9][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[10][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[10][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[11][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[11][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[12][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[12][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[13][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[13][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 3:
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[91][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[91][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[89][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[89][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 4: // Medics SF
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 5: // La Cosa Nostra
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[21][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[21][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[22][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[22][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[23][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[23][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[24][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[24][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 6: // Yakuza
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[25][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[25][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[26][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[26][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[27][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[27][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[28][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[28][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 7: // Goverment
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[29][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[29][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[30][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[30][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[31][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[31][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[32][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[32][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[33][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[33][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 8: // Casino Caligula
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, 189); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = 189; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[46][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[46][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[47][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[47][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 9: // SF News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[42][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[42][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[43][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[43][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[44][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[44][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 188); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = 188; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[45][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[45][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 10: // SFPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[34][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[34][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[35][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[35][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[36][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[36][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[37][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[37][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[38][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[38][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[39][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[39][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[40][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[40][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[41][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[41][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 11: // Instructors
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[48][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[48][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[49][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[49][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[51][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[51][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 12: // Ballas
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[74][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[74][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[75][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[75][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[76][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[76][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 195); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 195; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 13: // Vagos
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[80][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[80][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[81][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[81][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[82][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[82][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 14: // Russian Mafia
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[60][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[60][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[61][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[61][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[62][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[62][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[63][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[63][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[64][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[64][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 15: // Groove
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[65][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[65][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[66][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[66][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[67][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[67][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[68][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[68][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[69][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[69][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[70][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[70][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, 56); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 56; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 16: // LS News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[85][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[85][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[86][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[86][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[87][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[87][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 188); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = 188; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[88][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[88][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 17: // Aztek
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[71][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[71][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[72][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[72][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[73][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[73][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 18: // Rifa
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[77][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[77][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[78][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[78][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[79][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[79][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 30); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = 30; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 19: // Army LV
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[91][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[91][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[89][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[89][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 20: // LV News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[85][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[85][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[86][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[86][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[87][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[87][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 188); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = 188; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[88][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[88][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 21: // LVPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[52][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[52][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[53][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[53][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[54][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[54][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[55][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[55][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[56][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[56][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[57][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[57][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[58][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[58][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[59][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[59][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 22: // Medics LS
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 23: // Medics LV
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 24: // Hell's Angels MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 26: // Warlocks MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 29: // Pagans MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				}
			}
		case 1: //previous
			{
				switch (SelectCharID[playerid])
				{
				case 1: // LSPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[0][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[0][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[1][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[1][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[2][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[2][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[3][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[3][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[4][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[4][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[5][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[5][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[6][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[6][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[7][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[7][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 2: // FBI
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[8][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[8][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[9][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[9][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[10][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[10][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[11][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[11][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[12][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[12][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[13][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[13][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 3: // Army SF
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[91][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[91][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[89][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[89][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 4: // Medics SF
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 5: // La Cosa Nostra
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[21][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[21][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[22][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[22][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[23][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[23][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[24][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[24][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 6: // Yakuza
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[25][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[25][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[26][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[26][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[27][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[27][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[28][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[28][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 7: // Goverment
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[29][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[29][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[30][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[30][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[31][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[31][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[32][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[32][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[33][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[33][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 8: // Casino Caligula
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, 189); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 189; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[46][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[46][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[47][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[47][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 9: // SF News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[42][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[42][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[43][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[43][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[44][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[44][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[45][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[45][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 10: // SFPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[34][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[34][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[35][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[35][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[36][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[36][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[37][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[37][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[38][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[38][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[39][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[39][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[40][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[40][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[41][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[41][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 11: // Instructors
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[48][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[48][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[49][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[49][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[51][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[51][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 12: // Ballas
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[74][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[74][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[75][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[75][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[76][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[76][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 195); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 195; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 13: // Vagos
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[80][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[80][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[81][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[81][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[82][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[82][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 14: // Russian Mafia
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[60][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[60][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[61][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[61][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[62][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[62][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[63][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[63][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[64][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[64][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 15: // Groove
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[65][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[65][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[66][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[66][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[67][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[67][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[68][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[68][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[69][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[69][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[70][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[70][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, 56); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = 56; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 16: // LS News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[85][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[85][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[86][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[86][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[87][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[87][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[88][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[88][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 17: // Aztek
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[71][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[71][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[72][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[72][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[73][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[73][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 18: // Rifa
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[77][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[77][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[78][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[78][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[79][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[79][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 30); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 30; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 19: // Army LV
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[91][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[91][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[89][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[89][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 20: // LV News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[85][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[85][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[86][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[86][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[87][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[87][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[88][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[88][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 21: // LVPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[52][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[52][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[53][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[53][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[54][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[54][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[55][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[55][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[56][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[56][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[57][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[57][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[58][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[58][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[59][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[59][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 22: // Medics LS
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 23: // Medics LV
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 24: // Hell's Angels MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 26: // Warlocks MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 29: // Pagans MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				}
			}
		case 2:
			{
				PTEMP[playerid][pModel] = InviteSkin[playerid];
				forma[playerid] = 0;
				switch(zips[playerid])
				{
				case false: SetPlayerVirtualWorld(playerid, 2);
				case true: SetPlayerVirtualWorld(playerid, 1);
				}
				SelectCharPlace[playerid] = 0;
				CharPrice[playerid] = 0;
				SelectCharID[playerid] = 0;
				SelectChar[playerid] = 0;
				PicCP[playerid] = 0;
				//=====
				switch(zips[playerid])
				{
				case false: SetPlayerVirtualWorld(playerid, 2);
				case true: SetPlayerVirtualWorld(playerid, 1);
				}
				TogglePlayerControllable(playerid, 1);
				if(GetPVarInt(playerid, "player_frac_mo"))
				{
					SpawnPlayer(playerid);
					DeletePVar(playerid, "player_frac_mo");
				}
				else
				{
					SetPlayerPos(playerid,221.7944,-8.4229,1002.2109);
					SetPlayerFacingAngle(playerid,273.5792);
					SetPlayerInterior(playerid,5);
				}
				SetCameraBehindPlayer(playerid);
			}
		}
	}
	else if(GetPlayerMenu(playerid) == ChoseSkin[1])
	{
		switch(row)
		{
			case 0: //previous
			{
				switch (SelectCharID[playerid])
				{
				case 1: // LSPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[0][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[0][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[1][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[1][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[2][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[2][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[3][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[3][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[4][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[4][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[5][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[5][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[6][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[6][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[7][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[7][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 2: // FBI
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[8][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[8][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[9][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[9][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[10][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[10][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[11][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[11][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[12][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[12][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[13][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[13][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 3: // Army SF
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[91][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[91][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[89][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[89][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 4: // Medics SF
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 5: // La Cosa Nostra
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[21][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[21][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[22][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[22][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[23][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[23][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[24][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[24][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 6: // Yakuza
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[25][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[25][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[26][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[26][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[27][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[27][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[28][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[28][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 7: // Goverment
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[29][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[29][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[30][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[30][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[31][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[31][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[32][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[32][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[33][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[33][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 8: // Casino Caligula
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, 189); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 189; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[46][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[46][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[47][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[47][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 9: // SF News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[42][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[42][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[43][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[43][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[44][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[44][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[45][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[45][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 10: // SFPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[34][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[34][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[35][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[35][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[36][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[36][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[37][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[37][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[38][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[38][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[39][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[39][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[40][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[40][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[41][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[41][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 11: // Instructors
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[48][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[48][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[49][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[49][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[51][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[51][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 12: // Ballas
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[74][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[74][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[75][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[75][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[76][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[76][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 195); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 195; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 13: // Vagos
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[80][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[80][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[81][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[81][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[82][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[82][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 14: // Russian Mafia
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[60][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[60][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[61][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[61][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[62][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[62][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[63][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[63][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[64][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[64][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 15: // Groove
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[65][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[65][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[66][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[66][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[67][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[67][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[68][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[68][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[69][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[69][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[70][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[70][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, 56); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = 56; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 16: // LS News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[85][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[85][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[86][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[86][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[87][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[87][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[88][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[88][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 17: // Aztek
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[71][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[71][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[72][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[72][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[73][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[73][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 18: // Rifa
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[77][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[77][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[78][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[78][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[79][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[79][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 30); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = 30; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 19: // Army LV
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[91][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[91][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[89][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[89][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 20: // LV News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[85][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[85][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[86][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[86][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[87][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[87][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[88][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[88][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 21: // LVPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[52][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[52][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[53][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[53][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[54][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[54][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[55][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[55][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[56][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[56][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[57][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[57][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[58][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[58][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[59][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[59][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 22: // Medics LS
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 23: // Medics LV
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 24: // Hell's Angels MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 26: // Warlocks MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				case 29: // Pagans MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[1],playerid);
					}
				}
			}
			case 1: // next
			{
				switch (SelectCharID[playerid])
				{
				case 1:
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[0][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[0][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[1][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[1][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[2][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[2][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[3][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[3][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[4][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[4][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[5][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[5][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[6][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[6][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[7][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[7][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 2:
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[8][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[8][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[9][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[9][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[10][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[10][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[11][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[11][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[12][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[12][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[13][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[13][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 3:
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[91][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[91][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[89][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[89][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 4: // Medics SF
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 5: // La Cosa Nostra
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[21][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[21][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[22][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[22][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[23][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[23][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[24][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[24][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 6: // Yakuza
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[25][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[25][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[26][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[26][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[27][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[27][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[28][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[28][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 7: // Goverment
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[29][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[29][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[30][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[30][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[31][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[31][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[32][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[32][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[33][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[33][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 8: // Casino Caligula
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, 189); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = 189; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[46][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[46][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[47][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[47][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 9: // SF News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[42][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[42][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[43][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[43][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[44][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[44][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 188); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = 188; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[45][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[45][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 10: // SFPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[34][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[34][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[35][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[35][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[36][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[36][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[37][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[37][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[38][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[38][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[39][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[39][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[40][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[40][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[41][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[41][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 11: // Instructors
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[48][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[48][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[49][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[49][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[51][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[51][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 12: // Ballas
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[74][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[74][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[75][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[75][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[76][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[76][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 195); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 195; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 13: // Vagos
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[80][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[80][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[81][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[81][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[82][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[82][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 14: // Russian Mafia
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[60][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[60][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[61][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[61][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[62][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[62][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[63][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[63][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[64][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[64][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 15: // Groove
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[65][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[65][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[66][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[66][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[67][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[67][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[68][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[68][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[69][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[69][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[70][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[70][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, 56); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 56; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 16: // LS News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[85][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[85][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[86][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[86][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[87][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[87][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 188); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = 188; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[88][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[88][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 17: // Aztek
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[71][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[71][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[72][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[72][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[73][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[73][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 18: // Rifa
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[77][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[77][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[78][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[78][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[79][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[79][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 30); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = 30; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, 226); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = 226; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 19: // Army LV
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[91][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[91][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[89][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[89][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 20: // LV News
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[85][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[85][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[86][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[86][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[87][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[87][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, 188); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = 188; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[88][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[88][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 21: // LVPD
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[52][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[52][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[53][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[53][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[54][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[54][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[55][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[55][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[56][0]); SelectCharPlace[playerid] = 6; InviteSkin[playerid] = JoinPed[56][0]; }
						else if(SelectCharPlace[playerid] == 6) { SetPlayerSkin(playerid, JoinPed[57][0]); SelectCharPlace[playerid] = 7; InviteSkin[playerid] = JoinPed[57][0]; }
						else if(SelectCharPlace[playerid] == 7) { SetPlayerSkin(playerid, JoinPed[58][0]); SelectCharPlace[playerid] = 8; InviteSkin[playerid] = JoinPed[58][0]; }
						else if(SelectCharPlace[playerid] == 8) { SetPlayerSkin(playerid, JoinPed[59][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[59][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 22: // Medics LS
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 23: // Medics LV
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[16][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[16][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[17][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[17][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[18][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[18][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[19][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[19][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[20][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[20][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 24: // Hell's Angels MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 26: // Warlocks MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				case 29: // Pagans MC
					{
						if(SelectCharPlace[playerid] == 1) { SetPlayerSkin(playerid, JoinPed[105][0]); SelectCharPlace[playerid] = 2; InviteSkin[playerid] = JoinPed[105][0]; }
						else if(SelectCharPlace[playerid] == 2) { SetPlayerSkin(playerid, JoinPed[106][0]); SelectCharPlace[playerid] = 3; InviteSkin[playerid] = JoinPed[106][0]; }
						else if(SelectCharPlace[playerid] == 3) { SetPlayerSkin(playerid, JoinPed[107][0]); SelectCharPlace[playerid] = 4; InviteSkin[playerid] = JoinPed[107][0]; }
						else if(SelectCharPlace[playerid] == 4) { SetPlayerSkin(playerid, JoinPed[108][0]); SelectCharPlace[playerid] = 5; InviteSkin[playerid] = JoinPed[108][0]; }
						else if(SelectCharPlace[playerid] == 5) { SetPlayerSkin(playerid, JoinPed[109][0]); SelectCharPlace[playerid] = 1; InviteSkin[playerid] = JoinPed[109][0]; }
						ShowMenuForPlayer(ChoseSkin[0],playerid);
					}
				}
			}
		case 2:
			{
				PTEMP[playerid][pModel] = InviteSkin[playerid];
				forma[playerid] = 0;
				switch(zips[playerid])
				{
				case false: SetPlayerVirtualWorld(playerid, 2);
				case true: SetPlayerVirtualWorld(playerid, 1);
				}
				SelectCharPlace[playerid] = 0;
				CharPrice[playerid] = 0;
				SelectCharID[playerid] = 0;
				SelectChar[playerid] = 0;
				PicCP[playerid] = 0;
				//=====
				switch(zips[playerid])
				{
				case false: SetPlayerVirtualWorld(playerid, 2);
				case true: SetPlayerVirtualWorld(playerid, 1);
				}
				TogglePlayerControllable(playerid, 1);
				SetPlayerPos(playerid,221.7944,-8.4229,1002.2109);
				SetPlayerFacingAngle(playerid,273.5792);
				SetPlayerInterior(playerid,5);
				SetCameraBehindPlayer(playerid);
			}
		}
	}
	if(GetPlayerMenu(playerid) == BuyClothes)
	{
		switch(row)
		{
		case 0:
			{
				if(PTEMP[playerid][pSex] == 1)
				{
					if(ChangeSkin[playerid]	== sizeof(SkinMen)-1) ChangeSkin[playerid] = 0;
					else ChangeSkin[playerid]++;
					SetPlayerSkin(playerid,SkinMen[ChangeSkin[playerid]][0]);// Одеваем скин
					switch(booston)
					{
					case 0:format(string, 127,"~n~~n~~n~~n~~n~~n~~g~COST: ~w~%i",SkinMen[ChangeSkin[playerid]][1]);// Выводим цену на екран
					case 1:format(string, 127,"~n~~n~~n~~n~~n~~n~~g~COST: ~w~%i",SkinMen[ChangeSkin[playerid]][1]-SkinMen[ChangeSkin[playerid]][1]*20/100);// Выводим цену на екран
					}
				}
				else //Если женщина то...
				{
					if(ChangeSkin[playerid] == sizeof(SkinMale)-1)ChangeSkin[playerid] = 0;
					else ChangeSkin[playerid]++;//Прибавляем переменную
					SetPlayerSkin(playerid,SkinMale[ChangeSkin[playerid]][0]);//Одеваем скин
					switch(booston)
					{
					case 0:	format(string, 127,"~n~~n~~n~~n~~n~~n~~g~COST: ~w~%i",SkinMale[ChangeSkin[playerid]][1]);//?Выводим цену на екран
					case 1: format(string, 127,"~n~~n~~n~~n~~n~~n~~g~COST: ~w~%i",SkinMale[ChangeSkin[playerid]][1]-SkinMale[ChangeSkin[playerid]][1]*20/100);//?Выводим цену на екран
					}
				}
				GameTextForPlayer(playerid, string, 2000, 3);
				ShowMenuForPlayer(BuyClothes, playerid);//Выводим меню дальше
			}
		case 1://Если нажал назад то...
			{
				if(PTEMP[playerid][pSex] == 1)//Если парень то...
				{
					if(ChangeSkin[playerid] == 0)ChangeSkin[playerid] = sizeof(SkinMen)-1;
					else ChangeSkin[playerid]--;
					SetPlayerSkin(playerid,SkinMen[ChangeSkin[playerid]][0]);//Одеваем скин
					switch(booston)
					{
					case 0:format(string, 127,"~n~~n~~n~~n~~n~~n~~g~COST: ~w~%i",SkinMen[ChangeSkin[playerid]][1]);// Выводим цену на екран
					case 1:format(string, 127,"~n~~n~~n~~n~~n~~n~~g~COST: ~w~%i",SkinMen[ChangeSkin[playerid]][1]-SkinMen[ChangeSkin[playerid]][1]*20/100);// Выводим цену на екран
					}
				}
				else//Если девушка то...
				{
					if(ChangeSkin[playerid] == 0)ChangeSkin[playerid] = sizeof(SkinMale)-1;
					else ChangeSkin[playerid]--;
					SetPlayerSkin(playerid,SkinMale[ChangeSkin[playerid]][0]);//Одеваем скин
					switch(booston)
					{
					case 0:	format(string, 127,"~n~~n~~n~~n~~n~~n~~g~COST: ~w~%i",SkinMale[ChangeSkin[playerid]][1]);//?Выводим цену на екран
					case 1: format(string, 127,"~n~~n~~n~~n~~n~~n~~g~COST: ~w~%i",SkinMale[ChangeSkin[playerid]][1]-SkinMale[ChangeSkin[playerid]][1]*20/100);//?Выводим цену на екран
					}
				}
				GameTextForPlayer(playerid, string, 2000, 3);
				ShowMenuForPlayer(BuyClothes, playerid);//Выводим меню дальше
			}
		case 2://Если нажал купить то...
			{
				if(PTEMP[playerid][pSex] == 1)//Если мужик то...
				{
					switch(booston)
					{
					case 0:
						{
							if(PTEMP[playerid][pBank] < SkinMen[ChangeSkin[playerid]][1])
							{
								SCM(playerid,COLOR_GREY," Недостаточно денег на банковском счету");//Пишем грустное сообщение
								ShowMenuForPlayer(BuyClothes, playerid);//Возвращаем меню, вдруг захочет что-то подешевле....
								return true;
							}
							PTEMP[playerid][pBank]-= SkinMen[ChangeSkin[playerid]][1],format(YCMDstr, sizeof(YCMDstr), "~r~-$%i",SkinMen[ChangeSkin[playerid]][1]);
							GameTextForPlayer(playerid, YCMDstr, 2000, 1);
						}
					case 1:
						{
							if(PTEMP[playerid][pBank] < SkinMen[ChangeSkin[playerid]][1]-SkinMen[ChangeSkin[playerid]][1]*20/100)
							{
								SCM(playerid,COLOR_GREY," Недостаточно денег на банковском счету");//Пишем грустное сообщение
								ShowMenuForPlayer(BuyClothes, playerid);//Возвращаем меню, вдруг захочет что-то подешевле....
								return true;
							}
							PTEMP[playerid][pBank]-= SkinMen[ChangeSkin[playerid]][1],format(YCMDstr, sizeof(YCMDstr), "~r~-$%i",SkinMen[ChangeSkin[playerid]][1]-SkinMen[ChangeSkin[playerid]][1]*20/100);
							GameTextForPlayer(playerid, YCMDstr, 2000, 1);
						}
					}
				}
				else//Если девушка то...
				{
					switch(booston)
					{
					case 0:
						{
							if(PTEMP[playerid][pBank] < SkinMale[ChangeSkin[playerid]][1])
							{
								SCM(playerid,COLOR_GREY," Недостаточно денег на банковском счету");//Пишем грустное сообщение
								ShowMenuForPlayer(BuyClothes, playerid);//Возвращаем меню, вдруг захочет что-то подешевле....
								return true;
							}
							PTEMP[playerid][pBank]-= SkinMale[ChangeSkin[playerid]][1],format(YCMDstr, sizeof(YCMDstr), "~r~-$%i",SkinMale[ChangeSkin[playerid]][1]);
							GameTextForPlayer(playerid, YCMDstr, 2000, 1);
						}
					case 1:
						{
							if(PTEMP[playerid][pBank] < SkinMale[ChangeSkin[playerid]][1]-SkinMale[ChangeSkin[playerid]][1]*20/100)
							{
								SCM(playerid,COLOR_GREY," Недостаточно денег на банковском счету");//Пишем грустное сообщение
								ShowMenuForPlayer(BuyClothes, playerid);//Возвращаем меню, вдруг захочет что-то подешевле....
								return true;
							}
							PTEMP[playerid][pBank]-= SkinMale[ChangeSkin[playerid]][1],format(YCMDstr, sizeof(YCMDstr), "~r~-$%i",SkinMale[ChangeSkin[playerid]][1]-SkinMale[ChangeSkin[playerid]][1]*20/100);
							GameTextForPlayer(playerid, YCMDstr, 2000, 1);
						}
					}
				}
				switch(zips[playerid])
				{
				case false: SetPlayerVirtualWorld(playerid, 2);
				case true: SetPlayerVirtualWorld(playerid, 1);
				}
				PTEMP[playerid][pChar][0] = GetPlayerSkin(playerid);//даём скин
				TogglePlayerControllable(playerid, 1);//Размораживаем
				SetPlayerPos(playerid,221.7944,-8.4229,1002.2109);//тпкаем обратно в амгаз
				SetPlayerFacingAngle(playerid,273.5792);//Bla bla
				SetPlayerInterior(playerid,5);//Даём инт. магазина
				SetCameraBehindPlayer(playerid);//Включаем управление камерой
				if(PTEMP[playerid][pQuestL] == 1 && PTEMP[playerid][pQuest] == 4)
				{
					PlayerPlaySound(playerid, 4201, 0.0, 0.0, 0);
					ShowPlayerDialogEx(playerid,13375,DIALOG_STYLE_MSGBOX,"Задание","Теперь ты можешь поехать в Мэрию и получить там паспорт\n{DDCD70}Задача: Войти в мэрию\n{17B757}Награда: 2 уровень,4000 вирт"
					,"Готово","");
					GameTextForPlayer(playerid, "~g~+1000$", 2000, 1);
					PTEMP[playerid][pCash] += 1000;
					PTEMP[playerid][pQuest] = 5;
					PTEMP[playerid][pQuestP] = 0;
					PTEMP[playerid][pQuestPF] = 0;
					SCM(playerid,0x30a0a7aa," Задание выполнено");
				}
			}
		case 3://если нажал Exit
			{
				switch(zips[playerid])
				{
				case false: SetPlayerVirtualWorld(playerid, 2);
				case true: SetPlayerVirtualWorld(playerid, 1);
				}
				SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);//Меняем скин на тот который был
				TogglePlayerControllable(playerid, 1);//Размораживаем
				SetPlayerPos(playerid,221.7944,-8.4229,1002.2109);//тпкаем обратно в амгаз
				SetPlayerFacingAngle(playerid,273.5792);//Bla bla
				SetPlayerInterior(playerid,5);//Даём инт. магазина
				SetCameraBehindPlayer(playerid);//Включаем управление камерой
			}
		}
	}
	return true;
}