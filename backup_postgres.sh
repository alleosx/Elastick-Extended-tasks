#!/bin/bash

# Параметры подключения к БД
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME=kanban
DB_USER=kanban
DB_PASSWORD=kanban

# Путь для сохранения бекапов
BACKUP_DIR="/path/to/backup/directory"
DATE=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_backup_$DATE.sql"

# Экспорт переменной пароля для pg_dump
export PGPASSWORD=$DB_PASSWORD

# Выполнение бекапа
pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER -F c -b -v -f $BACKUP_FILE $DB_NAME

# Очистка переменной пароля
unset PGPASSWORD

# Логирование
echo "Backup completed: $BACKUP_FILE"
