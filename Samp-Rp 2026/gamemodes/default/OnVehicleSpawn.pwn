public OnVehicleSpawn(vehicleid)
{
	if(SERVERCARID[vehicleid] == false)
	{
		DestroyVehicle(vehicleid);
	}
	car_ex[vehicleid] = true;
	GetVehiclePos(vehicleid,car_coord[vehicleid][0],car_coord[vehicleid][1],car_coord[vehicleid][2]);
	GetVehicleZAngle(vehicleid,car_coord[vehicleid][3]);
	SetVehicleParamsEx(vehicleid,false,false,false,false,false,false,false);
	CarHealth[vehicleid] = float(1000);
	enginebrokened[vehicleid] = 0;
	if(car_pickup[vehicleid] > 0) DestroyDynamic3DTextLabel(car_text[vehicleid]), DestroyDynamicPickup(car_pickup[vehicleid]), car_pickup[vehicleid] = 0;
	if(Farmcar_pickup[vehicleid] > 0) Delete3DTextLabel(Farmcar_text[vehicleid]), DestroyDynamicPickup(Farmcar_pickup[vehicleid]), Farmcar_pickup[vehicleid] = 0;
	if(Farmcar_pickup[vehicleid] > 0) Delete3DTextLabel(Farmcar_text[vehicleid]), DestroyDynamicPickup(Farmcar_pickup[vehicleid]), Farmcar_pickup[vehicleid] = 0;
	foreach(i)
	{
		if(GetPVarInt(i,"took_faggio") == vehicleid && GetPVarInt(i,"took_faggio") > 0)
		{
			DestroyVehicle(vehicleid);
			DeletePVar(i,"took_faggio");
		}
	}
	foreach(i)
	{
		if(vehicleid == house_car[i]) Fuell[house_car[i]] = CarInfo[i][carFuel][GetPVarInt(i, "chosencar")],SetVehicleParamsEx(vehicleid,false,false,false,true,false,false,false), LoadTuning(i,house_car[i],GetPVarInt(i, "chosencar"));
	}
	for(new i = 0; i < 10; i++) if(vehicleid == taxi5lvlcar[i]) police[taxi5lvlcar[i]] = CreateObject(19308,0,0,0,0,0,0,100.0), AttachObjectToVehicle(police[taxi5lvlcar[i]], taxi5lvlcar[i], 0.000000, -0.400000, 0.854999, 0.000000, 0.000000, 0.0);
	for(new i = 0; i < 11; i++) if(vehicleid == taxi10lvlcar[i]) police[taxi10lvlcar[i]] = CreateObject(19308,0,0,0,0,0,0,100.0), AttachObjectToVehicle(police[taxi10lvlcar[i]], taxi10lvlcar[i], -0.014999, -0.140000, 0.919999, -1.005000, 0.000000, 0.0);
	foreach(i)
	{
	    if(vehicleid == house_car[i] && PTEMP[i][pKvartiraKey] != 0)
	    {
	        DestroyVehicle(house_car[i]);
	        house_car[i] = -1;
	    }
	}
	return true;
}