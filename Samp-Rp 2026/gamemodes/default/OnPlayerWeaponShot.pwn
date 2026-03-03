public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	TimeNumberShotTarget[playerid]++;
	TimeNumberShot[playerid]++;
	if(weaponid != 38)
	{
		if((gettime() - shotTime[playerid]) < 1)
		{
			shot[playerid]+=1;
		}
		else
		{
			shot[playerid]=0;
		}
		if(shot[playerid] > 10)
		{
			if(PTEMP[playerid][pAdmin] > 2) return true;
			format(string, 90, " <Warning> %s[%i]: Возможно чит на оружие", PTEMP[playerid][pName], playerid);
			ABroadCast(COLOR_REDD,string,2);
			//CheatKick(playerid,1111);
		}
		shotTime[playerid] = gettime();
	}
	//
	/*new Float:armour;
	GetPlayerArmour(playerid, armour);
	if(armour <= 0)
	{
		if(weaponid == 24) PTEMP[hitid][pHP]-=40;//DesertEagle
	    if(weaponid == 23) PTEMP[hitid][pHP]-=10;//SilencedColt
	    if(weaponid == 31) PTEMP[hitid][pHP]-=15;//M4
	    if(weaponid == 30) PTEMP[hitid][pHP]-=15;//AK
	    if(weaponid == 29) PTEMP[hitid][pHP]-=18;//MP5
	    if(weaponid == 34) PTEMP[hitid][pHP]-=50;//SniperRifle
	    if(weaponid == 25) PTEMP[hitid][pHP]-=25;//PumpShotgun
    }
    else
    {
    	if(weaponid == 24) armour-=40;//DesertEagle
	    if(weaponid == 23) armour-=10;//SilencedColt
	    if(weaponid == 31) armour-=15;//M4
	    if(weaponid == 30) armour-=15;//AK
	    if(weaponid == 29) armour-=18;//MP5
	    if(weaponid == 34) armour-=50;//SniperRifle
	    if(weaponid == 25) armour-=25;//PumpShotgun
	    SetPlayerArmourAC(hitid, armour);
    }
	//
	if(PTEMP[hitid][pHP] <= 0) SetPlayerHealthAC(hitid, PTEMP[hitid][pHP]);*/
	if(hittype == 1)
	{
		SERIU[playerid][SShout][0]++;
		SERIU[playerid][SShout][1]++;
		SERIU[playerid][SShout][2]++;
		SERIU[playerid][SShout][3]++;
	}
	if(hittype == BULLET_HIT_TYPE_PLAYER && AGM[hitid]) return 0;
	return true;
}