# ЛЦТ-2024 <br /> <br /> Мобильное приложение для управления антропогенной нагрузкой на особо охраняемых природных территориях Камчатского края.  <br /><br />Команда CopyPasteAdapt<br />https://disk.yandex.ru/d/OCxxeL4fbA_ihw

Разработанное командой решение состоит из:
- Мобильного приложения;
- Серверного приложения;
- Веб-приложения.
## Мобильное приложение - kamchatka_mobile <br /> https://github.com/Glebosik/Kamchatka-2024/releases/tag/Android
Мобильное приложение разрабатывалось на кроссплатформенном фреймворке Flutter. В рамках хакатона была реализована часть функционала из созданного дизайна приложения, достаточная для тестирования основных возможностей решения. Разработка решения на фреймворке Flutter позволяет в будущем отойти от мобильных приложений и перейти к формату PWA.
## Веб-приложение - kamchatka_web <br /> https://copy-paste-adapt.ru/
Веб-приложение для администрации также разрабатывалось на Flutter и включает в себя базовый функционал по работе со спроектированной системой.
## Серверное приложение - kamchatka_backend
Серверная часть данного приложения разработана для обработки запросов от мобильного приложения и клиентской веб-версии по технологии RestAPI, Flutter-Flask.
Архитектура приложения представляет собой:
1.	Виртуальный сервер на базе ОС Ubuntu 22.04.4 LTS:
    - Домен «copy-paste-adapt.ru»;
    - SSL-сертификат: Let`s Encrypt привязанный к домену.
2.	Веб-сервер Nginx версии 1.18.0;
3.	СУБД PostgreSQL версии 14.12 для работы с реляционной БД:
    - Таблица Users – Хранение данных зарегистрированных пользователей;
    - Таблица Proposals – Хранение заявок на посещение;
    - Таблица Incedents – Хранение отправленных пользователями проблем;
    - Таблица TourObjects – Хранение данных и коэффициентов о природных объектах;
    - Таблица Routes – Хранение данных и коэффициентов маршрутов на природных объектах;
    - Таблица Notifications - Хранение данных об обнаруженных с помощью нейросети (возгораниях, задымлениях) на космических фотоснимках;
4.	NoSQL-хранилище для ООПТ;
5.	WSGI-сервер Gunicorn версии 20.1.0-2;
6.	Systemd-unit-сервис обеспечения отказоустойчивости;
7.	Flask-сервер версии 2.3.2:
    - API:
      - API регистрации (все данные пользователя + хешированный пароль);
      - API входа в учетную запись пользователей;
      - API входа в учетную запись администраторов и модераторов;
      - API выхода из учетной записи;
      - API получение данных ООПТ из NoSQL базы;
      - API отправки пользователем заявки на посещение;
      - API отправки пользователем отчёта о проблеме;
      - API получения списка администраторов и модераторов;
      - API изменения администратором роли пользователей;
      - API получение данных из реляционной БД о проблемах;
      - API получение данных из реляционной БД о заявках;
      - API изменения администратором статуса заявки пользователя;
      - API получения администратором всех заявок указанного пользователя;
      - API изменения администратором статуса проблемы;
      - API расчета максимального количества людей на объекте;
      - API сервиса рекомендаций;
      - API получения погодных условий на объекте;
      - API интеллектуального обнаружения гари (возгорания, задымлений) на космических фотоснимках и получение координат выявленных происшествий
    - Хеширование и сравнение хешей паролей;
    - Комплекс валидаторов учётных данных;
    - ORM-SQLalchemy интерфейс взаимодействия с реляционной БД;
    - Система контроля состояния, целостности и миграции реляционной БД;
    - Функционал сокрытия конфиденциальных данных и переменных посредством хранения их в оболочке виртульного пространства;
8. Математическая модель для сервиса рекомендаций природных парков для посещения, основывающаяся более чем на 60 признаковых столбцах с возможностью увеличения по данным за 7 лет. Для демонстрации идеи использовалась архитектура модели RandomForestRegressor. Вывод модели – оптимальное количество людей на маршруте в соответствии с погодными условиями.
9. Нейросетевая модель для обнаружения гари (возгорания и задымлений на космических фотоснимках и получение координат выявленных происшествий - kamchatka_backend/kosmosnimki_final_version.py
