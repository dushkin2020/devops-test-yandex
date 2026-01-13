# Задание B2: "Маленькая проблема в Git"

## Ситуация
1. Работа в ветке `feature/junior-task` с незакоммиченными изменениями
2. Срочно нужно переключиться на `main` для исправления бага
3. После возврата нужно переименовать последний коммит

## Решение

### Часть 1: Сохранение незакоммиченных изменений

```bash
# Начало работы
git checkout -b feature/junior-task

# ... работаем, изменения не готовы для коммита ...

# Срочное переключение на main
git stash push -m "Временное сохранение"
git checkout main

# Исправление бага
# ... исправляем код ...
git add .
git commit -m "Fix: critical bug hotfix"
git push origin main

# Возврат к задаче
git checkout feature/junior-task
git stash pop

# ... продолжаем работу ...

# Переименование последнего коммита (если нужно)
git add .
git commit --amend -m "Feature: реализована новая функциональность"
# ВНИМАНИЕ: --force меняет историю, используйте осторожно!
# Лучше использовать --force-with-lease для безопасности
```
### Полезные команды stash
```bash
# Вместо stash можно сделать временный коммит
git add .
git commit -m "WIP: временное сохранение"

# Потом откатить коммит, но сохранить изменения
git reset --soft HEAD~1
```
## Ссылки на документацию
- [Git Stash](https://git-scm.com/docs/git-stash) - документация по stash
- [Git Commit --amend](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---amend) - изменение последнего коммита
- [Git Force With Lease](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-leaseltrefnamegt) - безопасный force push

## Автор
Dushkin Aleksandr