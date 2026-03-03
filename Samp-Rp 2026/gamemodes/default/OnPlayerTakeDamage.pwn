public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    /*
    if(issuerid != INVALID_PLAYER_ID)
    {
        new string[128], victim[MAX_PLAYER_NAME], attacker[MAX_PLAYER_NAME];
        new weaponname[24];
        GetPlayerName(playerid, victim, sizeof (victim));
        GetPlayerName(issuerid, attacker, sizeof (attacker));

        GetWeaponName(weaponid, weaponname, sizeof (weaponname));
        format(string, sizeof(string), " %s повредил на %.0f здоровья %s, оружие: %s", attacker, amount, victim, weaponname);
        SendClientMessageToAll(0xFFFFFFFF, string);
    }
    */
    if(Convoi[playerid] != 9999)
    {
        new Float:HP;
        GetPlayerHealth(playerid,HP);
        SetPlayerHealth(playerid,HP);
    }
   	
    return true;
}