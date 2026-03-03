public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid,
                                Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,
                                Float:fRotX, Float:fRotY, Float:fRotZ,
                                Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	SetPlayerAttachedObject(GetPVarInt(playerid, "GetPlayerObject"),index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
	SCM(playerid, -1, " Объект установлен");

	return 1;
}