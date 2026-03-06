new RulesMSG[17][] =
{
	{"1. Игровой процесс\n"},
	{"Запрещено:\n"},
	{"- Использование любых программ скриптов читов и.т.п. дающие нечестное преймущество в игре.\n"},
	{"- Использование багов (Ошибок, Неисправностей мода).\n"},
	{"- Использовать ESC в целях ухода от погони/смерти.\n"},
	{"- Убивать игроков на спавне (Место возрождения, базы организаций).\n"},
	{"- Убивать игроков при помощи транспорта (Давить, Стрелять с водительского места).\n"},
	{"- Убийство/нанесение физического вреда игрокам без причины (ДМ - Death Match).\n"},
	{"- Злоупотребление игровыми возможностями для создания неудобств игрокам.\n\n"},
	{"2. Ник в игре:\n"},
	{"- (сменить ник можно через /mm >> Сменить ник)\n"},
	{"- Ник должен состоять из Имени_Фамилии с заглавных букв.\n"},
	{"Запрещено:\n"},
	{"- Запрещено использовать чужие (уже кем-то занятые) ники.\n"},
	{"- Запрещено использовать ники, содержащие нецензурные или оскорбительные слова.\n"},
	{"- Отправлять более одной заявки в час (Исключение: Просьба Администрации).\n"},
	{"- Если вам отказали в смене ника, Значит нельзя.\n"}
};
new RulesMSGG[22][] =
{
	{"3. Чат:\n"},
	{"- OOC (Out Of Charter) - это всё, что касается реального мира.\n"},
	{"- IC (In Charter) - это всё, что касается виртульного мира, то есть игры.\n"},
	{"Запрещено:\n"},
	{"- Ругательство, оскорбления или нецензурная речь.\n"},
	{"- Угрозы игрокам (Не относящиеся к игровому процессу).\n"},
	{"- Писать сообщения в верхнем регистре (Caps Lock).\n"},
	{"- Писать в чат объявлений сообщения не относящихся к Role Play.\n"},
	{"- Писать одно и тоже сообщение слишком часто.\n"},
	{"- Обсуждать, критиковать действия администрации.\n"},
	{"- Реклама сторонних ресурсов.\n\n"},
	{"4. Администрация сервера:\n"},
	{"- Необходимо сообщать администрации о каких либо нарушениях из данных правил (/mm > Репорт).\n"},
	{"- Администрация самостоятельно выбирает штрафные санкции для каждого из случаев.\n"},
	{"- Запрещено препятствовать администрации в работе.\n"},
	{"- Решение администрации является окончательным и не подлежит обсуждению.\n\n"},
	{"5. Торговля:\n"},
	{"- Запрещены любые денежные махинации.\n"},
	{"- Запрещена продажа / покупка чего либо, за реальные деньги.\n"},
	{"- Запрещен обмен внеигровых предметов в любой форме, на игровые.\n"},
	{"- Запрещен обмен чего либо между игровыми серверами.\n"},
	{"- Запрещена продажа / передача аккаунтов.\n"}
};

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    printf(">-- OnDialogResponse(playerid = %d, dialogid = %d, response = %d, listitem = %d, inputtext = \"%s\") -->", playerid, dialogid, response, listitem, inputtext);

	//if(GetPVarInt(playerid,"USEDIALOGID") != dialogid) return Kick(playerid);
	while (strfind(inputtext, "%s", true) != -1) strdel(inputtext, strfind(inputtext, "%s", true), strfind(inputtext, "%s", true) + 2);
	while (strfind(inputtext, "%", true) != -1) strdel(inputtext, strfind(inputtext, "%", true), strfind(inputtext, "%", true) + 2);

	new gun,ammo;
	new gunname[32];

	SetPVarInt(playerid, "USEDIALOGID", 0);
	switch (dialogid){
	case 2:
    {
        if (response)
        {
            if (!strlen(inputtext))
            {
                format(string, 256, "{B4B5B7}______________________________________\n\n Добро пожаловать на сервер "NameServer"{B4B5B7}\n       Регистрация нового персонажа\n\nЛогин: {BFC0C2}%s{B4B5B7}\nВведите пароль:\n______________________________________", Name(playerid));
                ShowPlayerDialogEx(playerid, 2, DIALOG_STYLE_INPUT, "Регистрация", string, "Готово", "Отмена");
                return true;
            }
            if (!strlen(inputtext) || strlen(inputtext) < 6 || strlen(inputtext) > 16)
            {
                return ShowPlayerDialogEx(playerid, 2, DIALOG_STYLE_MSGBOX, "Ошибка!", "{FF6347}Длина пароля должна быть от 6 до 15 символов", "Повтор", "");
            }
            for (new i = strlen(inputtext); i != 0; --i)
            switch (inputtext[i])
            {
            case 'А'..'Я', 'а'..'я', ' ': return ShowPlayerDialogEx(playerid, 2, DIALOG_STYLE_MSGBOX, "Ошибка!", "{00FF21}Введенный вами пароль содержит русские буквы.\n Смените раскладку клавиатуры!", "Повтор", "");
            }
            strmid(PTEMP[playerid][pKey], inputtext, 0, strlen(inputtext), 32);
            PlayerPlaySound(playerid, 1097, 0.0, 0.0, 0.0);

            new rulesdialog[1300];
            format(rulesdialog, sizeof (rulesdialog), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
             RulesMSG[0], RulesMSG[1], RulesMSG[2], RulesMSG[3], RulesMSG[4], RulesMSG[5], RulesMSG[6], RulesMSG[7], RulesMSG[8],
             RulesMSG[9], RulesMSG[10], RulesMSG[11], RulesMSG[12], RulesMSG[13], RulesMSG[14], RulesMSG[15], RulesMSG[16]
            );
            ShowPlayerDialogEx(playerid, 12, DIALOG_STYLE_MSGBOX, "Правила сервера", rulesdialog, "Согласен", "Выйти");
            return true;
        }
        else
        {
            SCM(playerid, COLOR_LIGHTRED, " Для выхода из игры используйте /q(uit)");
            Kick(playerid);
        }
    }
    case 4:
    {
        if (response) PTEMP[playerid][pSex] = 1;
        else PTEMP[playerid][pSex] = 2;
        
        PTEMP[playerid][pTut] = 0;
        PTEMP[playerid][pAdmin] = 0;
        //PTEMP[playerid][pHelper] = 0;
        SetPVarInt(playerid, "Register", 1);
        SpawnPlayer(playerid);
        DelGun(playerid);
    }
    case 12:
    {
        if (!response) return SCM(playerid, COLOR_LIGHTRED, " Для выхода из игры используйте /q(uit)"), Kick(playerid);

        PEfir[playerid] = 999;
        Pefir[playerid] = 0;

        new rulesdialogg[1324];
        format(rulesdialogg, sizeof (rulesdialogg), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
         RulesMSGG[0], RulesMSGG[1], RulesMSGG[2], RulesMSGG[3], RulesMSGG[4], RulesMSGG[5], RulesMSGG[6], RulesMSGG[7], RulesMSGG[8], RulesMSGG[9], RulesMSGG[10],
         RulesMSGG[11], RulesMSGG[12], RulesMSGG[13], RulesMSGG[14], RulesMSGG[15], RulesMSGG[16], RulesMSGG[17], RulesMSGG[18], RulesMSGG[19], RulesMSGG[20], RulesMSGG[21]
        );
        ShowPlayerDialogEx(playerid, 13, DIALOG_STYLE_MSGBOX, "Правила сервера", rulesdialogg, "Согласен", "Выйти");
        return true;
    }
	case 13:
    {
        if (response) ShowPlayerDialogEx(playerid, 1945, DIALOG_STYLE_INPUT, "Электронная почта", "Введите действующий адрес электронной почты,\nесли вы забудете пароль, то на него будет выслан новый", "Далее", "Пропуск");
        else Kick(playerid);
        return true;
    }
    case 1945:
	{
		if (strlen(inputtext) > 0)
		{
			ShowPlayerDialogEx(playerid, 2625, DIALOG_STYLE_INPUT, "По приглашению от:", "Введите ник игрока, пригласившиго вас на сервер", "Далее", "Пропуск");
			strmid(PTEMP[playerid][pEmail], inputtext, 0, strlen(inputtext), strlen(inputtext)+5);
		}
		else
		{
			SCM(playerid, COLOR_GREY, " Длина должна быть от 1 до 64 символов");
			ShowPlayerDialogEx(playerid, 1945, DIALOG_STYLE_INPUT, "Электронная почта", "Пожалуйста введите действующий адрес электронной почты,\nесли вы забудите пароль на него будет выслан новый", "Далее", "Пропуск");
		}
		return true;
	}
    case 2625:
    {
        if (response)
        {
            if (!strlen(inputtext)) return ShowPlayerDialogEx(playerid, 2625, DIALOG_STYLE_INPUT, "По приглашению от:", "Введите ник игрока, пригласившего вас на сервер", "Далее", "Пропуск");
            mysql_format(DATABASE, QUERY, 128, "SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%e'",inputtext);
            mysql_function_query(DATABASE, QUERY, true, "_MySQL_QUERY", "iis", 3, playerid, inputtext);
        }
        else strmid(PTEMP[playerid][pDrug], "-", 0, strlen("-"), strlen("-")+5);
        
        ShowPlayerDialogEx(playerid, 4, DIALOG_STYLE_MSGBOX, " ", "Какого пола будет ваш персонаж:\n", "Мужчина", "Женщина");
        TogglePlayerControllable(playerid, 0);
    }
    case 2626:
	{
		if (!response) return true;
		if (strlen(inputtext) < 1 || strlen(inputtext) > 64)
		{
			return SCM(playerid, COLOR_GREY, " Длина должна быть от 1 до 64 символов"), ShowPlayerDialogEx(playerid, 2626, DIALOG_STYLE_INPUT, "Электронная почта", "Введите действующий адрес электронной почты,\nесли вы забудете пароль, то на него будет выслан новый", "Готово", "Пропуск");
        }
		strmid(PTEMP[playerid][pEmail], inputtext, 0, strlen(inputtext), strlen(inputtext)+5);
		return ShowPlayerDialogEx(playerid, 2625, DIALOG_STYLE_INPUT, "По приглашению от:", "Введите ник игрока, пригласившего вас на сервер", "Далее", "Пропуск");
	}
	case 19284:
	    {
	        if(!response) return true;
			if(strfind(inputtext, "<< Пред. страница") != -1)
			SetPVarInt(playerid, "off_list", GetPVarInt(playerid, "off_list")-1);
			else if(strfind(inputtext, ">> След. страница") != -1)
			SetPVarInt(playerid, "off_list", GetPVarInt(playerid, "off_list")+1);
	        else
	        {
	            new names[32];
	            sscanf(inputtext, "s[32]s[32]s[32]", inputtext,names, inputtext);
				SetPVarString(playerid, "offmembers_info", names);
				ShowPlayerDialog(playerid, 19285, DIALOG_STYLE_LIST, names, "[0] Информация\n[1] Повысить/Понизить\n[2] Уволить", "Выбор", "Назад");
				return true;
	        }
	        new stringer[2048];
	        new ss = GetPVarInt(playerid, "off_admin");
	        if(ss == 0) ss = PTEMP[playerid][pMember];
            mysql_format(DATABASE, QUERY, 128, "SELECT Name,pOnline,pChas,pMin,pRank FROM "TABLE_ACCOUNTS" WHERE pMember='%i'", ss);
			new Cache:result = mysql_query(DATABASE, QUERY);
			new r = cache_num_rows();
			if(r)
			{
			    new bool:label = true;
			    format(stringer, sizeof(stringer), "[#] Имя\tРанг\tПоследний вход\tАктивность за сутки/неделю\n");
				for(new i = GetPVarInt(playerid, "off_list")*29; i < r; i++)
				{
				    if(i%29 == 0)
				    {
				        if(label) label = false;
						else {label = true; break;}
				    }
				    new Names[32], Vxod[32];
					cache_get_field_content(i,"Name",Names,DATABASE,60);
					cache_get_field_content(i,"pOnline",Vxod,DATABASE,32);
					new pChass = cache_get_field_content_int(i, "pChas");
					new pMinn = cache_get_field_content_int(i, "pMin");
					new Rank = cache_get_field_content_int(i,"pRank");
					format(YCMDstr, sizeof(YCMDstr), "[%i] %s\t%i\t%s\t%i / %i часов\n",i, Names, Rank,Vxod,pMinn, pChass);
					strcat(stringer, YCMDstr);
				}

		        if(GetPVarInt(playerid, "off_list") != 0) strcat(stringer, "<< Пред. страница\n");
		        if(label)
		        strcat(stringer, ">> След. страница");
				ShowPlayerDialog(playerid, 19284, DIALOG_STYLE_TABLIST_HEADERS, "Состав оффлайн", stringer, "Выбрать", "Назад");
			}
			return cache_delete(result, DATABASE);
	    }
	case 19285:
	    {
	        if(!response)
	        {
	            new stringer[2048];
	            new ss = GetPVarInt(playerid, "off_admin");
	        	if(ss == 0) ss = PTEMP[playerid][pMember];
	            mysql_format(DATABASE, QUERY, 128, "SELECT Name,pOnline,pChas,pMin,pRank FROM "TABLE_ACCOUNTS" WHERE pMember='%i'", ss);
				new Cache:result = mysql_query(DATABASE, QUERY);
				new r = cache_num_rows();
				if(r)
				{
				    new bool:label = true;
				    format(stringer, sizeof(stringer), "[#] Имя\tРанг\tПоследний вход\tАктивность за сутки/неделю\n");
					for(new i = GetPVarInt(playerid, "off_list")*29; i < r; i++)
					{
					    if(i%29 == 0)
					    {
					        if(label) label = false;
							else {label = true; break;}
					    }
					    new Names[32], Vxod[32];
						cache_get_field_content(i,"Name",Names,DATABASE,60);
						cache_get_field_content(i,"pOnline",Vxod,DATABASE,32);
						new pChass = cache_get_field_content_int(i, "pChas");
						new pMinn = cache_get_field_content_int(i, "pMin");
						new Rank = cache_get_field_content_int(i,"pRank");
						format(YCMDstr, sizeof(YCMDstr), "[%i] %s\t%i\t%s\t%i / %i часов\n",i, Names, Rank,Vxod,pMinn, pChass);
						strcat(stringer, YCMDstr);
					}

			        if(GetPVarInt(playerid, "off_list") != 0) strcat(stringer, "<< Пред. страница\n");
			        if(label)
			        strcat(stringer, ">> След. страница");
					ShowPlayerDialog(playerid, 19284, DIALOG_STYLE_TABLIST_HEADERS, "Состав оффлайн", stringer, "Выбрать", "Назад");
				}
				return cache_delete(result, DATABASE);
	        }
	        new names[32];
	        GetPVarString(playerid, "offmembers_info", names, 32);
	        switch(listitem)
	        {
				case 0:
				{
				    new ss = GetPVarInt(playerid, "off_admin");
	        		if(ss == 0) ss = PTEMP[playerid][pMember];
				    mysql_format(DATABASE, QUERY, 128, "SELECT Name,pOnline,pOnlineLid,pChas,pMin,pRank FROM "TABLE_ACCOUNTS" WHERE pMember='%i' AND Name = '%s'", ss, names);
					new Cache:result = mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
					    new Vxod[32], Inv[32];
					    cache_get_field_content(0,"pOnline",Vxod,DATABASE,32);
					    cache_get_field_content(0,"pOnlineLid",Inv,DATABASE,32);
						new pChass = cache_get_field_content_int(0, "pChas");
						new pMinn = cache_get_field_content_int(0, "pMin");
						new Rank = cache_get_field_content_int(0,"pRank");
						format(string, sizeof(string), "Имя: %s\nРанг: %i\nДата вступления: %s\nДата посл.входа: %s\nАктивность. Часов за сутки/неделю: %i/%i", names, Rank, Inv, Vxod, pMinn, pChass);
						ShowPlayerDialog(playerid, 19286, DIALOG_STYLE_MSGBOX, "Сообщение", string, "Выбрать", "Назад");
					}
					return cache_delete(result, DATABASE);
				}
				case 1:
				{
				    format(string, sizeof(string), "Введите новый ранг игрока %s", names);
				    ShowPlayerDialog(playerid, 19287, DIALOG_STYLE_INPUT, "Ввод параметра", string, "Далее", "Назад");
				    return true;
				}
				case 2:
				{
					format(string, sizeof(string), "Вы действительно хотите выгнать %s из организации?", names);
				    ShowPlayerDialog(playerid, 19288, DIALOG_STYLE_MSGBOX, "Сообщение", string, "Далее", "Назад");
				}
	        }
	    }
	case 19286:
		{
		    new names[32];
			GetPVarString(playerid, "offmembers_info", names, 32);
			ShowPlayerDialog(playerid, 19285, DIALOG_STYLE_LIST, names, "[0] Информация\n[1] Повысить/Понизить\n[2] Уволить", "Выбор", "Назад");
			return true;
		}
	case 19287:
	    {
	        if(!response)
			{
				new names[32];
				GetPVarString(playerid, "offmembers_info", names, 32);
				ShowPlayerDialog(playerid, 19285, DIALOG_STYLE_LIST, names, "[0] Информация\n[1] Повысить/Понизить\n[2] Уволить", "Выбор", "Назад");
				return true;
			}
	        if(strlen(inputtext) == 0)
			{
				new names[32];
		        GetPVarString(playerid, "offmembers_info", names, 32);
	        	format(string, sizeof(string), "Введите новый ранг игрока %s", names);
			    ShowPlayerDialog(playerid, 19287, DIALOG_STYLE_INPUT, "Ввод параметра", string, "Далее", "Назад");
			    return true;
	        }
			new rank = strval(inputtext);
			new bool:label = false;
			switch(PTEMP[playerid][pMember])
			{
			    case 1,10,21:
				{
					switch(rank) { case 1..13: {} default: { SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 13"); label = true; } }
				}
			    case 2,4,5,6,9,11,12,13,14,15,16,17,18,20,24,26,29:
				{
		            switch(rank) { case 1..9: {} default: { SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 9"); label = true; } }
				}
			    case 3,19:
				{
				    switch(rank) { case 1..14: {} default: { SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 14"); label = true; } }
				}
			    case 7:
				{
					switch(rank) { case 1..9: {} default: { SCM(playerid, COLOR_GREY, " Нельзя меньше 1 и больше 9"); label = true; } }
				}
			}
			if(label)
			{
				new names[32];
		        GetPVarString(playerid, "offmembers_info", names, 32);
	        	format(string, sizeof(string), "Введите новый ранг игрока %s", names);
			    ShowPlayerDialog(playerid, 19287, DIALOG_STYLE_INPUT, "Ввод параметра", string, "Далее", "Назад");
			    return true;
			}
			new names[32];
   			GetPVarString(playerid, "offmembers_info", names, 32);
			format(string, sizeof(string), "/offgiverank %s %i",names, rank);
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			return ShowPlayerDialog(playerid, 19285, DIALOG_STYLE_LIST, names, "[0] Информация\n[1] Повысить/Понизить\n[2] Уволить", "Выбор", "Назад");
		}
	case 19288:
	    {
	        new names[32];
   			GetPVarString(playerid, "offmembers_info", names, 32);
	    	if(!response) return ShowPlayerDialog(playerid, 19285, DIALOG_STYLE_LIST, names, "[0] Информация\n[1] Повысить/Понизить\n[2] Уволить", "Выбор", "Назад");
	    	format(string, sizeof(string), "/offuninvite %s",names);
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			new stringer[2048];
			new ss = GetPVarInt(playerid, "off_admin");
	        if(ss == 0) ss = PTEMP[playerid][pMember];
            mysql_format(DATABASE, QUERY, 128, "SELECT Name,pOnline,pChas,pMin,pRank FROM "TABLE_ACCOUNTS" WHERE pMember='%i'", ss);
			new Cache:result = mysql_query(DATABASE, QUERY);
			new r = cache_num_rows();
			if(r)
			{
			    new bool:label = true;
			    format(stringer, sizeof(stringer), "[#] Имя\tРанг\tПоследний вход\tАктивность за сутки/неделю\n");
				for(new i = GetPVarInt(playerid, "off_list")*29; i < r; i++)
				{
				    if(i%29 == 0)
				    {
				        if(label) label = false;
						else {label = true; break;}
				    }
				    new Names[32], Vxod[32];
					cache_get_field_content(i,"Name",Names,DATABASE,60);
					cache_get_field_content(i,"pOnline",Vxod,DATABASE,32);
					new pChass = cache_get_field_content_int(i, "pChas");
					new pMinn = cache_get_field_content_int(i, "pMin");
					new Rank = cache_get_field_content_int(i,"pRank");
					format(YCMDstr, sizeof(YCMDstr), "[%i] %s\t%i\t%s\t%i / %i часов\n",i, Names, Rank,Vxod,pMinn, pChass);
					strcat(stringer, YCMDstr);
				}

		        if(GetPVarInt(playerid, "off_list") != 0) strcat(stringer, "<< Пред. страница\n");
		        if(label)
		        strcat(stringer, ">> След. страница");
				ShowPlayerDialog(playerid, 19284, DIALOG_STYLE_TABLIST_HEADERS, "Состав оффлайн", stringer, "Выбрать", "Назад");
			}
			return cache_delete(result, DATABASE);
	    }
	case 13954:
	    {
	        if(!response) return true;
	        new strs[32];
	        
	        if(!strcmp(inputtext, "Купить оружие", true))
	        {
	            strs = "gun";
	        }
	        else if(!strcmp(inputtext, "Крыша", true))
	        {
				strs = "debt";
	        }
	        else if(!strcmp(inputtext, "Свадьба", true))
	        {
				strs = "propose";
	        }
	        else if(!strcmp(inputtext, "Контракт", true))
	        {
				strs = "gcontract";
	        }
	        else if(!strcmp(inputtext, "Штраф", true))
	        {
				strs = "ticket";
	        }
	        else if(!strcmp(inputtext, "Наркотики", true))
	        {
				strs = "drugs";
	        }
	        else if(!strcmp(inputtext, "Бой", true))
	        {
				strs = "fight";
	        }
	        else if(!strcmp(inputtext, "Покупка дома", true))
	        {
				strs = "house";
	        }
	        else if(!strcmp(inputtext, "Заправка", true))
	        {
				strs = "refill";
	        }
	        else if(!strcmp(inputtext, "Починка", true))
	        {
				strs = "repair";
	        }
	        else if(!strcmp(inputtext, "Территории", true))
	        {
				strs = "zone";
	        }
	        else if(!strcmp(inputtext, "Ключи от камеры", true))
	        {
				strs = "ekey";
	        }
			else if(!strcmp(inputtext, "Выход из тюрьмы", true))
	        {
				strs = "free";
	        }
			else if(!strcmp(inputtext, "Хот Дог", true))
	        {
				strs = "eat";
	        }
	        format(string, sizeof(string), "/accept %s",strs);
	        CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
	        CallLocalFunction("OnPlayerCommandText", "is", playerid, "/accept");
	    }
	case 11486:
	    {
	        if(!response) return true;
	        new strs[128];
	        GetPVarString(playerid, "achat", strs, sizeof(strs));
	        DeletePVar(playerid, "achat");
	        switch(listitem)
	        {
	            case 0: SetPVarInt(playerid, "achat", 1), SCM(playerid, -1, " Теперь вы будете писать в обычный чат администраторов");
	            case 1: SetPVarInt(playerid, "achat", 2), SCM(playerid, -1, " Теперь вы будете писать в чат спец. администраторов");
	        }
	        if(strlen(strs) != 0)
	        {
				format(string, sizeof(string), "/a %s", strs);
				CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
	        }
	    }
	case 11052:
	    {
	        if(!response) return true;
	        if(!GetPVarInt(playerid, "Fraction_Duty"))
	        {
		        switch(listitem)
		        {
		            case 0: PTEMP[playerid][pSpawnChange][0] = 0;
		            case 1: PTEMP[playerid][pSpawnChange][0] = 1;
		        }
	        }
	        else
	        {
		        switch(listitem)
		        {
		            case 0: PTEMP[playerid][pSpawnChange][1] = 0;
		            case 1: PTEMP[playerid][pSpawnChange][1] = 1;
		        }
				if(PTEMP[playerid][pMember] == 4)
				{
				    PTEMP[playerid][pJobHeal] = listitem;
				}
	        }
	        
	        SCM(playerid, -1, " Изменения приняты");
	    }
	case 5254:
		{
		    if(!response) return true;
		    switch(listitem)
		    {
		        case 0..2:
		        {
		            SetPVarInt(playerid, "serverBonus", listitem);
					ShowPlayerDialog(playerid, 5255, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите значение", "Далее", "Назад");
					return true;
		        }
		        case 3: // pDirectory
		        {
                    mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.columns WHERE `TABLE_name` = 'accounts' AND`COLUMN_NAME` = 'pDirectory'");
					mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
						new def[64];
						cache_get_field_content(1,"COLUMN_DEFAULT",def,DATABASE,sizeof(def));
						switch(strval(def))
						{
						    case 0:
						    {
								mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pDirectory` SET DEFAULT '1'",false,"","");
                                SCM(playerid, -1, " Вы включили выдачу телефонного справочника при регистрации");
						    }
						    case 1:
						    {
						    	mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pDirectory` SET DEFAULT '0'",false,"","");
                                SCM(playerid, -1, " Вы отключили выдачу телефонного справочника при регистрации");
						    }
						}
					}
		        }
                case 4: // pCarLic
		        {
                    mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.columns WHERE `TABLE_name` = 'accounts' AND\
					`COLUMN_NAME` = 'pCarLic'");
					mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
						new def[64];
						cache_get_field_content(1,"COLUMN_DEFAULT",def,DATABASE,sizeof(def));
						switch(strval(def))
						{
						    case 0:
						    {
								mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pCarLic` SET DEFAULT '1'",false,"","");
                                SCM(playerid, -1, " Вы включили выдачу водительских прав при регистрации");
						    }
						    case 1:
						    {
						    	mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pCarLic` SET DEFAULT '0'",false,"","");
                                SCM(playerid, -1, " Вы отключили выдачу водительских прав при регистрации");
						    }
						}
					}
		        }
		        case 5: // pFlyLic
		        {
                    mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.columns WHERE `TABLE_name` = 'accounts' AND\
					`COLUMN_NAME` = 'pFlyLic'");
					mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
						new def[64];
						cache_get_field_content(1,"COLUMN_DEFAULT",def,DATABASE,sizeof(def));
						switch(strval(def))
						{
						    case 0:
						    {
								mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pFlyLic` SET DEFAULT '1'",false,"","");
                                SCM(playerid, -1, " Вы включили выдачу лицензии на полёты при регистрации");
						    }
						    case 1:
						    {
						    	mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pFlyLic` SET DEFAULT '0'",false,"","");
                                SCM(playerid, -1, " Вы отключили выдачу лицензии на полёты при регистрации");
						    }
						}
					}
		        }
		        case 6: // pBoatLic
		        {
                    mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.columns WHERE `TABLE_name` = 'accounts' AND\
					`COLUMN_NAME` = 'pBoatLic'");
					mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
						new def[64];
						cache_get_field_content(1,"COLUMN_DEFAULT",def,DATABASE,sizeof(def));
						switch(strval(def))
						{
						    case 0:
						    {
								mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pBoatLic` SET DEFAULT '1'",false,"","");
                                SCM(playerid, -1, " Вы включили выдачу лицензии на водный транспорт при регистрации");
						    }
						    case 1:
						    {
						    	mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pBoatLic` SET DEFAULT '0'",false,"","");
                                SCM(playerid, -1, " Вы отключили выдачу лицензии на водный транспорт при регистрации");
						    }
						}
					}
		        }
		        case 7: // pFishLic
		        {
                    mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.columns WHERE `TABLE_name` = 'accounts' AND\
					`COLUMN_NAME` = 'pFishLic'");
					mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
						new def[64];
						cache_get_field_content(1,"COLUMN_DEFAULT",def,DATABASE,sizeof(def));
						switch(strval(def))
						{
						    case 0:
						    {
								mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pFishLic` SET DEFAULT '1'",false,"","");
                                SCM(playerid, -1, " Вы включили выдачу лицензии на рыболовлю при регистрации");
						    }
						    case 1:
						    {
						    	mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pFishLic` SET DEFAULT '0'",false,"","");
                                SCM(playerid, -1, " Вы отключили выдачу лицензии на рыболовлю при регистрации");
						    }
						}
					}
		        }
		        case 8: // pGunLic
		        {
                    mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.columns WHERE `TABLE_name` = 'accounts' AND\
					`COLUMN_NAME` = 'pGunLic'");
					mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
						new def[64];
						cache_get_field_content(1,"COLUMN_DEFAULT",def,DATABASE,sizeof(def));
						switch(strval(def))
						{
						    case 0:
						    {
								mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pGunLic` SET DEFAULT '1'",false,"","");
                                SCM(playerid, -1, " Вы включили выдачу лицензии на оружие при регистрации");
						    }
						    case 1:
						    {
						    	mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pGunLic` SET DEFAULT '0'",false,"","");
                                SCM(playerid, -1, " Вы отключили выдачу лицензии на оружие при регистрации");
						    }
						}
					}
		        }
		        case 9: // pGunSkills
		        {
                    mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.columns WHERE `TABLE_name` = 'accounts' AND\
					`COLUMN_NAME` = 'pGunSkills'");
					mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
						new def[64];
						cache_get_field_content(1,"COLUMN_DEFAULT",def,DATABASE,sizeof(def));
						if(!strcmp(def, "0, 0, 0, 0, 0, 0"))
						{
							mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pGunSkills` SET DEFAULT '100, 100, 100, 100, 100, 100'",false,"","");
       						SCM(playerid, -1, " Вы включили выдачу навыка владения оружием при регистрации");
						}
						else if(!strcmp(def, "100, 100, 100, 100, 100, 100"))
						{
							mysql_function_query(DATABASE,"ALTER TABLE `accounts` ALTER COLUMN `pGunSkills` SET DEFAULT '0, 0, 0, 0, 0, 0'",false,"","");
       						SCM(playerid, -1, " Вы отключили выдачу навыка владения оружием при регистрации");
						}
					}
		        }
		    }
			SetTimerEx("_ServerBonus" , 250, false, "i", playerid);
		}
	case 5255:
	    {
	        if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/serverbonus");
			if(GetPVarInt(playerid, "serverBonus") == 0) // pLevel
			{
				if(strlen(inputtext) == 0 || strval(inputtext) < 1 || strval(inputtext) > 1000)
				{
		            return ShowPlayerDialog(playerid, 5255, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите значение", "Далее", "Назад");
				}
				mysql_format(DATABASE, QUERY, 128, "ALTER TABLE `accounts` ALTER COLUMN `pLevel` SET DEFAULT '%i'",strval(inputtext));
				mysql_function_query(DATABASE,QUERY,false,"","");
				SendMes(playerid, -1, " Вы изменили начальный уровень при регистрации на %i", strval(inputtext));
			}
			else if(GetPVarInt(playerid, "serverBonus") == 1) // pBank
			{
				if(strlen(inputtext) == 0 || strval(inputtext) < 0 || strval(inputtext) > 999999999)
				{
		            return ShowPlayerDialog(playerid, 5255, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите значение", "Далее", "Назад");
				}
				mysql_format(DATABASE, QUERY, 128, "ALTER TABLE `accounts` ALTER COLUMN `pBank` SET DEFAULT '%i'",strval(inputtext));
				mysql_function_query(DATABASE,QUERY,false,"","");
				SendMes(playerid, -1, " Вы изменили начальные деньги в банке при регистрации на %i", strval(inputtext));
			}
			else if(GetPVarInt(playerid, "serverBonus") == 2) // pCash
			{
				if(strlen(inputtext) == 0 || strval(inputtext) < 0 || strval(inputtext) > 999999999)
				{
		            return ShowPlayerDialog(playerid, 5255, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите значение", "Далее", "Назад");
				}
				mysql_format(DATABASE, QUERY, 128, "ALTER TABLE `accounts` ALTER COLUMN `pCash` SET DEFAULT '%i'",strval(inputtext));
				mysql_function_query(DATABASE,QUERY,false,"","");
				SendMes(playerid, -1, " Вы изменили начальные деньги на руках при регистрации на %i", strval(inputtext));
			}
			SetTimerEx("_ServerBonus" , 250, false, "i", playerid);
	    }
	case 19270:
	    {
	        if(!response) return true;
	        switch(listitem)
	        {
	            case 0..4:
				{
				    if(FarmInfo[listitem+1][isCaptured])
				    {
				        return SCM(playerid, COLOR_GREY, " За этот бизнес уже была война!");
				    }
				    if(FarmInfo[listitem+1][fBiker] == 0)
				    {
				        if(IsCaptedBiker(PTEMP[playerid][pMember]) == 1) return SCM(playerid, COLOR_GREY, " Вы уже воевали недавно. Попробуйте через пару часов.");
						FarmInfo[listitem+1][fBiker] = PTEMP[playerid][pMember];
				        format(string, sizeof(string), " Вы завладели Фермой №%i", listitem);
				        SendFamilyMessage(PTEMP[playerid][pMember], COLOR_GREEN, string);
				        SetTimer("_CanCaptBiker",7200000, true);
				        FarmInfo[listitem+1][isCaptured] = true;
				        switch(PTEMP[playerid][pMember])
						{
						    case 24: IsCapted[hells] = true;
						    case 26: IsCapted[warloks] = true;
						    case 29: IsCapted[pagans] = true;
						}
				        return true;
				    }
				    else if(PTEMP[playerid][pMember] != FarmInfo[listitem][fBiker])
				    {
				        if(BikerCapture[atack] == 0 && BikerCapture[other] == 0)
				        {
							if(IsCaptedBiker(PTEMP[playerid][pMember]) == 1) return SCM(playerid, COLOR_GREY, " Вы уже воевали недавно. Попробуйте через пару часов.");
							if(IsCaptedBiker(FarmInfo[listitem+1][fBiker]) == 1) return SCM(playerid, COLOR_GREY, " Этот клуб уже воевал недавно. Попробуйте через пару часов.");
							BikerCapture[atack] = PTEMP[playerid][pMember];
				            BikerCapture[other] = FarmInfo[listitem+1][fBiker];
				            BikerCapture[reasons] = listitem;
				            format(string, sizeof(string), " Вы объявили войну %s! Начало через 15 минут.", GetNameOfBiker(FarmInfo[listitem+1][fBiker]));
				            SendFamilyMessage(BikerCapture[atack], COLOR_GREEN, string);
				            format(string, sizeof(string), " Вам объявили войну %s! Начало через 15 минут. Ваша задача удержать зону, отмеченную на карте", GetNameOfBiker(FarmInfo[listitem+1][fBiker]));
				            SendFamilyMessage(BikerCapture[other], COLOR_REDD, string);
				            BikerCapt(BikerCapture[atack], BikerCapture[other]);
							switch(BikerCapture[atack])
							{
							    case 24: IsCapted[hells] = true;
							    case 26: IsCapted[warloks] = true;
							    case 29: IsCapted[pagans] = true;
							}
							switch(BikerCapture[other])
							{
							    case 24: IsCapted[hells] = true;
							    case 26: IsCapted[warloks] = true;
							    case 29: IsCapted[pagans] = true;
							}
							SetTimer("_CanCaptBiker", 7200000, true);
							SetTimer("_StopCaptureBiker", 900000, true);
							FarmInfo[listitem+1][isCaptured] = true;
				        }
				    }
				    else if(PTEMP[playerid][pMember] == FarmInfo[listitem][fBiker]) return SCM(playerid, COLOR_GREY, " Этот бизнес ваш!");
				}
				case 5..7:
				{
				    new list = listitem - 5;
				    if(WorkshopInfo[list+1][isCaptured])
				    {
				        return SCM(playerid, COLOR_GREY, " За этот бизнес уже была война!");
				    }
				    if(WorkshopInfo[list+1][wBiker] == 0)
				    {
						if(IsCaptedBiker(PTEMP[playerid][pMember]) == 1) return SCM(playerid, COLOR_GREY, " Вы уже воевали недавно. Попробуйте через пару часов.");
						WorkshopInfo[list+1][wBiker] = PTEMP[playerid][pMember];
				        format(string, sizeof(string), " Вы завладели Мастерской №%i", list);
				        SendFamilyMessage(PTEMP[playerid][pMember], COLOR_GREEN, string);
				        SetTimer("_CanCaptBiker",7200000, true);
				        WorkshopInfo[list+1][isCaptured] = true;
				        switch(PTEMP[playerid][pMember])
						{
						    case 24: IsCapted[hells] = true;
						    case 26: IsCapted[warloks] = true;
						    case 29: IsCapted[pagans] = true;
						}
				        return true;
				    }
				    else if(PTEMP[playerid][pMember] != WorkshopInfo[list+1][wBiker])
				    {
				        if(BikerCapture[atack] == 0 && BikerCapture[other] == 0)
				        {
                            if(IsCaptedBiker(PTEMP[playerid][pMember]) == 1) return SCM(playerid, COLOR_GREY, " Вы уже воевали недавно. Попробуйте через пару часов.");
							if(IsCaptedBiker(WorkshopInfo[list+1][wBiker]) == 1) return SCM(playerid, COLOR_GREY, " Этот клуб уже воевал недавно. Попробуйте через пару часов.");
							BikerCapture[atack] = PTEMP[playerid][pMember];
				            BikerCapture[other] = WorkshopInfo[list+1][wBiker];
				            BikerCapture[reasons] = list;
				            format(string, sizeof(string), " Вы объявили войну %s! Начало через 15 минут.", GetNameOfBiker(WorkshopInfo[list+1][wBiker]));
				            SendFamilyMessage(BikerCapture[atack], COLOR_GREEN, string);
				            format(string, sizeof(string), " Вам объявили войну %s! Начало через 15 минут. Ваша задача удержать зону, отмеченную на карте", GetNameOfBiker(WorkshopInfo[list+1][wBiker]));
				            SendFamilyMessage(BikerCapture[other], COLOR_REDD, string);
				            BikerCapt(BikerCapture[atack], BikerCapture[other]);
				            switch(BikerCapture[atack])
							{
							    case 24: IsCapted[hells] = true;
							    case 26: IsCapted[warloks] = true;
							    case 29: IsCapted[pagans] = true;
							}
							switch(BikerCapture[other])
							{
							    case 24: IsCapted[hells] = true;
							    case 26: IsCapted[warloks] = true;
							    case 29: IsCapted[pagans] = true;
							}
							SetTimer("_CanCaptBiker", 7200000, true);
							SetTimer("_StopCaptureBiker", 900000, true);
							WorkshopInfo[list+1][isCaptured] = true;
				        }
				    }
				    else if(PTEMP[playerid][pMember] == WorkshopInfo[list+1][wBiker]) return SCM(playerid, COLOR_GREY, " Этот бизнес ваш!");
				}
	        }
	    }
	case 5693:
	    {
	        if(!response) return true;
	        switch(listitem)
	        {
	            case 0:
	            {
	                format(string, sizeof(string), "Имя\t\tОчки\n\
													[0] Rifa\t\t%i\n\
													[1] Grove street\t\t%i\n\
													[2] Ballas\t\t%i\n\
													[3] Vagos\t\t%i\n\
													[4] Aztec\t\t%i\n",
													gRating[Rifa], gRating[Grove], gRating[Ballas], gRating[Vagos], gRating[Aztec]);
             		ShowPlayerDialogEx(playerid, 5694, DIALOG_STYLE_TABLIST_HEADERS, "Банды", string, "Выбрать", "Назад");
	            }
	            case 1:
	            {
	                new Names[32], query[1028], gratings;
	                format(query, sizeof(query), "Имя\t\tОчки\nМой рейтинг\t\t%i\n", PTEMP[playerid][pGRating]);
	                mysql_format(DATABASE, QUERY, 62, "SELECT `Name`,`grating` FROM `"TABLE_ACCOUNTS"` WHERE `grating` > '0'");
					mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
						for(new i = 0; i < r; i++)
						{
							new strin[40];
							cache_get_field_content(i,"Name",Names,DATABASE,60);
							gratings = cache_get_field_content_int(i, "grating");
				            format(strin,sizeof(strin),"[%i] %s\t%i\n",i, Names, gratings);
							strcat(query, strin);
						}
					}
					ShowPlayerDialogEx(playerid, 5695, DIALOG_STYLE_TABLIST_HEADERS, "Игроки", query, "Выбрать", "Назад");
	            }
	            case 2:
	            {
	                new sdate[32], query[128];
	                mysql_format(DATABASE, QUERY, 62, "SELECT date FROM `gratinghistory`");
					mysql_query(DATABASE, QUERY);
					new r = cache_num_rows();
					if(r)
					{
						for(new i = 0; i < r; i++)
						{
							new strin[40];
							cache_get_field_content(i,"date",sdate,DATABASE,32);
				            format(strin,sizeof(strin),"%s\n", sdate, grating);
							strcat(query, strin);
						}
					}
					ShowPlayerDialogEx(playerid, 5696, DIALOG_STYLE_LIST, "История", query, "Выбрать", "Назад");
	            }
	        }
	    }
	case 5694:
	    {
			if(response)
			{
				format(string, sizeof(string), "Имя\t\tОчки\n\
													[0] Rifa\t\t%i\n\
													[1] Grove street\t\t%i\n\
													[2] Ballas\t\t%i\n\
													[3] Vagos\t\t%i\n\
													[4] Aztec\t\t%i\n",
													gRating[Rifa], gRating[Grove], gRating[Ballas], gRating[Vagos], gRating[Aztec]);
           		ShowPlayerDialogEx(playerid, 5694, DIALOG_STYLE_TABLIST_HEADERS, "Банды", string, "Выбрать", "Назад");
  			}
  			else if(!response)
  			{
  			    CallLocalFunction("OnPlayerCommandText", "is", playerid, "/grating");
  			}
	    }
	case 5695:
	    {
	    	if(response)
			{
				new Names[32], query[1028], gratings;
                format(query, sizeof(query), "Имя\t\tОчки\nМой рейтинг\t\t%i\n", PTEMP[playerid][pGRating]);
                mysql_format(DATABASE, QUERY, 62, "SELECT `Name`,`grating` FROM `"TABLE_ACCOUNTS"` WHERE `grating` > '0'");
				mysql_query(DATABASE, QUERY);
				new r = cache_num_rows();
				if(r)
				{
					for(new i = 0; i < r; i++)
					{
						new strin[40];
						cache_get_field_content(i,"Name",Names,DATABASE,60);
						gratings = cache_get_field_content_int(i, "grating");
			            format(strin,sizeof(strin),"[%i] %s\t%i\n",i, Names, gratings);
						strcat(query, strin);
					}
				}
				ShowPlayerDialogEx(playerid, 5695, DIALOG_STYLE_TABLIST_HEADERS, "Игроки", query, "Выбрать", "Назад");
  			}
  			else if(!response)
  			{
  			    CallLocalFunction("OnPlayerCommandText", "is", playerid, "/grating");
  			}
	    }
	case 5696:
	    {
	        if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/grating");
            new query[512], player[32], playerMark, agGrove, agBallas, agRifa, agAztec, agVagos;
            format(query, sizeof(query), "Имя\t\tОчки\n[0] [ЛУЧШИЙ ИГРОК]\n");
            mysql_format(DATABASE, QUERY, 62, "SELECT * FROM `gratinghistory` WHERE date = '%s'", inputtext);
			mysql_query(DATABASE, QUERY);
			SetPVarString(playerid, "grhistory", inputtext);
			new r = cache_num_rows();
			if(r)
			{
				new strin[512];
				cache_get_field_content(0,"player",player,DATABASE,60);
				playerMark = cache_get_field_content_int(0, "playerMark");
	            format(strin,sizeof(strin),"[1] %s\t\t%i\n[2] [БАНДЫ]\n", player, playerMark);
				strcat(query, strin);
				agGrove = cache_get_field_content_int(0, "Grove street");
				agBallas = cache_get_field_content_int(0, "Ballas");
				agRifa = cache_get_field_content_int(0, "Rifa");
				agAztec = cache_get_field_content_int(0, "Aztec");
				agVagos = cache_get_field_content_int(0, "Vagos");
				format(strin, sizeof(strin), "[3] Grove street\t\t%i\n\
	   										  [4] Ballas\t\t%i\n\
	   										  [5] Rifa\t\t%i\n\
	   										  [6] Aztec\t\t%i\n\
	   										  [7] Vagos\t\t%i\n",agGrove, agBallas, agRifa, agAztec, agVagos);
				strcat(query, strin);
			} else printf("Нет даных в gratinghistory");
			ShowPlayerDialogEx(playerid, 5697, DIALOG_STYLE_TABLIST_HEADERS, "Меню", query, "Выбрать", "Назад");
	    }
	case 5697:
	    {
	        if(!response)
	        {
	            new sdate[32], query[128];
                mysql_format(DATABASE, QUERY, 62, "SELECT date FROM `gratinghistory`");
				mysql_query(DATABASE, QUERY);
				new r = cache_num_rows();
				if(r)
				{
					for(new i = 0; i < r; i++)
					{
						new strin[40];
						cache_get_field_content(i,"date",sdate,DATABASE,32);
			            format(strin,sizeof(strin),"%s\n", sdate, grating);
						strcat(query, strin);
					}
				}
				ShowPlayerDialogEx(playerid, 5696, DIALOG_STYLE_LIST, "История", query, "Выбрать", "Назад");
	        }
			else
			{
	            new query[512], player[32], playerMark, agGrove, agBallas, agRifa, agAztec, agVagos;
	            format(query, sizeof(query), "Имя\t\tОчки\n[0] [ЛУЧШИЙ ИГРОК]\n");
				new sss[32];
				GetPVarString(playerid, "grhistory", sss, 32);
	            mysql_format(DATABASE, QUERY, 62, "SELECT * FROM `gratinghistory` WHERE date = '%s'", sss);
				mysql_query(DATABASE, QUERY);
				new r = cache_num_rows();
				if(r)
				{
					new strin[512];
					cache_get_field_content(0,"player",player,DATABASE,60);
					playerMark = cache_get_field_content_int(0, "playerMark");
		            format(strin,sizeof(strin),"[1] %s\t\t%i\n[2] [БАНДЫ]\n", player, playerMark);
					strcat(query, strin);
					agGrove = cache_get_field_content_int(0, "Grove street");
					agBallas = cache_get_field_content_int(0, "Ballas");
					agRifa = cache_get_field_content_int(0, "Rifa");
					agAztec = cache_get_field_content_int(0, "Aztec");
					agVagos = cache_get_field_content_int(0, "Vagos");
					format(strin, sizeof(strin), "[3] Grove street\t\t%i\n\
		   										  [4] Ballas\t\t%i\n\
		   										  [5] Rifa\t\t%i\n\
		   										  [6] Aztec\t\t%i\n\
		   										  [7] Vagos\t\t%i\n",agGrove, agBallas, agRifa, agAztec, agVagos);
					strcat(query, strin);
				} else printf("Нет даных в gratinghistory");
				ShowPlayerDialogEx(playerid, 5697, DIALOG_STYLE_TABLIST_HEADERS, "Меню", query, "Выбрать", "Назад");
			}
	    }
	case 21021:
	    {
	        if(!response) return true;
	        if(!strcmp(inputtext, "Назначить саппорта", true))
	        {
	            return ShowPlayerDialogEx(playerid, 21023, DIALOG_STYLE_INPUT, "Добавить саппорта", "Введите ник нейм саппорта", "Добавтиь", "Назад");
	        }
	        SetPVarString(playerid, "SelectedSupport", inputtext);
	        new query[128];
	        format(query, sizeof(query), "[0] Разморозить права\n[1] Заморозить права\n");
	        if(PTEMP[playerid][pAdmin] > 7) strcat(query, "[2] Снять саппорта", sizeof(query));
	        ShowPlayerDialogEx(playerid, 21022, DIALOG_STYLE_LIST, "Управление саппортами", query, "Выбор", "Назад");
	    }
	case 21022:
	    {
	        if(!response) return DeletePVar(playerid, "SelectedSupport"),SetTimerEx("_SpMenu" , 50, false, "i", playerid);
			new Names[32];
			GetPVarString(playerid, "SelectedSupport", Names, sizeof(Names));
			switch(listitem)
			{
			    case 0:
				{
				    format(string, sizeof(string), "/setsupport %s 1", Names);
					CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
				}
				case 1:
				{
					format(string, sizeof(string), "/setsupport %s 0", Names);
					CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
				}
				case 2:
				{
					format(string, sizeof(string), "/addsupport %s 0", Names);
					CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
				}
			}
			SetTimerEx("_SpMenu" , 50, false, "i", playerid);
	    }
	case 21023:
	    {
	        if(!response) return DeletePVar(playerid, "SelectedSupport"),CallLocalFunction("OnPlayerCommandText", "is", playerid, "/spmenu");
			if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid, 21023, DIALOG_STYLE_INPUT, "Добавить саппорта", "Введите ник нейм саппорта", "Добавтиь", "Назад");
			format(string, sizeof(string), "/addsupport %s 1", inputtext);
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			SetTimerEx("_SpMenu" , 50, false, "i", playerid);
	    }
	case 21025:
	    {
	        if(!response) return true;
	        if(!strcmp(inputtext, "Назначить администратора", true))
	        {
	            return ShowPlayerDialogEx(playerid, 21026, DIALOG_STYLE_INPUT, "{00FF00}Назначить администратора", "Введите ник будущего администратора", "Продолжить", "Назад");
	        }
	        new niknames[32], lastcon[32], lvl;
	        sscanf(inputtext, "s",niknames);
	        SetPVarString(playerid, "selectedadmin", niknames);
	        mysql_format(DATABASE, QUERY, 62, "SELECT * FROM `"TABLE_ADMIN"` WHERE `Name` = '%s'", niknames);
			mysql_query(DATABASE, QUERY);
			new r = cache_num_rows();
			if(r)
			{
				cache_get_field_content(0,"LastCon",lastcon,DATABASE,60);
				lvl = cache_get_field_content_int(0, "level");
			}
			if(strlen(lastcon) == 0) lastcon = "Нет";
	        format(string, sizeof(string), "[Последний вход]\n%s \n[Уровень администратора]\n%i\n",lastcon, lvl);
	        if(PTEMP[playerid][pAdmin] >= 9)
	        {
	            new strs[128];
	            format(strs, sizeof(strs), "Изменить уровень администратора\nСнять администратора");
	            strcat(string, strs);
	        }
	        ShowPlayerDialogEx(playerid, 21028, DIALOG_STYLE_LIST, niknames, string, "Выбор", "Назад");
	    }
	case 21026:
	    {
	        if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/admmenu");
	        if(strlen(inputtext) == 0) return ShowPlayerDialogEx(playerid, 21026, DIALOG_STYLE_INPUT, "{00FF00}Назначить администратора", "Введите ник будущего администратора", "Продолжить", "Назад");
	        SetPVarString(playerid, "chosenadmin", inputtext);
	        ShowPlayerDialogEx(playerid, 21027, DIALOG_STYLE_INPUT, inputtext, "Введите уровень администратора", "Назначить", "Назад");
	    }
	case 21027:
	    {
	        if(!response) return ShowPlayerDialogEx(playerid, 21026, DIALOG_STYLE_INPUT, "{00FF00}Назначить администратора", "Введите ник будущего администратора", "Продолжить", "Назад"), DeletePVar(playerid, "chosenadmin");
			new lvl = strval(inputtext);
			if(!strlen(inputtext) || !lvl) ShowPlayerDialogEx(playerid, 21027, DIALOG_STYLE_INPUT, inputtext, "Введите уровень администратора", "Назначить", "Назад");
			new Names[32];
			GetPVarString(playerid, "chosenadmin", Names, 32);
			format(string, sizeof(string), "/addmoderation %s %i", Names, lvl);
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			SetTimerEx("_AdmMenu" , 50, false, "i", playerid);
		}
	case 21028:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/admmenu");
			if(listitem >= 0 && listitem <= 3)
			{
			    new niknames[32], lastcon[32], lvl;
		        GetPVarString(playerid, "selectedadmin", niknames, 32);
		        mysql_format(DATABASE, QUERY, 62, "SELECT * FROM `"TABLE_ADMIN"` WHERE `Name` = '%s'", niknames);
				mysql_query(DATABASE, QUERY);
				new r = cache_num_rows();
				if(r)
				{
					cache_get_field_content(0,"LastCon",lastcon,DATABASE,60);
					lvl = cache_get_field_content_int(0, "level");
				}
				if(!strcmp(lastcon, "", true)) lastcon = "Нет";
		        format(string, sizeof(string), "[Последний вход]\n%s\n[Уровень администратора]\n%i\n",lastcon, lvl);
		        if(PTEMP[playerid][pAdmin] > 8)
		        {
		            new strs[128];
		            format(strs, sizeof(strs), "Изменить уровень администратора\nСнять администратора");
		            strcat(string, strs);
		        }
		        ShowPlayerDialogEx(playerid, 21028, DIALOG_STYLE_LIST, niknames, string, "Выбор", "Назад");
			}
			else if(listitem == 4)
			{
				ShowPlayerDialogEx(playerid, 21029, DIALOG_STYLE_INPUT, "Изменить уровень администратора", "Введите новый уровень администратора", "Выбор", "Назад");
			}
			else if(listitem == 5)
			{
			    new sss[32];
			    GetPVarString(playerid, "selectedadmin", sss, 32);
				format(string, sizeof(string), "Вы уверены, что хотите снять администратора\n{FF0000}\t\t%s", sss);
				ShowPlayerDialogEx(playerid, 21030, DIALOG_STYLE_MSGBOX, "{FF0000}Снять администратора", string, "Снять", "Назад");
			}
		}
	case 21029:
	    {
			if(!response)
			{
			    new niknames[32], lastcon[32], lvl;
		        GetPVarString(playerid, "selectedadmin", niknames, 32);
		        mysql_format(DATABASE, QUERY, 62, "SELECT * FROM `"TABLE_ADMIN"` WHERE `Name` = '%s'", niknames);
				mysql_query(DATABASE, QUERY);
				new r = cache_num_rows();
				if(r)
				{
					cache_get_field_content(0,"LastCon",lastcon,DATABASE,60);
					lvl = cache_get_field_content_int(0, "level");
				}
				if(!strcmp(lastcon, "", true)) lastcon = "Нет";
		        format(string, sizeof(string), "[Последний вход]\n%s\n[Уровень администратора]\n%i\n",lastcon, lvl);
		        if(PTEMP[playerid][pAdmin] > 8)
		        {
		            new strs[128];
		            format(strs, sizeof(strs), "Изменить уровень администратора\nСнять администратора");
		            strcat(string, strs);
		        }
		        return ShowPlayerDialogEx(playerid, 21028, DIALOG_STYLE_LIST, niknames, string, "Выбор", "Назад");
			}
			new lvl = strval(inputtext);
			if(!strlen(inputtext) || !lvl) return ShowPlayerDialogEx(playerid, 21029, DIALOG_STYLE_INPUT, "Изменить уровень администратора", "Введите новый уровень администратора", "Выбор", "Назад");
			new niknames[32];
			GetPVarString(playerid, "selectedadmin", niknames, 32);
			format(string, sizeof(string), "/addmoderation %s %i", niknames, lvl);
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			SetTimerEx("_AdmMenu" , 50, false, "i", playerid);
	    }
	case 21030:
	    {
	        if(!response)
			{
			    new niknames[32], lastcon[32], lvl;
		        GetPVarString(playerid, "selectedadmin", niknames, 32);
		        mysql_format(DATABASE, QUERY, 62, "SELECT * FROM `"TABLE_ADMIN"` WHERE `Name` = '%s'", niknames);
				mysql_query(DATABASE, QUERY);
				new r = cache_num_rows();
				if(r)
				{
					cache_get_field_content(0,"LastCon",lastcon,DATABASE,60);
					lvl = cache_get_field_content_int(0, "level");
				}
				if(!strcmp(lastcon, "", true)) lastcon = "Нет";
		        format(string, sizeof(string), "[Последний вход]\n%s\n[Уровень администратора]\n%i\n",lastcon, lvl);
		        if(PTEMP[playerid][pAdmin] > 8)
		        {
		            new strs[128];
		            format(strs, sizeof(strs), "Изменить уровень администратора\nСнять администратора");
		            strcat(string, strs);
		        }
		        return ShowPlayerDialogEx(playerid, 21028, DIALOG_STYLE_LIST, niknames, string, "Выбор", "Назад");
			}
	        new niknames[32];
			GetPVarString(playerid, "selectedadmin", niknames, 32);
			format(string, sizeof(string), "/addmoderation %s 0", niknames);
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			SetTimerEx("_AdmMenu" , 50, false, "i", playerid);
	    }
	case 21032:
	    {
			if(!response) return true;
			CallLocalFunction("OnPlayerCommandText", "is", playerid, "/members 1");
	    }
	case 1135:
	 	{
	   		if(!response) return true;
	     	new str[512];
	     	for(new h = 0; h < idgols; h++)
	 		{
	 			new strz[64];
	 			format(strz,sizeof(str2),"%s\n",Golosovan[h][Variant]);
	 			strcat(str,strz,sizeof(str));
	 		}
	 		ShowPlayerDialogEx(playerid,1134,DIALOG_STYLE_LIST,GL2[NameGolos],str,"Выбор","Отмена");
	 	}
    case 1134:
	 	{
			if(!response) return true;
			if(PTEMP[playerid][progolos] == true) return SCM(playerid,COLOR_GREY," Вы уже голосовали!");
			Golosovan[listitem][Golosov] ++;
			PTEMP[playerid][progolos] = true;
			SCM(playerid,COLOR_GREY," Ваш голос учтён, Спасибо");
	 	}
    case 1132:
	    {
			if(!strlen(inputtext)) return true;
			strmid(GL2[NameGolos],inputtext,0,128,256);
			format(string,sizeof(string)," Вы создали голосование - %s.",inputtext);
			SCM(playerid,COLOR_LIGHTBLUE,string);
			GL2[goloson] = true;
			ShowPlayerDialogEx(playerid,1133,1,"Создание вариантов ответа","Введите Вариант №1","Далее","");
	    }
    case 1133:
	    {
			if(!response) return true;
			if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid,1133,1,"Создание вариантов ответа","Введите следующий вариант","Далее","");
			strmid(Golosovan[idgols][Variant],inputtext,0,128,256);
			Golosovan[idgols][Golosov] = 0;
			ShowPlayerDialogEx(playerid,1133,1,"Создание вариантов ответа","Введите следующий вариант","Далее","");
			idgols++;
	    }
	case 6:
	    {
	        if(!response)
			{
				DeletePVar(playerid,"ATPX");
				DeletePVar(playerid,"ATPY");
				DeletePVar(playerid,"ATPZ");
				return 1;
			}
			SetPlayerPos(playerid,GetPVarFloat(playerid,"ATPX"),GetPVarFloat(playerid,"ATPY"),GetPVarFloat(playerid,"ATPZ"));
			DeletePVar(playerid,"ATPX");
			DeletePVar(playerid,"ATPY");
			DeletePVar(playerid,"ATPZ");
	    }
	case 1000:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/offmembers"), ShowPlayerDialogEx(playerid, 1000, DIALOG_STYLE_LIST, "Панель лидера", "[0] Игроки в Offline\n[1] Понизить/повысить игрока в Offline\n[2] Уволить игрока в Offline\n[3] Снять деньги с банка", "Выбрать", "Назад");
			case 1: ShowPlayerDialogEx(playerid,1001,DIALOG_STYLE_INPUT, "Понизить/повысить игрока в Offline", "Введите в строку для ввода\n[Имя] [Ранг]", "Принять","Назад");
			case 2: ShowPlayerDialogEx(playerid,1002,DIALOG_STYLE_INPUT, "Уволить игрока в Offline", "Введите в строку для ввода имя игрока\nКоторого хотите уволить", "Принять","Назад");
			}
		}
	case 1001:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 1000, DIALOG_STYLE_LIST, "Панель лидера", "[0] Игроки в Offline\n[1] Понизить/повысить игрока в Offline\n[2] Уволить игрока в Offline\n[3] Снять деньги с банка", "Выбрать", "Назад");
			new params_name[60],rank;
			if(sscanf(inputtext, "s[60]i",params_name,rank)) return ShowPlayerDialogEx(playerid,1001,DIALOG_STYLE_INPUT, "Понизить/повысить игрока в Offline", "Введите в строку для ввода\n[Имя] | [Ранг]", "Принять","Назад");
			new mess[40];
			format(mess, sizeof(mess), "/offgiverank %s %i",params_name,rank);
			CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);
			return ShowPlayerDialogEx(playerid, 1000, DIALOG_STYLE_LIST, "Панель лидера", "[0] Игроки в Offline\n[1] Понизить/повысить игрока в Offline\n[2] Уволить игрока в Offline\n[3] Снять деньги с банка", "Выбрать", "Назад");
		}
	case 1002:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 1000, DIALOG_STYLE_LIST, "Панель лидера", "[0] Игроки в Offline\n[1] Понизить/повысить игрока в Offline\n[2] Уволить игрока в Offline\n[3] Снять деньги с банка", "Выбрать", "Назад");
			new params_name[60];
			if(sscanf(inputtext, "s[60]",params_name)) return ShowPlayerDialogEx(playerid,1002,DIALOG_STYLE_INPUT, "Уволить игрока в Offline", "Введите в строку для ввода имя игрока\nКоторого хотите уволить", "Принять","Назад");
			new mess[40];
			format(mess, sizeof(mess), "/offuninvite %s",params_name);
			CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);
			return ShowPlayerDialogEx(playerid, 1000, DIALOG_STYLE_LIST, "Панель лидера", "[0] Игроки в Offline\n[1] Понизить/повысить игрока в Offline\n[2] Уволить игрока в Offline\n[3] Снять деньги с банка", "Выбрать", "Назад");
		}
	case 1375:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: {ShowPlayerDialogEx(playerid,1377,DIALOG_STYLE_LIST,"Выберите тип бизнеса","Бары и клубы\nЗакусочные\nМагазины 24/7\nЗаправки", "Выбрать", "Назад");}
			case 1: {ShowPlayerDialogEx(playerid,1386,DIALOG_STYLE_LIST,"Выберите тип бизнеса","Бары и клубы\nЗакусочные\nМагазины 24/7\nЗаправки", "Выбрать", "Назад");}
			case 2: ShowPlayerDialogEx(playerid,1376,DIALOG_STYLE_LIST,"Выберите тип бизнеса","Бары и клубы\nЗакусочные\nМагазины 24/7\nЗаправки", "Выбрать", "Назад");
			case 3: {CallLocalFunction("OnPlayerCommandText", "is", playerid, "/pskill");}
			case 4: {ShowPlayerDialogEx(playerid,1228,DIALOG_STYLE_MSGBOX, " ", "Вы уверены, что хотите выбросить продукты?", "Выбросить", "Отмена");}
			}
			return true;
		}
	case 1376:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/prodmenu");
			string = "";
			strcat(string,"{FFFFFF}[Бизнес]  {0076FC}[Цена за 1 продукт]  {10762D}[Требуется продуктов]\n\n");
			for(new i = 1; i <= TotalBizz; i++)
			{
				if(BizzInfo[i][bType] != listitem+1) continue;
				format(YCMDstr,128,"{FFFFFF}%s  {0076FC}%i  {10762D}%i\n",BizzInfo[i][bMessage], BizzInfo[i][bProdPrice], BizzMaxProds[i]-BizzInfo[i][bProducts]);
				strcat(string,YCMDstr);
			}
			return ShowPlayerDialogEx(playerid,0,DIALOG_STYLE_MSGBOX,"Мониторинг",string, "Готово", "");
		}
	case 1386:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					CallLocalFunction("OnPlayerCommandText", "is", playerid, "/sellprodsone");
				}
			case 1:
				{
					CallLocalFunction("OnPlayerCommandText", "is", playerid, "/sellprodstwo");
				}
			case 2:
				{
					CallLocalFunction("OnPlayerCommandText", "is", playerid, "/sellprodsthree");
				}
			case 3:
				{
					CallLocalFunction("OnPlayerCommandText", "is", playerid, "/sellprodsfour");
				}
			}
		}
	case 1377:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					new newcar = GetPlayerVehicleID(playerid);
					if(newcar >= comptruck[4] && newcar <= comptruck[9])
					{
						ShowPlayerDialogEx(playerid,1378, DIALOG_STYLE_INPUT, "Закупка товаров / еды","Введите количество продуктов от 1 до 200", "Готово", "Отмена");
					}
					else return SCM(playerid,COLOR_GREY," Нужно быть в транспортном средстве, которое может перевозить данный тип груза");
				}
			case 1:
				{
					new newcar = GetPlayerVehicleID(playerid);
					if(newcar >= comptruck[4] && newcar <= comptruck[9])
					{
						ShowPlayerDialogEx(playerid,1379, DIALOG_STYLE_INPUT, "Закупка товаров / еды","Введите количество продуктов от 1 до 200", "Готово", "Отмена");
					}
					else return SCM(playerid,COLOR_GREY," Нужно быть в транспортном средстве, которое может перевозить данный тип груза");
				}
			case 2:
				{
					new newcar = GetPlayerVehicleID(playerid);
					if(newcar >= comptruck[4] && newcar <= comptruck[9])
					{
						ShowPlayerDialogEx(playerid,1380, DIALOG_STYLE_INPUT, "Закупка товаров / еды","Введите количество продуктов от 1 до 200", "Готово", "Отмена");
					}
					else return SCM(playerid,COLOR_GREY," Нужно быть в транспортном средстве, которое может перевозить данный тип груза");
				}
			case 3:
				{
					new newcar = GetPlayerVehicleID(playerid);
					if(newcar >= comptruck[2] && newcar <= comptruck[3])
					{
						ShowPlayerDialogEx(playerid,1381, DIALOG_STYLE_INPUT, "Закупка топлива","Введите количество литров от 1 до 1000", "Готово", "Отмена");
					}
					else return SCM(playerid,COLOR_GREY," Нужно быть в транспортном средстве, которое может перевозить данный тип груза");
				}
			}
		}
	case 1378:
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[4] && newcar <= comptruck[9])
			{
				if(!response || PTEMP[playerid][pJob] != 5) return true;
				if(!strlen(inputtext) || strval(inputtext) < 0) return SCM(playerid,COLOR_GREY," Неверное количество!");
				if(strval(inputtext) < 0 || strval(inputtext) > PTEMP[playerid][pPMGruz]) return SendMes(playerid,COLOR_GREY," Минимальное количество - 1,максимальное - %i",PTEMP[playerid][pPMGruz]);
				if(PTEMP[playerid][pCash] < strval(inputtext)*15) return SCM(playerid,COLOR_GREY," У вас не достаточно денег!");
				if(car_prods[GetPlayerVehicleID(playerid)][3]+strval(inputtext) > 200) return SCM(playerid,COLOR_GREY," В вашем транспортном средстве нет места");
				if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
				SetPVarInt(playerid, "kolvo", strval(inputtext));
				format(string,256,"Вы собираетесь купить продукты для Баров / Клубов\n\n{FFD500}Количество: %d\n{E51212}Стоимость: %d вирт\n{1CA628}Скидка: 0 вирт",strval(inputtext),strval(inputtext)*15);
				return ShowPlayerDialogEx(playerid,1382,DIALOG_STYLE_MSGBOX,"Покупка продуктов",string,"Купить","Отмена");
			}
			else return SCM(playerid,COLOR_GREY," Вы должны находиться в транспортном средстве");
		}
	case 1379:
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[4] && newcar <= comptruck[9])
			{
				if(!response || PTEMP[playerid][pJob] != 5) return true;
				if(!strlen(inputtext) || strval(inputtext) < 0) return SCM(playerid,COLOR_GREY," Неверное количество!");
				if(strval(inputtext) < 0 || strval(inputtext) > PTEMP[playerid][pPMGruz]) return SendMes(playerid,COLOR_GREY," Минимальное количество - 1,максимальное - %i",PTEMP[playerid][pPMGruz]);
				if(PTEMP[playerid][pCash] < strval(inputtext)*15) return SCM(playerid,COLOR_GREY," У вас не достаточно денег!");
				if(car_prods[GetPlayerVehicleID(playerid)][3]+strval(inputtext) > 200) return SCM(playerid,COLOR_GREY," В вашем транспортном средстве нет места");
				if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
				SetPVarInt(playerid, "kolvo", strval(inputtext));
				format(string,256,"Вы собираетесь купить продукты для закусочных\n\n{FFD500}Количество: %d\n{E51212}Стоимость: %d вирт\n{1CA628}Скидка: 0 вирт",strval(inputtext),strval(inputtext)*15);
				return ShowPlayerDialogEx(playerid,1383,DIALOG_STYLE_MSGBOX,"Покупка продуктов",string,"Купить","Отмена");
			}
			else return SCM(playerid,COLOR_GREY," Вы должны находиться в транспортном средстве");
		}
	case 1380:
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[4] && newcar <= comptruck[9])
			{
				if(!response || PTEMP[playerid][pJob] != 5) return true;
				if(!strlen(inputtext) || strval(inputtext) < 0) return SCM(playerid,COLOR_GREY," Неверное количество!");
				if(strval(inputtext) < 0 || strval(inputtext) > PTEMP[playerid][pPMGruz]) return SendMes(playerid,COLOR_GREY," Минимальное количество - 1,максимальное - %i",PTEMP[playerid][pPMGruz]);
				if(PTEMP[playerid][pCash] < strval(inputtext)*15) return SCM(playerid,COLOR_GREY," У вас не достаточно денег!");
				if(car_prods[GetPlayerVehicleID(playerid)][2]+strval(inputtext) > 200) return SCM(playerid,COLOR_GREY," В вашем транспортном средстве нет места");
				if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
				SetPVarInt(playerid, "kolvo", strval(inputtext));
				format(string,256,"Вы собираетесь купить товары для Магазинов 24/7\n\n{FFD500}Количество: %d\n{E51212}Стоимость: %d вирт\n{1CA628}Скидка: 0 вирт",strval(inputtext),strval(inputtext)*15);
				return ShowPlayerDialogEx(playerid,1384,DIALOG_STYLE_MSGBOX,"Покупка продуктов",string,"Купить","Отмена");
			}
			else return SCM(playerid,COLOR_GREY," Вы должны находиться в транспортном средстве");
		}
	case 1381:
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[2] && newcar <= comptruck[3])
			{
				if(!response || PTEMP[playerid][pJob] != 5) return true;
				if(!strlen(inputtext) || strval(inputtext) < 0) return SCM(playerid,COLOR_GREY," Неверное количество!");
				if(strval(inputtext) < 0 || strval(inputtext) > 1000) return SCM(playerid,COLOR_GREY," Минимальное количество - 1,максимальное - 1000");
				if(PTEMP[playerid][pCash] < strval(inputtext)*15) return SCM(playerid,COLOR_GREY," У вас не достаточно денег!");
				if(car_prods[GetPlayerVehicleID(playerid)][1]+strval(inputtext) > 1000) return SCM(playerid,COLOR_GREY," В вашем транспортном средстве нет места");
				if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
				SetPVarInt(playerid, "kolvo", strval(inputtext));
				format(string,256,"Вы собираетесь купить топливо для заправок\n\n{FFD500}Количество: %d\n{E51212}Стоимость: %d вирт\n{1CA628}Скидка: 0 вирт",strval(inputtext),strval(inputtext)*15);
				return ShowPlayerDialogEx(playerid,1385,DIALOG_STYLE_MSGBOX,"Покупка продуктов",string,"Купить","Отмена");
			}
			else return SCM(playerid,COLOR_GREY," Вы должны находиться в транспортном средстве");
		}
	case 1382:
		{
			if(!response) return true;
			car_prods[GetPlayerVehicleID(playerid)][3] += GetPVarInt(playerid,"kolvo");
			PTEMP[playerid][pCash]-=GetPVarInt(playerid,"kolvo")*15;
			SendMes(playerid,TEAM_GROVE_COLOR," Товары: %i / %i",car_prods[GetPlayerVehicleID(playerid)][2],PTEMP[playerid][pPMGruz]);
			SendMes(playerid,TEAM_GROVE_COLOR," Еда: %i / %i",car_prods[GetPlayerVehicleID(playerid)][3],PTEMP[playerid][pPMGruz]);
			DeletePVar(playerid,"Kolvo");
			return 1;
		}
	case 1383:
		{
			if(!response) return true;
			car_prods[GetPlayerVehicleID(playerid)][3] += GetPVarInt(playerid,"kolvo");
			PTEMP[playerid][pCash]-=GetPVarInt(playerid,"kolvo")*15;
			SendMes(playerid,TEAM_GROVE_COLOR," Товары: %i / %i",car_prods[GetPlayerVehicleID(playerid)][2],PTEMP[playerid][pPMGruz]);
			SendMes(playerid,TEAM_GROVE_COLOR," Еда: %i / %i",car_prods[GetPlayerVehicleID(playerid)][3],PTEMP[playerid][pPMGruz]);
			DeletePVar(playerid,"Kolvo");
			return 1;
		}
	case 1384:
		{
			if(!response) return true;
			car_prods[GetPlayerVehicleID(playerid)][2] += GetPVarInt(playerid,"kolvo");
			PTEMP[playerid][pCash]-=GetPVarInt(playerid,"kolvo")*15;
			SendMes(playerid,TEAM_GROVE_COLOR," Товары: %i / %i",car_prods[GetPlayerVehicleID(playerid)][2],PTEMP[playerid][pPMGruz]);
			SendMes(playerid,TEAM_GROVE_COLOR," Еда: %i / %i",car_prods[GetPlayerVehicleID(playerid)][3],PTEMP[playerid][pPMGruz]);
			DeletePVar(playerid,"Kolvo");
			return 1;
		}
	case 1385:
		{
			if(!response) return true;
			car_prods[GetPlayerVehicleID(playerid)][1] += GetPVarInt(playerid,"kolvo");
			PTEMP[playerid][pCash]-=GetPVarInt(playerid,"kolvo")*15;
			SendMes(playerid,TEAM_GROVE_COLOR," Топливо: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][1]);
			DeletePVar(playerid,"Kolvo");
			return 1;
		}
	case 1387:
		{
			if(!response) return true;
			new bizz = GetPVarInt(playerid,"bizz");
			if(strcmp(BizzInfo[bizz][bOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У бизнеса нет владельца");
			PTEMP[playerid][pCash]+=car_prods[GetPlayerVehicleID(playerid)][3]*16;
			BizzInfo[bizz][bProducts] += car_prods[GetPlayerVehicleID(playerid)][3];
			car_prods[GetPlayerVehicleID(playerid)][3] = 0;
			SendMes(playerid,TEAM_GROVE_COLOR," Товары: %i / %i",car_prods[GetPlayerVehicleID(playerid)][2],PTEMP[playerid][pPMGruz]);
			SendMes(playerid,TEAM_GROVE_COLOR," Еда: %i / %i",car_prods[GetPlayerVehicleID(playerid)][3],PTEMP[playerid][pPMGruz]);
			if(booston == 0) PTEMP[playerid][pPProc] += 1;
			else if(booston == 1) PTEMP[playerid][pPProc] += 2;
			DeletePVar(playerid,"bizz");
			ExpExp(playerid);
			return 1;
		}
	case 1388:
		{
			if(!response) return true;
			new bizz = GetPVarInt(playerid,"bizz");
			if(strcmp(BizzInfo[bizz][bOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У бизнеса нет владельца");
			PTEMP[playerid][pCash]+=car_prods[GetPlayerVehicleID(playerid)][3]*16;
			BizzInfo[bizz][bProducts] += car_prods[GetPlayerVehicleID(playerid)][3];
			car_prods[GetPlayerVehicleID(playerid)][3] = 0;
			SendMes(playerid,TEAM_GROVE_COLOR," Товары: %i / %i",car_prods[GetPlayerVehicleID(playerid)][2],PTEMP[playerid][pPMGruz]);
			SendMes(playerid,TEAM_GROVE_COLOR," Еда: %i / %i",car_prods[GetPlayerVehicleID(playerid)][3],PTEMP[playerid][pPMGruz]);
			if(booston == 0) PTEMP[playerid][pPProc] += 1;
			else if(booston == 1) PTEMP[playerid][pPProc] += 2;
			DeletePVar(playerid,"bizz");
			ExpExp(playerid);
			return 1;
		}
	case 1389:
		{
			if(!response) return true;
			new bizz = GetPVarInt(playerid,"bizz");
			if(strcmp(BizzInfo[bizz][bOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У бизнеса нет владельца");
			PTEMP[playerid][pCash]+=car_prods[GetPlayerVehicleID(playerid)][2]*16;
			BizzInfo[bizz][bProducts] += car_prods[GetPlayerVehicleID(playerid)][2];
			car_prods[GetPlayerVehicleID(playerid)][2] = 0;
			SendMes(playerid,TEAM_GROVE_COLOR," Товары: %i / %i",car_prods[GetPlayerVehicleID(playerid)][2],PTEMP[playerid][pPMGruz]);
			SendMes(playerid,TEAM_GROVE_COLOR," Еда: %i / %i",car_prods[GetPlayerVehicleID(playerid)][3],PTEMP[playerid][pPMGruz]);
			if(booston == 0) PTEMP[playerid][pPProc] += 1;
			else if(booston == 1) PTEMP[playerid][pPProc] += 2;
			DeletePVar(playerid,"bizz");
			ExpExp(playerid);
			return 1;
		}
	case 1390:
		{
			if(!response) return true;
			new bizz = GetPVarInt(playerid,"bizz");
			if(strcmp(BizzInfo[bizz][bOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У бизнеса нет владельца");
			PTEMP[playerid][pCash]+=car_prods[GetPlayerVehicleID(playerid)][1]*16;
			BizzInfo[bizz][bProducts] += car_prods[GetPlayerVehicleID(playerid)][1];
			car_prods[GetPlayerVehicleID(playerid)][1] = 0;
			SendMes(playerid,TEAM_GROVE_COLOR," Топливо: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][1]);
			if(booston == 0) PTEMP[playerid][pPProc] += 1;
			else if(booston == 1) PTEMP[playerid][pPProc] += 2;
			DeletePVar(playerid,"bizz");
			ExpExp(playerid);
			return 1;
		}
	case 1883:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 1884, DIALOG_STYLE_MSGBOX, "Банкоматы", "Установить объект на данное место?", "Да", "Нет");
			return EditDynamicObject(playerid,GetPVarInt(playerid,"st_object"));
		}
	case 1884:
		{
			if(!response)
			{
				DestroyDynamicObject(GetPVarInt(playerid,"st_object"));
				DeletePVar(playerid,"st_object");
				SCM(playerid,COLOR_RED," Банкомат не был установлен!");
			}
			else
			{
				new Float:x, Float:y, Float:z, Float:rz;
				GetDynamicObjectPos(GetPVarInt(playerid,"st_object"),x,y,z);
				GetDynamicObjectRot(GetPVarInt(playerid,"st_object"), rz, rz, rz);
				DeletePVar(playerid,"st_object");
				ATMInfo[TOTALATM][aX] = x;
				ATMInfo[TOTALATM][aY] = y;
				ATMInfo[TOTALATM][aZ] = z;
				ATMInfo[TOTALATM][arZ] = rz;
				mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_ATM"` (`aX`, `aY`, `aZ`, `arZ`) VALUES ('%f', '%f', '%f', '%f')",x, y, z, rz);
				mysql_function_query(DATABASE,QUERY,false,"","");
				TOTALATM++;
				SendMes(playerid,COLOR_GREEN," Банкомат под номером %i установлен!",TOTALATM);
			}
			return true;
		}
	case 1783:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 1784, DIALOG_STYLE_MSGBOX, "Хот доги", "Установить объект на данное место?", "Да", "Нет");
			return EditDynamicObject(playerid,GetPVarInt(playerid,"st_object"));
		}
	case 1784:
		{
			if(!response)
			{
				DestroyDynamicObject(GetPVarInt(playerid,"st_object"));
				DeletePVar(playerid,"st_object");
				SCM(playerid,COLOR_RED," Прилавок не был установлен!");
			}
			else
			{
				new Float:x, Float:y, Float:z, Float:rz;
				GetDynamicObjectPos(GetPVarInt(playerid,"st_object"),x,y,z);
				GetDynamicObjectRot(GetPVarInt(playerid,"st_object"), rz, rz, rz);
				DeletePVar(playerid,"st_object");
				StallInfo[TOTALSTALL][stPos][0] = x;
				StallInfo[TOTALSTALL][stPos][1] = y;
				StallInfo[TOTALSTALL][stPos][2] = z;
				StallInfo[TOTALSTALL][stPos][3] = rz;
				StallInfo[TOTALSTALL][stText] = CreateDynamic3DTextLabel( "Не работает", 0xFF8C37FF, StallInfo[TOTALSTALL][stPos][0], StallInfo[TOTALSTALL][stPos][1], StallInfo[TOTALSTALL][stPos][2], 8.0 );
				SendMes(playerid,COLOR_GREEN," Прилавок под номером %i установлен!",TOTALSTALL+1);
				mysql_format(DATABASE,QUERY, 300, "INSERT INTO `"TABLE_STALL"` (`pos_x`, `pos_y`, `pos_z`, `pos_r`) VALUES ('%f', '%f', '%f', '%f')",x, y, z, rz);
				mysql_function_query(DATABASE,QUERY,false,"","");
				TOTALSTALL++;
			}
			return true;
		}
	case 1344:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: SetPlayerCheckpoint(playerid, 2230.4875,-2211.9368,13.5469,5);
			case 1..5: SetPlayerCheckpoint(playerid, FarmInfo[listitem][fMenu][0], FarmInfo[listitem][fMenu][1], FarmInfo[listitem][fMenu][2],5);
			}
			CP[playerid] = 777;
			return SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 1203:
		{
			if(!response) {}
			else
			{
				if(GetPVarInt(GetPVarInt(playerid,"TaxiPlayer"),"PayDayCashJob") > gettime()) return true;
				if(GetPVarInt(GetPVarInt(playerid,"TaxiPlayer"),"Taxi_") <= 0) SetPVarInt(GetPVarInt(playerid,"TaxiPlayer"),"PayDayCashJob",gettime() + 150);
				if(booston == 0) PTEMP[GetPVarInt(playerid,"TaxiPlayer")][ptaxiexp]++;
				else if(booston == 1) PTEMP[GetPVarInt(playerid,"TaxiPlayer")][ptaxiexp] += 3;
				if(PTEMP[GetPVarInt(playerid,"TaxiPlayer")][ptaxiexp] >= PTEMP[GetPVarInt(playerid,"TaxiPlayer")][ptaxilvl]*8) PTEMP[GetPVarInt(playerid,"TaxiPlayer")][ptaxilvl]++, PTEMP[GetPVarInt(playerid,"TaxiPlayer")][ptaxiexp] = 0;
			}
		}
	case 1322:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: ShowPlayerDialogEx(playerid,1356, DIALOG_STYLE_INPUT, " ","Сколько вы хотите купить зерна?", "Готово", "Отмена");
			case 1: ShowPlayerDialogEx(playerid,1357, DIALOG_STYLE_INPUT, " ","Сколько вы хотите продать зерна?", "Готово", "Отмена");
			case 2: ShowPlayerDialogEx(playerid,1358, DIALOG_STYLE_INPUT, " ","Сколько вы хотите купить урожая?", "Готово", "Отмена");
			case 3: ShowPlayerDialogEx(playerid,1359, DIALOG_STYLE_INPUT, " ","Сколько вы хотите продать урожая?", "Готово", "Отмена");
			}
		}
	case 1359:
		{
			if(!response || PTEMP[playerid][pJob] != 5) return true;
			if(!strlen(inputtext) || strval(inputtext) < 0) return SCM(playerid,COLOR_GREY," Неверное количество!");
			if(GetPlayerVehicleID(playerid) < comptruck[0] && GetPlayerVehicleID(playerid) > comptruck[1]) return SCM(playerid,COLOR_GREY," Вы должны находиться в фургоне"), RemovePlayerFromVehicleAC(playerid);
			if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
			if(PlayerToPoint(15, playerid,1630.0807,2323.3582,10.8203) && car_prods[GetPlayerVehicleID(playerid)][0] != 0)
			{
				if(car_prods[GetPlayerVehicleID(playerid)][0] < strval(inputtext)) return SCM(playerid,COLOR_GREY," В машине недостаточно урожая");
				PTEMP[playerid][pCash]+=strval(inputtext)*34;
				car_prods[GetPlayerVehicleID(playerid)][0] -= strval(inputtext);
				format(YCMDstr, 124, "{FFFFFF}Склад с урожаем\n\nУрожая продано: {0C9599}%i\n{FFFFFF}Цена: {0C9599}%i вирт", strval(inputtext), strval(inputtext)*UrojSell);
				ShowPlayerDialogEx(playerid,9998,DIALOG_STYLE_MSGBOX, " ", YCMDstr, "Закрыть", "");
			}
			else if(PlayerToPoint(15, playerid,2178.3220,-1660.2120,14.9782) && car_prods[GetPlayerVehicleID(playerid)][1] != 0)
			{
				if(car_prods[GetPlayerVehicleID(playerid)][1] < strval(inputtext)) return SCM(playerid,COLOR_GREY," В машине недостаточно наркотиков");
				PTEMP[playerid][pCash]+=strval(inputtext)*34;
				car_prods[GetPlayerVehicleID(playerid)][1] -= strval(inputtext);
				format(YCMDstr, 124, "{FFFFFF}Наркопритон\n\nНаркотиков продано: {0C9599}%i\n{FFFFFF}Цена: {0C9599}%i вирт", strval(inputtext), strval(inputtext)*NarkSell);
				ShowPlayerDialogEx(playerid,9998,DIALOG_STYLE_MSGBOX, " ", YCMDstr, "Закрыть", "");
			}
			else return SCM(playerid,COLOR_GREY," Вы должны находиться у места продажи урожая / наркопритона");
		}
	case 7205:
		{
			if(response)
			{
				if(CarOffer[playerid] == 999) return SCM(playerid,COLOR_GREY," Игрок отменил обмен / вам никто не предлагал обмен автомобилями");
				SendMes(playerid,COLOR_BLUE," Ждите подтверждение %s",Name(CarOffer[playerid]));
				format(YCMDstr, 256, "{FFFFFF}Вы собираетесь обменяться своим личным транспортом с %s\n\n{F1E100}Вы отдаете:\n\t{FFFFFF}%s[%i]\tPercent: (%i)\n\n{F1E100}Вы получаете:\n\t{FFFFFF}%s[%i]\tPercent: (%i)\n\t%i вирт\n\nВы согласны на сделку?",
				Name(playerid), VehicleNames[GetVehicleModel(house_car[CarOffer[playerid]])-400],GetVehicleModel(house_car[CarOffer[playerid]]),CarInfo[CarOffer[playerid]][carPercent][GetPVarInt(CarOffer[playerid], "chosencar")],VehicleNames[GetVehicleModel(house_car[playerid])-400],GetVehicleModel(house_car[playerid]),CarInfo[playerid][carPercent][GetPVarInt(playerid, "chosencar")],CarPrice[playerid]);
				ShowPlayerDialogEx(CarOffer[playerid],7206,DIALOG_STYLE_MSGBOX, "Подтверждение", YCMDstr, "Согласен", "Отмена");
				return 1;
			}
			else
			{
				SCM(playerid,COLOR_GREY," Вы отказались от сделки");
				SCM(CarOffer[playerid],COLOR_GREY," Игрок отказался от сделки");
				SetPVarInt(CarOffer[playerid],"CarOffer",9999);
				CarPrice[playerid] = 999;
				CarOffer[playerid] = 999;
				return true;
			}
		}
	case 7206:
		{
			new i = GetPVarInt(playerid,"CarOffer");
			if(response)
			{
				if(GetPVarInt(playerid,"CarOffer") == 9999) return true;
				if(!ProxDetectorS(8.0, playerid, i)) return SCM(playerid, COLOR_GREY, " Игрок должен находиться рядом с вами"), CarPrice[i] = 999, CarOffer[i] = 999, SetPVarInt(playerid,"CarOffer",9999);
				if(PTEMP[i][pCash] < CarPrice[i]) return SCM(playerid, COLOR_GREY, " У игрока нет столько денег"), CarPrice[i] = 999, CarOffer[i] = 999, SetPVarInt(playerid,"CarOffer",9999);
				PTEMP[i][pCash] -= CarPrice[i];
				PTEMP[playerid][pCash] += CarPrice[i];
				new previous_data, pveh = GetPVarInt(playerid, "chosencar"), iveh = GetPVarInt(i, "chosencar");
				previous_data = CarInfo[playerid][carModel][pveh];
				CarInfo[playerid][carModel][pveh] = CarInfo[i][carModel][iveh];
				CarInfo[i][carModel][iveh] = previous_data;
				previous_data = CarInfo[playerid][carColor_one][pveh];
				CarInfo[playerid][carColor_one][pveh] = CarInfo[i][carColor_one][iveh];
				CarInfo[i][carColor_one][iveh] = previous_data;
				previous_data = CarInfo[playerid][carColor_two][pveh];
				CarInfo[playerid][carColor_two][pveh] = CarInfo[i][carColor_two][iveh];
				CarInfo[i][carColor_two][iveh] = previous_data;
				previous_data = CarInfo[playerid][carPercent][pveh];
				CarInfo[playerid][carPercent][pveh] = CarInfo[i][carPercent][iveh];
				CarInfo[i][carPercent][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_1][pveh];
				CarInfo[playerid][carVehcom_1][pveh] = CarInfo[i][carVehcom_1][iveh];
				CarInfo[i][carVehcom_1][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_2][pveh];
				CarInfo[playerid][carVehcom_2][pveh] = CarInfo[i][carVehcom_2][iveh];
				CarInfo[i][carVehcom_2][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_3][pveh];
				CarInfo[playerid][carVehcom_3][pveh] = CarInfo[i][carVehcom_3][iveh];
				CarInfo[i][carVehcom_3][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_4][pveh];
				CarInfo[playerid][carVehcom_4][pveh] = CarInfo[i][carVehcom_4][iveh];
				CarInfo[i][carVehcom_4][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_5][pveh];
				CarInfo[playerid][carVehcom_5][pveh] = CarInfo[i][carVehcom_5][iveh];
				CarInfo[i][carVehcom_5][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_6][pveh];
				CarInfo[playerid][carVehcom_6][pveh] = CarInfo[i][carVehcom_6][iveh];
				CarInfo[i][carVehcom_6][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_7][pveh];
				CarInfo[playerid][carVehcom_7][pveh] = CarInfo[i][carVehcom_7][iveh];
				CarInfo[i][carVehcom_7][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_8][pveh];
				CarInfo[playerid][carVehcom_8][pveh] = CarInfo[i][carVehcom_8][iveh];
				CarInfo[i][carVehcom_8][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_9][pveh];
				CarInfo[playerid][carVehcom_9][pveh] = CarInfo[i][carVehcom_9][iveh];
				CarInfo[i][carVehcom_9][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_10][pveh];
				CarInfo[playerid][carVehcom_10][pveh] = CarInfo[i][carVehcom_10][iveh];
				CarInfo[i][carVehcom_10][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_11][pveh];
				CarInfo[playerid][carVehcom_11][pveh] = CarInfo[i][carVehcom_11][iveh];
				CarInfo[i][carVehcom_11][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_12][pveh];
				CarInfo[playerid][carVehcom_12][pveh] = CarInfo[i][carVehcom_12][iveh];
				CarInfo[i][carVehcom_12][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_13][pveh];
				CarInfo[playerid][carVehcom_13][pveh] = CarInfo[i][carVehcom_13][iveh];
				CarInfo[i][carVehcom_13][iveh] = previous_data;
				previous_data = CarInfo[playerid][carVehcom_14][pveh];
				CarInfo[playerid][carVehcom_14][pveh] = CarInfo[i][carVehcom_14][iveh];
				CarInfo[i][carVehcom_14][iveh] = previous_data;
				previous_data = house_car[playerid];
				house_car[playerid] = house_car[i];
				house_car[i] = previous_data;
				SendMes(playerid,0x6495EDFF," Вы обменялись автомобилями с %s",PTEMP[i][pName]);
				SendMes(i, 0x6495EDFF," Вы обменялись автомобилями с %s",PTEMP[playerid][pName]);
				CarPrice[i] = 999;
				CarOffer[i] = 999;
				new house = PTEMP[playerid][pPHouseKey];
				new houses = PTEMP[i][pPHouseKey];
				DestroyVehicle(house_car[playerid]);
				house_car[playerid] = -1;
				if(HGet(playerid)) house_car[playerid] = CreateVehicle(CarInfo[playerid][carModel][pveh], HouseInfo[house][hCarx], HouseInfo[house][hCary], HouseInfo[house][hCarz], HouseInfo[house][hCarc] , CarInfo[playerid][carColor_one][pveh] ,CarInfo[playerid][carColor_two][pveh], 86400);
				DestroyVehicle(house_car[i]);
				house_car[i] = -1;
				if(HGet(i)) house_car[i] = CreateVehicle(CarInfo[i][carModel][iveh], HouseInfo[houses][hCarx], HouseInfo[houses][hCary], HouseInfo[houses][hCarz], HouseInfo[houses][hCarc] , CarInfo[i][carColor_one][iveh] ,CarInfo[i][carColor_two][iveh], 86400);
				SetPVarInt(playerid,"CarOffer",9999);
				return true;
			}
			else
			{
				SCM(playerid,COLOR_GREY," Вы отказались от сделки");
				SCM(i,COLOR_GREY," Игрок отказался от сделки");
				CarPrice[i] = 999;
				CarOffer[i] = 999;
				SetPVarInt(playerid,"CarOffer",9999);
				return true;
			}
		}
	case 1358:
		{
			if(!response || PTEMP[playerid][pJob] != 5) return true;
			if(!strlen(inputtext) || strval(inputtext) < 0) return SCM(playerid,COLOR_GREY," Неверное количество!");
			if(GetPlayerVehicleID(playerid) < comptruck[0] || GetPlayerVehicleID(playerid) > comptruck[1]) return SCM(playerid,COLOR_GREY," Вы должны находиться в фургоне"), RemovePlayerFromVehicleAC(playerid);
			if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
			new null = -1;
			for(new i = 0; i <= TOTALFARM; i++) if(PlayerToPoint(15, playerid,FarmInfo[i][fMenu][0], FarmInfo[i][fMenu][1], FarmInfo[i][fMenu][2])) null = i;
			if(null == -1) return SCM(playerid,COLOR_GREY," Вы должны находиться возле фермы");
			if(strcmp(FarmInfo[null][fOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У фермы нет владельца");
			if(FarmInfo[null][fProds] < strval(inputtext)) return SCM(playerid,COLOR_GREY," На складе фермы недостаточно урожая");
			if(PTEMP[playerid][pCash] < strval(inputtext)*FarmInfo[null][fProds_Price]) return SCM(playerid,COLOR_GREY," Недостаточно средств");
			switch(FarmInfo[null][fProds_Selling])
			{
			case 1:
				{
					if(strval(inputtext) > 10000-car_prods[GetPlayerVehicleID(playerid)][0]) return SCM(playerid,COLOR_GREY," В машине не хватает места");
					car_prods[GetPlayerVehicleID(playerid)][0] += strval(inputtext);
					format(YCMDstr, 124, "{FFFFFF}Ферма номер: {B41010}%i\n\n{FFFFFF}Урожая куплено: {0C9599}%i\n{FFFFFF}Цена: {0C9599}%i вирт", null-1, strval(inputtext),strval(inputtext)*FarmInfo[null][fProds_Price]);
					ShowPlayerDialogEx(playerid,0,DIALOG_STYLE_MSGBOX, " ", YCMDstr, "Закрыть", "");
					SCM(playerid,COLOR_GREEN," Вы можете продать урожай на склад {FFFFFF}(( /gps >> [1] По работе >> [3] Склад для урожая с ферм ))");
					SendMes(playerid,TEAM_GROVE_COLOR," Зерна в машине: %i / 1000",car_grain[GetPlayerVehicleID(playerid)][0]);
					SendMes(playerid,TEAM_GROVE_COLOR," Урожая в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][0]);
					SendMes(playerid,TEAM_GROVE_COLOR," Наркотиков в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][1]);
				}
			case 2:
				{
					if(strval(inputtext) > 10000-car_prods[GetPlayerVehicleID(playerid)][1]) return SCM(playerid,COLOR_GREY," В машине не хватает места");
					car_prods[GetPlayerVehicleID(playerid)][1] += strval(inputtext);
					format(YCMDstr, 124, "{FFFFFF}Ферма номер: {B41010}%i\n\n{FFFFFF}Наркотиков куплено: {0C9599}%i\n{FFFFFF}Цена: {0C9599}%i вирт", null-1, strval(inputtext),strval(inputtext)*FarmInfo[null][fProds_Price]);
					ShowPlayerDialogEx(playerid,9999,DIALOG_STYLE_MSGBOX, " ", YCMDstr, "Закрыть", "");
					SCM(playerid,COLOR_GREEN," Вы можете продать наркотики в притон {FFFFFF}(( /gps >> [1] Важное >> [7] Наркопритон ))");
					SendMes(playerid,TEAM_GROVE_COLOR," Зерна в машине: %i / 1000",car_grain[GetPlayerVehicleID(playerid)][0]);
					SendMes(playerid,TEAM_GROVE_COLOR," Урожая в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][0]);
					SendMes(playerid,TEAM_GROVE_COLOR," Наркотиков в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][1]);
				}
			}
			FarmStatPay[null][5] += strval(inputtext);
			FarmStatDay[null][5] += strval(inputtext);
			PTEMP[playerid][pCash]-=strval(inputtext)*FarmInfo[null][fProds_Price];
			FarmStatPay[null][8] += strval(inputtext)*FarmInfo[null][fProds_Price];
			FarmStatDay[null][8] += strval(inputtext)*FarmInfo[null][fProds_Price];
			return FarmInfo[null][fBank]+=strval(inputtext)*FarmInfo[null][fProds_Price];
		}
	case 1357:
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[0] && newcar <= comptruck[1])
			{
				if(!response || PTEMP[playerid][pJob] != 5) return true;
				if(GetPlayerVehicleID(playerid) < comptruck[0] || GetPlayerVehicleID(playerid) > comptruck[1]) return SCM(playerid,COLOR_GREY," Вы должны находиться в фургоне"), RemovePlayerFromVehicleAC(playerid);
				if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
				if(!strlen(inputtext) || strval(inputtext) < 0 || strval(inputtext) > car_grain[GetPlayerVehicleID(playerid)][0]) return SCM(playerid,COLOR_GREY," В автомобиле недостаточно зерна!");
				new null = 0;
				for(new i = 0; i <= TOTALFARM; i++) if(PlayerToPoint(15, playerid,FarmInfo[i][fMenu][0], FarmInfo[i][fMenu][1], FarmInfo[i][fMenu][2])) null = i;
				if(!null) return SCM(playerid,COLOR_GREY," Вы должны находиться возле фермы");
				if(strcmp(FarmInfo[null][fOwner],"None",true) == 0) return SCM(playerid,COLOR_GREY," У фермы нет владельца");
				if(FarmInfo[null][fGrain]+strval(inputtext) > 10000) return SCM(playerid,COLOR_GREY," На ферме достаточно зерна");
				if(FarmInfo[null][fBank] < strval(inputtext)*FarmInfo[null][fGrain_Price]) return SCM(playerid,COLOR_GREY," На балансе фермы недостаточно денег");
				FarmInfo[null][fBank]-=strval(inputtext)*FarmInfo[null][fGrain_Price];
				FarmStatPay[null][6] += strval(inputtext)*FarmInfo[null][fGrain_Price];
				FarmStatDay[null][6] += strval(inputtext)*FarmInfo[null][fGrain_Price];
				FarmInfo[null][fGrain]+=strval(inputtext);
				PTEMP[playerid][pCash]+=strval(inputtext)*FarmInfo[null][fGrain_Price];
				car_grain[GetPlayerVehicleID(playerid)][0]-=strval(inputtext);
				FarmStatPay[null][4] += strval(inputtext);
				FarmStatDay[null][4] += strval(inputtext);
				format(YCMDstr, 124, "{FFFFFF}Ферма номер: {B41010}%i\n\n{FFFFFF}Зерна продано: {0C9599}%i\n{FFFFFF}Цена: {0C9599}%i вирт", null-1, strval(inputtext),strval(inputtext)*FarmInfo[null][fGrain_Price]);
				ShowPlayerDialogEx(playerid,9998,DIALOG_STYLE_MSGBOX, " ", YCMDstr, "Закрыть", "");
				return true;
			}
		}
	case 1346:
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[0] && newcar <= comptruck[1])
			{
				if(!response || PTEMP[playerid][pJob] != 5) return RemovePlayerFromVehicleAC(playerid);
				if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
				car_grain[GetPlayerVehicleID(playerid)][1] = 0;
				car_grain[GetPlayerVehicleID(playerid)][2] = 0;
				DestroyDynamicPickup(car_pickup[GetPlayerVehicleID(playerid)]);
				DestroyDynamic3DTextLabel(car_text[GetPlayerVehicleID(playerid)]);
				car_pickup[GetPlayerVehicleID(playerid)] = 0;
				if(PTEMP[playerid][pCash] < (car_grain[GetPlayerVehicleID(playerid)][0]-car_grain[GetPlayerVehicleID(playerid)][2])*4) return SCM(playerid,COLOR_GREY," Недостаточно средств!"), car_grain[GetPlayerVehicleID(playerid)][0] = car_grain[GetPlayerVehicleID(playerid)][2];
				PTEMP[playerid][pCash] -= (car_grain[GetPlayerVehicleID(playerid)][0]-car_grain[GetPlayerVehicleID(playerid)][2])*4;
				format(YCMDstr, 124, "{FFFFFF}Склад с зерном\n\nЗерна куплено: {0C9599}%i\n{FFFFFF}Цена: {0C9599}%i вирт", car_grain[GetPlayerVehicleID(playerid)][0]-car_grain[GetPlayerVehicleID(playerid)][2], (car_grain[GetPlayerVehicleID(playerid)][0]-car_grain[GetPlayerVehicleID(playerid)][2])*ZernBuy);
				ShowPlayerDialogEx(playerid,9997,DIALOG_STYLE_MSGBOX, " ", YCMDstr, "Закрыть", "");
				SendMes(playerid,TEAM_GROVE_COLOR," Зерна в машине: %i / 1000",car_grain[GetPlayerVehicleID(playerid)][0]);
				SendMes(playerid,TEAM_GROVE_COLOR," Урожая в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][0]);
				SendMes(playerid,TEAM_GROVE_COLOR," Наркотиков в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][1]);
				SCM(playerid,COLOR_GREEN," Загрузка зерна завершена. Вы можете продать зерно на ферму {FFFFFF}(( /gps >> [5] Фермы ))");
			}
			else return SCM(playerid,COLOR_GREY," Вы должны находиться в фургоне"), RemovePlayerFromVehicleAC(playerid);
		}
	case 1356:
		{
			new newcar = GetPlayerVehicleID(playerid);
			if(newcar >= comptruck[0] && newcar <= comptruck[1])
			{
				if(!response || PTEMP[playerid][pJob] != 5) return true;
				if(GetPVarInt(playerid,"rentcar_job") != GetPlayerVehicleID(playerid)) return SCM(playerid,COLOR_GREY," Это не ваш автомобиль!");
				if(!strlen(inputtext) || strval(inputtext) > 1000 || strval(inputtext) < 50) return ShowPlayerDialogEx(playerid,1356, DIALOG_STYLE_INPUT, "Загрузка зерна","Введите количество зерна на загрузку", "Ок", "Отмена"), SCM(playerid, COLOR_GREY, " Минимальное количество зерна - 50, максимальное - 1000");
				if(car_grain[GetPlayerVehicleID(playerid)][0]+strval(inputtext) > 1000) return SCM(playerid,COLOR_GREY," Грузовик полон!");
				if(!PlayerToPoint(10.0,playerid,2191.9878,-2262.4209,13.6586)) return SCM(playerid,COLOR_GREY," В данном месте нельзя заказать продукты");
				if(PTEMP[playerid][pCash] < strval(inputtext)*4) return SCM(playerid, COLOR_GREY," У вас не хватает денег!");
				new Float:x, Float:y, Float:z;
				GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
				SetVehicleParamsEx(GetPlayerVehicleID(playerid),false,false,false,doors,false,false,false);
				SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.0);
				GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
				GetXYInBackOfPlayer(playerid, x, y,3.5);
				car_pickup[GetPlayerVehicleID(playerid)] = CreatePickup(19197,23,x,y,z+0.5);
				car_grain[GetPlayerVehicleID(playerid)][1] = strval(inputtext);
				car_grain[GetPlayerVehicleID(playerid)][2] = car_grain[GetPlayerVehicleID(playerid)][0];
				format(string, 32, "Загружено\n{ffffff}%i / %i",car_grain[GetPlayerVehicleID(playerid)][0], car_grain[GetPlayerVehicleID(playerid)][1]);
				car_text[GetPlayerVehicleID(playerid)] = CreateDynamic3DTextLabel(string,0x5CABBDAA,x,y,z+1,15.0);
				SCM(playerid, 0x0073B7AA, " Машина на месте. Теперь вы и грузчики могут загружать ее");
				SCM(playerid, 0x0073B7AA, " Если решите завершить загрузку, сядьте снова в машину");
				RemovePlayerFromVehicleAC(playerid);
				return true;
			}
			else return SCM(playerid,COLOR_GREY," Вы должны находиться в фургоне");
		}
	case 1345:
		{
			if(!response || !GetPlayerVehicleID(playerid) || !GetPVarInt(playerid,"farm_id")) return true;
			new car, rand;
			for(new i = 0; i <= TOTALFARM; i++) if(GetPlayerVehicleID(playerid) >= FarmInfo[i][fSeed_Car][0] && GetPlayerVehicleID(playerid) <= FarmInfo[i][fSeed_Car][1]) car++;
			if(car == 0) return Kick(playerid);
			car = GetPlayerVehicleID(playerid);
			if(!Farmcar_works[car])
			{
				switch(GetPVarInt(playerid,"farm_id"))
				{
				case 1: rand = random(4), SetPlayerRaceCheckpoint(playerid,1,Farmcar_coord_one[rand][0],Farmcar_coord_one[rand][1],Farmcar_coord_one[rand][2],0,0,0,5.0);
				case 2: rand = random(4), SetPlayerRaceCheckpoint(playerid,1,Farmcar_coord_two[rand][0],Farmcar_coord_two[rand][1],Farmcar_coord_two[rand][2],0,0,0,5.0);
				case 3: rand = random(4), SetPlayerRaceCheckpoint(playerid,1,Farmcar_coord_three[rand][0],Farmcar_coord_three[rand][1],Farmcar_coord_three[rand][2],0,0,0,5.0);
				case 4: rand = random(4), SetPlayerRaceCheckpoint(playerid,1,Farmcar_coord_four[rand][0],Farmcar_coord_four[rand][1],Farmcar_coord_four[rand][2],0,0,0,5.0);
				case 5: rand = random(4), SetPlayerRaceCheckpoint(playerid,1,Farmcar_coord_five[rand][0],Farmcar_coord_five[rand][1],Farmcar_coord_five[rand][2],0,0,0,5.0);
				}
				SetPVarInt(playerid,"farm_status",3);
			}
			else
			{
				Delete3DTextLabel(Farmcar_text[car]);
				DestroyDynamicPickup(Farmcar_pickup[car]);
				Farmcar_pickup[car] = 0;
				DeletePVar(playerid,"farm_status");
				if(Farmcar_prods[car] > 1000) Farmcar_prods[car] = 1000;
				RemovePlayerAttachedObject(playerid,3);
				DisablePlayerCheckpoint(playerid);
				Farmcar_works[car] = false;
				format(string, sizeof(string), " {00AB06}Урожая в машине: %d / 1000",Farmcar_prods[car]);
				SCM(playerid, COLOR_GREEN,string);
				SCM(playerid,0x0073B7AA," Сбор урожая завершен.Теперь направляйтесь к ферме и разгрузитесь {FFFFFF}(( Командой /funload ))");
			}
			return true;
		}
	case 150:
		{
			if(response)
			{
				new farm;
				if(GetPVarInt(playerid,"Fraction_Duty")) return SCM(playerid,COLOR_GREY," Вы состоите в организации");
				if(GetPVarInt(playerid,"farm_id") || Works[playerid])return SCM(playerid,COLOR_GREY," Вы уже начали работу");
				for(new i = 0; i <= TOTALFARM; i++) if(IsPlayerInRangeOfPoint(playerid,20.0,FarmInfo[i][fCloakroom][0],FarmInfo[i][fCloakroom][1], FarmInfo[i][fCloakroom][2])) farm = i;
				if(!farm) return SCM(playerid,COLOR_GREY," Вы должны находиться возле раздевалки у фермы!");
				if(FGet(playerid) && PTEMP[playerid][pPFarmKey] == farm)
				{
					SetPVarInt(playerid,"farm_rank",4);
					switch(PTEMP[playerid][pSex]) { case 1: SetPlayerSkin(playerid,34); default: SetPlayerSkin(playerid,31); }
				}
				else if(GetFarmjob(playerid,farm) == 2)
				{
					SetPVarInt(playerid,"farm_rank",3);
					switch(PTEMP[playerid][pSex]) { case 1: SetPlayerSkin(playerid,161); default: SetPlayerSkin(playerid,198); }
				}
				else if(GetFarmjob(playerid,farm))
				{
					SetPVarInt(playerid,"farm_rank",2);
					FarmStatPay[farm][1] ++;
					FarmStatDay[farm][1] ++;
					switch(PTEMP[playerid][pSex]) { case 1: SetPlayerSkin(playerid,158); default: SetPlayerSkin(playerid,157); }
				}
				else
				{
					SetPVarInt(playerid,"farm_rank",1);
					FarmStatPay[farm][0] ++;
					FarmStatDay[farm][0] ++;
					switch(PTEMP[playerid][pSex]) { case 1: SetPlayerSkin(playerid,132); default: SetPlayerSkin(playerid,131); }
				}
				SetPVarInt(playerid,"farm_id",farm);
				DeletePVar(playerid,"farm_status");
			}
			else
			{
				new farm;
				if(!GetPVarInt(playerid,"farm_id"))return SCM(playerid,COLOR_GREY," Вы не начинали работу");
				for(new i = 0; i <= TOTALFARM; i++) if(IsPlayerInRangeOfPoint(playerid,20.0,FarmInfo[i][fCloakroom][0],FarmInfo[i][fCloakroom][1], FarmInfo[i][fCloakroom][2])) farm = i;
				if(!farm) return SCM(playerid,COLOR_GREY," Вы должны находиться возле раздевалки у фермы!");
				if(GetPVarInt(playerid,"farm_id") != farm) return SCM(playerid,COLOR_GREY," Вы не начинали работу на данной ферме!");
				PTEMP[playerid][pCash] += GetPVarInt(playerid,"farm_zp");
				FarmStatDay[farm][7] += GetPVarInt(playerid,"farm_zp");
				FarmStatPay[farm][7] += GetPVarInt(playerid,"farm_zp");
				if(GetPVarInt(playerid,"farm_zp") > 0) format(string, 16, "~g~+$%i",GetPVarInt(playerid,"farm_zp")), GameTextForPlayer(playerid, string, 5000, 1);
				FarmInfo[GetPVarInt(playerid,"farm_id")][fBank] -= GetPVarInt(playerid,"farm_zp");
				if(FarmInfo[GetPVarInt(playerid,"farm_id")][fBank] < 0) FarmInfo[GetPVarInt(playerid,"farm_id")][fBank] = 0;
				SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
				DisablePlayerCheckpoint(playerid);
				DisablePlayerRaceCheckpoint(playerid);
				RemovePlayerAttachedObject(playerid,3);
				DeletePVar(playerid,"farm_id");
				DeletePVar(playerid,"farm_status");
				DeletePVar(playerid,"farm_rank");
				DeletePVar(playerid,"farm_zp");
				SCM(playerid,COLOR_GREEN," Спасибо за работу, приходите еще!");
			}
			return true;
		}
	case 1757:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					if(!GetPVarInt(playerid,"Offer")) return SCM(playerid,COLOR_GREY," Вы не предлагали купить нарко");
					DrugOffer[GetPVarInt(playerid,"Offer")] = 999;
					DrugPrice[GetPVarInt(playerid,"Offer")] = 999;
					DrugGram[GetPVarInt(playerid,"Offer")] = 999;
					DeletePVar(playerid,"Offer");
				}
			case 1:
				{
					if(!GetPVarInt(playerid,"RepairOffer")) return SCM(playerid,COLOR_GREY," Вы не предлагали никому ремонт");
					RepairOffer[GetPVarInt(playerid,"RepairOffer")] = 999;
					RepairPrice[GetPVarInt(playerid,"RepairOffer")] = 999;
					DeletePVar(playerid,"RepairOffer");
				}
			case 2:
				{
					if(!GetPVarInt(playerid,"RefillOffer")) return SCM(playerid,COLOR_GREY," Вы не предлагали никому заправиться");
					RefillOffer[GetPVarInt(playerid,"RefillOffer")] = 999;
					RefillPrice[GetPVarInt(playerid,"RefillOffer")] = 999;
					DeletePVar(playerid,"RefillOffer");
				}
			case 3:
				{
					if(!GetPVarInt(playerid,"LiveOffer")) return SCM(playerid,COLOR_GREY," Вы не предлагали никому интервью");
					switch(PTEMP[playerid][pMember])
					{
					case 9: LiveOffer[GetPVarInt(playerid,"LiveOffer")] = 999;
					case 16: LiveOfferls[GetPVarInt(playerid,"LiveOffer")] = 999;
					case 20: LiveOfferlv[GetPVarInt(playerid,"LiveOffer")] = 999;
					}
					DeletePVar(playerid,"LiveOffer");
				}
			case 4:
				{
					if(updatecheck[playerid] == 9999) return SCM(playerid,COLOR_GREY," Принятых вызовов нет");
					updatecheck[playerid] = 9999;
				}
			case 5:
				{
					if(updatecheck[playerid] == 9999) return SCM(playerid,COLOR_GREY," Принятых вызовов нет");
					updatecheck[playerid] = 9999;
				}
			case 6:
				{
					if(updatecheck[playerid] == 9999) return SCM(playerid,COLOR_GREY," Принятых вызовов нет");
					updatecheck[playerid] = 9999;
				}
			case 7:
				{
					if(updatecheck[playerid] == 9999) return SCM(playerid,COLOR_GREY," Принятых вызовов нет");
					updatecheck[playerid] = 9999;
				}
			case 8:
				{
					if(GetPVarInt(playerid,"CarOffer") == 9999) return SCM(playerid,COLOR_GREY," Вы не предлагали никому обмен авто");
					CarOffer[GetPVarInt(playerid,"CarOffer")] = 999;
					CarPrice[GetPVarInt(playerid,"CarOffer")] = 999;
					SetPVarInt(playerid,"CarOffer",9999);
				}
			case 9:
				{
					if(timecar[playerid] < 1) return SCM(playerid,COLOR_GREY," Вы не начинали миссию автоугона");
					if(caroff[GetPlayerVehicleID(playerid)] == 1) caroff[GetPlayerVehicleID(playerid)] = 0, DestroyVehicle(GetPlayerVehicleID(playerid));
					timecar[playerid] = 0;
					if(PTEMP[playerid][pSkilla] > 0) PTEMP[playerid][pSkilla]--;
					SCM(playerid, COLOR_BLUE, " [SMS]: Ты нас разочаровал! Миссия провалена");
					avtocar[playerid] = 0;
					rabotaon[playerid] = 0;
					GangZoneDestroy(gangzonesa[playerid]);
				}
			case 10:
				{
					if(DiceOffers[playerid] != 999)
					{
						SendMes(playerid, COLOR_ORANGE, " Вы отказались играть в кости с %s",PTEMP[DiceOffers[playerid]][pName]);
						SendMes(DiceOffers[playerid], COLOR_ORANGE, " %s отказался играть с вами в кости",PTEMP[playerid][pName]);
						ZapretDice[playerid] = 0;
						ZapretDice[DiceOffers[playerid]] = 0;
						KostiMoney[DiceOffers[playerid]] = 0;
						KostiName[DiceOffers[playerid]] = 999;
						DiceOffers[playerid] = 999;
					}
					else return SCM(playerid,COLOR_GREY," Вы не предлогали не кому играть");
				}
			}
			GameTextForPlayer(playerid,"~r~cancelled", 3500, 1);
			return true;
		}
	case 1565:
		{
			new i = GetPVarInt(playerid,"_changehouse")-1;
			if(!GetPVarInt(playerid,"_changehouse")) return true;
			if(!response) return SCM(playerid,COLOR_GREY," Вы отказались от сделки"), SCM(i,COLOR_GREY," Игрок отказался от сделки"), DeletePVar(i,"changehouse"), DeletePVar(i,"changehouse_price"), DeletePVar(i,"changehouse_"), DeletePVar(playerid,"_changehouse");
			if(!HGet(i)) return SCM(playerid,COLOR_GREY," У игрока нет дома!"), DeletePVar(i,"changehouse"), DeletePVar(i,"changehouse_price"), DeletePVar(i,"changehouse_"), DeletePVar(playerid,"_changehouse");
			new h = PTEMP[i][pPHouseKey];
			if(!ProxDetectorS(8.0, playerid, i)) return SCM(playerid, COLOR_GREY, " Игрок слишком далеко от вас!"), DeletePVar(i,"changehouse"), DeletePVar(i,"changehouse_price"), DeletePVar(i,"changehouse_"), DeletePVar(playerid,"_changehouse");
			if(PTEMP[playerid][pCash] < GetPVarInt(i,"changehouse_price"))return SCM(playerid, COLOR_GREY, " У вас нет столько денег на руках!"), DeletePVar(i,"changehouse"), DeletePVar(i,"changehouse_price"), DeletePVar(i,"changehouse_"), DeletePVar(playerid,"_changehouse");
			if(GetPVarInt(playerid,"changehouse_h"))
			{
				if(!HGet(playerid)) return SCM(playerid,COLOR_GREY," У вас нет дома!"), DeletePVar(i,"changehouse"), DeletePVar(i,"changehouse_price"), DeletePVar(i,"changehouse_"), DeletePVar(playerid,"_changehouse");
				strmid(HouseInfo[PTEMP[playerid][pPHouseKey]][hOwner],PTEMP[i][pName], 0, strlen(PTEMP[i][pName]), 32);
				SendMes(playerid,0x6495EDFF," Вы обменялись домами с %s. Ваша доплата %i вирт!",PTEMP[i][pName], GetPVarInt(i,"changehouse_price"));
				SendMes(i,0x6495EDFF," Вы обменялись домами с %s. Доплата %i вирт!",PTEMP[playerid][pName], GetPVarInt(i,"changehouse_price"));
				BuyHouse(PTEMP[playerid][pPHouseKey]);
				printf("Игрок %s обменялся домами с %s", Name(playerid), Name(i));
			}
			else SendMes(playerid,0x6495EDFF," Вы купили дом у %s. Стоимость %i вирт!",PTEMP[i][pName], GetPVarInt(i,"changehouse_price")), SendMes(i,0x6495EDFF," Вы продали дом %s. Стоимость %i вирт!",PTEMP[playerid][pName], GetPVarInt(i,"changehouse_price"));
			strmid(HouseInfo[h][hOwner],PTEMP[playerid][pName], 0, strlen(PTEMP[playerid][pName]), 32);
			if(house_car[i] != -1 && !HGet(i)) DestroyVehicle(house_car[i]), house_car[i] = -1;
			PTEMP[playerid][pCash] -= GetPVarInt(i,"changehouse_price");
			PTEMP[i][pCash] += GetPVarInt(i,"changehouse_price");
			BuyHouse(h);
			HGet(i), HGet(playerid);
			DeletePVar(i,"changehouse");
			DeletePVar(i,"changehouse_price");
			DeletePVar(i,"changehouse_");
			return DeletePVar(playerid,"_changehouse");
		}
	case 1467:
		{
			if(!response)
			{
				if(GetPVarInt(playerid,"help_dialog") > 1) return ShowHelpDialog(playerid, 0);
				else return SetPVarInt(playerid,"help_dialog",0);
			}
			else if(!GetPVarInt(playerid,"help_dialog")) return ShowHelpDialog(playerid, 0);
			else if(GetPVarInt(playerid,"help_dialog") == 1) ShowHelpDialog(playerid, listitem+1);
			else if(GetPVarInt(playerid,"help_dialog") > 1) ShowHelpDialog(playerid, GetPVarInt(playerid,"help_dialog")-1);
			return true;
		}
	case 1755:
		{
			if(!response) return true;
			string = "";
			for(new i = 1; i <= TotalBizz; i++)
			{
				if(BizzInfo[i][bType] != listitem+1) continue;
				format(YCMDstr,128,"{FFFFFF}%s {0076FC}%i вирт\n",BizzInfo[i][bMessage], BizzInfo[i][bPrice]);
				strcat(string,YCMDstr);
			}
			return ShowPlayerDialogEx(playerid,0,DIALOG_STYLE_MSGBOX,"Мониторинг бизнесов",string, "Закрыть", "");
		}
 	case 9666:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: ShowPlayerDialogEx(playerid,9660,DIALOG_STYLE_INPUT, "Ввод параментра", "Введите сумму", "Выбрать", "Назад");
			case 1: ShowPlayerDialogEx(playerid,9661,DIALOG_STYLE_INPUT, "Ввод параментра", "Введите сумму", "Выбрать", "Назад");
			case 2: ShowPlayerDialogEx(playerid,9662,DIALOG_STYLE_INPUT, "Ввод параментра", "Напишите имя получателя", "Выбрать", "Назад");
			case 3: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/balance");
			case 4:
				{
					if(!HGet(playerid)) return SCM(playerid,COLOR_GREY," У вас нет дома"), ShowPlayerDialogEx(playerid, 9666, DIALOG_STYLE_LIST, "Банк", "[0] Пополнить счет\n[1] Снять со счета\n[2] Сделать перевод\n[3] Баланс\n[4] Оплатить квартплату", "Выбрать", "Назад");
					format(string,512,"[0] 1 час\t\t\t\t%i вирт\n[1] 3 часа\t\t\t\t%i вирт\n[2] 5 часов\t\t\t\t%i вирт\n[3] 12 часов\t\t\t\t%i вирт\n[4] 24 часа\t\t\t\t%i вирт\n[5] 3 дня\t\t\t\t%i вирт\n[6] 7 дней\t\t\t\t%i вирт\n[7] 14 дней\t\t\t\t%i вирт\n[8] 28 дней\t\t\t\t%i вирт",
					GetHouseOplata(PTEMP[playerid][pPHouseKey]),GetHouseOplata(PTEMP[playerid][pPHouseKey])*3,GetHouseOplata(PTEMP[playerid][pPHouseKey])*5,GetHouseOplata(PTEMP[playerid][pPHouseKey])*12,GetHouseOplata(PTEMP[playerid][pPHouseKey])*24,GetHouseOplata(PTEMP[playerid][pPHouseKey])*72,GetHouseOplata(PTEMP[playerid][pPHouseKey])*168,GetHouseOplata(PTEMP[playerid][pPHouseKey])*336,GetHouseOplata(PTEMP[playerid][pPHouseKey])*672);
					ShowPlayerDialog(playerid,9521,DIALOG_STYLE_LIST, "Оплатить квартплату",string, "Выбрать", "Назад");
				}
			}
		}
 	case 9660:
		{
			if(strval(inputtext) < 1 || !response) return ShowPlayerDialogEx(playerid, 9666, DIALOG_STYLE_LIST, "Банк", "[0] Пополнить счет\n[1] Снять со счета\n[2] Сделать перевод\n[3] Баланс\n[4] Оплатить квартплату", "Выбрать", "Назад");
			if(PTEMP[playerid][pCash] < strval(inputtext)) return SCM(playerid,COLOR_GREY, " У вас нет столько денег!"),ShowPlayerDialogEx(playerid,9660,DIALOG_STYLE_INPUT,"Ввод параметра","Введите сумму","Выбрать","Назад");
			format(string, sizeof(string), "/bank %i", strval(inputtext));
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			ShowPlayerDialogEx(playerid, 9666, DIALOG_STYLE_LIST, "Банк", "[0] Пополнить счет\n[1] Снять со счета\n[2] Сделать перевод\n[3] Баланс\n[4] Оплатить квартплату", "Выбрать", "Назад");
			return true;
		}
	case 9661:
		{
			if(strval(inputtext) < 1 || !response) return ShowPlayerDialogEx(playerid, 9666, DIALOG_STYLE_LIST, "Банк", "[0] Пополнить счет\n[1] Снять со счета\n[2] Сделать перевод\n[3] Баланс\n[4] Оплатить квартплату", "Выбрать", "Назад");
			if(PTEMP[playerid][pBank] < strval(inputtext)) return SCM(playerid,COLOR_GREY, " У вас нет столько денег!"),ShowPlayerDialogEx(playerid,9660,DIALOG_STYLE_INPUT,"Ввод параметра","Введите сумму","Выбрать","Назад");
			format(string, sizeof(string), "/withdraw %i", strval(inputtext));
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			ShowPlayerDialogEx(playerid, 9666, DIALOG_STYLE_LIST, "Банк", "[0] Пополнить счет\n[1] Снять со счета\n[2] Сделать перевод\n[3] Баланс\n[4] Оплатить квартплату", "Выбрать", "Назад");
			return true;
		}
	case 9662:
	    {
	    	if(strval(inputtext) < 1 || !response) return ShowPlayerDialogEx(playerid, 9666, DIALOG_STYLE_LIST, "Банк", "[0] Пополнить счет\n[1] Снять со счета\n[2] Сделать перевод\n[3] Баланс\n[4] Оплатить квартплату", "Выбрать", "Назад");
	    	if(GetPlayerID(inputtext) != INVALID_PLAYER_ID) return SCM(playerid, COLOR_GREY, " Игрок оффлайн"), ShowPlayerDialogEx(playerid,9662,DIALOG_STYLE_INPUT, "Ввод параментра", "Напишите имя получателя", "Выбрать", "Назад");
			SetPVarString(playerid, "transfer", inputtext);
			ShowPlayerDialogEx(playerid,9663,DIALOG_STYLE_INPUT, "Ввод параментра", "Напишите сумму перевода", "Выбрать", "Назад");
			return true;
		}
	case 9663:
	    {
	        if(!response) return ShowPlayerDialogEx(playerid,9662,DIALOG_STYLE_INPUT, "Ввод параментра", "Напишите имя получателя", "Выбрать", "Назад");
	        if(strlen(inputtext) < 1) return ShowPlayerDialogEx(playerid,9664,DIALOG_STYLE_INPUT, "Ввод параментра", "Напишите сумму перевода", "Выбрать", "Назад");
	        if(PTEMP[playerid][pBank] < strval(inputtext)) return SCM(playerid, COLOR_GREY, " На вашем банковском счету не достаточно денег!"), ShowPlayerDialogEx(playerid,9666,DIALOG_STYLE_INPUT, "Ввод параментра", "Напишите сумму перевода", "Выбрать", "Назад");
	        new strss[32];
	        GetPVarString(playerid, "transfer", strss, 32);
	        DeletePVar(playerid, "transfer");
	        format(string, sizeof(string), "/transfer %s %i", strss, strval(inputtext));
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			ShowPlayerDialogEx(playerid, 9666, DIALOG_STYLE_LIST, "Банк", "[0] Пополнить счет\n[1] Снять со счета\n[2] Сделать перевод\n[3] Баланс\n[4] Оплатить квартплату", "Выбрать", "Назад");
			return true;
	    }
	case 9600:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: ShowPlayerDialogEx(playerid, 9601, DIALOG_STYLE_INPUT, "Установить цену зерна","Введите цену зерна\n\nВНИМАНИЕ: Цена должна быть не менее 5 вирт\nи не более 15 вирт","Установить","Назад");
			case 1: ShowPlayerDialogEx(playerid, 9602, DIALOG_STYLE_INPUT, "Установить цену продуктов","Введите цену продуктов\n\nВНИМАНИЕ: Цена должна быть не менее 20 вирт\nи не более 30 вирт","Установить","Назад");
			case 2: ShowPlayerDialogEx(playerid, 9603, DIALOG_STYLE_INPUT, "Установить цену работы","Введите цену работы\n\nВНИМАНИЕ: Цена должна быть не менее 30 вирт\nи не более 200 вирт","Установить","Назад");
			case 3: ShowPlayerDialogEx(playerid, 9604, DIALOG_STYLE_INPUT, "Пополнить 'LandTax' счёт","Введите сумму для пополнения","Пополнить","Назад");
			case 4: ShowPlayerDialogEx(playerid, 9605, DIALOG_STYLE_INPUT, "Пополнить банк фермы","Введите сумму для пополнения","Пополнить","Назад");
			case 5: ShowPlayerDialogEx(playerid, 9606, DIALOG_STYLE_INPUT, "Вывести деньги с банка фермы","Введите сумму для вывода","Вывести","Назад");
			case 6: FarmStatsPay(playerid,GetPVarInt(playerid,"farm_id"));
			case 7: FarmStatsDay(playerid,GetPVarInt(playerid,"farm_id"));
			case 8: ShowPlayerDialogEx(playerid, 9607, DIALOG_STYLE_LIST, "Продаваемый продукт","Картофель\nВеселая трава","Применить","Назад");
			case 9..16: ShowPlayerDialogEx(playerid, 9608, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад"), SetPVarInt(playerid,"farm_slot",listitem-8);
			}
		}
	case 9607:
		{
			if(!FGet(playerid) && GetPVarInt(playerid,"farm_rank") < 3) return true;
			if(!response)
			{
				format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
				format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
				return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
			}
			switch(listitem)
			{
			case 0: SCM(playerid,COLOR_BLUE," Продаваемый продукт: Картофель");
			case 1: SCM(playerid,COLOR_BLUE," Продаваемый продукт: Весёлая трава");
			}
			FarmInfo[GetPVarInt(playerid,"farm_id")][fProds_Selling] = listitem+1;
			format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
			format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
			return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
		}
	case 9608:
		{
			if(!FGet(playerid) || GetPVarInt(playerid,"farm_rank") < 3) return true;
			if(!response)
			{
				format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
				format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
				return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
			}
			switch(GetPVarInt(playerid,"farm_slot"))
			{
			case 1..3: format(string,50,"/finvite %i 1 %i",strval(inputtext),GetPVarInt(playerid,"farm_slot"));
			default: format(string,50,"/finvite %i 2 %i",strval(inputtext),GetPVarInt(playerid,"farm_slot")-3);
			}
			CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
			format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
			format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
			return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
		}
	case 9601:
		{
			if(!FGet(playerid) || GetPVarInt(playerid,"farm_rank") < 3) return true;
			new i = PTEMP[playerid][pPFarmKey];
			if(!response)
			{
				format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
				format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
				return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
			}
			if(strval(inputtext) < 5 || strval(inputtext) >= 15) return ShowPlayerDialogEx(playerid, 9601, DIALOG_STYLE_INPUT, "Установить цену зерна","Введите цену зерна\n\nВНИМАНИЕ: Цена должна быть не менее 5 вирт\nи не более 15 вирт","Установить","Назад");
			FarmInfo[i][fGrain_Price] = strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Цена зерна установлена, в размере %i вирт",strval(inputtext));
			format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
			format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
			return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
		}
	case 9602:
		{
			if(!FGet(playerid) || GetPVarInt(playerid,"farm_rank") < 3) return true;
			new i = PTEMP[playerid][pPFarmKey];
			if(!response)
			{
				format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
				format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
				return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
			}
			if(strval(inputtext) <= 20 || strval(inputtext) >= 30) return ShowPlayerDialogEx(playerid, 9602, DIALOG_STYLE_INPUT, "Установить цену продуктов","Введите цену продуктов\n\nВНИМАНИЕ: Цена должна быть не менее 20 вирт\nи не более 30 вирт","Установить","Назад");
			FarmInfo[i][fProds_Price] = strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Цена продажи продуктов установлена, в размере %i вирт",strval(inputtext));
			format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
			format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
			return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
		}
	case 9603:
		{
			if(!FGet(playerid) || GetPVarInt(playerid,"farm_rank") < 3) return true;
			new i = PTEMP[playerid][pPFarmKey];
			if(!response)
			{
				format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
				format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
				return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
			}
			if(strval(inputtext) < 30 || strval(inputtext) > 200) return ShowPlayerDialogEx(playerid, 9603, DIALOG_STYLE_INPUT, "Установить цену работы","Введите цену работы\n\nВНИМАНИЕ: Цена должна быть не менее 30 вирт\nи не более 200 вирт","Установить","Назад");
			FarmInfo[i][fZp] = strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Цена работы установлена, в размере %i вирт",strval(inputtext));
			format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
			format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
			return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
		}
	case 9604:
		{
			if(!FGet(playerid) || GetPVarInt(playerid,"farm_rank") < 3) return true;
			new i = PTEMP[playerid][pPFarmKey];
			if(!response)
			{
				format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
				format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
				return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
			}
			if(FarmInfo[i][fLandTax]+strval(inputtext) > 84000) return SCM(playerid,COLOR_GREY," Неверная сумма. Максимально допустимая сумма 84000 вирт (7 дней)"), ShowPlayerDialogEx(playerid, 9604, DIALOG_STYLE_INPUT, "Пополнить 'LandTax' счёт","Введите сумму для пополнения","Пополнить","Назад");
			if(strval(inputtext) < 0 || strval(inputtext) > PTEMP[playerid][pBank]) return ShowPlayerDialogEx(playerid, 9604, DIALOG_STYLE_INPUT, "Пополнить 'LandTax' счёт","Введите сумму для пополнения","Пополнить","Назад");
			FarmInfo[i][fLandTax]+=strval(inputtext);
			PTEMP[playerid][pBank]-=strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Вы перевели на 'LandTax' счёт фермы %i вирт",strval(inputtext));
			format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
			format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
			return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
		}
	case 9605:
		{
			if(!FGet(playerid) || GetPVarInt(playerid,"farm_rank") < 3) return true;
			new i = PTEMP[playerid][pPFarmKey];
			if(!response)
			{
				format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
				format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
				return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
			}
			if(FarmInfo[i][fBank] > 1000000000) return SCM(playerid,COLOR_GREY," Нет места!");
			if(strval(inputtext) < 0 || strval(inputtext) > PTEMP[playerid][pBank]) return ShowPlayerDialogEx(playerid, 9605, DIALOG_STYLE_INPUT, "Пополнить банк фермы","Введите сумму для пополнения","Пополнить","Назад");
			FarmInfo[i][fBank]+=strval(inputtext);
			PTEMP[playerid][pBank]-=strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Вы пополнили счёт фермы на %i вирт",strval(inputtext));
			format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
			format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
			return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
		}
	case 9606:
		{
			if(!FGet(playerid)) return true;
			new i = PTEMP[playerid][pPFarmKey];
			if(!response)
			{
				format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
				format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
				return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
			}
			if(strval(inputtext) < 0 || strval(inputtext) > FarmInfo[i][fBank]) return ShowPlayerDialogEx(playerid, 9606, DIALOG_STYLE_INPUT, "Вывести деньги с банка фермы","Введите сумму для вывода","Вывести","Назад");
			FarmInfo[i][fBank]-=strval(inputtext);
			PTEMP[playerid][pBank]+=strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Вы сняли со счёта фермы %i вирт",strval(inputtext));
			format(string,sizeof(string),"Установить цену зерна\nУстановить цену продуктов\nУстановить цену работы\nВвести вирты на счёт 'LandTax'\nВвести вирты на ферму\nВывести вирты с фермы\nСтатистика за прошлый час\nСтатистика за этот день");
			format(string,sizeof(string),"%s\nСменить продаваемый продукт\nНазначить Зама [1]\nНазначить Зама [2]\nНазначить Зама [3]\nНазначить Фермера [1]\nНазначить Фермера [2]\nНазначить Фермера [3]\nНазначить Фермера [4]\nНазначить Фермера [5]",string);
			return ShowPlayerDialogEx(playerid, 9600, DIALOG_STYLE_LIST, "Панель настроек",string, "Выбрать", "Отмена");
		}
	case 9592:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: ShowPlayerDialogEx(playerid, 6000, DIALOG_STYLE_INPUT, "Пополнить банк автомастерской","Введите сумму для пополнения","Пополнить","Назад");
			case 1: ShowPlayerDialogEx(playerid, 6001, DIALOG_STYLE_INPUT, "Пополнить 'LandTax' счёт","Введите сумму для пополнения","Пополнить","Назад");
			case 2: ShowPlayerDialogEx(playerid, 6002, DIALOG_STYLE_INPUT, "Снять деньги с банка","Введите сумму для снятия","Снять","Назад");
			case 3: ShowPlayerDialogEx(playerid, 6003, DIALOG_STYLE_INPUT, "Установить стоимость 1 продукта","Введите стоимость одного продукта\n\nВНИМАНИЕ: Сумма стоимости должна быть\nне менее 50 вирт и не более 100 вирт","Установить","Назад");
			case 4: ShowPlayerDialogEx(playerid, 6004, DIALOG_STYLE_INPUT, "Установить зарплату рабочим","Введите сумму зарплаты\n\nВНИМАНИЕ: Сумма должна быть не менее 1 вирт\nи не более 10 вирт","Установить","Назад");
			case 5..12: ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад"), SetPVarInt(playerid,"w_slot",listitem-4);
			}
			return true;
		}
	case 6005:
		{
			if(!WGet(playerid)) return true;
			new i = GetPVarInt(playerid,"wShop");
			if(!response)
			{
				return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
					\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
			}
			if(!IsPlayerConnected(strval(inputtext)) && strval(inputtext) != -1) return SCM(playerid,COLOR_GREY," Игрок не в сети!"), ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад");
			switch(GetPVarInt(playerid,"w_slot"))
			{
			case 1:
				{
					if(strval(inputtext) == -1)
					{
						if(strcmp(WorkshopInfo[i][wDeputy1],"None",true) == 0) return SCM(playerid,COLOR_GREY," Данный слот не занят!"), ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад");
						SendMes(playerid,COLOR_BLUE," Вы уволили %s с должности заместителя [1]",WorkshopInfo[i][wDeputy1]), strmid(WorkshopInfo[i][wDeputy1],"None", 0, strlen("None"), 32);
					}
					else
					{
						strmid(WorkshopInfo[i][wDeputy1],PTEMP[strval(inputtext)][pName], 0, strlen(PTEMP[strval(inputtext)][pName]), 32);
						SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность заместителя [1]",WorkshopInfo[i][wDeputy1]);
						SendMes(strval(inputtext),COLOR_BLUE," %s принял вас на должность заместителя [1]",PTEMP[playerid][pName]);
					}
				}
			case 2:
				{
					if(strval(inputtext) == -1)
					{
						if(strcmp(WorkshopInfo[i][wDeputy2],"None",true) == 0) return SCM(playerid,COLOR_GREY," Данный слот не занят!"), ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад");
						SendMes(playerid,COLOR_BLUE," Вы уволили %s с должности заместителя [2]",WorkshopInfo[i][wDeputy2]), strmid(WorkshopInfo[i][wDeputy2],"None", 0, strlen("None"), 32);
					}
					else
					{
						strmid(WorkshopInfo[i][wDeputy2],PTEMP[strval(inputtext)][pName], 0, strlen(PTEMP[strval(inputtext)][pName]), 32);
						SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность заместителя [2]",WorkshopInfo[i][wDeputy2]);
						SendMes(strval(inputtext),COLOR_BLUE," %s принял вас на должность заместителя [2]",PTEMP[playerid][pName]);
					}
				}
			case 3:
				{
					if(strval(inputtext) == -1)
					{
						if(strcmp(WorkshopInfo[i][wDeputy3],"None",true) == 0) return SCM(playerid,COLOR_GREY," Данный слот не занят!"), ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад");
						SendMes(playerid,COLOR_BLUE," Вы уволили %s с должности заместителя [3]",WorkshopInfo[i][wDeputy3]), strmid(WorkshopInfo[i][wDeputy3],"None", 0, strlen("None"), 32);
					}
					else
					{
						strmid(WorkshopInfo[i][wDeputy3],PTEMP[strval(inputtext)][pName], 0, strlen(PTEMP[strval(inputtext)][pName]), 32);
						SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность заместителя [3]",WorkshopInfo[i][wDeputy3]);
						SendMes(strval(inputtext),COLOR_BLUE," %s принял вас на должность заместителя [3]",PTEMP[playerid][pName]);
					}
				}
			case 4:
				{
					if(strval(inputtext) == -1)
					{
						if(strcmp(WorkshopInfo[i][wMechanic1],"None",true) == 0) return SCM(playerid,COLOR_GREY," Данный слот не занят!"), ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад");
						SendMes(playerid,COLOR_BLUE," Вы уволили %s с должности механика [1]",WorkshopInfo[i][wMechanic1]), strmid(WorkshopInfo[i][wMechanic1],"None", 0, strlen("None"), 32);
					}
					else
					{
						strmid(WorkshopInfo[i][wMechanic1],PTEMP[strval(inputtext)][pName], 0, strlen(PTEMP[strval(inputtext)][pName]), 32);
						SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность механика [1]",WorkshopInfo[i][wMechanic1]);
						SendMes(strval(inputtext),COLOR_BLUE," %s принял вас на должность механика [1]",PTEMP[playerid][pName]);
					}
				}
			case 5:
				{
					if(strval(inputtext) == -1)
					{
						if(strcmp(WorkshopInfo[i][wMechanic2],"None",true) == 0) return SCM(playerid,COLOR_GREY," Данный слот не занят!"), ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад");
						SendMes(playerid,COLOR_BLUE," Вы уволили %s с должности механика [2]",WorkshopInfo[i][wMechanic2]), strmid(WorkshopInfo[i][wMechanic2],"None", 0, strlen("None"), 32);
					}
					else
					{
						strmid(WorkshopInfo[i][wMechanic2],PTEMP[strval(inputtext)][pName], 0, strlen(PTEMP[strval(inputtext)][pName]), 32);
						SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность механика [2]",WorkshopInfo[i][wMechanic2]);
						SendMes(strval(inputtext),COLOR_BLUE," %s принял вас на должность механика [2]",PTEMP[playerid][pName]);
					}
				}
			case 6:
				{
					if(strval(inputtext) == -1)
					{
						if(strcmp(WorkshopInfo[i][wMechanic3],"None",true) == 0) return SCM(playerid,COLOR_GREY," Данный слот не занят!"), ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад");
						SendMes(playerid,COLOR_BLUE," Вы уволили %s с должности механика [3]",WorkshopInfo[i][wMechanic3]), strmid(WorkshopInfo[i][wMechanic3],"None", 0, strlen("None"), 32);
					}
					else
					{
						strmid(WorkshopInfo[i][wMechanic3],PTEMP[strval(inputtext)][pName], 0, strlen(PTEMP[strval(inputtext)][pName]), 32);
						SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность механика [3]",WorkshopInfo[i][wMechanic3]);
						SendMes(strval(inputtext),COLOR_BLUE," %s принял вас на должность механика [3]",PTEMP[playerid][pName]);
					}
				}
			case 7:
				{
					if(strval(inputtext) == -1)
					{
						if(strcmp(WorkshopInfo[i][wMechanic4],"None",true) == 0) return SCM(playerid,COLOR_GREY," Данный слот не занят!"), ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад");
						SendMes(playerid,COLOR_BLUE," Вы уволили %s с должности механика [4]",WorkshopInfo[i][wMechanic4]), strmid(WorkshopInfo[i][wMechanic4],"None", 0, strlen("None"), 32);
					}
					else
					{
						strmid(WorkshopInfo[i][wMechanic4],PTEMP[strval(inputtext)][pName], 0, strlen(PTEMP[strval(inputtext)][pName]), 32);
						SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность механика [4]",WorkshopInfo[i][wMechanic4]);
						SendMes(strval(inputtext),COLOR_BLUE," %s принял вас на должность механика [4]",PTEMP[playerid][pName]);
					}
				}
			case 8:
				{
					if(strval(inputtext) == -1)
					{
						if(strcmp(WorkshopInfo[i][wMechanic5],"None",true) == 0) return SCM(playerid,COLOR_GREY," Данный слот не занят!"), ShowPlayerDialogEx(playerid, 6005, DIALOG_STYLE_INPUT, "Нанять рабочего","Введите ид игрока в данное окно\n\nВНИМАНИЕ: Введите -1 для увольнения","Далее","Назад");
						SendMes(playerid,COLOR_BLUE," Вы уволили %s с должности механика [5]",WorkshopInfo[i][wMechanic5]), strmid(WorkshopInfo[i][wMechanic5],"None", 0, strlen("None"), 32);
					}
					else
					{
						strmid(WorkshopInfo[i][wMechanic5],PTEMP[strval(inputtext)][pName], 0, strlen(PTEMP[strval(inputtext)][pName]), 32);
						SendMes(playerid,COLOR_BLUE," Вы приняли %s на должность механика [5]",WorkshopInfo[i][wMechanic5]);
						SendMes(strval(inputtext),COLOR_BLUE," %s принял вас на должность механика [5]",PTEMP[playerid][pName]);
					}
				}
			}
			DeletePVar(playerid,"w_slot");
			return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
				\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
		}
	case 6000:
		{
			if(!WGet(playerid)) return true;
			new i = GetPVarInt(playerid,"wShop");
			if(!response)
			{
				return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
					\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
			}
			if(WorkshopInfo[i][wBank] > 1000000000) return SCM(playerid,COLOR_GREY," Нет места!");
			if(strval(inputtext) < 0 || strval(inputtext) > PTEMP[playerid][pBank]) return ShowPlayerDialogEx(playerid, 6000, DIALOG_STYLE_INPUT, "Пополнить банк автомастерской","Введите сумму для пополнения","Пополнить","Назад");
			WorkshopInfo[i][wBank]+=strval(inputtext);
			PTEMP[playerid][pBank]-=strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Вы пополнили счёт банка автомастерской на %i вирт",strval(inputtext));
			return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
				\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
		}
	case 6001:
		{
			if(!WGet(playerid)) return true;
			new i = GetPVarInt(playerid,"wShop");
			if(!response)
			{
				return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
					\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
			}
			if(WorkshopInfo[i][wLandTax]+strval(inputtext) > 84000) return SCM(playerid,COLOR_GREY," Неверная сумма. Максимально допустимая сумма 84000 вирт (7 дней)"), ShowPlayerDialogEx(playerid, 6001, DIALOG_STYLE_INPUT, "Пополнить 'LandTax' счёт","Введите сумму для пополнения","Пополнить","Назад");
			if(strval(inputtext) < 0 || strval(inputtext) > PTEMP[playerid][pBank]) return ShowPlayerDialogEx(playerid, 6001, DIALOG_STYLE_INPUT, "Пополнить 'LandTax' счёт","Введите сумму для пополнения","Пополнить","Назад");
			WorkshopInfo[i][wLandTax]+=strval(inputtext);
			PTEMP[playerid][pBank]-=strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Вы пополнили 'LandTax' счёт автомастерской на %i вирт",strval(inputtext));
			return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
				\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
		}
	case 6002:
		{
			if(!WGet(playerid)) return true;
			new i = GetPVarInt(playerid,"wShop");
			if(!response)
			{
				return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
					\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
			}
			if(strval(inputtext) < 0 || strval(inputtext) > WorkshopInfo[i][wBank]) return ShowPlayerDialogEx(playerid, 6002, DIALOG_STYLE_INPUT, "Снять деньги с банка","Введите сумму для снятия","Снять","Назад");
			WorkshopInfo[i][wBank]-=strval(inputtext);
			PTEMP[playerid][pBank]+=strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Вы сняли со счёта автомастерской %i вирт",strval(inputtext));
			return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
				\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
		}
	case 6003:
		{
			if(!WGet(playerid)) return true;
			new i = GetPVarInt(playerid,"wShop");
			if(!response)
			{
				return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
					\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
			}
			if(strval(inputtext) < 50 || strval(inputtext) > 100) return ShowPlayerDialogEx(playerid, 6003, DIALOG_STYLE_INPUT, "Установить стоимость 1 продукта","Введите стоимость одного продукта\n\nВНИМАНИЕ: Сумма стоимости должна быть\nне менее 50 вирт и не более 100 вирт","Установить","Назад");
			WorkshopInfo[i][wPriceProds] = strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Стоимость одного продукта равна %i вирт",strval(inputtext));
			return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
				\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
		}
	case 6004:
		{
			if(!WGet(playerid)) return true;
			new i = GetPVarInt(playerid,"wShop");
			if(!response)
			{
				return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
					\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
			}
			if(strval(inputtext) < 1 || strval(inputtext) > 10) return ShowPlayerDialogEx(playerid, 6004, DIALOG_STYLE_INPUT, "Установить зарплату рабочим","Введите сумму зарплаты\n\nВНИМАНИЕ: Сумма должна быть не менее 1 вирт\nи не более 10 вирт","Установить","Назад");
			WorkshopInfo[i][wZp] = strval(inputtext);
			SendMes(playerid,COLOR_BLUE," Заработная плата рабочим равна %i вирт",strval(inputtext));
			return ShowPlayerDialogEx(playerid, 9592, DIALOG_STYLE_LIST, "Панель управления","[1] Пополнить банк автомастерской\n[2] Пополнить 'LandTax' счёт\n[3] Снять деньги с банка\n[4] Установить стоимость 1 продукта\n[5] Установить зарплату рабочим\n[6] Нанять заместителя (1)\
				\n[7] Нанять заместителя (2)\n[8] Нанять заместителя (3)\n[9] Нанять механика (1)\n[10] Нанять механика (2)\n[11] Нанять механика (3)\n[12] Нанять механика (4)\n[13] Нанять механика (5)", "Выбрать", "Отмена");
		}
	case 6500:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
				    SetPVarInt(GetPVarInt(playerid,"installation_"), "deleting_tune", 1);
				    SCM(playerid,COLOR_GREEN," Ожидайте подтверждения игрока!");
					format(string,200,"Механик %s предлагает вам удалить тюнинг вашего автомобиля",PTEMP[playerid][pName]);
					ShowPlayerDialogEx(GetPVarInt(playerid,"installation_"), 6501, DIALOG_STYLE_MSGBOX, "Удаление тюнинга:",string, "Удалить", "Отмена");
				}
			case 1:
				{
					new i = GetPVarInt(playerid,"installation_");
					if(CarInfo[i][carPercent][GetPVarInt(i, "chosencar")] >= 100 || CarInfo[i][carPercent][GetPVarInt(i, "chosencar")] <= 0) return SCM(playerid,COLOR_GREY," Игроку не нужна замена двигателя!");
					new cost = 0;
					switch(GetVehicleModel(house_car[i]))
					{
					case 400: cost = 650; case 404: cost = 500; case 436: cost = 500; case 439: cost = 750; case 458: cost = 600;
					case 466: cost = 550; case 475: cost = 950; case 478: cost = 500; case 479: cost = 550; case 492: cost = 700;
					case 516: cost = 700; case 517: cost = 750; case 518: cost = 850; case 526: cost = 550; case 527: cost = 500;
					case 542: cost = 600; case 543: cost = 500; case 546: cost = 700; case 547: cost = 550; case 549: cost = 600;
					case 567: cost = 1000; case 419: cost = 4000; case 421: cost = 4150; case 445: cost = 4050; case 489: cost = 4400;
					case 491: cost = 4000; case 533: cost = 4100; case 534: cost = 3600; case 554: cost = 4200; case 555: cost = 5000;
					case 561: cost = 4050; case 579: cost = 4650; case 580: cost = 5000; case 589: cost = 3500; case 603: cost = 4000;
					case 418: cost = 3500; case 461: cost = 5000; case 581: cost = 5000; case 586: cost = 4000; case 401: cost = 1700;
					case 405: cost = 2000; case 412: cost = 1750; case 422: cost = 1550; case 426: cost = 2100; case 467: cost = 1850;
					case 474: cost = 1850; case 496: cost = 2400; case 507: cost = 2250; case 529: cost = 2200; case 536: cost = 2000;
					case 540: cost = 1650; case 550: cost = 2400; case 551: cost = 2400; case 566: cost = 1750; case 575: cost = 2300;
					case 576: cost = 1750; case 585: cost = 1750; case 600: cost = 2100; case 402: cost = 15000; case 411: cost = 15000;
					case 415: cost = 15000; case 429: cost = 15000; case 451: cost = 20000; case 506: cost = 15000; case 541: cost = 20000;
					case 522: cost = 15000; case 434: cost = 16000; case 477: cost = 9500; case 480: cost = 10000; case 535: cost = 8500;
					case 545: cost = 7000; case 558: cost = 8500; case 559: cost = 9000; case 560: cost = 8950; case 562: cost = 9000;
					case 565: cost = 9000; case 587: cost = 9000; case 602: cost = 8000; case 521: cost = 8000; case 463: cost = 8000;
					case 468: cost = 7000;
					}
					SetPVarInt(i,"cost",cost*(100-CarInfo[i][carPercent][GetPVarInt(i, "chosencar")]));
					SetPVarInt(i,"prods",200);
					SetPVarInt(i,"detals",99);
					SetPVarInt(playerid,"installation",1);
					SCM(playerid,COLOR_GREEN," Ожидайте подтверждения игрока!");
					format(string,200,"Механик %s предлагает вам поставить новый двигатель\nСтоимость нового двигателя: %i вирт",PTEMP[playerid][pName],GetPVarInt(i,"cost"));
					ShowPlayerDialogEx(i, 6501, DIALOG_STYLE_MSGBOX, "Установка детали:",string, "Установить", "Отмена");
				}
			case 2: ShowPlayerDialogEx(playerid,6502,DIALOG_STYLE_INPUT,"Установка детали:","Введите 2 цвета, через пробел\n\nПример: 0 0", "Далее","Отмена");
			default:
				{
					new i = GetPVarInt(playerid,"installation_");
					new till = WorkshopInfo[GetPVarInt(i,"InWorkshop")][wPriceProds];
					SetPVarInt(i,"cost",till*AllTuningComponentsInfo[AwtomasMassiveID[playerid][listitem-3]][Cost]);
					SetPVarInt(i,"prods",200);
					SetPVarInt(i,"detals",AllTuningComponentsInfo[AwtomasMassiveID[playerid][listitem-3]][idcomp]);
					SetPVarInt(playerid,"installation",2);
					AddVehicleComponent(house_car[i],AllTuningComponentsInfo[AwtomasMassiveID[playerid][listitem-3]][idcomp]);
					SCM(playerid,COLOR_GREEN," Ожидайте подтверждения игрока!");
					format(string,200,"Механик %s предлагает вам поставить деталь %s\t\"%s\"\nСтоимость установки детали: %i вирт",PTEMP[playerid][pName],AllTuningComponentsInfo[AwtomasMassiveID[playerid][listitem-3]][Type],AllTuningComponentsInfo[AwtomasMassiveID[playerid][listitem-3]][Name],GetPVarInt(i,"cost"));
					ShowPlayerDialogEx(i, 6501, DIALOG_STYLE_MSGBOX, "Установка детали:",string, "Установить", "Отмена");
				}
			}
			return true;
		}
	case 6501:
		{
			if(response)
			{
				if(WorkshopInfo[GetPVarInt(playerid,"InWorkshop")][wProds] < GetPVarInt(playerid,"prods"))
				{
					if(GetPVarInt(playerid,"detals") > 100) RemoveVehicleComponent(house_car[playerid],GetPVarInt(playerid,"detals"));
					LoadTuning(playerid,house_car[playerid],GetPVarInt(playerid, "chosencar"));
					DeletePVar(playerid,"cost");
					DeletePVar(playerid,"prods");
					DeletePVar(playerid,"detals");
					DeletePVar(GetPVarInt(playerid,"mechanic"),"installation");
					SCM(playerid,COLOR_LIGHTRED," У автомастерской недостаточно продуктов!");
					return SetPlayerChatBubble(playerid,"Недостаточно продуктов",COLOR_GREEN,30.0,10000);
				}
				if(PTEMP[playerid][pBank] < GetPVarInt(playerid,"cost"))
				{
					if(GetPVarInt(playerid,"detals") > 100) RemoveVehicleComponent(house_car[playerid],GetPVarInt(playerid,"detals"));
					LoadTuning(playerid,house_car[playerid],GetPVarInt(playerid, "chosencar"));
					DeletePVar(playerid,"cost");
					DeletePVar(playerid,"prods");
					DeletePVar(playerid,"detals");
					DeletePVar(GetPVarInt(playerid,"mechanic"),"installation");
					SCM(playerid,COLOR_LIGHTRED," У вас недостаточно средств на банк. счете!");
					return SetPlayerChatBubble(playerid,"Недостаточно денег",COLOR_GREEN,30.0,10000);
				}
				switch(GetPVarInt(playerid,"detals"))
				{
				case 99:
					{
						new Float:p[3]; GetVehiclePos(house_car[playerid],p[0],p[1],p[2]);
						SetPlayerCheckpoint(GetPVarInt(playerid,"mechanic"),p[0]+4,p[1],p[2], 1.0);
					}
				case 100:
					{
						new Float:p[3]; GetVehiclePos(house_car[playerid],p[0],p[1],p[2]);
						SetPlayerCheckpoint(GetPVarInt(playerid,"mechanic"),p[0]-4,p[1],p[2], 1.0);
					}
				default:
					{
						new Float:p[3], rando = random(2); GetVehiclePos(house_car[playerid],p[0],p[1],p[2]);
						if(rando == 0) SetPlayerCheckpoint(GetPVarInt(playerid,"mechanic"),p[0],p[1]-2,p[2], 1.0);
						else SetPlayerCheckpoint(GetPVarInt(playerid,"mechanic"),p[0],p[1]+2,p[2], 1.0);
					}
				}
				if(GetPVarInt(playerid, "deleting_tune") == 1)
				{
                    RemoveTuning(playerid, house_car[playerid]);
                    return true;
				}
				SCM(playerid,COLOR_GREEN," Ожидайте пока механик установит деталь");
				SetPlayerChatBubble(playerid,"Подтвердил сделку",COLOR_GREEN,30.0,10000);
				SCM(GetPVarInt(playerid,"mechanic"),COLOR_GREEN," Установите деталь (( Встаньте на красный чекпоинт ))");
				return SetPVarInt(GetPVarInt(playerid,"mechanic"),"installation",2);
			}
			else
			{
				if(GetPVarInt(playerid,"detals") > 100) RemoveVehicleComponent(house_car[playerid],GetPVarInt(playerid,"detals"));
				DeletePVar(playerid,"cost");
				DeletePVar(playerid,"prods");
				DeletePVar(playerid,"detals");
				DeletePVar(playerid,"number");
				DeletePVar(playerid,"color0");
				DeletePVar(playerid,"color1");
				DeletePVar(GetPVarInt(playerid,"mechanic"),"installation");
				SetPlayerChatBubble(playerid,"Отменил сделку",COLOR_GREEN,30.0,10000);
				SCM(GetPVarInt(playerid,"mechanic"),COLOR_GREEN," Игрок отменил установку детали");
				LoadTuning(playerid,house_car[playerid],GetPVarInt(playerid, "chosencar"));
			}
			
			return true;
		}
	case 6502:
		{
			if(!response) return true;
			new Colors[2];
			if(sscanf(inputtext, "p< >ii",Colors[0],Colors[1])) return ShowPlayerDialogEx(playerid,6502,DIALOG_STYLE_INPUT,"Установка детали:","Введите 2 цвета, через пробел\n\nПример: 0 0", "Далее","Отмена");
			if(Colors[0] < 0 || Colors[0] > 255 || Colors[1] < 0 || Colors[1] > 255) return ShowPlayerDialogEx(playerid,6502,DIALOG_STYLE_INPUT,"Установка детали:","Введите 2 цвета, через пробел\n\nПример: 0 0", "Далее","Отмена");
			new i = GetPVarInt(playerid,"installation_");
			new till = WorkshopInfo[GetPVarInt(i,"InWorkshop")][wPriceProds];
			SetPVarInt(i,"cost",till*500);
			SetPVarInt(i,"prods",100);
			SetPVarInt(i,"detals",100);
			SetPVarInt(i,"color0",Colors[0]);
			SetPVarInt(i,"color1",Colors[1]);
			SetPVarInt(playerid,"installation",1);
			ChangeVehicleColor(house_car[i], Colors[0], Colors[1]);
			SCM(playerid,COLOR_GREEN," Ожидайте подтверждения игрока!");
			format(string,200,"Механик %s предлагает вам перекрасить ваш автомобиль\nСтоимость перекраски: %i вирт",PTEMP[playerid][pName],GetPVarInt(i,"cost"));
			return ShowPlayerDialogEx(i, 6501, DIALOG_STYLE_MSGBOX, "Установка детали:",string, "Установить", "Отмена");
		}
	case 139:
		{
			if(GetPlayerVirtualWorld(playerid) == 0) return true;
			if(response)
			{
				if(GetPVarInt(playerid,"Workshop")) return SCM(playerid,COLOR_GREY," Вы уже начали работу");
				if(GetWorkshopW(playerid,GetPlayerVirtualWorld(playerid))) SetPVarInt(playerid,"Workshop__",3), SetPlayerSkin(playerid,221);
				else if(GetWorkshop(playerid,GetPlayerVirtualWorld(playerid)) == 2) SetPVarInt(playerid,"Workshop__",2), SetPlayerSkin(playerid,222);
				else if(GetWorkshop(playerid,GetPlayerVirtualWorld(playerid)) == 1) SetPVarInt(playerid,"Workshop__",1), SetPlayerSkin(playerid,50);
				else if(GetWorkshop(playerid,GetPlayerVirtualWorld(playerid)) && PTEMP[playerid][pSex] == 2) SetPlayerSkin(playerid,225);
				else return SCM(playerid,COLOR_GREY," Вы тут не работаете");
				SendMes(playerid,COLOR_BLUE," Вы начали работу в автомастерской номер %i",GetPlayerVirtualWorld(playerid)-1);
				SetPVarInt(playerid,"Workshop",GetPlayerVirtualWorld(playerid));
				DeletePVar(playerid,"Workshop_");
			}
			else
			{
				if(!GetPVarInt(playerid,"Workshop")) return SCM(playerid,COLOR_GREY," Вы не начинали тут работу");
				SendMes(playerid,COLOR_BLUE," Вы закончили свою работу. Вами заработано %i вирт",GetPVarInt(playerid,"Workshop_"));
				SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
				format(string, 20, "~g~+$%i",GetPVarInt(playerid,"Workshop_"));
				GameTextForPlayer(playerid, string, 2000, 1);
				PTEMP[playerid][pPayCheck] += GetPVarInt(playerid,"Workshop_")/3;
				WorkshopInfo[GetPVarInt(playerid,"Workshop")][wBank]-=GetPVarInt(playerid,"Workshop_");
				DeletePVar(playerid,"Workshop");
				DeletePVar(playerid,"Workshop_");
				DeletePVar(playerid,"Workshop__");
			}
			return true;
		}
	case 135:
		{
			if(!response) return true;
			return ExitBone(playerid);
		}
	case 136:
		{
			if(!response) return true;
			if(strval(inputtext) < 1000 || strval(inputtext) > 300000000) return SCM(playerid,COLOR_GREY," Неверная ставка");
			new null = 0;
			for(new i; i < 5; i++) if(GetPVarInt(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Gamer][i],"BoneStol_")) null++;
			if(null > 0) return SCM(playerid,COLOR_GREY," Кто то из игроков уже поставил ставку");
			if(BoneInfo[GetPVarInt(playerid,"BoneStol")-1][GameStart] != 0) return SCM(playerid,COLOR_GREY," Вы не можете изменить ставку в процессе игры!");
			BoneInfo[GetPVarInt(playerid,"BoneStol")-1][Bet] = strval(inputtext);
			SCM(playerid,COLOR_INDIGO," Ставка успешно установлена!");
			return UpdateBone(GetPVarInt(playerid,"BoneStol")-1);
		}
	case 141:
		{
		/*
			if(!response) return true;
			if(GetPVarInt(playerid,"took_faggio")) DestroyVehicle(GetPVarInt(playerid,"took_faggio")), DeletePVar(playerid,"took_faggio");
			for(new t; t < 5; t++) TextDrawShowForPlayer(playerid, Tookfaggio[t]);
			SelectTextDraw(playerid, 0xFFFF00FF);
			SetPVarInt(playerid,"Tookfaggio",1);
			SCM(playerid,COLOR_GREEN," Выберите транспорт из списка, для закрытия используйте ESC");
		*/
		}
	case 5576:
		{
			if(!response || !GetPVarInt(playerid,"RStol") || RouletPlay[GetPVarInt(playerid,"RStol")] || GetPVarInt(playerid,"RStavka")) return true;
			switch(GetPVarInt(playerid,"RStol"))
			{
			case 1,5,12: {
					if(strval(inputtext) < 500 || strval(inputtext) > 5000 || PTEMP[playerid][pCash] < strval(inputtext)) return ShowPlayerDialogEx(playerid,5576,DIALOG_STYLE_INPUT,"Ставка","Минимальная ставка: 500 вирт\nМаксимальняа ставка: 5000 вирт\nВведите сумму:","Играть","Закрыть"); }
			case 2,7,10: {
					if(strval(inputtext) < 2000 || strval(inputtext) > 20000 || PTEMP[playerid][pCash] < strval(inputtext)) return ShowPlayerDialogEx(playerid,5576,DIALOG_STYLE_INPUT,"Ставка","Минимальная ставка: 2000 вирт\nМаксимальняа ставка: 20000 вирт\nВведите сумму:","Играть","Закрыть"); }
			case 3,8,11: {
					if(strval(inputtext) < 5000 || strval(inputtext) > 50000 || PTEMP[playerid][pCash] < strval(inputtext)) return ShowPlayerDialogEx(playerid,5576,DIALOG_STYLE_INPUT,"Ставка","Минимальная ставка: 5000 вирт\nМаксимальняа ставка: 50000 вирт\nВведите сумму:","Играть","Закрыть"); }
			case 4,6,9: {
					if(strval(inputtext) < 10000 || strval(inputtext) > 100000 || PTEMP[playerid][pCash] < strval(inputtext)) return ShowPlayerDialogEx(playerid,5576,DIALOG_STYLE_INPUT,"Ставка","Минимальная ставка: 10000 вирт\nМаксимальняа ставка: 100000 вирт\nВведите сумму:","Играть","Закрыть"); }
			}
			SetPVarInt(playerid,"RStavka",strval(inputtext));
			GetCasinoNumber(playerid);
			PTEMP[playerid][pCash]-=strval(inputtext);
			DestroyObject(GetPVarInt(playerid,"RObj"));
			new obj = CreateObject(random(3) + 1930,GetPVarFloat(playerid,"RX"),GetPVarFloat(playerid,"RY"),GetPVarFloat(playerid,"RZ"),0.00,0.00,0.00);
			SetPVarInt(playerid,"RObj",obj);
			new str[40];
			if(GetPVarInt(playerid,"RNumber_") > 4)
			{
				switch(GetPVarInt(playerid,"RNumber"))
				{
				case 116, 118, 120: str = "3 to 1"; case 121: str = "1 st 12";
				case 122: str = "2 nd 12"; case 123: str = "3 rd 12";
				case 124: str = "1 to 18"; case 125: str = "Even";
				case 126: str = "Red"; case 127: str = "Black";
				case 128: str = "Odd"; case 129: str = "19 to 36";
				}
			}
			else GetPVarString(playerid,"RNumbers",str,sizeof(str));
			format(string,256,"~<~~>~~up~~down~~n~~g~Money: %i~n~~y~Bet: %s",GetPVarInt(playerid,"RStavka"),str);
			return PlayerTextDrawSetString(playerid,RouletText[playerid],string);
		}
	case 5490:
		{
			if(!response) return true;
			if(RouletPlay[GetPVarInt(playerid,"RStol")] == false) PTEMP[playerid][pCash]+=GetPVarInt(playerid,"RStavka");
			DestroyObject(GetPVarInt(playerid,"RObj"));
			DeletePVar(playerid,"RObj");
			DeletePVar(playerid,"RStavka");
			DeletePVar(playerid,"RStol");
			DeletePVar(playerid,"RX");
			DeletePVar(playerid,"RY");
			DeletePVar(playerid,"RZ");
			DeletePVar(playerid,"RXONE");
			DeletePVar(playerid,"RYONE");
			DeletePVar(playerid,"RZONE");
			DeletePVar(playerid,"RNumber");
			DeletePVar(playerid,"RNumbers");
			DeletePVar(playerid,"RNumber_");
			PlayerTextDrawHide(playerid,RouletText[playerid]);
			TogglePlayerControllable(playerid, true);
			SetCameraBehindPlayer(playerid);
			return true;
		}
	case 202:
		{
			if(!response) return 1;
			if(SpecAd[playerid] != INVALID_PLAYER_ID) SpecID[SpecAd[playerid]] = 65535;
			SpecAd[playerid] = 65535;
			new mess[40];format(mess, sizeof(mess), "/re %s",inputtext);CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);
		}
	case 115:
		{
			if(response){new mess[40];format(mess, sizeof(mess), "/kick %i %s",SpecAd[playerid],inputtext);CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);}
		}
	case 101:
		{
			if(response){new mess[40];format(mess, sizeof(mess), "/warn %i %s",SpecAd[playerid],inputtext);CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);}
		}
	case 102:
		{
			if(response){new mess[40];format(mess, sizeof(mess), "/ban %i %s 30",SpecAd[playerid],inputtext);CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);}
		}
	case 116:
		{
			if(response){new mess[40];format(mess, sizeof(mess), "/sban %i %s",SpecAd[playerid],inputtext);CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);}
		}
	case 117:
		{
			if(response){new mess[40];format(mess, sizeof(mess), "/iban %i %s",SpecAd[playerid],inputtext);CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);}
		}
	case 195:// N class
		{
			if(!response) return true;
			new house = PTEMP[playerid][pPHouseKey];
			switch(listitem)
			{
			case 0: SetPlayerPos(playerid, 267.4610,304.9829,999.1484),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 2),SetPVarInt(playerid, "BuyInt", 91),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 1: SetPlayerPos(playerid, 421.5309,2536.5486,10.0000),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 10),SetPVarInt(playerid, "BuyInt", 92),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 2: SetPlayerPos(playerid, 2233.6919,-1112.8107,1050.8828),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 5),SetPVarInt(playerid, "BuyInt", 93),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 3: SetPlayerPos(playerid, 421.7613,2536.4836,10.0000),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 10),SetPVarInt(playerid, "BuyInt", 94),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 4: SetPlayerPos(playerid, 221.6766,1142.4962,1082.6094),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 4),SetPVarInt(playerid, "BuyInt", 95),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 5: SetPlayerPos(playerid, 2217.9087,-1076.3169,1050.4844),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 1),SetPVarInt(playerid, "BuyInt", 96),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 6: SetPlayerPos(playerid, 2467.8691,-1698.3516,1013.5078),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 2),SetPVarInt(playerid, "BuyInt", 97),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			}

		}
	case 20:// d class
		{
			if(!response) return true;
			new house = PTEMP[playerid][pPHouseKey];
			switch(listitem)
			{
			case 0: SetPlayerPos(playerid, 225.756989,1240.000000,1082.149902),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 2),SetPVarInt(playerid, "BuyInt", 1),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 1: SetPlayerPos(playerid, 223.1406,1287.3282,1082.1406),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 1),SetPVarInt(playerid, "BuyInt", 2),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 2: SetPlayerPos(playerid, 327.8892,1477.9272,1084.4375),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 15),SetPVarInt(playerid, "BuyInt", 3),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 3: SetPlayerPos(playerid, 386.7251,1471.6462,1080.1949),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 15),SetPVarInt(playerid, "BuyInt", 4),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 4: SetPlayerPos(playerid, 261.0327,1284.4261,1080.2578),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 4),SetPVarInt(playerid, "BuyInt", 5),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 5: SetPlayerPos(playerid, -42.5901,1405.5869,1084.4297),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 8),SetPVarInt(playerid, "BuyInt", 6),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 6: SetPlayerPos(playerid, 260.7397,1237.3687,1084.2578),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 9),SetPVarInt(playerid, "BuyInt", 7),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			}
		}
	case 185:// C class
		{
			if(!response) return true;
			new house = PTEMP[playerid][pPHouseKey];
			switch(listitem)
			{
			case 0: SetPlayerPos(playerid, 2269.5125,-1210.5259,1047.5625),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 10),SetPVarInt(playerid, "BuyInt", 81),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 1: SetPlayerPos(playerid, 295.0497,1473.2526,1080.2578),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 15),SetPVarInt(playerid, "BuyInt", 82),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 2: SetPlayerPos(playerid, 376.3149,1417.2452,1081.3281),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 15),SetPVarInt(playerid, "BuyInt", 83),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 3: SetPlayerPos(playerid, 447.0495,1398.1041,1084.3047),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 2),SetPVarInt(playerid, "BuyInt", 84),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 4: SetPlayerPos(playerid, 22.7479,1404.0393,1084.4297),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 5),SetPVarInt(playerid, "BuyInt", 85),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 5: SetPlayerPos(playerid, -68.8678,1352.1532,1080.2109),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 6),SetPVarInt(playerid, "BuyInt", 86),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 6: SetPlayerPos(playerid, 2807.6147,-1173.7506,1025.5703),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 8),SetPVarInt(playerid, "BuyInt", 87),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 7: SetPlayerPos(playerid, 2237.5376,-1080.5271,1049.0234),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 2),SetPVarInt(playerid, "BuyInt", 88),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 8: SetPlayerPos(playerid, 2365.1992,-1134.6941,1050.8750),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 8),SetPVarInt(playerid, "BuyInt", 89),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			}
		}
	case 175:// B class
		{
			if(!response) return true;
			new house = PTEMP[playerid][pPHouseKey];
			switch(listitem)
			{
			case 0: SetPlayerPos(playerid, 491.1569,1399.1304,1080.2578),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 2),SetPVarInt(playerid, "BuyInt", 71),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 1: SetPlayerPos(playerid, 23.7754,1341.2480,1084.3750),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 10),SetPVarInt(playerid, "BuyInt", 72),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 2: SetPlayerPos(playerid, 2324.3342,-1148.4485,1050.7101),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 12),SetPVarInt(playerid, "BuyInt", 73),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 3: SetPlayerPos(playerid, -262.1759,1456.6158,1084.3672),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 4),SetPVarInt(playerid, "BuyInt", 74),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 4: SetPlayerPos(playerid, 235.2905,1187.5282,1080.2578),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 3),SetPVarInt(playerid, "BuyInt", 75),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			}
		}
	case 165:// A/S class
		{
			if(!response) return true;
			new house = PTEMP[playerid][pPHouseKey];
			switch(listitem)
			{
			case 0: SetPlayerPos(playerid, 2317.7722,-1026.1692,1050.2178),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 9),SetPVarInt(playerid, "BuyInt", 41),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 1: SetPlayerPos(playerid, 226.9458,1114.2930,1080.9962),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 5),SetPVarInt(playerid, "BuyInt", 42),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 2: SetPlayerPos(playerid, 140.2581,1366.7158,1083.8594),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 5),SetPVarInt(playerid, "BuyInt", 43),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 3: SetPlayerPos(playerid, 234.2826,1065.229,1084.2101),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 6),SetPVarInt(playerid, "BuyInt", 44),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			case 4: SetPlayerPos(playerid, 225.630997,1022.479980,1084.069946),SetPlayerVirtualWorld(playerid, house),SetPlayerInterior(playerid, 7),SetPVarInt(playerid, "BuyInt", 45),SCM(playerid, 0x6495edff, " Когда будете готовы, введите команду /buyInterior ещё раз");
			}
		}
	case 22:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(!response) return SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
			if(PTEMP[playerid][pBank] < 200000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
			HouseInfo[house][hInt] = 2;
			HouseInfo[house][hExitx] = 225.756989;
			HouseInfo[house][hExity]= 1240.000000;
			HouseInfo[house][hExitz] = 1082.149902;
			PTEMP[playerid][pBank] -=200000;
			BuyHouse(house);
			SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
			SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
			DeletePVar(playerid, "BuyInt");
			return true;
		}
	case 23:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(!response) return SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
			if(PTEMP[playerid][pBank] < 200000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
			HouseInfo[house][hInt] = 1;
			HouseInfo[house][hExitx] = 223.1406;
			HouseInfo[house][hExity]= 1287.3282;
			HouseInfo[house][hExitz] = 1082.1406;
			PTEMP[playerid][pBank] -=200000;
			BuyHouse(house);
			SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
			SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
			DeletePVar(playerid, "BuyInt");
			return true;
		}
	case 24:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(!response) return SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
			if(PTEMP[playerid][pBank] < 200000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
			HouseInfo[house][hInt] = 15;
			HouseInfo[house][hExitx] = 327.8892;
			HouseInfo[house][hExity]= 1477.9272;
			HouseInfo[house][hExitz] = 1084.4375;
			PTEMP[playerid][pBank] -=200000;
			BuyHouse(house);
			SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
			SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
			DeletePVar(playerid, "BuyInt");
			return true;
		}
	case 25:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(!response) return SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
			if(PTEMP[playerid][pBank] < 200000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
			HouseInfo[house][hInt] = 15;
			HouseInfo[house][hExitx] = 386.7251;
			HouseInfo[house][hExity]= 1471.6462;
			HouseInfo[house][hExitz] = 1080.1949;
			PTEMP[playerid][pBank] -=200000;
			BuyHouse(house);
			SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
			SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
			DeletePVar(playerid, "BuyInt");
			return true;
		}
	case 26:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 200000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 4;
				HouseInfo[house][hExitx] = 261.0327;
				HouseInfo[house][hExity]= 1284.4261;
				HouseInfo[house][hExitz] = 1080.2578;
				PTEMP[playerid][pBank] -=200000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 27:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 200000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 8;
				HouseInfo[house][hExitx] = -42.5901;
				HouseInfo[house][hExity]= 1405.5869;
				HouseInfo[house][hExitz] = 1084.4297;
				PTEMP[playerid][pBank] -=200000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 28:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 200000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 9;
				HouseInfo[house][hExitx] = 260.7397;
				HouseInfo[house][hExity]= 1237.3687;
				HouseInfo[house][hExitz] = 1084.2578;
				PTEMP[playerid][pBank] -=200000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 41:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 500000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 9;
				HouseInfo[house][hExitx] = 2317.7722;
				HouseInfo[house][hExity] = -1026.1692;
				HouseInfo[house][hExitz] = 1050.2178;
				PTEMP[playerid][pBank] -=500000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),DeletePVar(playerid, "BuyInt");
		}
	case 42:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 500000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 5;
				HouseInfo[house][hExitx] = 226.9458;
				HouseInfo[house][hExity]= 1114.2930;
				HouseInfo[house][hExitz] = 1080.9962;
				PTEMP[playerid][pBank] -=500000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),DeletePVar(playerid, "BuyInt");
		}
	case 43:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 500000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 5;
				HouseInfo[house][hExitx] = 140.2581;
				HouseInfo[house][hExity]= 1366.7158;
				HouseInfo[house][hExitz] = 1083.8594;
				PTEMP[playerid][pBank] -=500000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),DeletePVar(playerid, "BuyInt");
		}
	case 44:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 500000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 6;
				HouseInfo[house][hExitx] = 234.2826;
				HouseInfo[house][hExity]= 1065.229;
				HouseInfo[house][hExitz] = 1084.2101;
				PTEMP[playerid][pBank] -=500000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),DeletePVar(playerid, "BuyInt");
		}
	case 45:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 500000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 7;
				HouseInfo[house][hExitx] = 225.630997;
				HouseInfo[house][hExity]= 1022.479980;
				HouseInfo[house][hExitz] = 1084.069946;
				PTEMP[playerid][pBank] -=500000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 71:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 400000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 2;
				HouseInfo[house][hExitx] = 491.1569;
				HouseInfo[house][hExity] = 1399.1304;
				HouseInfo[house][hExitz] = 1080.2578;
				PTEMP[playerid][pBank] -=400000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 72:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 400000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 10;
				HouseInfo[house][hExitx] = 23.7754;
				HouseInfo[house][hExity]= 1341.2480;
				HouseInfo[house][hExitz] = 1084.3750;
				PTEMP[playerid][pBank] -=400000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 73:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 400000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 12;
				HouseInfo[house][hExitx] = 2324.3342;
				HouseInfo[house][hExity]= -1148.4485;
				HouseInfo[house][hExitz] = 1050.7101;
				PTEMP[playerid][pBank] -=400000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 74:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 400000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 4;
				HouseInfo[house][hExitx] = -262.1759;
				HouseInfo[house][hExity]= 1456.6158;
				HouseInfo[house][hExitz] = 1084.3672;
				PTEMP[playerid][pBank] -=400000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 75:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 400000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 3;
				HouseInfo[house][hExitx] = 235.2905;
				HouseInfo[house][hExity]= 1187.5282;
				HouseInfo[house][hExitz] = 1080.2578;
				PTEMP[playerid][pBank] -=400000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 81:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 300000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 10;
				HouseInfo[house][hExitx] = 2269.5125;
				HouseInfo[house][hExity] = -1210.5259;
				HouseInfo[house][hExitz] = 1047.5625;
				PTEMP[playerid][pBank] -=300000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 82:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 300000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 15;
				HouseInfo[house][hExitx] = 295.0497;
				HouseInfo[house][hExity]= 1473.2526;
				HouseInfo[house][hExitz] = 1080.2578;
				PTEMP[playerid][pBank] -=300000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 83:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 300000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 15;
				HouseInfo[house][hExitx] = 376.3149;
				HouseInfo[house][hExity] = 1417.2452;
				HouseInfo[house][hExitz] = 1081.3281;
				PTEMP[playerid][pBank] -=300000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 84:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 300000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 2;
				HouseInfo[house][hExitx] = 447.0495;
				HouseInfo[house][hExity]= 1398.1041;
				HouseInfo[house][hExitz] = 1084.3047;
				PTEMP[playerid][pBank] -=300000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 85:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 300000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 5;
				HouseInfo[house][hExitx] = 22.7479;
				HouseInfo[house][hExity]= 1404.0393;
				HouseInfo[house][hExitz] = 1084.4297;
				PTEMP[playerid][pBank] -=300000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 86:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 300000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 6;
				HouseInfo[house][hExitx] = -68.8678;
				HouseInfo[house][hExity] = 1352.1532;
				HouseInfo[house][hExitz] = 1080.2109;
				PTEMP[playerid][pBank] -=300000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 87:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 300000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 8;
				HouseInfo[house][hExitx] = 2807.6147;
				HouseInfo[house][hExity] = -1173.7506;
				HouseInfo[house][hExitz] = 1025.5703;
				PTEMP[playerid][pBank] -=300000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 88:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 300000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 2;
				HouseInfo[house][hExitx] = 2237.5376;
				HouseInfo[house][hExity]= -1080.5271;
				HouseInfo[house][hExitz] = 1049.0234;
				PTEMP[playerid][pBank] -=300000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 89:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 300000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 8;
				HouseInfo[house][hExitx] = 2365.1992;
				HouseInfo[house][hExity] = -1134.6941;
				HouseInfo[house][hExitz] = 1050.8750;
				PTEMP[playerid][pBank] -=300000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 91:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 100000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 2;
				HouseInfo[house][hExitx] = 267.4610;
				HouseInfo[house][hExity]= 304.9829;
				HouseInfo[house][hExitz] = 999.1484;
				PTEMP[playerid][pBank] -=100000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 92:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 100000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 10;
				HouseInfo[house][hExitx] = 421.5309;
				HouseInfo[house][hExity]= 2536.5486;
				HouseInfo[house][hExitz] = 10.0000;
				PTEMP[playerid][pBank] -=100000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 93:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 100000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 5;
				HouseInfo[house][hExitx] = 2233.6919;
				HouseInfo[house][hExity]= -1112.8107;
				HouseInfo[house][hExitz] = 1050.8828;
				PTEMP[playerid][pBank] -=100000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 94:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 100000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 10;
				HouseInfo[house][hExitx] = 421.7613;
				HouseInfo[house][hExity]= 2536.4836;
				HouseInfo[house][hExitz] = 10.0000;
				PTEMP[playerid][pBank] -=100000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 95:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 100000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 4;
				HouseInfo[house][hExitx] = 221.6766;
				HouseInfo[house][hExity]= 1142.4962;
				HouseInfo[house][hExitz] = 1082.6094;
				PTEMP[playerid][pBank] -=100000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 96:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 100000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 1;
				HouseInfo[house][hExitx] = 2217.9087;
				HouseInfo[house][hExity]= -1076.3169;
				HouseInfo[house][hExitz] = 1050.4844;
				PTEMP[playerid][pBank] -=100000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 97:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(response)
			{
				if(PTEMP[playerid][pBank] < 100000) return SCM(playerid, COLOR_GREY, " Недостаточно средств в банке!");
				HouseInfo[house][hInt] = 2;
				HouseInfo[house][hExitx] = 2467.8691;
				HouseInfo[house][hExity]= -1698.3516;
				HouseInfo[house][hExitz] = 1013.5078;
				PTEMP[playerid][pBank] -=100000;
				BuyHouse(house);
				SCM(playerid, COLOR_BLUE, " Сделка прошла успешно");
				SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50);
				DeletePVar(playerid, "BuyInt");
				return true;
			}
			else SetPlayerPos(playerid, HouseInfo[house][hExitx],HouseInfo[house][hExity],HouseInfo[house][hExitz]),SetPlayerInterior(playerid, HouseInfo[house][hInt]),SetPlayerVirtualWorld(playerid, house+50),DeletePVar(playerid, "BuyInt");
		}
	case 50:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
        }
    case 50+1:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 0 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+1, DIALOG_STYLE_LIST, "Меню", "[0] [skin:79]\n[1] [skin:78]\n[2] [skin:137]\n[3] [skin:200]\n[4] [skin:230]\n[5] [skin:239]\n[6] [skin:212]\n[7] [skin:228]\n[8] [skin:142]\n[9] [skin:297]\n[10] [skin:292]\n[11] [skin:122]\n[12] [skin:193]\n[13] [skin:55]\n[14] [skin:90]\n[15] [skin:40]\n[16] [skin:233]\n[17] [skin:298]\n[18] [skin:93]", "Выбрать", "Назад");
        }
    case 50+2:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 1 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+2, DIALOG_STYLE_LIST, "Меню", "[0] [skin:280]\n[1] [skin:281]\n[2] [skin:282]\n[3] [skin:283]\n[4] [skin:288]\n[5] [skin:284]\n[6] [skin:285]\n[7] [skin:76]\n[8] [skin:306]\n[9] [skin:307]\n[10] [skin:309]\n[11] [skin:265]\n[12] [skin:266]\n[13] [skin:267]\n[14] [skin:310]\n[15] [skin:311]\n[16] [skin:302]\n[17] [skin:303]\n[18] [skin:304]\n[19] [skin:305]", "Выбрать", "Назад");
        }
    case 50+3:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 2 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+3, DIALOG_STYLE_LIST, "Меню", "[0] [skin:287]\n[1] [skin:191]\n[2] [skin:179]", "Выбрать", "Назад");
        }
    case 50+4:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 3 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+4, DIALOG_STYLE_LIST, "Меню", "[0] [skin:274]\n[1] [skin:275]\n[2] [skin:276]\n[3] [skin:70]\n[4] [skin:219]\n[5] [skin:308]", "Выбрать", "Назад");
        }
    case 50+5:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 4 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+5, DIALOG_STYLE_LIST, "Меню", "[0] [skin:57]\n[1] [skin:98]\n[2] [skin:147]\n[3] [skin:187]\n[4] [skin:216]", "Выбрать", "Назад");
        }
    case 50+6:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 5 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+6, DIALOG_STYLE_LIST, "Меню", "[0] [skin:59]\n[1] [skin:240]\n[2] [skin:150]", "Выбрать", "Назад");
        }
    case 50+7:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 6 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+7, DIALOG_STYLE_LIST, "Меню", "[0] [skin:188]\n[1] [skin:217]\n[2] [skin:250]\n[3] [skin:261]\n[4] [skin:148]\n[5] [skin:211]", "Выбрать", "Назад");
        }
    case 50+8:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 7 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+8, DIALOG_STYLE_LIST, "Меню", "[0] [skin:124]\n[1] [skin:223]\n[2] [skin:113]\n[3] [skin:91]", "Выбрать", "Назад");
        }
    case 50+9:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 8 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+9, DIALOG_STYLE_LIST, "Меню", "[0] [skin:123]\n[1] [skin:186]\n[2] [skin:120]\n[3] [skin:169]\n[4] [skin:117]\n[5] [skin:118]", "Выбрать", "Назад");
        }
    case 50+10:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 9 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+10, DIALOG_STYLE_LIST, "Меню", "[0] [skin:272]\n[1] [skin:112]\n[2] [skin:125]\n[3] [skin:214]\n[4] [skin:111]", "Выбрать", "Назад");
        }
    case 50+11:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 10 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+11, DIALOG_STYLE_LIST, "Меню", "[0] [skin:175]\n[1] [skin:174]\n[2] [skin:173]\n[3] [skin:226]", "Выбрать", "Назад");
        }
    case 50+12:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 11 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+12, DIALOG_STYLE_LIST, "Меню", "[0] [skin:105]\n[1] [skin:106]\n[2] [skin:107]\n[3] [skin:269]\n[4] [skin:271]\n[5] [skin:270]\n[6] [skin:56]", "Выбрать", "Назад");
        }
    case 50+13:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 12 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+13, DIALOG_STYLE_LIST, "Меню", "[0] [skin:102]\n[1] [skin:103]\n[2] [skin:104]\n[3] [skin:195]", "Выбрать", "Назад");
        }
    case 50+17:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 13 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+17, DIALOG_STYLE_LIST, "Меню", "[0] [skin:108]\n[1] [skin:109]\n[2] [skin:110]\n[3] [skin:190]", "Выбрать", "Назад");
        }
    case 50+15:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 14 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+17, DIALOG_STYLE_LIST, "Меню", "[0] [skin:114]\n[1] [skin:116]\n[2] [skin:115]\n[3] [skin:41]", "Выбрать", "Назад");
        }
    case 50+16:
        {
            if(!response) return true;
            format(string, sizeof(string), "/spy %i on 15 %i", GetPVarInt(playerid, "SmenaSkina"), listitem);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
            return ShowPlayerDialogEx(playerid, 50+16, DIALOG_STYLE_LIST, "Меню", "[0] [skin:100]\n[1] [skin:247]\n[2] [skin:248]\n[3] [skin:254]\n[4] [skin:246]\n[5] [skin:64]\n[6] [skin:131]\n[7] [skin:198]\n[8] [skin:181]", "Выбрать", "Назад");
        }
		//AutoSalon
	case 14009:
		{
			new x;
			switch(GetPVarInt(playerid,"AutoShop"))
			{
			case 3,4: x = 2;
			}
			if(response) SetPVarInt(playerid,"CarShop",x+1);
			else SetPVarInt(playerid,"CarShop",x+2);
			ShowBuyCar(playerid);
		}
	case 14010:
		{
		    if(!response) return true;
		    SetPVarInt(playerid, "chosencar_s", listitem);
			//SetPVarInt(playerid, "chosencar", listitem);
		    format(string, sizeof(string), "\n\n{FFFFFF}Вы действительно хотите заменить ваше авто {FFFF00}%s {FFFFFF} на новое {FFFF00}%s\n\n",
					VehicleNames[CarInfo[playerid][carModel][listitem]-400], VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400]);
			ShowPlayerDialogEx(playerid, 14012, 0, "Предупреждение", string, "Купить", "Отмена");
		}
	case 14012:
	    {
	        if(!response)
			{
		        new strs[128];
			    for(new i = 0; i < HouseInfo[HGet(playerid)][hKlass]; i++)
			    {
			        new str[32];
			        format(str, sizeof(str), "[%i] %s\n", i, VehicleNames[CarInfo[playerid][carModel][i]-400]);
			        strcat(strs, str, sizeof(strs));
			    }
				return ShowPlayerDialogEx(playerid,14010,DIALOG_STYLE_LIST,"Замена авто",strs,"Купить","Отмена");
		    }
			new h = GetPVarInt(playerid,"chosencar_s");
			//if(h == -1) h = 0;
			if(PTEMP[playerid][pBank] < ShopCar[GetPVarInt(playerid, "SelectAvto")][1]) return SCM(playerid,COLOR_GREY," На вашем банковском счету недостаточно денег!");
			CarInfo[playerid][carModel][h] = ShopCar[GetPVarInt(playerid, "SelectAvto")][0];
			CarInfo[playerid][carColor_one][h] = GetPVarInt(playerid,"BuyColor");
			CarInfo[playerid][carColor_two][h] = GetPVarInt(playerid,"BuyColor1");
			if(booston == 0) PTEMP[playerid][pBank] -= ShopCar[GetPVarInt(playerid, "SelectAvto")][1];
			if(booston == 1) PTEMP[playerid][pBank] -= ShopCar[GetPVarInt(playerid, "SelectAvto")][1]-ShopCar[GetPVarInt(playerid, "SelectAvto")][1]*20/100;
			CarInfo[playerid][carPercent][h] = 100;
			CarInfo[playerid][carFuel][h] = 200;
			ExitCar(playerid);
			AutoSaloon[playerid] = false;
			printf("Игрок %s купил автомобиль [ID: %i]", Name(playerid), CarInfo[playerid][carModel][h]);
			//SCM(playerid,COLOR_GREEN, " Вы приобрели автомобиль. Вам нужно подождать 24 часа/либо (( /fixcar )) заплатить");
			if(GetPVarInt(playerid, "chosencar") == -1) SetPVarInt(playerid, "chosencar", h);
	    }
	case 14011:
		{
			if(response) ExitCar(playerid);
		}
	case 11228:
		{
			if(!response) return true;
			PlayerPlaySound(playerid, 4201, 0.0, 0.0, 0);
			ShowPlayerDialogEx(playerid,11229,DIALOG_STYLE_MSGBOX,"Задание","Привет"
			,"Готово","");
			SCM(playerid,COLOR_YELLOW," Используйте команду /quest, чтобы повторно посмотреть текущий квест");
			SCM(playerid,0x30a0a7aa," Задание выполнено");
			PTEMP[playerid][pQuestL] = 1;
			PTEMP[playerid][pQuest] = 1;
			PTEMP[playerid][pQuestP] = 0;
			PTEMP[playerid][pQuestF] = 5;
			PTEMP[playerid][pQuestPF] = 15;
			PTEMP[playerid][pQuestShow] = 1;
		}
	case 1426:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					if(PTEMP[playerid][pDrugs] < 1) return SCM(playerid,COLOR_GREY," У вас нет наркотиков!");
					if(SLOTVIBROS >= 900) return SCM(playerid,COLOR_GREY, " В данный момент нельзя выбросить что либо");
					new Float:Xw,Float:Yw,Float:Zw;
					VibrosInfo[SLOTVIBROS][vModel] = 1;
					VibrosInfo[SLOTVIBROS][vTime] = GetTickCount();
					GetPlayerPos(playerid,Xw,Yw,Zw);
					VibrosInfo[SLOTVIBROS][vX] = Xw;
					VibrosInfo[SLOTVIBROS][vY] = Yw;
					VibrosInfo[SLOTVIBROS][vZ] = Zw-0.9;
					VibrosInfo[SLOTVIBROS][vPodnyat] = CreateDynamic3DTextLabel("Наркотики\nПоднять: {ffffff}/pick", COLOR_GREEN, VibrosInfo[SLOTVIBROS][vX], VibrosInfo[SLOTVIBROS][vY], VibrosInfo[SLOTVIBROS][vZ], 10.0);
					VibrosInfo[SLOTVIBROS][vKol] = PTEMP[playerid][pDrugs];
					VibrosInfo[SLOTVIBROS][vObject] = CreateObject(1485,VibrosInfo[SLOTVIBROS][vX],VibrosInfo[SLOTVIBROS][vY],VibrosInfo[SLOTVIBROS][vZ],0.00,0.00,0.00);
					SCM(playerid,COLOR_GREY," Вы выбросили наркотики на землю!");
					PTEMP[playerid][pDrugs] = 0;
					SLOTVIBROS++;
				}
			case 1:
				{
					if(PTEMP[playerid][pMats] < 1) return SCM(playerid,COLOR_GREY," У вас нет материалов!");
					if(SLOTVIBROS >= 900) return SCM(playerid,COLOR_GREY," В данный момент нельзя выбросить что либо");
					new Float:Xw,Float:Yw,Float:Zw;
					VibrosInfo[SLOTVIBROS][vModel] = 2;
					VibrosInfo[SLOTVIBROS][vTime] = GetTickCount();
					GetPlayerPos(playerid,Xw,Yw,Zw);
					VibrosInfo[SLOTVIBROS][vX] = Xw;
					VibrosInfo[SLOTVIBROS][vY] = Yw;
					VibrosInfo[SLOTVIBROS][vZ] = Zw-0.9;
					VibrosInfo[SLOTVIBROS][vPodnyat] = CreateDynamic3DTextLabel("Материалы\nПоднять: {ffffff}/pick", COLOR_GREEN, VibrosInfo[SLOTVIBROS][vX], VibrosInfo[SLOTVIBROS][vY], VibrosInfo[SLOTVIBROS][vZ], 10.0);
					VibrosInfo[SLOTVIBROS][vKol] = PTEMP[playerid][pMats];
					VibrosInfo[SLOTVIBROS][vObject] = CreateObject(1210,VibrosInfo[SLOTVIBROS][vX],VibrosInfo[SLOTVIBROS][vY],VibrosInfo[SLOTVIBROS][vZ],90.00,0.00,0.00);
					SCM(playerid,COLOR_GREY," Вы выбросили материалы на землю!");
					PTEMP[playerid][pMats] = 0;
					SLOTVIBROS++;
				}
			}
		}
	case 1343:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					switch(PTEMP[playerid][pQuestL])
					{
					case 0: SCM(playerid,COLOR_GREY," Сюжетная линия гость уже пройдена");
					case 1:
						{
							if(PTEMP[playerid][pQuest] == 1) {ShowPlayerDialogEx(playerid,11229,DIALOG_STYLE_MSGBOX,"Задание","Привет"
								,"Готово",""); }
							else if(PTEMP[playerid][pQuest] == 2) {	ShowPlayerDialogEx(playerid,11230,DIALOG_STYLE_MSGBOX,"Задание","Это снова Джанк,вижу тебе нужны права.\nУ меня есть знакомые в Автошколе,они помогут тебе сдать совершенно бесплатно.\nЧтобы добраться до Автошколы,воспользуйся Автобусом или Такси.\n{DDCD70}Задача: Пройдите автосдачу на права(Не покупкая права у инструктора!)\n{17B757}Награда: Бесплатная сдача на права"
								,"Готово",""); }
							else if(PTEMP[playerid][pQuest] == 3) {	ShowPlayerDialogEx(playerid,13372,DIALOG_STYLE_MSGBOX,"Задание","Тут неподалёку есть ферма,где можно неплохо заработать.\nМожешь использовать gps или найти таксиста и попросить его отвезти тебя.\nЕсли ты сможешь за раз собрать 30 кустов урожая,то я поделюсь с тобой своей прибылью\n{DDCD70}Задача: Собрать 30 единиц урожая\n{17B757}Награда: 2000 вирт"
								,"Готово",""); }
							else if(PTEMP[playerid][pQuest] == 4) {	ShowPlayerDialogEx(playerid,13374,DIALOG_STYLE_MSGBOX,"Задание","Теперь у тебя есть права и деньги.Пора бы приодеться\nВ каждом городе есть магазин одежды.Доедь до него,и купи что-нибудь приличное.\nИ не забывай использовать gps\n{DDCD70}Задача: Купить любой скин\n{17B757}Награда: 1000 вирт"
								,"Готово",""); }
							else if(PTEMP[playerid][pQuest] == 5) {	ShowPlayerDialogEx(playerid,13375,DIALOG_STYLE_MSGBOX,"Задание","Теперь ты можешь поехать в Мэрию и получить там паспорт\n{DDCD70}Задача: Войти в мэрию\n{17B757}Награда: 2 уровень,4000 вирт"
								,"Готово",""); }
						}
					}
				}
			case 1: SCM(playerid,COLOR_GREY," Временно не доступно");
			case 2: QuestStats(playerid,playerid);
			case 3: ShowPlayerDialogEx(playerid, 1443, DIALOG_STYLE_INPUT, "Ввод ид","Введите ID игрока,\nчью статистику вы хотите посмотреть.\nИгрок должен быть онлайн!","Далее","Назад");
			}
		}
	case 1443:
		{
			if(!response) return ShowPlayerDialogEx(playerid,1343,DIALOG_STYLE_LIST, "Управление квестами","Текущий квест\nВыбор сюжетной линии [Временно не работает]\nСтатистика\nЧужая статистика", "Далее", "Выход");
			if(IsPlayerConnected(strval(inputtext))) { QuestStats(playerid,strval(inputtext));}
			else SCM(playerid,COLOR_GREY," Игрок не найден"),ShowPlayerDialogEx(playerid, 1443, DIALOG_STYLE_INPUT, "Ввод ид","Введите ID игрока,\nчью статистику вы хотите посмотреть.\nИгрок должен быть онлайн!","Далее","Назад");
		}
	case 1342:
		{
			if(!response) return true;
			//ShowPlayerDialogEx(playerid,1342,DIALOG_STYLE_LIST, "Рыбалка","Начать / Закончить рыбалку\nНакопать червей\nПриготовить рыбу\nСъесть рыбу\nИнформация\nПомощь", "Выбор", "Выход");
			switch(listitem)
			{
			case 0:
				{
					if(!IsAtFishPlace(playerid)) return SCM(playerid,0x81DA99AA," Вы должны находиться возле причала");
					if(!GetPVarInt(playerid,"fish_began"))
					{
						if(!GetPVarInt(playerid,"fish_rod")) return SCM(playerid,0x81DA99AA," У вас нет удочки");
						if(!GetPVarInt(playerid,"fish_gear")) return SCM(playerid,0x81DA99AA," У вас нет снастей");
						if(!GetPVarInt(playerid,"fish_worms")) return SCM(playerid,0x81DA99AA," У вас нет червей");
						UpdateFish(playerid);
						PlayerTextDrawShow(playerid,FishingText[playerid]);
						SetPlayerAttachedObject(playerid, 0,18632,6,0.079376,0.037070,0.007706,181.482910,0.000000,0.000000,1.000000,1.000000,1.000000);
						SetPVarInt(playerid,"fish_began",1);
						DeletePVar(playerid,"fish_time");
						DeletePVar(playerid,"fish_ready");
					}
					else
					{
						//if(ribachit[playerid] == 1) return SCM(playerid,0x81DA99AA,"В данный момент нельзя завершить рыбалку");
						RemovePlayerAttachedObject(playerid,0);
						DeletePVar(playerid,"fish_began");
						DeletePVar(playerid,"fish_ready");
						DeletePVar(playerid,"fish_time");
						ClearAnimations(playerid);
						PlayerTextDrawHide(playerid,FishingText[playerid]);
					}
				}
			case 1:
				{
					if(!IsAtWormPlace(playerid)) return SCM(playerid,0x81DA99AA," Неудачное место для поиска");
					if(random(2) == 1) ClearAnimations(playerid),ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 6.1, 0, 0, 0, 0, 0,1),  SetPVarInt(playerid,"fish_worms",GetPVarInt(playerid,"fish_worms")+10), SCM(playerid,0x81DA99AA," Вы нашли 10 червей!"), ShowPlayerDialogEx(playerid,1342,DIALOG_STYLE_LIST, "Рыбалка","Начать / Закончить рыбалку\nНакопать червей\nПриготовить рыбу\nСъесть рыбу\nПродать рыбу\nИнформация\nПомощь", "Выбор", "Выход");
					else return ClearAnimations(playerid),ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 6.1, 0, 0, 0, 0, 0,1), SCM(playerid,0x81DA99AA," Вы ничего не нашли"), ShowPlayerDialogEx(playerid,1342,DIALOG_STYLE_LIST, "Рыбалка","Начать / Закончить рыбалку\nНакопать червей\nПриготовить рыбу\nСъесть рыбу\nПродать рыбу\nИнформация\nПомощь", "Выбор", "Выход");
				}
			case 2:
				{
					if(PTEMP[playerid][pFishesPach] >= 25) return SCM(playerid,0x81DA99AA," У вас 25 / 25 пачек рыбы");
					if(PTEMP[playerid][pFishes] < 20) return SCM(playerid,0x81DA99AA," Для создания требуется 20 кг. рыбы");
					PTEMP[playerid][pFishesPach]++;
					PTEMP[playerid][pFishes]-=float(20);
					SendMes(playerid,0x81DA99AA," Вы приготовили рыбу. У вас %i / 25 пачек.",PTEMP[playerid][pFishesPach]);
					ShowPlayerDialogEx(playerid,1342,DIALOG_STYLE_LIST, "Рыбалка","Начать / Закончить рыбалку\nНакопать червей\nПриготовить рыбу\nСъесть рыбу\nПродать рыбу\nИнформация\nПомощь", "Выбор", "Выход");
				}
			case 3:
				{
					if(PTEMP[playerid][pFishesPach] < 1) return SCM(playerid,0x81DA99AA," Недостаточно рыбы");
					PTEMP[playerid][pFishesPach]--;
					PTEMP[playerid][pSatiety]=100;
					SendMes(playerid,0x81DA99AA," «Сытость» пополнена до 100. У вас %i / 25 пачек.",PTEMP[playerid][pFishesPach]);
					ShowPlayerDialogEx(playerid,1342,DIALOG_STYLE_LIST, "Рыбалка","Начать / Закончить рыбалку\nНакопать червей\nПриготовить рыбу\nСъесть рыбу\nПродать рыбу\nИнформация\nПомощь", "Выбор", "Выход");
				}
			case 4:
				{
					for(new i = 1; i <= TotalBizz; i++)
					{
						if(PTEMP[playerid][pFishes] < 2) return SCM(playerid,0x81DA99AA," Недостаточно рыбы");
						if (PlayerToPoint(10, playerid,BizzInfo[i][bBarX], BizzInfo[i][bBarY], BizzInfo[i][bBarZ]) && BizzInfo[i][bType] == 2 && GetPlayerVirtualWorld(playerid) == BizzInfo[i][bVirtualWorld])
						{
							PTEMP[playerid][pCash] +=floatround(PTEMP[playerid][pFishes])*5;
							if(BizzInfo[i][bProducts]+floatround(PTEMP[playerid][pFishes]) < 2000) BizzInfo[i][bProducts]+=floatround(PTEMP[playerid][pFishes]);
							else BizzInfo[i][bProducts]=2000;
							format(YCMDstr,sizeof(YCMDstr), " Вы продали %.2f кг. рыбы. Выручка: %i вирт",PTEMP[playerid][pFishes],floatround(PTEMP[playerid][pFishes]));
							SCM(playerid,0x81DA99AA,YCMDstr);
							PTEMP[playerid][pFishes] = 0;
							ShowPlayerDialogEx(playerid,1342,DIALOG_STYLE_LIST, "Рыбалка","Начать / Закончить рыбалку\nНакопать червей\nПриготовить рыбу\nСъесть рыбу\nПродать рыбу\nИнформация\nПомощь", "Выбор", "Выход");
							break;
						}
					}
				}
			case 5:
				{
					format(string,500,"============== Готовность ==============\n\
									\nУдочка:\t- %s\
									\nСнастей:\t- %i шт.\
									\nЧервей:\t- %i шт.\n\n\
									============== Информация ==============\n\n\
									Пачек рыбы приготовлено:\t- %i шт.\
									\nРыбы поймано:\t- %.2f кг.\
									\n\n============== Сонар ==============\n\n\
									Сонар:\t- %s",(!GetPVarInt(playerid,"fish_rod"))?("Нету") : ("Есть"),GetPVarInt(playerid,"fish_gear"),GetPVarInt(playerid,"fish_worms"),
					PTEMP[playerid][pFishesPach],PTEMP[playerid][pFishes],(!GetPVarInt(playerid,"fish_sonar"))?("Нету") : ("Есть"));
					ShowPlayerDialogEx(playerid,10349,DIALOG_STYLE_MSGBOX, "Информация",string, "Скрыть", "");
				}
			case 6: ShowPlayerDialogEx(playerid,10349,DIALOG_STYLE_MSGBOX, "Помощь по рыбалке","ШАГ 1: Купите удочку и всё необходимое в магазине 24/7\nШАГ 2: Ищите рыбные места для рыбалки\nШАГ 3: Оснастите удочку и наживите червя\nШАГ 4: Подсекайте рыбу клавишей L.ALT", "Скрыть", "");
			}
		}
	case 7925:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					if(PTEMP[playerid][pCash] < 500) return SCM(playerid,-1," Недостаточно денег");
					ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена");
					return 1;
				}
			case 1:
				{
					if(PTEMP[playerid][pCash] < 300) return SCM(playerid,-1," Недостаточно денег");
					ShowPlayerDialogEx(playerid, 7928, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена");
					return 1;
				}
			case 2:
				{
					if(PTEMP[playerid][pCash] < 750) return SCM(playerid,-1," Недостаточно денег");
					ShowPlayerDialogEx(playerid, 7929, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена");
					return 1;
				}
			case 3:
				{
					if(PTEMP[playerid][pCash] < 500) return SCM(playerid,-1," Недостаточно денег");
					ShowPlayerDialogEx(playerid, 7930, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена");
					return 1;
				}
			case 4:
				{
					if(PTEMP[playerid][pCash] < 250) return SCM(playerid,-1," Недостаточно денег");
					ShowPlayerDialogEx(playerid, 7931, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена");
					return 1;
				}
			case 5:
				{
					if(PTEMP[playerid][pCash] < 500) return SCM(playerid,-1," Недостаточно денег");
					ShowPlayerDialogEx(playerid, 7932, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена");
					return 1;
				}
			case 6:
				{
					if(PTEMP[playerid][pCash] < 500) return SCM(playerid,-1," Недостаточно денег");
					ShowPlayerDialogEx(playerid, 7933, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена");
					return 1;
				}
			case 7:
				{
					if(PTEMP[playerid][pCash] < 1000) return SCM(playerid,-1," Недостаточно денег");
					ShowPlayerDialogEx(playerid, 7934, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена");
					return 1;
				}
			case 8:
				{
					if(PTEMP[playerid][pCash] < 1200) return SCM(playerid,-1," Недостаточно денег");
					PTEMP[playerid][pCash]-= 1200; // Отнимаем деньги
					switch(booston)
					{
					case 0:GiveWeapon(playerid,2,1); // Выдаём патроны/оружие
					case 1:GiveWeapon(playerid,2,1*3); // Выдаём патроны/оружие
					}
					format(string,64," Спасибо за покупку. $%i",1*1200);
					SCM(playerid,0x29FF00AA,string);
					ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
					return 1;
				}
			case 9:
				{
					if(PTEMP[playerid][pCash] < 1000) return SCM(playerid,-1," Недостаточно денег");
					PTEMP[playerid][pCash]-= 1000; // Отнимаем деньги
					switch(booston)
					{
					case 0:GiveWeapon(playerid,5,1); // Выдаём патроны/оружие
					case 1:GiveWeapon(playerid,5,1*3); // Выдаём патроны/оружие
					}
					format(string,64," Спасибо за покупку. $%i",1*1000); // Форматируем сообщение
					SCM(playerid,0x29FF00AA,string);
					ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
					return 1;
				}
			case 10:
				{
					if(PTEMP[playerid][pCash] < 1200) return SCM(playerid,-1," Недостаточно денег");
					PTEMP[playerid][pCash]-= 1200; // Отнимаем деньги
					switch(booston)
					{
					case 0:GiveWeapon(playerid,6,1); // Выдаём патроны/оружие
					case 1:GiveWeapon(playerid,6,1*3); // Выдаём патроны/оружие
					}
					format(string,64," Спасибо за покупку. $%i",1*1200); // Форматируем сообщение
					SCM(playerid,0x29FF00AA,string);
					ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
					return 1;
				}
			case 11:
				{
					if(PTEMP[playerid][pCash] < 1300) return SCM(playerid,-1," Недостаточно денег");
					PTEMP[playerid][pCash]-= 1300; // Отнимаем деньги
					switch(booston)
					{
					case 0:GiveWeapon(playerid,7,1); // Выдаём патроны/оружие
					case 1:GiveWeapon(playerid,7,1*3); // Выдаём патроны/оружие
					}
					format(string,64," Спасибо за покупку. $%i",1*1300); // Форматируем сообщение
					SCM(playerid,0x29FF00AA,string);
					ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
					return 1;
				}
			case 12:
				{
					if(PTEMP[playerid][pCash] < 2500) return SCM(playerid,-1," Недостаточно денег");
					PTEMP[playerid][pCash]-= 2500; // Отнимаем деньги
					switch(booston)
					{
					case 0:GiveWeapon(playerid,8,1); // Выдаём патроны/оружие
					case 1:GiveWeapon(playerid,8,1*3); // Выдаём патроны/оружие
					}
					format(string,64,"Спасибо за покупку. $%i",1*2500); // Форматируем сообщение
					SCM(playerid,0x29FF00AA,string);
					ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
					return 1;
				}
			case 13:
				{
					if(PTEMP[playerid][pCash] < 1500) return SCM(playerid,-1," Недостаточно денег");
					PTEMP[playerid][pCash]-= 1500; // Отнимаем деньги
					switch(booston)
					{
					case 0:GiveWeapon(playerid,10,1); // Выдаём патроны/оружие
					case 1:GiveWeapon(playerid,10,1*3); // Выдаём патроны/оружие
					}
					format(string,64," Спасибо за покупку. $%i",1*1500); // Форматируем сообщение
					SCM(playerid,0x29FF00AA,string);
					ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
					return 1;
				}
			case 14:
				{
					if(PTEMP[playerid][pCash] < 3000) return SCM(playerid,-1," Недостаточно денег");
					PTEMP[playerid][pCash]-= 3000; // Отнимаем деньги
					switch(booston)
					{
					case 0:GiveWeapon(playerid,14,1); // Выдаём патроны/оружие
					case 1:GiveWeapon(playerid,14,1*3); // Выдаём патроны/оружие
					}
					format(string,64," Спасибо за покупку. $%i",1*3000); // Форматируем сообщение
					SCM(playerid,0x29FF00AA,string);
					ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
					return 1;
				}
			case 15:
				{
					if(PTEMP[playerid][pCash] < 1300) return SCM(playerid,-1,"Недостаточно денег");
					PTEMP[playerid][pCash]-= 1300; // Отнимаем деньги
					switch(booston)
					{
					case 0:GiveWeapon(playerid,15,1); // Выдаём патроны/оружие
					case 1:GiveWeapon(playerid,15,1*3); // Выдаём патроны/оружие
					}
					format(string,64," Спасибо за покупку. $%i",1*1300); // Форматируем сообщение
					SCM(playerid,0x29FF00AA,string);
					ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
					return 1;
				}
			case 16:
				{
					if(PTEMP[playerid][pCash] < 1000) return SCM(playerid,-1," Недостаточно денег");
					PTEMP[playerid][pCash]-= 1000; // Отнимаем деньги
					switch(booston)
					{
					case 0:GiveWeapon(playerid,46,1); // Выдаём патроны/оружие
					case 1:GiveWeapon(playerid,46,1*3); // Выдаём патроны/оружие
					}
					format(string,64," Спасибо за покупку. $%i",1*1000); // Форматируем сообщение
					SCM(playerid,0x29FF00AA,string);
					ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
					return 1;
				}
			}
		}
	case 7927:
		{
			if(response) // Если игрок нажал купить
			{
				new gungins = strval(inputtext);
				if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена"); // Если игрок оставил пустое окно выводим его заного
				if(PTEMP[playerid][pCash] < strval(inputtext)*500) return SCM(playerid,-1," Недостаточно денег"); // Проверка хватает ли денег у игрока
				if(gungins > 999 || gungins < 0){ ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Количество патронов не должно быть\nменьше 1 или более 999", "Купить", "отмена");return 1;}
				PTEMP[playerid][pCash]-=strval(inputtext)*500; // Отнимаем деньги
				switch(booston)
				{
				case 0:GiveWeapon(playerid,24,gungins); // Выдаём патроны/оружие
				case 1:GiveWeapon(playerid,24,gungins*3); // Выдаём патроны/оружие
				}
				format(string,64," Спасибо за покупку. $%i",strval(inputtext)*500); // Форматируем сообщение
				SCM(playerid,0x29FF00AA,string);
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
				return 1; // Завершаем действие
			}
			else // Если отмена
			{
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
			}
		}
	case 7928:
		{
			if(response) // Если игрок нажал купить
			{
				new gungins = strval(inputtext);
				if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 7928, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена"); // Если игрок оставил пустое окно выводим его заного
				if(PTEMP[playerid][pCash] < strval(inputtext)*300) return SCM(playerid,-1," Недостаточно денег"); // Проверка хватает ли денег у игрока
				if(gungins > 999 || gungins < 0){ ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Количество патронов не должно быть\nменьше 1 или более 999", "Купить", "отмена");return 1;}
				PTEMP[playerid][pCash]-= strval(inputtext)*300; // Отнимаем деньги
				switch(booston)
				{
				case 0:GiveWeapon(playerid,23,gungins); // Выдаём патроны/оружие
				case 1:GiveWeapon(playerid,23,gungins*3); // Выдаём патроны/оружие
				}
				format(string,64," Спасибо за покупку. $%i",strval(inputtext)*300); // Форматируем сообщение
				SCM(playerid,0x29FF00AA,string);
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
				return 1; // Завершаем действие
			}
			else // Если отмена
			{
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
			}
		}
	case 7929:
		{
			if(response) // Если игрок нажал купить
			{
				new gungins = strval(inputtext);
				if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 7929, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена"); // Если игрок оставил пустое окно выводим его заного
				if(PTEMP[playerid][pCash] < strval(inputtext)*750) return SCM(playerid,-1," Недостаточно денег"); // Проверка хватает ли денег у игрока
				if(gungins > 999 || gungins < 0){ ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Количество патронов не должно быть\nменьше 1 или более 999", "Купить", "отмена");return 1;}
				PTEMP[playerid][pCash]-=strval(inputtext)*750; // Отнимаем деньги
				switch(booston)
				{
				case 0:GiveWeapon(playerid,33,gungins); // Выдаём патроны/оружие
				case 1:GiveWeapon(playerid,33,gungins*3); // Выдаём патроны/оружие
				}
				format(string,64," Спасибо за покупку. $%i",strval(inputtext)*750); // Форматируем сообщение
				SCM(playerid,0x29FF00AA,string);
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
				return 1; // Завершаем действие
			}
			else // Если отмена
			{
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
			}
		}
	case 7930:
		{
			if(response) // Если игрок нажал купить
			{
				new gungins = strval(inputtext);
				if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 7930, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена"); // Если игрок оставил пустое окно выводим его заного
				if(PTEMP[playerid][pCash] < strval(inputtext)*500) return SCM(playerid,-1," Недостаточно денег"); // Проверка хватает ли денег у игрока
				if(gungins > 999 || gungins < 0){ ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Количество патронов не должно быть\nменьше 1 или более 999", "Купить", "отмена");return 1;}
				PTEMP[playerid][pCash]-=strval(inputtext)*500; // Отнимаем деньги
				switch(booston)
				{
				case 0:GiveWeapon(playerid,25,gungins); // Выдаём патроны/оружие
				case 1:GiveWeapon(playerid,25,gungins*3); // Выдаём патроны/оружие
				}
				format(string,64," Спасибо за покупку. $%i",strval(inputtext)*500); // Форматируем сообщение
				SCM(playerid,0x29FF00AA,string);
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
				return 1; // Завершаем действие
			}
			else // Если отмена
			{
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
			}
		}
	case 7931:
		{
			if(response) // Если игрок нажал купить
			{
				new gungins = strval(inputtext);
				if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 7931, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена"); // Если игрок оставил пустое окно выводим его заного
				if(PTEMP[playerid][pCash] < strval(inputtext)*250) return SCM(playerid,-1," Недостаточно денег"); // Проверка хватает ли денег у игрока
				if(gungins > 999 || gungins < 0){ ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Количество патронов не должно быть\nменьше 1 или более 999", "Купить", "отмена");return 1;}
				PTEMP[playerid][pCash]-=strval(inputtext)*250; // Отнимаем деньги
				switch(booston)
				{
				case 0:GiveWeapon(playerid,29,gungins); // Выдаём патроны/оружие
				case 1:GiveWeapon(playerid,29,gungins*3); // Выдаём патроны/оружие
				}
				format(string,64," Спасибо за покупку. $%i",strval(inputtext)*250); // Форматируем сообщение
				SCM(playerid,0x29FF00AA,string);
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
				return 1; // Завершаем действие
			}
			else // Если отмена
			{
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
			}
		}
	case 7932:
		{
			if(response) // Если игрок нажал купить
			{
				new gungins = strval(inputtext);
				if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 7932, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена"); // Если игрок оставил пустое окно выводим его заного
				if(PTEMP[playerid][pCash] < strval(inputtext)*500) return SCM(playerid,-1," Недостаточно денег"); // Проверка хватает ли денег у игрока
				if(gungins > 999 || gungins < 0){ ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Количество патронов не должно быть\nменьше 1 или более 999", "Купить", "отмена");return 1;}
				PTEMP[playerid][pCash]-=strval(inputtext)*500; // Отнимаем деньги
				switch(booston)
				{
				case 0:GiveWeapon(playerid,30,gungins); // Выдаём патроны/оружие
				case 1:GiveWeapon(playerid,30,gungins*3); // Выдаём патроны/оружие
				}
				format(string,64," Спасибо за покупку. $%i",strval(inputtext)*500); // Форматируем сообщение
				SCM(playerid,0x29FF00AA,string);
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
				return 1; // Завершаем действие
			}
			else // Если отмена
			{
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
			}
		}
	case 7933:
		{
			if(response) // Если игрок нажал купить
			{
				new gungins = strval(inputtext);
				if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 7933, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена"); // Если игрок оставил пустое окно выводим его заного
				if(PTEMP[playerid][pCash] < strval(inputtext)*500) return SCM(playerid,-1," Недостаточно денег"); // Проверка хватает ли денег у игрока
				if(gungins > 999 || gungins < 0){ ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Количество патронов не должно быть\nменьше 1 или более 999", "Купить", "отмена");return 1;}
				PTEMP[playerid][pCash]-=strval(inputtext)*500; // Отнимаем деньги
				switch(booston)
				{
				case 0:GiveWeapon(playerid,31,gungins); // Выдаём патроны/оружие
				case 1:GiveWeapon(playerid,31,gungins*3); // Выдаём патроны/оружие
				}
				format(string,64," Спасибо за покупку. $%i",strval(inputtext)*500); // Форматируем сообщение
				SCM(playerid,0x29FF00AA,string);
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
				return 1; // Завершаем действие
			}
			else // Если отмена
			{
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
			}
		}
	case 7934:
		{
			if(response) // Если игрок нажал купить
			{
				new gungins = strval(inputtext);
				if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 7934, 1, "Патроны", "Введите количество патронов\nкоторые будут в комплекте с оружием.", "Купить", "отмена"); // Если игрок оставил пустое окно выводим его заного
				if(PTEMP[playerid][pCash] < strval(inputtext)*1000) return SCM(playerid,-1," Недостаточно денег"); // Проверка хватает ли денег у игрока
				if(gungins > 999 || gungins < 0){ ShowPlayerDialogEx(playerid, 7927, 1, "Патроны", "Количество патронов не должно быть\nменьше 1 или более 999", "Купить", "отмена");return 1;}
				PTEMP[playerid][pCash]-=strval(inputtext)*1000; // Отнимаем деньги
				switch(booston)
				{
				case 0:GiveWeapon(playerid,17,gungins); // Выдаём патроны/оружие
				case 1:GiveWeapon(playerid,17,gungins*3); // Выдаём патроны/оружие
				}
				format(string,64," Спасибо за покупку. $%i",strval(inputtext)*1000); // Форматируем сообщение
				SCM(playerid,0x29FF00AA,string);
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
				return 1; // Завершаем действие
			}
			else // Если отмена
			{
				ShowPlayerDialogEx(playerid, 7925, 2, "Доступное оружие", "Desert Eagle\t[$500]\nSilenced 9mm\t[$300]\nCountry Rifle\t[$750]\nShotgun\t[$500]\nSMG\t\t[$250]\nAK47\t\t[$500]\nM4\t\t[$500]\nTear Gas\t[$1000]\n\n\nGolf Club\t[$1200]\nBaseboll Bat\t[$1000]\nShovel\t\t[$1200]\nPool Cue\t[$1300]\nKatana\t\t[$2500]\nPurle Dildo\t[$1500]\nFlowers\t[$3000]\nCane\t\t[$1300]\nParachute\t[$1000]", "Далее", "Выйти");
			}
		}
	case 1723:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					if(PTEMP[playerid][pCarLic] || PTEMP[playerid][pCash] < 15000) return true;
					PTEMP[playerid][pCash]-=15000;
					PTEMP[playerid][pCarLic] = 1;
					SCM(playerid,-1," Вы приобрели лицензию!");
				}
			case 1:
				{
					if(PTEMP[playerid][pFlyLic] || PTEMP[playerid][pCash] < 20000) return true;
					PTEMP[playerid][pCash]-=20000;
					PTEMP[playerid][pFlyLic] = 1;
					SCM(playerid,-1," Вы приобрели лицензию!");
				}
			case 2:
				{
					if(PTEMP[playerid][pBoatLic] || PTEMP[playerid][pCash] < 15000) return true;
					PTEMP[playerid][pCash]-=15000;
					PTEMP[playerid][pBoatLic] = 1;
					SCM(playerid,-1," Вы приобрели лицензию!");
				}
			case 3:
				{
					if(PTEMP[playerid][pFishLic] || PTEMP[playerid][pCash] < 10000) return true;
					PTEMP[playerid][pCash]-=10000;
					PTEMP[playerid][pFishLic] = 1;
					SCM(playerid,-1," Вы приобрели лицензию!");
				}
			case 4:
				{
					if(PTEMP[playerid][pGunLic] || PTEMP[playerid][pCash] < 100000) return true;
					PTEMP[playerid][pCash]-=100000;
					PTEMP[playerid][pGunLic] = 1;
					SCM(playerid,-1," Вы приобрели лицензию!");
				}
			}
			return true;
		}
	case 1846:
		{
			if(!response) return true;
			new i = PTEMP[playerid][pPBizzKey];
			switch(listitem)
			{
			case 0: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/sellbiz");
			case 1: ShowPlayerDialogEx(playerid,1522,DIALOG_STYLE_LIST,"Пополнить счет","[0] Электроэнергия\n[1] Баланс банка бизнеса","Выбрать","Назад");
			case 2: ShowPlayerDialogEx(playerid, 1525, 1, "Снять деньги", "Введите кол-во вирт", "Принять", "Отмена");
			case 3: SendMes(playerid,-1," Баланс бизнеса: %i вирт",BizzInfo[i][bTill]),SendMes(playerid,-1," Баланс 'LandTax': %i вирт",BizzInfo[i][bLandTax]),ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
			case 4: if(BizzInfo[i][bType] == 1 || BizzInfo[i][bType] == 3) ShowPlayerDialogEx(playerid, 1526, 1, "Ввод параметра", "Введите цену за товар", "Принять", "Отмена");
			case 5: if(BizzInfo[i][bType] != 4 && BizzInfo[i][bID] != 47 && BizzInfo[i][bID] != 48) ShowPlayerDialogEx(playerid, 1527, 1, "Ввод параметра", "Введите цену за товар вход", "Принять", "Отмена"); else return SCM(playerid,COLOR_GREY," Вы не владеете заправкой / Казино-Баром");
			case 6: PrintBizInfo(playerid, i);
			}
		}
	case 1522:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
			switch(listitem)
			{
			case 0: ShowPlayerDialogEx(playerid, 1523, 1, "Ввод параметра", "Введите кол-во вирт", "Принять", "Отмена");
			case 1: ShowPlayerDialogEx(playerid, 1524, 1, "Ввод параметра", "Введите кол-во вирт", "Принять", "Отмена");
			}
		}
	case 1523:
		{
			if(!response) return ShowPlayerDialogEx(playerid,1522,DIALOG_STYLE_INPUT,"Пополнить счет","[0] Электроэнергия\n[1] Баланс банка бизнеса","Выбрать","Назад");
			new price, bouse = PTEMP[playerid][pPBizzKey];
			if(sscanf(inputtext, "i",price)) ShowPlayerDialogEx(playerid, 1523, 1, "Ввод параметра", "Введите кол-во вирт", "Принять", "Отмена");
			if(price < 1 || price > (BizzLandTax[bouse]*720)-BizzInfo[bouse][bLandTax])  return SendMes(playerid, COLOR_GRAD2, " Неверная сумма, максимально допустимая %i вирт", (BizzLandTax[bouse]*720)-BizzInfo[bouse][bLandTax]);
			if(PTEMP[playerid][pBank] < price) return SCM(playerid, COLOR_GREY, " На банковском счету недостаточно средств");
			PTEMP[playerid][pBank] -= price;
			BizzInfo[bouse][bLandTax] += price,SendMes(playerid,0x6495EDFF," Вы пополнили счет 'LandTax' на %i вирт",price);
			return ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
		}
	case 1524:
		{
			if(!response) return ShowPlayerDialogEx(playerid,1522,DIALOG_STYLE_INPUT,"Пополнить счет","[0] Электроэнергия\n[1] Баланс банка бизнеса","Выбрать","Назад");
			new price, bouse = PTEMP[playerid][pPBizzKey];
			if(sscanf(inputtext, "i",price)) ShowPlayerDialogEx(playerid, 1524, 1, "Ввод параметра", "Введите кол-во вирт", "Принять", "Отмена");
			if(price < 1 || price > 10000000)  return SendMes(playerid, COLOR_GRAD2, " Неверная сумма, максимально допустимая %i вирт", (10000000)-BizzInfo[bouse][bTill]);
			if(PTEMP[playerid][pBank] < price) return SCM(playerid, COLOR_GREY, " На банковском счету недостаточно средств");
			PTEMP[playerid][pBank] -= price;
			BizzInfo[bouse][bTill] += price, SendMes(playerid,0x6495EDFF," Вы перевели на счёт вашего бизнеса %i вирт",price);
			return ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
		}
	case 1525:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
			new price, bouse = PTEMP[playerid][pPBizzKey];
			if(sscanf(inputtext, "i",price)) ShowPlayerDialogEx(playerid, 1525, 1, "Ввод параметра", "Введите кол-во вирт", "Принять", "Отмена");
			if(BizzInfo[bouse][bTill] < price) return SCM(playerid, COLOR_GREY, " Недостаточно денег на балансе бизнеса");
			BizzInfo[bouse][bTill] -= price;
			PTEMP[playerid][pBank] += price, SendMes(playerid,0x6495EDFF," Вы сняли со счета вашего бизнеса %i вирт",price);
			return ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
		}
	case 1526:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
			new price, bouse = PTEMP[playerid][pPBizzKey];
			if(sscanf(inputtext, "i",price)) ShowPlayerDialogEx(playerid, 1526, 1, "Ввод параметра", "Введите цену за товар", "Принять", "Отмена");
			if(price < 100 || price > 500) return SCM(playerid,COLOR_GREY," Нельзя меньше 100 и больше 500 вирт"),ShowPlayerDialogEx(playerid, 1526, 1, "Ввод параметра", "Введите цену за товар", "Принять", "Отмена");
			BizzInfo[bouse][bPrice] = price;
			SendMes(playerid,-1," Цена на товары теперь от %d вирт",price);
			return ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
		}
	case 1527:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
			new price, bouse = PTEMP[playerid][pPBizzKey];
			if(sscanf(inputtext, "i",price)) ShowPlayerDialogEx(playerid, 1527, 1, "Ввод параметра", "Введите цену за вход", "Принять", "Отмена");
			if(price < 1 || price > 10000) return SCM(playerid,COLOR_GREY," Нельзя меньше 1 и больше 10 000 вирт"),ShowPlayerDialogEx(playerid, 1527, 1, "Ввод параметра", "Введите цену за вход", "Принять", "Отмена");
			BizzInfo[bouse][bEntranceCost] = price;
			SendMes(playerid,-1," Цена за вход теперь %d вирт",price);
			return ShowPlayerDialogEx(playerid, 1846, 2, "Бизнес", "[0] Продать бизнес\n[1] Пополнить счет\n[2] Снять деньги\n[3] Баланс\n[4] Цена за товар\n[5] Цена за вход\n[6] Информация", "Выбрать", "Отмена");
		}
	case 1054:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					new mes[512];
					new houseid = PTEMP[playerid][pPHouseKey];
					format(mes, sizeof(mes), "{758C9D}Материалы  {FFFFFF}%i/5000\n{758C9D}Наркотики  {FFFFFF}%i/1500\n{758C9D}Ключи от камеры  {FFFFFF}%i/50\n{758C9D}Готовая рыба  {FFFFFF}%i/250\n{758C9D}Silenced pistol  {FFFFFF}%i/500\n{758C9D}Desert Eagle  {FFFFFF}%i/450\n{758C9D}Shotgun  {FFFFFF}%i/450\n{758C9D}MP5  {FFFFFF}%i/1500\n{758C9D}AK47  {FFFFFF}%i/1500\n{758C9D}M4  {FFFFFF}%i/1500\n{758C9D}Rifle  {FFFFFF}%i/100",HouseInfo[houseid][hSafe][1],HouseInfo[houseid][hSafe][0],
					HouseInfo[houseid][hSafe][2],HouseInfo[houseid][hSafe][3],HouseInfo[houseid][hSafe][4],HouseInfo[houseid][hSafe][5],HouseInfo[houseid][hSafe][6],HouseInfo[houseid][hSafe][7],HouseInfo[houseid][hSafe][8],HouseInfo[houseid][hSafe][9],HouseInfo[houseid][hSafe][10]);
					ShowPlayerDialogEx(playerid,1053,DIALOG_STYLE_LIST,"Сейф",mes,"Выбрать","Назад");
				}
			case 1:
				{
					new mes2[512];
					new houseid = PTEMP[playerid][pPHouseKey];
					format(mes2, sizeof(mes2), "{758C9D}Материалы  {FFFFFF}%i/5000\n{758C9D}Наркотики  {FFFFFF}%i/1500\n{758C9D}Ключи от камеры  {FFFFFF}%i/50\n{758C9D}Готовая рыба  {FFFFFF}%i/250\n{758C9D}Silenced pistol  {FFFFFF}%i/500\n{758C9D}Desert Eagle  {FFFFFF}%i/450\n{758C9D}Shotgun  {FFFFFF}%i/450\n{758C9D}MP5  {FFFFFF}%i/1500\n{758C9D}AK47  {FFFFFF}%i/1500\n{758C9D}M4  {FFFFFF}%i/1500\n{758C9D}Rifle  {FFFFFF}%i/100",HouseInfo[houseid][hSafe][1],HouseInfo[houseid][hSafe][0],
					HouseInfo[houseid][hSafe][2],HouseInfo[houseid][hSafe][3],HouseInfo[houseid][hSafe][4],HouseInfo[houseid][hSafe][5],HouseInfo[houseid][hSafe][6],HouseInfo[houseid][hSafe][7],HouseInfo[houseid][hSafe][8],HouseInfo[houseid][hSafe][9],HouseInfo[houseid][hSafe][10]);
					ShowPlayerDialogEx(playerid,1052,DIALOG_STYLE_LIST,"Сейф",mes2,"Выбрать","Назад");
				}
			}
		}
	case 1052:
		{
			if(!response)return true;
			switch(listitem)
			{
			case 0:{ShowPlayerDialogEx(playerid, 1067,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 1:{ShowPlayerDialogEx(playerid, 1068,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 2:{ShowPlayerDialogEx(playerid, 1069,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 3:{ShowPlayerDialogEx(playerid, 1070,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 4:{ShowPlayerDialogEx(playerid, 1071,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 5:{ShowPlayerDialogEx(playerid, 1072,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 6:{ShowPlayerDialogEx(playerid, 1073,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 7:{ShowPlayerDialogEx(playerid, 1074,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 8:{ShowPlayerDialogEx(playerid, 1075,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 9:{ShowPlayerDialogEx(playerid, 1076,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 10:{ShowPlayerDialogEx(playerid, 1077,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}

			}
		}
	case 1053:
		{
			if(!response)return true;
			switch(listitem)
			{
			case 0:{ShowPlayerDialogEx(playerid, 1056,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 1:{ShowPlayerDialogEx(playerid, 1057,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 2:{ShowPlayerDialogEx(playerid, 1058,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 3:{ShowPlayerDialogEx(playerid, 1059,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 4:{ShowPlayerDialogEx(playerid, 1060,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 5:{ShowPlayerDialogEx(playerid, 1061,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 6:{ShowPlayerDialogEx(playerid, 1062,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 7:{ShowPlayerDialogEx(playerid, 1063,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 8:{ShowPlayerDialogEx(playerid, 1064,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 9:{ShowPlayerDialogEx(playerid, 1065,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			case 10:{ShowPlayerDialogEx(playerid, 1066,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");}
			}
		}
	case 1056:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1056,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][1] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно материалов");
			if(colvo1 < 1 || colvo1 > 5000)
			{
				ShowPlayerDialogEx(playerid,1056,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][1]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][1] -= colvo1;
			PTEMP[playerid][pMats] += colvo1;
			SCM(playerid,COLOR_YELLOW," Вы взяли материалы из сейфа");
			return true;
		}
	case 1057:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1057,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][0] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно наркотиков");
			if(colvo1 < 1 || colvo1 > 1500)
			{
				ShowPlayerDialogEx(playerid,1057,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][0]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][0] -= colvo1;
			PTEMP[playerid][pDrugs] += colvo1;
			SCM(playerid,COLOR_YELLOW," Вы взяли наркотики из сейфа");
			return true;
		}
	case 1058:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1058,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][2] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно ключей");
			if(colvo1 < 1 || colvo1 > 1500)
			{
				ShowPlayerDialogEx(playerid,1058,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][2]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][2] -= colvo1;
			PTEMP[playerid][pKeys] += colvo1;
			SCM(playerid,COLOR_YELLOW," Вы взяли ключи из сейфа");
			return true;
		}
	case 1059:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1059,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][3] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно рыбы");
			if(colvo1 < 1 || colvo1 > 50)
			{
				ShowPlayerDialogEx(playerid,1059,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][3]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][3] -= colvo1;
			PTEMP[playerid][pFishesPach] += colvo1;
			SCM(playerid,COLOR_YELLOW," Вы взяли рыбу из сейфа");
			return true;
		}
	case 1060:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1060,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][4] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 500)
			{
				ShowPlayerDialogEx(playerid,1060,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][4]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][4] -= colvo1;
			GiveWeapon(playerid, 23,colvo1);
			SCM(playerid,COLOR_YELLOW," Вы взяли патроны из сейфа");
			return true;
		}
	case 1061:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1061,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][5] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 450)
			{
				ShowPlayerDialogEx(playerid,1061,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][5]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][5] -= colvo1;
			GiveWeapon(playerid, 24,colvo1);
			SCM(playerid,COLOR_YELLOW," Вы взяли патроны из сейфа");
			return true;
		}
	case 1062:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1062,DIALOG_STYLE_INPUT,"Сейф","","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][6] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 450)
			{
				ShowPlayerDialogEx(playerid,1062,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][6]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][6] -= colvo1;
			GiveWeapon(playerid, 25,colvo1);
			SCM(playerid,COLOR_YELLOW," Вы взяли патроны из сейфа");
			return true;
		}
	case 1063:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1063,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][7] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 1500)
			{
				ShowPlayerDialogEx(playerid,1063,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][7]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][7] -= colvo1;
			GiveWeapon(playerid, 29,colvo1);
			SCM(playerid,COLOR_YELLOW," Вы взяли патроны из сейфа");
			return true;
		}
	case 1064:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1064,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][8] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 1500)
			{
				ShowPlayerDialogEx(playerid,1064,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][8]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][8] -= colvo1;
			GiveWeapon(playerid, 30,colvo1);
			SCM(playerid,COLOR_YELLOW," Вы взяли патроны из сейфа ");
			return true;
		}
	case 1065:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1065,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][9] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 1500)
			{
				ShowPlayerDialogEx(playerid,1065,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][9]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][9] -= colvo1;
			GiveWeapon(playerid, 31,colvo1);
			SCM(playerid,COLOR_YELLOW," Вы взяли патроны из сейфа");
			return true;
		}
	case 1066:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1066,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][10] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 100)
			{
				ShowPlayerDialogEx(playerid,1066,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][10]-colvo1 < 0) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][10] -= colvo1;
			GiveWeapon(playerid, 33,colvo1);
			SCM(playerid,COLOR_YELLOW," Вы взяли патроный из сейфа");
			return true;
		}
	case 1067:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1067,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(PTEMP[playerid][pMats] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно материалов");
			if(colvo1 < 1 || colvo1 > 5000)
			{
				ShowPlayerDialogEx(playerid,1067,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][1] > 5000) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][1] += colvo1;
			PTEMP[playerid][pMats] -= colvo1;
			SCM(playerid,COLOR_YELLOW," Вы положили материалы в сейф");
			return true;
		}
	case 1068:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1068,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(PTEMP[playerid][pDrugs] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно наркотиков");
			if(colvo1 < 1 || colvo1 > 1500)
			{
				ShowPlayerDialogEx(playerid,1067,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][0] > 1500) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][0] += colvo1;
			PTEMP[playerid][pDrugs] -= colvo1;
			SCM(playerid,COLOR_YELLOW," Вы положили наркотики в сейф");
			return true;
		}
	case 1069:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1069,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(PTEMP[playerid][pKeys] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно ключей");
			if(colvo1 < 1 || colvo1 > 50)
			{
				ShowPlayerDialogEx(playerid,1069,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][2] > 50) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][2] += colvo1;
			PTEMP[playerid][pKeys] -= colvo1;
			SCM(playerid,COLOR_YELLOW," Вы положили ключи в сейф");
			return true;
		}
	case 1070:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1070,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(PTEMP[playerid][pFishesPach] < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно рыбы");
			if(colvo1 < 1 || colvo1 > 250)
			{
				ShowPlayerDialogEx(playerid,1070,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][3] > 250) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][3] += colvo1;
			PTEMP[playerid][pFishesPach] -= colvo1;
			SCM(playerid,COLOR_YELLOW," Вы положили рыбу в сейф");
			return true;
		}
	case 1071:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1071,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(GetPlayerWeapon(playerid) != 23 || GetPlayerAmmo(playerid) < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 500)
			{
				ShowPlayerDialogEx(playerid,1071,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][4] > 500) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][4] += colvo1;
			GiveWeapon(playerid, 23,-colvo1);
			SCM(playerid,COLOR_YELLOW," Вы положили патроны в сейф");
			return true;
		}
	case 1072:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1072,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(GetPlayerWeapon(playerid) != 24 || GetPlayerAmmo(playerid) < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 450)
			{
				ShowPlayerDialogEx(playerid,1072,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][5] > 450) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][5] += colvo1;
			GiveWeapon(playerid, 24,-colvo1);
			SCM(playerid,COLOR_YELLOW," Вы положили патроны в сейф");
			return true;
		}
	case 1073:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1073,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(GetPlayerWeapon(playerid) != 25 || GetPlayerAmmo(playerid) < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 450)
			{
				ShowPlayerDialogEx(playerid,1073,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][6] > 450) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][6] += colvo1;
			GiveWeapon(playerid, 25,-colvo1);
			SCM(playerid,COLOR_YELLOW," Вы положили патроны в сейф");
			return true;
		}
	case 1074:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1074,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(GetPlayerWeapon(playerid) != 29 || GetPlayerAmmo(playerid) < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 1500)
			{
				ShowPlayerDialogEx(playerid,1074,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][7] > 1500) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][7] += colvo1;
			GiveWeapon(playerid, 29,-colvo1);
			SCM(playerid,COLOR_YELLOW," Вы положили патроны в сейф");
			return true;
		}
	case 1075:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1075,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(GetPlayerWeapon(playerid) != 30 || GetPlayerAmmo(playerid) < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 1500)
			{
				ShowPlayerDialogEx(playerid,1075,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][8] > 1500) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][8] += colvo1;
			GiveWeapon(playerid, 30,-colvo1);
			SCM(playerid,COLOR_YELLOW," Вы положили патроны в сейф");
			return true;
		}
	case 1076:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1076,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(GetPlayerWeapon(playerid) != 31 || GetPlayerAmmo(playerid) < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 1500)
			{
				ShowPlayerDialogEx(playerid,1076,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][9] > 1500) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][9] += colvo1;
			GiveWeapon(playerid, 31,-colvo1);
			SCM(playerid,COLOR_YELLOW," Вы положили патроны в сейф");
			return true;
		}
	case 1077:
		{
			if(!response) return true;
			if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,1077,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
			new colvo1;
			colvo1 = strval(inputtext);
			if(GetPlayerWeapon(playerid) != 33 || GetPlayerAmmo(playerid) < colvo1) return SCM(playerid, COLOR_GREY, " Недостаточно патронов");
			if(colvo1 < 1 || colvo1 > 100)
			{
				ShowPlayerDialogEx(playerid,1077,DIALOG_STYLE_INPUT,"Сейф","Введите количество","Готово","Назад");
				return true;
			}
			if(colvo1+HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][10] > 100) return SCM(playerid,COLOR_GREY," Неверное количество");
			HouseInfo[PTEMP[playerid][pPHouseKey]][hSafe][10] += colvo1;
			GiveWeapon(playerid, 33,-colvo1);
			SCM(playerid,COLOR_YELLOW," Вы положили патроны в сейф");
			return true;
		}
	case 1335:
		{
			if(response)
			{
				PTEMP[playerid][pJob] = 65;
				SCM(playerid, 0x6495EDFF, "Добро пожаловать в команду!");
				SCM(playerid, 0x6495EDFF, "На автомойке всегда найдется работа. Если тебе не на чем доехать, можешь взять скутер в гараже.");
				SCM(playerid, 0x6495EDFF, "(( Для взлома авто, подойди к нужной машине и если авто закрыто, зажми SPACE (Спринт) ))");
			}
			else SCM(playerid,COLOR_BLUE, "Проваливай! Не дай бог настучишь копам!");
		}
	case 2281:
		{
			if(!response) return true;
			if(!strlen(inputtext))
			{

				if(mesh[playerid] == 1) return SCM(playerid,0x30a0a7aa," Задание выполнено");
				return 1;

			}
		}

	case 1336:
		{
			if(!response) return true;
			timecar[playerid] = 0;
			if(PTEMP[playerid][pSkilla] > 0) PTEMP[playerid][pSkilla]--;
			SCM(playerid, COLOR_BLUE, "[SMS]: Ты нас разочаровал! Миссия провалена");
			avtocar[playerid] = 0;
			rabotaon[playerid] = 0;
			GangZoneDestroy(gangzonesa[playerid]);
		}
	case 1690:
		{
			if(!response) return true;
			bizselect[playerid] = bizname[playerid][listitem];
			if(auction_info[listitem] == 1)
			{
				if(WorkshopInfo[bizselect[playerid]][wAuction][1] == 0) format(YCMDstr,9,"%i",WorkshopInfo[bizselect[playerid]][wAuction][0]);
				else format(YCMDstr,16,"Скрыта");
				format(string,300,"{FFFF00}СТО [%i]\n{ffffff}Предыдущая ставка: %i\n{ffffff}Текущая ставка: %s\n{33AA33}Сделать ставку",WorkshopInfo[bizselect[playerid]][wID]-1,WorkshopInfo[bizselect[playerid]][wAuction][1], YCMDstr);
				ShowPlayerDialogEx(playerid,1691,DIALOG_STYLE_LIST,"Аукцион Ферм и CTO",string, "Далее", "Закрыть");
			}
			else
			{
				if(FarmInfo[bizselect[playerid]][fAuction][1] == 0) format(YCMDstr,9,"%i",FarmInfo[bizselect[playerid]][fAuction][0]);
				else format(YCMDstr,16,"Скрыта");
				format(string,300,"{FFFF00}Ферма [%i]\n{ffffff}Предыдущая ставка: %i\n{ffffff}Текущая ставка: %s\n{33AA33}Сделать ставку",FarmInfo[bizselect[playerid]][fID]-1,FarmInfo[bizselect[playerid]][fAuction][1], YCMDstr);
				ShowPlayerDialogEx(playerid,1693,DIALOG_STYLE_LIST,"Аукцион Ферм и CTO",string, "Далее", "Закрыть");
			}
			return true;
		}
	case 1694:
		{
			if(!response) return true;
			for(new i = 0; i <= TOTALFARM; i++) if(!strcmp(PTEMP[playerid][pName], FarmInfo[i][fAuctionName], true) && FarmInfo[i][fAuction][0] > 0) return SCM(playerid,COLOR_GREY," Вы уже делали ставку на другую Ферму/СТО");
			if(FGet(playerid)) return SCM(playerid,COLOR_GREY," У вас уже есть бизнес");
			if(GetPlayerID(FarmInfo[bizselect[playerid]][fAuctionName]) == playerid && FarmInfo[bizselect[playerid]][fAuction][0] > 0) return SCM(playerid,COLOR_GREY," Ваша ставка актуальна");
			if(strval(inputtext) < FarmInfo[bizselect[playerid]][fAuction][3]) return SCM(playerid,COLOR_GREY," Вы не смогли перебить текущую ставку, попробуйте повысить цену");
			if(strval(inputtext) < 100000 && FarmInfo[bizselect[playerid]][fAuction][3] == 0) return SCM(playerid,COLOR_GREY," Вы не смогли перебить текущую ставку, попробуйте повысить цену");
			if(PTEMP[playerid][pBank] < strval(inputtext)) return SCM(playerid,COLOR_GREY," На вашем банковском счету недостаточно денег");
			if(strval(inputtext)-FarmInfo[bizselect[playerid]][fAuction][0] < 100000) return SCM(playerid,COLOR_GREY," Вы не смогли перебить текущую ставку, попробуйте повысить цену");
			if(FarmInfo[bizselect[playerid]][fAuction][3] == 0) FarmInfo[bizselect[playerid]][fAuction][3] = strval(inputtext)/2;
			FarmInfo[bizselect[playerid]][fAuction][1] = FarmInfo[bizselect[playerid]][fAuction][0];
			FarmInfo[bizselect[playerid]][fAuction][0] = strval(inputtext);
			FarmInfo[bizselect[playerid]][fAuction][2] = 6;
			if(IsPlayerConnected(GetPlayerID(FarmInfo[bizselect[playerid]][fAuctionName])) && FarmInfo[bizselect[playerid]][fAuction][1] > 0)
			{
				format(string,144,"Игрок %s перебил вашу ставку на Ферму[%i]",PTEMP[playerid][pName],FarmInfo[bizselect[playerid]][fID]-1);
				SCM(GetPlayerID(FarmInfo[bizselect[playerid]][fAuctionName]),0x9615ffaa,string);
				PTEMP[GetPlayerID(FarmInfo[bizselect[playerid]][fAuctionName])][pBank] += FarmInfo[bizselect[playerid]][fAuction][1];
			}
			else if(!IsPlayerConnected(GetPlayerID(FarmInfo[bizselect[playerid]][fAuctionName])) && FarmInfo[bizselect[playerid]][fAuction][1] > 0)
			{
				mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%e'",FarmInfo[bizselect[playerid]][fAuctionName]);
				mysql_function_query(DATABASE,QUERY,true,"_MySQL_QUERY","iis",30,playerid,"");
			}
			strmid(FarmInfo[bizselect[playerid]][fAuctionName],PTEMP[playerid][pName], 0, strlen(PTEMP[playerid][pName]), 32);
			PTEMP[playerid][pBank] -= strval(inputtext);
			format(string,128," Вы перебили ставку на Ферму[%i]",FarmInfo[bizselect[playerid]][fID]-1);
			return SCM(playerid,0x9615ffaa,string);
		}
	case 1693: if(response && listitem == 3) return ShowPlayerDialogEx(playerid,1694,DIALOG_STYLE_INPUT,"Аукцион бизнесов","Введите сумму ставки", "Поставить", "Отмена");
	case 1691: if(response && listitem == 3) return ShowPlayerDialogEx(playerid,1692,DIALOG_STYLE_INPUT,"Аукцион бизнесов","Введите сумму ставки", "Поставить", "Отмена");
	case 1692:
		{
			if(!response) return true;
			for(new i = 1; i <= TOTALSHOPS; i++) if(!strcmp(PTEMP[playerid][pName], WorkshopInfo[i][wAuctionName], true) && WorkshopInfo[i][wAuction][0] > 0) return SCM(playerid,COLOR_GREY," Вы уже делали ставку на другую Ферму/СТО");
			if(WGet(playerid)) return SCM(playerid,COLOR_GREY," У вас уже есть бизнес");
			if(GetPlayerID(WorkshopInfo[bizselect[playerid]][wAuctionName]) == playerid && WorkshopInfo[bizselect[playerid]][wAuction][0] > 0) return SCM(playerid,COLOR_GREY," Ваша ставка актуальна");
			if(strval(inputtext) < WorkshopInfo[bizselect[playerid]][wAuction][3]) return SCM(playerid,COLOR_GREY," Вы не смогли перебить текущую ставку, попробуйте повысить цену");
			if(strval(inputtext) < 100000 && WorkshopInfo[bizselect[playerid]][wAuction][3] == 0) return SCM(playerid,COLOR_GREY," Вы не смогли перебить текущую ставку, попробуйте повысить цену");
			if(PTEMP[playerid][pBank] < strval(inputtext)) return SCM(playerid,COLOR_GREY," На вашем банковском счету недостаточно денег");
			if(strval(inputtext)-WorkshopInfo[bizselect[playerid]][wAuction][0] < 100000) return SCM(playerid,COLOR_GREY," Вы не смогли перебить текущую ставку, попробуйте повысить цену");
			if(WorkshopInfo[bizselect[playerid]][wAuction][3] == 0) WorkshopInfo[bizselect[playerid]][wAuction][3] = strval(inputtext)/2;
			WorkshopInfo[bizselect[playerid]][wAuction][1] = WorkshopInfo[bizselect[playerid]][wAuction][0];
			WorkshopInfo[bizselect[playerid]][wAuction][0] = strval(inputtext);
			WorkshopInfo[bizselect[playerid]][wAuction][2] = 6;
			if(IsPlayerConnected(GetPlayerID(WorkshopInfo[bizselect[playerid]][wAuctionName])) && WorkshopInfo[bizselect[playerid]][wAuction][1] > 0)
			{
				format(string,144,"Игрок %s перебил вашу ставку на СТО [%i]",PTEMP[playerid][pName],WorkshopInfo[bizselect[playerid]][wID]-1);
				SCM(GetPlayerID(WorkshopInfo[bizselect[playerid]][wAuctionName]),0x9615ffaa,string);
				PTEMP[GetPlayerID(WorkshopInfo[bizselect[playerid]][wAuctionName])][pBank] += WorkshopInfo[bizselect[playerid]][wAuction][1];
			}
			else if(!IsPlayerConnected(GetPlayerID(WorkshopInfo[bizselect[playerid]][wAuctionName])) && WorkshopInfo[bizselect[playerid]][wAuction][1] > 0)
			{
				mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%e'",WorkshopInfo[bizselect[playerid]][wAuctionName]);
				mysql_function_query(DATABASE,QUERY,true,"_MySQL_QUERY","iis",23,playerid,"");
			}
			strmid(WorkshopInfo[bizselect[playerid]][wAuctionName],PTEMP[playerid][pName], 0, strlen(PTEMP[playerid][pName]), 32);
			PTEMP[playerid][pBank] -= strval(inputtext);
			format(string,128," Вы перебили ставку на СТО [%i]",WorkshopInfo[bizselect[playerid]][wID]-1);
			return SCM(playerid,0x9615ffaa,string);
		}
	case 1667:
		{
			new sstring[10];
			if(!response) return true;
			bizselect[playerid] = bizname[playerid][listitem+1];
			if(BizzInfo[bizselect[playerid]][bLastStavka] == 0) format(sstring,9,"%i",BizzInfo[bizselect[playerid]][bStavka]);
			else format(sstring,32,"Скрыта");
			format(string,300,"{FFFF00}Бизнес: %s.\n{ffffff}Предыдущая ставка: %i\n{ffffff}Текущая ставка: %s\n{33AA33}Сделать ставку",BizzInfo[bizselect[playerid]][bMessage],BizzInfo[bizselect[playerid]][bTimeStavka],BizzInfo[bizselect[playerid]][bLastStavka], sstring);
			ShowPlayerDialogEx(playerid,1668,DIALOG_STYLE_LIST,"Аукцион бизнесов",string, "Далее", "Закрыть");
		}
	case 1668: if(response && listitem == 3) ShowPlayerDialogEx(playerid,1669,DIALOG_STYLE_INPUT,"Аукцион бизнесов","Введите сумму ставки", "Поставить", "Отмена");
	case 1669:
		{
			if(!response) return true;
			for(new i = 1; i <= TotalBizz; i++) if(!strcmp(PTEMP[playerid][pName], BizzInfo[i][bNameStavka], true) && BizzInfo[i][bStavka] > 0) return SCM(playerid,COLOR_GREY," Вы уже делали ставку на другой бизнес");
			if(BGet(playerid)) return SCM(playerid,COLOR_GREY," У вас уже есть бизнес");
			if(GetPlayerID(BizzInfo[bizselect[playerid]][bNameStavka]) == playerid && BizzInfo[bizselect[playerid]][bStavka] > 0) return SCM(playerid,COLOR_GREY," Ваша ставка актуальна");
			if(strval(inputtext) < BizzInfo[bizselect[playerid]][bMinStavka]) return SCM(playerid,COLOR_GREY," Вы не смогли перебить текущую ставку, попробуйте повысить цену");
			if(strval(inputtext) < 50000 && BizzInfo[bizselect[playerid]][bMinStavka] == 0) return SCM(playerid,COLOR_GREY," Вы не смогли перебить текущую ставку, попробуйте повысить цену");
			if(PTEMP[playerid][pBank] <= strval(inputtext)) return SCM(playerid,COLOR_GREY," На вашем банковском счету недостаточно денег");
			if(strval(inputtext)-BizzInfo[bizselect[playerid]][bStavka] < 15000) return SCM(playerid,COLOR_GREY," Вы не смогли перебить текущую ставку, попробуйте повысить цену");
			if(BizzInfo[bizselect[playerid]][bMinStavka] == 0) BizzInfo[bizselect[playerid]][bMinStavka] = strval(inputtext)/2;
			BizzInfo[bizselect[playerid]][bLastStavka] = BizzInfo[bizselect[playerid]][bStavka];
			BizzInfo[bizselect[playerid]][bStavka] = strval(inputtext);
			BizzInfo[bizselect[playerid]][bTimeStavka] = 6;
			if(IsPlayerConnected(GetPlayerID(BizzInfo[bizselect[playerid]][bNameStavka])) && BizzInfo[bizselect[playerid]][bLastStavka] > 0)
			{
				format(string,144,"Игрок %s перебил вашу ставку на бизнес %s",PTEMP[playerid][pName],BizzInfo[bizselect[playerid]][bMessage]);
				SCM(GetPlayerID(BizzInfo[bizselect[playerid]][bNameStavka]),0x9615ffaa,string);
				PTEMP[GetPlayerID(BizzInfo[bizselect[playerid]][bNameStavka])][pBank] += BizzInfo[bizselect[playerid]][bLastStavka];
			}
			else if(!IsPlayerConnected(GetPlayerID(BizzInfo[bizselect[playerid]][bNameStavka])) && BizzInfo[bizselect[playerid]][bLastStavka] > 0)
			{
				mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%e'",BizzInfo[bizselect[playerid]][bNameStavka]);
				mysql_function_query(DATABASE,QUERY,true,"_MySQL_QUERY","iis",1,playerid,"");
			}
			strmid(BizzInfo[bizselect[playerid]][bNameStavka],PTEMP[playerid][pName], 0, strlen(PTEMP[playerid][pName]), 32);
			PTEMP[playerid][pBank] -= strval(inputtext);
			format(string,128," Вы перебили ставку на бизнес %s",BizzInfo[bizselect[playerid]][bMessage]);
			SCM(playerid,0x9615ffaa,string);
		}
	case 1334:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					if(PTEMP[playerid][pJob] != 65) return SCM(playerid,COLOR_GREY," Вы не можете взять контракт!");
					new car[20];
					new sss = 0;
					for(new i = GetVehiclePoolSize(); i >= 0; i--) if(IsANope(i) && sss < 20 && IsVehicleOccupied(i) == -1 && Vehicleforeach(i) != -1) car[sss] = i, sss++;
					if(sss == 0) return SCM(playerid,COLOR_GREY," На данный момент на сервере нет машин Nope Class'a");
					new randomik = Random(0, sss);
					avtocar[playerid] = car[randomik];
					new Float:X,Float:Y,Float:Z;
					GetVehiclePos(avtocar[playerid],X,Y,Z);
					format(string, 144, "Пригони нам тачку марки %s, и мы тебе хорошо заплатим.",VehicleNames[GetVehicleModel(avtocar[playerid])-400]);
					SCM(playerid,0x6495EDFF,string);
					SCM(playerid,0x6495EDFF,"(( Чтобы взломать замок зажми Спринт (по умолчанию пробел) ))");
					SCM(playerid,0x6495EDFF,"Подобную тачку наши парни недавно видели. Я обозначил её на твоей карте.");
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					gangzonesa[playerid] = GangZoneCreate(X-95,Y-80,X+70,Y+85);
					GangZoneShowForPlayer(playerid,gangzonesa[playerid],COLOR_BLACK);
					timecar[playerid] = 1200;
				}
			case 1:
				{
					if(PTEMP[playerid][pSkilla] < 50) return SCM(playerid,COLOR_GREY," Вам опыт слишком мал. (Минимум 50).");
					if(PTEMP[playerid][pJob] != 65) return SCM(playerid,COLOR_GREY," Вы не можете взять контракт!");
					new car[20];
					new sss = 0;
					for(new i = GetVehiclePoolSize(); i >= 0; i--) if(IsAB(i) && sss < 20 && IsVehicleOccupied(i) == -1 && Vehicleforeach(i) != -1) car[sss] = i, sss++;
					if(sss == 0) return SCM(playerid,COLOR_GREY," На данный момент на сервере нет машин B Class'a");
					new randomik = Random(0, sss);
					avtocar[playerid] = car[randomik];
					new Float:X,Float:Y,Float:Z;
					GetVehiclePos(avtocar[playerid],X,Y,Z);
					format(string, 144, "Пригони нам тачку марки %s, и мы тебе хорошо заплатим.",VehicleNames[GetVehicleModel(avtocar[playerid])-400]);
					SCM(playerid,0x6495EDFF,string);
					SCM(playerid,0x6495EDFF,"(( Чтобы взломать замок зажми Спринт ( по умолчанию пробел ) )).");
					SCM(playerid,0x6495EDFF,"Подобную тачку наши парни недавно видели. Я обозначил её на твоей карте.");
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					gangzonesa[playerid] = GangZoneCreate(X-95,Y-80,X+70,Y+85);
					GangZoneShowForPlayer(playerid,gangzonesa[playerid],COLOR_BLACK);
					timecar[playerid] = 600;
				}
			case 2:
				{
					if(PTEMP[playerid][pSkilla] < 150) return SCM(playerid,COLOR_GREY," Вам опыт слишком мал. (Минимум 150).");
					if(PTEMP[playerid][pJob] != 65) return SCM(playerid,COLOR_GREY," Вы не можете взять контракт!");
					new car[20];
					new sss = 0;
					for(new i = GetVehiclePoolSize(); i >= 0; i--) if(IsAA(i) && sss < 20 && IsVehicleOccupied(i) == -1 && Vehicleforeach(i) != -1) car[sss] = i, sss++;
					if(sss == 0) return SCM(playerid,COLOR_GREY," На данный момент на сервере нет машин A Class'a");
					new randomik = Random(0, sss);
					avtocar[playerid] = car[randomik];
					new Float:X,Float:Y,Float:Z;
					GetVehiclePos(avtocar[playerid],X,Y,Z);
					format(string, 144, "Пригони нам тачку марки %s, и мы тебе хорошо заплатим.",VehicleNames[GetVehicleModel(avtocar[playerid])-400]);
					SCM(playerid,0x6495EDFF,string);
					SCM(playerid,0x6495EDFF,"(( Чтобы взломать замок зажми Спринт (по умолчанию пробел) ))");
					SCM(playerid,0x6495EDFF,"Подобную тачку наши парни недавно видели. Я обозначил её на твоей карте.");
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					gangzonesa[playerid] = GangZoneCreate(X-95,Y-80,X+70,Y+85);
					GangZoneShowForPlayer(playerid,gangzonesa[playerid],COLOR_BLACK);
					timecar[playerid] = 300;
				}
			}
		}
	case 1745:
		{
			if(!response) return true;
			if(GetPlayerVehicleID(playerid) >= buscar[0] && GetPlayerVehicleID(playerid) <= buscar[1]) SetPVarInt(playerid, "TypeBus", 1);
			else if(GetPlayerVehicleID(playerid) >= buscar[2] && GetPlayerVehicleID(playerid) <= buscar[3]) SetPVarInt(playerid, "TypeBus", 2);
			else if(GetPlayerVehicleID(playerid) >= buscar[4] && GetPlayerVehicleID(playerid) <= buscar[5]) SetPVarInt(playerid, "TypeBus", 3);
			else return true;
			new name[35];
			switch(GetPVarInt(playerid,"TypeBus"))
			{
			case 1: name = "ВнутриГородской ЛС";
			case 2: name = "ВнутриГородской СФ";
			case 3: name = "ВнутриГородской ЛВ";
			}
			format(string, 180, " Водитель автобуса %s начал маршрут %s. Проезд: бесплатный", PTEMP[playerid][pName], name);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(string, 90, "%s\n<< Проезд бесплатный >>", name);
			JobText3D[GetPlayerVehicleID(playerid)] = Create3DTextLabel(string, COLOR_GREEN, 0.0, 0.0, 2.25, 50.0,0,1);
			Attach3DTextLabelToVehicle(JobText3D[GetPlayerVehicleID(playerid)], GetPlayerVehicleID(playerid), 0.0, 0.0, 2.25);
			pPressed[playerid] = 0;
			new i = pPressed[playerid], type = GetPVarInt(playerid, "TypeBus");
			if(type == 1) SetPlayerRaceCheckpoint(playerid,0,BusCityLS[i][0],BusCityLS[i][1],BusCityLS[i][2],BusCityLS[i][3],BusCityLS[i][4],BusCityLS[i][5],7.0);
			if(type == 2) SetPlayerRaceCheckpoint(playerid,0,BusCitySF[i][0],BusCitySF[i][1],BusCitySF[i][2],BusCitySF[i][3],BusCitySF[i][4],BusCitySF[i][5],7.0);
			if(type == 3){SetPlayerRaceCheckpoint(playerid,0,BusCityLV[76][0],BusCityLV[76][1],BusCityLV[76][2],BusCityLV[76][3],BusCityLV[76][4],BusCityLV[76][5],5.0); pPressed[playerid] = 76; }
			return true;
		}
	case 163:
		{
			if(!response) return true;
			new name[35];
			switch(listitem)
			{
			case 0: name = "АвтоВокзал LS << >> Автошкола SF";
			case 1: name = "АвтоВокзал LS << >> АвтоВокзал LV";
			case 2: name = "АвтоВокзал LS << >> Заводы";
			}
			SetPVarInt(playerid, "TypeBus", listitem+4);
			format(string, 180, " Водитель автобуса %s начал маршрут %s. Проезд: бесплатный", PTEMP[playerid][pName], name);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(string, 90, "%s\n<< Проезд бесплатный >>", name);
			JobText3D[GetPlayerVehicleID(playerid)] = Create3DTextLabel(string, COLOR_GREEN, 0.0, 0.0, 2.25, 50.0,0,1);
			Attach3DTextLabelToVehicle(JobText3D[GetPlayerVehicleID(playerid)], GetPlayerVehicleID(playerid), 0.0, 0.0, 2.25);
			pPressed[playerid] = 0;
			new i = pPressed[playerid], type = GetPVarInt(playerid, "TypeBus");
			if(type == 4) SetPlayerRaceCheckpoint(playerid,0,BusSchool[i][0],BusSchool[i][1],BusSchool[i][2],BusSchool[i][3],BusSchool[i][4],BusSchool[i][5],7.0);
			if(type == 5) SetPlayerRaceCheckpoint(playerid,0,BusLSLV[i][0],BusLSLV[i][1],BusLSLV[i][2],BusLSLV[i][3],BusLSLV[i][4],BusLSLV[i][5],5.0);
			if(type == 6) SetPlayerRaceCheckpoint(playerid,0,BusLSZavodi[i][0],BusLSZavodi[i][1],BusLSZavodi[i][2],BusLSZavodi[i][3],BusLSZavodi[i][4],BusLSZavodi[i][5],5.0);
			return true;
		}
	case 5225:
		{
			if(!response) return DeletePVar(playerid,"lsaammo");
			if(GetPVarInt(playerid,"lsaammo") && lsamatbi < 100) return SCM(playerid,COLOR_GREY," На складе недостаточно материалов");
			else if(PTEMP[playerid][pMember] == 1 && lspdmatbi < 100) return SCM(playerid,COLOR_GREY," На складе недостаточно материалов");
			else if(PTEMP[playerid][pMember] == 2 && fbimats < 100) return SCM(playerid,COLOR_GREY," На складе недостаточно материалов");
			else if(PTEMP[playerid][pMember] == 10 && sfpdmats < 100) return SCM(playerid,COLOR_GREY," На складе недостаточно материалов");
			else if(PTEMP[playerid][pMember] == 21 && lvpdmats < 100) return SCM(playerid,COLOR_GREY," На складе недостаточно материалов");
			else if(PTEMP[playerid][pMember] == 3 && armmatsf < 100) return SCM(playerid,COLOR_GREY," На складе недостаточно материалов");
			else if(PTEMP[playerid][pMember] == 19 && armmatbi < 100) return SCM(playerid,COLOR_GREY," На складе недостаточно материалов");
			new guns[2];
			switch(listitem)
			{
			case 0:
				{
					GetPlayerWeaponData(playerid, 2, guns[0], guns[1]);
					if(guns[0] == 24 && guns[1] == 0 || guns[0] != 24) DeletePVar(playerid,"_Deagle");
					SetPVarInt(playerid,"_Deagle",GetPVarInt(playerid,"_Deagle")+1);
					if(guns[0] == 24 && guns[1] > 0 && GetPVarInt(playerid,"_Deagle") > 2) return SCM(playerid,COLOR_GREY," Вы не можете взять больше патронов для этого оружия"), GetGunsDialog(playerid);
					GiveWeapon(playerid,24,21);
					SCM(playerid, 0x9b000ff," Выдано: Desert Eagle (3 обоймы)");
				}
			case 1:
				{
					GetPlayerWeaponData(playerid, 3, guns[0], guns[1]);
					if(guns[0] == 25 && guns[1] == 0 || guns[0] != 25) DeletePVar(playerid,"_Shotgun");
					SetPVarInt(playerid,"_Shotgun",GetPVarInt(playerid,"_Shotgun")+1);
					if(guns[0] == 25 && guns[1] > 0 && GetPVarInt(playerid,"_Shotgun") > 2) return SCM(playerid,COLOR_GREY," Вы не можете взять больше патронов для этого оружия"), GetGunsDialog(playerid);
					GiveWeapon(playerid,25,30);
					SCM(playerid, 0x9b000ff," Выдано: Shotgun (30 патрон)");
				}
			case 2:
				{
					GetPlayerWeaponData(playerid, 4, guns[0], guns[1]);
					if(guns[0] == 29 && guns[1] == 0 || guns[0] != 29) DeletePVar(playerid,"_MP5");
					SetPVarInt(playerid,"_MP5",GetPVarInt(playerid,"_MP5")+1);
					if(guns[0] == 29 && guns[1] > 0 && GetPVarInt(playerid,"_MP5") > 2) return SCM(playerid,COLOR_GREY," Вы не можете взять больше патронов для этого оружия"), GetGunsDialog(playerid);
					GiveWeapon(playerid,29,90);
					SCM(playerid, 0x9b000ff," Выдано: SMG (3 обоймы)");
				}
			case 3:
				{
					GetPlayerWeaponData(playerid, 5, guns[0], guns[1]);
					if(guns[0] == 31 && guns[1] == 0 || guns[0] != 31) DeletePVar(playerid,"_M4A1");
					SetPVarInt(playerid,"_M4A1",GetPVarInt(playerid,"_M4A1")+1);
					if(guns[0] == 31 && guns[1] > 0 && GetPVarInt(playerid,"_M4A1") > 2) return SCM(playerid,COLOR_GREY," Вы не можете взять больше патронов для этого оружия"), GetGunsDialog(playerid);
					GiveWeapon(playerid,31,150);
					SCM(playerid, 0x9b000ff," Выдано: M4A1 (3 обоймы)");
				}
			case 4:
				{
					GetPlayerWeaponData(playerid, 6, guns[0], guns[1]);
					if(guns[0] == 33 && guns[1] == 0 || guns[0] != 33) DeletePVar(playerid,"_Rifle");
					SetPVarInt(playerid,"_Rifle",GetPVarInt(playerid,"_Rifle")+1);
					if(guns[0] == 33 && guns[1] > 0 && GetPVarInt(playerid,"_Rifle") > 2) return SCM(playerid,COLOR_GREY," Вы не можете взять больше патронов для этого оружия"), GetGunsDialog(playerid);
					GiveWeapon(playerid,33,30);
					SCM(playerid, 0x9b000ff," Выдано: Rifle (30 патронов)");
				}
			case 5:
				{
					new Float:armour;
					GetPlayerArmour(playerid,armour);
					if(armour > 90) return SCM(playerid,COLOR_GREY," Подождите немного"), GetGunsDialog(playerid);
					SetPlayerHealthAC(playerid, 100.0);
					SetPlayerArmourAC(playerid, 100);
					PTEMP[playerid][pSatiety] = 100;
					SCM(playerid, 0x9b000ff," Выдано: Броня");
				}
			case 6:
				{
				    GetPlayerWeaponData(playerid, 1, guns[0], guns[1]);
					if(guns[0] == 3 && guns[1] > 0) return SCM(playerid,COLOR_GREY," Вы не можете взять больше патронов для этого оружия"), GetGunsDialog(playerid);
						
				    switch(PTEMP[playerid][pMember])
				    {
				        case 1, 10, 21:
				        {
				        	GiveWeapon(playerid,3,1);
				        }
				        case 2:
				        {
				        	GiveWeapon(playerid,17,10);
				        }
				        case 3, 19:
				        {
				        	GiveWeapon(playerid,46,1);
				        }
				    }
				    SCM(playerid, 0x9b000ff," Выдано: Спец оружие");
				}
				case 7:
			    {
			        SetPlayerArmourAC(playerid, 0);
			        SCM(playerid, 0x9b000ff," Броня снята");
			    }
			}
			
			if(GetPVarInt(playerid,"lsaammo")) lsamatbi-=100;
			else if(PTEMP[playerid][pMember] == 1) lspdmatbi-=100;
			else if(PTEMP[playerid][pMember] == 2) fbimats-=100;
			else if(PTEMP[playerid][pMember] == 10) sfpdmats-=100;
			else if(PTEMP[playerid][pMember] == 21) lvpdmats-=100;
			else if(PTEMP[playerid][pMember] == 3) armmatsf-=100;
			else if(PTEMP[playerid][pMember] == 19) armmatbi-=100;
			return GetGunsDialog(playerid);
		}
	case 6700:
		{
			if(!response) return true;
			new i = GetPlayerVirtualWorld(playerid)-50;
			switch(listitem)
			{
			case 0: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/buyhouse");
			case 1: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/sellhouse");
			case 2: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/open");
			case 3: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/healme");
			case 4: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/buyinterior");
			case 5:
				{
					if(!HGet(playerid) || PTEMP[playerid][pPHouseKey] != i) return SCM(playerid,COLOR_GREY," Это не ваш дом");
					format(string,128,"{ffffff}Аптечек: %i штук\n{ffffff}Дверной замок: %s \n",HouseInfo[i][hHel], (HouseInfo[i][hLock] ? ("Закрыт"):("Открыт")));
					ShowPlayerDialogEx(playerid,64,DIALOG_STYLE_MSGBOX,"Информация",string,"Ок","");
				}
			}
		}
	case 8003:
		{
			if(response)
			{
				new i = GetPlayerVirtualWorld(playerid);
				switch(listitem)
				{
				case 0: ShowPlayerDialogEx(playerid, 8008, 0, "Подтверждение", "Вы точно хотите купить квартиру?\nПри продаже вам вернется 50% от стоимости.\nПри выселении вам ничего не вернется!", "Да", "Нет");
				case 1: ShowPlayerDialogEx(playerid, 8009, 0, "Подтверждение", "Вы точно хотите продать квартиру?", "Да", "Нет");
				case 2: ShowPlayerDialogEx(playerid, 8010, 2, "Квартплата", "Остаток\n - На час\n - На 5 часов\n - На сутки\n - На 3 суток\n - На неделю", "Перевести", "Отмена");
				case 3:
					{
						if(!KGet(playerid)) return SCM(playerid, COLOR_GREY, " У вас нет квартиры!");
						if(i != PTEMP[playerid][pKvartiraKey])return SCM(playerid, COLOR_GREY, " У вас нет квартиры!");
						if(kvartinfo[i][lock] == 0) kvartinfo[i][lock] = 1, SCM(playerid, COLOR_RED, " Дверь закрыта.");
						else kvartinfo[i][lock] = 0, SCM(playerid, COLOR_LIGHTGREEN, " Дверь открыта.");
					}
				case 4:
					{
						if(kvartinfo[i][aptek] == 0) return SCM(playerid, COLOR_GREY, "В квартире нет аптечек");
						else
						{
							kvartinfo[i][aptek] -= 1;
							SetPlayerHealth(playerid, 100);
							SCM(playerid, 0xFFFF00AA, "Вы вылечены");
						}
					}
				case 5: ShowPlayerDialogEx(playerid, 8018, 2, "Сменить интерьер", "Базовый - 5 000 вирт\nИностранный - 100 000 вирт\nМоренго - 150 000 вирт", "Купить", "Отмена");
				case 6:
					{
						new lockkkk[8];
						if(kvartinfo[i][lock] == 1)lockkkk = "Закрыта";
						else lockkkk = "Открыта";
						format(string,128,"{ffffff}Аптечек: %i штук\n{ffffff}Дверной замок: %s \n",kvartinfo[i][aptek], lockkkk);
						ShowPlayerDialogEx(playerid,64,DIALOG_STYLE_MSGBOX,"Информация",string,"Ок","");
					}
				}
			}
		}
	case 8008:
		{
			if(!response) return true;
			new i = GetPlayerVirtualWorld(playerid);
			if(!strcmp(kvartinfo[i][vladelec],"None",true))
			{
				if(KGet(playerid) || HGet(playerid))return SCM(playerid, COLOR_GREY, " У вас уже есть кварира / дом!");
				if(PTEMP[playerid][pBank] < kvartinfo[i][kCena] && booston == 0) return SCM(playerid, COLOR_GREY, " Недостаточно денег на банковском счету");
				if(PTEMP[playerid][pBank] < kvartinfo[i][kCena]-kvartinfo[i][kCena]*40/100 && booston == 1) return SCM(playerid, COLOR_GREY, " Недостаточно денег на банковском счету");
				strmid(kvartinfo[i][vladelec], PTEMP[playerid][pName], 0, strlen(PTEMP[playerid][pName]), 32);
				SCM(playerid, -1, " Поздравляем с покупкой!");
				SCM(playerid, 0xFFFF00AA, " Внимание! Вас могут выселить если квартира не будет вовремя оплачена");
				SCM(playerid, 0xFFFF00AA, " Стоимость квартплаты: 100 вирт в час");
				switch(booston)
				{
				case 0:PTEMP[playerid][pBank] -= kvartinfo[i][kCena];
				case 1:PTEMP[playerid][pBank] -= kvartinfo[i][kCena]-kvartinfo[i][kCena]*40/100;
				}
				KGet(playerid);
				CarInfo[playerid][carFuel][0] = 100;
				updatekvar(i);
				return true;
			}
			else return SCM(playerid, COLOR_GRAD1, " Квартира не продается");
		}
	case 8009:
		{
			if(!response) return true;
			new i = GetPlayerVirtualWorld(playerid);
			if(!KGet(playerid)) return SCM(playerid, COLOR_GREY, " У вас нет квартиры!");
			if(PTEMP[playerid][pKvartiraKey] != i)return SCM(playerid, COLOR_GREY, " У вас нет квартиры!");
			strmid(kvartinfo[i][vladelec], "None", 0, strlen("None"), 5);
			PTEMP[playerid][pKvartiraKey] = 9999;
			kvartinfo[i][lock] = 0;
			kvartinfo[i][plata] = 0;
			switch(booston)
			{
			case 0:PTEMP[playerid][pBank] += kvartinfo[i][kCena]/2;
			case 1:PTEMP[playerid][pBank] += kvartinfo[i][kCena]*40/100/2;
			}
			SCM(playerid, -1, " Квартира продана");
			updatekvar(i);
		}
	case 8010:
		{
			if(!response) return true;
			new i = GetPlayerVirtualWorld(playerid), dengi;
			if(!KGet(playerid)) return SCM(playerid, COLOR_GREY, " У вас нет квартиры!");
			if(PTEMP[playerid][pKvartiraKey] != i)return SCM(playerid, COLOR_GREY, " У вас нет квартиры!");
			switch(listitem)
			{
			case 0:return format(string,90,"Оплачено на: [%i дней]",kvartinfo[i][plata]/2400), SCM(playerid,COLOR_YELLOW,string);
			case 1:dengi = 100;
			case 2:dengi = 500;
			case 3:dengi = 2400;
			case 4:dengi = 7200;
			case 5:dengi = 16800;
			}
			if(kvartinfo[i][plata]+dengi > 16801)return SCM(playerid,-1," Неверная сумма");
			if(PTEMP[playerid][pBank] < dengi)return SCM(playerid, 0xAA3333AA, " Недостаточно денег на банковском счету");
			kvartinfo[i][plata] += dengi;
			PTEMP[playerid][pBank] -= dengi;
			format(string,90," Вы перевели: %i вирт",dengi);
			SCM(playerid,COLOR_YELLOW,string);
			return true;
		}
	case 8018:
		{
			if(!response) return true;
			new i = GetPlayerVirtualWorld(playerid);
			if(!KGet(playerid)) return SCM(playerid, COLOR_GREY, " У вас нет квартиры!");
			if(PTEMP[playerid][pKvartiraKey] != i)return SCM(playerid, COLOR_GREY, " У вас нет квартиры!");
			switch(listitem)
			{
			case 0:
				{
					if(kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] == 0) return SCM(playerid,COLOR_GREY," Вы уже приобрели этот интерьер");
					if(PTEMP[playerid][pBank] <= 5000) return SCM(playerid,COLOR_GREY," На вашем банковском счету недостаточно денег");
					SCM(playerid,0x6495EDFF," Вы приобрели новый интерьер!");
					kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] = 0;
					PTEMP[playerid][pBank] -= 5000;
					if(kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] == 0)
					{
						SetPVarInt(playerid, "podeezd", kvartinfo[PTEMP[playerid][pKvartiraKey]][virtmir]);
						SetPlayerPos(playerid,2283.3474,-1139.2313,1050.8984);
						SetPlayerInterior(playerid,11);
						SetPlayerVirtualWorld(playerid, PTEMP[playerid][pKvartiraKey]);
						return true;
					}
				}
			case 1:
				{
					if(kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] == 1) return SCM(playerid,COLOR_GREY," Вы уже приобрели этот интерьер");
					if(PTEMP[playerid][pBank] <= 100000) return SCM(playerid,COLOR_GREY," На вашем банковском счету недостаточно денег");
					SCM(playerid,0x6495EDFF," Вы приобрели новый интерьер!");
					kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] = 1;
					PTEMP[playerid][pBank] -= 100000;
					if(kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] == 1)
					{
						SetPVarInt(playerid, "podeezd", kvartinfo[PTEMP[playerid][pKvartiraKey]][virtmir]);
						SetPlayerPos(playerid,31.3584,-84.8000,1004.2859);
						SetPlayerInterior(playerid,15);
						SetPlayerVirtualWorld(playerid, PTEMP[playerid][pKvartiraKey]);
						return true;
					}
				}
			case 2:
				{
					if(kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] == 2) return SCM(playerid,COLOR_GREY," Вы уже приобрели этот интерьер");
					if(PTEMP[playerid][pBank] <= 150000) return SCM(playerid,COLOR_GREY," На вашем банковском счету недостаточно денег");
					SCM(playerid,0x6495EDFF," Вы приобрели новый интерьер!");
					kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] = 2;
					PTEMP[playerid][pBank] -= 150000;
					if(kvartinfo[PTEMP[playerid][pKvartiraKey]][kInt] == 2)
					{
						SetPVarInt(playerid, "podeezd", kvartinfo[PTEMP[playerid][pKvartiraKey]][virtmir]);
						SetPlayerPos(playerid,58.2073,-79.1497,1004.2859);
						SetPlayerInterior(playerid,15);
						SetPlayerVirtualWorld(playerid, PTEMP[playerid][pKvartiraKey]);
						return true;
					}
				}
			}
			return true;
		}
	case 6485:
		{
			if(!response) return true;
			new i = GetPVarInt(playerid, "podeezd");
			if(listitem == 0)
			{
				SetPlayerPos(playerid, PodeezdInfo[i][podPicX],PodeezdInfo[i][podPicY],PodeezdInfo[i][podPicZ]);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				DeletePVar(playerid, "podeezd");
				return true;
			}
			else
			{
				switch(PodeezdInfo[i][podInt])
				{
				case 0:
					{
						SetPlayerPos(playerid, 2240.9590, -1190.6875, 1033.7969);
						SetPlayerVirtualWorld(playerid,	PodeezdInfo[i][podMir][listitem]);
						SetPlayerInterior(playerid,15);
					}
				case 1:
					{
						SetPlayerPos(playerid, 2268.0962,1647.3221,1084.2344);
						SetPlayerVirtualWorld(playerid,	PodeezdInfo[i][podMir][listitem]);
						SetPlayerInterior(playerid,1);
					}
				}
			}
			return true;
		}
	case 8999:
		{
			if(!response) return DeletePVar(playerid, "podeezd");
			new i = GetPVarInt(playerid, "podeezd");
			if(listitem == 0)
			{
				if(KGet(playerid))
				{
					if(CarInfo[playerid][carModel][0] == 462)return SCM(playerid,COLOR_GRAD1," У вас нет автомобиля");
					else if(house_car[playerid] != -1)return SCM(playerid,COLOR_GREY," Автомобиль уже используется");
					new hh = GetPVarInt(playerid, "podeezd");
					if(hh != kvartinfo[PTEMP[playerid][pKvartiraKey]][virtmir]) return SCM(playerid,COLOR_GREY," Вы должны находиться возле своего подъезда");
					house_car[playerid] = CreateVehicle(CarInfo[playerid][carModel][0], PodeezdInfo[hh][carX], PodeezdInfo[hh][carY], PodeezdInfo[hh][carZ], PodeezdInfo[hh][carC] , CarInfo[playerid][carColor_one][0] ,CarInfo[playerid][carColor_two][0], 86400);
					SetVehicleParamsEx(house_car[playerid],false,false,false,true,false,false,false);
					CarHealth[house_car[playerid]] = float(1000);
					createdcar = house_car[playerid];
					Fuell[house_car[playerid]] = CarInfo[playerid][carFuel][0];
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					LoadTuning(playerid,house_car[playerid],0);
					AnRepairVehicle(house_car[playerid]);
					SCM(playerid,COLOR_YELLOW," Теперь вы можете забрать свою машину");
					DeletePVar(playerid, "podeezd");
				}
				else return SCM(playerid, COLOR_GREY, " У вас нет квартиры!");
			}
			else
			{
				switch(PodeezdInfo[i][podInt])
				{
				case 0:
					{
						SetPlayerPos(playerid, 2240.9590, -1190.6875, 1033.7969);
						SetPlayerVirtualWorld(playerid,	PodeezdInfo[i][podMir][listitem]);
						SetPlayerInterior(playerid,15);
					}
				case 1:
					{
						SetPlayerPos(playerid, 2268.0962,1647.3221,1084.2344);
						SetPlayerVirtualWorld(playerid,	PodeezdInfo[i][podMir][listitem]);
						SetPlayerInterior(playerid,1);
					}
				}
			}
			return true;
		}
	case 10399:
		{
			if(response)
			{
				new skin = PTEMP[playerid][pChar][0];
				PTEMP[playerid][pChar][0] = PTEMP[playerid][pChar][listitem+1];
				SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
				PTEMP[playerid][pChar][listitem+1] = skin;
				ShowPlayerDialogEx(playerid,10399,DIALOG_STYLE_LIST, "Гардероб","Вешалка №1\nВешалка №2\nВешалка №3\nВешалка №4\nВешалка №5", "Одеть", "Выйти");
			}
			else SpawnPlayer(playerid);
		}
	case 10:
		{
			if(response)
			{
				if(!strlen(inputtext) || strlen(inputtext) > 70)return ShowPlayerDialogEx(playerid,10,DIALOG_STYLE_INPUT, "Жалоба администрации", "Вы собираетесь отправить администрации сообщение с жалобой\nОтправляйте по форме [ID/ник нарушитиля] [Текст жалобы]", "Отправить", "Назад");
				format(YCMDstr, sizeof(YCMDstr), "/aquestion %s", (inputtext));
				CallLocalFunction("OnPlayerCommandText", "is", playerid, YCMDstr);
				return true;
			}
			else return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
		}
	case 229:
		{
			if(response)
			{
				if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,229,DIALOG_STYLE_INPUT, "Задать вопрос по игре", "Напишите свой вопрос", "Отправить", "Назад");
				format(YCMDstr, sizeof(YCMDstr), "/question %s", (inputtext));
				CallLocalFunction("OnPlayerCommandText", "is", playerid, YCMDstr);
				return true;
			}
			else return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
		}
	case 10352:
		{
			if(response)
			{
				if(PTEMP[playerid][pBank] < 1000000) return SCM(playerid, COLOR_GRAD1, " Для смены ника требуется 1000000 вирт на банковском счету");
				if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,10352,DIALOG_STYLE_INPUT, "Смена имени", "Введите новое имя\n\tИмя должно иметь формат: Имя_Фамилия\n\tИмя может содержать буквы от A-z и символ '_'\n\tДлина имени не может быть более 20 символов\n\tСтоимость смены имени 1000000 вирт", "Готово", "Назад");
                mysql_format(DATABASE, QUERY, 256, "SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'", inputtext);
				mysql_query(DATABASE, QUERY);
				new r = cache_num_rows();
				if(r)
				{
				    SCM(playerid, COLOR_GREY, " Данный ник используется");
				}
				else
				{
					PTEMP[playerid][pBank] -=1000000;
					format(WantNickChange[playerid],MAX_PLAYER_NAME, "%s",inputtext);
					format(string, 256, " [Заявка на смену ника] %s[%i] просит сменить ник на: %s", Name(playerid),playerid,(inputtext));
					ABroadCast(COLOR_LIGHTGREEN, string, 1);
					SCM(playerid, -1, " Ваша заявка отправлена. Ждите подтверждения мэром штата");
					SendFamilyMessage(7, TEAM_BLUE_COLOR, string);
					return true;
				}
			}
		}
	case 1:
		{
			if(!response) return SCM(playerid, COLOR_LIGHTRED, " Для выхода из игры используйте /q(uit)"),Kick(playerid);
			if(!strlen(inputtext))
			{
				format(string,344, "{B4B5B7}______________________________________\n\n Добро пожаловать на сервер "NameServer"{B4B5B7}\n       Этот аккаунт зарегистрирован\n\nЛогин: {BFC0C2}%s{B4B5B7}\nВведите пароль:\n______________________________________", Name(playerid));
				ShowPlayerDialogEx(playerid,1,DIALOG_STYLE_PASSWORD, "Авторизация",string, "Войти", "Отмена");
				return true;
			}
			for(new i = strlen(inputtext); i != 0; --i)
			switch(inputtext[i])
			{
			case 'А'..'Я', 'а'..'я', ' ':
				return ShowPlayerDialogEx(playerid,1,DIALOG_STYLE_MSGBOX, "Ошибка!", "{00FF21}Введенный вами пароль содержит русские буквы.\n Смените раскладку клавиатуры!", "Повтор", "");
			}
			strmid(PTEMP[playerid][pKey],inputtext, 0, strlen(inputtext), 32);
			mysql_format(DATABASE,QUERY,256,"SELECT * FROM `"TABLE_BAN"` WHERE `Name` = '%s'",PTEMP[playerid][pName]);
			SetPVarInt(playerid,"time_logged",120);
			return mysql_function_query(DATABASE,QUERY,true,"_MySQL_QUERY","iis",25,playerid,"");
		}
	case 3439:
		{
			if(response)
			{
				if(listitem == 0)
				{
					ShowPlayerDialogEx(playerid, 3440, DIALOG_STYLE_INPUT, "Урок по изучению Box", "Введите [ID] обучаемого", "Начать", "Отмена");
					return true;
				}
				else if(listitem == 1)
				{
					ShowPlayerDialogEx(playerid, 3441, DIALOG_STYLE_INPUT, "Урок по изучению Kong Fu", "Введите [ID] обучаемого", "Начать", "Отмена");
					return true;
				}
				else if(listitem == 2)
				{
					ShowPlayerDialogEx(playerid, 3444, DIALOG_STYLE_INPUT, "Урок по изучению Kick Box", "Введите [ID] обучаемого", "Начать", "Отмена");
					return true;
				}
				else if(listitem == 3)
				{
					ShowPlayerDialogEx(playerid, 3442, DIALOG_STYLE_INPUT, "Завершить урок по Box", "Введите [ID] обучаемого", "Завершить", "Отмена");
					return true;
				}
				else if(listitem == 4)
				{
					ShowPlayerDialogEx(playerid, 3443, DIALOG_STYLE_INPUT, "Завершить урок по Kong Fu", "Введите [ID] обучаемого", "Завершить", "Отмена");
					return true;
				}
				else if(listitem == 5)
				{
					ShowPlayerDialogEx(playerid, 3445, DIALOG_STYLE_INPUT, "Завершить урок по Kick Box", "Введите [ID] обучаемого", "Завершить", "Отмена");
					return true;
				}
			}
			else
			{
				return true;
			}
		}
	case 3389:
		{
			if(!response) return true;
			for(new h = 1; h <= TotalBizz; h++)
			{
				if(!PlayerToPoint(3, playerid,BizzInfo[h][bBarX], BizzInfo[h][bBarY], BizzInfo[h][bBarZ]) || GetPlayerVirtualWorld(playerid) != BizzInfo[h][bVirtualWorld]) continue;
				if(strcmp(BizzInfo[h][bOwner],"None",true) == 0 || BizzInfo[h][bLocked]) return SCM(playerid, COLOR_GREY, " Бизнес закрыт");
				switch(listitem)
				{
				case 0,1:
					{
						if(BizzInfo[h][bProducts] < 30) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]) return SCM(playerid,COLOR_GREY," У вас нет столько денег");
						PTEMP[playerid][pSatiety] += 30;
						if(PTEMP[playerid][pSatiety] > 100) PTEMP[playerid][pSatiety] = 100;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice];
						SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
						BizzInfo[h][bProducts] -= 30;
						BizzInfo[h][bTill] += BizzInfo[h][bPrice];
						BizzPay[h] += BizzInfo[h][bPrice];
					}
				case 2,3:
					{
						if(BizzInfo[h][bProducts] < 60) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*2) return SCM(playerid,COLOR_GREY," У вас нет столько денег");
						PTEMP[playerid][pSatiety] += 60;
						if(PTEMP[playerid][pSatiety] > 100) PTEMP[playerid][pSatiety] = 100;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*2;
						SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
						BizzInfo[h][bProducts] -= 60;
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*2;
						BizzPay[h] += BizzInfo[h][bPrice]*2;
					}
				case 4,5:
					{
						if(BizzInfo[h][bProducts] < 90) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*3) return SCM(playerid,COLOR_GREY," У вас нет столько денег");
						PTEMP[playerid][pSatiety] += 90;
						if(PTEMP[playerid][pSatiety] > 100) PTEMP[playerid][pSatiety] = 100;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*3;
						SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
						BizzInfo[h][bProducts] -= 90;
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*3;
						BizzPay[h] += BizzInfo[h][bPrice]*3;
					}
				}
				ClearAnimations(playerid);
				ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0, 0, 0, 0, 0, 0,1);
				if(GetPlayerInterior(playerid) == 10 || GetPlayerInterior(playerid) == 4) format(YCMDstr,sizeof(YCMDstr), "Бургер\t\t\t\t[%i вирт]\nРыбный суп\t\t\t[%i вирт]\nБольшой бургер\t\t[%i вирт]\nКотлеты\t\t\t[%i вирт]\
				\nПельмени\t\t\t[%i вирт]\nГамбургер\t\t\t[%i вирт]",BizzInfo[h][bPrice],BizzInfo[h][bPrice],BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*3);
				else format(YCMDstr,sizeof(YCMDstr), "Пицца маленькая\t\t[%i вирт]\nПицца с грибами\t\t[%i вирт]\nПицца с сыром\t\t[%i вирт]\nПицца большая\t\t[%i вирт]\
				\nПицца с ветчиной\t\t[%i вирт]\nПицца с куринным мясом\t[%i вирт]",BizzInfo[h][bPrice],BizzInfo[h][bPrice],BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*3);
				ShowPlayerDialogEx(playerid, 3389, DIALOG_STYLE_LIST, "Меню", YCMDstr, "Выбрать", "Отмена");
			}
			return true;
		}
	case 5589:
		{
			if(!response) return true;
			for(new h = 1; h <= TotalBizz; h++)
			{
				if(!PlayerToPoint(3, playerid,BizzInfo[h][bBarX], BizzInfo[h][bBarY], BizzInfo[h][bBarZ]) || GetPlayerVirtualWorld(playerid) != BizzInfo[h][bVirtualWorld]) continue;
				if(strcmp(BizzInfo[h][bOwner],"None",true) == 0 || BizzInfo[h][bLocked]) return SCM(playerid, COLOR_GREY, " Бизнес закрыт");
				switch(listitem)
				{
				case 0:
					{
						if(BizzInfo[h][bProducts] < 10) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						BizzInfo[h][bTill] += BizzInfo[h][bPrice];
						BizzPay[h] += BizzInfo[h][bPrice];
						BizzInfo[h][bProducts] -= 10;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice];
						new randphone = 100000 + random(899999);
						PTEMP[playerid][pPnumber] = randphone;
						SendMes(playerid,COLOR_BLUE," Ваш новый номер мобильного %i", randphone);
					}
				case 1:
					{
						if(BizzInfo[h][bProducts] < 20) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*2) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*2;
						BizzPay[h] += BizzInfo[h][bPrice]*2;
						BizzInfo[h][bProducts] -= 20;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*2;
						PTEMP[playerid][pDirectory] = 1;
						SCM(playerid, COLOR_BLUE, "Телефонная книга приобретена!");
						SCM(playerid, COLOR_BLUE, "(( Введите /directory - справочник, /number - узнать номер телефона игрока ))");
					}
				case 2:
					{
						if(BizzInfo[h][bProducts] < 30) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*3) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						if(HGet(playerid))
						{
							if(HouseInfo[PTEMP[playerid][pPHouseKey]][hHel] >= 500) return SCM(playerid,COLOR_GREY," Вы не можете хранить более 500 аптечек!");
							HouseInfo[PTEMP[playerid][pPHouseKey]][hHel] += 25;
							SCM(playerid, COLOR_BLUE," Вы купили в дом 25 аптечек");
						}
						else if(KGet(playerid))
						{
							if(kvartinfo[PTEMP[playerid][pKvartiraKey]][aptek] >= 500) return SCM(playerid,COLOR_GREY," Вы не можете хранить более 500 аптечек!");
							kvartinfo[PTEMP[playerid][pKvartiraKey]][aptek] += 25;
							SCM(playerid, COLOR_BLUE," Вы купили в квартиру 25 аптечек");
						}
						else return SCM(playerid,COLOR_GREY," У вас нет дома/квартиры");
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*3;
						BizzPay[h] += BizzInfo[h][bPrice]*3;
						BizzInfo[h][bProducts] -= 30;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*3;
					}
				case 3:
					{
						if(BizzInfo[h][bProducts] < 30) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*3) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*3;
						BizzPay[h] += BizzInfo[h][bPrice]*3;
						BizzInfo[h][bProducts] -= 30;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*3;
						GiveWeapon(playerid, 43, 10);
						SCM(playerid, COLOR_BLUE, " Вы купили фотоаппарат");
					}
				case 4:
					{
						if(BizzInfo[h][bProducts] < 30) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*3) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*3;
						BizzPay[h] += BizzInfo[h][bPrice]*3;
						BizzPay[h] += BizzInfo[h][bPrice]*3;
						BizzInfo[h][bProducts] -= 30;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*3;
						GiveWeapon(playerid, 14, 1);
						SCM(playerid, COLOR_BLUE, " Вы купили цветы");
					}
				case 6:
					{
						if(BizzInfo[h][bProducts] < 40) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*4) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*4;
						BizzPay[h] += BizzInfo[h][bPrice]*4;
						BizzInfo[h][bProducts] -= 40;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*4;
						SetPVarInt(playerid,"fish_rod",1);
						SCM(playerid, COLOR_BLUE, " Вы купили удочку");
					}
				case 7:
					{
						if(BizzInfo[h][bProducts] < 40) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*4) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*4;
						BizzPay[h] += BizzInfo[h][bPrice]*4;
						BizzInfo[h][bProducts] -= 40;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*4;
						SetPVarInt(playerid,"fish_gear",GetPVarInt(playerid,"fish_gear")+10);
						SCM(playerid, COLOR_BLUE, " Вы купили снасти. [10 шт.]");
					}
				case 8:
					{
						if(BizzInfo[h][bProducts] < 50) return SCM(playerid, COLOR_GREY, " Нет продуктов");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*5) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*5;
						BizzPay[h] += BizzInfo[h][bPrice]*5;
						BizzInfo[h][bProducts] -= 50;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*5;
						SetPVarInt(playerid,"fish_sonar",1);
						SCM(playerid, COLOR_BLUE, " Вы купили сонар");
					}

				}
				format(string,300, "Номер телефона:\t[%i вирт]\nСправочник:\t\t[%i вирт]\nАптечки(25шт.):\t\t[%i вирт]\nФотоаппарат:\t\t[%i вирт]\nЦветы:\t\t\t[%i вирт]\nУдочка:\t\t[%i вирт]\nСнасти(10шт.):\t\t[%i вирт]\nСонар:\t\t\t[%i вирт]",BizzInfo[h][bPrice],
				BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*4,BizzInfo[h][bPrice]*4,BizzInfo[h][bPrice]*5);
				ShowPlayerDialogEx(playerid, 5589, DIALOG_STYLE_LIST, "24/7", string, "Купить", "Отмена");
			}
			return true;
		}
	case 2289:
		{
			if(!response) return true;
			for(new h = 1; h <= TotalBizz; h++)
			{
				if(!PlayerToPoint(3, playerid,BizzInfo[h][bBarX], BizzInfo[h][bBarY], BizzInfo[h][bBarZ]) || GetPlayerVirtualWorld(playerid) != BizzInfo[h][bVirtualWorld]) continue;
				if(strcmp(BizzInfo[h][bOwner],"None",true) == 0 || BizzInfo[h][bLocked]) return SCM(playerid, COLOR_GREY, " Бизнес закрыт");
				switch(listitem)
				{
				case 0..2:
					{
						if(BizzInfo[h][bProducts] < 10) return SCM(playerid, COLOR_GREY, " В баре нет напитков");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						PTEMP[playerid][pSatiety] += 30;
						BizzInfo[h][bTill] += BizzInfo[h][bPrice];
						BizzPay[h] += BizzInfo[h][bPrice];
						BizzInfo[h][bProducts] -= 10;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice];
						if(PTEMP[playerid][pSatiety] > 100) PTEMP[playerid][pSatiety] = 100;
						SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
						ClearAnimations(playerid);
						ApplyAnimation(playerid, "BAR", "dnk_stndF_loop",4.1,0,0,0,0,0,1);
					}
				case 3..4:
					{
						if(BizzInfo[h][bProducts] < 20) return SCM(playerid, COLOR_GREY, " В баре нет напитков");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*2) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						PTEMP[playerid][pSatiety] += 30;
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*2;
						BizzPay[h] += BizzInfo[h][bPrice]*2;
						BizzInfo[h][bProducts] -= 20;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*2;
						if(PTEMP[playerid][pSatiety] > 100) PTEMP[playerid][pSatiety] = 100;
						SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
						ClearAnimations(playerid);
						ApplyAnimation(playerid, "BAR", "dnk_stndF_loop",4.1,0,0,0,0,0,1);
					}
				case 5..6:
					{
						if(BizzInfo[h][bProducts] < 30) return SCM(playerid, COLOR_GREY, " В баре нет напитков");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*3) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						PTEMP[playerid][pSatiety] += 60;
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*3;
						BizzPay[h] += BizzInfo[h][bPrice]*3;
						BizzInfo[h][bProducts] -= 30;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*3;
						if(PTEMP[playerid][pSatiety] > 100) PTEMP[playerid][pSatiety] = 100;
						SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
						ClearAnimations(playerid);
						ApplyAnimation(playerid, "BAR", "dnk_stndF_loop",4.1,0,0,0,0,0,1);
					}
				case 7:
					{
						if(BizzInfo[h][bProducts] < 40) return SCM(playerid, COLOR_GREY, " В баре нет напитков");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*4) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						PTEMP[playerid][pSatiety] += 60;
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*4;
						BizzPay[h] += BizzInfo[h][bPrice]*4;
						BizzInfo[h][bProducts] -= 40;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*4;
						if(PTEMP[playerid][pSatiety] > 100) PTEMP[playerid][pSatiety] = 100;
						SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
						ClearAnimations(playerid);
						ApplyAnimation(playerid, "BAR", "dnk_stndF_loop",4.1,0,0,0,0,0,1);
					}
				case 8..9:
					{
						if(BizzInfo[h][bProducts] < 50) return SCM(playerid, COLOR_GREY, " В баре нет напитков");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*5) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						PTEMP[playerid][pSatiety] += 90;
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*5;
						BizzPay[h] += BizzInfo[h][bPrice]*5;
						BizzInfo[h][bProducts] -= 50;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*5;
						if(PTEMP[playerid][pSatiety] > 100) PTEMP[playerid][pSatiety] = 100;
						SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
						ClearAnimations(playerid);
						ApplyAnimation(playerid, "BAR", "dnk_stndF_loop",4.1,0,0,0,0,0,1);
					}
				case 10:
					{
						if(BizzInfo[h][bProducts] < 60) return SCM(playerid, COLOR_GREY, " В баре нет напитков");
						if(PTEMP[playerid][pCash] < BizzInfo[h][bPrice]*6) return SCM(playerid, COLOR_GREY, " У вас нет столько денег");
						PTEMP[playerid][pSatiety] += 90;
						BizzInfo[h][bTill] += BizzInfo[h][bPrice]*6;
						BizzPay[h] += BizzInfo[h][bPrice]*6;
						BizzInfo[h][bProducts] -= 60;
						PTEMP[playerid][pCash] -= BizzInfo[h][bPrice]*6;
						if(PTEMP[playerid][pSatiety] > 100) PTEMP[playerid][pSatiety] = 100;
						SendMes(playerid,-1," «Сытость» пополнена до %i",PTEMP[playerid][pSatiety]);
						ClearAnimations(playerid);
						ApplyAnimation(playerid, "BAR", "dnk_stndF_loop",4.1,0,0,0,0,0,1);
					}
				}
				format(YCMDstr,sizeof(YCMDstr), "Вода\t\t[%i вирт]\nСода\t\t[%i вирт]\nТоник\t\t[%i вирт]\nКока-кола\t[%i вирт]\nПиво\t\t[%i вирт]\nСаке\t\t[%i вирт]\nВодка\t\t[%i вирт]\nВино\t\t[%i вирт]\nВиски\t\t[%i вирт]\nКоньяк\t\t[%i вирт]\nАбсент\t\t[%i вирт]",
				BizzInfo[h][bPrice],BizzInfo[h][bPrice],BizzInfo[h][bPrice],BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*2,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*3,BizzInfo[h][bPrice]*4,BizzInfo[h][bPrice]*5,BizzInfo[h][bPrice]*5,BizzInfo[h][bPrice]*6);
				ShowPlayerDialogEx(playerid, 2289, DIALOG_STYLE_LIST, "Меню Бара", YCMDstr, "Выбрать", "Отмена");
			}
			return true;
		}
	case 9125:
		{
			if(response)
			{
				if(PTEMP[playerid][pCash] <= 9000)
				{
					SCM(playerid, COLOR_GRAD2, " У вас нет столько денег!");
					RemovePlayerFromVehicleAC(playerid);
					TogglePlayerControllable(playerid, 1);
					return true;
				}
				PTEMP[playerid][pCash] -= 10000;
				arenda[playerid] = GetPlayerVehicleID(playerid);
				TogglePlayerControllable(playerid, 1);
				GameTextForPlayer(playerid,"~w~YOU HAVE HIRED THE CAR~n~GOOD LUCK ON ROAD", 5000, 3);
				SCM(playerid, -1, " Вы арендовали транспортное средство");
				return true;
			}
			else
			{
				RemovePlayerFromVehicleAC(playerid);
				TogglePlayerControllable(playerid, 1);
				return true;
			}
		}
	case 9126:
		{
			if(response)
			{
				if(PTEMP[playerid][pCash] <= 1500)
				{
					SCM(playerid, COLOR_GRAD2, " У вас нет столько денег!");
					RemovePlayerFromVehicleAC(playerid);
					TogglePlayerControllable(playerid, 1);
					return true;
				}
				PTEMP[playerid][pCash] -= 1500;
				arenda[playerid] = GetPlayerVehicleID(playerid);
				TogglePlayerControllable(playerid, 1);
				GameTextForPlayer(playerid,"~w~YOU HAVE HIRED THE CAR~n~GOOD LUCK ON ROAD", 5000, 3);
				SCM(playerid, -1, " Вы арендовали транспортное средство");
				return true;
			}
			else
			{
				RemovePlayerFromVehicleAC(playerid);
				TogglePlayerControllable(playerid, 1);
				return true;
			}
		}
	case 8128:
		{
			if(!response) return true;
			if(GetPVarInt(playerid,"BusRepairMoney") > GetPVarInt(playerid, "BusMoney")) SetPVarInt(playerid,"BusRepairMoney",PTEMP[playerid][pPayCheck]);
			format(YCMDstr, sizeof(YCMDstr), " Вы закончили свой рабочий день. Заработано $%i. За ремонт -$%i", GetPVarInt(playerid, "BusMoney"), GetPVarInt(playerid,"BusRepairMoney"));
			SCM(playerid, 0x26bf99aa, YCMDstr);
			SCM(playerid, -1, " Деньги будут перечислены на ваш счёт во время зарплаты");
			PTEMP[playerid][pPayCheck] -= GetPVarInt(playerid,"BusRepairMoney");
			DeletePVar(playerid, "BusTime");
			DeletePVar(playerid, "TypeBus");
			DeletePVar(playerid, "BusStop");
			DeletePVar(playerid, "BusMoney");
			DeletePVar(playerid, "BusRepairMoney");
			DeletePVar(playerid, "BusMoney");
			DeletePVar(playerid, "rentcar_job");
			pPressed[playerid] = 0;
			Delete3DTextLabel(JobText3D[GetPlayerVehicleID(playerid)]);
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			DisablePlayerRaceCheckpoint(playerid);
			return true;
		}
	case 9128:
		{
			if(!response) return RemovePlayerFromVehicleAC(playerid), TogglePlayerControllable(playerid, 1);
			if(PTEMP[playerid][pCash] < 500) return SCM(playerid, COLOR_GRAD2, " У вас нет столько денег!"), RemovePlayerFromVehicleAC(playerid), TogglePlayerControllable(playerid, 1);
			PTEMP[playerid][pCash]-=500;
			new carr = GetPlayerVehicleID(playerid);
			SetPVarInt(playerid,"rentcar_job",GetPlayerVehicleID(playerid));
			TogglePlayerControllable(playerid, 1);
			GameTextForPlayer(playerid, "~r~-$500", 5000, 1);
			GameTextForPlayer(playerid,"~w~YOU HAVE HIRED THE CAR~n~GOOD LUCK ON ROAD", 5000, 3);
			if(GetPlayerVehicleID(playerid) >= comptruck[0] && GetPlayerVehicleID(playerid) <= comptruck[1])
			{
				SendMes(playerid,TEAM_GROVE_COLOR," Зерна в машине: %i / 1000",car_grain[GetPlayerVehicleID(playerid)][0]);
				SendMes(playerid,TEAM_GROVE_COLOR," Урожая в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][0]);
				SendMes(playerid,TEAM_GROVE_COLOR," Наркотиков в машине: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][1]);
				SCM(playerid,-1," (( Команды: /prodmenu ))");
				SCM(playerid,-1," (( Чтобы закрыть машину, введите /plock ))");
			}
			else if(GetPlayerVehicleID(playerid) >= comptruck[2] && GetPlayerVehicleID(playerid) <= comptruck[3])
			{
				SendMes(playerid,TEAM_GROVE_COLOR," Топливо: %i / 1000",car_prods[GetPlayerVehicleID(playerid)][1]);
				SCM(playerid,-1," (( Команды: /prodmenu ))");
			}
			else if(GetPlayerVehicleID(playerid) >= comptruck[4] && GetPlayerVehicleID(playerid) <= comptruck[5])
			{
				SendMes(playerid,TEAM_GROVE_COLOR," Товары: %i / %i",car_prods[GetPlayerVehicleID(playerid)][2],PTEMP[playerid][pPMGruz]);
				SendMes(playerid,TEAM_GROVE_COLOR," Еда: %i / %i",car_prods[GetPlayerVehicleID(playerid)][3],PTEMP[playerid][pPMGruz]);
			}
			else if(GetPlayerVehicleID(playerid) >= comptruck[6] && GetPlayerVehicleID(playerid) <= comptruck[7])
			{
				SendMes(playerid,TEAM_GROVE_COLOR," Товары: %i / %i",car_prods[GetPlayerVehicleID(playerid)][2],PTEMP[playerid][pPMGruz]);
				SendMes(playerid,TEAM_GROVE_COLOR," Еда: %i / %i",car_prods[GetPlayerVehicleID(playerid)][3],PTEMP[playerid][pPMGruz]);
			}
			else if(GetPlayerVehicleID(playerid) >= comptruck[8] && GetPlayerVehicleID(playerid) <= comptruck[9])
			{
				SendMes(playerid,TEAM_GROVE_COLOR," Товары: %i / %i",car_prods[GetPlayerVehicleID(playerid)][2],PTEMP[playerid][pPMGruz]);
				SendMes(playerid,TEAM_GROVE_COLOR," Еда: %i / %i",car_prods[GetPlayerVehicleID(playerid)][3],PTEMP[playerid][pPMGruz]);
			}
			else if(GetPlayerVehicleID(playerid) >= mehanik[0] && GetPlayerVehicleID(playerid) <= mehanik[12]) SCM(playerid,COLOR_GREEN," Вы можете чинить и заправлять машины. (( Заправка: /refill / Ремонт: /repair ))"), SCM(playerid,COLOR_GREEN," Вы должны заключить контракт с заправкой. (( Команда: /mcontract ))");
			else if(GetPlayerVehicleID(playerid) >= buscar[0] && GetPlayerVehicleID(playerid) <= buscar[5]) ShowPlayerDialogEx(playerid,1745,DIALOG_STYLE_MSGBOX," ","Начать работу водителя автобуса?", "Да", "Нет");
			else if(GetPlayerVehicleID(playerid) >= hotdogcar[0] && GetPlayerVehicleID(playerid) <= hotdogcar[1]) SCM(playerid,COLOR_GREEN," Заключите контракт с закусочной, для торговли едой. (( Подъедьте к закусочной и введите: /hcontract ))");
			else if(carr >= taxicar[0] && carr <= taxicar[68] || carr >= taxi5lvlcar[0] && carr <= taxi5lvlcar[9] || carr >= taxi10lvlcar[0] && carr <= taxi10lvlcar[10] || carr >= taxi40lvlcar[0] && carr <= taxi40lvlcar[6]) SCM(playerid,COLOR_GREEN," Чтобы начать рабочий день введите /fare");
			else if(GetPlayerVehicleID(playerid) >= buscar[2] && GetPlayerVehicleID(playerid) <= buscar[3]) ShowPlayerDialogEx(playerid,1745,DIALOG_STYLE_MSGBOX," ","Начать работу водителя автобуса?", "Да", "Нет");
			else if(GetPlayerVehicleID(playerid) >= buscar[4] && GetPlayerVehicleID(playerid) <= buscar[5]) ShowPlayerDialogEx(playerid,1745,DIALOG_STYLE_MSGBOX," ","Начать работу водителя автобуса?", "Да", "Нет");
			else ShowPlayerDialogEx(playerid, 163, 2, "Маршрут", "АвтоВокзал LS << >> Автошкола SF\nАвтоВокзал LS << >> АвтоВокзал LV", "Принять", "Отмена");
			return true;
		}
	case 3002:
		{
			if(!response) return true;
			if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid,3002,DIALOG_STYLE_INPUT, "Зарплата репортерам", "[Зарплата] = [Ранг] * N + N\nN = указанное значение от 100 до 2000", "Готово", "Отмена");
			new moneys;
			moneys = strval(inputtext);
			if(moneys < 100 || moneys > 2000)
			{
				ShowPlayerDialogEx(playerid,3002,DIALOG_STYLE_INPUT, "Зарплата репортерам", "[Зарплата] = [Ранг] * N + N\nN = указанное значение от 100 до 2000", "Готово", "Отмена");
				return true;
			}
			SendMes(playerid, COLOR_YELLOW2, " Вы установили зарплату репортёрам %i.", moneys);
			switch(PTEMP[playerid][pMember])
			{
				case 9: newsZP[1] = moneys;
				case 16: newsZP[0] = moneys;
				case 20: newsZP[2] = moneys;
			}
		}
	case 3001:
		{
			if(!response) return true;
			if(!strlen(inputtext)) return  ShowPlayerDialogEx(playerid,3001,DIALOG_STYLE_INPUT, "Стоимость секунды разговора", "Введите цену за звонок не более 20 вирт", "Готово", "Отмена");
			new moneys;
			moneys = strval(inputtext);
			if(moneys < 1 || moneys > 20)
			{
				ShowPlayerDialogEx(playerid,3001,DIALOG_STYLE_INPUT, "Стоимость секунды разговора", "Введите цену за звонок не более 20 вирт", "Готово", "Отмена");
				return true;
			}
			SendMes(playerid, COLOR_YELLOW2, " Вы установили цену за секунду разговора %i вирт.", moneys);
			switch(PTEMP[playerid][pMember])
			{
				case 9: smspricesf = moneys;
				case 16: smspricels = moneys;
				case 20: smspricelv = moneys;
			}
		}
	case 31:
		{
			if(!response) return true;
			if(!strlen(inputtext))
			{
				ShowPlayerDialogEx(playerid,31,DIALOG_STYLE_INPUT, "Цена за символ", "Введите цену за один символ не более 50 вирт", "Готово", "Отмена");
			}
			new moneys;
			moneys = strval(inputtext);
			if(moneys < 1 || moneys > 50)
			{
				SCM(playerid, COLOR_GREY, " Минимальная сумма - 1, максимальная - 50!");
				ShowPlayerDialogEx(playerid,31,DIALOG_STYLE_INPUT, "Цена за символ", "Введите цену за один символ не более 50 вирт", "Готово", "Отмена");
				return true;
			}
			SendMes(playerid, COLOR_YELLOW2, " Вы установили цену за символ %i вирт.", moneys);
			switch(PTEMP[playerid][pMember])
			{
				case 9: addd[1] = moneys;
				case 16: addd[0] = moneys;
				case 20: addd[2] = moneys;
			}
			return true;
		}
	case 10202:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					ShowPlayerDialogEx(playerid,11553,DIALOG_STYLE_INPUT, "Снять деньги с банка News", "Введите сумму", "Готово", "Отмена");
				}
			case 1:
				{
					ShowPlayerDialogEx(playerid,11552,DIALOG_STYLE_INPUT, "Пополнить счет банка News", "Введите сумму", "Готово", "Отмена");
				}
			}
		}
	case 10203:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					ShowPlayerDialogEx(playerid,11553,DIALOG_STYLE_INPUT, "Снять деньги с банка News", "Введите сумму", "Готово", "Отмена");
				}
			case 1:
				{
					ShowPlayerDialogEx(playerid,11552,DIALOG_STYLE_INPUT, "Пополнить счет банка News", "Введите сумму", "Готово", "Отмена");
				}
			}
		}
	case 3113:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
			switch(listitem)
			{
			case 0:
				{
					ShowPlayerDialogEx(playerid,3001,DIALOG_STYLE_INPUT, "Стоимость секунды разговора", "Введите цену за звонок не более 20 вирт", "Готово", "Отмена");
				}
			case 1:
				{
					ShowPlayerDialogEx(playerid,31,DIALOG_STYLE_INPUT, "Стоимость одного символа", "Введите цену за символ не более 50 вирт", "Готово", "Отмена");
				}
			case 2:
			    {
			    	ShowPlayerDialogEx(playerid,3002,DIALOG_STYLE_INPUT, "Зарплата репортерам", "[Зарплата] = [Ранг] * N + N\nN = указанное значение от 100 до 2000", "Готово", "Отмена");
			    }
			}
		}
	case 11518:
		{
			if(!response) return true;
			SetPVarInt(playerid, "AdvertID", listitem+1);
			ShowPlayerDialogEx(playerid, 11519, 2, "Объявления", " [1] Читать\n [2] Редактировать и отправить\n [3] Отправить\n [4] Удалить объявление\n [5] Отправить администрации", "Принять", "Назад");
		}
	case 11519:
		{
			if(!response) { DeletePVar(playerid, "AdvertID"); return AdvertList(playerid); }
			new full = 0;
			switch(PTEMP[playerid][pMember])
			{
			case 16: full = 0;
			case 9: full = 1;
			case 20: full = 2;
			}
			switch(listitem)
			{
			case 0:
				{
     				format(string, 128, " %s",AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adText]);
					ShowPlayerDialogEx(playerid, 11520, 0, "Объявления", string, "Назад", "");
				}
			case 1:
				{
					format(string, 128, " %s",AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adText]);
					ShowPlayerDialogEx(playerid, 11521, 1, "Объявления", string, "Принять", "Назад");
				}
			case 2:
				{

					if(AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][edited] == false)
					{
						strmid(AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][editName], Name(playerid), 0, 50, 50);
						AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][edited] = true;
					}
					if(AdvertTime > gettime())
					{
						DeletePVar(playerid, "AdvertID");
						SCM(playerid, COLOR_GREY, " Объявления можно дать через 15 секунд!");
						return AdvertList(playerid);
					}
					format(string, 128, " Объявление: %s. Прислал: %s. Тел: %i",AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adText], AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adName],AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adPhone]);
					SendClientMessageToAll(0xd900c8, string);
					switch(PTEMP[playerid][pMember])
					{
					case 9:
						{
							format(string, 128, "        Отредактировал сотрудник SF News: %s", AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][editName]);
							SendClientMessageToAll(0xd900c8, string);
						}
					case 16:
						{
							format(string, 128, "        Отредактировал сотрудник LS News: %s", AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][editName]);
							SendClientMessageToAll(0xd900c8, string);
						}
					case 20:
						{
							format(string, 128, "        Отредактировал сотрудник LV News: %s", AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][editName]);
							SendClientMessageToAll(0xd900c8, string);
						}
					}
					for(new i = GetPVarInt(playerid, "AdvertID"); i <= TOTALADVERT[full] - 1; i++)
					{
						AdvertInfo[i][full][adPhone] = AdvertInfo[i+1][full][adPhone];
						strmid(AdvertInfo[i][full][adText],AdvertInfo[i+1][full][adText],0,strlen(AdvertInfo[i+1][full][adText]), 50);
						strmid(AdvertInfo[i][full][adName],AdvertInfo[i+1][full][adName],0,strlen(AdvertInfo[i+1][full][adName]), 50);
						strmid(AdvertInfo[i][full][editName],AdvertInfo[i+1][full][editName],0,strlen(AdvertInfo[i+1][full][editName]), 50);
						AdvertInfo[i][full][editName] = AdvertInfo[i+1][full][editName];
					}
					TOTALADVERT[full]--;
					AdvertTime = gettime() + 15;
					DeletePVar(playerid, "AdvertID");
					AdvertList(playerid);
				}
			case 3:
				{
					for(new i = GetPVarInt(playerid, "AdvertID"); i <= TOTALADVERT[full] - 1; i++)
					{
						AdvertInfo[i][full][adPhone] = AdvertInfo[i+1][full][adPhone];
						strmid(AdvertInfo[i][full][adText],AdvertInfo[i+1][full][adText],0,strlen(AdvertInfo[i+1][full][adText]), 50);
						strmid(AdvertInfo[i][full][adName],AdvertInfo[i+1][full][adName],0,strlen(AdvertInfo[i+1][full][adName]), 50);
					}
					TOTALADVERT[full]--;
					SCM(playerid, -1, " {20A9FF}Объявление удалено");
					DeletePVar(playerid, "AdvertID");
					AdvertList(playerid);
				}
			case 4:
				{
					if(AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][edited] == true) return SCM(playerid, COLOR_GREY, " Отредактированные объявления нельзя отправить администрации.");
					format(string, 128, " News Report: %s. Прислал: %s (Отправил: %s)",AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adText], AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adName], Name(playerid));
					SendAdminMessage(0xD97700AA, string);
					for(new i = GetPVarInt(playerid, "AdvertID"); i <= TOTALADVERT[full] - 1; i++)
					{
						AdvertInfo[i][full][adPhone] = AdvertInfo[i+1][full][adPhone];
						strmid(AdvertInfo[i][full][adText],AdvertInfo[i+1][full][adText],0,strlen(AdvertInfo[i+1][full][adText]), 50);
						strmid(AdvertInfo[i][full][adName],AdvertInfo[i+1][full][adName],0,strlen(AdvertInfo[i+1][full][adName]), 50);
					}
					TOTALADVERT[full]--;
					SCM(playerid, COLOR_LIGHTRED, " Объявление отправлено администрации");
					DeletePVar(playerid, "AdvertID");
					AdvertList(playerid);
				}
			}
		}
	case 11520: ShowPlayerDialogEx(playerid, 11519, 2, "Объявления", " [1] Читать\n [2] Редактировать и отправить\n [3] Отправить\n [4] Удалить объявление\n [5] Отправить администрации", "Принять", "Назад");
	case 11521:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 11519, 2, "Объявления", " [1] Читать\n [2] Редактировать и отправить\n [3] Отправить\n [4] Удалить объявление\n [5] Отправить администрации", "Принять", "Назад");
			new full = 0;
			switch(PTEMP[playerid][pMember])
			{
			case 9: full = 1;
			case 16: full = 0;
			case 20: full = 2;
			}
			if(!strlen(inputtext))
			{
				format(string, 128, " %s",AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adText]);
				return ShowPlayerDialogEx(playerid, 11521, 1, "Объявления", string, "Принять", "Назад");
			}
			strmid(AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adText], inputtext, 0, 128, 128);
			strmid(AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][editName], Name(playerid), 0, 50, 50);
			AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][edited] = true;
			if(AdvertTime > gettime())
			{
				DeletePVar(playerid, "AdvertID");
				SCM(playerid, COLOR_GREY, " Объявления можно дать через 15 секунд!");
				return AdvertList(playerid);
			}
			format(string, 128, " Объявление: %s. Прислал: %s. Тел: %i",AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adText], AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adName],AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][adPhone]);
			SendClientMessageToAll(0xd900c8, string);
			switch(PTEMP[playerid][pMember])
			{
			case 9:
				{
					format(string, 128, "        Отредактировал сотрудник SF News: %s", AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][editName]);
					SendClientMessageToAll(0xd900c8, string);
				}
			case 16:
				{
					format(string, 128, "        Отредактировал сотрудник LS News: %s", AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][editName]);
					SendClientMessageToAll(0xd900c8, string);
				}
			case 20:
				{
					format(string, 128, "        Отредактировал сотрудник LV News: %s", AdvertInfo[GetPVarInt(playerid, "AdvertID")][full][editName]);
					SendClientMessageToAll(0xd900c8, string);
				}
			}
			for(new i = GetPVarInt(playerid, "AdvertID"); i <= TOTALADVERT[full] - 1; i++)
			{
				AdvertInfo[i][full][adPhone] = AdvertInfo[i+1][full][adPhone];
				strmid(AdvertInfo[i][full][adText],AdvertInfo[i+1][full][adText],0,strlen(AdvertInfo[i+1][full][adText]), 50);
				strmid(AdvertInfo[i][full][adName],AdvertInfo[i+1][full][adName],0,strlen(AdvertInfo[i+1][full][adName]), 50);
				strmid(AdvertInfo[i][full][editName],AdvertInfo[i+1][full][editName],0,strlen(AdvertInfo[i+1][full][editName]), 50);
				AdvertInfo[i][full][edited] = AdvertInfo[i+1][full][edited];
			}
			TOTALADVERT[full]--;
			AdvertTime = gettime() + 15;
			DeletePVar(playerid, "AdvertID");
			AdvertList(playerid);
		}
	case 2223:
		{
			if(!response) return true;
			//new newcar = GetPlayerVehicleID(playerid);
			switch(listitem)
			{
			case 0:
				{
					if(PEfir[playerid] != 999)
					{
						PEfir[playerid] = 999;
						SCM(playerid, -1, " Вы вошли в прямой эфир");
						CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
						return true;
					}
					else return SCM(playerid, -1, " Вы уже в эфире");
				}
			case 1:
				{
					if(PEfir[playerid] != 255)
					{
						PEfir[playerid] = 255;
						SCM(playerid, -1, " Вы вышли из прямого эфира");
						if(PTEMP[playerid][pMember] == 9 && smssf == playerid)
						{
						    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
							format(string, 128, " [SFN] %s завершил приём звонков от слушателей", Name(playerid));
							SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
							smssf = -1;
						}
						else if(PTEMP[playerid][pMember] == 16 && smsls == playerid)
						{
						    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
							format(string, 128, " [LSN] %s завершил приём звонков от слушателей", Name(playerid));
							SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
							smsls = -1;
						}
						else if(PTEMP[playerid][pMember] == 20 && smslv == playerid)
						{
						    SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
							format(string, 128, " [LVN] %s завершил приём звонков от слушателей", Name(playerid));
							SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
							smslv = -1;
						}
						CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
						return true;
					}
					else return SCM(playerid, COLOR_GRAD1, " Вы не в эфире");
				}
			case 2:
				{
					if((PTEMP[playerid][pMember] == 9 && smssf != -1) || (PTEMP[playerid][pMember] == 16 && smsls != -1)
					|| (PTEMP[playerid][pMember] == 20 && smsls != -1)) return SCM(playerid, COLOR_GREY, " Приём звонков уже включён");
					new strs[32];
					switch(PTEMP[playerid][pMember])
					{
						case 9: smssf = playerid, strs = "SFN";
						case 16: smsls = playerid, strs = "LSN";
						case 20: smslv = playerid, strs = "LVN";
					}
					SCM(playerid, COLOR_BLUE, " Вы начали приём звонков от слушаталей");
					format(string, 128, " [%s] %s начал приём звонков от слушателей",strs, Name(playerid));
					SendFamilyMessage(PTEMP[playerid][pMember],COLOR_GREEN, string);
					CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
					return true;
				}
			case 3:
				{
					if((PTEMP[playerid][pMember] == 9 && smssf == -1) || (PTEMP[playerid][pMember] == 16 && smsls == -1)
					|| (PTEMP[playerid][pMember] == 20 && smslv == -1)) return SCM(playerid, COLOR_GREY, " Приём звонков уже отключён");
					new strs[32];
					switch(PTEMP[playerid][pMember])
					{
						case 9: smssf = -1, strs = "SFN";
						case 16: smsls = -1, strs = "LSN";
						case 20: smslv = -1, strs = "LVN";
					}
					SCM(playerid, COLOR_BLUE, " Вы завершили приём звонков от слушаталей");
					format(string, 128, " [%s] %s завершил приём звонков от слушателей",strs, Name(playerid));
					SendFamilyMessage(PTEMP[playerid][pMember],0xAF6262FF, string);
					CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
					return true;
				}
			case 4: ShowPlayerDialog(playerid, 2230, DIALOG_STYLE_INPUT, "Взять интервью", "Введите ид игрока для начала интервью", "Далее", "Назад");
			case 5: ShowPlayerDialog(playerid, 2231, DIALOG_STYLE_INPUT, "Завершить интервью", "Введите ид игрока для завершения интвервью", "Далее", "Назад");
			case 6: { AdvertList(playerid); }
			case 7:
			{
				new strs[32];
			    switch(PTEMP[playerid][pMember])
			    {
			    	case 9: strs = "SF News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fSfnews]);
			    	case 16: strs = "LS News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fLsnews]);
					case 20: strs = "LV News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fLvnews]);
			    }
				ShowPlayerDialog(playerid, 3115, DIALOG_STYLE_LIST, strs, string, "Далее", "Назад");
			}
			case 8:
				{
					if(PTEMP[playerid][pLeader] == 9 || PTEMP[playerid][pLeader] == 16 || PTEMP[playerid][pLeader] == 20)
						ShowPlayerDialogEx(playerid, 3113, DIALOG_STYLE_LIST, "[ ANEWS MENU ]", " [ 1 ] Цена звонка\n [ 2 ] Цена за объявления\n [ 3 ] Зарплата", "Выбрать", "Отмена");
					else
	 				{
	 				    SCM(playerid, COLOR_GREY, " Вам не доступен данный раздел!");
	 				    CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
	 				}
				}
			case 9:
			    {
					if(PTEMP[playerid][pRank] < 7)
					{
					    SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
					    return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
					}
					ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
			    }
			}
		}
	case 3118:
	    {
	        if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
	        switch(listitem)
	        {
	            case 0:
	            {
					new firstfree = -1;
					if(PTEMP[playerid][pMember] == 9)
					{
					    for(new i = 0; i < 10; i++)
					    {
					    	if(!strlen(VoteNews[sfn][i][vcaption]))
					    	{
					    	    firstfree = i;
					    	    break;
					    	}
				    	}
			    	}
			    	else if(PTEMP[playerid][pMember] == 16)
					{
					    for(new i = 0; i < 10; i++)
					    {
					    	if(!strlen(VoteNews[lsn][i][vcaption]))
					    	{
					    	    firstfree = i;
					    	    break;
					    	}
				    	}
			    	}
			    	else if(PTEMP[playerid][pMember] == 20)
					{
					    for(new i = 0; i < 10; i++)
					    {
					    	if(!strlen(VoteNews[lvn][i][vcaption]))
					    	{
					    	    firstfree = i;
					    	    break;
					    	}
				    	}
			    	}
			    	if(firstfree == 0)
			    	{
			    		return ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
			    	}
			    	else
			    	{
			    	    format(string, sizeof(string), "");
			    	    new strs[32];
						if(PTEMP[playerid][pMember] == 9)
						{
				    	    for(new i = 0; i < 10; i++)
						    {
						    	if(strlen(VoteNews[sfn][i][vcaption]))
						    	{
						    	    format(strs, sizeof(strs), "[%i] %s\n",i,VoteNews[sfn][i][vcaption]);
						    		strcat(string, strs);
						    	}
					    	}
				    	}
				    	else if(PTEMP[playerid][pMember] == 16)
						{
				    	    for(new i = 0; i < 10; i++)
						    {
						    	if(strlen(VoteNews[lsn][i][vcaption]))
						    	{
						    	    format(strs, sizeof(strs), "[%i] %s\n",i,VoteNews[lsn][i][vcaption]);
						    		strcat(string, strs);
						    	}
					    	}
				    	}
				    	else if(PTEMP[playerid][pMember] == 20)
						{
				    	    for(new i = 0; i < 10; i++)
						    {
						    	if(strlen(VoteNews[lvn][i][vcaption]))
						    	{
						    	    format(strs, sizeof(strs), "[%i] %s\n",i,VoteNews[lvn][i][vcaption]);
						    		strcat(string, strs);
						    	}
					    	}
				    	}
				    	ShowPlayerDialog(playerid, 3130, DIALOG_STYLE_LIST, "Голосование",string, "Выбрать", "Назад");
			    	}
	            }
	            case 1: return ShowPlayerDialog(playerid, 3129, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите название. До 32 символов", "Далее", "Назад");
	        }
	    }
	case 3129:
	    {
	    	if(!response) return ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
	    	if(strlen(inputtext) < 1 || strlen(inputtext) > 32) return ShowPlayerDialog(playerid, 3129, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите название. До 32 символов", "Далее", "Назад");
			if(PTEMP[playerid][pMember] == 9)
			{
			    new firstfree = -1;
			    for(new i = 0; i < 10; i++)
			    {
			    	if(!strlen(VoteNews[sfn][i][vcaption]))
			    	{
			    	    firstfree = i;
			    	    break;
			    	}
		    	}
		    	if(firstfree == -1)
				{
					SCM(playerid, COLOR_GREY, " Достигнуто максимальное количество голосований!");
					ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
				}
			    strmid(VoteNews[sfn][firstfree][vcaption], inputtext, 0, strlen(inputtext), 32);
			    VoteNews[sfn][firstfree][vlevel] = 1;
			}
			else if(PTEMP[playerid][pMember] == 16)
			{
                new firstfree = -1;
			    for(new i = 0; i < 10; i++)
			    {
			    	if(!strlen(VoteNews[lsn][i][vcaption]))
			    	{
			    	    firstfree = i;
			    	    break;
			    	}
		    	}
		    	if(firstfree == -1)
				{
					SCM(playerid, COLOR_GREY, " Достигнуто максимальное количество голосований!");
					ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
				}
			    strmid(VoteNews[lsn][firstfree][vcaption], inputtext, 0, strlen(inputtext), 32);
			    VoteNews[lsn][firstfree][vlevel] = 1;
			}
			else if(PTEMP[playerid][pMember] == 20)
			{
				new firstfree = -1;
			    for(new i = 0; i < 10; i++)
			    {
			    	if(!strlen(VoteNews[lvn][i][vcaption]))
			    	{
			    	    firstfree = i;
			    	    break;
			    	}
		    	}
		    	if(firstfree == -1)
				{
					SCM(playerid, COLOR_GREY, " Достигнуто максимальное количество голосований!");
					ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
				}
			    strmid(VoteNews[lvn][firstfree][vcaption], inputtext, 0, strlen(inputtext), 32);
			    VoteNews[lvn][firstfree][vlevel] = 1;
			}
			SCM(playerid, -1, " Голосование добавлено, но ещё не запущено");
			ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
		}
	case 3130:
	    {
	    	if(!response) return ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
			SetPVarInt(playerid, "chosen_point_vote", listitem);
			ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
		}
	case 3136:
	    {
	        if(!response)
	        {
	        	return ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
	        }
	        new i = GetPVarInt(playerid, "chosen_point_vote"), strs[32];
	        format(string, sizeof(string), "");
	        new index = 0;
			if(PTEMP[playerid][pMember] == 9)
			{
				for(new j = 0; j < 10; j++)
				{
				    if(strlen(VoteNewsVariants_SF[i][j][vname]) == 0)
				    {
				        if(VoteNews[sfn][i][vactive]) format(strs, sizeof(strs), "[%i] %s\t%i голосов\n", index, VoteNewsVariants_SF[i][j][vname],VoteNewsVariants_SF[i][j][vnumber] );
				        else format(strs, sizeof(strs), "[%i] %s\n", index, VoteNewsVariants_SF[i][j][vname]);
				        strcat(string, strs);
				        index++;
				    }
				}
			}
			else if(PTEMP[playerid][pMember] == 16)
			{
				for(new j = 0; j < 10; j++)
				{
				    if(strlen(VoteNewsVariants_LS[i][j][vname]) != 0)
				    {
				        if(VoteNews[lsn][i][vactive]) format(strs, sizeof(strs), "[%i] %s\t%i голосов\n", index, VoteNewsVariants_LS[i][j][vname],VoteNewsVariants_LS[i][j][vnumber] );
				        else format(strs, sizeof(strs), "[%i] %s\n", index, VoteNewsVariants_LS[i][j][vname]);
				        strcat(string, strs);
				        index++;
				    }
				}
			}
			else if(PTEMP[playerid][pMember] == 20)
			{
				for(new j = 0; j < 10; j++)
				{
				    if(strlen(VoteNewsVariants_LV[i][j][vname]) != 0)
				    {
				        if(VoteNews[lvn][i][vactive]) format(strs, sizeof(strs), "[%i] %s\t%i голосов\n", index, VoteNewsVariants_LV[i][j][vname],VoteNewsVariants_LV[i][j][vnumber] );
				        else format(strs, sizeof(strs), "[%i] %s\n", index, VoteNewsVariants_LV[i][j][vname]);
				        strcat(string, strs);
				        index++;
				    }
				}
			}
			if(strlen(string) == 0) return ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
			else
			{
				ShowPlayerDialog(playerid, 3136, DIALOG_STYLE_LIST, "Варианты", string, "Выбрать", "Назад");
			}
	    }
	case 3131:
	    {
	        if(!response)
	        {
	            new firstfree = -1;
				if(PTEMP[playerid][pMember] == 9)
				{
				    for(new i = 0; i < 10; i++)
				    {
				    	if(!strlen(VoteNews[sfn][i][vcaption]))
				    	{
				    	    firstfree = i;
				    	    break;
				    	}
			    	}
		    	}
		    	else if(PTEMP[playerid][pMember] == 16)
				{
				    for(new i = 0; i < 10; i++)
				    {
				    	if(!strlen(VoteNews[lsn][i][vcaption]))
				    	{
				    	    firstfree = i;
				    	    break;
				    	}
			    	}
		    	}
		    	else if(PTEMP[playerid][pMember] == 20)
				{
				    for(new i = 0; i < 10; i++)
				    {
				    	if(!strlen(VoteNews[lvn][i][vcaption]))
				    	{
				    	    firstfree = i;
				    	    break;
				    	}
			    	}
		    	}
		    	if(firstfree == 0)
		    	{
		    		return ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
		    	}
		    	else
		    	{
		    	    format(string, sizeof(string), "");
		    	    new strs[32];
					if(PTEMP[playerid][pMember] == 9)
					{
			    	    for(new i = 0; i < 10; i++)
					    {
					    	if(strlen(VoteNews[sfn][i][vcaption]))
					    	{
					    	    format(strs, sizeof(strs), "[%i] %s\n",i,VoteNews[sfn][i][vcaption]);
					    		strcat(string, strs);
					    	}
				    	}
			    	}
			    	else if(PTEMP[playerid][pMember] == 16)
					{
			    	    for(new i = 0; i < 10; i++)
					    {
					    	if(strlen(VoteNews[lsn][i][vcaption]))
					    	{
					    	    format(strs, sizeof(strs), "[%i] %s\n",i,VoteNews[lsn][i][vcaption]);
					    		strcat(string, strs);
					    	}
				    	}
			    	}
			    	else if(PTEMP[playerid][pMember] == 20)
					{
			    	    for(new i = 0; i < 10; i++)
					    {
					    	if(strlen(VoteNews[lvn][i][vcaption]))
					    	{
					    	    format(strs, sizeof(strs), "[%i] %s\n",i,VoteNews[lvn][i][vcaption]);
					    		strcat(string, strs);
					    	}
				    	}
			    	}
			    	ShowPlayerDialog(playerid, 3130, DIALOG_STYLE_LIST, "Голосование",string, "Выбрать", "Назад");
		    	}
		    	return true;
  			}
  			switch(listitem)
			{
			    case 0: // variants
			    {
			        new i = GetPVarInt(playerid, "chosen_point_vote"), strs[32];
			        format(string, sizeof(string), "");
			        new index = 0;
					if(PTEMP[playerid][pMember] == 9)
					{
						for(new j = 0; j < 10; j++)
						{
						    if(strlen(VoteNewsVariants_SF[i][j][vname]) != 0)
						    {
						        if(VoteNews[sfn][i][vactive]) format(strs, sizeof(strs), "[%i] %s\t%i голосов\n", index, VoteNewsVariants_SF[i][j][vname],VoteNewsVariants_SF[i][j][vnumber] );
						        else format(strs, sizeof(strs), "[%i] %s\n", index, VoteNewsVariants_SF[i][j][vname]);
						        strcat(string, strs);
						        index++;
						    }
						}
					}
					else if(PTEMP[playerid][pMember] == 16)
					{
						for(new j = 0; j < 10; j++)
						{
						    if(strlen(VoteNewsVariants_LS[i][j][vname]) != 0)
						    {
						        if(VoteNews[lsn][i][vactive]) format(strs, sizeof(strs), "[%i] %s\t%i голосов\n", index, VoteNewsVariants_LS[i][j][vname],VoteNewsVariants_LS[i][j][vnumber] );
						        else format(strs, sizeof(strs), "[%i] %s\n", index, VoteNewsVariants_LS[i][j][vname]);
						        strcat(string, strs);
						        index++;
						    }
						}
					}
					else if(PTEMP[playerid][pMember] == 20)
					{
						for(new j = 0; j < 10; j++)
						{
						    if(strlen(VoteNewsVariants_LV[i][j][vname]) != 0)
						    {
						        if(VoteNews[lvn][i][vactive]) format(strs, sizeof(strs), "[%i] %s\t%i голосов\n", index, VoteNewsVariants_LV[i][j][vname],VoteNewsVariants_LV[i][j][vnumber] );
						        else format(strs, sizeof(strs), "[%i] %s\n", index, VoteNewsVariants_LV[i][j][vname]);
						        strcat(string, strs);
						        index++;
						    }
						}
					}
					if(strlen(string) == 0) return ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
					else
					{
						ShowPlayerDialog(playerid, 3136, DIALOG_STYLE_LIST, "Варианты", string, "Выбрать", "Назад");
					}
			    }
			    case 1: // add variant
			    {
			    	return ShowPlayerDialog(playerid, 3133, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите вариант ответа. До 32 символов", "Далее", "Назад");
			    }
			    case 2: // add question
			    {
					return ShowPlayerDialog(playerid, 3132, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите вопрос. До 100 символов", "Далее", "Назад");
			    }
			    case 3: // level limit
			    {
			    	return ShowPlayerDialog(playerid, 3134, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите уровень с которого будет доступно голосование", "Далее", "Назад");
			    }
			    case 4: // launch
			    {
			        
			        new i = GetPVarInt(playerid, "chosen_point_vote");
			        if(PTEMP[playerid][pMember] == 9)
					{
						for(new j = 0; j < 10; j++)
				        {
				            if(VoteNews[sfn][j][vactive])
				            {
				                ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
								if(i == j) return SCM(playerid, COLOR_GREY, " Это голосование уже запущено!");
								return SendMes(playerid, COLOR_GREY, " Уже активировано голосование \"%s\". Сперва удалите его",VoteNews[sfn][j][vcaption]);
                			}
				        }
						new index = -1;
						for(new j = 0; j < 10; j++)
						{
							if(strlen(VoteNewsVariants_SF[i][j][vname]) == 0)
							{
								index = j;
								break;
							}
						}
						if(index == 0)
						{
						    ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
							return SCM(playerid, COLOR_GREY, " Вы не добавили ни одного варианта ответа");
						}
						VoteNews[sfn][i][vactive] = 1;
						//SCM(playerid, -1, " Вы запустили голосование!");
						format(string, sizeof(string), " Открыто голосование репортёром %s News SF {FFFFFF}(( используйте /vote ))", Name(playerid));
						OOCNews(TEAM_GROVE_COLOR, string);
					}
					else if(PTEMP[playerid][pMember] == 16)
					{
					    for(new j = 0; j < 10; j++)
				        {
				            if(VoteNews[lsn][j][vactive])
				            {
				                ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
                                if(i == j) return SCM(playerid, COLOR_GREY, " Это голосование уже запущено!");
								return SendMes(playerid, COLOR_GREY, " Уже активировано голосование \"%s\". Сперва удалите его",VoteNews[lsn][j][vcaption]);
                			}
				        }
						new index = -1;
						for(new j = 0; j < 10; j++)
						{
							if(strlen(VoteNewsVariants_LS[i][j][vname]) == 0)
							{
								index = j;
								break;
							}
						}
						if(index == 0)
						{
						    ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
							return SCM(playerid, COLOR_GREY, " Вы не добавили ни одного варианта ответа");
						}
						VoteNews[lsn][i][vactive] = 1;
						//SCM(playerid, -1, " Вы запустили голосование!");
						format(string, sizeof(string), " Открыто голосование репортёром %s News LS {FFFFFF}(( используйте /vote ))", Name(playerid));
						LSNews(TEAM_GROVE_COLOR, string);
					}
					else if(PTEMP[playerid][pMember] == 20)
					{
					    for(new j = 0; j < 10; j++)
				        {
				            if(VoteNews[lvn][j][vactive])
				            {
				                ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
				                if(i == j) return SCM(playerid, COLOR_GREY, " Это голосование уже запущено!");
								return SendMes(playerid, COLOR_GREY, " Уже активировано голосование \"%s\". Сперва удалите его",VoteNews[lvn][j][vcaption]);
                			}
				        }
						new index = -1;
						for(new j = 0; j < 10; j++)
						{
							if(strlen(VoteNewsVariants_LV[i][j][vname]) == 0)
							{
								index = j;
								break;
							}
						}
						if(index == 0)
						{
						    ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
							return SCM(playerid, COLOR_GREY, " Вы не добавили ни одного варианта ответа");
						}
						VoteNews[lvn][i][vactive] = 1;
						//SCM(playerid, -1, " Вы запустили голосование!");
						format(string, sizeof(string), " Открыто голосование репортёром %s News LV {FFFFFF}(( используйте /vote ))", Name(playerid));
						LVNews(TEAM_GROVE_COLOR, string);
					}
					ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
			    }
			    case 5: // delete
			    {
                    new index = GetPVarInt(playerid, "chosen_point_vote");
                    if(PTEMP[playerid][pMember] == 9)
                    {
						new zin = -1;
					    for(new i = index; i < 9; i++)
					    {
					    	strmid(VoteNews[sfn][i][vcaption], VoteNews[sfn][i+1][vcaption], 0, 32, 32);
							strmid(VoteNews[sfn][i][vquestion], VoteNews[sfn][i+1][vquestion], 0, 32, 32);
							VoteNews[sfn][i][vlevel] = VoteNews[sfn][i+1][vlevel];
							VoteNews[sfn][i][vactive] = VoteNews[sfn][i+1][vactive];
							for(new j = 0; j < 10; j++)
							{
								strmid(VoteNewsVariants_SF[i][j][vname], VoteNewsVariants_SF[i+1][j][vname], 0, 32, 32);
								VoteNewsVariants_SF[i][j][vnumber] = VoteNewsVariants_SF[i+1][j][vnumber];
							}
							if(strlen(VoteNews[sfn][i+1][vcaption]) == 0) zin = i+1;
					    }
					    if(zin == -1) zin = 9;
				        format(VoteNews[sfn][zin][vcaption], 32, "");
						format(VoteNews[sfn][zin][vquestion],32, "");
						VoteNews[sfn][zin][vlevel] = 1;
						VoteNews[sfn][zin][vactive] = 0;
						for(new j = 0; j < 10; j++)
						{
							format(VoteNewsVariants_SF[zin][j][vname], 32, "");
							VoteNewsVariants_SF[zin][j][vnumber] = 0;
						}
                    }
                    else if(PTEMP[playerid][pMember] == 16)
                    {
                    	new zin = -1;
					    for(new i = index; i < 9; i++)
					    {
					    	strmid(VoteNews[lsn][i][vcaption], VoteNews[lsn][i+1][vcaption], 0, 32, 32);
							strmid(VoteNews[lsn][i][vquestion], VoteNews[lsn][i+1][vquestion], 0, 32, 32);
							VoteNews[lsn][i][vlevel] = VoteNews[lsn][i+1][vlevel];
							VoteNews[lsn][i][vactive] = VoteNews[lsn][i+1][vactive];
							for(new j = 0; j < 10; j++)
							{
								strmid(VoteNewsVariants_LS[i][j][vname], VoteNewsVariants_LS[i+1][j][vname], 0, 32, 32);
								VoteNewsVariants_LS[i][j][vnumber] = VoteNewsVariants_LS[i+1][j][vnumber];
							}
							if(strlen(VoteNews[lsn][i+1][vcaption]) == 0) zin = i+1;
					    }
					    if(zin == -1) zin = 9;
				        format(VoteNews[lsn][zin][vcaption], 32, "");
						format(VoteNews[lsn][zin][vquestion],32, "");
						VoteNews[lsn][zin][vlevel] = 1;
						VoteNews[lsn][zin][vactive] = 0;
						for(new j = 0; j < 10; j++)
						{
							format(VoteNewsVariants_LS[zin][j][vname], 32, "");
							VoteNewsVariants_LS[zin][j][vnumber] = 0;
						}
                    }
                    else if(PTEMP[playerid][pMember] == 20)
                    {
                    	new zin = -1;
					    for(new i = index; i < 10; i++)
					    {
					    	strmid(VoteNews[lvn][i][vcaption], VoteNews[lvn][i+1][vcaption], 0, 32, 32);
							strmid(VoteNews[lvn][i][vquestion], VoteNews[lvn][i+1][vquestion], 0, 32, 32);
							VoteNews[lvn][i][vlevel] = VoteNews[lvn][i+1][vlevel];
							VoteNews[lvn][i][vactive] = VoteNews[lvn][i+1][vactive];
							for(new j = 0; j < 10; j++)
							{
								strmid(VoteNewsVariants_LV[i][j][vname], VoteNewsVariants_LV[i+1][j][vname], 0, 32, 32);
								VoteNewsVariants_LV[i][j][vnumber] = VoteNewsVariants_LV[i+1][j][vnumber];
							}
							if(strlen(VoteNews[lsn][i+1][vcaption]) == 0) zin = i+1;
					    }
					    if(zin == -1) zin = 9;
				        format(VoteNews[lvn][zin][vcaption], 32, "");
						format(VoteNews[lvn][zin][vquestion],32, "");
						VoteNews[lvn][zin][vlevel] = 1;
						VoteNews[lvn][zin][vactive] = 0;
						for(new j = 0; j < 10; j++)
						{
							format(VoteNewsVariants_LV[zin][j][vname], 32, "");
							VoteNewsVariants_LV[zin][j][vnumber] = 0;
						}
                    }
                    
                    
	      			new firstfree = -1;
					if(PTEMP[playerid][pMember] == 9)
					{
					    for(new i = 0; i < 10; i++)
					    {
					    	if(!strlen(VoteNews[sfn][i][vcaption]))
					    	{
					    	    firstfree = i;
					    	    break;
					    	}
				    	}
			    	}
			    	else if(PTEMP[playerid][pMember] == 16)
					{
					    for(new i = 0; i < 10; i++)
					    {
					    	if(!strlen(VoteNews[lsn][i][vcaption]))
					    	{
					    	    firstfree = i;
					    	    break;
					    	}
				    	}
			    	}
			    	else if(PTEMP[playerid][pMember] == 20)
					{
					    for(new i = 0; i < 10; i++)
					    {
					    	if(!strlen(VoteNews[lvn][i][vcaption]))
					    	{
					    	    firstfree = i;
					    	    break;
					    	}
				    	}
			    	}
			    	if(firstfree == 0)
			    	{
			    		return ShowPlayerDialog(playerid, 3118, DIALOG_STYLE_LIST, "Голосование","[0] Созданные\n[1] Добавить", "Выбрать", "Назад");
			    	}
			    	else
			    	{
			    	    format(string, sizeof(string), "");
			    	    new strs[32];
						if(PTEMP[playerid][pMember] == 9)
						{
				    	    for(new i = 0; i < 10; i++)
						    {
						    	if(strlen(VoteNews[sfn][i][vcaption]))
						    	{
						    	    format(strs, sizeof(strs), "[%i] %s\n",i,VoteNews[sfn][i][vcaption]);
						    		strcat(string, strs);
						    	}
					    	}
				    	}
				    	else if(PTEMP[playerid][pMember] == 16)
						{
				    	    for(new i = 0; i < 10; i++)
						    {
						    	if(strlen(VoteNews[lsn][i][vcaption]))
						    	{
						    	    format(strs, sizeof(strs), "[%i] %s\n",i,VoteNews[lsn][i][vcaption]);
						    		strcat(string, strs);
						    	}
					    	}
				    	}
				    	else if(PTEMP[playerid][pMember] == 20)
						{
				    	    for(new i = 0; i < 10; i++)
						    {
						    	if(strlen(VoteNews[lvn][i][vcaption]))
						    	{
						    	    format(strs, sizeof(strs), "[%i] %s\n",i,VoteNews[lvn][i][vcaption]);
						    		strcat(string, strs);
						    	}
					    	}
				    	}
				    	ShowPlayerDialog(playerid, 3130, DIALOG_STYLE_LIST, "Голосование",string, "Выбрать", "Назад");
	      			}
      			}
   			}
	   	}
	case 3137:
	    {
	        if(!response) return true;
	        if(gNews[playerid] == 0)
	        {
	            new index = -1;
	            for(new i = 0; i < 10; i++)
	            {
	                if(VoteNews[sfn][i][vactive] == 1)
	                {
	                    index = i;
	                    break;
	                }
	            }
	            format(string, sizeof(string), "");
	            new strs[32], counter;
	            for(new i = 0; i < 10; i++)
	            {
	                if(strlen(VoteNewsVariants_SF[index][i][vname]) != 0)
	                {
		                format(strs, sizeof(strs), "[%i] %s\n", counter, VoteNewsVariants_SF[index][i][vname]);
		                counter++;
		                strcat(string, strs);
					}
	            }
	            ShowPlayerDialog(playerid, 3135, DIALOG_STYLE_LIST, VoteNews[sfn][index][vcaption], string, "Выбор", "Отмена");
	        }
	        else if(lNews[playerid] == 0)
	        {
	            new index = -1;
	            for(new i = 0; i < 10; i++)
	            {
	                if(VoteNews[lsn][i][vactive] == 1)
	                {
	                    index = i;
	                    break;
	                }
	            }
	            format(string, sizeof(string), "");
	            new strs[32], counter;
	            for(new i = 0; i < 10; i++)
	            {
	                if(strlen(VoteNewsVariants_LS[index][i][vname]) != 0)
	                {
		                format(strs, sizeof(strs), "[%i] %s\n", counter, VoteNewsVariants_LS[index][i][vname]);
		                counter++;
		                strcat(string, strs);
	                }
	            }
	            ShowPlayerDialog(playerid, 3135, DIALOG_STYLE_LIST, VoteNews[lsn][index][vcaption], string, "Выбор", "Отмена");
	        }
	        else if(LvNews[playerid] == 0)
	        {
	            new index = -1;
	            for(new i = 0; i < 10; i++)
	            {
	                if(VoteNews[lvn][i][vactive] == 1)
	                {
	                    index = i;
	                    break;
	                }
	            }
	            format(string, sizeof(string), "");
	            new strs[32], counter;
	            for(new i = 0; i < 10; i++)
	            {
	                if(strlen(VoteNewsVariants_LV[index][i][vname]) != 0)
	                {
						format(strs, sizeof(strs), "[%i] %s\n", counter, VoteNewsVariants_LV[index][i][vname]);
		                counter++;
		                strcat(string, strs);
      				}
	            }
	            ShowPlayerDialog(playerid, 3135, DIALOG_STYLE_LIST, VoteNews[lvn][index][vcaption], string, "Выбор", "Отмена");
	        }
	    }
	case 3135:
	    {
	        if(!response) return true;
	        new voteid = -1;
   			if(gNews[playerid] == 0)
			{
       			if(GetPVarInt(playerid, "progolos_sf"))
			    {
			        return SCM(playerid, COLOR_GREY, " Вы уже голосовали!");
			        //CallLocalFunction("OnPlayerCommandText", "is", playerid, "/vote");
			        //return true;
			    }
				for(new i = 0; i < 10; i++)
			    {
			        if(VoteNews[sfn][i][vactive] == 1)
			        {
						voteid = i;
						break;
			        }
			    }
				new counter = 0, strs[32];
				format(string, sizeof(string), "");
			    for(new i = 0; i < 10; i++)
			    {
					if(strlen(VoteNewsVariants_SF[voteid][i][vname]) != 0)
			        {
						format(strs, sizeof(strs), "[%i] %s", counter, VoteNewsVariants_SF[voteid][i][vname]);
						counter++;
			        }
			    }
			    counter--;
				if(listitem == counter)
				{
				    VoteNewsVariants_SF[voteid][9][vnumber]++;
				}
				else
				{
					VoteNewsVariants_SF[voteid][listitem][vnumber]++;
				}
				SCM(playerid, -1, " Спасибо, ваш голос учтён!");
				SetPVarInt(playerid, "progolos_sf", 1);
			}
			else if(lNews[playerid] == 0)
			{
			    if(GetPVarInt(playerid, "progolos_ls"))
			    {
			        return SCM(playerid, COLOR_GREY, " Вы уже голосовали!");
			        //CallLocalFunction("OnPlayerCommandText", "is", playerid, "/vote");
			        //return true;
			    }
				for(new i = 0; i < 10; i++)
			    {
			        if(VoteNews[lsn][i][vactive] == 1)
			        {
						voteid = i;
						break;
			        }
			    }
				new counter = 0, strs[32];
				format(string, sizeof(string), "");
			    for(new i = 0; i < 10; i++)
			    {
					if(strlen(VoteNewsVariants_LS[voteid][i][vname]) != 0)
			        {
						format(strs, sizeof(strs), "[%i] %s", counter, VoteNewsVariants_LS[voteid][i][vname]);
						counter++;
			        }
			    }
			    counter--;
				if(listitem == counter)
				{
				    VoteNewsVariants_LS[voteid][9][vnumber]++;
				}
				else
				{
					VoteNewsVariants_LS[voteid][listitem][vnumber]++;
				}
				SCM(playerid, -1, " Спасибо, ваш голос учтён!");
				SetPVarInt(playerid, "progolos_ls", 1);
			}
			else if(LvNews[playerid] == 0)
			{
			    if(GetPVarInt(playerid, "progolos_lv"))
			    {
			        return SCM(playerid, COLOR_GREY, " Вы уже голосовали!");
			        //CallLocalFunction("OnPlayerCommandText", "is", playerid, "/vote");
			        //return true;
			    }
			    for(new i = 0; i < 10; i++)
			    {
			        if(VoteNews[lvn][i][vactive] == 1)
			        {
						voteid = i;
						break;
			        }
			    }
				new counter = 0, strs[32];
				format(string, sizeof(string), "");
			    for(new i = 0; i < 10; i++)
			    {
					if(strlen(VoteNewsVariants_LV[voteid][i][vname]) != 0)
			        {
						format(strs, sizeof(strs), "[%i] %s", counter, VoteNewsVariants_LV[voteid][i][vname]);
						counter++;
			        }
			    }
			    counter--;
				if(listitem == counter)
				{
				    VoteNewsVariants_LV[voteid][9][vnumber]++;
				}
				else
				{
					VoteNewsVariants_LV[voteid][listitem][vnumber]++;
				}
				SCM(playerid, -1, " Спасибо, ваш голос учтён!");
				SetPVarInt(playerid, "progolos_lv", 1);
			}
	    }
	case 3134:
	    {
	    	if(!response) return ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
			new l = strval(inputtext);
			if(l < 0 || l > 100) return ShowPlayerDialog(playerid, 3134, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите уровень с которого будет доступно голосование", "Далее", "Назад");
			new i = GetPVarInt(playerid, "chosen_point_vote");
			switch(PTEMP[playerid][pMember])
			{
			    case 9: VoteNews[sfn][i][vlevel] = l;
			    case 16: VoteNews[lsn][i][vlevel] = l;
			    case 20: VoteNews[lvn][i][vlevel] = l;
   			}
   			SCM(playerid, -1, " Вы установили минимальный уровень для голосования");
   			return ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
		}
	case 3133:
	    {
	        if(!response) return ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
	        if(strlen(inputtext) < 1 || strlen(inputtext) > 100) return ShowPlayerDialog(playerid, 3133, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите вариант ответа. До 32 символов", "Далее", "Назад");
			new i = GetPVarInt(playerid, "chosen_point_vote");
			if(PTEMP[playerid][pMember] == 9)
			{
				for(new j = 0; j < 10; j++)
				{
				    if(strlen(VoteNewsVariants_SF[i][j][vname]) == 0)
				    {
				        strmid(VoteNewsVariants_SF[i][j][vname], inputtext, 0, strlen(inputtext), 32);
				        SCM(playerid, -1, " Вы добавили вариант для голосования");
				        strmid(VoteNewsVariants_SF[i][9][vname], "Воздержаться", 0, 32, 32);
				        break;
				    }
				    if(j == 8) SCM(playerid, COLOR_GREY, " Достигнуто максимальное количество вариантов!");
				}
			}
			else if(PTEMP[playerid][pMember] == 16)
			{
				for(new j = 0; j < 10; j++)
				{
				    if(strlen(VoteNewsVariants_LS[i][j][vname]) == 0)
				    {
				        strmid(VoteNewsVariants_LS[i][j][vname], inputtext, 0, strlen(inputtext), 32);
				        SCM(playerid, -1, " Вы добавили вариант для голосования");
				        strmid(VoteNewsVariants_LS[i][9][vname], "Воздержаться", 0, 32, 32);
				        break;
				    }
				    if(j == 8) SCM(playerid, COLOR_GREY, " Достигнуто максимальное количество вариантов!");
				}
			}
			else if(PTEMP[playerid][pMember] == 20)
			{
				for(new j = 0; j < 10; j++)
				{
				    if(strlen(VoteNewsVariants_LV[i][j][vname]) == 0)
				    {
				        strmid(VoteNewsVariants_LV[i][j][vname], inputtext, 0, strlen(inputtext), 32);
				        SCM(playerid, -1, " Вы добавили вариант для голосования");
				        strmid(VoteNewsVariants_LV[i][9][vname], "Воздержаться", 0, 32, 32);
				        break;
				    }
				    if(j == 8) SCM(playerid, COLOR_GREY, " Достигнуто максимальное количество вариантов!");
				}
			}
			return ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
		}
	case 3132:
	    {
	        if(!response) return ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
	        if(strlen(inputtext) < 1 || strlen(inputtext) > 100) return ShowPlayerDialog(playerid, 3132, DIALOG_STYLE_INPUT, "Ввод параметра", "Введите вопрос. До 100 символов", "Далее", "Назад");
			new i = GetPVarInt(playerid, "chosen_point_vote");
			switch(PTEMP[playerid][pMember])
			{
			    case 9: strmid(VoteNews[sfn][i][vquestion], inputtext, 0, strlen(inputtext), 100);
			    case 16: strmid(VoteNews[lsn][i][vquestion], inputtext, 0, strlen(inputtext), 100);
			    case 20: strmid(VoteNews[lvn][i][vquestion], inputtext, 0, strlen(inputtext), 100);
   			}
   			SCM(playerid, -1, " Вы добавили вопрос для голосования");
			return ShowPlayerDialog(playerid, 3131, DIALOG_STYLE_LIST, "Меню", "[0] Варианты\n[1] Добавить вариант\n[2] Добавить вопрос\n[3] Ограничить по левелу\n[4] Запустить\n[5] Удалить", "Выбрать", "Назад");
	    }
	case 3115:
	    {
	        if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
	        switch(listitem)
	        {
	            case 2:
	            {
					new strs[32];
				    switch(PTEMP[playerid][pMember])
				    {
				    	case 9: strs = "SF News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fSfnews]);
				    	case 16: strs = "LS News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fLsnews]);
						case 20: strs = "LV News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fLvnews]);
				    }
					return ShowPlayerDialog(playerid, 3115, DIALOG_STYLE_LIST, strs, string, "Далее", "Назад");
	            }
	            case 1:
	            {
	            	return ShowPlayerDialog(playerid, 3116, DIALOG_STYLE_INPUT, "Перевести на счёт", "Введите сумму, которую вы хотите положить", "Далее", "Назад");
	            }
	            case 0:
	            {
	            	return ShowPlayerDialog(playerid, 3117, DIALOG_STYLE_INPUT, "Сеять со счёта", "Введите сумму, которую вы хотите снять", "Далее", "Назад");
	            }
	        }
		}
	case 3117:
	    {
	        if(!response)
	        {
	        	new strs[32];
			    switch(PTEMP[playerid][pMember])
			    {
			    	case 9: strs = "SF News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fSfnews]);
			    	case 16: strs = "LS News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fLsnews]);
					case 20: strs = "LV News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fLvnews]);
			    }
				ShowPlayerDialog(playerid, 3115, DIALOG_STYLE_LIST, strs, string, "Далее", "Назад");
	        }
	        if(strlen(inputtext) == 0) return ShowPlayerDialog(playerid, 3117, DIALOG_STYLE_INPUT, "Снять со счёт", "Введите сумму, которую вы хотите снять", "Далее", "Назад");
			new money = strval(inputtext);
			if(money < 1) return ShowPlayerDialog(playerid, 3117, DIALOG_STYLE_INPUT, "Снять со счёта", "Введите сумму, которую вы хотите снять", "Далее", "Назад");
			switch(PTEMP[playerid][pMember])
			{
			    case 9:
			    {
			        if((snyatosf+money) > 100000)
			        {
			            return ShowPlayerDialog(playerid, 3117, DIALOG_STYLE_INPUT, "Снять со счёта", "Введите сумму, которую вы хотите снять\nВ день нельзя снимать больше 100 000", "Далее", "Назад");
			        }
			        else
			        {
			            if(PTEMP[playerid][pRank] < 10)
						{
						    SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
						}
			            snyatosf += money;
			            FracBank[0][fSfnews] -= money;
			            PTEMP[playerid][pBank] += money;
			            SendMes(playerid, COLOR_BLUE, " Вы сняли со счёта банка SFN %i вирт. Ваш баланс: %i", money, PTEMP[playerid][pBank]);
			            format(string, sizeof(string), "[0] Баланс новостей: %i вирт\n[1] Положить деньги\n[2] Снять деньги", FracBank[0][fSfnews]);
			            return ShowPlayerDialog(playerid, 3115, DIALOG_STYLE_LIST, "Снять со счёта", string, "Далее", "Назад");
			        }
			    }
			    case 16:
			    {
			    	if((snyatols+money) > 100000)
			        {
			            return ShowPlayerDialog(playerid, 3117, DIALOG_STYLE_INPUT, "Снять со счёта", "Введите сумму, которую вы хотите снять\nВ день нельзя снимать больше 100 000", "Далее", "Назад");
			        }
			        else
			        {
			            if(PTEMP[playerid][pRank] < 10)
						{
						    SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
						}
			            snyatols += money;
			            FracBank[0][fLsnews] -= money;
			            PTEMP[playerid][pBank] += money;
			            SendMes(playerid, COLOR_BLUE, " Вы сняли со счёта банка LSN %i вирт. Ваш баланс: %i", money, PTEMP[playerid][pBank]);
			            format(string, sizeof(string), "[0] Баланс новостей: %i вирт\n[1] Положить деньги\n[2] Снять деньги", FracBank[0][fLsnews]);
			            return ShowPlayerDialog(playerid, 3115, DIALOG_STYLE_LIST, "Снять со счёта", string, "Далее", "Назад");
			        }
			    }
			    case 20:
			    {
			    	if((snyatolv+money) > 100000)
			        {
			            return ShowPlayerDialog(playerid, 3117, DIALOG_STYLE_INPUT, "Снять со счёта", "Введите сумму, которую вы хотите снять\nВ день нельзя снимать больше 100 000", "Далее", "Назад");
			        }
			        else
			        {
			            if(PTEMP[playerid][pRank] < 10)
						{
						    SCM(playerid, COLOR_GREY, " Вам недоступна эта функция!");
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
						}
			            snyatolv += money;
			            FracBank[0][fLvnews] -= money;
			            PTEMP[playerid][pBank] += money;
			            SendMes(playerid, COLOR_BLUE, " Вы сняли со счёта банка LVN %i вирт. Ваш баланс: %i", money, PTEMP[playerid][pBank]);
			            format(string, sizeof(string), "[0] Баланс новостей: %i вирт\n[1] Положить деньги\n[2] Снять деньги", FracBank[0][fLvnews]);
			            return ShowPlayerDialog(playerid, 3115, DIALOG_STYLE_LIST, "Снять со счёта", string, "Далее", "Назад");
			        }
			    }
			}
	    }
	case 3116:
	    {
	    	if(!response)
	        {
	        	new strs[32];
			    switch(PTEMP[playerid][pMember])
			    {
			    	case 9: strs = "SF News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fSfnews]);
			    	case 16: strs = "LS News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fLsnews]);
					case 20: strs = "LV News Bank", format(string, sizeof(string), "Снять со счёта(наличные)\nПеревести на счёт(с личного счёта)\nБаланс: %i вирт", FracBank[0][fLvnews]);
			    }
				return ShowPlayerDialog(playerid, 3115, DIALOG_STYLE_LIST, strs, string, "Далее", "Назад");
	        }
			if(strlen(inputtext) == 0) return ShowPlayerDialog(playerid, 3116, DIALOG_STYLE_INPUT, "Положить на счёт", "Введите сумму, которую вы хотите положить", "Далее", "Назад");
			new money = strval(inputtext);
			if(money < 1) return ShowPlayerDialog(playerid, 3116, DIALOG_STYLE_INPUT, "Положить на счёт", "Введите сумму, которую вы хотите положить", "Далее", "Назад");
			if(money > PTEMP[playerid][pBank])
			{
			    SCM(playerid, COLOR_GREY, " У вас нет столько денег на банковском счету!");
			    return ShowPlayerDialog(playerid, 3116, DIALOG_STYLE_INPUT, "Положить на счёт", "Введите сумму, которую вы хотите положить", "Далее", "Назад");
			}
			switch(PTEMP[playerid][pMember])
			{
			    case 9: FracBank[0][fSfnews] += money;
			    case 16: FracBank[0][fLsnews] += money;
			    case 20: FracBank[0][fLvnews] += money;
			}
			PTEMP[playerid][pBank] -= money;
	    }
	case 2230:
	    {
	        if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
	        if(strlen(inputtext) == 0) return ShowPlayerDialog(playerid, 2230, DIALOG_STYLE_INPUT, "Взять интервью", "Введите ид игрока для начала интервью", "Далее", "Назад");
			new plid = strval(inputtext);
			if(!IsPlayerConnected(plid) || plid == INVALID_PLAYER_ID)
			{
			    SCM(playerid, COLOR_GREY, " Игрок оффлайн!");
			    ShowPlayerDialog(playerid, 2230, DIALOG_STYLE_INPUT, "Взять интервью", "Введите ид игрока для начала интервью", "Далее", "Назад");
				return true;
			}
			if (GetDistanceBetweenPlayers(playerid, plid) > 5)
		 	{
			 	SCM(playerid, COLOR_GREY, " Игрок слишком далеко!");
			 	ShowPlayerDialog(playerid, 2230, DIALOG_STYLE_INPUT, "Взять интервью", "Введите ид игрока для начала интервью", "Далее", "Назад");
				return true;
		 	}
		 	switch(PTEMP[playerid][pMember])
		 	{
		 	    case 9: TalkingLive[plid] = 2;
		 	    case 16:TalkingLivels[plid] = 2;
		 	    case 20:TalkingLivelv[plid] = 2;
    		}
    		SCM(playerid, -1, " Он вошёл в прямой эфир");
    		SCM(plid, -1, " Вы вошли в прямой эфир");
    		CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
    		return true;
		}
	case 2231:
	    {
	        if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
			if(strlen(inputtext) == 0) return ShowPlayerDialog(playerid, 2231, DIALOG_STYLE_INPUT, "Завершить интервью", "Введите ид игрока для завершения интвервью", "Далее", "Назад");
			new plid = strval(inputtext);
			if(!IsPlayerConnected(plid) || plid == INVALID_PLAYER_ID)
			{
			    SCM(playerid, COLOR_GREY, " Игрок оффлайн!");
			    ShowPlayerDialog(playerid, 2231, DIALOG_STYLE_INPUT, "Завершить интервью", "Введите ид игрока для завершения интвервью", "Далее", "Назад");
				return true;
			}
			if (GetDistanceBetweenPlayers(playerid, plid) > 5)
		 	{
			 	SCM(playerid, COLOR_GREY, " Игрок слишком далеко!");
			 	ShowPlayerDialog(playerid, 2231, DIALOG_STYLE_INPUT, "Завершить интервью", "Введите ид игрока для завершения интвервью", "Далее", "Назад");
				return true;
		 	}
		 	switch(PTEMP[playerid][pMember])
		 	{
		 	    case 9: TalkingLive[plid] = 255;
		 	    case 16:TalkingLivels[plid] = 255;
		 	    case 20:TalkingLivelv[plid] = 255;
    		}
    		SCM(playerid, -1, " Он вышёл из прямого эфира");
    		SCM(plid, -1, " Вы вышли из прямого эфира");
    		CallLocalFunction("OnPlayerCommandText", "is", playerid, "/n");
    		return true;
	    }
	case 8454:
	    {
	        if(!response) return true;
	        // LS News 9
	        TOTALADVERT[0]++;
	        new i = TOTALADVERT[0];
	        strmid(AdvertInfo[i][0][adName], PTEMP[playerid][pName], 0, 50, 50);
			AdvertInfo[i][0][adPhone] = PTEMP[playerid][pPnumber];
			strmid(AdvertInfo[i][0][adText], ReportQ[playerid], 0, 144, 144);
			AdvertInfo[i][0][edited] = false;
			SCM(playerid, -1, " Ваше объявление будет подано после проверки");
			format(YCMDstr,sizeof(YCMDstr)," Добавлено новое объявление от %s", Name(playerid));
			SendFamilyMessage(9,0xb953aa,YCMDstr);
			AdvertTime = gettime() + 15;
			format(string, sizeof(string), "~r~-$%i",(strlen(ReportQ[playerid])*addd[1]));
			GameTextForPlayer(playerid, string, 5000, 1);
			PTEMP[playerid][pCash] -= (strlen(ReportQ[playerid])*addd[1]);
	    }
   	case 8455:
	    {
	        if(!response) return true;
	        // SF News 16
	        TOTALADVERT[1]++;
	        new i = TOTALADVERT[1];
	        strmid(AdvertInfo[i][1][adName], PTEMP[playerid][pName], 0, 50, 50);
			AdvertInfo[i][1][adPhone] = PTEMP[playerid][pPnumber];
			strmid(AdvertInfo[i][1][adText], ReportQ[playerid], 0, 144, 144);
			AdvertInfo[i][1][edited] = false;
			SCM(playerid, -1, " Ваше объявление будет подано после проверки");
			format(YCMDstr,sizeof(YCMDstr)," Добавлено новое объявление от %s", Name(playerid));
			SendFamilyMessage(16,0xb953aa,YCMDstr);
			AdvertTime = gettime() + 15;
			format(string, sizeof(string), "~r~-$%i",(strlen(ReportQ[playerid])*addd[0]));
			GameTextForPlayer(playerid, string, 5000, 1);
			PTEMP[playerid][pCash] -= (strlen(ReportQ[playerid])*addd[0]);
	    }
    case 8456:
	    {
	        if(!response) return true;
	        // LV News 20
	        TOTALADVERT[2]++;
	        new i = TOTALADVERT[2];
	        strmid(AdvertInfo[i][2][adName], PTEMP[playerid][pName], 0, 50, 50);
			AdvertInfo[i][2][adPhone] = PTEMP[playerid][pPnumber];
			strmid(AdvertInfo[i][2][adText], ReportQ[playerid], 0, 144, 144);
			AdvertInfo[i][2][edited] = false;
			SCM(playerid, -1, " Ваше объявление будет подано после проверки");
			format(YCMDstr,sizeof(YCMDstr)," Добавлено новое объявление от %s", Name(playerid));
			SendFamilyMessage(20,0xb953aa,YCMDstr);
			AdvertTime = gettime() + 15;
			format(string, sizeof(string), "~r~-$%i",(strlen(ReportQ[playerid])*addd[2]));
			GameTextForPlayer(playerid, string, 5000, 1);
			PTEMP[playerid][pCash] -= (strlen(ReportQ[playerid])*addd[2]);
	    }
	case 10092:
    {
        if (!response) return true;
        useguns[playerid] = 1;
        ShowPlayerDialogEx(playerid, 10098, DIALOG_STYLE_LIST, "Список вакансий", " Таксист\n Водитель автобуса\n Продавец хот-догов\n Развозчик продуктов\n Механик\n Прораб\n Тренер\n Дальнобойщик", "Принять", "Отказ");
        return true;
    }
    case 10093:
    {
        if (!response) return true;
        {
            ShowPlayerDialogEx(playerid, 9000, DIALOG_STYLE_LIST, "Меню", "[0] LSPD [key:1]\n[1] LSPD-Тюрьма [key:2]\n[2] Мэрия [key:3]\n[3] Автовокзал ЛС [key:4]\n[4] ЛС-СФ Шоссе [key:5]\n[5] Автошкола [key:6]\n[6] ФБР [key:7]\n[7] Аэропорт СФ [key:8]\n[8] Аэропорт ЛС [key:9]\n[9] Военная база [key:10]\n[10] Цент Лас Вентурас [key:11]\n[11] Клуб Джизи [key:12]\n[12] Админ казино [key:13]\n[13] Вокзал ЛВ [key:14]\n[14] Аэро ЛС Въезд [key:15]\n[15] Вокзал СФ [key:16]\n[16] Авианосец стоянка [key:17]\n[17] Авианосец [key:18]\n>> След.страница", "Выбрать", "Назад");
        }
    }
	case 70:
		{
			if (!response) return true;
			for(new i = 1; i <= TotalHouse; i++)
			{
				if (PlayerToPoint(3, playerid,HouseInfo[i][hExitx], HouseInfo[i][hExity], HouseInfo[i][hExitz]))
				{
					if (GetPlayerVirtualWorld(playerid) == i+50)
					{
						SetPlayerInterior(playerid,0);
						SetPlayerVirtualWorld(playerid,0);
						SetPlayerPos(playerid,HouseInfo[i][hEntrancex],HouseInfo[i][hEntrancey],HouseInfo[i][hEntrancez]);
						return true;
					}
				}
			}
		}
	case 10022:
		{
			if(response)
			{
				format(string,300, "Ваш урок начат. Пройдите на парковку автошколы и сядьте в свободную машину.\nДалее вам будет показан маршрут, по котрому вы должны будете проехать\nЕсли во время экзамена автомобиль попадет в аварию, экзамен будет завершен");
				ShowPlayerDialogEx(playerid,10023,DIALOG_STYLE_MSGBOX, "Экзамен по вождению",string, "Готово", "Отмена");
			}
			else
			{
				return true;
			}
		}
	case 10023:
		{
			if(response)
			{
				if(PTEMP[playerid][pQuestL] == 1 && PTEMP[playerid][pQuest] == 2)
				{
					GameTextForPlayer(playerid, "~r~-$0", 5000, 1);
					LessonStat[playerid] = 0;
					LessonCar[playerid] = 1;
					TakingLesson[playerid] = 1;
					SetPlayerRaceCheckpoint(playerid, 1, -2077.2729,-92.4760,34.1641,-2077.2729,-92.4760,35.1641, 6.0);
					return true;
				}
				else
				{
					if(PTEMP[playerid][pCash] < 500) return SCM(playerid, COLOR_GREY, " Не достаточно денег!");
					GameTextForPlayer(playerid, "~r~-$500", 5000, 1);
					PTEMP[playerid][pCash]-= 500;
					LessonStat[playerid] = 0;
					LessonCar[playerid] = 1;
					TakingLesson[playerid] = 1;
					SetPlayerRaceCheckpoint(playerid, 1, -2077.2729,-92.4760,34.1641,-2077.2729,-92.4760,35.1641, 6.0);
					return true;
				}
			}
			else
			{
				return true;
			}
		}
	case 11516:
		{
			if(response)
			{
				taxiexpp[GetPVarInt(playerid, "Taxist")] ++;
				DeletePVar(playerid, "Taxist");
			}
			else
			{
				DeletePVar(playerid, "Taxist");
			}
		}
	case 8004:
		{
			if(response)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				switch(listitem)
				{
				case 0: ShowPlayerDialogEx(playerid, 8011, 2, "Список дисков", "Shadow\nMega\nWires\nClassic\nRimshine\nCutter\nTwist\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic", "OK", "Назад");
				case 1: AddVehicleComponent(vehicleid,1087), PlayerPlaySound(playerid,1133,0.0,0.0,0.0), ShowPlayerDialogEx(playerid, 8004, 2, "Тюнинг меню", "Диски\nГидравлика\nАрхангел Тюнинг\nЦвет\nВинилы ", "Выбрать", "Назад");
				case 2:
					{
						new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
						switch(Model)
						{
						case 559,560,561,562,565: ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "Выбрать", "Назад");
						default: SCM(playerid,-1, " Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus");
						}
					}
				case 3: ShowPlayerDialogEx(playerid, 8013, 2, "Выбор цвета", "Красный\nГолубой\nЖелтый\nЗеленый\nСерый\nОранжевый\nЧерный\nБелый", "Выбрать", "Назад");
				case 4: ShowPlayerDialogEx(playerid, 8014, 2, "Выбор винила", "Винил №1\nВинил №2\nВинил №3", "Выбрать", "Назад");
				case 5: ShowPlayerDialogEx(playerid, 8015, 2, "Выбор азота", "Азот 2X\nАзот 5X\nАзот 10X", "Выбрать", "Назад");
				}
			}
			else
			return true;
		}
	case 313:
		{
			new playa = GetPVarInt(playerid,"ID");
			if(response)
			{
				switch(listitem)
				{
				case 0:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 2)) RemovePlayerAttachedObject(playa, 2);
						SetPlayerAttachedObject(playa,2,19137,2,0.100000,0.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
						return 1;
					}
				case 1:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 7)) RemovePlayerAttachedObject(playa, 7);
						SetPlayerAttachedObject(playa,7, 19270, 2, 0.111052, 0.021643, -0.000846, 92.280899, 92.752510, 358.071044, 1.200000, 1.283168, 1.200000);
						return 1;
					}
				case 2:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 4)) RemovePlayerAttachedObject(playa, 4);
						SetPlayerAttachedObject(playa,4, 18646, 2, 0.111052, 0.021643, -0.000846, 92.280899, 92.752510, 358.071044, 1.200000, 1.283168, 1.200000);
						return 1;
					}
				case 3:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 7)) RemovePlayerAttachedObject(playa, 7);
						SetPlayerAttachedObject(playa,7, 19163, 2, 0.111052, 0.021643, -0.000846, 100.280899, 100.752510, 445.071044, 1.100000, 1.300000, 1.300000);
						return 1;
					}
				case 4:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 0)) RemovePlayerAttachedObject(playa, 0);
						SetPlayerAttachedObject(playa,0, 18915, 2, 0.1, 0.03, -0.005, 90.0, 180.0, 90.0);
						return 1;
					}
				case 5:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 0)) RemovePlayerAttachedObject(playa, 0);
						SetPlayerAttachedObject(playa,0, 18912, 2, 0.1, 0.03, -0.005, 90.0, 180.0, 90.0);
						return 1;
					}
				case 6:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 0)) RemovePlayerAttachedObject(playa, 0);
						SetPlayerAttachedObject(playa,0, 18916, 2, 0.1, 0.03, -0.005, 90.0, 180.0, 90.0);
						return 1;
					}
				case 7:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 0)) RemovePlayerAttachedObject(playa, 0);
						SetPlayerAttachedObject(playa,0, 18917, 2, 0.1, 0.03, -0.005, 90.0, 180.0, 90.0);
						return 1;
					}
				case 8:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 0)) RemovePlayerAttachedObject(playa, 0);
						SetPlayerAttachedObject(playa,0, 18918, 2, 0.1, 0.03, -0.005, 90.0, 180.0, 90.0);
						return 1;
					}
				case 9:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 4)) RemovePlayerAttachedObject(playa, 4);
						SetPlayerAttachedObject(playa,4, 3528, 2, 0.111052, 0.021643, -0.000846, 92.280899, 92.752510, 358.071044, 0.100000, 0.100000, 0.100000);
						return 1;
					}
				case 10:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 4)) RemovePlayerAttachedObject(playa, 4);
						SetPlayerAttachedObject(playa,4, 18643, 2, 0.111052, 0.021643, -0.000846, 92.280899, 92.752510, 358.071044, 1.200000, 1.283168, 1.200000);
						return 1;
					}
				case 11:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 0) || IsPlayerAttachedObjectSlotUsed(playa, 1) || IsPlayerAttachedObjectSlotUsed(playa, 4))
						{
							RemovePlayerAttachedObject(playa, 0);
							RemovePlayerAttachedObject(playa, 1);
							RemovePlayerAttachedObject(playa, 4);
						}
						SetPlayerAttachedObject(playa,0, 18693, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000);
						SetPlayerAttachedObject(playa,1, 18693, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000);
						SetPlayerAttachedObject(playa,4, 18965, 2, 0.111052, 0.021643, -0.000846, 92.280899, 92.752510, 358.071044, 1.200000, 1.283168, 1.200000);
						return 1;
					}
				case 12:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 7)) RemovePlayerAttachedObject(playa, 7);
						SetPlayerAttachedObject(playa,7, 19078, 1, 0.329150, -0.072101, 0.156082, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
						return 1;
					}
				case 13:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 7)) RemovePlayerAttachedObject(playa, 7);
						SetPlayerAttachedObject(playa,7, 354, 1, 0.329150, -0.072101, 0.156082, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
						return 1;
					}
				case 14:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 1)) RemovePlayerAttachedObject(playa, 1);
						SetPlayerAttachedObject(playa,1, 356, 6, 0.013610, -0.021393, -0.144862, 2.354303, 354.413848, 0.219168, 3.034477, 3.000000, 3.000000);
						return 1;
					}
				case 15:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 1)) RemovePlayerAttachedObject(playa, 1);
						SetPlayerAttachedObject(playa,1, 19086, 8, -0.049768, -0.014062, -0.108385, 87.458297, 263.478149, 184.123764, 0.622413, 1.041609, 1.012785);
						return 1;
					}
				case 16:
					{
						if(IsPlayerAttachedObjectSlotUsed(playa, 0)) RemovePlayerAttachedObject(playa, 0);
						SetPlayerAttachedObject(playa,0, 19078, 1, -1.097527, -0.348305, -0.008029, 0.000000, 0.000000, 0.000000, 8.073966, 8.073966, 8.073966);
						return 1;
					}
				case 17:
					{
						RemovePlayerAttachedObject(playa, 0);
						RemovePlayerAttachedObject(playa, 1);
						RemovePlayerAttachedObject(playa, 2);
						RemovePlayerAttachedObject(playa, 3);
						RemovePlayerAttachedObject(playa, 4);
						RemovePlayerAttachedObject(playa, 5);
						RemovePlayerAttachedObject(playa, 6);
						RemovePlayerAttachedObject(playa, 7);
						RemovePlayerAttachedObject(playa, 8);
						RemovePlayerAttachedObject(playa, 9);
						return 1;
					}
				}
			}
		}
	case 8011:
		{
			if(response)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				switch(listitem)
				{
				case 0: AddVehicleComponent(vehicleid,1073);
				case 1: AddVehicleComponent(vehicleid,1074);
				case 2: AddVehicleComponent(vehicleid,1076);
				case 3: AddVehicleComponent(vehicleid,1077);
				case 4: AddVehicleComponent(vehicleid,1075);
				case 5: AddVehicleComponent(vehicleid,1079);
				case 6: AddVehicleComponent(vehicleid,1078);
				case 7: AddVehicleComponent(vehicleid,1080);
				case 8: AddVehicleComponent(vehicleid,1081);
				case 9: AddVehicleComponent(vehicleid,1082);
				case 10: AddVehicleComponent(vehicleid,1083);
				case 11: AddVehicleComponent(vehicleid,1084);
				case 12: AddVehicleComponent(vehicleid,1085);
				}
				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialogEx(playerid, 8011, 2, "Список дисков", "Shadow\nMega\nWires\nClassic\nRimshine\nCutter\nTwist\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic", "OK", "Назад");
			}
			else ShowPlayerDialogEx(playerid, 8004, 2, "Тюнинг меню", "Диски \nГидравлика \nАрхангел Тюнинг \nЦвет \nВинилы ", "Выбрать", "Назад");
		}
	case 8013:
		{
			if(response)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				switch(listitem)
				{
				case 0: ChangeVehicleColor(vehicleid, 3, 3);
				case 1: ChangeVehicleColor(vehicleid, 79, 79);
				case 2: ChangeVehicleColor(vehicleid, 65, 65);
				case 3: ChangeVehicleColor(vehicleid, 86, 86);
				case 4: ChangeVehicleColor(vehicleid, 9, 9);
				case 5: ChangeVehicleColor(vehicleid, 6, 6);
				case 6: ChangeVehicleColor(vehicleid, 0, 0);
				case 7: ChangeVehicleColor(vehicleid, 1, 1);
				}
				PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
				ShowPlayerDialogEx(playerid, 8013, 2, "Выбор цвета", "Красный \nГолубой \nЖелтый \nЗеленый \nСерый \nОранжевый \nЧерный \nБелый", "Готово", "Назад");
			}
			else ShowPlayerDialogEx(playerid, 8004, 2, "Тюнинг меню", "Диски \nГидравлика \nАрхангел Тюнинг \nЦвет \nВинилы ", "Выбрать", "Назад");
		}
	case 8015:
		{
			if(response)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				switch(listitem)
				{
				case 0:
					{
						AddVehicleComponent(vehicleid,1008);
						ShowPlayerDialogEx(playerid, 8015, 2, "Выбор винила", "Азот 2X \nАзот 5X \nАзот 10X ", "Готово", "Назад");
					}
				case 1:
					{
						AddVehicleComponent(vehicleid,1009);
						ShowPlayerDialogEx(playerid, 8015, 2, "Выбор винила", "Азот 2X \nАзот 5X \nАзот 10X ", "Готово", "Назад");
					}
				case 2:
					{
						AddVehicleComponent(vehicleid,1010);
						ShowPlayerDialogEx(playerid, 8015, 2, "Выбор винила", "Азот 2X \nАзот 5X \nАзот 10X ", "Готово", "Назад");
					}
				}
			}
			else ShowPlayerDialogEx(playerid, 8004, 2, "Тюнинг меню", "Диски \nГидравлика \nАрхангел Тюнинг \nЦвет \nВинилы \nАзот", "Выбрать", "Назад");
		}
	case 8014:
		{
			if(response)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				ChangeVehiclePaintjob(vehicleid,listitem+1);
				PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
				ShowPlayerDialogEx(playerid, 8014, 2, "Выбор винила", "Винил №1 \nВинил №2 \nВинил №3 ", "Готово", "Назад");
			}
			else ShowPlayerDialogEx(playerid, 8004, 2, "Тюнинг меню", "Диски \nГидравлика \nАрхангел Тюнинг \nЦвет \nВинилы ", "Выбрать", "Назад");
		}
	case 8012:
		{
			if(response)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);
				switch(listitem)
				{
				case 0:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1172);
						case 560: AddVehicleComponent(vehicleid,1170);
						case 565: AddVehicleComponent(vehicleid,1152);
						case 559: AddVehicleComponent(vehicleid,1173);
						case 561: AddVehicleComponent(vehicleid,1157);
						case 558: AddVehicleComponent(vehicleid,1165);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 1:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1171);
						case 560: AddVehicleComponent(vehicleid,1169);
						case 565: AddVehicleComponent(vehicleid,1153);
						case 559: AddVehicleComponent(vehicleid,1160);
						case 561: AddVehicleComponent(vehicleid,1155);
						case 558: AddVehicleComponent(vehicleid,1166);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 2:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1148);
						case 560: AddVehicleComponent(vehicleid,1140);
						case 565: AddVehicleComponent(vehicleid,1151);
						case 559: AddVehicleComponent(vehicleid,1161);
						case 561: AddVehicleComponent(vehicleid,1156);
						case 558: AddVehicleComponent(vehicleid,1167);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 3:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1149);
						case 560: AddVehicleComponent(vehicleid,1141);
						case 565: AddVehicleComponent(vehicleid,1150);
						case 559: AddVehicleComponent(vehicleid,1159);
						case 561: AddVehicleComponent(vehicleid,1154);
						case 558: AddVehicleComponent(vehicleid,1168);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 4:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1146);
						case 560: AddVehicleComponent(vehicleid,1139);
						case 565: AddVehicleComponent(vehicleid,1050);
						case 559: AddVehicleComponent(vehicleid,1158);
						case 561: AddVehicleComponent(vehicleid,1160);
						case 558: AddVehicleComponent(vehicleid,1163);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 5:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1147);
						case 560: AddVehicleComponent(vehicleid,1138);
						case 565: AddVehicleComponent(vehicleid,1049);
						case 559: AddVehicleComponent(vehicleid,1162);
						case 561: AddVehicleComponent(vehicleid,1058);
						case 558: AddVehicleComponent(vehicleid,1164);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 6:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1041), AddVehicleComponent(vehicleid,1039);
						case 560: AddVehicleComponent(vehicleid,1031), AddVehicleComponent(vehicleid,1030);
						case 565: AddVehicleComponent(vehicleid,1052), AddVehicleComponent(vehicleid,1048);
						case 559: AddVehicleComponent(vehicleid,1070), AddVehicleComponent(vehicleid,1072);
						case 561: AddVehicleComponent(vehicleid,1057), AddVehicleComponent(vehicleid,1063);
						case 558: AddVehicleComponent(vehicleid,1093), AddVehicleComponent(vehicleid,1095);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 7:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1036), AddVehicleComponent(vehicleid,1040);
						case 560: AddVehicleComponent(vehicleid,1026), AddVehicleComponent(vehicleid,1027);
						case 565: AddVehicleComponent(vehicleid,1051), AddVehicleComponent(vehicleid,1047);
						case 559: AddVehicleComponent(vehicleid,1069), AddVehicleComponent(vehicleid,1071);
						case 561: AddVehicleComponent(vehicleid,1056), AddVehicleComponent(vehicleid,1062);
						case 558: AddVehicleComponent(vehicleid,1090), AddVehicleComponent(vehicleid,1094);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 8:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1035);
						case 560: AddVehicleComponent(vehicleid,1033);
						case 565: AddVehicleComponent(vehicleid,1052);
						case 559: AddVehicleComponent(vehicleid,1068);
						case 561: AddVehicleComponent(vehicleid,1061);
						case 558: AddVehicleComponent(vehicleid,1091);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 9:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1038);
						case 560: AddVehicleComponent(vehicleid,1032);
						case 565: AddVehicleComponent(vehicleid,1054);
						case 559: AddVehicleComponent(vehicleid,1067);
						case 561: AddVehicleComponent(vehicleid,1055);
						case 558: AddVehicleComponent(vehicleid,1088);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 10:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1037);
						case 560: AddVehicleComponent(vehicleid,1029);
						case 565: AddVehicleComponent(vehicleid,1045);
						case 559: AddVehicleComponent(vehicleid,1066);
						case 561: AddVehicleComponent(vehicleid,1059);
						case 558: AddVehicleComponent(vehicleid,1089);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				case 11:
					{
						switch(cartype)
						{
						case 562: AddVehicleComponent(vehicleid,1034);
						case 560: AddVehicleComponent(vehicleid,1028);
						case 565: AddVehicleComponent(vehicleid,1046);
						case 559: AddVehicleComponent(vehicleid,1065);
						case 561: AddVehicleComponent(vehicleid,1064);
						case 558: AddVehicleComponent(vehicleid,1092);
						}
						PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
						ShowPlayerDialogEx(playerid, 8012, 2, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
					}
				}
			}
			else ShowPlayerDialogEx(playerid, 8004, 2, "Тюнинг меню", "Диски\nГидравлика\nАрхангел Тюнинг\nЦвет\nВинилы", "Выбрать", "Назад");
			return true;
		}
	case 555:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					ShowPlayerDialogEx(playerid, 556, DIALOG_STYLE_INPUT, "Выдать водительские права", "Введите ID того, кому вы хотите выдать лицензию", "Выдать", "Отмена");
					return false;
				}
			case 1:
				{
					ShowPlayerDialogEx(playerid, 557, DIALOG_STYLE_INPUT, "Выдать лицензию на полёты", "Введите ID того, кому вы хотите выдать лицензию", "Выдать", "Отмена");
					return false;
				}
			case 2:
				{
					ShowPlayerDialogEx(playerid, 558, DIALOG_STYLE_INPUT, "Выдать лицензию на рыболовлю", "Введите ID того, кому вы хотите выдать лицензию", "Выдать", "Отмена");
					return false;
				}
			case 3:
				{
					ShowPlayerDialogEx(playerid, 559, DIALOG_STYLE_INPUT, "Выдать лицензию на вождение водного транспорта", "Введите ID того, кому вы хотите выдать лицензию", "Выдать", "Отмена");
					return false;
				}
			case 4:
				{
					ShowPlayerDialogEx(playerid, 561, DIALOG_STYLE_INPUT, "Выдать комплект всех лицензий", "Введите ID того, кому вы хотите выдать лицензию", "Выдать", "Отмена");
					return false;
				}
			case 5:
				{
					ShowPlayerDialogEx(playerid, 560, DIALOG_STYLE_INPUT, "Выдать лицензию на оружие", "Введите ID того, кому вы хотите выдать лицензию", "Выдать", "Отмена");
					return false;
				}
			case 6:
				{
					ShowPlayerDialogEx(playerid, 562, DIALOG_STYLE_INPUT, "Выдать лицензию на бизнес", "Введите ID того, кому вы хотите выдать лицензию", "Выдать", "Отмена");
					return false;
				}
			}
		}
	case 556:
		{
			if(!response) return true;
			new idd = strval(inputtext);
			if(idd == INVALID_PLAYER_ID)
			{
				SCM(playerid, COLOR_GREY, " Такого игрока нет на сервере!");
				return true;
			}
			if(PTEMP[idd][pCarLic] == 1)
			{
				SCM(playerid, COLOR_GREY, " У этого игрока есть права!");
				return true;
			}
			format(string, 128, " Вы выдали права %s[%i].",Name(idd), idd);
			SCM(playerid, COLOR_BLUE, string);
			PTEMP[idd][pCarLic] = 1;
			SendMes(idd, COLOR_BLUE, " %s Выдал вам водительские права",Name(playerid));
		}
	case 557:
		{
			if(!response) return true;
			new idd = strval(inputtext);
			if(idd == INVALID_PLAYER_ID)
			{
				SCM(playerid, COLOR_GREY, " Такого игрока нет на сервере!");
				return true;
			}
			if(PTEMP[idd][pFlyLic] == 1)
			{
				SCM(playerid, COLOR_GREY,  "У этого игрока есть лицензия на полёты!");
				return true;
			}
			format(string, 128, " Вы выдали лицензию на полёты %s[%i].",Name(idd), idd);
			SCM(playerid, COLOR_BLUE, string);
			PTEMP[idd][pFlyLic] = 1;
			SendMes(idd, COLOR_BLUE, " %s Выдал вам лицензию на полёты",Name(playerid));
		}
	case 558:
		{
			if(!response) return true;
			new idd = strval(inputtext);
			if(idd == INVALID_PLAYER_ID)
			{
				SCM(playerid, COLOR_GREY, " Такого игрока нет на сервере!");
				return true;
			}
			if(PTEMP[idd][pFishLic] == 1)
			{
				SCM(playerid, COLOR_GREY, " У этого игрока есть разрешение на рыболовство!");
				return true;
			}
			format(string, 128, " Вы выдали лицензию на рыболовлю %s[%i].",Name(idd), idd);
			SCM(playerid, COLOR_BLUE, string);
			PTEMP[idd][pFishLic] = 1;
			SendMes(idd, COLOR_BLUE, " %s Выдал вам разрешение на рыболовство.",Name(playerid));
		}
	case 559:
		{
			if(!response) return true;
			new idd = strval(inputtext);
			if(idd == INVALID_PLAYER_ID)
			{
				SCM(playerid, COLOR_GREY, " Такого игрока нет на сервере!");
				return true;
			}
			if(PTEMP[idd][pBoatLic] == 1)
			{
				SCM(playerid, COLOR_GREY, " У этого игрока есть лицензия на лодку!");
				return true;
			}
			format(string, 128, " Вы выдали лицензию на лодку %s[%i].",Name(idd), idd);
			SCM(playerid, COLOR_BLUE, string);
			PTEMP[idd][pBoatLic] = 1;
			SendMes(idd, COLOR_BLUE, " %s Выдал вам лицензию на морской транспорт",Name(playerid));
		}
	case 560:
		{
			if(!response) return true;
			new idd = strval(inputtext);
			if(idd == INVALID_PLAYER_ID)
			{
				SCM(playerid, COLOR_GREY, " Такого игрока нет на сервере!");
				return true;
			}
			if(PTEMP[idd][pGunLic] == 1)
			{
				SCM(playerid, COLOR_GREY, " У этого игрока есть лицензия на оружие!");
				return true;
			}
			format(string, 128, " Вы выдали лицензию на оружие %s[%i].",Name(idd), idd);
			SCM(playerid, COLOR_BLUE, string);
			PTEMP[idd][pGunLic] = 1;
			SendMes(idd, COLOR_BLUE, " %s Выдал вам лицензию на оружие",Name(playerid));
		}
	case 561:
		{
			if(!response) return true;
			new idd = strval(inputtext);
			if(idd == INVALID_PLAYER_ID)
			{
				SCM(playerid, COLOR_GREY, " Такого игрока нет на сервере!");
				return true;
			}
			format(string, 128, " Вы выдали все лицензии игроку %s[%i].",Name(idd), idd);
			SCM(playerid, COLOR_BLUE, string);
			PTEMP[idd][pCarLic] = 1;
			PTEMP[idd][pFishLic] = 1;
			PTEMP[idd][pBoatLic] = 1;
			PTEMP[idd][pFlyLic] = 1;
			PTEMP[idd][pGunLic] = 1;
			PTEMP[idd][pBizLic] = 1;
			SendMes(idd, COLOR_BLUE, " %s Выдал вам комплект всех лицензий",Name(playerid));
		}
	case 562:
		{
			if(!response) return true;
			new idd = strval(inputtext);
			if(idd == INVALID_PLAYER_ID)
			{
				SCM(playerid, COLOR_GREY, " Такого игрока нет на сервере!");
				return true;
			}
			if(PTEMP[idd][pBizLic] == 1)
			{
				SCM(playerid, COLOR_GREY, " У этого игрока есть лицензия на бизнес!");
				return true;
			}
			format(string, 128, " Вы выдали лицензию на бизнес %s[%i].",Name(idd), idd);
			SCM(playerid, COLOR_BLUE, string);
			PTEMP[idd][pBizLic] = 1;
			SendMes(idd, COLOR_LIGHTBLUE, " %s Выдал вам лицензию на бизнес",Name(playerid));
		}
	case 10098:
	{
		if (!response) return useguns[playerid] = 0;
		useguns[playerid] = 0;
		if (PTEMP[playerid][pMember] != 0 && GetPVarInt(playerid, "Fraction_Duty")) return SCM(playerid, COLOR_GRAD1, " Вы состоите в организации!");
		switch (listitem){
        case 0:
		{
			PTEMP[playerid][pJob] = 4;
			SCM(playerid, 0x6495EDFF, " Вы приняты на работу в такси.");
            SCM(playerid, 0x6495EDFF, " (( Команды: /fare - начать рабочий день ))");
			return true;
		}
		case 1:
		{
			PTEMP[playerid][pJob] = 1;
			SCM(playerid, 0x6495EDFF, " Вы приняты на работу водителем автобуса.");
			SCM(playerid, 0x6495EDFF, " (( Команды: /route - закончить работу водителя автобуса ))");
		}
		case 2:
		{
			PTEMP[playerid][pJob] = 3;
			SCM(playerid, 0x6495EDFF, " Вы приняты на работу продавцом хот-догов.");
			SCM(playerid, 0x6495EDFF, " (( Используйте /gps чтобы найти стоянку машин хот-догов ))");
			SCM(playerid, 0x6495EDFF, " (( Команды: /hcontract - подписать контракт с закусочной,  /selleat - продать хот дог ))");
			SCM(playerid, 0x6495EDFF, " (( Команды: /hcounter - начать работу за прилавком на вокзале ))");
			SCM(playerid, 0x6495EDFF, " (( Чтобы подписать контракт с закусочной, подойдите ко входу Burger, Pizza, Cluc и введите команду /hcontract ))");
		}
		case 3:
		{
			PTEMP[playerid][pJob] = 5;
			if (PTEMP[playerid][pPSkill] == 0) PTEMP[playerid][pPSkill] = 1;
			if (PTEMP[playerid][pPSkill] == 1) PTEMP[playerid][pPMGruz] = 200;
			SCM(playerid, 0x6495EDFF, " Вы приняты на работу развозчиком продуктов.");
			SCM(playerid, 0x6495EDFF, " (( Команды: /prodmenu ))");
			return true;
		}
		case 4:
		{
			PTEMP[playerid][pJob] = 2;
			SCM(playerid, 0x6495EDFF, " Вы приняты на работу автомехаником.");
			SCM(playerid, 0x6495EDFF, " (( Команды: /refill - заправить, /repair - починить, /fillGarage, /mcontract - подписать контракт с Бензозаправкой ))");
			return true;
		}
		case 5:
		{
			PTEMP[playerid][pJob] = 9;
			SCM(playerid, 0x6495EDFF, " Вы приняты на работу прорабом.");
			SCM(playerid, 0x6495EDFF, " (( Ваш заработок зависит от того сколько у вас рабочих, и как они работают ))");
			SCM(playerid, 0x6495EDFF, " (( За 1 ящик, перетащенный рабочим, вы получаете 25 вирт ))");
			SCM(playerid, 0x6495EDFF, " (( Команды: /gcontract - предложить работу, /getpayday - получения прибыли с рабочего ))");
			return true;
		}
		case 6:
		{
			PTEMP[playerid][pJob] = 6;
			SCM(playerid, 0x6495EDFF, " Вы приняты на работу тренером.");
			SCM(playerid, 0x6495EDFF, " (( Команды: /fgstyle - обучение стилям боя ))");
			return true;
		}
		case 7:
		{
			PTEMP[playerid][pJob] = 99;
			if (PTEMP[playerid][pDLevel] == 1) PTEMP[playerid][pDMgruz] = 7;
			SCM(playerid, 0x6495EDFF, " Вы приняты на работу водителем по перевозке грузов.");
			SCM(playerid, 0x6495EDFF, " Чтобы начать работы, езжайте на стоянку аренды машин (( /gps ))");
			SCM(playerid, 0x6495EDFF, " (( Команды: /truck ))");
			return true;
		}}
	}
	case 1010:
		{
			if (!response) return true;
			SCM(playerid, COLOR_BLUE, " Рабочий день начат");
			SetPlayerSkin(playerid, PTEMP[playerid][pModel]);
			SetPlayerToTeamColor(playerid);
			SetPVarInt(playerid,"Fraction_Duty",1);
			SpawnPlayer(playerid);
			return true;
		}
	case 1011:
	{
		if (!response) return true;
		if (!listitem)
		{
			SCM(playerid, COLOR_BLUE, " Рабочий день окончен");
			SetPlayerSkin(playerid, PTEMP[playerid][pChar][0]);
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
			DeletePVar(playerid, "Fraction_Duty");
			SetPlayerArmourAC(playerid, 0);
			ResetPlayerWeaponsEx(playerid);
			Update3DTextLabelText(LabelRank[playerid], TEAM_GROVE_COLOR, "");
		}
		else if (listitem == 1)
		{
			SCM(playerid, COLOR_RED, " Используйте клавишу 'Быстрый бег' (пробел по умолчанию)");
			SCM(playerid, COLOR_RED, " Используйте клавишу 'Вверх, вниз' (W, S по умолчанию)");

			SetPVarInt(playerid, "player_frac_mo", 1);
			ShowMenuForPlayer(ChoseSkin[0], playerid);
			SetPlayerInterior(playerid, 5);
			OldSkin[playerid] = GetPlayerSkin(playerid);
			ChosenSkin[playerid] = OldSkin[playerid];

			SetPlayerVirtualWorld(playerid, 2+random(100));
			SetPlayerPos            (playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
			SetPlayerFacingAngle    (playerid, gInviteSpawns[3]                                      );
			SetPlayerCameraPos      (playerid, gInviteSpawns[0]+3, gInviteSpawns[1], gInviteSpawns[2]);
			SetPlayerCameraLookAt   (playerid, gInviteSpawns[0]  , gInviteSpawns[1], gInviteSpawns[2]);
			TogglePlayerControllable(playerid, 0);

			SelectChar[playerid]   = 255;
			SelectCharID[playerid] = PTEMP[playerid][pMember];
			SelectCharPlace[playerid] = 1;
		}
		return true;
	}
	case 5522:
		{
			if(!response) return true;
			new Float:tempheal;
			new sendername[MAX_PLAYER_NAME];
			new giveplayer[MAX_PLAYER_NAME];
			GetPlayerHealth(playerid,tempheal);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(HealOffer[playerid], giveplayer, sizeof(giveplayer));
			if(tempheal >= 100.0) return SCM(HealOffer[playerid], COLOR_GRAD1, " Этот человек здоров!");
			if(PTEMP[playerid][pCash] < HealPrice[playerid]) return SCM(HealOffer[playerid], COLOR_GREY, " У этого человека нет столько денег на руках!");
			PTEMP[HealOffer[playerid]][pCash] += HealPrice[playerid];
			PTEMP[playerid][pCash] -= HealPrice[playerid];
			PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			format(string, 64, "~g~+100hp~n~~r~-$%i", HealPrice[playerid]);
			GameTextForPlayer(playerid, string, 5000, 1);
			format(string, 64, "~g~+100hp~n~~g~+$%i", HealPrice[playerid]);
			GameTextForPlayer(HealOffer[playerid], string, 5000, 1);
			SetPlayerHealthAC(playerid, 100);
			PTEMP[playerid][pHP] = 100;
			startaddiction[playerid] = 0;
			PTEMP[playerid][pNarcoLomka] = 0;
			return true;
		}
	case 6622:
		{
			new sendername[MAX_PLAYER_NAME];
			new giveplayer[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(FreeOffer[playerid], giveplayer, sizeof(giveplayer));
			if(response)
			{
				if(PTEMP[playerid][pCash] < FreePrice[playerid])
				{
					SCM(FreeOffer[playerid], COLOR_GREY, " У этого человека нет столько денег на руках!");
					SCM(playerid, COLOR_GREY, " У вас нет столько денег!");
					return true;
				}
				PTEMP[FreeOffer[playerid]][pCash] += FreePrice[playerid];
				PTEMP[playerid][pCash] -= FreePrice[playerid];
				format(string, 144, " Адвокат %s выпустил вас за %i вирт!",giveplayer, FreePrice[playerid]);
				SCM(playerid, 0x6495EDFF,string);
				format(string, 144, " Вы выпустили %s за %i вирт!",sendername, FreePrice[playerid]);
				SCM(FreeOffer[playerid], 0x6495EDFF,string);
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid,1553.4962,-1675.2714,16.1953);
				SetPlayerFacingAngle(playerid, 95.0636);
				PTEMP[playerid][pJailTime] = 0;
				PTEMP[playerid][pMestoJail] = 0;
				format(string, 32, "~g~Freedom");
				PTEMP[playerid][pWantedLevel] = 0;
				SetPlayerWantedLevel(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				GameTextForPlayer(playerid, string, 5000, 1);
				return true;
			}
			else
			{
				if(PTEMP[playerid][pBank] < FreePrice[playerid])
				{
					SCM(FreeOffer[playerid], COLOR_GREY, " У этого человека нет столько денег в банке!");
					SCM(playerid, COLOR_GREY, " У Вас нет столько денег!");
					return true;
				}
				PTEMP[FreeOffer[playerid]][pCash] += FreePrice[playerid];
				PTEMP[playerid][pBank] -= FreePrice[playerid];
				format(string, 144, " Адвокат %s выпустил вас за %i вирт!",giveplayer, FreePrice[playerid]);
				SCM(playerid, 0x6495EDFF,string);
				format(string, 144, " Вы выпустили %s за %i вирт!",sendername, FreePrice[playerid]);
				SCM(FreeOffer[playerid], 0x6495EDFF,string);
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid,1553.4962,-1675.2714,16.1953);
				SetPlayerFacingAngle(playerid, 95.0636);
				PTEMP[playerid][pJailTime] = 0;
				PTEMP[playerid][pMestoJail] = 0;
				format(string, 32, "~g~Freedom");
				PTEMP[playerid][pWantedLevel] = 0;
				SetPlayerWantedLevel(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				GameTextForPlayer(playerid, string, 5000, 1);
				return true;
			}
		}
	case 9500:
		{
			if(!response) DeletePVar(playerid,"Licenses");
			if(GetPVarInt(playerid,"Licenses") == 1)
			{
				if(PTEMP[playerid][pCash] < 500) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
				PTEMP[playerid][pCash]-=GetPVarInt(playerid,"MoneyLicenses");
				PTEMP[GetPVarInt(playerid,"PlayerSell")][pPayCheck]+=GetPVarInt(playerid,"MoneyLicenses")/70;
				format(string, 144, "Игрок %s приобрел водительские права. Сумма добавлена к зарплате.",PTEMP[playerid][pName]);
				SCM(GetPVarInt(playerid,"PlayerSell"), 0x6495EDFF, string);
				PTEMP[playerid][pCarLic] = 1;
				SCM(playerid, 0x6495EDFF, "Вы успешно приобрели водительские права.");
				foreach(i)
				{
					if(PTEMP[i][pMember] == 11)
					{
						if(PTEMP[i][pRank] == 8) PTEMP[i][pPayCheck]+=GetPVarInt(playerid,"MoneyLicenses")/95;
						else if(PTEMP[i][pRank] == 9) PTEMP[i][pPayCheck]+=GetPVarInt(playerid,"MoneyLicenses")/92;
						else if(PTEMP[i][pRank] == 10) PTEMP[i][pPayCheck]+=GetPVarInt(playerid,"MoneyLicenses")/90;
					}
				}
			}
			else if(GetPVarInt(playerid,"Licenses") == 2)
			{
				if(PTEMP[playerid][pCash] < 10000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
				PTEMP[playerid][pCash]-=10000;
				PTEMP[GetPVarInt(playerid,"PlayerSell")][pPayCheck]+=10000/70;
				format(string, 144, "Игрок %s приобрел лицензию на воздушный траспорт. Сумма добавлена к зарплате.",PTEMP[playerid][pName]);
				SCM(GetPVarInt(playerid,"PlayerSell"), 0x6495EDFF, string);
				PTEMP[playerid][pFlyLic] = 1;
				SCM(playerid, 0x6495EDFF, "Вы успешно приобрели лицензию.");
				foreach(i)
				{
					if(PTEMP[i][pMember] == 11)
					{
						if(PTEMP[i][pRank] == 8) PTEMP[i][pPayCheck]+=10000/95;
						else if(PTEMP[i][pRank] == 9) PTEMP[i][pPayCheck]+=10000/92;
						else if(PTEMP[i][pRank] == 10) PTEMP[i][pPayCheck]+=10000/90;
					}
				}
			}
			else if(GetPVarInt(playerid,"Licenses") == 3)
			{
				if(PTEMP[playerid][pCash] < 2000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
				PTEMP[playerid][pCash]-=2000;
				PTEMP[GetPVarInt(playerid,"PlayerSell")][pPayCheck]+=2000/70;
				format(string, 144, "Игрок %s приобрел лицензию на рыболовство. Сумма добавлена к зарплате.",PTEMP[playerid][pName]);
				SCM(GetPVarInt(playerid,"PlayerSell"), 0x6495EDFF, string);
				PTEMP[playerid][pFishLic] = 1;
				SCM(playerid, 0x6495EDFF, "Вы успешно приобрели лицензию.");
				foreach(i)
				{
					if(PTEMP[i][pMember] == 11)
					{
						if(PTEMP[i][pRank] == 8) PTEMP[i][pPayCheck]+=2000/95;
						else if(PTEMP[i][pRank] == 9) PTEMP[i][pPayCheck]+=2000/92;
						else if(PTEMP[i][pRank] == 10) PTEMP[i][pPayCheck]+=2000/90;
					}
				}
			}
			else if(GetPVarInt(playerid,"Licenses") == 4)
			{
				if(PTEMP[playerid][pCash] < 5000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
				PTEMP[playerid][pCash]-=5000;
				PTEMP[GetPVarInt(playerid,"PlayerSell")][pPayCheck]+=5000/70;
				format(string, 144, "Игрок %s приобрел лицензию на морской траспорт. Сумма добавлена к зарплате.",PTEMP[playerid][pName]);
				SCM(GetPVarInt(playerid,"PlayerSell"), 0x6495EDFF, string);
				PTEMP[playerid][pBoatLic] = 1;
				SCM(playerid, 0x6495EDFF, "Вы успешно приобрели лицензию.");
				foreach(i)
				{
					if(PTEMP[i][pMember] == 11)
					{
						if(PTEMP[i][pRank] == 8) PTEMP[i][pPayCheck]+=5000/95;
						else if(PTEMP[i][pRank] == 9) PTEMP[i][pPayCheck]+=5000/92;
						else if(PTEMP[i][pRank] == 10) PTEMP[i][pPayCheck]+=5000/90;
					}
				}
			}
			else if(GetPVarInt(playerid,"Licenses") == 5)
			{
				if(PTEMP[playerid][pCash] < 50000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
				PTEMP[playerid][pCash]-=50000;
				PTEMP[GetPVarInt(playerid,"PlayerSell")][pPayCheck]+=50000/70;
				format(string, 144, "Игрок %s приобрел лицензию на оружие. Сумма добавлена к зарплате.",PTEMP[playerid][pName]);
				SCM(GetPVarInt(playerid,"PlayerSell"), 0x6495EDFF, string);
				PTEMP[playerid][pGunLic] = 1;
				SCM(playerid, 0x6495EDFF, "Вы успешно приобрели лицензию.");
				foreach(i)
				{
					if(PTEMP[i][pMember] == 11)
					{
						if(PTEMP[i][pRank] == 8) PTEMP[i][pPayCheck]+=50000/95;
						else if(PTEMP[i][pRank] == 9) PTEMP[i][pPayCheck]+=50000/92;
						else if(PTEMP[i][pRank] == 10) PTEMP[i][pPayCheck]+=50000/90;
					}
				}
			}
			else if(GetPVarInt(playerid,"Licenses") == 6)
			{
				if(PTEMP[playerid][pCash] < 100000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
				PTEMP[playerid][pCash]-=100000;
				PTEMP[GetPVarInt(playerid,"PlayerSell")][pPayCheck]+=100000/70;
				format(string, 144, "Игрок %s приобрел лицензию на открытие бизнеса. Сумма добавлена к зарплате.",PTEMP[playerid][pName]);
				SCM(GetPVarInt(playerid,"PlayerSell"), 0x6495EDFF, string);
				BizzInfo[PTEMP[playerid][pPBizzKey]][bLicense] = 1;
				SCM(playerid, 0x6495EDFF, "Вы успешно приобрели лицензию.");
				foreach(i)
				{
					if(PTEMP[i][pMember] == 11)
					{
						if(PTEMP[i][pRank] == 8) PTEMP[i][pPayCheck]+=100000/95;
						else if(PTEMP[i][pRank] == 9) PTEMP[i][pPayCheck]+=100000/92;
						else if(PTEMP[i][pRank] == 10) PTEMP[i][pPayCheck]+=100000/90;
					}
				}
			}
			DeletePVar(playerid,"PlayerSell");
			DeletePVar(playerid,"Licenses");
		}
	case 7777:
		{
			if(!response) return DeletePVar(ChosenPlayer[playerid],"PlayerSell");
			new string556[100];
			switch(listitem)
			{
			case 0:
				{
					//if(PTEMP[playerid][pCash] < 500) return SCM(playerid, COLOR_GREY, " У вас Недостаточно денег");
					if(PTEMP[ChosenPlayer[playerid]][pCarLic] == 1) return SCM(playerid, COLOR_GRAD1, " У данного игрока уже есть вод. права!");
					if(PTEMP[ChosenPlayer[playerid]][pLevel] <= 2) SetPVarInt(ChosenPlayer[playerid], "MoneyLicenses",500);
					else if(PTEMP[ChosenPlayer[playerid]][pLevel] <= 5) SetPVarInt(ChosenPlayer[playerid], "MoneyLicenses",5000);
					else if(PTEMP[ChosenPlayer[playerid]][pLevel] <= 15) SetPVarInt(ChosenPlayer[playerid], "MoneyLicenses",10000);
					else SetPVarInt(ChosenPlayer[playerid], "MoneyLicenses",30000);
					SetPVarInt(ChosenPlayer[playerid], "Licenses",1);
					format(string,256,"Инструктор %s предлагает вам купить водительские права за %i вирт\nВы согласны?",PTEMP[playerid][pName],GetPVarInt(ChosenPlayer[playerid], "MoneyLicenses"));
					ShowPlayerDialogEx(ChosenPlayer[playerid], 9500, DIALOG_STYLE_MSGBOX, "Продажа лицензий:",string, "Купить", "Отмена");
					return true;
				}
			case 1:
				{
					//if(PTEMP[playerid][pCash] < 10000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
					if(PTEMP[ChosenPlayer[playerid]][pFlyLic] == 1) return SCM(playerid, COLOR_GRAD1, " У данного игрока уже есть эта лицензия!");
					SetPVarInt(ChosenPlayer[playerid], "Licenses",2);
					format(string,256,"Инструктор %s предлагает вам купить лицензию на воздушный транспорт за 10000 вирт\nВы согласны?",PTEMP[playerid][pName]);
					ShowPlayerDialogEx(ChosenPlayer[playerid], 9500, DIALOG_STYLE_MSGBOX, "Продажа лицензий:",string, "Купить", "Отмена");
					return true;
				}
			case 2:
				{
					//if(PTEMP[playerid][pCash] < 2000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
					if(PTEMP[ChosenPlayer[playerid]][pFishLic] == 1) return SCM(playerid, COLOR_GRAD1, " У данного игрока уже есть эта лицензия!");
					SetPVarInt(ChosenPlayer[playerid], "Licenses",3);
					format(string,256,"Инструктор %s предлагает вам купить лицензию на раболовство за 2000 вирт\nВы согласны?",PTEMP[playerid][pName]);
					ShowPlayerDialogEx(ChosenPlayer[playerid], 9500, DIALOG_STYLE_MSGBOX, "Продажа лицензий:",string, "Купить", "Отмена");
				}
			case 3:
				{
					//if(PTEMP[playerid][pCash] < 5000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
					if(PTEMP[ChosenPlayer[playerid]][pBoatLic] == 1) return SCM(playerid, COLOR_GRAD1, " У данного игрока уже есть эта лицензия!");
					SetPVarInt(ChosenPlayer[playerid], "Licenses",4);
					format(string,256,"Инструктор %s предлагает вам купить лицензию на морской транспорт за 5000 вирт\nВы согласны?",PTEMP[playerid][pName]);
					ShowPlayerDialogEx(ChosenPlayer[playerid], 9500, DIALOG_STYLE_MSGBOX, "Продажа лицензий:",string, "Купить", "Отмена");
					return true;
				}
			case 4:
				{
					//if(PTEMP[playerid][pCash] < 50000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
					if(PTEMP[ChosenPlayer[playerid]][pGunLic] == 1) return	SCM(playerid, COLOR_GRAD1, " У данного игрока уже есть эта лицензия!");
					SetPVarInt(ChosenPlayer[playerid], "Licenses",5);
					format(string,256,"Инструктор %s предлагает вам купить лицензию на оружие за 50000 вирт\nВы согласны?",PTEMP[playerid][pName]);
					ShowPlayerDialogEx(ChosenPlayer[playerid], 9500, DIALOG_STYLE_MSGBOX, "Продажа лицензий:",string, "Купить", "Отмена");
					return true;
				}
			case 5:
				{
					//if(PTEMP[playerid][pCash] < 100000) return SCM(playerid, COLOR_GREY, " У вас недостаточно денег");
					if(!BGet(ChosenPlayer[playerid])) return	SCM(playerid, COLOR_GRAD1, " Игрок не имеет бизнеса!");
					SetPVarInt(ChosenPlayer[playerid], "Licenses",6);
					format(string,256,"Инструктор %s предлагает вам купить лицензию на открытие бизнеса за 100000 вирт\nВы согласны?",PTEMP[playerid][pName]);
					ShowPlayerDialogEx(ChosenPlayer[playerid], 9500, DIALOG_STYLE_MSGBOX, "Продажа лицензий:",string, "Купить", "Отмена");
					return true;
				}
			case 6:
				{
					if(TakingLesson[ChosenPlayer[playerid]] == 1) return SCM(playerid, COLOR_GRAD1, " Вы уже начинали с этим игроком урок!");
					format(string556, sizeof(string556), "Вы начали урок у %s.",Name(ChosenPlayer[playerid]));
					SCM(playerid, 0x6495EDFF, string556);
					TakingLesson[ChosenPlayer[playerid]] = 1;
					SCM(ChosenPlayer[playerid], 0x6495EDFF, "Инструктор начал с Вами урок по вождению");
					return true;
				}
			case 7:
				{
					if(TakingLesson[ChosenPlayer[playerid]] == 0) return SCM(playerid, COLOR_GRAD1, " Вы не начинали урок с этим игроком!");
					format(string556, sizeof(string556), "Вы завершили урок у %s.",Name(ChosenPlayer[playerid]));
					SCM(playerid, 0x6495EDFF, string556);
					TakingLesson[ChosenPlayer[playerid]] = 0;
					SCM(ChosenPlayer[playerid], 0x6495EDFF, "Инструктор завершил с Вами урок по вождению");
					return true;
				}
			}
		}
	case 7779:
		{
			if(!response) return true;
			new frisks[32];
			strmid(frisks, inputtext, 0, 1);
			new para1 = GetPVarInt(playerid, "FriskID"), frisking[128];
			switch(frisks[0])
			{
			    case 'A':
			    {
			        PTEMP[para1][pDrugs] = 0;
			        format(frisking, sizeof(frisking), " %s забрал у %s наркотики", Name(playerid), Name(para1));
			    }
			    case 'B':
			    {
			        PTEMP[para1][pMats] = 0;
			        format(frisking, sizeof(frisking), " %s забрал у %s материалы", Name(playerid), Name(para1));
			    }
				case 'F':
				{
					PTEMP[para1][pKeys] = 0;
			        format(frisking, sizeof(frisking), " %s забрал у %s ключи от камеры", Name(playerid), Name(para1));
				}
				case 'K':
				{
				    PTEMP[para1][pCarLic] = 0;
				    format(frisking, sizeof(frisking), " %s забрал у %s водительские права", Name(playerid), Name(para1));
				}
				case 'L':
				{
				    PTEMP[para1][pFlyLic] = 0;
				    format(frisking, sizeof(frisking), " %s забрал у %s лицензию на полёты", Name(playerid), Name(para1));
				}
				case 'M':
				{
					PTEMP[para1][pBoatLic] = 0;
				    format(frisking, sizeof(frisking), " %s забрал у %s лицензию на лодки", Name(playerid), Name(para1));
				}
				case 'N':
				{
					PTEMP[para1][pFishLic] = 0;
				    format(frisking, sizeof(frisking), " %s забрал у %s лицензию на рыболовлю", Name(playerid), Name(para1));
				}
				case 'O':
				{
				    PTEMP[para1][pGunLic] = 0;
				    format(frisking, sizeof(frisking), " %s забрал у %s лицензию на оружие", Name(playerid), Name(para1));
				}
				case 'P':
				{
				    DelGun(para1);
				    format(frisking, sizeof(frisking), " %s забрал у %s оружие", Name(playerid), Name(para1));
				}
			}
			if(strlen(frisking) > 0) ProxDetector(30.0, playerid, frisking, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			switch(frisks[0])
			{
			    case 'C':
				{
				    SCM(playerid, -1, " Вы не можете забрать это");
				}
				case 'D':
				{
					SCM(playerid, -1, " Вы не можете забрать это");
				}
				case 'E':
				{
					SCM(playerid, -1, " Вы не можете забрать это");
				}
				case 'J':
				{
					SCM(playerid, -1, " Вы не можете забрать это");
				}
			}
			new strs[32];
		 	new friskings[512];
		 	format(friskings, sizeof(friskings), "Key\tВещи\tКоличество\n");
			if(PTEMP[para1][pDrugs] > 0){
			    format(strs, sizeof(strs), "A\tНаркотики\t%i\n",PTEMP[para1][pDrugs]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	if(PTEMP[para1][pMats] > 0){
			    format(strs, sizeof(strs), "B\tМатериалы\t%i\n",PTEMP[para1][pMats]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	if(PTEMP[para1][pDirectory] == 1){
			    format(strs, sizeof(strs), "C\tТелефонная книга\t%i\n",PTEMP[para1][pDirectory]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		    format(strs, sizeof(strs), "D\tCD-Player\t%i\n",1);
			strcat(friskings, strs, sizeof(friskings));
			if(PTEMP[para1][pFishes] > 0.0){
			    format(strs, sizeof(strs), "E\tРыба\t%f\n",PTEMP[para1][pFishes]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	if(PTEMP[para1][pKeys] > 0){
			    format(strs, sizeof(strs), "F\tКлючи от камеры\t%i\n",PTEMP[para1][pKeys]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	if(PTEMP[para1][pMushrooms] > 0){
			    format(strs, sizeof(strs), "J\tГрибы\t%i\n",PTEMP[para1][pMushrooms]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	if(PTEMP[para1][pCarLic] == 1){
			    format(strs, sizeof(strs), "K\tВодительские права\t%i\n",PTEMP[para1][pCarLic]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	if(PTEMP[para1][pFlyLic] == 1){
			    format(strs, sizeof(strs), "L\tЛицензия пилота\t%i\n",PTEMP[para1][pFlyLic]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	if(PTEMP[para1][pBoatLic] == 1){
			    format(strs, sizeof(strs), "M\tЛицензия на лодки\t%i\n",PTEMP[para1][pBoatLic]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	if(PTEMP[para1][pFishLic] == 1){
			    format(strs, sizeof(strs), "N\tЛицензия на рыболовство\t%i\n",PTEMP[para1][pFishLic]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	if(PTEMP[para1][pGunLic] == 1){
			    format(strs, sizeof(strs), "O\tЛицензия на оружие\t%i\n",PTEMP[para1][pGunLic]);
				strcat(friskings, strs, sizeof(friskings));
		 	}
		 	new bool:label = false;
		 	for(new i = 0; i < 46; i++)
		 	    if(Weapons[para1][i] > 0)
					label = true;
			if(label){
				format(strs, sizeof(strs), "P\tОружие\t%i\n",1);
				strcat(friskings, strs, sizeof(friskings));
			}
			ShowPlayerDialogEx(playerid, 7779, DIALOG_STYLE_TABLIST_HEADERS, "Карманы", friskings, "Забрать", "Отмена");
		}
	case 9508:
	{
	    if(!response) return true;
		new playeridd;
		new st[32];
		sscanf(inputtext, "s[32]s[32]",st, inputtext);
		sscanf(inputtext, "p<[>s[32]s[32]", inputtext, st);
		sscanf(st, "p<]>is[32]", playeridd, inputtext);
		new job[24];
		if((PTEMP[playerid][pMember] == 21 || PTEMP[playerid][pMember] == 10 || PTEMP[playerid][pMember] == 1) && GetPVarInt(playerid,"Fraction_Duty"))
		{
			job = "cop";
		}
		else if(PTEMP[playerid][pMember] == 4 || PTEMP[playerid][pMember] == 22 && GetPVarInt(playerid,"Fraction_Duty"))
        {
			job = "medic";
        }
        else if(PTEMP[playerid][pJob] == 4 && GetPVarInt(playerid,"TaxiDuty"))
        {
			job = "taxi";
        }
        else if(PTEMP[playerid][pJob] == 2)
		{
			job = "mechanic";
		}
		format(string, sizeof(string), "/service ac %s %i", job, playeridd);
		CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
	}
	case 9956:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
				    CallLocalFunction("OnPlayerCommandText", "is", playerid, "/service call cop");
					//ShowPlayerDialogEx(playerid,9957,DIALOG_STYLE_INPUT,"Диспетчер",".\t\t\tОпишите где вы находитесь\t\t\t.","Готово","Отмена");
					return 1;
				}
			case 1:
				{
                    CallLocalFunction("OnPlayerCommandText", "is", playerid, "/service call medic");
					//ShowPlayerDialogEx(playerid,9958,DIALOG_STYLE_INPUT,"Диспетчер",".\t\t\tОпишите где вы находитесь\t\t\t.","Готово","Отмена");
					return 1;
				}
			case 2:
				{
				    CallLocalFunction("OnPlayerCommandText", "is", playerid, "/service call taxi");
					//ShowPlayerDialogEx(playerid,9959,DIALOG_STYLE_INPUT,"Диспетчер",".\t\t\tОпишите где вы находитесь\t\t\t.","Готово","Отмена");
					return 1;
				}
			case 3:
				{
					CallLocalFunction("OnPlayerCommandText", "is", playerid, "/service call mechanic");
					//ShowPlayerDialogEx(playerid,9960,DIALOG_STYLE_INPUT,"Диспетчер",".\t\t\tОпишите вашу ситуацию\t\t\t.","Готово","Отмена");
					return 1;
				}
			}
			CallLocalFunction("OnPlayerCommandText", "is", playerid, "/service call");
		}
	case 5454:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 5:
				{
					new giveplayer[MAX_PLAYER_NAME];
					SCM(playerid, 0xF10DEB10AA, " Адвокаты Online:");
					foreach(i)
					{
						if(PTEMP[i][pMember] == 7 && PTEMP[i][pRank] == 2 && PTEMP[i][pLogin] == 1)
						{
							GetPlayerName(i, giveplayer, sizeof(giveplayer));
							format(string, 256, " Адвокат: %s [тел: %i]", giveplayer, PTEMP[i][pPnumber]);
							SCM(playerid, 0xF999DEB9AA, string);
						}
					}
				}
			case 0:
				{
					new giveplayer[MAX_PLAYER_NAME];
					SCM(playerid, 0xF10DEB10AA, "Таксисты:");
					foreach(i)
					{
						if(PTEMP[i][pJob] != 4 || (!PTEMP[i][pLogin])) continue;
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, 256, "Таксист: %s [тел: %i]", giveplayer, PTEMP[i][pPnumber]);
						SCM(playerid, 0xF999DEB9AA, string);
					}
				}
			case 4:
				{
					if(IsPlayerConnected(playerid))
					{
						SCM(playerid, 0xF10DEB10AA, "Лидеры Online:");
						foreach(i)
						{
							if(PTEMP[i][pLeader]>0 && PTEMP[i][pLogin] == 1)
							{
								format(string, 144, " %s: %s [тел: %i]",GetFracName(PTEMP[i][pLeader]),Name(i),PTEMP[i][pPnumber]);
								SCM(playerid, 0xF99DEB9AA, string);
							}
						}
					}
				}
			case 6:
				{
					new giveplayer[MAX_PLAYER_NAME];
					SCM(playerid, 0xF10DEB10AA, "Развозчики продуктов:");
					foreach(i)
					{
						if(PTEMP[i][pJob] != 5) continue;
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, 256, " %s [тел: %i]", giveplayer, PTEMP[i][pPnumber]);
						SCM(playerid, 0xF999DEB9AA, string);
					}
				}
			case 1:
				{
					new giveplayer[MAX_PLAYER_NAME];
					SCM(playerid, 0xF10DEB10AA, "Механики:");
					foreach(i)
					{
						if(PTEMP[i][pJob] != 2) continue;
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, 256, " %s [тел: %i]", giveplayer, PTEMP[i][pPnumber]);
						SCM(playerid, 0xF999DEB9AA, string);
					}
				}
			case 2:
				{
					new giveplayer[MAX_PLAYER_NAME];
					SCM(playerid, 0xF10DEB10AA, "Прорабы:");
					foreach(i)
					{
						if(PTEMP[i][pJob] != 9) continue;
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, 256, " %s [тел: %i]", giveplayer, PTEMP[i][pPnumber]);
						SCM(playerid, 0xF999DEB9AA, string);
					}
				}
			case 3:
				{
					new giveplayer[MAX_PLAYER_NAME];
					SCM(playerid, 0xF10DEB10AA, "Медики:");
					foreach(i)
					{
						if(PTEMP[i][pMember] == 4 && PTEMP[i][pLogin] == 1 || PTEMP[i][pMember] == 22 && PTEMP[i][pLogin] == 1 || PTEMP[i][pMember] == 33 && PTEMP[i][pLogin] == 1)
						{
							GetPlayerName(i, giveplayer, sizeof(giveplayer));
							format(string, 256, " %s [тел: %i]", giveplayer, PTEMP[i][pPnumber]);
							SCM(playerid, 0xF999DEB9AA, string);
						}
					}
				}
			case 7:
				{
					new giveplayer[MAX_PLAYER_NAME];
					SCM(playerid, 0xF10DEB10AA, "Тренеры:");
					foreach(i)
					{
						if(PTEMP[i][pJob] != 6 || (!PTEMP[i][pLogin])) continue;
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, 256, " %s [тел: %i]", giveplayer, PTEMP[i][pPnumber]);
						SCM(playerid, 0xF999DEB9AA, string);
					}
				}
			}
		}
	case 8240:
		{
			if(response)
			{
				SetPlayerInterior(playerid,7);
				SetPlayerVirtualWorld(playerid, 15);
				SetPlayerPos(playerid,302.3128,-140.9305,1004.0625);
				SetPlayerFacingAngle(playerid, 318.5262);
				return true;
			}
			else
			{
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid,2278.3853,2460.9187,38.6837);
				SetPlayerFacingAngle(playerid, 357.9236);
				return true;
			}
		}
	case 8241:
		{
			if(response)
			{
				SetPlayerInterior(playerid,7);
				SetPlayerVirtualWorld(playerid, 15);
				SetPlayerPos(playerid,302.3128,-140.9305,1004.0625);
				SetPlayerFacingAngle(playerid, 318.5262);
				return true;
			}
			else
			{
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid,2294.0447,2468.8052,10.8203);
				SetPlayerFacingAngle(playerid, 90.8629);
				return true;
			}
		}
	case 2013:
		{
			if(!response) return true;
			new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
			ShowPlayerDialogEx(playerid, 2013, DIALOG_STYLE_LIST, "Взять оружие со склада", listitems, "Взять", "Отмена");
			switch(listitem)
			{
			case 0:
				{
					if(yakuzamats <= 50)return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 24; ammo = 50;
					yakuzamats -= 70;
				}
			case 1:
				{
					if(yakuzamats <= 50)return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 25; ammo = 15;
					yakuzamats -= 50;
				}
			case 2:
				{
					if(yakuzamats <= 50)return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 33; ammo = 10;
					yakuzamats -= 100;
				}
			case 3:
				{
					if(yakuzamats <= 50)return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 31; ammo = 100;
					yakuzamats -= 500;
				}
			case 4:
				{
					if(yakuzamats <= 50)return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 30; ammo = 100;
					yakuzamats -= 500;
				}
			case 5:
				{
					if(yakuzamats <= 50)return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 29; ammo = 200;
					yakuzamats -= 400;
				}
			case 6:
				{
					if(yakuzamats <= 50)return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 23; ammo = 100; yakuzamats -= 100;
				}
			}
			if(booston == 0) GiveWeapon(getgunsid[playerid], gun, ammo);
			else if(booston == 1) GiveWeapon(getgunsid[playerid], gun, ammo*3);
			SendMes(playerid, COLOR_BLUE," На складе осталось %i материалов",yakuzamats);
			if(getgunsid[playerid] == playerid) format(string, 144, " %s взял(а) оружие со склада",PTEMP[playerid][pName]);
			else format(string, 144, " %s взял(а) оружие со склада и передал %s",PTEMP[playerid][pName],Name(getgunsid[playerid]));
			ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			return true;
		}
	case 2014:
		{
			if(!response) return true;
			new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
			ShowPlayerDialogEx(playerid, 2014, DIALOG_STYLE_LIST, "Взять оружие со склада", listitems, "Взять", "Отмена");
			switch(listitem)
			{
			case 0:
				{
					if(lcnmats <= 50) return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 24; ammo = 50; lcnmats -= 70;
				}
			case 1:
				{
					if(lcnmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 25; ammo = 15; lcnmats -= 50;
				}
			case 2:
				{
					if(lcnmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 33; ammo = 10; lcnmats -= 100;
				}
			case 3:
				{
					if(lcnmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 31; ammo = 100; lcnmats -= 500;
				}
			case 4:
				{
					if(lcnmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 30; ammo = 100; lcnmats -= 500;
				}
			case 5:
				{
					if(lcnmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 29; ammo = 200; lcnmats -= 400;
				}
			case 6:
				{
					if(lcnmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 23; ammo = 100; lcnmats -= 100;
				}
			}
			if(booston == 0) GiveWeapon(getgunsid[playerid], gun, ammo);
			else if(booston == 1) GiveWeapon(getgunsid[playerid], gun, ammo*3);
			SendMes(playerid, COLOR_BLUE," На складе осталось %i материалов",lcnmats);
			if(getgunsid[playerid] == playerid) format(string, 144, " %s взял(а) оружие со склада",PTEMP[playerid][pName]);
			else format(string, 144, " %s взял(а) оружие со склада и передал %s",PTEMP[playerid][pName],Name(getgunsid[playerid]));
			ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			return true;
		}
	case 2015:
		{
			if(!response) return true;
			new listitems[] = " [1] Deagle\t[70 материалов/50 патронов]\n [2] Shotgun\t[50 материалов/15 патронов]\n [3] Rifle\t[100 материалов/10 патронов]\n [4] M4\t\t[500 материалов/100 патронов]\n [5] AK-47\t[500 материалов/100 патронов]\n [6] MP5\t[400 материалов/200 патронов]\n [7] SDPistol\t[100 материалов/100 патронов])";
			ShowPlayerDialogEx(playerid, 2015, DIALOG_STYLE_LIST, "Взять оружие со склада", listitems, "Взять", "Отмена");
			switch(listitem)
			{
			case 0:
				{
					if(rmmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 24; ammo = 50; rmmats -= 70;
				}
			case 1:
				{
					if(rmmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 25; ammo = 15; rmmats -= 50;
				}
			case 2:
				{
					if(rmmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 33; ammo = 10; rmmats -= 100;
				}
			case 3:
				{
					if(rmmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 31; ammo = 100; rmmats -= 500;
				}
			case 4:
				{
					if(rmmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 30; ammo = 100; rmmats -= 500;
				}
			case 5:
				{
					if(rmmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 29; ammo = 200; rmmats -= 400;
				}
			case 6:
				{
					if(rmmats <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 23; ammo = 100; rmmats -= 100;
				}
			}
			if(booston == 0) GiveWeapon(getgunsid[playerid], gun, ammo);
			else if(booston == 1) GiveWeapon(getgunsid[playerid], gun, ammo*3);
			SendMes(playerid, COLOR_BLUE," На складе осталось %i материалов",rmmats);
			if(getgunsid[playerid] == playerid) format(string, 144, " %s взял(а) оружие со склада",PTEMP[playerid][pName]);
			else format(string, 144, " %s взял(а) оружие со склада и передал %s",PTEMP[playerid][pName],Name(getgunsid[playerid]));
			ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			return true;
		}
	case 2017:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					if(hamcmatbi <= 50)  return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 24; ammo = 50; hamcmatbi -= 70;
				}
			case 1:
				{
					if(hamcmatbi <= 50)  return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 25; ammo = 15; hamcmatbi -= 50;
				}
			case 2:
				{
					if(hamcmatbi <= 50)  return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 33; ammo = 10; hamcmatbi -= 100;
				}
			case 3:
				{
					if(hamcmatbi <= 50)  return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 31; ammo = 100; hamcmatbi -= 500;
				}
			case 4:
				{
					if(hamcmatbi <= 50)  return SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 30; ammo = 100; hamcmatbi -= 500;
				}
			case 5:
				{
					if(hamcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 29; ammo = 200; hamcmatbi -= 400;
				}
			case 6:
				{
					if(hamcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
					gun = 23; ammo = 100; hamcmatbi -= 100;
				}
			}
			new sendername[MAX_PLAYER_NAME];
			GetWeaponName(gun, gunname, sizeof(gunname));
			if(booston == 0) GiveWeapon(playerid, gun, ammo);
			else if(booston == 1) GiveWeapon(playerid, gun, ammo*3);
			format(string, 100, " Вы взяли оружие со склада");
			SCM(playerid, COLOR_BLUE, string);
			GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, 144, " %s взял(а) оружие со склада", sendername);
			ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			return true;
		}
	case 8001:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:{ShowPlayerDialogEx(playerid, 8002, DIALOG_STYLE_LIST, "Важные", "[0] Мэрия\n[1] Банк\n[2] Автошкола\n[3] Автовокзал [LS]\n[4] ЖД вокзал [LS]\n[5] Fort Carson\n[6] Приём металла\n[7] Наркопритон\n[8] Аэропорт [LS]\n[9] Аэропорт [SF]\n[10] Аэропорт [LV]\n[11] Пляж Santa Maria\n[12] Спортзал [LV]\n[13] Пеинтбол\n[14] Церковь", "Выбрать", "Назад");}
			case 1:{ShowPlayerDialogEx(playerid, 8005, DIALOG_STYLE_LIST, "По работе", "[0] Склад с алкоголем\n[1] Нефтезавод\n[2] Склад продуктов\n[3] Склад для урожая с ферм\n[4] Автобусный парк\n[5] Стоянка машин Хот догов\n[6] Работа грузчика\n[7] Склад с наркотиками\n[8] Автоугонщики", "Выбрать", "Назад");}
			case 2:
				{
					new strrr[900];
					new count = 0;
					for(new h = 1; h <= TotalBizz; h++)
					{
						format(YCMDstr, sizeof(YCMDstr),"[%i] %s\n",count, BizzInfo[h][bMessage]), strcat(strrr, YCMDstr); count ++;
						if (strlen(strrr) > 1) ShowPlayerDialogEx(playerid, 8006, DIALOG_STYLE_LIST, "Бизнесы", strrr, "Выбрать", "Назад");
					}
				}
			case 3:{ShowPlayerDialogEx(playerid, 8007, DIALOG_STYLE_LIST, "Магазины", "[0] Автосалон: Nope\n[1] Автосалон: D and C\n[2] Автосалон: B and A\n[3] Магазин одежды [LS]\n[4] Магазин одежды [SF]\n[5] Оружейный магазин [LS]\n[6] Оружейный магазин [SF]\n[7] Оружейный магазин [LV]", "Выбрать", "Назад");}
			case 4:
				{
					new dialog[600];
					strcat(dialog,"[0] Мэрия\n");
					strcat(dialog,"[1] Автошкола\n");
					strcat(dialog,"[2] Медики [LS]\n");
					strcat(dialog,"[3] Медики [SF]\n");
					strcat(dialog,"[4] Медики [LV]\n");
					strcat(dialog,"[5] Полиция [LS]\n");
					strcat(dialog,"[6] Полиция [SF]\n");
					strcat(dialog,"[7] Полиция [LV]\n");
					strcat(dialog,"[8] ФБР\n");
					strcat(dialog,"[9] Военная база [Авианосец]\n");
					strcat(dialog,"[10] Военная база [Зона 51]\n");
					strcat(dialog,"[11] Новости [LS]\n");
					strcat(dialog,"[12] Новости [SF]\n");
					strcat(dialog,"[13] Новости [LV]\n");
					strcat(dialog,"[14] Особняк Yakuza\n");
					strcat(dialog,"[15] Особняк Русской мафии\n");
					strcat(dialog,"[16] Особняк La Coca Nostra\n");
					strcat(dialog,"[17] Район Grove Street\n");
					strcat(dialog,"[18] Район Vagos\n");
					strcat(dialog,"[19] Район Ballas\n");
					strcat(dialog,"[20] Район Rifa\n");
					strcat(dialog,"[21] Район Aztecas\n");
					return ShowPlayerDialogEx(playerid, 8028, DIALOG_STYLE_LIST, "Базы организаций", dialog, "Выбрать", "Назад");
				}
			case 5:{ShowPlayerDialogEx(playerid, 8029, DIALOG_STYLE_LIST, "Фермы", "[0] Ферма номер: 0\n[1] Ферма номер: 1\n[2] Ферма номер: 2\n[3] Ферма номер: 3\n[4] Ферма номер: 4", "Выбрать", "Назад");}
			case 6:{ShowPlayerDialogEx(playerid, 8031, DIALOG_STYLE_LIST, "Дальнобойщики", "[0] Порт ЛС\n[1] Порт СФ\n[2] Нефтезавод №1\n[3] Нефтезавод №2\n[4] Склад угля №1\n[5] Склад угля №1\n[6] Лесопилка №1\n[7] Лесопилка №2\n[8] Аренда машин", "Выбрать", "Назад");}
			case 7:{ShowPlayerDialogEx(playerid, 8030, DIALOG_STYLE_LIST, "Клубы байкеров", "[0] Hell's Angels MC\n[1] Pagans MC\n[2] Warlocks MC", "Выбрать", "Назад");}
			case 8:{ShowPlayerDialogEx(playerid, 8032, DIALOG_STYLE_LIST, "СТО", "[0] СТО [LS]\n[1] СТО [SF]\n[2] СТО [LV]", "Выбрать", "Назад");}
			}
		}
	case 8002:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Отмена");
			switch(listitem)
			{
			case 0: SetPlayerRaceCheckpoint(playerid,1, 1479.6614,-1741.5881,13.5469,0,0,0,2);
			case 1: SetPlayerRaceCheckpoint(playerid,1, 1418.4148,-1704.4663,13.5469,0,0,0,2);
			case 2: SetPlayerRaceCheckpoint(playerid,1, -2029.6696,-96.3916,35.1641,0,0,0,2);
			case 3: SetPlayerRaceCheckpoint(playerid,1, 1148.0006,-1747.2552,13.5703,0,0,0,2);
			case 4: SetPlayerRaceCheckpoint(playerid,1, 1800.6935,-1896.7571,13.4045,0,0,0,2);
			case 5: SetPlayerRaceCheckpoint(playerid,1, -72.8030,1159.6533,19.7422,0,0,0,2);
			case 6: SetPlayerRaceCheckpoint(playerid,1, 2755.9060,-2515.5491,13.6397,0,0,0,2);
			case 7: SetPlayerRaceCheckpoint(playerid,1, 2182.8240,-1666.7662,14.7032,0,0,0,2);
			case 8: SetPlayerRaceCheckpoint(playerid,1, 1961.2422,-2181.9412,13.5469,0,0,0,2);
			case 9: SetPlayerRaceCheckpoint(playerid,1, -1549.4977,-438.6559,6.0000,0,0,0,2);
			case 10: SetPlayerRaceCheckpoint(playerid,1, 1718.0468,1610.3558,10.0079,0,0,0,2);
			case 11: SetPlayerRaceCheckpoint(playerid,1, 315.2710,-1784.7847,4.6507,0,0,0,2);
			case 12: SetPlayerRaceCheckpoint(playerid,1, 2094.8950,2475.4832,10.8203,0,0,0,2);
			case 13: SetPlayerRaceCheckpoint(playerid,1, 2586.3958,2790.0894,10.8203,0,0,0,2);
			case 14: SetPlayerRaceCheckpoint(playerid,1, -1982.9703,1115.3318,53.1268,0,0,0,2);
			}
			CP[playerid] = 776;
			SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 8005:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Отмена");
			switch(listitem)
			{
			case 0: SetPlayerRaceCheckpoint(playerid,1, -20.6436,-300.6627,5.4229,0,0,0,2);
			case 1: SetPlayerRaceCheckpoint(playerid,1, -1028.2332,-596.7050,32.0078,0,0,0,2);
			case 2: SetPlayerRaceCheckpoint(playerid,1, -500.6603,-557.4494,25.5234,0,0,0,2);
			case 3: SetPlayerRaceCheckpoint(playerid,1, 1628.4138,2321.3416,10.8130,0,0,0,2);
			case 4: SetPlayerRaceCheckpoint(playerid,1, 1634.0817,-1152.8029,23.9063,0,0,0,2);
			case 5: SetPlayerRaceCheckpoint(playerid,1, -2432.1353,728.1223,35.0156,0,0,0,2);
			case 6: SetPlayerRaceCheckpoint(playerid,1, 2228.9771,-2214.3423,13.5469,0,0,0,2);
			case 7: SetPlayerRaceCheckpoint(playerid,1, 1280.6012,-1328.3436,13.3721,0,0,0,2);
			case 8: SetPlayerRaceCheckpoint(playerid,1, 2519.6055,-1463.4926,23.9785,0,0,0,2);
			}
			CP[playerid] = 776;
			SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 8006:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Отмена");
			SetPlayerRaceCheckpoint(playerid,1,BizzInfo[listitem+1][bEntranceX], BizzInfo[listitem+1][bEntranceY], BizzInfo[listitem+1][bEntranceZ],0,0,0,3.0);
			CP[playerid] = 776;
			SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 8007:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Отмена");
			switch(listitem)
			{
			case 0: SetPlayerRaceCheckpoint(playerid,1, 562.2973,-1291.6454,17.2482,0,0,0,2);
			case 1: SetPlayerRaceCheckpoint(playerid,1, -1952.2416,297.8349,35.4688,0,0,0,2);
			case 2: SetPlayerRaceCheckpoint(playerid,1, 2200.7192,1394.1440,11.0625,0,0,0,2);
			case 3: SetPlayerRaceCheckpoint(playerid,1, 455.8528,-1501.2737,31.0440,0,0,0,2);
			case 4: SetPlayerRaceCheckpoint(playerid,1, -1703.1656,941.8860,24.8906,0,0,0,2);
			case 5: SetPlayerRaceCheckpoint(playerid,1, 1361.7899,-1280.1626,13.3828,0,0,0,2);
			case 6: SetPlayerRaceCheckpoint(playerid,1, -2626.7271,212.4711,4.5982,0,0,0,2);
			case 7: SetPlayerRaceCheckpoint(playerid,1, 2154.7754,943.8470,10.8203,0,0,0,2);
			}
			CP[playerid] = 776;
			SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 8028:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Отмена");
			switch(listitem)
			{
			case 0: SetPlayerRaceCheckpoint(playerid,1, 1479.6614,-1741.5881,13.5469,0,0,0,2);
			case 1: SetPlayerRaceCheckpoint(playerid,1, -2029.6696,-96.3916,35.1641,0,0,0,2);
			case 2: SetPlayerRaceCheckpoint(playerid,1, 1186.6284,-1324.4036,13.5592,0,0,0,2);
			case 3: SetPlayerRaceCheckpoint(playerid,1, -2662.4089,624.6633,14.4531,0,0,0,2);
			case 4: SetPlayerRaceCheckpoint(playerid,1, 1609.2395,1829.0909,10.8203,0,0,0,2);
			case 5: SetPlayerRaceCheckpoint(playerid,1, 1539.9977,-1676.8136,13.5497,0,0,0,2);
			case 6: SetPlayerRaceCheckpoint(playerid,1, -1605.5968,719.9384,11.9772,0,0,0,2);
			case 7: SetPlayerRaceCheckpoint(playerid,1, 2288.0718,2423.9084,10.8203,0,0,0,2);
			case 8: SetPlayerRaceCheckpoint(playerid,1, -2426.4136,496.5313,30.0703,0,0,0,2);
			case 9: SetPlayerRaceCheckpoint(playerid,1, -1341.7393,475.5054,7.1875,0,0,0,2);
			case 10: SetPlayerRaceCheckpoint(playerid,1, 86.9121,1913.2690,17.7896,0,0,0,2);
			case 11: SetPlayerRaceCheckpoint(playerid,1, 1630.2021,-1717.4863,13.4957,0,0,0,2);
			case 12: SetPlayerRaceCheckpoint(playerid,1, -2044.7574,462.1444,35.1719,0,0,0,2);
			case 13: SetPlayerRaceCheckpoint(playerid,1, 2646.0962,1178.4163,10.8203,0,0,0,2);
			case 14: SetPlayerRaceCheckpoint(playerid,1, 1463.7456,2773.4534,10.6719,0,0,0,2);
			case 15: SetPlayerRaceCheckpoint(playerid,1, 947.1475,1732.4764,8.8516,0,0,0,2);
			case 16: SetPlayerRaceCheckpoint(playerid,1, 1444.5669,749.3381,10.8203,0,0,0,2);
			case 17: SetPlayerRaceCheckpoint(playerid,1, 2466.5449,-1665.6993,13.4696,0,0,0,2);
			case 18: SetPlayerRaceCheckpoint(playerid,1, 2795.1541,-1594.1162,10.9269,0,0,0,2);
			case 19: SetPlayerRaceCheckpoint(playerid,1, 2706.2224,-1997.3385,13.5547,0,0,0,2);
			case 20: SetPlayerRaceCheckpoint(playerid,1, 2179.1306,-1760.8370,13.5469,0,0,0,2);
			case 21: SetPlayerRaceCheckpoint(playerid,1, 1702.7330,-2106.9773,13.5469,0,0,0,2);
			}
			CP[playerid] = 776;
			SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 8029:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Отмена");
			switch(listitem)
			{
			case 0: SetPlayerRaceCheckpoint(playerid,1, -376.1135,-1410.9020,25.7266,0,0,0,2);
			case 1: SetPlayerRaceCheckpoint(playerid,1, -113.4650,-3.5923,3.1094,0,0,0,2);
			case 2: SetPlayerRaceCheckpoint(playerid,1, -1055.0795,-1195.0725,129.0927,0,0,0,2);
			case 3: SetPlayerRaceCheckpoint(playerid,1, 2.0902,74.6309,3.1172,0,0,0,2);
			case 4: SetPlayerRaceCheckpoint(playerid,1, 1926.3021,173.4447,37.2813,0,0,0,2);
			}
			CP[playerid] = 776;
			SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 8030:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Отмена");
			switch(listitem)
			{
			case 0: SetPlayerRaceCheckpoint(playerid,1, 692.6858,-477.6270,16.3359,0,0,0,2);
			case 1: SetPlayerRaceCheckpoint(playerid,1, -2105.0916,-2490.5391,30.6250,0,0,0,2);
			case 2: SetPlayerRaceCheckpoint(playerid,1, 656.0513,1723.5275,6.9922,0,0,0,2);
			}
			CP[playerid] = 776;
			SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 8031:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Отмена");
			switch(listitem)
			{
			case 0: SetPlayerRaceCheckpoint(playerid,1, 2601.7473,-2226.6167,13.3735,0,0,0,2);
			case 1: SetPlayerRaceCheckpoint(playerid,1, -1731.3489,118.6924,3.5547,0,0,0,2);
			case 3: SetPlayerRaceCheckpoint(playerid,1, 256.2961,1414.4734,10.7075,0,0,0,2);
			case 4: SetPlayerRaceCheckpoint(playerid,1, -1046.8383,-670.5345,32.3516,0,0,0,2);
			case 5: SetPlayerRaceCheckpoint(playerid,1, 608.5809,847.9885,-43.1515,0,0,0,2);
			case 6: SetPlayerRaceCheckpoint(playerid,1, -1873.1827,-1720.1915,21.7500,0,0,0,2);
			case 7: SetPlayerRaceCheckpoint(playerid,1, -1978.7343,-2434.5264,30.63,0,0,0,2);
			case 8: SetPlayerRaceCheckpoint(playerid,1, 2353.2612,2719.6458,10.7217,0,0,0,2);
			}
			CP[playerid] = 776;
			SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 8032:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_LIST, "GPS", "[0] Важные\n[1] По работе\n[2] Бизнесы\n[3] Магазины\n[4] Базы организаций\n[5] Фермы\n[6] Дальнобойщики\n[7] Клубы байкеров\n[8] СТО", "Выбрать", "Отмена");
			switch(listitem)
			{
			case 0: SetPlayerRaceCheckpoint(playerid,1, 844.5269,-592.0873,17.8798,0,0,0,2);
			case 1: SetPlayerRaceCheckpoint(playerid,1, -1799.2909,1198.1625,25.1194,0,0,0,2);
			case 2: SetPlayerRaceCheckpoint(playerid,1, 1659.0791,2195.0078,10.8203,0,0,0,2);
			}
			CP[playerid] = 776;
			SCM(playerid, -1, " Место на карте помечено красной меткой");
		}
	case 2019:
		{
			if(response)
			{
				switch(listitem)
				{
				case 0:
					{
						if(wmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 24; ammo = 50; wmcmatbi -= 70;
					}
				case 1:
					{
						if(wmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 25; ammo = 15; wmcmatbi -= 50;
					}
				case 2:
					{
						if(wmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 33; ammo = 10; wmcmatbi -= 100;
					}
				case 3:
					{
						if(wmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 31; ammo = 100; wmcmatbi -= 500;
					}
				case 4:
					{
						if(wmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 30; ammo = 100; wmcmatbi -= 500;
					}
				case 5:
					{
						if(wmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 29; ammo = 200; wmcmatbi -= 400;
					}
				case 6:
					{
						if(wmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 23; ammo = 100; wmcmatbi -= 100;
					}
				}
				new sendername[MAX_PLAYER_NAME];
				GetWeaponName(gun, gunname, sizeof(gunname));
				if(booston == 0) GiveWeapon(playerid, gun, ammo);
				else if(booston == 1) GiveWeapon(playerid, gun, ammo*3);
				format(string, 256, " Вы взяли оружие со склада");
				SCM(playerid, COLOR_BLUE, string);
				GetPlayerName(playerid,sendername,sizeof(sendername));
				format(string, 144, " %s взял(а) оружие со склада", sendername);
				ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return true;
			}
			else
			{
				return true;
			}
		}
	case 2022:
		{
			if(response)
			{
				switch(listitem)
				{
				case 0:
					{
						if(pmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 24; ammo = 50; pmcmatbi -= 70;
					}
				case 1:
					{
						if(pmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 25; ammo = 15; pmcmatbi -= 50;
					}
				case 2:
					{
						if(pmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 33; ammo = 10; pmcmatbi -= 100;
					}
				case 3:
					{
						if(pmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 31; ammo = 100; pmcmatbi -= 500;
					}
				case 4:
					{
						if(pmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 30; ammo = 100; pmcmatbi -= 500;
					}
				case 5:
					{
						if(pmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 29; ammo = 200; pmcmatbi -= 400;
					}
				case 6:
					{
						if(pmcmatbi <= 50)  return  SCM(playerid,COLOR_GRAD1, " На складе нет материалов!");
						gun = 23; ammo = 100; pmcmatbi -= 100;
					}
				}
				new sendername[MAX_PLAYER_NAME];
				GetWeaponName(gun, gunname, sizeof(gunname));
				if(booston == 0) GiveWeapon(playerid, gun, ammo);
				else if(booston == 1) GiveWeapon(playerid, gun, ammo*3);
				format(string, 256, " Вы взяли оружие со склада");
				SCM(playerid, COLOR_BLUE, string);
				GetPlayerName(playerid,sendername,sizeof(sendername));
				format(string, 144, " %s взял(а) оружие со склада", sendername);
				ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return true;
			}
			else
			{
				return true;
			}
		}
	case 32000:
		{
			if(response)
			{
				new car = GetPlayerVehicleID(playerid);
				if(car >= PetrolTanker[0] && car <= PetrolTanker[5])
				{
					if(PTEMP[playerid][pDLevel] >= 14)
					{
						if(PTEMP[playerid][pCash] <= 15000)
						{
							SCM(playerid, COLOR_GREY, " Не достаточно денег");
							RemovePlayerFromVehicleAC(playerid);
							TogglePlayerControllable(playerid, 1);
							return true;
						}
						else
						{
							jobcar[car] = true;
							PTEMP[playerid][pCash] -= 15000;
							TogglePlayerControllable(playerid, 1);
							SCM(playerid, -1, " Вы арендовали транспортное средство");
							return true;
						}
					}
					else
					{
						SCM(playerid, COLOR_GREY, " Для этого транспорта требуется 15 уровень скилла");
						RemovePlayerFromVehicleAC(playerid);
						TogglePlayerControllable(playerid, 1);
					}
				}
				else if(car >= Tanker[0] && car <= Tanker[11])
				{
					if(PTEMP[playerid][pDLevel] >= 0)
					{
						if(PTEMP[playerid][pCash] < 5000)
						{
							SCM(playerid, COLOR_GREY, " Не достаточно денег");
							RemovePlayerFromVehicleAC(playerid);
							TogglePlayerControllable(playerid, 1);
							return true;
						}
						else
						{
							jobcar[car] = true;
							PTEMP[playerid][pCash] -= 5000;
							TogglePlayerControllable(playerid, 1);
							SCM(playerid, -1, " Вы арендовали транспортное средство");
							return true;
						}
					}
				}
				else if(car >= Linerunner[0] && car <= Linerunner[1])
				{
					if(PTEMP[playerid][pDLevel] >= 4)
					{
						if(PTEMP[playerid][pCash] < 10000)
						{
							SCM(playerid, COLOR_GREY, " Не достаточно денег");
							RemovePlayerFromVehicleAC(playerid);
							TogglePlayerControllable(playerid, 1);
							return true;
						}
						else
						{
							jobcar[car] = true;
							PTEMP[playerid][pCash] -= 10000;
							TogglePlayerControllable(playerid, 1);
							SCM(playerid, -1, " Вы арендовали транспортное средство");
							return true;
						}
					}
					else
					{
						SCM(playerid, COLOR_GREY, " Для этого транспорта требуется 5 уровень скилла");
						RemovePlayerFromVehicleAC(playerid);
						TogglePlayerControllable(playerid, 1);
					}
				}
				else if(car >= Roadtrain[0] && car <= Roadtrain[5])
				{
					if(PTEMP[playerid][pDLevel] > 24)
					{
						if(PTEMP[playerid][pCash] < 20000)
						{
							SCM(playerid, COLOR_GREY, " Не достаточно денег");
							RemovePlayerFromVehicleAC(playerid);
							TogglePlayerControllable(playerid, 1);
							return true;
						}
						else
						{
							jobcar[car] = true;
							PTEMP[playerid][pCash] -= 20000;
							TogglePlayerControllable(playerid, 1);
							SCM(playerid, -1, " Вы арендовали транспортное средство");
							return true;
						}
					}
					else
					{
						SCM(playerid, COLOR_GREY, " Для этого транспорта требуется 25 уровень скилла");
						RemovePlayerFromVehicleAC(playerid);
						TogglePlayerControllable(playerid, 1);
					}
				}
				return true;
			}
			else
			{
				RemovePlayerFromVehicleAC(playerid);
				TogglePlayerControllable(playerid, 1);
				return true;
			}
		}
	case 2929:
		{
			if(response)
			{
				new bouse = PTEMP[playerid][pPBizzKey];
				if(!strlen(inputtext))return ShowPlayerDialogEx(playerid,2929,DIALOG_STYLE_INPUT, "Перевод денег на счёт бизнеса","Введите сумму, которую вы хотите положить на счёт бизнеса", "Готово", "Отмена");
				new moneys;
				moneys = strval(inputtext);
				if(moneys < 1000 || moneys > 1000000)
				{
					SCM(playerid, COLOR_GREY, " Минимальная сумма 1000 вирт, максимальная 1000000 вирт");
					ShowPlayerDialogEx(playerid,2929,DIALOG_STYLE_INPUT, "Перевод денег на счёт бизнеса","Введите сумму, которую вы хотите положить на счёт бизнеса", "Готово", "Отмена");
					return true;
				}
				if(moneys+BizzInfo[bouse][bTill] > 55000) return SCM(playerid,COLOR_GREY," Неверная сумма");
				if(PTEMP[playerid][pBank] < moneys) return	SCM(playerid, COLOR_GRAD1, " У вас нет столько денег!");
				PTEMP[playerid][pBank] -= moneys;
				BizzInfo[bouse][bTill] += moneys;
				format(string, 144, "Вы положили на счёт Вашего бизнеса %i вирт", moneys);
				SCM(playerid, 0x6495EDFF, string);
				SetPlayerChatBubble(playerid, "Кладёт на счёт бизнеса",COLOR_PURPLE,30.0,10000);
				return true;
			}
			else
			{
				return true;
			}
		}
	case 8900:
		{
			if(!response) return GameTextForPlayer(playerid,"~g~good luck",1000,1);
			switch(listitem)
			{
			case 0: return ShowPlayerDialogEx(playerid, 8904, DIALOG_STYLE_LIST, "Пополнить счет","[0] 500 вирт\n[1] 1 000 вирт\n[2] 5 000 вирт\n[3] 10 000 вирт\n[4] 20 000 вирт\n[5] 50 000 вирт\n[6] 100 000 вирт\n[7] 500 000 вирт", "Выбрать", "Назад");
			case 1: return ShowPlayerDialogEx(playerid, 8905, DIALOG_STYLE_LIST, "Снять со счета","[0] 500 вирт\n[1] 1 000 вирт\n[2] 5 000 вирт\n[3] 10 000 вирт\n[4] 20 000 вирт\n[5] 50 000 вирт\n[6] 100 000 вирт\n[7] 500 000 вирт", "Выбрать", "Назад");
			case 2:
				{
					format(string,168," Баланс: %i вирт",PTEMP[playerid][pBank]);
					SCM(playerid,0x6495edff, string);
					return ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
				}
			case 3:
				{
					if(!HGet(playerid)) return SCM(playerid,COLOR_GREY," У вас нет дома"), ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
					format(string,512,"[0] 1 час\t\t\t\t\t%i вирт\n[1] 3 часа\t\t\t\t\t%i вирт\n[2] 5 часов\t\t\t\t\t%i вирт\n[3] 12 часов\t\t\t\t\t%i вирт\n[4] 24 часа\t\t\t\t\t%i вирт\n[5] 3 дня\t\t\t\t\t%i вирт\n[6] 7 дней\t\t\t\t\t%i вирт\n[7] 14 дней\t\t\t\t\t%i вирт\n[8] 28 дней\t\t\t\t\t%i вирт",
					GetHouseOplata(PTEMP[playerid][pPHouseKey]),GetHouseOplata(PTEMP[playerid][pPHouseKey])*3,GetHouseOplata(PTEMP[playerid][pPHouseKey])*5,GetHouseOplata(PTEMP[playerid][pPHouseKey])*12,GetHouseOplata(PTEMP[playerid][pPHouseKey])*24,GetHouseOplata(PTEMP[playerid][pPHouseKey])*72,GetHouseOplata(PTEMP[playerid][pPHouseKey])*168,GetHouseOplata(PTEMP[playerid][pPHouseKey])*336,GetHouseOplata(PTEMP[playerid][pPHouseKey])*672);
					ShowPlayerDialogEx(playerid,9521,DIALOG_STYLE_LIST, "Оплатить квартплату",string, "Выбрать", "Назад");
				}
			}
		}
	case 8904:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			switch(listitem)
			{
			case 0: SetPVarInt(playerid,"Bankmoney",500);
			case 1: SetPVarInt(playerid,"Bankmoney",1000);
			case 2: SetPVarInt(playerid,"Bankmoney",5000);
			case 3: SetPVarInt(playerid,"Bankmoney",10000);
			case 4: SetPVarInt(playerid,"Bankmoney",20000);
			case 5: SetPVarInt(playerid,"Bankmoney",50000);
			case 6: SetPVarInt(playerid,"Bankmoney",100000);
			case 7: SetPVarInt(playerid,"Bankmoney",500000);
			}
			if(PTEMP[playerid][pCash] < GetPVarInt(playerid,"Bankmoney")) return SCM(playerid,COLOR_GREY," У вас недостаточно средств"), ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			PTEMP[playerid][pCash]-=GetPVarInt(playerid,"Bankmoney");
			PTEMP[playerid][pBank]+=GetPVarInt(playerid,"Bankmoney");
			format(string,15,"~r~-$%i",GetPVarInt(playerid,"Bankmoney")), GameTextForPlayer(playerid,string,1000,1);
			SendMes(playerid,0x6495EDFF," Вы пополнили счет на %i вирт. Баланс: %i вирт",GetPVarInt(playerid,"Bankmoney"),PTEMP[playerid][pBank]);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			return ShowPlayerDialogEx(playerid, 8904, DIALOG_STYLE_LIST, "Пополнить счет","[0] 500 вирт\n[1] 1 000 вирт\n[2] 5 000 вирт\n[3] 10 000 вирт\n[4] 20 000 вирт\n[5] 50 000 вирт\n[6] 100 000 вирт\n[7] 500 000 вирт", "Выбрать", "Назад");
		}
	case 8905:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			switch(listitem)
			{
			case 0: SetPVarInt(playerid,"Bankmoney",500);
			case 1: SetPVarInt(playerid,"Bankmoney",1000);
			case 2: SetPVarInt(playerid,"Bankmoney",5000);
			case 3: SetPVarInt(playerid,"Bankmoney",10000);
			case 4: SetPVarInt(playerid,"Bankmoney",20000);
			case 5: SetPVarInt(playerid,"Bankmoney",50000);
			case 6: SetPVarInt(playerid,"Bankmoney",100000);
			case 7: SetPVarInt(playerid,"Bankmoney",500000);
			}
			if(PTEMP[playerid][pBank] < GetPVarInt(playerid,"Bankmoney")) return SCM(playerid,COLOR_GREY," У вас недостаточно средств"), ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			PTEMP[playerid][pBank]-=GetPVarInt(playerid,"Bankmoney");
			PTEMP[playerid][pCash]+=GetPVarInt(playerid,"Bankmoney");
			format(string,15,"~b~+$%i",GetPVarInt(playerid,"Bankmoney")), GameTextForPlayer(playerid,string,1000,1);
			SendMes(playerid,0x6495edff," Вы сняли со счета %i вирт. Баланс: %i вирт",GetPVarInt(playerid,"Bankmoney"),PTEMP[playerid][pBank]);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			return ShowPlayerDialogEx(playerid, 8905, DIALOG_STYLE_LIST, "Снять со счета","[0] 500 вирт\n[1] 1 000 вирт\n[2] 5 000 вирт\n[3] 10 000 вирт\n[4] 20 000 вирт\n[5] 50 000 вирт\n[6] 100 000 вирт\n[7] 500 000 вирт", "Выбрать", "Назад");
		}
	case 9521:
		{
			if(!response) return true;
			if(!HGet(playerid)) return SCM(playerid,COLOR_GREY," У вас нет дома"), ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			switch(listitem)
			{
			case 0: SetPVarInt(playerid,"Housemoney",1);
			case 1: SetPVarInt(playerid,"Housemoney",3);
			case 2: SetPVarInt(playerid,"Housemoney",5);
			case 3: SetPVarInt(playerid,"Housemoney",12);
			case 4: SetPVarInt(playerid,"Housemoney",24);
			case 5: SetPVarInt(playerid,"Housemoney",72);
			case 6: SetPVarInt(playerid,"Housemoney",168);
			case 7: SetPVarInt(playerid,"Housemoney",336);
			case 8: SetPVarInt(playerid,"Housemoney",672);
			}
			new moneys = (GetPVarInt(playerid,"Housemoney")*GetHouseOplata(PTEMP[playerid][pPHouseKey]));
			if(PTEMP[playerid][pBank] < moneys) return SCM(playerid,COLOR_GREY," Недостаточно средств на банковском счету"), ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			if(HouseInfo[PTEMP[playerid][pPHouseKey]][hTakings]+moneys > GetHouseOplata(PTEMP[playerid][pPHouseKey])*672+1) {
				SendMes(playerid,COLOR_GREY," Вы не можете пополнить домашний счет выше, чем на %i вирт. Ваш баланс: %i вирт",GetHouseOplata(PTEMP[playerid][pPHouseKey])*672,HouseInfo[PTEMP[playerid][pPHouseKey]][hTakings]);
				format(string,512,"[0] 1 час\t\t\t\t\t%i вирт\n[1] 3 часа\t\t\t\t\t%i вирт\n[2] 5 часов\t\t\t\t\t%i вирт\n[3] 12 часов\t\t\t\t\t%i вирт\n[4] 24 часа\t\t\t\t\t%i вирт\n[5] 3 дня\t\t\t\t\t%i вирт\n[1] 7 дней\t\t\t\t\t%i вирт\n[1] 14 дней\t\t\t\t\t%i вирт\n[1] 28 дней\t\t\t\t\t%i вирт",
				GetHouseOplata(PTEMP[playerid][pPHouseKey]),GetHouseOplata(PTEMP[playerid][pPHouseKey])*3,GetHouseOplata(PTEMP[playerid][pPHouseKey])*5,GetHouseOplata(PTEMP[playerid][pPHouseKey])*12,GetHouseOplata(PTEMP[playerid][pPHouseKey])*24,GetHouseOplata(PTEMP[playerid][pPHouseKey])*72,GetHouseOplata(PTEMP[playerid][pPHouseKey])*168,GetHouseOplata(PTEMP[playerid][pPHouseKey])*336,GetHouseOplata(PTEMP[playerid][pPHouseKey])*672);
				ShowPlayerDialogEx(playerid,9521,DIALOG_STYLE_LIST, "Оплатить квартплату",string, "Выбрать", "Назад"); return true;}
			HouseInfo[PTEMP[playerid][pPHouseKey]][hTakings]+=moneys;
			PTEMP[playerid][pBank]-= moneys;
			FracBank[0][fKazna]+=moneys/2;
			SendMes(playerid,COLOR_BLUE," Вы перевели %i вирт. Остаток: %i вирт. Домашний счёт %i вирт",moneys,PTEMP[playerid][pBank],HouseInfo[PTEMP[playerid][pPHouseKey]][hTakings]);
			format(string,512,"[0] 1 час\t\t\t\t\t%i вирт\n[1] 3 часа\t\t\t\t\t%i вирт\n[2] 5 часов\t\t\t\t\t%i вирт\n[3] 12 часов\t\t\t\t\t%i вирт\n[4] 24 часа\t\t\t\t\t%i вирт\n[5] 3 дня\t\t\t\t\t%i вирт\n[6] 7 дней\t\t\t\t\t%i вирт\n[7] 14 дней\t\t\t\t\t%i вирт\n[8] 28 дней\t\t\t\t\t%i вирт",
			GetHouseOplata(PTEMP[playerid][pPHouseKey]),GetHouseOplata(PTEMP[playerid][pPHouseKey])*3,GetHouseOplata(PTEMP[playerid][pPHouseKey])*5,GetHouseOplata(PTEMP[playerid][pPHouseKey])*12,GetHouseOplata(PTEMP[playerid][pPHouseKey])*24,GetHouseOplata(PTEMP[playerid][pPHouseKey])*72,GetHouseOplata(PTEMP[playerid][pPHouseKey])*168,GetHouseOplata(PTEMP[playerid][pPHouseKey])*336,GetHouseOplata(PTEMP[playerid][pPHouseKey])*672);
			ShowPlayerDialogEx(playerid,9521,DIALOG_STYLE_LIST, "Оплатить квартплату",string, "Выбрать", "Назад");
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			DeletePVar(playerid,"Housemoney");
		}
	case 5032:
		{
			new house = PTEMP[playerid][pPHouseKey];
			if(!response) return true;
			if(!HGet(playerid)) return SCM(playerid,COLOR_GREY," У вас нет дома");
			if(house_car[playerid] != -1)
			{
				DestroyVehicle(house_car[playerid]);
				house_car[playerid] = -1;
			}
			HouseInfo[house][hHel] = 0;
			HouseInfo[house][hLock] = 1;
			HouseInfo[house][hVec] = 0;
			HouseInfo[house][hVcol1] = -1;
			HouseInfo[house][hVcol2] = -1;
			if(HouseInfo[house][hKlass] >= 2)
			{
				SetPVarInt(playerid,"chosencar",0); // Поставим значение "все автомобили в гараже и никакая машина не выбрана"
				DestroyVehicle(garage_car[playerid][0]);
				DestroyVehicle(garage_car[playerid][1]);
				DestroyVehicle(garage_car[playerid][2]);
				DestroyVehicle(garage_car[playerid][3]);
				DestroyVehicle(garage_car[playerid][4]);
			}
			for(new h = 0; h < 10; h++) HouseInfo[house][hSafe][h] = 0;
			strmid(HouseInfo[house][hOwner], "None", 0, strlen("None"), 15);
			PTEMP[playerid][pBank] += HouseInfo[house][hValue];
			format(string,40,"~w~house in sold~n~~g~$%i",HouseInfo[house][hValue]);
			GameTextForPlayer(playerid,string, 5000, 3);
			PTEMP[playerid][pPHouseKey] = 9999;
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid,HouseInfo[house][hEntrancex],HouseInfo[house][hEntrancey],HouseInfo[house][hEntrancez]);
			BuyHouse(house);
			SaveMySQL(10, playerid);
			return true;
		}
	case 4423:
		{
			if(response)
			{
				if(PTEMP[playerid][pMember] != 0 || GetPVarInt(playerid,"farm_id")) return SCM(playerid,COLOR_GRAD1, "Вы состоите во фракции");
				if(PTEMP[playerid][pJob] == 9)
				{
					if(Prorab[playerid] == true) SCM(playerid,COLOR_GREY," Вы уже начали рабочий день");
					SetPlayerSkin(playerid,27);
					SCM(playerid,COLOR_GREEN, "Рабочий день начат. (( На радаре помечены места загрузки и разгрузки ))");
					Prorab[playerid] = true;
				}
				else
				{
					if(Works[playerid] == true) return SCM(playerid,COLOR_GRAD1, " Вы уже начали рабочий день");
					Works[playerid] = true; JobAmmount[playerid] = 0; JobCP[playerid] = 1;
					SetPlayerCheckpoint(playerid,2230.3528,-2286.1353,14.3751,1.5);
					new skin = random(2);
					if(skin == 1) SetPlayerSkin(playerid,260);
					else SetPlayerSkin(playerid,16);
					SCM(playerid,COLOR_GREEN, "Рабочий день начат. (( На радаре помечены места загрузки и разгрузки ))");
					PicCP[playerid] = 0;
				}
			}
			else
			{
				if(PTEMP[playerid][pJob] == 9)
				{
					if(Prorab[playerid] == false) return SCM(playerid,COLOR_GREY," Вы не начинали рабочий день");
					SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
					Prorab[playerid] = false;
					SCM(playerid,COLOR_GREEN, "Рабочий день окончен");
				}
				else
				{
					if(Works[playerid] == false) return SCM(playerid,COLOR_GRAD1, " Вы не начинали рабочий день");
					if(JobAmmount[playerid] != 0) return SCM(playerid,-1, " Вы должны получить зарплату в офисе");
					SCM(playerid,COLOR_GREEN, "Рабочий день окончен.");
					SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
					DisablePlayerCheckpoint(playerid);
					PicCP[playerid] = 1;
					mesh[playerid] = 999;
					usemesh[playerid] = 0;
					Works[playerid] = false;
					return true;
				}
			}
		}
	case 19:
		{
			if(response)
			{
				if(PTEMP[playerid][pMember] != 0) return SCM(playerid,COLOR_GRAD1, "Вы состоите во фракции");
				SetPlayerSkin(playerid,27);
				SCM(playerid,COLOR_GREEN, "Рабочий день начат. (( На радаре помечены места загрузки и разгрузки ))");
			}
			else
			{
				if(PTEMP[playerid][pJob] == 0) return SCM(playerid,COLOR_GRAD1, " Вы не брали работу");
				SCM(playerid,COLOR_YELLOW, "Рабочий день завершён");
				SetPlayerSkin(playerid,PTEMP[playerid][pChar][0]);
				SCM(playerid,COLOR_GREEN,"Спасибо за работу, приходите еще!");
				return true;
			}
		}
	case 9298:
		{
			if(!response) return true;
			switch(PTEMP[playerid][pMember])
			{
			case 5:
				{
					if(MafiaBank[0][nLcn] < 500000) return SCM(playerid,COLOR_GREY," В банке мафии нет столько денег");
					lcnmats = 100000;
					SCM(playerid,COLOR_YELLOW, "Вы купили 100000 материалов за 500000 вирт");
					MafiaBank[0][nLcn]-=500000;
				}
			case 6:
				{
					if(MafiaBank[0][nYakuza] < 500000) return SCM(playerid,COLOR_GREY," В банке мафии нет столько денег");
					yakuzamats = 100000;
					SCM(playerid,COLOR_YELLOW, "Вы купили 100000 материалов за 500000 вирт");
					MafiaBank[0][nYakuza]-=500000;
				}
			case 14:
				{
					if(MafiaBank[0][nRm] < 500000) return SCM(playerid,COLOR_GREY," В банке мафии нет столько денег");
					rmmats = 100000;
					SCM(playerid,COLOR_YELLOW, "Вы купили 100000 материалов за 500000 вирт");
					MafiaBank[0][nRm]-=500000;
				}
			}
			return true;
		}
	case 7724:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					SetPlayerFacingAngle(playerid, 181.6046);
					SetPlayerCameraPos(playerid,338.6618,1573.9758,29.3534);
					SetPlayerCameraLookAt(playerid,338.6618,1573.9758,29.3534);
					TogglePlayerControllable(playerid, 0);
					return true;
				}
			case 1:
				{
					SetPlayerFacingAngle(playerid, 170.0947);
					SetPlayerCameraPos(playerid,-61.5420,1612.7935,24.2544);
					SetPlayerCameraLookAt(playerid,-61.5420,1612.7935,24.2544);
					TogglePlayerControllable(playerid, 0);
					return true;
				}
			case 2:
				{
					SetPlayerFacingAngle(playerid, 115.7203);
					SetPlayerCameraPos(playerid,121.2786,1942.5219,29.0367);
					SetPlayerCameraLookAt(playerid,121.2786,1942.5219,29.0367);
					TogglePlayerControllable(playerid, 0);
					return true;
				}
			case 3:
				{
					SetPlayerFacingAngle(playerid, 319.3263);
					SetPlayerCameraPos(playerid,277.4582,2024.3215,26.3999);
					SetPlayerCameraLookAt(playerid,277.4582,2024.3215,26.3999);
					TogglePlayerControllable(playerid, 0);
					return true;
				}
			}
			SCM(playerid, COLOR_LIGHTRED, "/cameraoff - отключить камеру.");
			SetPlayerVirtualWorld(playerid, 0);
		}
	case 3725:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					for(new h = 1; h <= TotalHouse; h++)
					{
						if(strcmp(HouseInfo[h][hOwner],"None",true) != 0)
						{
							SCM(playerid, COLOR_GRAD1, " Все дома проданы");
							strmid(HouseInfo[h][hOwner], "None", 0, strlen("None"), 15);
							BuyHouse(h);
						}
					}
					return true;
				}
			case 1:
				{
					for(new i = 1; i <= TotalBizz; i++)
					{
						if(strcmp(BizzInfo[i][bOwner],"None",true) != 0)
						{
							SCM(playerid, COLOR_GRAD1, " Все бизнесы проданы");
							strmid(BizzInfo[i][bOwner], "None", 0, strlen("None"), 15);
							BizzInfo[i][bTill] = 0;
							BizzInfo[i][bPrice] = 0;
							BizzInfo[i][bMafia] = 0;
							BizzInfo[i][bLandTax] = 0;
							BizzPay[i] = 0;
							format(string, 90, "%s\nПродаётся", BizzInfo[i][bMessage],BizzInfo[i][bBuyPrice]);
							UpdateDynamic3DTextLabelText(BizzInfo[i][bLabel], COLOR_GREEN, string);
						}
					}
				}
			case 2:
				{
					ShowPlayerDialogEx(playerid, 2725, DIALOG_STYLE_LIST, "Выбирете интерьер", " [1] Деревянный\n [2] Мрамор\n [3] Дворец\n [4] Обычный стиль\n [5] Обычное дерево\n [6] Обычный стиль 2\n [7] Красное деверо\n [8] Обычный стиль\n [9] Дешовый стиль", "Выбрать", "Закрыть");
					return true;
				}
			case 3:
				{
					ShowPlayerDialogEx(playerid, 15624, DIALOG_STYLE_LIST, "Выбирете интерьер", " [1] Интерьер C Класса\n [2] Интерьер A Класса\n [3] Интерьер S Класса\n [4] Интерьер D Класса\n [5] Интерьер D Класса\n [6] Интерьер N Класса\n [7] Интерьер S Класса\n [8] Интерьер D Класса\n [9] Интерьер D Класса\n [10] Интерьер D Класса\n [11] Интерьер A Класса\n [12] Интерьер N Класса\n [13] Интерьер S Класса", "Выбрать", "Закрыть");
					return true;
				}
			case 4:
				{
					for(new h = 1; h <= TotalHouse; h++)
					{
						if(HouseInfo[h][hInt] == 10) HouseInfo[h][hKlass] = 0;
						else if(HouseInfo[h][hInt] == 6) HouseInfo[h][hKlass] = 1;
						else if(HouseInfo[h][hInt] == 5) HouseInfo[h][hKlass] = 2;
						else if(HouseInfo[h][hInt] == 12) HouseInfo[h][hKlass] = 3;
						else if(HouseInfo[h][hKlass] == 4) HouseInfo[h][hKlass] = 4;
						SendMes(playerid,-1," Дом %i распеределен",h);
					}
				}
			case 5:
				{
					for(new h = 1; h <= TotalHouse; h++)
					{
						if(HouseInfo[h][hKlass] == 0) HouseInfo[h][hValue] = 130000;
						if(HouseInfo[h][hKlass] == 1) HouseInfo[h][hValue] = 350000;
						if(HouseInfo[h][hKlass] == 2) HouseInfo[h][hValue] = 1500000;
						if(HouseInfo[h][hKlass] == 3) HouseInfo[h][hValue] = 2500000;
						if(HouseInfo[h][hKlass] == 4) HouseInfo[h][hValue] = 16000000;
						if(HouseInfo[h][hKlass] == 5) HouseInfo[h][hValue] = 30000000;
						SendMes(playerid,-1," Дом %i распеределен",h);
					}
				}
			}
		}
	case 2725:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:	ShowPlayerDialogEx(playerid, 2726, DIALOG_STYLE_INPUT, "Деревянный стиль", "Введите номер дома", "Готово", "Отмена");
			case 1:	ShowPlayerDialogEx(playerid, 2727, DIALOG_STYLE_INPUT, "Мрамор", "Введите номер дома", "Готово", "Отмена");
			case 2: ShowPlayerDialogEx(playerid, 2728, DIALOG_STYLE_INPUT, "Дворец", "Введите номер дома", "Готово", "Отмена");
			case 3:	ShowPlayerDialogEx(playerid, 2729, DIALOG_STYLE_INPUT, "Обычный стиль", "Введите номер дома", "Готово", "Отмена");
			case 4:	ShowPlayerDialogEx(playerid, 2730, DIALOG_STYLE_INPUT, "Обычное дерево", "Введите номер дома", "Готово", "Отмена");
			case 5: ShowPlayerDialogEx(playerid, 2731, DIALOG_STYLE_INPUT, "Обычный стиль [2]", "Введите номер дома", "Готово", "Отмена");
			case 6:	ShowPlayerDialogEx(playerid, 2732, DIALOG_STYLE_INPUT, "Красное дерево", "Введите номер дома", "Готово", "Отмена");
			case 7: ShowPlayerDialogEx(playerid, 2733, DIALOG_STYLE_INPUT, "Обычный стиль [3]", "Введите номер дома", "Готово", "Отмена");
			case 8: ShowPlayerDialogEx(playerid, 2734, DIALOG_STYLE_INPUT, "Дешевый стиль", "Введите номер дома", "Готово", "Отмена");
			}
		}
	case 15624:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: ShowPlayerDialogEx(playerid, 2735, DIALOG_STYLE_INPUT, "Интерьер C Класса", "Введите номер дома", "Готово", "Отмена");
			case 1: ShowPlayerDialogEx(playerid, 2736, DIALOG_STYLE_INPUT, "Интерьер A Класса", "Введите номер дома", "Готово", "Отмена");
			case 2: ShowPlayerDialogEx(playerid, 2737, DIALOG_STYLE_INPUT, "Интерьер S Класса", "Введите номер дома", "Готово", "Отмена");
			case 3: ShowPlayerDialogEx(playerid, 2738, DIALOG_STYLE_INPUT, "Интерьер D Класса", "Введите номер дома", "Готово", "Отмена");
			case 4: ShowPlayerDialogEx(playerid, 2739, DIALOG_STYLE_INPUT, "Интерьер D Класса", "Введите номер дома", "Готово", "Отмена");
			case 5: ShowPlayerDialogEx(playerid, 2740, DIALOG_STYLE_INPUT, "Интерьер N Класса", "Введите номер дома", "Готово", "Отмена");
			case 6: ShowPlayerDialogEx(playerid, 2741, DIALOG_STYLE_INPUT, "Интерьер S Класса", "Введите номер дома", "Готово", "Отмена");
			case 7: ShowPlayerDialogEx(playerid, 2742, DIALOG_STYLE_INPUT, "Интерьер D Класса", "Введите номер дома", "Готово", "Отмена");
			case 8: ShowPlayerDialogEx(playerid, 2743, DIALOG_STYLE_INPUT, "Интерьер D Класса", "Введите номер дома", "Готово", "Отмена");
			case 9: ShowPlayerDialogEx(playerid, 2744, DIALOG_STYLE_INPUT, "Интерьер D Класса", "Введите номер дома", "Готово", "Отмена");
			case 10: ShowPlayerDialogEx(playerid, 2745, DIALOG_STYLE_INPUT, "Интерьер A Класса", "Введите номер дома", "Готово", "Отмена");
			case 11: ShowPlayerDialogEx(playerid, 2746, DIALOG_STYLE_INPUT, "Интерьер N Класса", "Введите номер дома", "Готово", "Отмена");
			case 12: ShowPlayerDialogEx(playerid, 2747, DIALOG_STYLE_INPUT, "Интерьер S Класса", "Введите номер дома", "Готово", "Отмена");
			}
		}
	case 2726:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 4;
			HouseInfo[house][hExitx] = -261.9759;
			HouseInfo[house][hExity] = 1456.8844;
			HouseInfo[house][hExitz] = 1084.3672;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
			return true;
		}
	case 2727:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 6;
			HouseInfo[house][hExitx] = 234.1571;
			HouseInfo[house][hExity] = 1064.9569;
			HouseInfo[house][hExitz] = 1084.2104;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2728:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 5;
			HouseInfo[house][hExitx] = 140.9131;
			HouseInfo[house][hExity] = 1367.9713;
			HouseInfo[house][hExitz] = 1083.8621;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2729:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 5;
			HouseInfo[house][hExitx] = 22.7783;
			HouseInfo[house][hExity] = 1404.9600;
			HouseInfo[house][hExitz] = 1084.4297;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2730:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 10;
			HouseInfo[house][hExitx] = 23.8334;
			HouseInfo[house][hExity] = 1340.4812;
			HouseInfo[house][hExitz] = 1084.3750;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2731:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 4;
			HouseInfo[house][hExitx] = 261.0654;
			HouseInfo[house][hExity] = 1284.2991;
			HouseInfo[house][hExitz] = 1080.2578;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2732:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 2;
			HouseInfo[house][hExitx] = 491.0190;
			HouseInfo[house][hExity] = 1399.0691;
			HouseInfo[house][hExitz] = 1080.2578;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2733:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 2;
			HouseInfo[house][hExitx] = 225.9761;
			HouseInfo[house][hExity] = 1239.9126;
			HouseInfo[house][hExitz] = 1082.1406;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2734:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 10;
			HouseInfo[house][hExitx] = 2261.3103;
			HouseInfo[house][hExity] = -1136.4467;
			HouseInfo[house][hExitz] = 1050.6328;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2735:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 5;
			HouseInfo[house][hExitx] = 22.7405;
			HouseInfo[house][hExity] = 1404.3799;
			HouseInfo[house][hExitz] = 1084.4297;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2736:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 5;
			HouseInfo[house][hExitx] = 140.2206;
			HouseInfo[house][hExity] = 1367.2734;
			HouseInfo[house][hExitz] = 1083.8612;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2737:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 6;
			HouseInfo[house][hExitx] = 234.1562;
			HouseInfo[house][hExity] = 1064.9047;
			HouseInfo[house][hExitz] = 1084.2106;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2738:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 6;
			HouseInfo[house][hExitx] = -68.8618;
			HouseInfo[house][hExity] = 1352.2183;
			HouseInfo[house][hExitz] = 1080.2109;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2739:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 8;
			HouseInfo[house][hExitx] = -42.6081;
			HouseInfo[house][hExity] = 1406.5001;
			HouseInfo[house][hExitz] = 1084.4297;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2740:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 6;
			HouseInfo[house][hExitx] = 344.7035;
			HouseInfo[house][hExity] = 304.9266;
			HouseInfo[house][hExitz] = 999.1484;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2741:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 5;
			HouseInfo[house][hExitx] = 1298.9363;
			HouseInfo[house][hExity] = -795.4872;
			HouseInfo[house][hExitz] = 1084.0078;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2742:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 2;
			HouseInfo[house][hExitx] = 2467.7708;
			HouseInfo[house][hExity] = -1698.2811;
			HouseInfo[house][hExitz] = 1013.5078;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2743:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 8;
			HouseInfo[house][hExitx] = 2807.6252;
			HouseInfo[house][hExity] = -1173.2600;
			HouseInfo[house][hExitz] = 1025.5703;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2744:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 5;
			HouseInfo[house][hExitx] = 318.6064;
			HouseInfo[house][hExity] = 1115.7708;
			HouseInfo[house][hExitz] = 1083.8828;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2745:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 12;
			HouseInfo[house][hExitx] = 2324.3367;
			HouseInfo[house][hExity] = -1148.6296;
			HouseInfo[house][hExitz] = 1050.7101;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2746:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 10;
			HouseInfo[house][hExitx] = 421.7613;
			HouseInfo[house][hExity] = 2536.4836;
			HouseInfo[house][hExitz] = 10.0000;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 2747:
		{
			if(!response) return true;
			new house = strval(inputtext);
			HouseInfo[house][hInt] = 7;
			HouseInfo[house][hExitx] = 225.631;
			HouseInfo[house][hExity] = 1022.48;
			HouseInfo[house][hExitz] = 1084.07;
			SCM(playerid, COLOR_GREEN, " Интеръер дома изменен");
		}
	case 1994:
		{
			if(!response) return true;
			ClearAnimations(playerid);
			switch(listitem)
			{
			case 0: ApplyAnimation(playerid, "DANCING", "dnce_M_b", 4.1, 1, 0, 0, 1, 1 , 1);
			case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
			case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
			case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
			case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
			case 5: ApplyAnimation(playerid, "SMOKING", "M_smklean_loop", 4.1, 1, 0, 0, 1, 1, 1);
			case 6: ApplyAnimation(playerid, "SUNBATHE", "ParkSit_M_in", 4.1, 0, 0, 0, 1, 1, 1);
			case 7: ApplyAnimation(playerid, "SUNBATHE", "SitnWait_in_W", 4.1, 0, 0, 0, 1, 1, 1);
			case 8: ApplyAnimation(playerid, "CRACK", "Bbalbat_Idle_01", 4.1, 0, 0, 0, 1, 1, 1);
			case 9: ApplyAnimation(playerid, "CRACK", "crckdeth1", 4.1, 0, 0, 0, 1, 1, 1);
			case 10: ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.1, 0, 0, 0, 1, 1, 1);
			case 11: ApplyAnimation(playerid, "CRACK", "crckdeth3", 4.1, 0, 0, 0, 1, 1, 1);
			case 12: ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.1, 0, 0, 0, 1, 1, 1);
			case 13: ApplyAnimation(playerid, "CRACK", "crckidle1", 4.1, 0, 0, 0, 1, 1, 1);
			case 14: ApplyAnimation(playerid, "CRACK", "crckidle2", 4.1, 0, 0, 0, 1, 1, 1);
			case 15: ApplyAnimation(playerid, "CRACK", "crckidle3", 4.1, 0, 0, 0, 1, 1, 1);
			case 16: ApplyAnimation(playerid, "CRACK", "crckidle4", 4.1, 0, 0, 0, 1, 1, 1);
			case 17: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 0, 0, 1, 1, 1);
			case 18: ApplyAnimation(playerid, "PED", "gang_gunstand", 4.1, 0, 0, 0, 1, 1, 1);
			case 19: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
			case 20: ApplyAnimation(playerid, "PED", "DUCK_cower", 4.1, 0, 0, 0, 1, 1, 1);
			case 21: ApplyAnimation(playerid, "PED", "DOOR_LHinge_O", 4.1, 0, 1, 1, 1, 1 ,1);
			case 22: ApplyAnimation(playerid, "PED", "FLOOR_hit", 4.1, 0, 0, 0, 1, 1, 1);
			case 23: ApplyAnimation(playerid, "PED", "FLOOR_hit_f", 4.1, 0, 0, 0, 1, 1, 1);
			case 24: ApplyAnimation(playerid, "PED", "run_right", 4.1, 1, 1, 1, 1, 1 ,1);
			case 25: ApplyAnimation(playerid, "PED", "SEAT_down", 4.1, 0, 0, 0, 1, 1 ,1);
			case 26: ApplyAnimation(playerid, "PED", "WALK_drunk", 4.1, 1, 1, 1, 1, 1 ,1);
			}
			return ShowPlayerDialogEx(playerid, 1994, DIALOG_STYLE_LIST, "AnimList", "[0] Dance 0\n[1] Dance 1\n[2] Dance 2\n[3] Dance 3\n[4] Dance 4\n[5] Smoking\n[6] Sunbathe1\n[7] Sunbathe2\n[8] Crack1\n[9] Crack2\n[10] Crack3\n[11] Crack4\n[12] Crack5\n[13] Crack6\n[14] Crack7\n[15] Crack8\n[16] Crack9\n[17] Dealer\n[18] Ped\n[19] Руки вверх\n[20] Ped1\n[21] Ped2\n[22] Ped3\n[23] Ped4\n[24] Ped5\n[25] Ped6\n[26] Ped7", "Готово", "Отмена");
		}
	case 9898:
		{
			if(!response) return true;
			for(new i = 1; i <= TotalBizz; i++)
			{
				if (PlayerToPoint(3, playerid,BizzInfo[i][bEntranceX], BizzInfo[i][bEntranceY], BizzInfo[i][bEntranceZ]) && BizzInfo[i][bType] != 4)
				{
					if(PTEMP[playerid][pCash] < BizzInfo[i][bEntranceCost])
					{
						SCM(playerid, COLOR_GRAD1, " У вас нет столько денег");
						return true;
					}
					PickupX[playerid] = BizzInfo[i][bExitX], PickupY[playerid] = BizzInfo[i][bExitY];
					oldpickup[playerid] = BizzInfo[i][bExitPic];
					timepickup[playerid] = 3;
					PTEMP[playerid][pCash] -=BizzInfo[i][bEntranceCost];
					BizzInfo[i][bTill] += BizzInfo[i][bEntranceCost];
					BizzPay[i] += BizzInfo[i][bEntranceCost];
					SetPlayerInterior(playerid,BizzInfo[i][bInterior]);
					SetPlayerPos(playerid,BizzInfo[i][bExitX],BizzInfo[i][bExitY],BizzInfo[i][bExitZ]);
					SetPlayerVirtualWorld(playerid,BizzInfo[i][bVirtualWorld]);
					enterbiz[playerid] = i;
					return true;
				}
			}
		}
	case 10075: // Вход в красный дом
		{
			if(!response) return true;
			for(new i = 1; i <= TotalHouse; i++)
			{
				if (PlayerToPoint(3, playerid,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]))
				{
	  					switch(HouseInfo[i][hKlass])
					    {
			      			case 0: // Дом N Klass
				        	{
								CallLocalFunction("OnPlayerCommandText", "is", playerid, "/enter");
							}
							case 1: // Дом D Klass
							{
								CallLocalFunction("OnPlayerCommandText", "is", playerid, "/enter");
							}
							case 2..5: // Дома от C класса до домов S класса
							{
			    				ShowPlayerDialogEx(playerid, 1006, 2, "Вход","Войти в дом\nВойти в гараж", "Готово", "Отмена");
							}
						}
				}
			}
		}
	case 10026: // Вход в зеленый дом
		{
			if(!response) return true;
			for(new i = 1; i <= TotalHouse; i++)
			{
				if (PlayerToPoint(3, playerid,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]))
				{
		   			switch(HouseInfo[i][hKlass])
				    {
		      			case 0: // Дом N Klass
			        	{
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/enter");
						}
						case 1: // Дом D Klass
						{
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/enter");
						}
						case 2..5: // Дома от C класса до домов S класса
						{
		    				ShowPlayerDialogEx(playerid, 1006, 2, "Вход","Войти в дом\nВойти в гараж", "Готово", "Отмена");
						}
					}
				}
			}
		}
		case 1006: // Вход в дом / гараж от домов C-S классов
		{
		    switch(listitem)
			{
			    case 0: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/enter");
				case 1: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/enterg");
			}
		}
	case 1007: // Выйти на улицу / войти в дом
		{
			if(!response) return true;
			new i = GetPlayerVirtualWorld(playerid);
			switch(listitem)
			{
				case 0: // Выйти на улицу
				{
					PickupX[playerid] = HouseInfo[i-100][hEntrancex], PickupY[playerid] = HouseInfo[i-100][hEntrancey];
					oldpickup[playerid] = HouseInfo[i-100][hPickup];
					timepickup[playerid] = 3;
					SetPlayerInterior(playerid,0);
					SetPlayerPos(playerid,HouseInfo[i-100][hEntrancex],HouseInfo[i-100][hEntrancey],HouseInfo[i-100][hEntrancez]);
					SetPlayerVirtualWorld(playerid,0);
				}
				case 1: // Войти в дом
				{
					SetPlayerInterior(playerid,HouseInfo[i-100][hInt]);
					SetPlayerPos(playerid,HouseInfo[i-100][hExitx],HouseInfo[i-100][hExity],HouseInfo[i-100][hExitz]);
					SetPlayerVirtualWorld(playerid,i-50);
				}
			}
		}
		case 1008: // Выйти на улицу / войти в гараж
		{
			if(!response) return true;
			switch(listitem)
			{
				case 0:
				{
	   				for(new i = 1; i <= TotalHouse; i++)
					{
						if(!PlayerToPoint(3, playerid,HouseInfo[i][hExitx], HouseInfo[i][hExity], HouseInfo[i][hExitz])) continue;
						if(GetPlayerVirtualWorld(playerid) == i+50)
						{
							PickupX[playerid] = HouseInfo[i][hEntrancex], PickupY[playerid] = HouseInfo[i][hEntrancey];
							oldpickup[playerid] = HouseInfo[i][hPickup];
							timepickup[playerid] = 3;
							SetPlayerInterior(playerid,0);
							SetPlayerVirtualWorld(playerid,0);
							SetPlayerPos(playerid,HouseInfo[i][hEntrancex],HouseInfo[i][hEntrancey],HouseInfo[i][hEntrancez]);
							break;
						}
      				}
      			}
				case 1: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/enterg"); // Войти в гараж
      		}
		}
	case 29322:
		{
			if(!response || !strlen(inputtext) || strval(inputtext) == 0) return DeletePVar(playerid,"d_code1"), DeletePVar(playerid,"d_code2");
			if(!GetPVarInt(playerid,"d_code1")) return SetPVarInt(playerid,"d_code1",strval(inputtext)), ShowPlayerDialogEx(playerid,29322,DIALOG_STYLE_INPUT, "Код #2", "===============================\n              Введите код №2\n===============================", "Далее", "Отмена");
			SetPVarInt(playerid,"d_code2",strval(inputtext));
			mysql_format(DATABASE,QUERY,256,"SELECT * FROM `"TABLE_DONATE"` WHERE `code_one` = '%i' AND `code_two` = '%i' AND `used` = '0'",GetPVarInt(playerid,"d_code1"), GetPVarInt(playerid,"d_code2"));
			return mysql_function_query(DATABASE,QUERY,true,"_MySQL_QUERY","iis",27,playerid,"");
		}
	case 20012:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/ahelp");
			case 1: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/paint");
			case 2: ShowPlayerDialogEx(playerid,4385,DIALOG_STYLE_LIST, "{FFFFFF}Список погоды", "{FFFFFF}[1]- Солнечная погода\n[2]- Очень солнечная погода\n[3]- Гроза\n[4]- Пасмурно и туман\n[5]- Хмурая и дождливая\n[6]- Песчаная буря \n[7]- Туманный и зеленоватый\n[8]- В красках бледного Апельсина\n[9]- Свежая в синих красках \n[10]- Туманно и серо \n[11]- Темный неясный коричневый \n[12]- Розовое небо", "Выбрать", "Отмена");
			case 3:
				{
					new playersip[32];
					new s[128];
					new stringus[128];
					new countmute = 0;
					foreach(i)
					{
						GetPlayerIp(i,playersip,sizeof(playersip));
						if(!strcmp(playersip, playersip))
						{
							new num_players_on_ip = GetNumberThisIP(playersip);
							if(num_players_on_ip > 1)
							{
								format(stringus, 256, " [%i] %s | IP %s", i,Name(i),playersip);
								SCM(playerid, -1, stringus);
								countmute++;
							}
							if(countmute == 0) ShowPlayerDialogEx(playerid, 2963, DIALOG_STYLE_MSGBOX, "{FFFFFF}Одинаковый IP-адрес", "{FFFFFF}В данный момент, нету игроков с одинаковым IP адресом.", "Назад", "");
						}
					}
					format(string, 256, "{FFA500}[IP MANS]{FFFFFF} В данный момент с одинаковым IP игроков: {FFA500}%i!", countmute);
					SCM(playerid, COLOR_LIGHTBLUE, string);
					return ShowPlayerDialogEx(playerid, 1331, DIALOG_STYLE_MSGBOX, "{FFFFFF}Игроки с IP адресами:",s,"OK","");
				}
			case 4: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/warnmans");
			case 5: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mutelist");
			case 6: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/vipmans");
			case 7: CallLocalFunction("OnPlayerCommandText", "is", playerid, "/abalance");
			}
		}
	case 4385:// ID диалога
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: SetWeather(10),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 1: SetWeather(11),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 2: SetWeather(8),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 3: SetWeather(9),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 4: SetWeather(14),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 5: SetWeather(19),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 6: SetWeather(20),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 7: SetWeather(23),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 8: SetWeather(27),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 9: SetWeather(30),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 10: SetWeather(33),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			case 11: SetWeather(-1337),SCM(playerid, COLOR_NEWS, " Погода изменена!");
			}
		}
	case 20011:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					SCM(playerid,0x83BFBFAA, "<1> /(a)dmin  /pm  /givecopkeys  /atazer /hi /hp /mutelist /getskill");
					SCM(playerid,0x83BFBFAA, "<1> /getstats /fid  /ajob  /ram  /kick  /mute /alock /aad /admins /ahelp");
					SCM(playerid,0x83BFBFAA, "<1> /togphone  /o  /unjail  /jail  /tjail /atipster /whonear /gmap");
				}
			case 1:
				{
					if(PTEMP[playerid][pAdmin] >= 2)
					{
						SCM(playerid,0x83BFBFAA, "<2> /spcar  /spwcar  /sduty  /gm  /re  /ban  /warn  /amembers");
						SCM(playerid,0x83BFBFAA, "<2> /iwep  /goto  /setskin /take /prison /banip /tp");
					}
					else return SCM(playerid,COLOR_GREY," У вас недостаточно прав");
				}
			case 2:
				{
					if(PTEMP[playerid][pAdmin] >= 3)
					{
						SCM(playerid,0x83BFBFAA, "<3> /gethere /mark  /gotomark /awarehouse /atune");
						SCM(playerid,0x83BFBFAA, "<3> /slap  /freeze  /unfreeze /spcars /geton /givemf");
					}
					else return SCM(playerid,COLOR_GREY," У вас недостаточно прав");
				}
			case 3:
				{
					if(PTEMP[playerid][pAdmin] >= 4)
					{
						SCM(playerid,0x83BFBFAA, "<4> /settime  /weather  /noooc  /olimit  /sp  /skick");
						SCM(playerid,0x83BFBFAA, "<4> /iban  /ioffban  /offban  /offwarn  /sban  /auninvite");
						SCM(playerid,0x83BFBFAA, "<4> /getip  /agetip  /pgetip  /apgetip  /unbanip  /setnik /spveh");
						SCM(playerid,0x83BFBFAA, "<4> /agetstats  /farm  /farmstats  /spveh  /getleader");
					}
					else return SCM(playerid,COLOR_GREY," У вас недостаточно прав");
				}
			case 4:
				{
					if(PTEMP[playerid][pAdmin] >= 5)
					{
						SCM(playerid,0x83BFBFAA, "<5> /makeleader  /givegun  /veh  /delcar  /sethp /fixveh  /fixvehs");
						SCM(playerid,0x83BFBFAA, "<5> /bantime  /unban  /arace  /paint /apanel /offuninvite  /offmembers");
						SCM(playerid,0x83BFBFAA, "<5> /hbject  /hbjectid  /setcasinoowner  /warnmans  /vipmans  /setsupport");
						SCM(playerid,0x83BFBFAA, "<5> /createvote /addvote /votelist /stopvote /actor /delactor");
					}
					else return SCM(playerid,COLOR_GREY," У вас недостаточно прав");
				}
			case 5:
				{
					if(PTEMP[playerid][pAdmin] >= 6)
					{
						SCM(playerid,0x83BFBFAA, "<6> /amusic  /obj  /object  /dobject  /eobject  /attach  /delattach /admmenu");
						SCM(playerid,0x83BFBFAA, "<6> /setspa  /getschet  /setarm  /gzcolor  /getobjectpos /splist /spmenu");
					}
					else return SCM(playerid,COLOR_GREY," У вас недостаточно прав");
				}
			case 6:
				{
					if(PTEMP[playerid][pAdmin] >= 7)
					{
						SCM(playerid,0x83BFBFAA, "<7> /addhouse  /sethousepos  /sethousecarpos  /setklass  /setcost");
						SCM(playerid,0x83BFBFAA, "<7> /setschet  /setkvartpos  /setkvartcarpos  /asellhouse /house");
						SCM(playerid,0x83BFBFAA, "<7> /biz  /setbcost  /addcbar  /setmats  /gotocar  /chat  /gm [id]");
						SCM(playerid,0x83BFBFAA, "<7> /agiverank  /agl  /cc  /forceskin  /unwarn  /booston  /boostoff");
						SCM(playerid,0x83BFBFAA, "<7> /delaccount  /setskill /setgrating  /alevel");
					}
					else return SCM(playerid,COLOR_GREY," У вас недостаточно прав");
				}


			case 7:
				{
					if(PTEMP[playerid][pAdmin] >= 8)
					{
						SCM(playerid,0x83BFBFAA, "<8> /unlockallkvart  /clearreconnect  /setallbizint  /getcampos  /setbproducts");
						SCM(playerid,0x83BFBFAA, "<8> /setbizbar  /setallbizworld  /setbizexit  /addstall  /addatm /addsbizz");
						SCM(playerid,0x83BFBFAA, "<8> /addeat  /addpizza  /addshop  /saveall  /asellbiz /restart");
					}
					else return SCM(playerid,COLOR_GREY," У вас недостаточно прав");
				}


			case 8:
				{
					if(PTEMP[playerid][pAdmin] >= 9)
					{
						SCM(playerid,0x83BFBFAA, "<9> /payday  /setstat  /setstatcar  /reloadbans  /createdonate  /edit  /offip  /smson");
                        SCM(playerid,0x83BFBFAA, "<9> /podeezd  /kvartira  /podcrt  /podcreate  /addmoderation  /addsupport");
                        SCM(playerid,0x83BFBFAA, "<9> /addkvarts - добавить квартиры на весь этаж  /spmenu, /admmenu - расширены");
					}
					else return SCM(playerid,COLOR_GREY," У вас недостаточно прав");
				}

			case 9:
				{
					if(PTEMP[playerid][pAdmin] >= 10)
					{
						SCM(playerid,0x83BFBFAA, "<> /setplayerskin  /rr  /money  /givemoney  /_ServerBonus");

					}
					else return SCM(playerid,COLOR_GREY," У вас недостаточно прав");
				}
			}
		}
	case 10025:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
			switch(listitem)
			{
			case 0: ShowPlayerDialogEx(playerid,1012,DIALOG_STYLE_INPUT, "Поиск команд", "Введите интересующую Вас команду, и получите её описание", "Готово", "Отмена");
			case 1:
				{
					SCM(playerid,COLOR_CMD," <> /time /heal /id /ids /setsex /gps /healaddict");
					SCM(playerid,COLOR_CMD," <> /instructors /divorce /propose /witness /deliver");
					SCM(playerid,COLOR_CMD," <> /drink /music /colorlist /myskill /pdd");
					SCM(playerid,COLOR_CMD," <> /sell /busdrivers /eat /licenses /ratingnews");
					SCM(playerid,COLOR_CMD," <> /showlicenses /get /cancel /accept /animlist");
					SCM(playerid,COLOR_CMD," <> /eject /quitjob /buy /pay");
					SCM(playerid,COLOR_CMD," <> /usedrugs /radio /quest");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 2:
				{
					SCM(playerid,COLOR_CMD," <> /(o)oc - Глобальный чат");
					SCM(playerid,COLOR_CMD," <> /(ad)vertise - Объявления");
					SCM(playerid,COLOR_CMD," <> /(gov)ernment - Государственные новости");
					SCM(playerid,COLOR_CMD," <> /(f)amily - Чат организации");
					SCM(playerid,COLOR_CMD," <> /(s)hout - Крик");
					SCM(playerid,COLOR_CMD," <> /(m)egaphone - Мегафон на полицейских машинах");
					SCM(playerid,COLOR_CMD," <> /(r)adio - Чат государственных организаций (Полиция/ФБР и т.д.)");
					SCM(playerid,COLOR_CMD," <> /(d)epartments - Общий чат государственных организаций");
					SCM(playerid,COLOR_CMD," <> /me - Действие (Имя_Фамилия пожал руку)");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 3:
				{
					SCM(playerid,COLOR_CMD," <> /(c)all - Позвонить (Номер телефона можно узнать через /number)");
					SCM(playerid,COLOR_CMD," <> /sms - Отправить СМС сообщение");
					SCM(playerid,COLOR_CMD," <> /(p)ickup - Ответить на звонок");
					SCM(playerid,COLOR_CMD," <> /(h)angup - Завершить телефонный разговор");
					SCM(playerid,COLOR_CMD," <> /directory /number /togphone");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 4:
				{
					SCM(playerid,COLOR_CMD," <> /withdraw - Снять деньги со счёта");
					SCM(playerid,COLOR_CMD," <> /bank - Положить деньги на счёт");
					SCM(playerid,COLOR_CMD," <> /balance - Узнать баланс счёта");
					SCM(playerid,COLOR_CMD," <> /transfer - Перевести деньги со счёта на счёт");
					SCM(playerid,COLOR_CMD," <> /housebank - Перевести деньги со счёта на домашний счёт");
					SCM(playerid,COLOR_CMD," <> /atm - Меню банкомата");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 5:
				{
					SCM(playerid,COLOR_CMD," <> /fixcar - Обновить / Телепортировать автомобиль к дому");
					SCM(playerid,COLOR_CMD," <> /home - Поставить метку у дома (GPS)");
					SCM(playerid,COLOR_CMD," <> /spawnchange - Сменить респавн(возрождение) ДОМ <==> База организации");
					SCM(playerid,COLOR_CMD," <> /healme - Использовать аптечку");
					SCM(playerid,COLOR_CMD," <> /open /enter /exit");
					SCM(playerid,COLOR_CMD," <> /sellhouse /buyhouse");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 6:
				{
					SCM(playerid,COLOR_CMD," <> /buybiz - Купить бизнес");
					SCM(playerid,COLOR_CMD," <> /sellbiz - Продать бизнес");
					SCM(playerid,COLOR_CMD," <> /bizlock - Закрыть / Открыть бизнес");
					SCM(playerid,COLOR_CMD," <> /bizstats /getbizstats - Статистика бизнеса");
					SCM(playerid,COLOR_CMD," <> /bizfee - Установить цену за товар");
					SCM(playerid,COLOR_CMD," <> /bizwithdraw - Снять деньги с бизнеса");
					SCM(playerid,COLOR_CMD," <> /bizbank - Перевести на счёт или оплатить электроэнергию");
					SCM(playerid,COLOR_CMD," <> /bizenterc - Установить цену входа (Только клубам / барам / ресторанам)");
					SCM(playerid,COLOR_CMD," <> /bizmafia - Установить крышу");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 7: SCM(playerid,COLOR_CMD," <> /fish - Меню рыбалки"),CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
			case 8:
				{
					SCM(playerid,COLOR_CMD," <> [Развозчик] /prodmenu");
					SCM(playerid,COLOR_CMD," <> [Хот дог] /hcontract /selleat /hcounter");
					SCM(playerid,COLOR_CMD," <> [Механик] /refill /repair /mcontract");
					SCM(playerid,COLOR_CMD," <> [Такси/Автобус] /fare /route");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 9:
				{
					SCM(playerid,COLOR_CMD," <> /invite - Принять в огранизацию");
					SCM(playerid,COLOR_CMD," <> /uninvite - Выгнать / Уволить из организации");
					SCM(playerid,COLOR_CMD," <> /giverank - Повысить / Понизить ранг в организации");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 10:
				{
					SCM(playerid,COLOR_CMD," <> /newsbank");
					SCM(playerid,COLOR_CMD," <> /ratingnews");
					SCM(playerid,COLOR_CMD," <> /(n)ews");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 11:
				{
					SCM(playerid,COLOR_CMD," <> /tazer");
					SCM(playerid,COLOR_CMD," <> /settax");
					SCM(playerid,COLOR_CMD," <> /gettax");
					SCM(playerid,COLOR_CMD," <> /free");
					SCM(playerid,COLOR_CMD," <> /government");
					SCM(playerid,COLOR_CMD," <> /radio");
					SCM(playerid,COLOR_CMD," <> /departments");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 12:
				{
					SCM(playerid,COLOR_CMD," <> /instopen /duty /itazer");
					SCM(playerid,COLOR_CMD," <> Инструкторам доступно клик меню ([?]двойной клик по нику игрока в ТАБ)");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 13:
				{
					SCM(playerid,COLOR_CMD," <> /ram /take /frisk /tazer");
					SCM(playerid,COLOR_CMD," <> /cuff /follow /uncuff /find /wanted");
					SCM(playerid,COLOR_CMD," <> /clear /ticket /arrest /(gov)ernment");
					SCM(playerid,COLOR_CMD," <> /givecopkeys /(m)egaphone /(r)adio /(d)epartments");
					SCM(playerid,COLOR_CMD," <> /mdc /(su)spect /demote");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 14:
				{
					SCM(playerid,COLOR_CMD," <> [Банды] /gbankput /gbankwithdraw /gbank");
					SCM(playerid,COLOR_CMD," <> [Банды] /selldrugs /sellgun /sellzone /capture /get guns");
					SCM(playerid,COLOR_CMD," <> [Банды] /warehouse /materials /unloading");
					SCM(playerid,COLOR_CMD," <> [Мафии] /tie /untie /mafiawar /бизлист(/bizlist)");
					SCM(playerid,COLOR_CMD," <> [Мафии] /mafiabank /mafiawithdraw /mafiabalance");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			case 15:
				{
					SCM(playerid,COLOR_CMD," <> /rentcar /unrentcar - Взять на прокат / Вернуть автомобиль");
					SCM(playerid,COLOR_CMD," <> /buycar /sellcar /changecar - Купить / Продать / Передать автомобиль");
					SCM(playerid,COLOR_CMD," <> /fill /fillcar - Заправить автомобиль на заправке или с канистры");
					SCM(playerid,COLOR_CMD," <> /slimit - Вкл / Выкл ограничитель скорости");
					SCM(playerid,COLOR_CMD," <> /carpass - Показать / Посмотреть документы на автомобиль");
					SCM(playerid,COLOR_CMD," <> /lock - Открыть / Закрыть автомобиль");
					return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
				}
			}
		}
	case 2001:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: SetPlayerColor(playerid, TEAM_HIT_COLOR);
			case 1: SetPlayerColor(playerid,0x089401FF);
			case 2: SetPlayerColor(playerid,0x56FB4EFF);
			case 3: SetPlayerColor(playerid,0x49E789FF);
			case 4: SetPlayerColor(playerid,0x2A9170FF);
			case 5: SetPlayerColor(playerid,0x9ED201FF);
			case 6: SetPlayerColor(playerid,0x279B1EFF);
			case 7: SetPlayerColor(playerid,0x51964DFF);
			case 8: SetPlayerColor(playerid,0xFF0606FF);
			case 9: SetPlayerColor(playerid,0xFF6600FF);
			case 10: SetPlayerColor(playerid,0xF45000FF);
			case 11: SetPlayerColor(playerid,0xBE8A01FF);
			case 12: SetPlayerColor(playerid,0xB30000FF);
			case 13: SetPlayerColor(playerid,0x954F4FFF);
			case 14: SetPlayerColor(playerid,0xE7961DFF);
			case 15: SetPlayerColor(playerid,0xE6284EFF);
			case 16: SetPlayerColor(playerid,0xFF9DB6FF);
			case 17: SetPlayerColor(playerid,0x110CE7FF);
			case 18: SetPlayerColor(playerid,0x0CD7E7FF);
			case 19: SetPlayerColor(playerid,0x139BECFF);
			case 20: SetPlayerColor(playerid,0x2C9197FF);
			case 21: SetPlayerColor(playerid,0x114D71FF);
			case 22: SetPlayerColor(playerid,0x8813E7FF);
			case 23: SetPlayerColor(playerid,0xB313E7FF);
			case 24: SetPlayerColor(playerid,0x758C9DFF);
			case 25: SetPlayerColor(playerid,0xFFDE24FF);
			case 26: SetPlayerColor(playerid,0xFFEE8AFF);
			case 27: SetPlayerColor(playerid,0xDDB201FF);
			case 28: SetPlayerColor(playerid,0xDDA701FF);
			case 29: SetPlayerColor(playerid,0xB0B000FF);
			case 30: SetPlayerColor(playerid,0x868484FF);
			case 31: SetPlayerColor(playerid,0xB8B6B6FF);
			case 32: SetPlayerColor(playerid,0x333333FF);
			case 33: SetPlayerColor(playerid,0xFAFAFAFF);
			}
		}
	case 1012:
		{
			if(!response) return true;
			if(!strcmp(inputtext, "/time",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /time  - узнать время");
			}
			else if(!strcmp(inputtext, "/gps",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /gps  - навигатор");
			}
			else if(!strcmp(inputtext, "/viphelp",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /viphelp  - помощь по VIP функциям");
			}
			else if(!strcmp(inputtext, "/drink",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /drink  - выпить");
			}
			else if(!strcmp(inputtext, "/directory",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /directory  - справочник");
			}
			else if(!strcmp(inputtext, "/eject",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /eject  - выбросить из машины");
			}
			else if(!strcmp(inputtext, "/dice",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /dice  - бросить кости");
			}
			else if(!strcmp(inputtext, "/clist",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /clist - цвета");
			}
			else if(!strcmp(inputtext, "/usedrugs",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /usedrugs - употребить наркотики");
			}
			else if(!strcmp(inputtext, "/showpass",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /showpass - показать паспорт");
			}
			else if(!strcmp(inputtext, "/myskill",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /myskill - навыки оружия");
			}
			else if(!strcmp(inputtext, "/hi",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /hi - пожать руку");
			}
			else if(!strcmp(inputtext, "/id",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /id - узнать id игрока");
			}
			else if(!strcmp(inputtext, "/ids",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> /ids - узнать id игроков с указанным ником");
			}
			else if(!strcmp(inputtext, "/o",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> (/o)oc - Глобальный чат");
			}
			else if(!strcmp(inputtext, "/ad",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> (/ad)vertise - Объявление");
			}
			else if(!strcmp(inputtext, "/gov",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> (/gov)erment - Государственные новости");
			}
			else if(!strcmp(inputtext, "/f",true))
			{
				SCM(playerid, 0x83BFBFAA, "<> (/f)amily - Чат организации");
			}
			else if(!strcmp(inputtext, "/s",true))
			{
				SCM(playerid,0x83BFBFAA, "<> (/s)hout - Крик");
			}
			else if(!strcmp(inputtext, "/m",true))
			{
				SCM(playerid,0x83BFBFAA, "<> (/m)egaphone - Мегафон на служебном транспорте");
			}
			else if(!strcmp(inputtext, "/r",true))
			{
				SCM(playerid,0x83BFBFAA, "<> (/r)adio - Чат государственных организаций (Полиция/ФБР и т.д)");
			}
			else if(!strcmp(inputtext, "/d",true))
			{
				SCM(playerid,0x83BFBFAA, "<> (/d)epartaments - Общий чат государственных организаций");
			}
			else if(!strcmp(inputtext, "/me",true))
			{
				SCM(playerid,0x83BFBFAA, "<> (/me) - Действие (Пример: Имя_Фамилия пожал руку)");
			}
			else if(!strcmp(inputtext, "/call",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /call - Позвонить (Номер телефона можно узнать через /number)");
			}
			else if(!strcmp(inputtext, "/sms",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /sms - Отправить СМС сообщение");
			}
			else if(!strcmp(inputtext, "/number",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /number - узнать номер игрока");
			}
			else if(!strcmp(inputtext, "/h",true))
			{
				SCM(playerid,0x83BFBFAA, "<> (/h)angup - Завершить телефонный разговор");
			}
			else if(!strcmp(inputtext, "/p",true))
			{
				SCM(playerid,0x83BFBFAA, "<> (/p)ickup - Ответить на звонок");
			}
			else if(!strcmp(inputtext, "/togphone",true))
			{
				SCM(playerid,0x83BFBFAA, "<> togphone - выкл. телефон");
			}
			else if(!strcmp(inputtext, "/hpanel",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /hpanel - Главное меню(Настройки дома)");
			}
			else if(!strcmp(inputtext, "/home",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /home - Поставить метку у дома (GPS)");
			}
			else if(!strcmp(inputtext, "/spawnchange",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /spawnchange - Сменить респавн(Возрождение) ДОМ <==> База организации");
			}
			else if(!strcmp(inputtext, "/healme",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /healme - Использовать аптечку");
			}
			else if(!strcmp(inputtext, "/buybiz",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /buybiz - Купить бизнес");
			}
			else if(!strcmp(inputtext, "/bizstats",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /bizstats - Статистика бизнеса");
			}
			else if(!strcmp(inputtext, "/bizwithdraw ",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /bizwithdraw - Снять деньги с бизнеса");
			}
			else if(!strcmp(inputtext, "/bizfee",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /bizfee - Установить цену за товар");
			}
			else if(!strcmp(inputtext, "/sellbiz",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /sellbiz - Продать бизнес");
			}
			else if(!strcmp(inputtext, "/changehouse",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /changehouse - Продать дом другому человеку или же совершить обмен.");
			}
			else if(!strcmp(inputtext, "/invite",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /invite - Пригласить человека во фракцию");
			}
			else if(!strcmp(inputtext, "/uninvite",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /uninvite - Выгнать человека из фракции");
			}
			else if(!strcmp(inputtext, "/giverank",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /giverank - Повысить/Понизить игрока в ранге");
			}
			else if(!strcmp(inputtext, "/tie",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /tie - Связать заложника. Доступно только мафиям");
			}
			else if(!strcmp(inputtext, "/untie",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /untie - Развязать заложника. Доступно только мафиям");
			}
			else if(!strcmp(inputtext, "/heal",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /heal - Вылечить человека в карете скорой помощи. Доступно только медикам");
			}
			else if(!strcmp(inputtext, "/getgun",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /getgun - Взять оружие со склада мафии");
			}
			else if(!strcmp(inputtext, "/mafiabalance",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /mafiabalance - Проверить счёт мафии в банке");
			}
			else if(!strcmp(inputtext, "/mafiawithdraw",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /mafiawithdraw - Снять деньги со счёта мафии");
			}
			else if(!strcmp(inputtext, "/mafiabank",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /mafiabank - Положить деньги на счёт мафии");
			}
			else if(!strcmp(inputtext, "/ram",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /ram - Выбить дверь. Только законники");
			}
			else if(!strcmp(inputtext, "/cuff",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /cuff - Надеть наручники. Только законники");
			}
			else if(!strcmp(inputtext, "/follow",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /follow - Вести за собой престуника");
			}
			else if(!strcmp(inputtext, "/uncuff",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /uncuff - Снять наручники. Только законники");
			}
			else if(!strcmp(inputtext, "/givecopkeys",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /givecopkeys - Выдать ключи от полицейского участка");
			}
			else if(!strcmp(inputtext, "/arrest",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /arrest - Посадить преступника в камеру. Необходимо находиться в здании тюрьмы");
			}
			else if(!strcmp(inputtext, "/warehouse",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /warehouse - Проверить склад организации");
			}
			else if(!strcmp(inputtext, "/take",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /take - Отобрать у человека запрещённые предметы. Только законники");
			}
			else if(!strcmp(inputtext, "/frisk",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /frisk - Обыскать человека на запрещённые предметы. Только законники");
			}
			else if(!strcmp(inputtext, "/su",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /(su)spect - Добавить человека в список разыскиваемых. Только законники");
			}
			else if(!strcmp(inputtext, "/suspect",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /(su)spect - Добавить человека в список разыскиваемых. Только законники");
			}
			else if(!strcmp(inputtext, "/tazer",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /tazer - Сменить пули");
			}
			else if(!strcmp(inputtext, "/wanted",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /wanted - Посмотреть список разыскиваемых. Только законники");
			}
			else if(!strcmp(inputtext, "/demote",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /demote - Повысить/Понизить законника. Только для ФБР");
			}
			else if(!strcmp(inputtext, "/gbank",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /gbank - Проверить счёт мафии в банке");
			}
			else if(!strcmp(inputtext, "/gbankput",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /gbankput - Положить деньги на счёт банды");
			}
			else if(!strcmp(inputtext, "/gbankwhisdraw",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /gbankwhisdraw - Снять деньги со счёта банды");
			}
			else if(!strcmp(inputtext, "/getbizstats",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /getbizstats - Проверить бизнес");
			}
			else if(!strcmp(inputtext, "/mafiawar",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /mafiawar - Назначить стрелу");
			}
			else if(!strcmp(inputtext, "/fare",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /fare - Начать работу таксистом");
			}
			else if(!strcmp(inputtext, "/mcontract",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /mcontract - Заключить контракт с заправкой. Механики");
			}
			else if(!strcmp(inputtext, "/sellgrib",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /sellgrib - Продать грибы");
			}
			else if(!strcmp(inputtext, "/clear",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /clear - Снять розыск. Только для законников");
			}
			else if(!strcmp(inputtext, "/refill",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /refill - Заправить автомобиль топливом. Для механников");
			}
			else if(!strcmp(inputtext, "/prodmenu",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /prodmenu - Загрузить продукты. Для развозчиков");
			}
			else if(!strcmp(inputtext, "/repair",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /repair - Подчинить повреждённый автомобиль. Для механников");
			}
			else if(!strcmp(inputtext, "/route",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /route - Начать работу водителя автобуса");
			}
			else if(!strcmp(inputtext, "/fixcar",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /fixcar - Отбуксировать домашний автомобиль к дому");
			}
			else if(!strcmp(inputtext, "/newsbank",true))
			{
				SCM(playerid,0x83BFBFAA, "<> /newsbank -  Баланс денежных средств в News");
			}
			return true;
		}
	case 14:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
			if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid,14,DIALOG_STYLE_INPUT, "Введите ключ", "Введите новый ключ безопасности", "Готово", "Назад");
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pKeyip = '%e' WHERE name = '%e'",inputtext,PTEMP[playerid][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");
			PTEMP[playerid][pCheckip] = 1;
			format(string, 144, " Вы успешно сменили ключ. Ваш новый: %s", inputtext);
			SCM(playerid, 0x2ddd13aa, string);
			return true;
		}
	case 11:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
			if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid,11,DIALOG_STYLE_INPUT, "Смена пароля", "Чтобы не подвергнуть аккаунт взлому, рекомедуем придумать трудный пароль.\nСодержащий набор букв и цифр", "Сменить", "Назад");
			if(strlen(inputtext) < 6 || strlen(inputtext) > 16) return ShowPlayerDialogEx(playerid,11,DIALOG_STYLE_MSGBOX,"Ошибка!","{FF6347}Длина пароля должна быть от 6 до 16","Повтор","");
			mysql_format(DATABASE, QUERY, 128, "UPDATE `"TABLE_ACCOUNTS"` SET pKey = '%e' WHERE name = '%e'",inputtext,PTEMP[playerid][pName]);
			mysql_function_query(DATABASE,QUERY,false,"","");
			format(string, 128, " Вы успешно сменили пароль. Ваш новый: %s", inputtext);
			SCM(playerid, 0x2ddd13aa, string);
			return true;
		}
	case 9653:
		{
			if(!response) return true;
			if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 19 || proverkaforma[playerid] == 1)
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 433) return SCM(playerid,COLOR_GREY, " Вы не в матовозе!");
				switch(listitem)
				{
				case 0:
					{
						SCM(playerid,COLOR_GREEN, " Встаньте на красный маркер, чтобы заполнить грузовик материалами!");
						SetPlayerCheckpoint(playerid,335.9255,1994.7932,17.6406,8.0);
						MatsArmyCar[playerid]=20;
						return true;
					}
				case 1:
					{
						if(!PlayerToPoint(10.0,playerid,334.9307,1962.9658,17.6406)) return	SCM(playerid,COLOR_GREY, " Вы не у разгрузочной зоны!");
						new tmpcar = GetPlayerVehicleID(playerid);
						if(MatHaul[tmpcar-gunscar[0]][mLoad] <= 0) return SCM(playerid, COLOR_GRAD1, " В матовозе нет оружия!");
						armmatbi += MatHaul[tmpcar-gunscar[0]][mLoad];
						MatHaul[tmpcar-gunscar[0]][mLoad] =0;
						format(string, 144, " Оружие выгружено! В грузовике: %i/10000", MatHaul[tmpcar-gunscar[0]][mLoad]);
						SCM(playerid, TEAM_GROVE_COLOR, string);
						return true;
					}
				case 2:
					{
						SetPlayerCheckpoint(playerid,2745.2368,-2463.9832,13.6484,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=151;
						return true;
					}
				case 3:
					{
						SetPlayerCheckpoint(playerid,-1601.8774,309.4032,7.1875,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=21;
						return true;
					}
				case 4:
					{
						SetPlayerCheckpoint(playerid,1529.6000,-1691.2000,13.3828,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=31;
						return true;
					}
				case 5:
					{
						SetPlayerCheckpoint(playerid,-2429.1721,490.0948,29.9279,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=24;
						return true;
					}
				case 6:
					{
						SetPlayerCheckpoint(playerid,-1607.2913,683.5955,-5.2422,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=35;
						return true;
					}
				case 7:
					{
						SetPlayerCheckpoint(playerid,2292.0837,2458.9941,10.8203,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=150;
						return true;
					}
				case 8:
					{
						new listitems[] = " [1] Разгрузка The Ballas\n [2] Разгрузка The Vagos\n [3] Разгрузка The Grove\n [4] Разгрузка The Aztec\n [5] Разгрузка The Rifa";
						ShowPlayerDialogEx(playerid, 3232, DIALOG_STYLE_LIST, " Развозка материалов бандам", listitems, "Выбрать", "Отмена");
						return true;
					}
				case 9:
					{
						new listitems[] = " [1] Разгрузка Hell's Angels MC\n [2] Разгрузка Warlocks MC\n [3] Разгрузка Pagans MC";
						ShowPlayerDialogEx(playerid, 3233, DIALOG_STYLE_LIST, " Развозка материалов байкерам", listitems, "Выбрать", "Отмена");
						return true;
					}
				}
			}
		}
	case 3232:
		{
			if(!response) return true;
			if (GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 19 || proverkaforma[playerid] == 1)
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 433) return SCM(playerid,COLOR_GREY, " Вы не в матовозе!");
				switch(listitem)
				{
				case 0:
					{
						SetPlayerCheckpoint(playerid,2645.9717,-2005.8618,13.3828,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=100;
						return true;
					}
				case 1:
					{
						SetPlayerCheckpoint(playerid,2795.7639,-1619.4196,10.9219,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=101;
						return true;
					}
				case 2:
					{
						SetPlayerCheckpoint(playerid,2489.2656,-1670.0692,13.3359,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=102;
						return true;
					}
				case 3:
					{
						SetPlayerCheckpoint(playerid,1806.0304,-2111.7974,13.3828,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=103;
						return true;
					}
				case 4:
					{
						SetPlayerCheckpoint(playerid,2176.5503,-1803.5483,13.3692,6.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=104;
						return true;
					}
				}
			}
		}
	case 3233:
		{
			if(!response) return true;
			if(GetPVarInt(playerid,"Fraction_Duty") && PTEMP[playerid][pMember] == 19 || proverkaforma[playerid] == 1)
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 433) return SCM(playerid,COLOR_GREY, " Вы не в матовозе!");
				switch(listitem)
				{
				case 0: //Hell's
					{
						SetPlayerCheckpoint(playerid,681.5627,-473.9190,16.5363,10.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=61;
						return true;
					}
				case 1: // Warlocks
					{
						SetPlayerCheckpoint(playerid,662.8604,1716.4194,7.1875,10.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=63;
						return true;
					}
				case 2:// Pagans
					{
						SetPlayerCheckpoint(playerid,-2105.8921,-2480.8372,30.6250,10.0);
						SCM(playerid, -1, " Метка на карте указана в виде красного маркера");
						MatsArmyCar[playerid]=66;
						return true;
					}
				}
			}
		}
	case 2323:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
			switch(listitem)
			{
			case 0:
				{
					if(PTEMP[playerid][pCheckip] == 1)
					{
						PTEMP[playerid][pCheckip] = 0;
						SCM(playerid, -1, " Проверка по IP адресу отключена");
						return true;
					}
					if(!PTEMP[playerid][pActivemail]) return SCM(playerid,COLOR_GREY," Для начала активируйте e-mail");
					ShowPlayerDialogEx(playerid,14,DIALOG_STYLE_INPUT, "Введите ключ", "У вас не установлен ключ безопасности!\nОт 5 до 16 символов", "Готово", "Назад");
					return true;
				}
			case 1:
				{
					if(!PTEMP[playerid][pActivemail]) return SCM(playerid,COLOR_GREY," Для начала активируйте e-mail");
					ShowPlayerDialogEx(playerid,14,DIALOG_STYLE_INPUT, "Сменить ключ", "Введите ваш новый ключ безопасности", "Готово", "Назад");
					return true;
				}
			case 2:
				{
					new rulesdialog[400];
					format(rulesdialog,sizeof(rulesdialog), "%s%s%s%s%s",IPMSG[0],IPMSG[1],IPMSG[2],IPMSG[3],IPMSG[4]);
					ShowPlayerDialogEx(playerid,165,DIALOG_STYLE_MSGBOX, "INFO",rulesdialog, "Готово", "");
				}
			case 3:
				{
				    if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
				    {
						format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмэил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
					}
					else
					{
					    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
					}
					ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
					return true;
				}
			case 4:
			    {
			        ShowPlayerDialogEx(playerid, 2324,DIALOG_STYLE_LIST, "Меню", "[0] Сгенерировать ключ\n[1] Отключить", "Выбор", "Назад");
			        return true;
			    }
			}
		}
	case 2324:
	    {
	        if(!response)
	        {
	            ShowPlayerDialogEx(playerid, 2323, DIALOG_STYLE_LIST, "Безопасность", "[1] Вкл / Откл проверку по IP\n[2] Сменить ключ\n[3] Помощь\n[4] Эмаил\n[5] Google Authenticator", "Выбрать", "Назад");
	            return true;
	        }
	        else
	        {
	            if(listitem == 0)
	            {
	                if(PTEMP[playerid][pCheckip] == 0) return SCM(playerid, COLOR_LIGHTRED, " Необходимо включить защиту по IP!");
	                ShowPlayerDialogEx(playerid, 2325, DIALOG_STYLE_PASSWORD, "Ввод параметра", "Введите свой основной пароль", "Выбрать", "Назад");
	            }
	            else if(listitem == 1)
	            {
					if(PTEMP[playerid][pGoogleIP] == 1)
					ShowPlayerDialogEx(playerid, 2326, DIALOG_STYLE_PASSWORD, "Ввод параметра", "Введите гугл-код", "Выбрать", "Назад");
	            }
	        }
  		}
	case 2325:
	    {
	        if(!response)
	        {
	       		ShowPlayerDialogEx(playerid, 2324,DIALOG_STYLE_LIST, "Меню", "[0] Сгенерировать ключ\n[1] Отключить", "Выбор", "Назад");
	        	return true;
	        }
	        else
	        {
	            
	            if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid, 2325, DIALOG_STYLE_PASSWORD, "Ввод параметра", "Введите свой основной пароль", "Выбрать", "Назад");
	            if(strcmp(inputtext, PTEMP[playerid][pKey], false)) return SCM(playerid, COLOR_LIGHTRED, " Вы ввели неверный пароль"), ShowPlayerDialogEx(playerid, 2325, DIALOG_STYLE_PASSWORD, "Ввод параметра", "Введите свой основной пароль", "Выбрать", "Назад");
	            else
	            {
	                new secretkey[17];
	                for(new i = 0; i < 17; i ++) strcat(secretkey, googleauth[random(sizeof(googleauth))]);
	                SetPVarString(playerid, "GoogleKey", secretkey);
					format(string, sizeof(string), "Ваш секретный ключ: %s\nВведите его в программе Google Authenticator\n\nВведите гугл-код для сохранения настроек", secretkey);
					ShowPlayerDialogEx(playerid, 2327, DIALOG_STYLE_INPUT, "Ввод параметра", string, "Выбрать", "Назад");
	            }
	        }
	    }
	case 2326:
	    {
	        if(!response)
	        {
	       		ShowPlayerDialogEx(playerid, 2324,DIALOG_STYLE_LIST, "Меню", "[0] Сгенерировать ключ\n[1] Отключить", "Выбор", "Назад");
	        	return true;
	        }
	        else
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid, 2326, DIALOG_STYLE_PASSWORD, "Ввод параметра", "Введите гугл-код", "Выбрать", "Назад");
	            new mustGoogleKey = GoogleAuthenticatorCode(PTEMP[playerid][pGoogleKey], gettime());
	            if(strval(inputtext) != mustGoogleKey)
	            {
	            	return ShowPlayerDialogEx(playerid, 2326, DIALOG_STYLE_PASSWORD, "Ввод параметра", "Введите гугл-код", "Выбрать", "Назад");
	            }
	            else
	            {
	                SCM(playerid, COLOR_GREEN, " Изменения приняты");
	                mysql_format(DATABASE,QUERY,128, "UPDATE accounts SET pGoogleIP = '0' WHERE name = '%s'", PTEMP[playerid][pName]);
					mysql_function_query(DATABASE,QUERY,false,"","");
					PTEMP[playerid][pGoogleIP] = 0;
	            }
	        }
	    }
	case 2327:
		{
	        if(!response) return ShowPlayerDialogEx(playerid, 2325, DIALOG_STYLE_PASSWORD, "Ввод параметра", "Введите свой основной пароль", "Выбрать", "Назад");
	        else
	        {
	            new GoogleKey[17];
	            GetPVarString(playerid, "GoogleKey", GoogleKey, sizeof(GoogleKey));
	            DeletePVar(playerid, "GoogleKey");
				new mustGoogleKey = GoogleAuthenticatorCode(GoogleKey, gettime());
	            if(strval(inputtext) != mustGoogleKey)
	            {
	                SCM(playerid, COLOR_LIGHTRED, " Вы ввели не верный код");
	                new secretkey[17];
	                for(new i = 0; i < 17; i ++) strcat(secretkey, googleauth[random(sizeof(googleauth))]);
	                SetPVarString(playerid, "GoogleKey", secretkey);
					format(string, sizeof(string), "Ваш секретный ключ: %s\nВведите его в программе Google Authenticator\n\nВведите гугл-код для сохранения настроек", secretkey);
					ShowPlayerDialogEx(playerid, 2327, DIALOG_STYLE_INPUT, "Ввод параметра", string, "Выбрать", "Назад");
	            }
	            else
	            {
	                SCM(playerid, COLOR_GREEN, " Изменения приняты");
					mysql_format(DATABASE,QUERY,128, "UPDATE accounts SET pGoogleIP = '1', pGoogleKey = '%s' WHERE name = '%s'", GoogleKey, PTEMP[playerid][pName]);
					mysql_function_query(DATABASE,QUERY,false,"","");
					PTEMP[playerid][pGoogleIP] = 1;
	            }
	        }
		}
	case 35:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 2323, DIALOG_STYLE_LIST, "Безопасность", "[1] Вкл / Откл проверку по IP\n[2] Сменить ключ\n[3] Помощь\n[4] Эмаил\n[5] Google Authenticator", "Выбрать", "Назад");
			switch(listitem)
			{
			    case 0:
			    {
			        if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
			        {
			            SCM(playerid, -1, " Ожидание...");
                        new randpass = 10000 + random(99999);
                        SetPVarInt(playerid, "mail_key", randpass);
			            
						format(string, sizeof (string), "to=%s&subject=Код подтверждения Е-мэйл&text=Код подтверждения Е-мэйл: %i<br><br> ---<br> С уважением,<br> Entropy Role Play<br> http://samp-rp.ru<br><br> Не отвечайте на это письмо если вы считаете, что данное письмо пришло к вам по ошибке.", PTEMP[playerid][pEmail], randpass);
			            HTTP(1, HTTP_POST, "website.com/sendmail.php", string, "MyHttpResponse");

			            if (PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
					    {
							format(string, sizeof (string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
						}
						else
						{
						    format(string, sizeof (string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
						}
						ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
			        }
			        else
			        {
						SCM(playerid, COLOR_GREY, " Вы уже сняли блокировку");
						if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
					    {
							format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
						}
						else
						{
						    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
						}
						ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
						return true;
					}
			    }
			    case 1:
			    {
			    	if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
			    	{
			            ShowPlayerDialogEx(playerid, 36, DIALOG_STYLE_INPUT, "Эмаил", "Введите код, который был отправлен на вашу почту в строке ниже", "Далее", "Назад");
			        }
			        else
			        {
						SCM(playerid, COLOR_GREY, " Вы уже сняли блокировку");
						if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
					    {
							format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
						}
						else
						{
						    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
						}
						ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
						return true;
					}
			    }
				case 2:
				{
					if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
					{
						SCM(playerid, COLOR_GREY, " Необходимо разблокировать");
						if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
					    {
							format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
						}
						else
						{
						    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
						}
						ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
						return true;
					}
					ShowPlayerDialogEx(playerid, 37, DIALOG_STYLE_INPUT, "Эмаил", "Введите новый эмаил адрес вашего аккаунта", "Далее", "Назад");
				}
				case 3:
				{
					if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
					{
						SCM(playerid, COLOR_GREY, " Вы уже активировали Эмаил");
						if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
					    {
							format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
						}
						else
						{
						    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
						}
						ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
						return true;
					}
                    SCM(playerid, -1, " Ожидание...");
                    new randpass = 10000 + random(99999);
                    SetPVarInt(playerid, "mail_key", randpass);

		            format(string, sizeof (string), "to=%s&subject=Код подтверждения Е-мэйл&text=Код подтверждения Е-мэйл: %i<br><br> ---<br> С уважением,<br> Entropy Role Play<br> http://samp-rp.ru<br><br> Не отвечайте на это письмо если вы считаете, что данное письмо пришло к вам по ошибке.", PTEMP[playerid][pEmail], randpass);
		            HTTP(playerid, HTTP_POST, "website.com/sendmail.php", string, "MyHttpResponse");

		            if (PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
				    {
						format(string, sizeof (string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
					}
					else
					{
					    format(string, sizeof (string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
					}
					ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
				}
				case 4:
				{
					if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
					{
						SCM(playerid, COLOR_GREY, " Вы уже активировали Эмаил");
						if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
					    {
							format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
						}
						else
						{
						    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
						}
						ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
						return true;
					}
					ShowPlayerDialogEx(playerid, 38, DIALOG_STYLE_INPUT, "Эмаил", "Введите код подтверждения, который был отправлен на вашу почту", "Далее", "Назад");
				}
			}
		}
	case 36:
	    {
	        if(!response) 
	        {
	            if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
			    {
					format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмэил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
				}
				else
				{
				    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
				}
				ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
	        }
	        if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 36, DIALOG_STYLE_INPUT, "Эмаил", "Введите код, который был отправлен на вашу почту в строке ниже", "Далее", "Назад");
	        if(strval(inputtext) != GetPVarInt(playerid, "mail_key"))
	        {
	            SCM(playerid, COLOR_GREY, " Вы ввели неверный код подтверждения!");
	            if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
			    {
					format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
				}
				else
				{
				    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
				}
				ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
	            return true;
	        }
	        else
	        {
	            SetPVarInt(playerid, "mail_access", 1);
				PTEMP[playerid][pActivemail] = 0;
				DeletePVar(playerid, "mail_key");
	            SCM(playerid, -1, " Ожидание...");
	            SCM(playerid, COLOR_YELLOW, " Блокировка снята. Теперь вы можете сменить Эмэил адрес");
	            if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
			    {
					format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
				}
				else
				{
				    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
				}
				ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
	        }
	    }
	case 37:
	    {
	        if(!response) 
	        {
	            if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
			    {
					format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмэил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
				}
				else
				{
				    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
				}
				ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
	        }
	        if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid, 37, DIALOG_STYLE_INPUT, "Эмаил", "Введите новый эмаил адрес вашего аккаунта", "Далее", "Назад");
			strmid(PTEMP[playerid][pEmail], inputtext, 0, strlen(inputtext), 128);
			SendMes(playerid, -1, " Вы успешно сменили Эмэил адрес на %s", PTEMP[playerid][pEmail]);
			if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
		    {
				format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
			}
			else
			{
			    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
			}
			ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
	    }
	case 38:
	    {
	        if(!response)
	        {
	            if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
			    {
					format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмэил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
				}
				else
				{
				    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
				}
				ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
	        }
	        if(!strval(inputtext)) return ShowPlayerDialogEx(playerid, 36, DIALOG_STYLE_INPUT, "Эмаил", "Введите код, который был отправлен на вашу почту в строке ниже", "Далее", "Назад");
	        if(strval(inputtext) != GetPVarInt(playerid, "mail_key"))
	        {
	            SCM(playerid, COLOR_GREY, " Вы ввели неверный код подтверждения!");
	            if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
			    {
					format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
				}
				else
				{
				    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
				}
				ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
	            return true;
	        }
	        else
	        {
	            SetPVarInt(playerid, "mail_access", 0);
	            SCM(playerid, -1, " Ожидание...");
	            SCM(playerid, COLOR_YELLOW, " Вы успешно подтвердили свой Эмаил адрес");
	            PTEMP[playerid][pActivemail] = 1;
	            DeletePVar(playerid, "mail_key");
	            if(PTEMP[playerid][pActivemail] && !GetPVarInt(playerid, "mail_access"))
			    {
					format(string, sizeof(string), "[0] Разблокировать. Получить код\n[1] Разблокировать. Ввести код\n[2] {000000}Указать новый эмаил\n[3] {000000}Подтвердить. Получить код\n[4] {000000}Подтвердить. Ввести код");
				}
				else
				{
				    format(string, sizeof(string), "[0] {000000}Разблокировать. Получить код\n[1] {000000}Разблокировать. Ввести код\n[2] Указать новый эмаил\n[3] Подтвердить. Получить код\n[4] Подтвердить. Ввести код");
				}
				ShowPlayerDialogEx(playerid,35,DIALOG_STYLE_LIST, "Эмаил", string, "Выбрать", "Назад");
	        }
		}
	case 40:
	    {
	        if(!response) return SCM(playerid, COLOR_LIGHTRED, " Для выхода из игры введите (/q)uit" ), Kick(playerid);
			switch(listitem)
			{
			    case 0:
			    {
			        ShowPlayerDialogEx(playerid, 5131, DIALOG_STYLE_INPUT, "Восстановление доступа", "Введите эмеил адрес аккаунта", "Готово", "Назад");
			    }
			    case 1:
			    {
			        ShowPlayerDialogEx(playerid, 5132, DIALOG_STYLE_INPUT, "Восстановление доступа", "Введите код подтверждения для сброса паролей", "Готово", "Назад");
			    }
			}
	    }
	case 5131:
	    {
	        if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/restoreaccess");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "SELECT `pEmail` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'", PTEMP[playerid][pName]);
			mysql_query(DATABASE, QUERY);
			new r = cache_num_rows();
			if(r)
			{
				cache_get_field_content(0,"pEmail",PTEMP[playerid][pEmail],DATABASE,60);
			}
			else return SCM(playerid, COLOR_GREY, " Ваш Эмеил не был найден..."), Kick(playerid);
	        if (!strcmp(inputtext, PTEMP[playerid][pEmail], false))
	        {
	            SCM(playerid, -1, " Ожидание...");
		        new randpass = 10000 + random(99999);
	            SetPVarInt(playerid, "mail_key", randpass);

	            format(string, sizeof (string), "to=%s&subject=Код подтверждения Е-мэйл&text=Код подтверждения Е-мэйл: %i<br><br> ---<br> С уважением,<br> Entropy Role Play<br> http://samp-rp.ru<br><br> Не отвечайте на это письмо если вы считаете, что данное письмо пришло к вам по ошибке.", PTEMP[playerid][pEmail], randpass);
	            HTTP(playerid, HTTP_POST, "website.com/sendmail.php", string, "MyHttpResponse");
	            
				CallLocalFunction("OnPlayerCommandText", "is", playerid, "/restoreaccess");
          	}
          	else
 			{
          	    SCM(playerid, COLOR_GREY, " Эмеил адрес не совпадает");
          	    ShowPlayerDialogEx(playerid, 5131, DIALOG_STYLE_INPUT, "Восстановление доступа", "Введите эмеил адрес аккаунта", "Готово", "Назад");
          	}
	    }
    case 5132:
	    {
	        if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/restoreaccess");
	        if(GetPVarInt(playerid, "mail_key") != strval(inputtext))
	        {
	            SCM(playerid, COLOR_GREY, " Код подтверждения введён не правильно");
	            ShowPlayerDialogEx(playerid, 5132, DIALOG_STYLE_INPUT, "Восстановление доступа", "Введите код подтверждения для сброса паролей", "Готово", "Назад");
	        }
	        else
	        {
	            SCM(playerid, -1, " Ожидание...");
		        new randpass1[128], randpass2[128];
				format(randpass1, 128, "%i", (100000 + random(899999999)));
				format(randpass2, 128, "%i", (100000 + random(899999999)));
				new Hash1[64 + 1], Hash2[64 + 1];
				SHA256_PassHash(randpass1, "78sdjs", Hash1, sizeof Hash1);
				SHA256_PassHash(randpass2, "78sdjs", Hash2, sizeof Hash2);
				mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_ACCOUNTS"` SET `pKey` = '%s', `pKeyip` = '%s' WHERE `Name` = '%s'", Hash1, Hash2, PTEMP[playerid][pName]);
				mysql_query(DATABASE, QUERY);
	            format(string, sizeof(string), "to=%s&subject=Восстановление доступа&text=Здравствуйте!<br><br>Ваши пароли на сервере "NameServer" были сброшены: <br>Ваш новый пароль от аккаунта: <b>%s</b><br>Ваш новый защитный ключ: <b>%s</b><br><br>С уважением, администрация!", PTEMP[playerid][pEmail], randpass1, randpass2);
	            HTTP(playerid, HTTP_POST, "website.com/sendmail.php", string, "MyHttpResponse2");
	            SetTimerEx("_Kicking" , 3000, false, "i", playerid);
	        }
	    }
	case 9943:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
			if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid,9943,DIALOG_STYLE_INPUT, "Заявка на смену ника", "Напишите новый ник (по форме Имя_Фамилия)", "Отправить", "Назад");
			new sendername[MAX_PLAYER_NAME];
			//if(IsIP(inputtext) || CheckString(inputtext) || strcmp(inputtext, "_",true) == -1) return SCM(playerid,COLOR_GREY,"NonRP ник.");
            mysql_format(DATABASE, QUERY, 256, "SELECT `Name` FROM `"TABLE_ACCOUNTS"` WHERE `Name` = '%s'", inputtext);
			mysql_query(DATABASE, QUERY);
			new r = cache_num_rows();
			if(r)
			{
			    SCM(playerid, COLOR_GREY, " Данный ник используется");
			}
			else
			{
				format(WantNickChange[playerid],MAX_PLAYER_NAME, "%s",inputtext);
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, 190, " [Заявка на смену ника] %s[%i] просит сменить ник на: %s", sendername,playerid,(inputtext));
				ABroadCast(COLOR_LIGHTGREEN, string, 1);
				format(string, 190, " [Заявка на смену ника] %s[%i] просит сменить ник на: %s", sendername,playerid,(inputtext));
				SCM(playerid, COLOR_LIGHTGREEN, string);
				SCM(playerid, -1, " Ваша заявка отправлена. Ждите одобрения администрацией");
				return true;
			}
		}
	case 9623:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					format(string,256,"[1] Чат оос\t\t%s\n[2] Чат семьи\t\t%s\n[3] Ники игроков\t%s",(!GetPVarInt(playerid,"ooc_chat"))?("выключить") : ("включить"),
					(!GetPVarInt(playerid,"family_chat"))?("выключить") : ("включить"), (!GetPVarInt(playerid,"name_tag"))?("выключить") : ("включить"));
					ShowPlayerDialogEx(playerid, 9973, DIALOG_STYLE_LIST, "Настройки чата",string, "Выбрать", "Назад");
				}
			case 1: ShowStats(playerid,playerid);
			case 2: ShowPlayerDialogEx(playerid, 10025, DIALOG_STYLE_LIST, "Команды сервера","[0] Описание команд\n[1] Обычные\n[2] Чат\n[3] Телефон\n[4] Банк\n[5] Дом\n[6] Бизнес\n[7] Рыбалка\n[8] Работа\n[9] Лидеры\n[10] Репортеры\n[11] Мэрия\n[12] Инструкторы\n[13] Законники\n[14] Мафии/Банды\n[15] Автомобиль", "Выбрать", "Назад");
			case 3: ShowPlayerDialogEx(playerid, 229, DIALOG_STYLE_INPUT, "Задать вопрос по игре", "|               Напишите свой вопрос               |", "Отправить", "Назад");
			case 4: ShowPlayerDialogEx(playerid,10,DIALOG_STYLE_INPUT, "Отправить жалобу", "Вы собираетесь отправить администрации сообщение с жалобой\nОтправляйте по форме [ID/ник нарушитиля] [Текст жалобы]", "Отправить", "Назад");
			case 5: ShowPlayerDialogEx(playerid,11,DIALOG_STYLE_INPUT, "Смена пароля", "    Введите Ваш новый пароль     ", "Принять", "Отмена");
			case 6:
				{
					new clearc;
					while(clearc++ < 99)
					SCM(playerid, -1, " ");
				}
			case 7:
				{
					new rulesdialog[1300];
					format(rulesdialog,sizeof(rulesdialog), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
					RulesMSG[0],RulesMSG[1],RulesMSG[2],RulesMSG[3],RulesMSG[4],RulesMSG[5],RulesMSG[6],RulesMSG[7],RulesMSG[8],RulesMSG[9],RulesMSG[10],RulesMSG[11],RulesMSG[12],RulesMSG[13],RulesMSG[14],RulesMSG[15],RulesMSG[16]);
					ShowPlayerDialogEx(playerid,9980,DIALOG_STYLE_MSGBOX, "Правила сервера", rulesdialog, "Согласен", "Выйти");
					return true;
				}
			case 8: ShowPlayerDialogEx(playerid,8842,DIALOG_STYLE_INPUT, "Слив денег", "Если к Вам попали ворованные/читерские деньги\nотправьте их администрации сервера.\nИначе Вы будете забанены как соучастник", "Слив", "Назад");
			case 9:
				{
					ShowPlayerDialogEx(playerid, 2323, DIALOG_STYLE_LIST, "Безопасность", "[1] Вкл / Откл. проверку по IP\n[2] Сменить ключ\n[3] Помощь\n[4] Эмаил\n[5] Google Authenticator", "Выбрать", "Назад");
					return true;
				}
			case 10: ShowPlayerDialogEx(playerid,9943,DIALOG_STYLE_INPUT, "Заявка на смену ника", "Напишите новый ник (по форме Имя_Фамилия)", "Отправить", "Назад");
			case 11: ShowPlayerDialogEx(playerid, 69, DIALOG_STYLE_MSGBOX, "Приобретение виртов", "Подробности на сайте meltrune.com/Донат", "Закрыть", "");
			case 12:
				{
					if(booston == 0) return SCM(playerid,-1," Бонусы отключены");
					mysql_format(DATABASE,QUERY,256,"SELECT * FROM `boost` WHERE `Text` = 'BoostTime'");
					return mysql_function_query(DATABASE,QUERY,true,"_MySQL_QUERY","iis",36,playerid,"");
				}
			}
		}
	case 20086:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			if(PTEMP[playerid][pLevel] < 5 || PTEMP[playerid][pBank] < 100000) return ShowPlayerDialogEx(playerid,8905,DIALOG_STYLE_MSGBOX, "Банкомат","К сожалению вы не можете подать объявление\nПричину прочтите в INFO", "Назад", "");
			new null = -1;
			for(new i = 0; i < 20; i++) if(!strlen(ATMADVERTISE[i])) { null = i; break; }
			if(null == -1) return ShowPlayerDialogEx(playerid,8905,DIALOG_STYLE_MSGBOX, "Банкомат","Нет места для опубликования объявления\nЖдите следующего часа!", "Назад", "");
			return ShowPlayerDialogEx(playerid,20087,DIALOG_STYLE_INPUT,"Банкомат","Введите текст объявления","Опубликовать","Назад");
		}
	case 20087:
		{
			if(!response) return ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			if(strlen(inputtext) > 60) return SCM(playerid,COLOR_GREY," Макс. 60 символов"), ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			if(PTEMP[playerid][pBank] < strlen(inputtext)*100) return SCM(playerid,COLOR_GREY," Недостаточно средств на банковском счету"), ShowPlayerDialogEx(playerid, 8900, DIALOG_STYLE_LIST, "ATM","[0] Пополнить счет\n[1] Снять со счета\n[2] Баланс\n[3] Оплатить квартплату", "Выбрать", "Назад");
			new null = -1;
			for(new i = 0; i < 20; i++) if(!strlen(ATMADVERTISE[i])) { null = i; break; }
			if(null == -1) return ShowPlayerDialogEx(playerid,8905,DIALOG_STYLE_MSGBOX, "Банкомат","Нет места для опубликования объявления\nЖдите следующего часа!", "Назад", "");
			format(string,180,"%s | %s | Тел: %i", PTEMP[playerid][pName], inputtext, PTEMP[playerid][pPnumber]);
			strmid(ATMADVERTISE[null],string, 0, strlen(string),150);
			format(string,10,"~r~-$%i",strlen(inputtext)*100), GameTextForPlayer(playerid,string,1000,1);
			PTEMP[playerid][pBank]-=strlen(inputtext)*100;
			FracBank[0][fKazna] += strlen(inputtext)*100;
			new str[150];
			string = "";
			for(new i = 19; i >= 0; i--)
			{
				if(strlen(ATMADVERTISE[i])) format(str,150,"%i. %s\n",i+1,ATMADVERTISE[i]);
				strcat(string, str);
			}
			return ShowPlayerDialogEx(playerid,20086,DIALOG_STYLE_MSGBOX, "Банкомат", string, "Отправить", "Назад");
		}
	case 9973:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
			switch(listitem)
			{
			case 0:
				{
					if(!GetPVarInt(playerid,"ooc_chat")) SetPVarInt(playerid,"ooc_chat",1), SCM(playerid, 0x6495EDFF, "Просмотр общего чата отключён!");
					else DeletePVar(playerid,"ooc_chat"), SCM(playerid, 0x6495EDFF, "Просмотр общего чата включён!");
				}
			case 1:
				{
					if(!GetPVarInt(playerid,"family_chat")) SetPVarInt(playerid,"family_chat",1), SCM(playerid, 0x6495EDFF, "Просмотр семейного чата отключён!");
					else DeletePVar(playerid,"family_chat"), SCM(playerid, 0x6495EDFF, "Просмотр семейного чата включён!");
				}
			case 2:
				{
					if(!GetPVarInt(playerid,"name_tag"))
					{
						SetPVarInt(playerid,"name_tag",1);
						foreach(i) ShowPlayerNameTagForPlayer(playerid, i, false);
						SCM(playerid, 0x6495EDFF, "Показ ников отключён!");
					}
					else
					{
						DeletePVar(playerid,"name_tag");
						foreach(i) ShowPlayerNameTagForPlayer(playerid, i, true);
						SCM(playerid, 0x6495EDFF, "Показ ников включён!");
					}
				}
			}
			return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
		}
	case 8842:
		{
			if(!response) return CallLocalFunction("OnPlayerCommandText", "is", playerid, "/mm");
			new moneys;
			moneys = strval(inputtext);
			if(strval(inputtext) < 1) return SCM(playerid, COLOR_RED, " Неверная сумма");
			if(PTEMP[playerid][pCash] < strval(inputtext)) return SCM(playerid,COLOR_GREY, " У вас нет столько денег!"),ShowPlayerDialogEx(playerid,8842,DIALOG_STYLE_INPUT,"Слив ворованных денег","Если к вам попали ворованные/сбагозенные деньги,\nих следует передать администрации.\nИначе вы можете быть забаненым как вор/соучастник!","Готово","Отмена");
			PTEMP[playerid][pCash] -= strval(inputtext);
			format(string, 90, " Вы пожертвовали $ %i", moneys);
			SCM(playerid, -1, string);
			SCM(playerid, COLOR_LIGHTRED, " Большое спасибо за сотрудничество");
			return true;
		}
	case 1227:
		{
			if(!response) return 1;
			if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid, 1227, DIALOG_STYLE_PASSWORD, "Админ авторизация", "Ошибка! Пароль должен содержать и цыфры и буквы.\nЗапрещены любые другие символы, а так же кириллица", "Вход", "Отмена");
			new pass2;
			if(GetPVarInt(playerid, "Alogin") == 1)
			{
				if(sscanf(inputtext, "s[16]", pass2)) ShowPlayerDialogEx(playerid, 1227, DIALOG_STYLE_PASSWORD, "Админ авторизация", "Введите пароль\n\nПароль должен состоять из латинских букв и цифр\n	размером от 6 до 15 символов", "Вход", "Отмена");
				if(!strcmp(inputtext, "qwerty", true)) return ShowPlayerDialogEx(playerid, 1227, DIALOG_STYLE_PASSWORD, "Админ авторизация", "Введите пароль\n\nПароль должен состоять из латинских букв и цифр\n	размером от 6 до 15 символов", "Вход", "Отмена");
				if(strlen(inputtext) < 6 || strlen(inputtext) > 16) return ShowPlayerDialogEx(playerid, 1227, DIALOG_STYLE_PASSWORD, "Админ авторизация", "Ошибка! Пароль должен содержать и цыфры и буквы.\nЗапрещены любые другие символы, а так же кириллица", "Вход", "Отмена");
				mysql_format(DATABASE,QUERY,256, "UPDATE "TABLE_ADMIN" SET  password = '%s' WHERE Name = '%s' LIMIT 1", pass2, PTEMP[playerid][pName]);
				mysql_function_query(DATABASE,QUERY,false,"","");
				SCM(playerid, COLOR_GREEN, " Поздравляем! Вы получили доступ модератора");
				//SendMes(playerid, 0xF5B900AA, " Вы авторизировались как модератор %i уровня", GetPVarInt(playerid,"level"));
				dostup[playerid] = 1;
				format(string, 90, " <ALogin> вошел %s[%i]", PTEMP[playerid][pName], playerid);
				SendAdminMessage(0xF5B900AA, string);
				AGM[playerid] = true;
				PTEMP[playerid][pAdmin] = GetPVarInt(playerid,"level");
				if(PTEMP[playerid][pAdmin] >= 10) Goto[playerid] = false;
				new year, month, day;
				getdate(year, month, day);
				mysql_format(DATABASE,QUERY,256, "UPDATE "TABLE_ADMIN" SET `LastCon` = '%02i.%02i.%04i' WHERE Name = '%s'", day, month, year, PTEMP[playerid][pName]);
				mysql_function_query(DATABASE,QUERY,false,"","");
				printf("Администратор %s авторизовался администратором %i уровня", PTEMP[playerid][pName], PTEMP[playerid][pAdmin]);
				return true;
			}
			else if(GetPVarInt(playerid, "Alogin") == 2)
			{
				format(string, 60, " <ALogin> %s[%i]: ввел неверный пароль",PTEMP[playerid][pName],playerid);
				new str[64];
				GetPVarString(playerid,"password",str,64);
				if(strcmp(inputtext, str, true)) return SendAdminMessage(0xF5B900AA, string),SCM(playerid, COLOR_GREY, " Вы ввели неверный пароль");
				SendMes(playerid, 0xF5B900AA, " Вы авторизировались как модератор %i уровня", GetPVarInt(playerid,"level"));
				PTEMP[playerid][pAdmin] = GetPVarInt(playerid,"level");
				dostup[playerid] = 1;
				format(string, 90, " <ALogin> вошел %s[%i]", PTEMP[playerid][pName], playerid);
				if(PTEMP[playerid][pAdmin] < 6) SendAdminMessage(0xF5B900AA, string);
				else ABroadCast(0xF5B900AA,string,7);
				AGM[playerid] = true;
				if(PTEMP[playerid][pAdmin] >= 10) Goto[playerid] = false;
				new year, month, day;
				getdate(year, month, day);
				mysql_format(DATABASE,QUERY,256, "UPDATE "TABLE_ADMIN" SET `LastCon` = '%02i.%02i.%04i' WHERE Name = '%s'", day, month, year, PTEMP[playerid][pName]);
				mysql_function_query(DATABASE,QUERY,false,"","");
				printf("[ALOGIN] %s авторизовался администратором %i уровня", PTEMP[playerid][pName], PTEMP[playerid][pAdmin]);
			}
			if(GetPVarInt(playerid, "Alogin") == 3)
			{
				if(strlen(inputtext) < 6 || strlen(inputtext) > 16) return ShowPlayerDialogEx(playerid, 1227, DIALOG_STYLE_PASSWORD, "Админ авторизация", "Ошибка! Пароль должен содержать и цыфры и буквы.\nЗапрещены любые другие символы, а так же кириллица", "Вход", "Отмена");
				dostup[playerid] = 0;
				SCM(playerid, COLOR_GREY, " Вы не модератор");
				return true;
			}
		}
	case 16:
		{
			if(!response) return true;
			if(!strlen(inputtext))
			{
				ShowPlayerDialogEx(playerid,16,DIALOG_STYLE_PASSWORD, "Введите ключ безопастности", "      ==== Ваш IP адрес сменился ====\n=== Введите ваш ключ безопасности ===", "Готово", "Отмена");
				SetPlayerInterior(playerid,0);
				SetPlayerCameraLookAt(playerid,1133.0504,-2038.4034,69.0980);
				SetPlayerFacingAngle(playerid, 179.5547);
				SetPlayerCameraPos(playerid, -1817.0808, 1112.9937, 235.4244);
				SetPlayerCameraLookAt(playerid, -1816.5471, 949.6590, 235.4244);
				TogglePlayerControllable(playerid, 0);
				PTEMP[playerid][pLogin] = 0;
				mysql_format(DATABASE, QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pLogin = '0' WHERE name = '%e'",PTEMP[playerid][pName]);
				mysql_function_query(DATABASE,QUERY,false,"","");
				return true;
			}
			if(strcmp(inputtext, PTEMP[playerid][pKeyip], true) == 0)
			{
			    if(PTEMP[playerid][pGoogleIP] == 0)
			    {
					new playersip[64];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerIp(playerid,playersip,sizeof(playersip));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					mysql_format(DATABASE,QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pIp = '%s', pLogin = '1' WHERE name = '%e'",playersip,PTEMP[playerid][pName]);
					mysql_function_query(DATABASE,QUERY,false,"","");
					PTEMP[playerid][pLogin] = 1;
					Convoi[playerid] = 9999;
					SpawnPlayer(playerid);
					TogglePlayerControllable(playerid, 1);
					if(PTEMP[playerid][pPHouseKey] != 9999)
					{
						new house = PTEMP[playerid][pPHouseKey];
						createdcar = house_car[playerid];
						house_car[playerid] = CreateVehicle(CarInfo[playerid][carModel][GetPVarInt(playerid, "chosencar")], HouseInfo[house][hCarx], HouseInfo[house][hCary], HouseInfo[house][hCarz], HouseInfo[house][hCarc] , CarInfo[playerid][carColor_one][GetPVarInt(playerid, "chosencar")] ,CarInfo[playerid][carColor_two][GetPVarInt(playerid, "chosencar")], 86400);
						SetVehicleParamsEx(house_car[playerid],false,false,false,true,false,false,false);
						CarHealth[house_car[playerid]] = float(1000);
						createdcar ++;
						new pveh = GetPVarInt(playerid, "chosencar");
						Fuell[house_car[playerid]] = CarInfo[playerid][carFuel][pveh];
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_1][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_2][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_3][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_4][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_5][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_6][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_7][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_8][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_9][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_10][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_11][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_12][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_13][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_14][pveh]);
					}
				}
				else
				{
				    ShowPlayerDialogEx(playerid,1812,DIALOG_STYLE_PASSWORD, "Ввод параметра", "      ==== Ваш IP адрес сменился ====\n=== Введите гугл-код ===", "Готово", "Отмена");
					SetPlayerInterior(playerid,0);
					SetPlayerCameraLookAt(playerid,1133.0504,-2038.4034,69.0980);
					SetPlayerFacingAngle(playerid, 179.5547);
					SetPlayerCameraPos(playerid, -1817.0808, 1112.9937, 235.4244);
					SetPlayerCameraLookAt(playerid, -1816.5471, 949.6590, 235.4244);
					TogglePlayerControllable(playerid, 0);
					PTEMP[playerid][pLogin] = 0;
					mysql_format(DATABASE, QUERY,128, "UPDATE `"TABLE_ACCOUNTS"` SET pLogin = '0' WHERE name = '%e'",PTEMP[playerid][pName]);
					mysql_function_query(DATABASE,QUERY,false,"","");
				}
				return true;
			}
			else
			{
				ShowPlayerDialogEx(playerid,69,DIALOG_STYLE_MSGBOX, "{B20000}Внимание", "{FF6347}Вы были кикнуты с сервера\nПричина: 'Не верный ключ безопасности'\nВведите '/q', чтобы выйти", "Закрыть", "");
				Kick(playerid);
				return true;
			}
		}
	case 1812:
	    {
	        if(!response) return SCM(playerid, COLOR_LIGHTRED, " Введите /q(uit) для выхода с игры"), Kick(playerid);
	        else
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialogEx(playerid,1812,DIALOG_STYLE_PASSWORD, "Ввод параметра", "      ==== Ваш IP адрес сменился ====\n=== Введите гугл-код ===", "Готово", "Отмена");
	            new mustGoogleKey = GoogleAuthenticatorCode(PTEMP[playerid][pGoogleKey], gettime());
	            if(strval(inputtext) != mustGoogleKey)
	            {
	                SCM(playerid, COLOR_LIGHTRED, " Вы ввели не верный код");
	                Kick(playerid);
	            }
	            else
	            {
	                new playersip[64];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerIp(playerid,playersip,sizeof(playersip));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					Online[playerid] = 0;
					PTEMP[playerid][pLogin] = 1;
					Convoi[playerid] = 9999;
					SpawnPlayer(playerid);
					TogglePlayerControllable(playerid, 1);
					if(PTEMP[playerid][pPHouseKey] != 9999)
					{
						new house = PTEMP[playerid][pPHouseKey];
						createdcar = house_car[playerid];
						house_car[playerid] = CreateVehicle(CarInfo[playerid][carModel][GetPVarInt(playerid, "chosencar")], HouseInfo[house][hCarx], HouseInfo[house][hCary], HouseInfo[house][hCarz], HouseInfo[house][hCarc] , CarInfo[playerid][carColor_one][GetPVarInt(playerid, "chosencar")] ,CarInfo[playerid][carColor_two][GetPVarInt(playerid, "chosencar")], 86400);
						SetVehicleParamsEx(house_car[playerid],false,false,false,true,false,false,false);
						CarHealth[house_car[playerid]] = float(1000);
						createdcar ++;
						new pveh = GetPVarInt(playerid, "chosencar");
						Fuell[house_car[playerid]] = CarInfo[playerid][carFuel][pveh];
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_1][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_2][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_3][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_4][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_5][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_6][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_7][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_8][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_9][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_10][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_11][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_12][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_13][pveh]);
						AddVehicleComponent(house_car[playerid], CarInfo[playerid][carVehcom_14][pveh]);
					}
	            }
	        }
	    }
	case 9000:
    {
        if (!response) return true;
        if (listitem == 18){
            ShowPlayerDialogEx(playerid, 9001, DIALOG_STYLE_LIST, "Меню", "[18] Зона 51 склад [key:19]\n[19] Форт карсон [key:20]\n[20] Гетто [key:21]\n[21] Тюрьма ЛВ [key:22]\n[22] Тюрьма СФ [key:23]\n[23] Работа прораба [key:24]\n[24] За рестораном [key:25]\n[25] Дракона [key:26]\n[26] Калигула [key:27]\n[27] ЖД - ЛС [key:28]\n<< Пред.страница", "Выбрать", "Назад");
        }
        else
        {
            format(string, sizeof (string), "/tp %i", listitem + 1);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
        }
    }
    case 9001:
    {
        if (!response) return true;
        if (listitem == 10){
            ShowPlayerDialogEx(playerid, 9000, DIALOG_STYLE_LIST, "Меню", "[0] LSPD [key:1]\n[1] LSPD-Тюрьма [key:2]\n[2] Мэрия [key:3]\n[3] Автовокзал ЛС [key:4]\n[4] ЛС-СФ Шоссе [key:5]\n[5] Автошкола [key:6]\n[6] ФБР [key:7]\n[7] Аэропорт СФ [key:8]\n[8] Аэропорт ЛС [key:9]\n[9] Военная база [key:10]\n[10] Цент Лас Вентурас [key:11]\n[11] Клуб Джизи [key:12]\n[12] Админ казино [key:13]\n[13] Вокзал ЛВ [key:14]\n[14] Аэро ЛС Въезд [key:15]\n[15] Вокзал СФ [key:16]\n[16] Авианосец стоянка [key:17]\n[17] Авианосец [key:18]\n>> След.страница", "Выбрать", "Назад");
        }
        else
        {
            format(string, sizeof (string), "/tp %i", listitem+19);
            CallLocalFunction("OnPlayerCommandText", "is", playerid, string);
        }
    }}
	while (strfind(inputtext, "%s", true) != -1)
	{
		strdel(inputtext, strfind(inputtext, "%s", true), strfind(inputtext, "%s", true) + 2);
	}

    printf("<-- OnDialogResponse(playerid = %d, dialogid = %d, response = %d, listitem = %d, inputtext = \"%s\") --<", playerid, dialogid, response, listitem, inputtext);

	return true;
}