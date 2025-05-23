
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	СформироватьДвиженияОсновныеНачисления();
	РасчитатьОсновныеНачисления();
	РасчитатьОсновныеНачисленияОтпуск();
	СформироватьДвиженияУдержанияНДФЛ();
	РасчитатьДвиженияУдержанияНДФЛ();
	СформироватьДвиженияВзаиморасчетыССотрудниками();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СформироватьДвиженияОсновныеНачисления()
		
	Для Каждого Строка Из Начисления Цикл 
		
		Если ТипЗнч(Строка.ВидРасчета) <> Тип("ПланВидовРасчетаСсылка.ВКМ_ОсновныеНачисления") Тогда
			Продолжить;
		КонецЕсли;
		
		Движение = Движения.ВКМ_ОсновныеНачисления.Добавить();
		Движение.ПериодРегистрации = Дата;
		Движение.ВидРасчета = Строка.ВидРасчета;
		
		Если Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск Тогда
			Движение.БазовыйПериодНачало = НачалоМесяца(ДобавитьМесяц(Строка.ДатаНачала, -12));
			Движение.БазовыйПериодКонец = КонецМесяца(ДобавитьМесяц(Строка.ДатаОкончания, -1));
		КонецЕсли;
		
		Движение.ПериодДействияНачало = Строка.ДатаНачала;
		Движение.ПериодДействияКонец = Строка.ДатаОкончания;
		Движение.Сотрудник = Строка.Сотрудник;
		Движение.ГрафикРаботы = Строка.ГрафикРаботы;
		
	КонецЦикла;
	
	Движения.ВКМ_ОсновныеНачисления.Записать();
	
КонецПроцедуры

Процедура РасчитатьОсновныеНачисления()
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ОсновныеНачисленияДанныеГрафика.НомерСтроки КАК НомерСтроки,
		|	ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеПериодДействия КАК РабочихДнейПлан,
		|	ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеФактическийПериодДействия КАК РабочихДнейФакт,
		|	ВКМ_УсловияОплатыСотрудниковСрезПоследних.Сотрудник КАК Сотрудник,
		|	ВКМ_УсловияОплатыСотрудниковСрезПоследних.Оклад КАК Оклад
		|ПОМЕСТИТЬ ВТ_Сотрудник_Оклад
		|ИЗ
		|	РегистрРасчета.ВКМ_ОсновныеНачисления.ДанныеГрафика КАК ВКМ_ОсновныеНачисленияДанныеГрафика
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ВКМ_УсловияОплатыСотрудников.СрезПоследних(&НачалоПериода, ) КАК ВКМ_УсловияОплатыСотрудниковСрезПоследних
		|		ПО ВКМ_ОсновныеНачисленияДанныеГрафика.Сотрудник = ВКМ_УсловияОплатыСотрудниковСрезПоследних.Сотрудник
		|ГДЕ
		|	ВКМ_ОсновныеНачисленияДанныеГрафика.Регистратор = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_Сотрудник_Оклад.НомерСтроки КАК НомерСтроки,
		|	ВТ_Сотрудник_Оклад.Сотрудник КАК Сотрудник,
		|	ЕСТЬNULL(ВТ_Сотрудник_Оклад.Оклад, 0) КАК Оклад,
		|	ЕСТЬNULL(ВКМ_ВыполненныеСотрудникомРаботыОбороты.СуммаКОплатеОборот, 0) КАК СуммаКОплате,
		|	ВТ_Сотрудник_Оклад.РабочихДнейПлан КАК РабочихДнейПлан,
		|	ВТ_Сотрудник_Оклад.РабочихДнейФакт КАК РабочихДнейФакт
		|ИЗ
		|	ВТ_Сотрудник_Оклад КАК ВТ_Сотрудник_Оклад
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ВКМ_ВыполненныеСотрудникомРаботы.Обороты(&НачалоПериода, &КонецПериода, Месяц, ) КАК ВКМ_ВыполненныеСотрудникомРаботыОбороты
		|		ПО ВТ_Сотрудник_Оклад.Сотрудник = ВКМ_ВыполненныеСотрудникомРаботыОбороты.Сотрудник";
	
	Запрос.УстановитьПараметр("КонецПериода", КонецМесяца(Дата));
	Запрос.УстановитьПараметр("НачалоПериода", НачалоМесяца(Дата));
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
		
	Пока Выборка.Следующий() Цикл
		
		Движение = Движения.ВКМ_ОсновныеНачисления[Выборка.НомерСтроки - 1];
		
		Если Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Оклад Тогда
			
			Оклад = Выборка.Оклад / Выборка.РабочихДнейПлан * Выборка.РабочихДнейФакт;
			Движение.Результат = Оклад + Выборка.СуммаКОплате;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Движения.ВКМ_ОсновныеНачисления.Записать(, Истина);
	
КонецПроцедуры

