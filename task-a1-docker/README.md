# Задание A1: "Собери и запусти" (Docker)

## Цель
Развернуть простое веб-приложение с использованием Docker

## Выполнение

### 1. Созданы файлы
- `Dockerfile` - конфигурация образа на основе nginx:alpine
- `index.html` - простая веб-страница
- `docker-compose.yml` - конфигурация для Docker Compose

### 2. Dockerfile
```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
# Сборка образа
docker build -t my-web-app:latest .

# Запуск контейнера
docker run -d --name my-web -p 8080:80 my-web-app:latest

# Проверка
curl http://localhost:8080
4. Результат
Образ успешно собран: my-web-app:latest

Контейнер запущен на порту 8080

Веб-страница доступна по http://localhost:8080
```
### 5. Docker Compose

version: '3.8'
services:
  web:
    image: my-web-app:latest
    container_name: my-web-compose
    ports:
      - "8081:80"
    restart: unless-stopped
    
### 7. Docker Compose запуск
```bash
# Запуск
docker-compose up -d

# Проверка (порт 8081!)
curl http://localhost:8081

# Или в браузере
http://localhost:8081

