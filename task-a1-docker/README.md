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
```bash
version: '3.8'
services:
  web:
    image: my-web-app:latest
    container_name: my-web-compose
    ports:
      - "8081:80"
    restart: unless-stopped
    
### 7. Docker Compose запуск

# Запуск
docker-compose up -d

# Проверка (порт 8081!)
curl http://localhost:8081

# Или в браузере
http://localhost:8081
```
### 7.	Вопрос для размышления: Как можно доставить твой index.html в контейнер, не пересобирая образ?

Есть несколько способов доставить index.html без пересборки образа:
```bash
1. **Volume Mount (рекомендуется для разработки):**
   ```bash
   docker run -v ./index.html:/usr/share/nginx/html/index.html -p 8080:80 nginx:alpine
Файл монтируется с хоста, изменения видны сразу.
2. **Bind Mount (более гибкий):**
   ```bash
   docker run --mount type=bind,source=./index.html,target=/usr/share/nginx/html/index.html -p 8080:80 nginx:alpine
   
   Отличие от Volume: Можно контролировать тип монтирования (read-only, read-write)
На практике чаще всего используют Volume Mount — простой и эффективный способ обновлять контент без пересборки.
```
## Автор
Dushkin Aleksandr

