publics:_CheckTrigger()
{
	//print("--> _CheckTrigger()");

	foreach(i)
	{
		if (TriggerStatus[i] == 1) return 1; // Если этого не будет, то будет флудить
		// x, y, z заменяем на то, где стоит триггер и устанавливаем виртуальный мир где он будет срабатывать, можете удалить, но будет работать триггер во всех вирт мирах
		if (IsPlayerInRangeOfPoint(i, 2.0, -2047.460083, -114.519997, 1033.453115))
		{
			TriggerStatus[i] = 1;
			// Ставим свои координаты x, y, z чтобы триггер мог установить значение 0, когда игрок отойдет от него
			TriggerPos[i][0] = -2047.460083;
			TriggerPos[i][1] = -114.519997;
			TriggerPos[i][2] = 1033.453115;
			if (PTEMP[i][pCarLic] == 1) return SendClientMessage(i, COLOR_GRAD1, " Вы уже имеете водительские права");
			if (GetPVarInt(i, "givecarlic") == 2)
			{
				SendClientMessage(i, -1, " Вы недостаточно хорошо ездиете, чтобы получить водительские права!");
				SendClientMessage(i, -1, " Пересдать экзамен можно в любое время.");
				SendClientMessage(i, -1, " Мы настоятельно рекомендуем вам прочесть ПДД");
				LessonCar[i] = 0;
				LessonStat[i] = 0;
				TakingLesson[i] = 0;
				DeletePVar(i, "givecarlic");
			}
			else if (GetPVarInt(i, "givecarlic") == 1)
			{
				LessonCar[i] = 0;
				LessonStat[i] = 0;
				TakingLesson[i] = 0;
				PTEMP[i][pCarLic] = 1;
				SendClientMessage(i, -1, " Поздравляем! Вы сдали экзамен по вождению");
				SendClientMessage(i, COLOR_GREEN, " Подсказка: Теперь вы можете устроить на работу в Мэрии << Испльзуйте /GPS >>");
				SendClientMessage(i, COLOR_GREEN, " Подсказка: Работа водителя автобуса очень интересная и прибыльная (зарплата государства + деньги за билеты)");
				SendClientMessage(i, -1, " Мы рекомендуем вам поработать пару лет (( 2 левла )), а после вступить в организацию");
				DeletePVar(i,"givecarlic");
			}
			if (PTEMP[i][pQuestL] == 1 && PTEMP[i][pQuest] == 2)
			{
				PlayerPlaySound(i, 4201, 0.0, 0.0, 0);
				ShowPlayerDialogEx(i, 13372, DIALOG_STYLE_MSGBOX, "Задание", "Тут неподалёку есть ферма,где можно неплохо заработать.\nМожешь использовать gps или найти таксиста и попросить его отвезти тебя.\nЕсли ты сможешь за раз собрать 25 кустов урожая,то я поделюсь с тобой своей прибылью\n{DDCD70}Задача: Собрать 30 единиц урожая\n{17B757}Награда: 2000 вирт", "Готово", "");
				PTEMP[i][pQuest] = 3;
				PTEMP[i][pQuestP] = 0;
				PTEMP[i][pQuestPF] = 30;
				SendClientMessage(i, 0x30a0a7aa, " Задание выполнено");
			}
			else ShowPlayerDialogEx(i, 10022, DIALOG_STYLE_MSGBOX, "Экзамен по вождению", "Приветствуем вас в автошколе.\nЕсли хотите сдать на права, выберите далее", "Далее", "Отмена");
			return true;
		}
		// x, y, z заменяем на то, где стоит триггер и устанавливаем виртуальный мир где он будет срабатывать, можете удалить, но будет работать триггер во всех вирт мирах
		else if (IsPlayerInRangeOfPoint(i, 1.0, 359.8704, 184.7093, 1008.3828))
		{
			if (useguns[i] == 0)
			{
			    //if(BGet(i)) return SendClientMessage(i, COLOR_GRAD1, "Бизнесмен не может устроиться на работу");
				ShowPlayerDialogEx(i, 10092, DIALOG_STYLE_MSGBOX, "Приём на работу", "Вы хотите просмотреть список доступных работ?", "Да", "Нет");
				TriggerStatus[i] = 1;
				// Ставим свои координаты x, y, z чтобы триггер мог установить значение 0, когда игрок отойдет от него
				TriggerPos[i][0] = 359.8704;
				TriggerPos[i][1] = 184.7093;
				TriggerPos[i][2] = 1008.3828;
				return true;
			}
		}
		// x, y, z заменяем на то где стоит  триггер и устанавливаем виртуальный мир где он будет срабатывать, можете удалить, но будет работать триггер во всех вирт мирах
		else if (IsPlayerInRangeOfPoint(i, 1.0, 1160.4260, -1770.3188, 16.5938))
		{
			SetPVarInt(i, "help_dialog", 0), ShowPlayerDialogEx(i, 1467, 0, "Помощь", "Я объясню как играть на этом сервере.\nЧто делать, куда идти в данный момент", "Далее", "Отмена");
			TriggerStatus[i] = 1;
			// Ставим свои координаты x, y, z чтобы триггер мог установить значение 0, когда игрок отойдет от него
			TriggerPos[i][0] = 1160.4260;
			TriggerPos[i][1] = -1770.3188;
			TriggerPos[i][2] = 16.5938;
			return true;
		}
	}

	//print("<-- _CheckTrigger()");

	return 1;
}