publics:_UpdateFresh()
{
    //print("--> _UpdateFresh()");

	foreach(i)
	{
	    if (IsABank(i)) GameTextForPlayer(i, "~n~~n~~n~~n~~n~~n~~n~~n~~g~PRESS  ~w~~k~~VEHICLE_ENTER_EXIT~",1300,4);
		new carid = GetPlayerVehicleID(i);
		if (GetPVarInt(i,"BoneStol")) SelectTextDraw(i,0x33AAFFFF);
		if (GetPVarInt(i, "SelectAvto") != -1) SelectTextDraw(i,0x0080FFFF);
		if (GetRoulet(i) && !GetPVarInt(i,"RStol") && !GetPVarInt(i,"CasinoRank")) GameTextForPlayer(i,"~g~PRESS ENTER",1300,4);
		if (IsPlayerNearGarage(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER && IsPlayerInVehicle(i, house_car[i])) GameTextForPlayer(i,"~g~PRESS ~k~~VEHICLE_HORN~",1300,4);
		if (!GetPVarInt(i,"BoneStol") && IsPlayerNearBone(i) != -1) GameTextForPlayer(i,"~g~PRESS ENTER",1300,4);
		SetPVarInt(i, "NewPlayerAmmo", GetPlayerAmmo(i));
		if (GetPVarInt(i, "NewPlayerAmmo") != GetPVarInt(i, "PlayerAmmo"))
		{
			OnPlayerAmmoChange(i, GetPVarInt(i, "NewPlayerAmmo"), GetPVarInt(i, "PlayerAmmo"));
			SetPVarInt(i, "PlayerAmmo", GetPVarInt(i, "NewPlayerAmmo"));
		}
		if (!IsPlayerApplyAnimation(i, "KO_skid_front") && PlayerCuffedTime[i])
		{
		    ApplyAnimation(i,"PED","KO_skid_front",6.0,0,1,1,1,0);
		}
		if (Works[i])
		{
			if (JobCP[i] != 2 && usemesh[i] != 1) return true;
			if (IsPlayerInAnyVehicle(i)) return true;
			if (IsPlayerApplyAnimation(i, "FALL_back") ||
				IsPlayerApplyAnimation(i, "FALL_collapse") ||
				IsPlayerApplyAnimation(i, "FALL_fall") ||
				IsPlayerApplyAnimation(i, "FALL_front") ||
				IsPlayerApplyAnimation(i, "FALL_glide") ||
				IsPlayerApplyAnimation(i, "FALL_land") ||
				IsPlayerApplyAnimation(i, "FALL_skyDive"))
			{
				SCM(i, COLOR_LIGHTRED, " Вы уронили ящик");
				DisablePlayerCheckpoint(i);
				mesh[i] = 0;
				usemesh[i] = 0;
				if (IsPlayerAttachedObjectSlotUsed(i,1)) RemovePlayerAttachedObject(i,1);
				SetPlayerCheckpoint(i,2230.3528,-2286.1353,14.3751,1.5);
				JobCP[i] = 1;
			}
		}
        if (GetPVarInt(i, "matovoz_rob"))
		{
			if (IsPlayerApplyAnimation(i, "FALL_back") ||
				IsPlayerApplyAnimation(i, "FALL_collapse") ||
				IsPlayerApplyAnimation(i, "FALL_fall") ||
				IsPlayerApplyAnimation(i, "FALL_front") ||
				IsPlayerApplyAnimation(i, "FALL_glide") ||
				IsPlayerApplyAnimation(i, "FALL_land") ||
				IsPlayerApplyAnimation(i, "FALL_skyDive"))
			{
				SCM(i, COLOR_LIGHTRED, " Вы уронили ящик");
				DisablePlayerCheckpoint(i);
		        MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad] += 250;
				format(string, sizeof(string), "Кол-во груза\n%i", MatHaul[RobbingBiker[robCar]-gunscar[0]][mLoad]);
        		UpdateDynamic3DTextLabelText(Rob3DText, 0xEDEA9FAA, string);
				RemovePlayerAttachedObject(i, 1);
				SetPlayerSpecialAction (i, SPECIAL_ACTION_NONE);
				DeletePVar(i, "matovoz_rob");
			}
		}
		new currentveh;
		currentveh = GetPlayerVehicleID(i);
		new Float:vehx, Float:vehy, Float:vehz;
		GetVehiclePos(currentveh, vehx, vehy, vehz);
		new vehicleid = GetPlayerVehicleID(i);
		new vehiclemodel = GetVehicleModel(vehicleid);
		if (vehiclemodel == 514 || vehiclemodel == 515 || vehiclemodel == 403)
		{
			if (GetVehicleTrailer(GetPlayerVehicleID(i)) != 0 && GetPlayerState(i) == PLAYER_STATE_DRIVER && vehz < 0)
			{
				SCM(i, 0xFF6347AA, " Вы потеряли свой грузовик");
				SCM(i, 0xFF6347AA, " Вы потеряли свой груз");
				peremennn[i] = 0;
				SetVehicleToRespawn(GetPlayerVehicleID(i));
				DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(i)));
				DriverJob[i] = false;
				PTEMP[i][pDgruz] = 0;
				Gruz[i] = 0;
				bGruz[i] = 0;
			}
		}
		if (vehiclemodel == 514 || vehiclemodel == 515 || vehiclemodel == 403)
		{
			if (GetVehicleTrailer(GetPlayerVehicleID(i)) == 0 && GetPlayerState(i) == PLAYER_STATE_DRIVER && vehz < 0)
			{
				SCM(i, 0xFF6347AA, " Вы потеряли свой грузовик");
				SetVehicleToRespawn(GetPlayerVehicleID(i));
				DriverJob[i] = false;
			}
		}
		GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
		new Keys, ud;
		new up, dn;
		GetPlayerKeys(i, Keys, up, dn);
		if (GetPVarInt(i,"RStol") && !GetPVarInt(i,"RStavka"))
		{
			new Float:p;
			GetPlayerFacingAngle(i,p);
			switch (GetPVarInt(i,"RStol"))
			{
			case 1..4:
				{
					if(p >= 0 && p <= 190)
					{
						if(dn < 0) Down(i);
						else if(dn > 0) Up(i);
						else if(up < 0) Left(i);
						else if(up > 0) Right(i);
					}
					else
					{
						if(dn > 0) Down(i);
						else if(dn < 0) Up(i);
						else if(up > 0) Left(i);
						else if(up < 0) Right(i);
					}
				}
			default:
				{
					if(p >= 0 && p <= 130 || p >= 290 && p <= 360)
					{
						if(dn > 0) Down(i);
						else if(dn < 0) Up(i);
						else if(up > 0) Left(i);
						else if(up < 0) Right(i);
					}
					else
					{
						if(dn < 0) Down(i);
						else if(dn > 0) Up(i);
						else if(up < 0) Left(i);
						else if(up > 0) Right(i);
					}
				}
			}
		}
		if (IsAAntidm(i) && GetPlayerWeapon(i) > 1)
		{
		    if (!IsAArm(i) && !IsACop(i) && PTEMP[i][pAdmin] < 1)
			SetPlayerArmedWeapon(i,0);
		}
		if (Spectate[i] && ud == KEY_DOWN && !LastReconClick[i][0])
		{
			PlayerPlaySound(i, 1083, 0.0, 0.0, 0.0);
			LastReconClick[i][0] = ud;
			if (ReconSelectSub[i] == INVALID_TEXT_DRAW)
			{
				DisableEnableReconButton(i, ReconSelect[i], 0);
				if (ReconSelect[i] >= 15)
				{
					ReconSelect[i] = 7;
					DisableEnableReconButton(i, ReconSelect[i], 1);
				}
				else
				{
					ReconSelect[i]++;
					DisableEnableReconButton(i, ReconSelect[i], 1);
				}
				return 1;
			}
			else
			{
				DisableEnableReconButton(i, ReconSelectSub[i], 0);
				if (ReconSelectSub[i] >= ReconBounds[i][1])
				{
					ReconSelectSub[i] = ReconBounds[i][0];
					DisableEnableReconButton(i, ReconSelectSub[i], 1);
				}
				else
				{
					ReconSelectSub[i]++;
					DisableEnableReconButton(i, ReconSelectSub[i], 1);
				}
			}
		}
		if (Spectate[i] && SpecAd[i] != INVALID_PLAYER_ID) return PlayerTextDrawShow(i, ReconPlayer[34]);
		if (SERVERTEST)
		{
			SendMes(i,COLOR_BLUE,"i - %i, CAMERAMODE - %i",i,GetPlayerCameraMode(i));
			new Float:XS, Float:YS, Float:ZS;
			GetPlayerPos(i,XS,YS,ZS);
			SendMes(i,COLOR_BLUE,"i - %i, X - %.1f, Y - %.1f, Z - %.1f",i,XS,YS,ZS);
			new Float:xw, Float:yw, Float:zw;
			GetPlayerVelocity(i,xw,yw,zw);
			SendMes(i,COLOR_BLUE,"i - %i, X - %.1f, Y - %.1f, Z - %.1f",i,xw,yw,zw);
		}
		if (Sounds == 1)
		{
			new distance = floatround( GetPlayerDistanceFromPoint( i, streampos[0], streampos[1], streampos[2]) );
			if (UseSound[i] == 0 && distance <= rads)
			{
				PlayAudioStreamForPlayer(i, stream, streampos[0], streampos[1], streampos[2], rads, 1);
				UseSound[i] = 1;
			}
			if (UseSound[i] == 1 && distance > rads) UseSound[i] = 0;
		}
		if (IsPlayerInAnyVehicle(i)) SetPlayerArmedWeapon(i,0);
		if (GetPlayerState(i) == PLAYER_STATE_DRIVER && (GetPlayerWeapon(i) == WEAPON_DEAGLE || GetPlayerWeapon(i) == WEAPON_SHOTGSPA || GetPlayerWeapon(i) == WEAPON_SAWEDOFF || GetPlayerWeapon(i) == WEAPON_MINIGUN || GetPlayerWeapon(i) == WEAPON_MP5  )) SetPlayerArmedWeapon(i,0);
	}

    //print("<-- _UpdateFresh()");

	return true;
}