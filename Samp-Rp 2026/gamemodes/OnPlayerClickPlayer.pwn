public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(PTEMP[playerid][pMember] == 11)
	{
		if(!ProxDetectorS(8.0, playerid, clickedplayerid)) return SCM(playerid,COLOR_GREY,"Игрок должен находиться рядом с вами");
		if(!GetPVarInt(playerid,"Fraction_Duty")) return SCM(playerid,COLOR_GRAD1, "Вам нужно начать рабочий день в автошколе");
		new listitems[] = " [0] Водительские права\n [1] Лицензия на полёты\n [2] Лицензия на рыболовлю\n [3] Лицензия на вождение водного транспорта\n [4] Лицензия на оружие\n [5] Лицензия на бизнес\n [6] Начать урок\n [7] Завершить урок";
		ShowPlayerDialogEx(playerid, 7777, DIALOG_STYLE_LIST, "Выдача лицензий", listitems, "Выбрать", "Отмена");
		ChosenPlayer[playerid] = clickedplayerid;
		SetPVarInt(ChosenPlayer[playerid],"PlayerSell",playerid);
	}
	return false;
}