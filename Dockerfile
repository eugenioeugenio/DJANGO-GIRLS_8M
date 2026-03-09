FROM python:3.11-alpine
ENV PYTHONUNBUFFERED=1
WORKDIR /code

# Устанавливаем зависимости
COPY requirements.txt /code/
RUN pip install --no-cache-dir -r requirements.txt

# Копируем проект
COPY . /code/

# Исправляем права и конвертируем переносы строк (на случай, если ты забыл про LF в VS Code)
RUN apk add --no-cache dos2unix && \
    dos2unix /code/entrypoint.sh && \
    chmod +x /code/entrypoint.sh

EXPOSE 8000

# Запускаем один главный скрипт
ENTRYPOINT ["/bin/sh", "/code/entrypoint.sh"]
