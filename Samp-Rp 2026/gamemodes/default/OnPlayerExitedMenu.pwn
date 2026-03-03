public OnPlayerExitedMenu(playerid)
{
	if(!IsValidMenu(GetPlayerMenu(playerid))) return true;
	ShowMenuForPlayer(GetPlayerMenu(playerid), playerid);
	TogglePlayerControllable(playerid,0);
	return true;
}