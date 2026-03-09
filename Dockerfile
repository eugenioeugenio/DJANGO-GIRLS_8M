FROM python:3.11-alpine
ENV PYTHONUNBUFFERED=1
WORKDIR /code

RUN apk add --no-cache dos2unix

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Лечим именно тот файл, который ЕСТЬ в папке
RUN dos2unix init.sh && chmod +x init.sh

EXPOSE 8000

# Запускаем через init.sh
ENTRYPOINT ["/bin/sh", "/code/init.sh"]



