SetPlayerToTeamColor(playerid)
{
	switch (PTEMP[playerid][pMember])
	{
	case 0:	SetPlayerColor(playerid, TEAM_HIT_COLOR);
	case 1: SetPlayerColor(playerid, 0x110CE7FF);
	case 2: SetPlayerColor(playerid, 0x313131AA);
	case 3: SetPlayerColor(playerid, COLOR_GREEN);
	case 4: SetPlayerColor(playerid, 0x954F4FFF);
	case 5: SetPlayerColor(playerid, 0xDDA701FF);
	case 6: SetPlayerColor(playerid, COLOR_REDD);
	case 7: SetPlayerColor(playerid, 0x114D71FF);
	case 8: SetPlayerColor(playerid, 0xB313E7FF);
	case 9: SetPlayerColor(playerid, 0x49E789FF);
	case 10: SetPlayerColor(playerid, 0x110CE7FF);
	case 11: SetPlayerColor(playerid, 0x139BECFF);
	case 12: SetPlayerColor(playerid, 0xB313E7FF);
	case 13: SetPlayerColor(playerid, 0xDBD604AA);
	case 14: SetPlayerColor(playerid, COLOR_GRAD1);
	case 15: SetPlayerColor(playerid, 0x009F00AA);
	case 16: SetPlayerColor(playerid, 0x40848BAA);
	case 17: SetPlayerColor(playerid, TEAM_AZTECAS_COLOR);
	case 18: SetPlayerColor(playerid, 0x2A9170FF);
	case 19: SetPlayerColor(playerid, COLOR_GREEN);
	case 20: SetPlayerColor(playerid, 0xE6284EFF);
	case 21: SetPlayerColor(playerid, 0x110CE7FF);
	case 22: SetPlayerColor(playerid, 0x954F4FFF);
	case 23: SetPlayerColor(playerid, 0x9ED201FF);
	case 24: SetPlayerColor(playerid, 0xB30000FF);
	case 25: SetPlayerColor(playerid, 0x49E789FF);
	case 26: SetPlayerColor(playerid, 0xF45000FF);
	case 27: SetPlayerColor(playerid, 0xF45000FF);
	case 28: SetPlayerColor(playerid, 0xFFEE8AFF);
	case 29: SetPlayerColor(playerid, 0x114D71FF);
	case 30: SetPlayerColor(playerid, 0xE6284EFF);
	case 31: SetPlayerColor(playerid, 0xB30000FF);
	case 32: SetPlayerColor(playerid, 0xFF9DB6FF);
	case 33: SetPlayerColor(playerid, 0x954F4FFF);
	case 34: SetPlayerColor(playerid, 0x7df9ffFF);
	}
	return true;
}