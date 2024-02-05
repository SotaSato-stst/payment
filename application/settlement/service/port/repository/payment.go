package repository

type PaymentRepositoryInterface interface {
	SavePayment(paymentType string, fromId string, toId string, amount int) error
}
