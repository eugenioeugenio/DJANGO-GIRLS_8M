#!/bin/sh
mkdir -p /code/db

# Даем полные права на папку (чтобы SQLite мог создать файл)
chmod 777 /code/db


# 1. Миграции
python3 manage.py migrate --noinput

# 2. Создание админа в одну строку, чтобы кавычки не терялись
python3 manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'pass') if not User.objects.filter(username='admin').exists() else print('Admin exists')"

# 3. Запуск сервера (обязательно!)
python3 manage.py runserver 0.0.0.0:8000
