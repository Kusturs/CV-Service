package main

import (
	"log"

	db "cv-service/internal/infrastructure/persistence/postgres"
)

func main() {
	pool, err := db.NewConnection()
	if err != nil {
		log.Fatalf("Failed to connect to the database: %v", err)
	}
	defer pool.Close()

	// Здесь вы можете использовать pool для выполнения запросов к базе данных

	// Пример использования:
	// rows, err := pool.Query(context.Background(), "SELECT * FROM users")
	// if err != nil {
	//     log.Fatalf("Failed to execute query: %v", err)
	// }
	// defer rows.Close()
	// ... обработка результатов ...

	// Запуск вашего HTTP-сервера или другой логики приложения
}
