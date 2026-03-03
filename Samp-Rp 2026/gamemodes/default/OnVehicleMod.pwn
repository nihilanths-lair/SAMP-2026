public OnVehicleMod(playerid, vehicleid, componentid)
{
	new vehicleide = GetVehicleModel(vehicleid);
	new modok = IsLegalCarMod(vehicleide, componentid);
	if(!modok) Kick(playerid);
	return true;
}