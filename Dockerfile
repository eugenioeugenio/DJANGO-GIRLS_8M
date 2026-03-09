FROM python:3.11-alpine
ENV PYTHONUNBUFFERED=1
WORKDIR /code

# 1. Устанавливаем системные зависимости
RUN apk add --no-cache dos2unix

# 2. Ставим питон-пакеты
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 3. Копируем проект
COPY . .

# 4. ЛЕЧИМ СКРИПТ (явно указываем путь из WORKDIR)
RUN dos2unix entrypoint.sh && chmod +x entrypoint.sh

EXPOSE 8000

# Используем полный путь для надежности
ENTRYPOINT ["/bin/sh", "/code/entrypoint.sh"]


