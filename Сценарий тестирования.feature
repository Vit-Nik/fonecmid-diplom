﻿#language: ru

@tree

Функционал: Проверка корректности создания документов "Обслуживание клиента" Менеджером с последующим закрытием
 этих документов Специалистом. Проверка массового создания "Актов" Бухгалтером на основании документов 
 "Обслуживание клиента". Корректность формирования отчета "Анализ выставленных актов".

Как тестировщик-автоматизатор я хочу 
автоматизировать процесс проверки создания документов "Обслуживание клиента", массового создания "Актов" и корректность
 формирования отчета "Анализ выставленных актов" 
чтобы не делать этого вручную   

Контекст:
	И я закрываю все окна клиентского приложения

Сценарий: Я проверяю корректность создания документов Обслуживание клиента, массовое создание "Актов" на основании этих документов и корректность формирования отчета "Анализ выставленных актов".
	* Я запускаю сценарий от имени менеджера Попов Алексей
		И я подключаю TestClient "От имени менеджера" логин "Попов Алексей" пароль ""		
	* Я создаю документ Обслуживание клиента для клиента ООО Сатурн и специалистом Петров Петр
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживания клиентов'
		Тогда открылось окно 'Обслуживания клиентов'
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Обслуживание клиента (создание)'
		И я нажимаю кнопку выбора у поля с именем "Дата"
		И в поле с именем 'Дата' я ввожу текст '03.03.2025'
		И я нажимаю кнопку выбора у поля с именем "Клиент"
		Тогда открылось окно 'Контрагенты'
		И в таблице  "Список" я перехожу на один уровень вниз
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '0000000*'  | 'ООО Сатурн'   |
		И в таблице "Список" я выбираю текущую строку
		Когда открылось окно 'Обслуживание клиента (создание) *'
		И я нажимаю кнопку выбора у поля с именем "Договор"
		Тогда открылось окно 'Договоры контрагентов'
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '0000000*'  | 'ДАО2'         |
		И в таблице "Список" я выбираю текущую строку
		И я нажимаю кнопку выбора у поля с именем "Специалист"
		Тогда открылось окно 'Сотрудники'
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '0000000*'  | 'Петров Петр'  |
		И в таблице "Список" я выбираю текущую строку			
		И из выпадающего списка с именем "Специалист" я выбираю точное значение 'Петров Петр'
		И в поле с именем 'ОписаниеПроблемы' я ввожу текст 'Установить операционную систему'
		И я нажимаю кнопку выбора у поля с именем "ДатаПроведенияРабот"
		И в поле с именем 'ДатаПроведенияРабот' я ввожу текст '04.03.2025'
		И в поле с именем 'ВремяНачалаРаботПлан' я ввожу текст ' 9:00:00'
		И в поле с именем 'ВремяОкончанияработПлан' я ввожу текст '11:00:00'
		И я перехожу к следующему реквизиту
		И я нажимаю на кнопку с именем 'ФормаЗаписать'
		Тогда открылось окно 'Обслуживание клиента * от *'
		И Я закрываю окно 'Обслуживание клиента * от *'
		Тогда открылось окно 'Обслуживания клиентов'		
	* Тогда в форме списка документа Обслуживание клиентов появилась новая запись
		И таблица "Список" содержит строки по шаблону:
			| 'Дата'       | 'Клиент'     | 'Специалист'   | 'Номер'     | 'Описание проблемы'               | 'Комментарий' |
			| '03.03.2025' | 'ООО Сатурн' | 'Петров Петр'  | '0000000*'  | 'Установить операционную систему' | ''            |
	* Я создаю документ Обслуживание клиента для клиента ООО Квазар и специалистом Иванов Иван
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживания клиентов'
		Тогда открылось окно 'Обслуживания клиентов'
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Обслуживание клиента (создание)'
		И я нажимаю кнопку выбора у поля с именем "Дата"
		И в поле с именем 'Дата' я ввожу текст '12.03.2025'
		И я нажимаю кнопку выбора у поля с именем "Клиент"
		Тогда открылось окно 'Контрагенты'
		И в таблице  "Список" я перехожу на один уровень вниз
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '0000000*'  | 'ООО Квазар'   |
		И в таблице "Список" я выбираю текущую строку
		И я нажимаю кнопку выбора у поля с именем "Договор"
		Тогда открылось окно 'Договоры контрагентов'
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '0000000*'  | 'ДАО1'         |
		И в таблице "Список" я выбираю текущую строку
		И я нажимаю кнопку выбора у поля с именем "Специалист"
		Тогда открылось окно 'Сотрудники'
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '0000000*'  | 'Иванов Иван'  |
		И в таблице "Список" я выбираю текущую строку			
		И в поле с именем 'ОписаниеПроблемы' я ввожу текст 'Ремонт ноутбука'
		И я нажимаю кнопку выбора у поля с именем "ДатаПроведенияРабот"
		И в поле с именем 'ДатаПроведенияРабот' я ввожу текст '14.03.2025'
		И в поле с именем 'ВремяНачалаРаботПлан' я ввожу текст '10:00:00'
		И в поле с именем 'ВремяОкончанияработПлан' я ввожу текст '12:00:00'
		И я перехожу к следующему реквизиту
		И я нажимаю на кнопку с именем 'ФормаЗаписать'
		Тогда открылось окно 'Обслуживание клиента * от *'
		И Я закрываю окно 'Обслуживание клиента * от *'
		Тогда открылось окно 'Обслуживания клиентов'		
	* Тогда в форме списка документа Обслуживание клиента появилась новая запись
		И таблица "Список" содержит строки по шаблону:
			| 'Дата'       | 'Клиент'     | 'Специалист'   | 'Номер'     | 'Описание проблемы'               | 'Комментарий' |
			| '12.03.2025' | 'ООО Квазар' | 'Иванов Иван'  | '0000000*'  | 'Ремонт ноутбука'                 | ''            |
	* Я создаю документ Обслуживание клиента для клиента ООО Уран и специалистом Кузин Степан
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживания клиентов'
		Тогда открылось окно 'Обслуживания клиентов'
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Обслуживание клиента (создание)'
		И я нажимаю кнопку выбора у поля с именем "Дата"
		И в поле с именем 'Дата' я ввожу текст '24.03.2025'
		И я нажимаю кнопку выбора у поля с именем "Клиент"
		Тогда открылось окно 'Контрагенты'
		И в таблице  "Список" я перехожу на один уровень вниз
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '0000000*'  | 'ООО Уран'     |
		И в таблице "Список" я выбираю текущую строку
		И я нажимаю кнопку выбора у поля с именем "Договор"
		Тогда открылось окно 'Договоры контрагентов'
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '0000000*'  | 'ДАО4'         |
		И в таблице "Список" я выбираю текущую строку
		И я нажимаю кнопку выбора у поля с именем "Специалист"
		Тогда открылось окно 'Сотрудники'
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование'  |
			| '0000000*'  | 'Кузин Степан'  |
		И в таблице "Список" я выбираю текущую строку		
		И в поле с именем 'ОписаниеПроблемы' я ввожу текст 'Ремонт кулера'
		И я нажимаю кнопку выбора у поля с именем "ДатаПроведенияРабот"
		И в поле с именем 'ДатаПроведенияРабот' я ввожу текст '25.03.2025'
		И в поле с именем 'ВремяНачалаРаботПлан' я ввожу текст '12:00:00'
		И в поле с именем 'ВремяОкончанияработПлан' я ввожу текст '14:00:00'
		И я перехожу к следующему реквизиту
		И я нажимаю на кнопку с именем 'ФормаЗаписать'
		Тогда открылось окно 'Обслуживание клиента * от *'
		И Я закрываю окно 'Обслуживание клиента * от *'
		Тогда открылось окно 'Обслуживания клиентов'
	* Тогда в форме списка документа Обслуживание клиента появилась новая запись	
		И таблица "Список" содержит строки по шаблону:
			| 'Дата'       | 'Клиент'     | 'Специалист'   | 'Номер'     | 'Описание проблемы'               | 'Комментарий' |
			| '24.03.2025' | 'ООО Уран'   | 'Кузин Степан' | '0000000*'  | 'Ремонт кулера'                   | ''            |
	* Я закрываю сеанс от имени менеджера Попов Алексей
		И я закрываю TestClient "От имени менеджера"
	* Я запускаю сценарий от имени специалиста Петров Петр
		И я подключаю TestClient "От имени специалиста" логин "Петров Петр" пароль ""			
	* Я заполняю документ Обслуживание клиента ООО Сатурн фактическими данными
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживания клиентов'
		Тогда открылось окно 'Обслуживания клиентов'
		И в таблице "Список" я перехожу к строке:
			| 'Дата'       | 'Клиент'     | 'Номер'     | 'Описание проблемы'               | 'Специалист'  |
			| '03.03.2025' | 'ООО Сатурн' | '0000000*'  | 'Установить операционную систему' | 'Петров Петр' |		
		И в таблице "Список" я выбираю текущую строку		
		Тогда открылось окно 'Обслуживание клиента * от *'
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Проверка технического состояния'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '2,00'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасыКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Копирование данных'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасыКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Установка операционной системы'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '2,00'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасыКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '2,00'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Обслуживание клиента * от * *' в течение 20 секунд
	*Тогда в форме списка регистра накопления Выполненные клиенту работы появилась новая запись	
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Выполненные клиентам работы'
		Тогда открылось окно 'Выполненные клиентам работы'
		И в таблице "Список" я перехожу к строке:
			| 'Договор' | 'Клиент'     | 'Количество часов' | 'Номер строки' | 'Период'              | 'Регистратор'                                  | 'Сумма к оплате' |
			| 'ДАО2'    | 'ООО Сатурн' | '4'                | '1'            | '03.03.2025 12:00:00' | 'Обслуживание клиента 0000000* от 03.03.2025'  | '7 200,00'       |
		И таблица "Список" содержит строки по шаблону:
			| 'Договор' | 'Клиент'     | 'Количество часов' | 'Номер строки' | 'Период'              | 'Регистратор'                                  | 'Сумма к оплате' |
			| 'ДАО2'    | 'ООО Сатурн' | '4'                | '1'            | '03.03.2025 12:00:00' | 'Обслуживание клиента 0000000* от 03.03.2025'  | '7 200,00'       |
	* Я заполняю документ Обслуживание клиента ООО Квазар фактическими данными					
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживания клиентов'
		Тогда открылось окно 'Обслуживания клиентов'
		И в таблице "Список" я перехожу к строке:
			| 'Дата'       | 'Клиент'     | 'Номер'     | 'Описание проблемы' | 'Специалист'  |
			| '12.03.2025' | 'ООО Квазар' | '0000000*'  | 'Ремонт ноутбука'   | 'Иванов Иван' |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента * от *'
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Диагностика неисправностей'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасыКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Замена кулера'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасыКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Обслуживание клиента * от * *' в течение 20 секунд
	*Тогда в форме списка регистра накопления Выполненные клиенту работы появилась новая запись	
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Выполненные клиентам работы'
		Тогда открылось окно 'Выполненные клиентам работы'
		И в таблице "Список" я перехожу к строке:
			| 'Период'              | 'Регистратор'                                  | 'Номер строки' | 'Клиент'     | 'Договор'   | 'Количество часов' | 'Сумма к оплате' |
			| '12.03.2025 12:00:00' | 'Обслуживание клиента 0000000* от 12.03.2025'  | '1'            | 'ООО Квазар' | 'ДАО1'      | '2'                | '3 000,00'       |
		И таблица "Список" содержит строки по шаблону:
			| 'Период'              | 'Регистратор'                                  | 'Номер строки' | 'Клиент'     | 'Договор'   | 'Количество часов' | 'Сумма к оплате' |
			| '12.03.2025 12:00:00' | 'Обслуживание клиента 0000000* от 12.03.2025'  | '1'            | 'ООО Квазар' | 'ДАО1'      | '2'                | '3 000,00'       |								
	* Я заполняю документ Обслуживание клиента ООО Уран фактическими данными	
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживания клиентов'
		Тогда открылось окно 'Обслуживания клиентов'
		И в таблице "Список" я перехожу к строке:
			| 'Дата'       | 'Клиент'   | 'Номер'     | 'Описание проблемы' | 'Специалист'   |
			| '24.03.2025' | 'ООО Уран' | '000000*' | 'Ремонт кулера'     | 'Кузин Степан' |
		И в таблице "Список" я активизирую поле с именем "Дата"
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента * от *'
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Диагностика работ'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасыКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Чистка'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасыКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Тестирование'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасыКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '1,00'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Обслуживание клиента * от * *' в течение 20 секунд
	*Тогда в форме списка регистра накопления Выполненные клиенту работы появилась новая запись	
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Выполненные клиентам работы'
		Тогда открылось окно 'Выполненные клиентам работы'
		И в таблице "Список" я перехожу к строке:
			| 'Договор' | 'Клиент'   | 'Количество часов' | 'Номер строки' | 'Период'              | 'Регистратор'                                  | 'Сумма к оплате' |
			| 'ДАО4'    | 'ООО Уран' | '3'                | '1'            | '24.03.2025 12:00:00' | 'Обслуживание клиента 0000000* от 24.03.2025'  | '7 500,00'       |
		И таблица "Список" содержит строки по шаблону:
			| 'Договор' | 'Клиент'   | 'Количество часов' | 'Номер строки' | 'Период'              | 'Регистратор'                                  | 'Сумма к оплате' |
			| 'ДАО4'    | 'ООО Уран' | '3'                | '1'            | '24.03.2025 12:00:00' | 'Обслуживание клиента 0000000* от 24.03.2025'  | '7 500,00'       |
	* Я закрываю сеанс от имени специалиста Петров Петр
		И я закрываю TestClient "От имени специалиста"
	* Я запускаю сценарий от имени бухгалтера Сидоров Сидор
		И я подключаю TestClient "От имени бухгалтера" логин "Сидоров Сидор" пароль ""											
	* Я делаю Масовое создание актов
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Массовое создание актов'
		Тогда открылось окно 'Массовое создание актов'
		И я нажимаю кнопку выбора у поля с именем "Период"
		Тогда открылось окно 'Выберите период'
		И я нажимаю кнопку выбора у поля с именем "DateBegin"
		И в поле с именем 'DateBegin' я ввожу текст '01.03.2025'
		И я нажимаю кнопку выбора у поля с именем "DateEnd"
		И в поле с именем 'DateEnd' я ввожу текст '31.03.2025'
		И я нажимаю на кнопку с именем 'Select'
		Тогда открылось окно 'Массовое создание актов'
		И я нажимаю на кнопку с именем 'ФормаСоздатьАкты'	
	* Тогда в таблице Сформированные документы появились новые записи
		Когда открылось окно 'Массовое создание актов'
		И таблица "СформированныеДокументы" содержит строки по шаблону:
			| 'Договор' | 'Документ реализации'                                       |
			| 'ДАО1'    | 'Реализация товаров и услуг 000000* от 31.03.2025 23:59:59' |
			| 'ДАО2'    | 'Реализация товаров и услуг 000000* от 31.03.2025 23:59:59' |
			| 'ДАО4'    | 'Реализация товаров и услуг 000000* от 31.03.2025 23:59:59' |
	* Я формирую отчет Анализ выставленных актов и сравниваю с эталоном
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Анализ выставленных актов'
		Тогда открылось окно 'Анализ выставленных актов'
		И я нажимаю кнопку выбора у поля с именем "Период1ДатаНачала"
		И в поле с именем 'Период1ДатаНачала' я ввожу текст '01.03.2025'
		И я нажимаю кнопку выбора у поля с именем "Период1ДатаОкончания"
		И в поле с именем 'Период1ДатаОкончания' я ввожу текст '31.03.2025'
		И я нажимаю на кнопку с именем 'СформироватьОтчет'
		Тогда табличный документ "ОтчетТабличныйДокумент" равен:
			| 'Анализ выставленных актов' | ''        | ''                        | ''                           |
			| ''                          | ''        | ''                        | ''                           |
			| 'Клиент'                    | 'Договор' | 'Сумма выполненных работ' | 'Сумма начисленная к оплате' |
			| 'ООО Сатурн'                | 'ДАО2'    | '7 200,00'                | '7 200,00'                   |
			| 'ООО Квазар'                | 'ДАО1'    | '3 000,00'                | '3 000,00'                   |
			| 'ООО Уран'                  | 'ДАО4'    | '7 500,00'                | '7 500,00'                   |
			| 'Итого'                     | ''        | '17 700,00'               | '17 700,00'                  |
		
											