public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
{
    if(AGM[damagedid]) return false;
    
    if(weaponid == 24 || weaponid == 25 || weaponid == 31 || weaponid == 29 || weaponid == 33)
	{
		  if(!IsACop(playerid)) return true;
		  if(NewTazer[playerid] != true) return true;
		  if(PlayerCuffed[damagedid] == 2) return true;
	      if(PlayerCuffed[damagedid] == 1)
	      {
	   		  new Float:Health;
	  		  GetPlayerHealth(damagedid,Health);
		      return SetPlayerHealth(damagedid,Health);
		  }
		  new Float:Health;
		  GetPlayerHealth(damagedid,Health);
  		  SetPlayerHealth(damagedid,Health);
		  ApplyAnimation(damagedid,"PED","KO_skid_front",6.0,0,1,1,1,0);
		  PlayerCuffed[damagedid] = 1;
		  PlayerCuffedTime[damagedid] = 10;
		  GameTextForPlayer(damagedid,"~r~freeze", 5000, 3);
	}
    
	SetDamage(damagedid, playerid, amount, weaponid);
	return true;
}