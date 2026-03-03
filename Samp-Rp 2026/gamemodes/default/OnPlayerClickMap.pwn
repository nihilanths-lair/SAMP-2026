public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PTEMP[playerid][pLogin] == 0) return true;
	if(PTEMP[playerid][pAdmin] < 3 || dostup[playerid] == 0) return true;
    SetPVarFloat(playerid,"ATPX",fX);
    SetPVarFloat(playerid,"ATPY",fY);
    SetPVarFloat(playerid,"ATPZ",fZ);
	return true;
}