Процедура РасчитатьОсновныеНачисленияОтпуск()
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ОсновныеНачисления.НомерСтроки КАК НомерСтроки,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияБазаВКМ_ДополнительныеНачисления.РезультатБаза, 0) КАК БазаПремия,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.РезультатБаза, 0) КАК БазаОсн,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеФактическийПериодДействия, 0) КАК ФактКолДней,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеБазовыйПериод, 0) КАК БазаКолДней
		|ИЗ
		|	РегистрРасчета.ВКМ_ОсновныеНачисления КАК ВКМ_ОсновныеНачисления
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.БазаВКМ_ОсновныеНачисления(
		|				&Измерение,
		|				&Измерение,
		|				,
		|				Регистратор = &Ссылка
		|					И ВидРасчета = &Отпуск) КАК ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления
		|		ПО ВКМ_ОсновныеНачисления.НомерСтроки = ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.НомерСтроки
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.БазаВКМ_ДополнительныеНачисления(
		|				&Измерение,
		|				&Измерение,
		|				,
		|				Регистратор = &Ссылка
		|					И ВидРасчета = &Отпуск) КАК ВКМ_ОсновныеНачисленияБазаВКМ_ДополнительныеНачисления
		|		ПО ВКМ_ОсновныеНачисления.НомерСтроки = ВКМ_ОсновныеНачисленияБазаВКМ_ДополнительныеНачисления.НомерСтроки
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.ДанныеГрафика(
		|				Регистратор = &Ссылка
		|					И ВидРасчета = &Отпуск) КАК ВКМ_ОсновныеНачисленияДанныеГрафика
		|		ПО ВКМ_ОсновныеНачисления.НомерСтроки = ВКМ_ОсновныеНачисленияДанныеГрафика.НомерСтроки
		|ГДЕ
		|	ВКМ_ОсновныеНачисления.Регистратор = &Ссылка
		|	И ВКМ_ОсновныеНачисления.ВидРасчета = &Отпуск";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Отпуск", ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск);
	
	Измерение = Новый Массив;
	Измерение.Добавить("Сотрудник");
	Запрос.УстановитьПараметр("Измерение", Измерение);
	
	Выборка = Запрос.Выполнить().Выбрать();
		
	Пока Выборка.Следующий() Цикл
				
		Движение = Движения.ВКМ_ОсновныеНачисления[Выборка.НомерСтроки - 1];
		Отпускные = (Выборка.БазаОсн + Выборка.БазаПремия) * Выборка.ФактКолДней / Выборка.БазаКолДней;
		Движение.Результат = Отпускные;
		
	КонецЦикла;
	
	Движения.ВКМ_ОсновныеНачисления.Записать(, Истина);
	
КонецПроцедуры

Процедура СформироватьДвиженияУдержанияНДФЛ()
	
	ВидРасчетаНДФЛ = ПланыВидовРасчета.ВКМ_Удержания.НДФЛ;
	
	Сотрудники = Начисления.Выгрузить(, "Сотрудник");
	Сотрудники.Свернуть("Сотрудник");
	
	Для Каждого Строка Из Сотрудники Цикл
		
		Движение = Движения.ВКМ_Удержания.Добавить();
		Движение.ПериодРегистрации = Дата;
		Движение.ВидРасчета = ВидРасчетаНДФЛ;
		Движение.Сотрудник = Строка.Сотрудник;
		Движение.БазовыйПериодНачало = НачалоМесяца(Дата);
		Движение.БазовыйПериодКонец = КонецМесяца(Дата);
		
	КонецЦикла;
	
	Движения.ВКМ_Удержания.Записать();
	
КонецПроцедуры

Процедура РасчитатьДвиженияУдержанияНДФЛ()
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_Удержания.НомерСтроки КАК НомерСтроки,
		|	ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.РезультатБаза КАК РезультатБаза
		|ИЗ
		|	РегистрРасчета.ВКМ_Удержания КАК ВКМ_Удержания
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_Удержания.БазаВКМ_ОсновныеНачисления(
		|				&Измерение,
		|				&Измерение,
		|				,
		|				Регистратор = &Ссылка
		|					И ВидРасчета = &ВидРасчета) КАК ВКМ_УдержанияБазаВКМ_ОсновныеНачисления
		|		ПО ВКМ_Удержания.НомерСтроки = ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.НомерСтроки
		|ГДЕ
		|	ВКМ_Удержания.Регистратор = &Ссылка
		|	И ВКМ_Удержания.ВидРасчета = &ВидРасчета";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("ВидРасчета", ПланыВидовРасчета.ВКМ_Удержания.НДФЛ);
	
	Измерение = Новый Массив;
	Измерение.Добавить("Сотрудник");
	Запрос.УстановитьПараметр("Измерение", Измерение);
	
	Выборка = Запрос.Выполнить().Выбрать();
		
	Пока Выборка.Следующий() Цикл
		
		Движение = Движения.ВКМ_Удержания[Выборка.НомерСтроки - 1];
		Движение.Размер = Выборка.РезультатБаза;
		Движение.Результат = Движение.Размер * 13 / 100;
		
	КонецЦикла;
	
	Движения.ВКМ_Удержания.Записать(, Истина);
	
КонецПроцедуры

Процедура СформироватьДвиженияВзаиморасчетыССотрудниками()
	
	Движения.ВКМ_ВзаиморасчетыССотрудниками.Записывать = Истина;
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ОсновныеНачисления.Сотрудник КАК Сотрудник,
		|	СУММА(ЕСТЬNULL(ВКМ_ОсновныеНачисления.Результат, 0)) КАК СуммаНачисления,
		|	МАКСИМУМ(ЕСТЬNULL(ВКМ_Удержания.Результат, 0)) КАК СуммаУдержания
		|ИЗ
		|	РегистрРасчета.ВКМ_ОсновныеНачисления КАК ВКМ_ОсновныеНачисления
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_Удержания КАК ВКМ_Удержания
		|		ПО ВКМ_ОсновныеНачисления.Сотрудник = ВКМ_Удержания.Сотрудник
		|ГДЕ
		|	ВКМ_ОсновныеНачисления.Регистратор = &Ссылка
		|	И ВКМ_Удержания.Регистратор = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	ВКМ_ОсновныеНачисления.Сотрудник";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Движение = Движения.ВКМ_ВзаиморасчетыССотрудниками.Добавить();
		Движение.Период = Дата;
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Сотрудник = Выборка.Сотрудник;
		Движение.Сумма = Выборка.СуммаНачисления - Выборка.СуммаУдержания;
		
	КонецЦикла;
		
КонецПроцедуры

#КонецОбласти

#КонецЕсли