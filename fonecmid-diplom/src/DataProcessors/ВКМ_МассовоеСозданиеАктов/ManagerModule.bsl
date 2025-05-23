
Процедура СформироватьАктыЗаПериод(Параметры, АдресРезультата) Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДоговорыКонтрагентов.Ссылка КАК Договор,
	|	ДоговорыКонтрагентов.Организация КАК Организация,
	|	ДоговорыКонтрагентов.Владелец КАК Контрагент,
	|	МАКСИМУМ(ДоговорыКонтрагентов.ВКМ_АбонентскаяПлата) КАК АбонентскаяПлата,
	|	ЕСТЬNULL(СУММА(ВКМ_ВыполненныеКлиентуРаботыОбороты.КоличествоЧасовПриход), 0) КАК Количество,
	|	ЕСТЬNULL(СУММА(ВКМ_ВыполненныеКлиентуРаботыОбороты.СуммаКОплатеПриход), 0) КАК Сумма
	|ПОМЕСТИТЬ ВТ_ИсходныеДанные
	|ИЗ
	|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ВКМ_ВыполненныеКлиентуРаботы.Обороты(&НачалоПериода, &КонецПериода, Регистратор, ) КАК ВКМ_ВыполненныеКлиентуРаботыОбороты
	|		ПО ДоговорыКонтрагентов.Ссылка = ВКМ_ВыполненныеКлиентуРаботыОбороты.Договор
	|ГДЕ
	|	ДоговорыКонтрагентов.ВидДоговора = ЗНАЧЕНИЕ(Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбоненскоеОбслуживание)
	|	И ДоговорыКонтрагентов.ВКМ_НачалоПериодаДействия <= &НачалоПериода
	|	И КОНЕЦПЕРИОДА(ДоговорыКонтрагентов.ВКМ_ОкончаниеПериодаДействия, ДЕНЬ) >= &КонецПериода
	|
	|СГРУППИРОВАТЬ ПО
	|	ДоговорыКонтрагентов.Ссылка,
	|	ДоговорыКонтрагентов.Владелец,
	|	ДоговорыКонтрагентов.Организация
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	РеализацияТоваровУслуг.Ссылка КАК Ссылка,
	|	РеализацияТоваровУслуг.Договор КАК Договор
	|ПОМЕСТИТЬ ВТ_Реализация
	|ИЗ
	|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	|ГДЕ
	|	РеализацияТоваровУслуг.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ИсходныеДанные.Договор КАК Договор,
	|	ВТ_ИсходныеДанные.Организация КАК Организация,
	|	ВТ_ИсходныеДанные.Контрагент КАК Контрагент,
	|	ВТ_ИсходныеДанные.АбонентскаяПлата КАК АбонентскаяПлата,
	|	ВТ_ИсходныеДанные.Количество КАК Количество,
	|	ВТ_ИсходныеДанные.Сумма КАК Сумма,
	|	ВТ_Реализация.Ссылка КАК Реализация
	|ИЗ
	|	ВТ_ИсходныеДанные КАК ВТ_ИсходныеДанные
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Реализация КАК ВТ_Реализация
	|		ПО ВТ_ИсходныеДанные.Договор = ВТ_Реализация.Договор";
	
	Запрос.УстановитьПараметр("КонецПериода", Параметры.КонецПериода);
	Запрос.УстановитьПараметр("НачалоПериода", Параметры.НачалоПериода);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат;
	Иначе
		ДанныеДляНовогоДокумента = РезультатЗапроса.Выгрузить();
		ВсегоАктов = ДанныеДляНовогоДокумента.Количество();
		ДанныеДляНовогоДокумента.Колонки.Добавить("ДокументРеализация");
	КонецЕсли;
	
	ТекДок = 1;
	
	ТаблицаРезультат = Новый ТаблицаЗначений;
	КолонкаТаблицы = ТаблицаРезультат.Колонки.Добавить("Договор");
	КолонкаТаблицы = ТаблицаРезультат.Колонки.Добавить("ДокументРеализации");
	
	Для Каждого СтрокаТЗ Из ДанныеДляНовогоДокумента Цикл
		
		Если СтрокаТЗ.Реализация = Null Тогда
			НовыйДокумент = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
		Иначе 
			НовыйДокумент = СтрокаТЗ.Реализация.ПолучитьОбъект();
		КонецЕсли;
		
		НовыйДокумент.Дата = Параметры.КонецПериода;
		
		СтрокаТЗ.ДокументРеализация = НовыйДокумент;
		ЗаполнитьЗначенияСвойств(НовыйДокумент, СтрокаТЗ);
		НовыйДокумент.Заполнить(СтрокаТЗ);
		НовыйДокумент.Записать();
		
		Если НовыйДокумент.ПроверитьЗаполнение() Тогда
			НовыйДокумент.Записать(РежимЗаписиДокумента.Проведение);
		КонецЕсли;
		
		НоваяСтрока = ТаблицаРезультат.Добавить();
		НоваяСтрока.Договор = СтрокаТЗ.Договор;
		НоваяСтрока.ДокументРеализации = НовыйДокумент.Ссылка;
		
		ПроцентВыполнения = (ТекДок / ВсегоАктов) * 100;
		ПроцентВыполнения = Окр(ПроцентВыполнения, 0);
		
		ДлительныеОперации.СообщитьПрогресс(ПроцентВыполнения, СокрЛП(НовыйДокумент.Ссылка));
		
		ТекДок = ТекДок + 1;
		
	КонецЦикла;
	
	МассивДокументов = ОбщегоНазначения.ТаблицаЗначенийВМассив(ТаблицаРезультат);
	
	ПоместитьВоВременноеХранилище(МассивДокументов, АдресРезультата);
	
КонецПроцедуры

