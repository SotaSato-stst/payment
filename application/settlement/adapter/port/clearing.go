package port

type ClearingService interface {
	CalcCommission() (int, error)
}
