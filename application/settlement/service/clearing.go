package service

import (
	"fmt"
	pi "merpay/settlement/service/port/repository"
)

type ClearingService struct {
	pr pi.PaymentRepositoryInterface
}

func NewClearingService(pr pi.PaymentRepositoryInterface) *ClearingService {
	return &ClearingService{
		pr: pr,
	}
}

func (c *ClearingService) CalcCommission() (int, error) {
	return 1, nil
}

func (c *ClearingService) SavePayment(paymentType string, fromId string, toId string, amount int) error {
	err := c.pr.SavePayment(paymentType, fromId, toId, amount)
	if err != nil {
		return fmt.Errorf("failed to save payment: %w", err)
	}
	return nil
}
