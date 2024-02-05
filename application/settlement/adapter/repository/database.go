package repository

import (
	"fmt"
	"os"

	"github.com/jmoiron/sqlx"
)

func NewDB() (*sqlx.DB, error) {
	dsn := os.Getenv("Database")
	if dsn == "" {
		dsn = "settlement_user:default_password@tcp(127.0.0.1:5432)/settlmentdb"
	}

	db, err := sqlx.Open("postgres", dsn)
	if err != nil {
		return nil, fmt.Errorf("failed to init DB: %w", err)
	}

	return db, nil
}
