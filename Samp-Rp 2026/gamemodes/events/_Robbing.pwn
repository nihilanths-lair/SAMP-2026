publics:_Robbing()
{
    //print("--> _Robbing()");

	for (new ac = 0; ac < 9; ac++) SetActorHealth(ActorsRob[ac], 255);
    new pl[10][8];
	foreach(i)
	{
		if (GetPlayerInterior(i) == 5)
		{
			if (PlayerToPoint(30,i,204.8515,-8.1603,1001.2109) && RobInts[i] == 3)// Victim SF
			{
           	 	if (cdrob[1] == false)
                {
            		switch (PTEMP[i][pMember])
            		{
						case 12: pl[1][0]++;
						case 13: pl[1][1]++;
						case 15: pl[1][2]++;
						case 17: pl[1][3]++;
						case 18: pl[1][4]++;
						default: continue;
            		}
		    		new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                	GetPlayerKeys(i, keys, updown, leftright);
    	    		if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    		{
						if (PTA != ActorsRob[4]) continue;
                		new PW = GetPlayerWeapon(i);
                		if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                		{
							if (pl[1][0] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
							else if (pl[1][1] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
							else if (pl[1][2] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
							else if (pl[1][3] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
							else if (pl[1][4] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[1] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",1);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 3, ActorsRob[4]);
                            	wantedsrobfriend(PTEMP[i][pMember], 1, 3);
                        	}
                        	else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                		}
            		}
            	}
            	continue;
			}
			else if (PlayerToPoint(30,i,204.8515,-8.1603,1001.2109) && RobInts[i] == 4) // Victim LS
			{
                if (cdrob[0] == false)
                {
            		switch (PTEMP[i][pMember])
            		{
						case 12: pl[0][0]++;
						case 13: pl[0][1]++;
						case 15: pl[0][2]++;
						case 17: pl[0][3]++;
						case 18: pl[0][4]++;
						default: continue;
            		}
		    		new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                	GetPlayerKeys(i, keys, updown, leftright);
    	    		if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    		{
                        if (PTA != ActorsRob[3]) continue;
                		new PW = GetPlayerWeapon(i);
                		if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                		{
							if (pl[0][0] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
							else if (pl[0][1] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
							else if (pl[0][2] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
							else if (pl[0][3] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
							else if (pl[0][4] > 1)
							{
                        		ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            	cdrob[0] = true;
                            	SetTimerEx("RobsEnabledCD", 1800000, false, "d",0);
                            	RobTickRTC[i] = 30;
                            	robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 0, PTEMP[i][pMember], 4, ActorsRob[3]);
                            	wantedsrobfriend(PTEMP[i][pMember], 0, 4);
                        	}
                        	else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                		}
            		}
            	}
            	continue;
			}
		}
		else if (PlayerToPoint(30,i,316.1089,-133.7254,999.6016) && RobInts[i] == 0)
		{
            if (cdrob[2] == false)
            {
            	switch (PTEMP[i][pMember])
            	{
					case 5: pl[2][5]++;
					case 6: pl[2][6]++;
					case 14: pl[2][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if (PTA != ActorsRob[2]) continue;
                	new PW = GetPlayerWeapon(i);
                	if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if (pl[2][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[2] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",2);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 0, ActorsRob[2]);
                            wantedsrobfriend(PTEMP[i][pMember], 2, 0);
                        }
						else if (pl[2][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[2] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",2);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 0, ActorsRob[2]);
                            wantedsrobfriend(PTEMP[i][pMember], 2, 0);
                        }
						else if (pl[2][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[2] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",2);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 0, ActorsRob[2]);
                            wantedsrobfriend(PTEMP[i][pMember], 2, 0);
                        }
                        else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                	}
            	}
            }
            continue;
		}
		else if (PlayerToPoint(30,i,295.4810,-40.2167,1001.5156) && RobInts[i] == 1)
		{
            if (cdrob[3] == false)
            {
            	switch (PTEMP[i][pMember])
            	{
					case 5: pl[3][5]++;
					case 6: pl[3][6]++;
					case 14: pl[3][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if (PTA != ActorsRob[1]) continue;
                	new PW = GetPlayerWeapon(i);
                    if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if (pl[3][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[3] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",3);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 1, ActorsRob[1]);
                            wantedsrobfriend(PTEMP[i][pMember], 3, 1);
                        }
						else if (pl[3][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[3] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",3);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 1, ActorsRob[1]);
                            wantedsrobfriend(PTEMP[i][pMember], 3, 1);
                        }
						else if (pl[3][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[3] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",3);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 1, ActorsRob[1]);
                            wantedsrobfriend(PTEMP[i][pMember], 3, 1);
                        }
                        else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                	}
            	}
            }
            continue;
		}
		else if (PlayerToPoint(30,i,296.8526,-82.5276,1001.5156) && RobInts[i] == 2)
		{
            if (cdrob[4] == false)
            {
            	switch (PTEMP[i][pMember])
            	{
					case 5: pl[4][5]++;
					case 6: pl[4][6]++;
					case 14: pl[4][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if (PTA != ActorsRob[0]) continue;
                	new PW = GetPlayerWeapon(i);
                	if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if (pl[4][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[4] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",4);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 2, ActorsRob[0]);
                            wantedsrobfriend(PTEMP[i][pMember], 4, 2);
                        }
						else if (pl[4][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[4] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",4);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 2, ActorsRob[0]);
                            wantedsrobfriend(PTEMP[i][pMember], 4, 2);
                        }
						else if (pl[4][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[4] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",4);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 1, PTEMP[i][pMember], 2, ActorsRob[0]);
                            wantedsrobfriend(PTEMP[i][pMember], 4, 2);
                        }
                        else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                	}
            	}
            }
            continue;
		}
		else if (PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 5) // [Bikers] - Medic SF
		{
            if (cdrob[5] == false)
            {
            	switch (PTEMP[i][pMember])
            	{
					case 24: pl[5][5]++;
					case 26: pl[5][6]++;
					case 29: pl[5][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if (PTA != ActorsRob[5]) continue;
                	new PW = GetPlayerWeapon(i);
                	if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if (pl[5][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[5] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",5);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 5, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 5, 5);
                        }
						else if (pl[5][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[5] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",5);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 5, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 5, 5);
                        }
						else if (pl[5][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[5] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",5);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 5, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 5, 5);
                        }
                        else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                	}
            	}
            }
            continue;
		}
		else if (PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 6) // [Bikers] - Medic LS
		{
            if (cdrob[6] == false)
            {
            	switch (PTEMP[i][pMember])
            	{
					case 24: pl[6][5]++;
					case 26: pl[6][6]++;
					case 29: pl[6][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if (PTA != ActorsRob[6]) continue;
                	new PW = GetPlayerWeapon(i);
                	if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if (pl[6][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[6] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",6);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 6, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 6, 6);
                        }
						else if (pl[6][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[6] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",6);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 6, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 6, 6);
                        }
						else if (pl[6][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[6] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",6);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 6, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 6, 6);
                        }
                        else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                	}
            	}
            }
            continue;
		}
		else if (PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 7) // [Bikers] - Medic LV
		{
            if (cdrob[7] == false)
            {
            	switch (PTEMP[i][pMember])
            	{
					case 24: pl[7][5]++;
					case 26: pl[7][6]++;
					case 29: pl[7][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if (PTA != ActorsRob[7]) continue;
                	new PW = GetPlayerWeapon(i);
                	if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if (pl[7][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[7] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",7);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 7, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 7, 7);
                        }
						else if (pl[7][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[7] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",7);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 7, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 7, 7);
                        }
						else if (pl[7][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[7] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",7);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 7, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 7, 7);
                        }
                        else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                	}
            	}
            }
            continue;
		}
		else if (PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 8) // [Bikers] - Medic FC
		{
            if (cdrob[8] == false)
            {
            	switch (PTEMP[i][pMember])
            	{
					case 24: pl[8][5]++;
					case 26: pl[8][6]++;
					case 29: pl[8][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if (PTA != ActorsRob[8]) continue;
                	new PW = GetPlayerWeapon(i);
                	if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if (pl[8][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[8] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",8);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 8, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 8, 8);
                        }
						else if (pl[8][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[8] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",8);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 8, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 8, 8);
                        }
						else if (pl[8][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[8] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",8);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 8, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 8, 8);
                        }
                        else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                	}
            	}
            }
            continue;
		}
		else if (PlayerToPoint(30,i,298.4895,180.3188,1214.7949) && RobInts[i] == 9) // [Bikers] - Medic LS Ghetto
		{
            if (cdrob[9] == false)
            {
            	switch (PTEMP[i][pMember])
            	{
					case 24: pl[9][5]++;
					case 26: pl[9][6]++;
					case 29: pl[9][7]++;
					default: continue;
            	}
		    	new PTA = GetPlayerCameraTargetActor(i), keys, updown, leftright;
                GetPlayerKeys(i, keys, updown, leftright);
    	    	if (PTA != INVALID_ACTOR_ID && keys & KEY_AIM)
    	    	{
                    if (PTA != ActorsRob[9]) continue;
                	new PW = GetPlayerWeapon(i);
                	if (PW == 23 || PW == 24 || PW == 25 || PW == 29 || PW == 30 || PW == 31 || PW == 32)
                	{
						if (pl[9][5] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[9] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",9);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 9, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 9, 9);
                        }
						else if (pl[9][6] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[9] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",9);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 9, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 9, 9);
                        }
						else if (pl[9][7] > 1)
						{
                        	ApplyActorAnimation(PTA, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
                            cdrob[9] = true;
                            SetTimerEx("RobsEnabledCD", 1800000, false, "d",9);
                            RobTickRTC[i] = 30;
                            robscdtimer[i] = SetTimerEx("_RobTickRTSC", 1000, true, "ddddi", i, 2, PTEMP[i][pMember], 9, PTA);
                            wantedsrobfriend(PTEMP[i][pMember], 9, 9);
                        }
                        else SendClientMessage(i, COLOR_GREY, " ƒл€ начала ограблени€ нужно минимум 2 напарника");
                	}
            	}
            }
            continue;
		}
	}
	
    //print("<-- _Robbing()");
}