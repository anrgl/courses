
![ci badge](https://github.com/anrgl/courses/actions/workflows/ci.yml/badge.svg)
# Courses - прототип API приложения онлайн курсов

## Стек
- Ruby 3.3
- Ruby on rails 7.2
- PostgreSQL 16
- Docker
    

## Настройка проекта
```bash
make build
```
```bash
make bash
```
```bash
bundle install
```
```bash
rails db:drop db:create db:migrate db:seed
```

## Запуск проекта
```bash
make app
```

## Тестирование
```bash
make rswag
```

API docs по адресу http://localhost:3000/api-docs

```bash
make test
```
