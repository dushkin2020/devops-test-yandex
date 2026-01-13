#!/bin/bash

# Задание B1: "Простой скрипт-помощник" (Bash)
# Скрипт для очистки старых лог-файлов

# Функция вывода справки
show_help() {
    echo "Использование: $0 /путь/к/директории N"
    echo ""
    echo "Описание:"
    echo "  Находит и удаляет файлы с расширением .log старше N дней"
    echo ""
    echo "Аргументы:"
    echo "  /путь/к/директории - директория для поиска лог-файлов"
    echo "  N                  - количество дней (файлы старше N дней)"
    echo ""
    echo "Примеры:"
    echo "  $0 /var/log 7      # Удалить лог-файлы старше 7 дней в /var/log"
    echo "  $0 ./logs 30       # Удалить лог-файлы старше 30 дней в ./logs"
    exit 1
}

# Проверка количества аргументов
if [ $# -ne 2 ]; then
    echo "Ошибка: Неправильное количество аргументов"
    echo ""
    show_help
fi

DIR_PATH="$1"
DAYS="$2"

# Проверка существования директории
if [ ! -d "$DIR_PATH" ]; then
    echo "Ошибка: Директория '$DIR_PATH' не существует"
    exit 1
fi

# Проверка что DAYS - число
if ! [[ "$DAYS" =~ ^[0-9]+$ ]]; then
    echo "Ошибка: Второй аргумент должен быть числом (количество дней)"
    exit 1
fi

# Поиск файлов .log старше N дней
echo "Поиск .log файлов в '$DIR_PATH' старше $DAYS дней..."
echo "--------------------------------------------------------"

# Используем find для поиска файлов
LOG_FILES=$(find "$DIR_PATH" -name "*.log" -type f -mtime +"$DAYS")

if [ -z "$LOG_FILES" ]; then
    echo "Файлы не найдены."
    exit 0
fi

# Вывод найденных файлов
echo "Найдены следующие файлы:"
echo ""
count=1
echo "$LOG_FILES" | while read -r file; do
    file_size=$(du -h "$file" | cut -f1)
    file_date=$(stat -c "%y" "$file" | cut -d' ' -f1)
    echo "  $count. $file"
    echo "     Размер: $file_size, Дата изменения: $file_date"
    count=$((count + 1))
done

echo ""
echo "Всего файлов: $(echo "$LOG_FILES" | wc -l)"
echo ""

# Запрос подтверждения
read -p "Удалить эти файлы? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Удаление файлов..."
    echo "$LOG_FILES" | while read -r file; do
        if rm -v "$file"; then
            echo "  Удалено: $file"
        else
            echo "  Ошибка при удалении: $file"
        fi
    done
    echo "Удаление завершено."
else
    echo "Удаление отменено."
fi
