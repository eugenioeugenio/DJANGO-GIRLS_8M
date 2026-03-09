FROM python:3.11-alpine
ENV PYTHONUNBUFFERED=1
WORKDIR /code

# Устанавливаем зависимости
COPY requirements.txt /code/
RUN pip install --no-cache-dir -r requirements.txt

# Копируем всё остальное
COPY . /code/

# КЛЮЧЕВОЙ МОМЕНТ: лечим файл прямо в контейнере
RUN apk add --no-cache dos2unix && \
    dos2unix /code/entrypoint.sh && \
    chmod +x /code/entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/bin/sh", "/code/entrypoint.sh"]

