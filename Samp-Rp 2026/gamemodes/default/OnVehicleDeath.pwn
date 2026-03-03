public OnVehicleDeath(vehicleid, killerid)
{
	if(SERVERTEST) SendMes(killerid,COLOR_BLUE,"VEHICLEDEATH: VEHICLEID - %i, KILLERID - %i",vehicleid,killerid);
	if(killerid != INVALID_PLAYER_ID)
	{
		// fix #1 {
		new Float:carhp;
		GetVehicleHealth(vehicleid, carhp);
		// fix #1 }
		if(carhp < 300) return true;
		else
		{
			SetPVarInt(killerid,"CarSpWarn",GetPVarInt(killerid,"CarSpWarn")+1);
			if(GetPVarInt(killerid,"CarSpWarn") >= 1)
			{
				return WarningSP(killerid);
			}
		}
		return 1;
	}
	if(GetTickCount() - GetPVarInt(killerid,"vehicledeath") <= 100) return CheatKick(killerid,030);
	SetPVarInt(killerid,"vehicledeath", GetTickCount());
	SetVehicleParamsEx(vehicleid,false,false,false,false,false,false,false);
	car_ex[vehicleid] = true;
	return true;
}