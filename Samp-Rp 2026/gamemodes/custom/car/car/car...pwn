// Закрыть транспортное средство
LockCar(playerid, carid)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if (!IsAPlane(carid) && !IsABoat(carid) && !IsABike(carid) && AutoSaloon[playerid] != true)
		{
			PlayerTextDrawColor    (playerid, StatusShow[playerid], -16776961);
			PlayerTextDrawSetString(playerid, StatusShow[playerid], "Lock");
			PlayerTextDrawShow     (playerid, StatusShow[playerid]);
		}
	}
	GetVehicleParamsEx(carid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(carid, engine, lights, alarm, true, bonnet, boot, objective);
}
// Открыть транспортное средство
UnLockCar(playerid, carid)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if (!IsAPlane(carid) && !IsABoat(carid) && !IsABike(carid) && AutoSaloon[playerid] != true)
		{
			PlayerTextDrawColor    (playerid, StatusShow[playerid], 0x20B220AA);
			PlayerTextDrawSetString(playerid, StatusShow[playerid], "Unlock");
			PlayerTextDrawShow     (playerid, StatusShow[playerid]);
		}
	}
	GetVehicleParamsEx(carid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(carid, engine, lights, alarm, false, bonnet, boot, objective);
}