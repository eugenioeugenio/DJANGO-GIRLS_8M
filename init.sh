#!/bin/sh

# Останавливаем выполнение при любой ошибке
set -e

# Применяем миграции
python3 manage.py migrate --noinput

# Создаем суперпользователя (только если его еще нет)
echo "from django.contrib.auth.models import User; \
if not User.objects.filter(username='admin').exists(): \
    User.objects.create_superuser('admin', 'admin@example.com', 'pass')" \
| python3 manage.py shell

# Запускаем сам сервер (важно, чтобы контейнер не выключался)
python3 manage.py runserver 0.0.0.0:8000
