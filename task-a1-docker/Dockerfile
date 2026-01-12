# Используем легкий образ nginx
FROM nginx:alpine

# Копируем нашу страницу в контейнер
COPY index.html /usr/share/nginx/html/

# Открываем порт 80
EXPOSE 80

# Команда запуска nginx
CMD ["nginx", "-g", "daemon off;"]
