DOCKER_COMPOSE = docker compose
GO = go
BINARY_NAME = cv-service
MIGRATE = docker compose run --rm migrator

.PHONY: up
up:
	$(DOCKER_COMPOSE) up -d

.PHONY: down
down:
	$(DOCKER_COMPOSE) down

.PHONY: logs
logs:
	$(DOCKER_COMPOSE) logs -f

.PHONY: build
build:
	$(DOCKER_COMPOSE) build

.PHONY: run
run:
	$(GO) run ./cmd/server

.PHONY: test
test:
	$(GO) test ./...

.PHONY: build-local
build-local:
	$(GO) build -o $(BINARY_NAME) ./cmd/server

.PHONY: dev
dev: up
	$(GO) run ./cmd/server

.PHONY: lint
lint:
	golangci-lint run

.PHONY: fmt
fmt:
	$(GO) fmt ./...

.PHONY: clean
clean:
	$(GO) clean
	rm -f $(BINARY_NAME)

.PHONY: migrate-up
migrate-up:
	$(MIGRATE) up

.PHONY: migrate-down
migrate-down:
	$(MIGRATE) down 1

.PHONY: migrate-create
migrate-create:
	@read -p "Введите имя миграции: " name; \
	$(MIGRATE) create -ext sql -dir . -seq $$name

.PHONY: help
help:
	@echo "Доступные команды:"
	@echo "  make up              - Запуск всех сервисов в Docker"
	@echo "  make down            - Остановка всех сервисов в Docker"
	@echo "  make logs            - Просмотр логов Docker-контейнеров"
	@echo "  make build           - Сборка Docker-образов"
	@echo "  make run             - Запуск приложения локально"
	@echo "  make test            - Запуск тестов"
	@echo "  make build-local     - Сборка бинарного файла локально"
	@echo "  make dev             - Запуск сервисов в Docker и приложения локально"
	@echo "  make lint            - Запуск линтера"
	@echo "  make fmt             - Форматирование кода"
	@echo "  make clean           - Очистка артефактов сборки"
	@echo "  make migrate-up      - Применение всех миграций"
	@echo "  make migrate-down    - Откат последней миграции"
	@echo "  make migrate-create  - Создание новой миграции"
