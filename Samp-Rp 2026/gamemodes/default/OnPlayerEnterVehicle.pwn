public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(SERVERTEST) SendMes(playerid,COLOR_BLUE,"PLAYERID - %i, VEHICLEID - %i, ISPASSENGER - %i",playerid,vehicleid,ispassenger);
	SetPVarInt(playerid, "NoAB", 1);
	SetPVarInt(playerid, "GunCheckTime", 2);
	SetPlayerArmedWeapon(playerid,0);
	SetPVarInt(playerid,"not_engine",0);
	SetPVarInt(playerid,"not_engine_",0);
	if(usemats[playerid] > 0)
	{
		if(usemats[playerid] == 1) armmatsf += 250;
		if(usemats[playerid] == 2) lsamatbi += 250;
		if(usemats[playerid] == 3) armmatbi += 250;
		usemats[playerid] = 0;
		RemovePlayerAttachedObject(playerid, 1);
		SCM(playerid, COLOR_LIGHTRED," Вы уронили ящик");
		SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
	}
	if(GetPVarInt(playerid, "matovoz_rob"))
	{
        MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad] += 250;
        format(string, sizeof(string), "Кол-во груза\n%i", MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad]);
        UpdateDynamic3DTextLabelText(Rob3DText, 0xEDEA9FAA, string);
		RemovePlayerAttachedObject(playerid, 1);
		SCM(playerid, COLOR_LIGHTRED," Вы уронили ящик");
		SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
	}
	if(!ispassenger) vehicleidtp[playerid] = vehicleid;
	Refueling[playerid] = 0;
	SetPVarInt(playerid, "EnterVehTime", GetTickCount() + 250);
	return true;
}