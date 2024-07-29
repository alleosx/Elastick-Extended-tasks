
Elastick-Extended-tasks
Характеристики разворачиваемых сервисов:

PostgreSQL в standalone-варианте Тип хранилища - persistent volume. При удалении контейнера данные должны сохраняться и быть доступны при последующем запуске нового контейнера PostgreSQL

pgAdmin развернут в отдельном контейнере. Тип хранилища - persistent volume. При удалении контейнера и последующем запуске нового инстанса данные о подключении к БД должны сохраняться При переходе по адресу pgadmin.test.com должен открываться интерфейс pgAdmin, выставить логин/пароль на вход mail@test.com / kanban

TaskManagerApp В качестве рабочей СУБД должен использоваться инстанс развернутой ранее в контейнере PostgreSQL. При переходе по адресу kanban.test.com открывается TaskManagerApp При переходе по адресу swagger.test.com/api/swagger-ui.html открывается интерфейс Kanban REST API

Развернуты контейнеры Prometheus и Grafana.

Prometheus в standalone-варианте. Тип хранилища - persistent volume. При удалении контейнера данные должны сохраняться и быть доступны при последующем запуске нового контейнера РазвернутЫ экспортеры для сбора метрик в Prometheus:

nginx_exporter для сбора метрик с Nginx node_exporter для сбора метрик хостовой машины postgres_exporter для сбора метрик с БД Метрика по jvm с TaskManagerApp:

Развернуты контейнеры с EFK stack в standalone-варианте. Elasticsearch Тип хранилища - persistent volume. При удалении контейнера данные должны сохраняться и быть доступны при последующем запуске нового контейнера. Fluentd для агрегации логов Nginx через отдельный volume nginx-proxy.

Kibana как средство просмотра логов

Написан скрипт на bash по автоматизации бекапа базы PostgreSQL Добавлен экспортер Сadvisor для сбора метрик c контейнеров Добавлен дашборд для отображения метрик Сadvisor

![загрузка](https://github.com/user-attachments/assets/5f955efe-bc78-461b-98aa-9b87c054d290)


test.com - Доступна стартовая страница Nginx

kanban.test.com - Доступна страница Kanban UI

swagger.test.com - Доступна страница Kanban REST Api

pgadmin.test.com - Доступна страница pgAdmin

grafana.test.com - Доступна страница Grafana

kibana.test.com - Доступна страница Kibana

На странице Kanban UI через графическое окружение виртуалки успешно создаются канбан-доски и задачи внутри этих досок, работает перемещение по статусам.

На странице pgAdmin настроено подключение к БД, просматриваются данные по доскам и задачам внутри таблиц, выполнено резервное копирование БД.

На странице Grafana доступны дашборды для просмотра метрик:

Node метрики c хоста Nginx метрики с веб-прокси JVM метрики с Kanban PostgreSQL метрики с БД На странице Kibana доступны для просмотра логи с веб-прокси Nginx. Создан как минимум 1 дашборд по ошибкам в логах Nginx
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
