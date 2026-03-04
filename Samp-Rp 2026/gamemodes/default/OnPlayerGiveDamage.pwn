public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
{
    if (AGM[damagedid]) return false;
    if (weaponid == 24 || weaponid == 25 || weaponid == 31 || weaponid == 29 || weaponid == 33)
	{
		if (!IsACop(playerid)) return true;
		if (NewTazer[playerid] != true) return true;
		if (PlayerCuffed[damagedid] == 2) return true;
		if (PlayerCuffed[damagedid] == 1)
		{
			new Float:Health;
			GetPlayerHealth(damagedid, Health);
			return SetPlayerHealth(damagedid, Health);
		}
		new Float:Health;
		GetPlayerHealth(damagedid, Health);
		SetPlayerHealth(damagedid, Health);
		ApplyAnimation(damagedid, "PED", "KO_skid_front", 6.0,0,1,1,1,0);
		PlayerCuffed[damagedid] = 1;
		PlayerCuffedTime[damagedid] = 10;
		GameTextForPlayer(damagedid, "~r~freeze", 5000, 3);
	}
	if (GetPVarInt(playerid,"AFK_Time") > 2) return true;
	if (PTEMP[playerid][pArmour] > 0.0)
    {
        if ((PTEMP[playerid][pArmour]-amount) <= 0.0)
        {
        	SetPlayerArmourAC(playerid, 0.0);
        	PTEMP[playerid][pArmour] = 0.0;
        }
        else if ((PTEMP[playerid][pArmour]-amount) > 0.0)
        {
       		SetPlayerArmourAC(playerid, PTEMP[playerid][pArmour]-amount);
       		PTEMP[playerid][pArmour] -= amount;
        }
    }
    else
    {
        if ((PTEMP[playerid][pHP]-amount) <= 0.0 && !killed[playerid])
        {
			PTEMP[playerid][pHP] = 0.0;
        	SetPlayerHealthAC(playerid, 0.0);
        	OnPlayerDeath(playerid, playerid, weaponid);
        	PTEMP[playerid][pHP] = 100;
        	killed[playerid] = true;
        }
        else if ((PTEMP[playerid][pHP]-amount) > 0.0)
        {
			PTEMP[playerid][pHP] -= amount;
           	SetPlayerHealthAC(playerid, PTEMP[playerid][pHP]);
        }
    }
	return true;
}