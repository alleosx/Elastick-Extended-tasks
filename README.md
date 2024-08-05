Level 1. Linux
Развернута виртуальная машина в среде Virtualbox на базе ОС Ubuntu 20.04,

Level 2. Docker
Развернут контейнер с Nginx в качестве веб-прокси.
Весь роутинг настроен путем фильтрации доменных имен.
Тип хранилища папки /var/log - persistent volume. Необходимо для сбора и отправки логов в EFK Stack на уровне 5. 

Level 3. TaskManagerApp и PostgreSQL
Развернуты контейнеры с TaskManagerApp и PostgreSQL
Характеристики разворачиваемых сервисов:
PostgreSQL в standalone-варианте
Тип хранилища - persistent volume. При удалении контейнера данные должны сохраняться и быть доступны при последующем запуске нового контейнера PostgreSQL
pgAdmin развернут в отдельном контейнере и настроено подключение к БД.
Тип хранилища - persistent volume. При удалении контейнера и последующем запуске нового инстанса данные о подключении к БД должны сохраняться
При переходе по адресу pgadmin.test.com должен открываться интерфейс pgAdmin,  выставить логин/пароль на вход mail@test.com / kanban
TaskManagerApp
В качестве рабочей СУБД должен использоваться инстанс развернутой ранее в контейнере PostgreSQL.
При переходе по адресу kanban.test.com открывается TaskManagerApp
При переходе по адресу swagger.test.com открывается интерфейс Kanban REST API

Запуск всех сервисов должен выполнятся при помощи инструмента docker compose
Имя контейнера аналогично сервису
Volume: kanban-data:/var/lib/postgresql/data

Проброс портов 5432:5432

Переменные:

      - POSTGRES_DB=kanban
      - POSTGRES_USER=kanban
      - POSTGRES_PASSWORD=kanban

Сервис kanban-app
Сборка из Dockerfile в каталоге ./kanban-app

Имя контейнера аналогично сервису

Проброс портов 8080:8080

Переменные:

      - DB_SERVER=kanban-postgres
      - POSTGRES_DB=kanban
      - POSTGRES_USER=kanban
      - POSTGRES_PASSWORD=kanban

Линк kanban-postgres

Сервис kanban-ui
Сборка из Dockerfile в каталоге ./kanban-ui

Имя контейнера аналогично сервису

Проброс портов 4200:80

Линк kanban-app


Level 4. Prometheus и Grafana
Развернут контейнеры с Prometheus и Grafana.

Prometheus в standalone-варианте. Тип хранилища - persistent volume. При удалении контейнера данные должны сохраняться и быть доступны при последующем запуске нового контейнера 

Пазвернуты экспортеры для сбора метрик в Prometheus:

nginx_exporter для сбора метрик с Nginx
node_exporter для сбора метрик хостовой машины
postgres_exporter для сбора метрик с БД

Метрика по jvm с TaskManagerApp: 

Level 5. Elasticstack
Развернуты контейнеры с EFK stack в standalone-варианте.

Elasticsearch Тип хранилища - persistent volume. При удалении контейнера данные должны сохраняться и быть доступны при последующем запуске нового контейнера.

Fluentd для агрегации логов Nginx через отдельный volume, инициализированный на уровне 2.

Kibana как средство просмотра логов


Level 6. Extended tasks
Написае скрипт на bash по автоматизации бекапа базы PostgreSQL

Добавлен экспортер Сadvisor для сбора метрик c контейнеров


Архитектура

![Без названия](https://github.com/user-attachments/assets/d93afd01-4c27-4fe4-885b-3279ab8adcd7)


1. Проверка доступности сервисов.

test.com - Доступна стартовая страница Nginx

kanban.test.com - Доступна страница Kanban UI

swagger.test.com - Доступна страница Kanban REST Api

pgadmin.test.com - Доступна страница pgAdmin

grafana.test.com - Доступна страница Grafana

kibana.test.com - Доступна страница Kibana



2. Проверка корректности настройки и работы сервисов.

На странице Kanban UI через графическое окружение виртуалки успешно создаются канбан-доски и задачи внутри этих досок, работает перемещение по статусам.

На странице pgAdmin настроено подключение к БД, просматриваются данные по доскам и задачам внутри таблиц, выполнено резервное копирование БД.

На странице Grafana доступны дашборды для просмотра метрик:

Node метрики c хоста
Nginx метрики с веб-прокси
JVM метрики с Kanban
PostgreSQL метрики с БД
На странице Kibana доступны для просмотра логи с веб-прокси Nginx. Создан как минимум 1 дашборд по ошибкам в логах Nginx



### How to run it?

The entire application can be run with a single command on a terminal:

```
$ docker-compose up -d
```

If you want to stop it, use the following command:

```
$ docker-compose down
```

---
