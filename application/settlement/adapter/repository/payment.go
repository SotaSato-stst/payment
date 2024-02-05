package repository

import "github.com/jmoiron/sqlx"

type PaymentRepository struct {
	db *sqlx.DB
}

func NewPaymentRepository(db *sqlx.DB) *PaymentRepository {
	return &PaymentRepository{db: db}
}

func (r *PaymentRepository) SavePayment(paymentType string, fromId string, toId string, amount int) error {
	return nil
}
