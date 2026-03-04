public OnPlayerCommandText(playerid, cmdtext[])
{
	if (GetPVarInt(playerid, "USEDIALOGID") && PTEMP[playerid][pLogin] > 0) return true;
	return true;
}