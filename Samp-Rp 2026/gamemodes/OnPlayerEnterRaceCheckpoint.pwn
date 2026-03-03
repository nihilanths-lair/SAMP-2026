public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(SERVERTEST) SendMes(playerid,COLOR_BLUE,"CHECKPOINT: RACECHECKPOINT - %i",playerid);
	if(GetTickCount() - GetPVarInt(playerid,"entercheckpoint") <= 500) return CheatKick(playerid,003);
	SetPVarInt(playerid,"entercheckpoint", GetTickCount());
	if(CP[playerid] == 776) GameTextForPlayer(playerid, "~r~Point Is Established", 3000, 1),CP[playerid] = 0;
	DisablePlayerRaceCheckpoint(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(GetPVarInt(playerid,"gonka") > 0 && race_info[1] == 3)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPVarInt(playerid,"gonkaid",GetPVarInt(playerid,"gonkaid")+1);
			if(GetPVarInt(playerid,"gonkaid") == 32)
			{
				if(RaceList < 2)
				{
					SendMes(playerid,COLOR_BLUE," Поздравляем! Вы заняли %i место!",RaceList+1);
					switch(booston)
					{
					case 0:
						{
							format(string,32,"~g~+$%i",15000-(RaceList*5000));
							GameTextForPlayer(playerid,string, 5000, 1);
							PTEMP[playerid][pCash] += 15000-(RaceList*5000);
						}
					case 1:
						{
							format(string,32,"~g~+$%i",45000-(RaceList*15000));
							GameTextForPlayer(playerid,string, 5000, 1);
							PTEMP[playerid][pCash] += 45000-(RaceList*15000);
						}
					}
				}
				SetPlayerInterior(playerid,3);
				SetPlayerPos(playerid,831.7769,6.8750,1004.1797);
				SetPlayerFacingAngle(playerid,108.1610);
				strmid(RaceInfo[RaceList][rName],PTEMP[playerid][pName], 0, strlen(PTEMP[playerid][pName]), 32);
				RaceList++;
				DestroyVehicle(RaceInfo[GetPVarInt(playerid,"gonka")-1][rCar]);
				return DeletePVar(playerid,"gonka");
			}
			if(GetPVarInt(playerid,"gonkaid") != 31) SetPlayerRaceCheckpoint(playerid, 0, RaceGonka[GetPVarInt(playerid,"gonkaid")][0x0],RaceGonka[GetPVarInt(playerid,"gonkaid")][0x1],RaceGonka[GetPVarInt(playerid,"gonkaid")][0x2],RaceGonka[GetPVarInt(playerid,"gonkaid")+1][0x0],RaceGonka[GetPVarInt(playerid,"gonkaid")+1][0x1],RaceGonka[GetPVarInt(playerid,"gonkaid")+1][0x2], 8.0);
			else SetPlayerRaceCheckpoint(playerid, 1, RaceGonka[GetPVarInt(playerid,"gonkaid")][0x0],RaceGonka[GetPVarInt(playerid,"gonkaid")][0x1],RaceGonka[GetPVarInt(playerid,"gonkaid")][0x2],0.0,0.0,0.0,8.0);
			format(string,64,"~g~~w~%i / 32~g~",GetPVarInt(playerid,"gonkaid")); GameTextForPlayer(playerid,string, 5000, 4);
		}
		if(GetPVarInt(playerid,"farm_status") == 5)
		{
			SetPVarInt(playerid,"farm_combine", GetPVarInt(playerid,"farm_combine")+1);
			switch(GetPVarInt(playerid,"farm_id"))
			{
			case 1:
				{
					if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_one))
					{
						if((FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] - 5000) >= 0)
						{
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = 5000;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]-=5000;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}5000. {1E5580}Зерна на складе {FFFFFF}%i / 10000",FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						else
						{
						    new null = FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain];
						    FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = null;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] = 0;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}%i. {1E5580}Зерна на складе {FFFFFF}%i / 10000",null, FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						DeletePVar(playerid,"farm_status");
						DeletePVar(playerid,"farm_combine");
					}
					else if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_one)-1) SetPlayerRaceCheckpoint(playerid,1,Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")][2],0,0,0,5.0);
					else SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")+1][0],Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")+1][1],Farmcombine_coord_one[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				}
			case 2:
				{
					if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_two))
					{
						if((FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] - 5000) >= 0)
						{
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = 5000;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]-=5000;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}5000. {1E5580}Зерна на складе {FFFFFF}%i / 10000",FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						else
						{
						    new null = FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain];
						    FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = null;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] = 0;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}%i. {1E5580}Зерна на складе {FFFFFF}%i / 10000",null, FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						DeletePVar(playerid,"farm_status");
						DeletePVar(playerid,"farm_combine");
					}
					else if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_two)-1) SetPlayerRaceCheckpoint(playerid,1,Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")][2],0,0,0,5.0);
					else SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")+1][0],Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")+1][1],Farmcombine_coord_two[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				}
			case 3:
				{
					if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_three))
					{
						if((FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] - 5000) >= 0)
						{
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = 5000;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]-=5000;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}5000. {1E5580}Зерна на складе {FFFFFF}%i / 10000",FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						else
						{
						    new null = FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain];
						    FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = null;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] = 0;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}%i. {1E5580}Зерна на складе {FFFFFF}%i / 10000",null, FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						DeletePVar(playerid,"farm_status");
						DeletePVar(playerid,"farm_combine");
					}
					else if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_three)-1) SetPlayerRaceCheckpoint(playerid,1,Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")][2],0,0,0,5.0);
					else SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")+1][0],Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")+1][1],Farmcombine_coord_three[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				}
			case 4:
				{
					if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_four))
					{
						if((FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] - 5000) >= 0)
						{
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = 5000;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]-=5000;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}5000. {1E5580}Зерна на складе {FFFFFF}%i / 10000",FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						else
						{
						    new null = FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain];
						    FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = null;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] = 0;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}%i. {1E5580}Зерна на складе {FFFFFF}%i / 10000",null, FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						DeletePVar(playerid,"farm_status");
						DeletePVar(playerid,"farm_combine");
					}
					else if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_four)-1) SetPlayerRaceCheckpoint(playerid,1,Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")][2],0,0,0,5.0);
					else SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")+1][0],Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")+1][1],Farmcombine_coord_four[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				}
			case 5:
				{
					if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_five))
					{
						if((FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] - 5000) >= 0)
						{
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = 5000;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]-=5000;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}5000. {1E5580}Зерна на складе {FFFFFF}%i / 10000",FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						else
						{
						    new null = FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain];
						    FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain_Sown] = null;
							FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain] = 0;
							SendMes(playerid, -1," {1E5580}Поле засеяно на {FFFFFF}%i. {1E5580}Зерна на складе {FFFFFF}%i / 10000",null, FarmInfo[GetPVarInt(playerid,"farm_id")][fGrain]);
						}
						DeletePVar(playerid,"farm_status");
						DeletePVar(playerid,"farm_combine");
					}
					else if(GetPVarInt(playerid,"farm_combine") == sizeof(Farmcombine_coord_five)-1) SetPlayerRaceCheckpoint(playerid,1,Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")][2],0,0,0,5.0);
					else SetPlayerRaceCheckpoint(playerid,0,Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")][0],Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")][1],Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")][2],Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")+1][0],Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")+1][1],Farmcombine_coord_five[GetPVarInt(playerid,"farm_combine")+1][2],5.0);
				}
			}
		}
		if(GetPVarInt(playerid,"farm_status") == 3)
		{
			new car;
			for(new i = 0; i <= TOTALFARM; i++) if(GetPlayerVehicleID(playerid) >= FarmInfo[i][fSeed_Car][0] && GetPlayerVehicleID(playerid) <= FarmInfo[i][fSeed_Car][1]) car = i;
			if(car == 0) return Kick(playerid);
			/*switch(car)
			{
				case 1: for(car = 0; car < sizeof(Farmcar_coord_one); car++) if(!PlayerToPoint(10.0, playerid, Farmcar_coord_one[car][0], Farmcar_coord_one[car][1], Farmcar_coord_one[car][2])) return true;
				case 2: for(car = 0; car < sizeof(Farmcar_coord_two); car++) if(!PlayerToPoint(10.0, playerid, Farmcar_coord_two[car][0], Farmcar_coord_two[car][1], Farmcar_coord_two[car][2])) return true;
				case 3: for(car = 0; car < sizeof(Farmcar_coord_three); car++) if(!PlayerToPoint(10.0, playerid, Farmcar_coord_three[car][0], Farmcar_coord_three[car][1], Farmcar_coord_three[car][2])) return true;
				case 4: for(car = 0; car < sizeof(Farmcar_coord_four); car++) if(!PlayerToPoint(10.0, playerid, Farmcar_coord_four[car][0], Farmcar_coord_four[car][1], Farmcar_coord_four[car][2])) return true;
				case 5: for(car = 0; car < sizeof(Farmcar_coord_five); car++) if(!PlayerToPoint(10.0, playerid, Farmcar_coord_five[car][0], Farmcar_coord_five[car][1], Farmcar_coord_five[car][2])) return true;
			}*/
			TogglePlayerControllable(playerid, 0);
			SCM(playerid,COLOR_YELLOW," Пожалуйста подождите");
			GetVehiclePos(GetPlayerVehicleID(playerid), car_coord[GetPlayerVehicleID(playerid)][0], car_coord[GetPlayerVehicleID(playerid)][1], car_coord[GetPlayerVehicleID(playerid)][2]);
			GetVehicleZAngle(GetPlayerVehicleID(playerid),car_coord[GetPlayerVehicleID(playerid)][3]);
			GetXYInBackOfPlayer(playerid, car_coord[GetPlayerVehicleID(playerid)][0], car_coord[GetPlayerVehicleID(playerid)][1],3.0);
			return SetTimerEx("Farmduty" , 2000, false, "i", playerid);
		}
		if(LessonCar[playerid] == 1)
		{
			switch(pLessonCar[playerid])
			{
			case CHECKPOINT_1:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_3;
					SetPlayerRaceCheckpoint(playerid, 0,-2047.3120,-82.8890,34.9072,-2047.3120,-82.8890,34.9072, 5.0);
				}
			case CHECKPOINT_3:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_4;
					SetPlayerRaceCheckpoint(playerid, 0,-2020.2249,-72.4633,34.9145,-2004.6350,-55.5920,34.9081, 5.0);
				}
			case CHECKPOINT_4:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_5;
					SetPlayerRaceCheckpoint(playerid, 0,-2004.6350,-55.5920,34.9081,-2004.0828,63.9897,29.0385, 5.0);
				}
			case CHECKPOINT_5:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_6;
					SetPlayerRaceCheckpoint(playerid, 0,-2004.0828,63.9897,29.0385,-2004.9127,159.6589,27.2818, 5.0);
				}
			case CHECKPOINT_6:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_7;
					SetPlayerRaceCheckpoint(playerid, 0,-2004.9127,159.6589,27.2818,-2022.3209,172.0152,28.4565, 5.0);
				}
			case CHECKPOINT_7:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_8;
					SetPlayerRaceCheckpoint(playerid, 0,-2022.3209,172.0152,28.4565,-2029.9869,156.7025,28.5793, 5.0);
				}
			case CHECKPOINT_8:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_9;
					SetPlayerRaceCheckpoint(playerid, 0,-2029.9869,156.7025,28.5793,-2017.3555,138.1394,27.6932, 5.0);
				}
			case CHECKPOINT_9:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_10;
					SetPlayerRaceCheckpoint(playerid, 0,-2017.3555,138.1394,27.6932,-2003.2570,159.9656,27.2823, 5.0);
				}
			case CHECKPOINT_10:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_11;
					SetPlayerRaceCheckpoint(playerid, 0,-2003.2570,159.9656,27.2823,-2000.3943,288.7868,33.7211, 5.0);
				}
			case CHECKPOINT_11:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_13;//
					SetPlayerRaceCheckpoint(playerid, 0,-2000.3943,288.7868,33.7211,-2021.0210,321.9275,34.7585, 5.0);
				}
			case CHECKPOINT_13:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_14;//
					SetPlayerRaceCheckpoint(playerid, 0,-2021.0210,321.9275,34.7585,-2239.3616,321.8053,34.9154, 5.0);
				}
			case CHECKPOINT_14:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_15;//
					SetPlayerRaceCheckpoint(playerid, 0,-2239.3616,321.8053,34.9154,-2254.4856,298.3696,34.9073, 5.0);
				}
			case CHECKPOINT_15:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_16;//
					SetPlayerRaceCheckpoint(playerid, 0,-2254.4856,298.3696,34.9073,-2259.3555,-59.4185,34.9898, 5.0);
				}
			case CHECKPOINT_16:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_17;//
					SetPlayerRaceCheckpoint(playerid, 0,-2259.3555,-59.4185,34.9898,-2409.8345,-67.7337,35.0145, 5.0);
				}
			case CHECKPOINT_17:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_18;//
					SetPlayerRaceCheckpoint(playerid, 0,-2409.8345,-67.7337,35.0145,-2423.4453,-116.1348,35.0505, 5.0);
				}
			case CHECKPOINT_18:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_19;//
					SetPlayerRaceCheckpoint(playerid, 0,-2423.4453,-116.1348,35.0505,-2430.5403,-197.4688,35.0630, 5.0);
				}
			case CHECKPOINT_19:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_20;//
					SetPlayerRaceCheckpoint(playerid, 0,-2430.5403,-197.4688,35.0630,-2512.2915,-207.9353,24.7875, 5.0);
				}
			case CHECKPOINT_20:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_21;//
					SetPlayerRaceCheckpoint(playerid, 0,-2512.2915,-207.9353,24.7875,-2698.0916,-208.0479,3.9219, 5.0);
				}
			case CHECKPOINT_21:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_22;//
					SetPlayerRaceCheckpoint(playerid, 0,-2698.0916,-208.0479,3.9219,-2704.1455,-177.0296,3.9226, 5.0);
				}
			case CHECKPOINT_22:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_23;//
					SetPlayerRaceCheckpoint(playerid, 0,-2704.1455,-177.0296,3.9226,-2703.7417,129.7518,3.9227, 5.0);
				}
			case CHECKPOINT_23:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_24;//
					SetPlayerRaceCheckpoint(playerid, 0,-2703.7417,129.7518,3.9227,-2704.3784,324.0871,3.9407, 5.0);
				}
			case CHECKPOINT_24:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_25;//
					SetPlayerRaceCheckpoint(playerid, 0,-2704.3784,324.0871,3.9407,-2687.5083,333.3723,3.9292, 5.0);
				}
			case CHECKPOINT_25:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_26;//
					SetPlayerRaceCheckpoint(playerid, 0,-2687.5083,333.3723,3.9292,-2660.8440,347.2428,3.9233, 5.0);
				}
			case CHECKPOINT_26:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_27;//
					SetPlayerRaceCheckpoint(playerid, 0,-2660.8440,347.2428,3.9233,-2660.1770,402.8072,3.8754, 5.0);
				}
			case CHECKPOINT_27:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_28;//
					SetPlayerRaceCheckpoint(playerid, 0,-2660.1770,402.8072,3.8754,-2695.0830,417.7195,3.8885, 5.0);
				}
			case CHECKPOINT_28:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_29;//
					SetPlayerRaceCheckpoint(playerid, 0,-2695.0830,417.7195,3.8885,-2703.8547,455.9360,3.9302, 5.0);
				}
			case CHECKPOINT_29:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_30;//
					SetPlayerRaceCheckpoint(playerid, 0,-2703.8547,455.9360,3.9302,-2747.8162,554.4193,14.1497, 5.0);
				}
			case CHECKPOINT_30:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_31;//
					SetPlayerRaceCheckpoint(playerid, 0,-2747.8162,554.4193,14.1497,-2671.2651,562.7997,14.2034, 5.0);
				}
			case CHECKPOINT_31:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_32;//
					SetPlayerRaceCheckpoint(playerid, 0,-2671.2651,562.7997,14.2034,-2538.5269,562.7781,14.2080, 5.0);
				}
			case CHECKPOINT_32:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_33;//
					SetPlayerRaceCheckpoint(playerid, 0,-2538.5269,562.7781,14.2080,-2525.4382,600.6388,21.0344, 5.0);
				}
			case CHECKPOINT_33:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_34;//
					SetPlayerRaceCheckpoint(playerid, 0,-2525.4382,600.6388,21.0344,-2523.5493,815.4084,49.6125, 5.0);
				}
			case CHECKPOINT_34:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_35;//
					SetPlayerRaceCheckpoint(playerid, 0,-2523.5493,815.4084,49.6125,-2524.7771,1012.3589,77.9656, 5.0);
				}
			case CHECKPOINT_35:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_36;//
					SetPlayerRaceCheckpoint(playerid, 0,-2524.7771,1012.3589,77.9656,-2519.0784,1102.1168,55.3142, 5.0);
				}
			case CHECKPOINT_36:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_37;//
					SetPlayerRaceCheckpoint(playerid, 0,-2519.0784,1102.1168,55.3142,-2543.8076,1121.2388,55.3183, 5.0);
				}
			case CHECKPOINT_37:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_38;//
					SetPlayerRaceCheckpoint(playerid, 0,-2543.8076,1121.2388,55.3183,-2654.0317,1195.3846,55.1729, 5.0);
				}
			case CHECKPOINT_38:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_40;//
					SetPlayerRaceCheckpoint(playerid, 0,-2654.0317,1195.3846,55.1729,-2534.5251,1185.9242,42.3106, 5.0);
				}
			case CHECKPOINT_40:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_41;//
					SetPlayerRaceCheckpoint(playerid, 0,-2534.5251,1185.9242,42.3106,-2454.5630,1222.4424,34.7949, 5.0);
				}
			case CHECKPOINT_41:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_42;//
					SetPlayerRaceCheckpoint(playerid, 0,-2454.5630,1222.4424,34.7949,-2453.9104,1363.3192,6.7814, 5.0);
				}
			case CHECKPOINT_42:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_43;//
					SetPlayerRaceCheckpoint(playerid, 0,-2453.9104,1363.3192,6.7814,-2327.0271,1363.4899,6.7821, 5.0);
				}
			case CHECKPOINT_43:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_44;//
					SetPlayerRaceCheckpoint(playerid, 0,-2327.0271,1363.4899,6.7821,-2280.0376,1333.7422,6.7823, 5.0);
				}
			case CHECKPOINT_44:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_45;//
					SetPlayerRaceCheckpoint(playerid, 0,-2280.0376,1333.7422,6.7823,-2061.0693,1305.2551,6.8781, 5.0);
				}
			case CHECKPOINT_45:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_46;//
					SetPlayerRaceCheckpoint(playerid, 0,-2061.0693,1305.2551,6.8781,-2009.4646,1285.4056,6.7899, 5.0);
				}
			case CHECKPOINT_46:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_47;//
					SetPlayerRaceCheckpoint(playerid, 0,-2009.4646,1285.4056,6.7899,-1912.2991,1291.7936,6.7814, 5.0);
				}
			case CHECKPOINT_47:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_48;//
					SetPlayerRaceCheckpoint(playerid, 0,-1912.2991,1291.7936,6.7814,-1760.2518,1337.8812,6.7821, 5.0);
				}
			case CHECKPOINT_48:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_49;//
					SetPlayerRaceCheckpoint(playerid, 0,-1760.2518,1337.8812,6.7821,-1639.5083,1216.5533,6.7822, 5.0);
				}
			case CHECKPOINT_49:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_50;//
					SetPlayerRaceCheckpoint(playerid, 0,-1639.5083,1216.5533,6.7822,-1607.8207,1030.2471,6.7816, 5.0);
				}
			case CHECKPOINT_50:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_51;//
					SetPlayerRaceCheckpoint(playerid, 0,-1607.8207,1030.2471,6.7816,-1563.3192,814.5651,6.7817, 5.0);
				}
			case CHECKPOINT_51:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_52;//
					SetPlayerRaceCheckpoint(playerid, 0,-1563.3192,814.5651,6.7817,-1563.3192,743.6430,6.7820, 5.0);
				}
			case CHECKPOINT_52:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_53;//
					SetPlayerRaceCheckpoint(playerid, 0,-1563.3192,743.6430,6.7820,-1703.4800,735.9361,24.4788, 5.0);
				}
			case CHECKPOINT_53:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_54;//
					SetPlayerRaceCheckpoint(playerid, 0,-1703.4800,735.9361,24.4788,-1716.9756,700.5042,24.4776, 5.0);
				}
			case CHECKPOINT_54:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_55;//
					SetPlayerRaceCheckpoint(playerid, 0,-1716.9756,700.5042,24.4776,-1823.9097,610.2460,34.7587, 5.0);
				}
			case CHECKPOINT_55:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_56;//
					SetPlayerRaceCheckpoint(playerid, 0,-1823.9097,610.2460,34.7587,-1993.1875,609.6210,34.7618, 5.0);
				}
			case CHECKPOINT_56:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_57;//
					SetPlayerRaceCheckpoint(playerid, 0,-1993.1875,609.6210,34.7618,-2007.4740,530.2824,34.7916, 5.0);
				}
			case CHECKPOINT_57:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_58;//
					SetPlayerRaceCheckpoint(playerid, 0,-2007.4740,530.2824,34.7916,-2008.0841,466.2849,34.7550, 5.0);
				}
			case CHECKPOINT_58:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_59;//
					SetPlayerRaceCheckpoint(playerid, 0,-2008.0841,466.2849,34.7550,-2009.4291,191.2641,27.2783, 5.0);
				}
			case CHECKPOINT_59:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_60;//
					SetPlayerRaceCheckpoint(playerid, 0,-2009.4291,191.2641,27.2783,-2009.0417,-13.3749,34.3996, 5.0);
				}
			case CHECKPOINT_60:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_61;//
					SetPlayerRaceCheckpoint(playerid, 0,-2009.0417,-13.3749,34.3996,-2008.8506,-57.0414,34.9097, 5.0);
				}
			case CHECKPOINT_61:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_62;//
					SetPlayerRaceCheckpoint(playerid, 0,-2008.8506,-57.0414,34.9097,-2036.2216,-67.9920,34.9151, 5.0);
				}
			case CHECKPOINT_62:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_63;//
					SetPlayerRaceCheckpoint(playerid, 0,-2036.2216,-67.9920,34.9151,-2047.7125,-81.9187,34.9092, 5.0);
				}
			case CHECKPOINT_63:
				{
					LessonStat[playerid]++;
					pLessonCar[playerid] = CHECKPOINT_64;
					SetPlayerRaceCheckpoint(playerid, 1,-2047.7125,-81.9187,34.9092,0.0,0.0,0.0, 5.0);
				}
			case CHECKPOINT_64:
				{
					new Float:health;
					GetVehicleHealth(GetPlayerVehicleID(playerid),health);
					if (health >= 850)
					{
						SCM(playerid, COLOR_GREEN, "Припаркуйте автомобиль и пройдите в здание автошколы");
						SetPVarInt(playerid,"givecarlic",1);
						DisablePlayerRaceCheckpoint(playerid);
					}
					else
					{
						SCM(playerid, COLOR_GREEN, "Припаркуйте автомобиль и пройдите в здание автошколы");
						SetPVarInt(playerid,"givecarlic",2);
						DisablePlayerRaceCheckpoint(playerid);
					}
				}
			}
		}
		if(GetPVarInt(playerid, "TypeBus") > 0)
		{
			new type = GetPVarInt(playerid, "TypeBus"), e_type, name[35];
			switch(GetPVarInt(playerid, "TypeBus"))
			{
			case 1: name = "ВнутриГородской ЛС";
			case 2: name = "ВнутриГородской СФ";
			case 3: name = "ВнутриГородской ЛВ";
			case 4: name = "АвтоВокзал LS << >> Автошкола SF";
			case 5: name = "АвтоВокзал LS << >> АвтоВокзал LV";
			case 6: name = "АвтоВокзал LS << >> Заводы";
			}
			if(type == 1)
			{
				if(pPressed[playerid] == 7 || pPressed[playerid] == 16 || pPressed[playerid] == 24 || pPressed[playerid] == 38 || pPressed[playerid] == 66 || pPressed[playerid] == 74 || pPressed[playerid] == 88 || pPressed[playerid] == 107  || pPressed[playerid] == 111|| pPressed[playerid] == 132)
				{
					if(GetPVarInt(playerid, "BusStop") == 0)
					{
						SetPVarInt(playerid, "TimeBus", 11);
						SCM(playerid, 0x33aa33ff, " Остановка! Ждите пассажиров");
						format(string, 90, " Автобус отъезжает через 10 секунд");
						ProxDetector(30.0, playerid, string, 0x33aa33ff,0x33aa33ff,0x33aa33ff,0x33aa33ff,0x33aa33ff);
					}
					else
					{
						if(pPressed[playerid] == 128) pPressed[playerid] = 0;
						else pPressed[playerid]++;
						new i = pPressed[playerid];
						SetPlayerRaceCheckpoint(playerid,0,BusCityLS[i][0],BusCityLS[i][1],BusCityLS[i][2],BusCityLS[i][3],BusCityLS[i][4],BusCityLS[i][5],7.0);
						SetPVarInt(playerid, "BusStop", 0);
					}
				}
				else
				{
					pPressed[playerid]++;
					SetPVarInt(playerid, "BusMoney", GetPVarInt(playerid, "BusMoney") + 50);
					PTEMP[playerid][pPayCheck] += 50;
					if(pPressed[playerid] == 7 || pPressed[playerid] == 16 || pPressed[playerid] == 24 || pPressed[playerid] == 38 || pPressed[playerid] == 66 || pPressed[playerid] == 74 || pPressed[playerid] == 88 || pPressed[playerid] == 107  || pPressed[playerid] == 111|| pPressed[playerid] == 132) e_type = 1;
					else e_type = 0;
					new i = pPressed[playerid];
					SetPlayerRaceCheckpoint(playerid,e_type,BusCityLS[i][0],BusCityLS[i][1],BusCityLS[i][2],BusCityLS[i][3],BusCityLS[i][4],BusCityLS[i][5],7.0);
				}
			}
			if(type == 2) // 9, 46, 82 / 91
			{
				if(pPressed[playerid] == 3 || pPressed[playerid] == 10 || pPressed[playerid] == 20 || pPressed[playerid] == 32 || pPressed[playerid] == 35 || pPressed[playerid] == 40 || pPressed[playerid] == 46 || pPressed[playerid] == 53 || pPressed[playerid] == 56)
				{
					if(GetPVarInt(playerid, "BusStop") == 0)
					{
						SetPVarInt(playerid, "TimeBus", 11);
						SCM(playerid, 0x33aa33ff, " Остановка! Ждите пассажиров");
						format(string, 90, " Автобус отъезжает через 10 секунд");
						ProxDetector(30.0, playerid, string, 0x33aa33ff,0x33aa33ff,0x33aa33ff,0x33aa33ff,0x33aa33ff);
					}
					else
					{
						if(pPressed[playerid] == 56) pPressed[playerid] = 0;
						else pPressed[playerid]++;
						new i = pPressed[playerid];
						SetPlayerRaceCheckpoint(playerid,0,BusCitySF[i][0],BusCitySF[i][1],BusCitySF[i][2],BusCitySF[i][3],BusCitySF[i][4],BusCitySF[i][5],7.0);
						SetPVarInt(playerid, "BusStop", 0);
					}
				}
				else
				{
					pPressed[playerid]++;
					SetPVarInt(playerid, "BusMoney", GetPVarInt(playerid, "BusMoney") + 70);
					PTEMP[playerid][pPayCheck] += 70;
					if(pPressed[playerid] == 3 || pPressed[playerid] == 10 || pPressed[playerid] == 20 || pPressed[playerid] == 32 || pPressed[playerid] == 35 || pPressed[playerid] == 40 || pPressed[playerid] == 46 || pPressed[playerid] == 53 || pPressed[playerid] == 56) e_type = 1;
					else e_type = 0;
					new i = pPressed[playerid];
					SetPlayerRaceCheckpoint(playerid,e_type,BusCitySF[i][0],BusCitySF[i][1],BusCitySF[i][2],BusCitySF[i][3],BusCitySF[i][4],BusCitySF[i][5],7.0);
				}
			}
			if(type == 3)
			{
				if(pPressed[playerid] == 7 || pPressed[playerid] == 10 || pPressed[playerid] == 18 || pPressed[playerid] == 24 || pPressed[playerid] == 32 || pPressed[playerid] == 39 || pPressed[playerid] == 51 || pPressed[playerid] == 64 || pPressed[playerid] == 71  || pPressed[playerid] == 79)
				{
					if(GetPVarInt(playerid, "BusStop") == 0)
					{
						SetPVarInt(playerid, "TimeBus", 11);
						SCM(playerid, 0x33aa33ff, " Остановка! Ждите пассажиров");
						format(string, 90, " Автобус отъезжает через 10 секунд");
						ProxDetector(30.0, playerid, string, 0x33aa33ff,0x33aa33ff,0x33aa33ff,0x33aa33ff,0x33aa33ff);
					}
					else
					{
						if(pPressed[playerid] == 79) pPressed[playerid] = 0;
						else pPressed[playerid]++;
						new i = pPressed[playerid];
						SetPlayerRaceCheckpoint(playerid,0,BusCityLV[i][0],BusCityLV[i][1],BusCityLV[i][2],BusCityLV[i][3],BusCityLV[i][4],BusCityLV[i][5],7.0);
						SetPVarInt(playerid, "BusStop", 0);
					}
				}
				else
				{
					pPressed[playerid]++;
					SetPVarInt(playerid, "BusMoney", GetPVarInt(playerid, "BusMoney") + 60);
					PTEMP[playerid][pPayCheck] += 60;
					if(pPressed[playerid] == 7 || pPressed[playerid] == 10 || pPressed[playerid] == 18 || pPressed[playerid] == 24 || pPressed[playerid] == 32 || pPressed[playerid] == 39 || pPressed[playerid] == 51 || pPressed[playerid] == 64 || pPressed[playerid] == 71 || pPressed[playerid] == 79) e_type = 1;
					else e_type = 0;
					new i = pPressed[playerid];
					SetPlayerRaceCheckpoint(playerid,e_type,BusCityLV[i][0],BusCityLV[i][1],BusCityLV[i][2],BusCityLV[i][3],BusCityLV[i][4],BusCityLV[i][5],7.0);
				}
			}
			if(type == 4)
			{
				if(pPressed[playerid] == 0 || pPressed[playerid] == 8 || pPressed[playerid] == 45 || pPressed[playerid] == 48 || pPressed[playerid] == 52 || pPressed[playerid] == 86|| pPressed[playerid] == 96)
				{
					if(GetPVarInt(playerid, "BusStop") == 0)
					{
						SetPVarInt(playerid, "TimeBus", 11);
						SCM(playerid, COLOR_GREEN, " Остановите автобус и подождите пассажиров!");
						format(string, 90, " Автобус АвтоВокзал LS << >> Автошкола SF  отъезжает через 10 секунд");
						ProxDetector(30.0, playerid, string, COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN);
					}
					else
					{
						if(pPressed[playerid] == 95) pPressed[playerid] = 0;
						else pPressed[playerid]++;
						new i = pPressed[playerid];
						SetPlayerRaceCheckpoint(playerid,0,BusSchool[i][0],BusSchool[i][1],BusSchool[i][2],BusSchool[i][3],BusSchool[i][4],BusSchool[i][5],7.0);
						SetPVarInt(playerid, "BusStop", 0);
					}
				}
				else
				{
					pPressed[playerid]++;
					SetPVarInt(playerid, "BusMoney", GetPVarInt(playerid, "BusMoney") + 40);
					PTEMP[playerid][pPayCheck] += 40;
					if(pPressed[playerid] == 0 || pPressed[playerid] == 8 || pPressed[playerid] == 45 || pPressed[playerid] == 48 || pPressed[playerid] == 52 || pPressed[playerid] == 86|| pPressed[playerid] == 96) e_type = 1;
					else e_type = 0;
					new i = pPressed[playerid];
					SetPlayerRaceCheckpoint(playerid,e_type,BusSchool[i][0],BusSchool[i][1],BusSchool[i][2],BusSchool[i][3],BusSchool[i][4],BusSchool[i][5],7.0);
				}
			}
			if(type == 5)
			{
				if(pPressed[playerid] == 0 || pPressed[playerid] == 10 || pPressed[playerid] == 36  || pPressed[playerid] == 60 || pPressed[playerid] == 69)
				{
					if(GetPVarInt(playerid, "BusStop") == 0)
					{
						SetPVarInt(playerid, "TimeBus", 11);
						SCM(playerid, COLOR_GREEN, " Остановите автобус и подождите пассажиров!");
						format(string, 90, " Автобус АвтоВокзал LS << >> АвтоВокзал LV отъезжает через 10 секунд");
						ProxDetector(30.0, playerid, string, COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN);
					}
					else
					{
						if(pPressed[playerid] == 69) pPressed[playerid] = 0;
						else pPressed[playerid]++;
						new i = pPressed[playerid];
						SetPlayerRaceCheckpoint(playerid,0,BusLSLV[i][0],BusLSLV[i][1],BusLSLV[i][2],BusLSLV[i][3],BusLSLV[i][4],BusLSLV[i][5],7.0);
						SetPVarInt(playerid, "BusStop", 0);
					}
				}
				else
				{
					pPressed[playerid]++;
					SetPVarInt(playerid, "BusMoney", GetPVarInt(playerid, "BusMoney") + 60);
					PTEMP[playerid][pPayCheck] += 60;
					if(pPressed[playerid] == 0 || pPressed[playerid] == 10 || pPressed[playerid] == 36  || pPressed[playerid] == 60 || pPressed[playerid] == 69) e_type = 1;
					else e_type = 0;
					new i = pPressed[playerid];
					SetPlayerRaceCheckpoint(playerid,e_type,BusLSLV[i][0],BusLSLV[i][1],BusLSLV[i][2],BusLSLV[i][3],BusLSLV[i][4],BusLSLV[i][5],7.0);
				}
			}
			if(type == 6)
			{
				if(pPressed[playerid] == 0 || pPressed[playerid] == 10 || pPressed[playerid] == 36  || pPressed[playerid] == 60 || pPressed[playerid] == 69)
				{
					if(GetPVarInt(playerid, "BusStop") == 0)
					{
						SetPVarInt(playerid, "TimeBus", 11);
						SCM(playerid, COLOR_GREEN, " Остановите автобус и подождите пассажиров!");
						format(string, 90, " Автобус АвтоВокзал LS << >> Заводы отъезжает через 10 секунд");
						ProxDetector(30.0, playerid, string, COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN);
					}
					else
					{
						if(pPressed[playerid] == 69) pPressed[playerid] = 0;
						else pPressed[playerid]++;
						new i = pPressed[playerid];
						SetPlayerRaceCheckpoint(playerid,0,BusLSZavodi[i][0],BusLSZavodi[i][1],BusLSZavodi[i][2],BusLSZavodi[i][3],BusLSZavodi[i][4],BusLSZavodi[i][5],7.0);
						SetPVarInt(playerid, "BusStop", 0);
					}
				}
				else
				{
					pPressed[playerid]++;
					SetPVarInt(playerid, "BusMoney", GetPVarInt(playerid, "BusMoney") + 60);
					PTEMP[playerid][pPayCheck] += 60;
					if(pPressed[playerid] == 0 || pPressed[playerid] == 10 || pPressed[playerid] == 36  || pPressed[playerid] == 60 || pPressed[playerid] == 69) e_type = 1;
					else e_type = 0;
					new i = pPressed[playerid];
					SetPlayerRaceCheckpoint(playerid,e_type,BusLSZavodi[i][0],BusLSZavodi[i][1],BusLSZavodi[i][2],BusLSZavodi[i][3],BusLSZavodi[i][4],BusLSZavodi[i][5],7.0);
				}
			}
		}
	}
	return true;
}