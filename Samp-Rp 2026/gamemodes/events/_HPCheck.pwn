publics:_HPCheck()
{
    //print(">-- _HPCheck() -->");

	foreach(i)
	{
		if(PTEMP[i][pLogin] == 0) continue;
		GetVehicleParamsEx(GetPlayerVehicleID(i),engine,lights,alarm,doors,bonnet,boot,objective);
		if(!IsAPlane(GetPlayerVehicleID(i)) && !IsABoat(GetPlayerVehicleID(i)) && !IsABike(GetPlayerVehicleID(i)) && IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER && engine == 1)
		{
		    new h = GetPVarInt(i, "chosencar");
			if(Vehicleforeach(GetPlayerVehicleID(i)) != -1)
			{
				if(GetVehicleModel(GetPlayerVehicleID(i)) >= ShopCar[0][0] && GetVehicleModel(GetPlayerVehicleID(i)) <= ShopCar[56][0])
				{
					switch(CarInfo[Vehicleforeach(GetPlayerVehicleID(i))][carPercent][h])
					{
					case 51..100: Fuell[GetPlayerVehicleID(i)] -= 1.0000;
					case 5..50: Fuell[GetPlayerVehicleID(i)] -= 2.0000;
					default: Fuell[GetPlayerVehicleID(i)] -= 4.0000;
					}
				}
				else
				{
					switch(CarInfo[Vehicleforeach(GetPlayerVehicleID(i))][carPercent][h])
					{
					case 51..100: Fuell[GetPlayerVehicleID(i)] -= 2.0000;
					case 5..50: Fuell[GetPlayerVehicleID(i)] -= 4.0000;
					default: Fuell[GetPlayerVehicleID(i)] -= 8.0000;
					}
				}
				CarInfo[Vehicleforeach(GetPlayerVehicleID(i))][carFuel][h] = Fuell[GetPlayerVehicleID(i)];
			}
			else Fuell[GetPlayerVehicleID(i)] -= 1.0000;
		}
		new Float:health;
		GetPlayerHealth(i,health);
		//if(PTEMP[i][pTut] != 0 && health <= 10.0) SCM(i, COLOR_YELLOW, " У вас сильно ухудшилось здоровье, вылечитесь у медика!");
		if(PTEMP[i][pSatiety] > 0) PTEMP[i][pSatiety] -= 1;
		if(PTEMP[i][pSatiety] == 49 || PTEMP[i][pSatiety] == 24) SCM(i,COLOR_LIGHTGREEN, " Вы проголодались! Посетите бар, закусочную или купите ХотДог. Узнать свою «Сытость» можно командой /satiety");
		if(PTEMP[i][pSatiety] < 50) SetPlayerHealthAC(i, health - 1.0);
		else if(PTEMP[i][pSatiety] < 25) SetPlayerHealthAC(i, health - 2.0);
		PTEMP[i][pMin]++;
		if(PTEMP[i][pMin] >= 60) PTEMP[i][pChas]++, PTEMP[i][pMin] = 0;
	}

    //print("<-- _HPCheck() --<");

	return true;
}