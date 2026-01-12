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