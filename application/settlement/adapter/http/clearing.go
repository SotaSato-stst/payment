package http

import (
	"context"
	port "merpay/settlement/adapter/port"
	pb "merpay/settlement/proto/settlement"
)

type Server struct {
	pb.UnimplementedClearingServer
	cs port.ClearingService
}

func NewServer(cs port.ClearingService) *Server {
	return &Server{
		cs: cs,
	}
}
func (s *Server) PostClearing(ctx context.Context, in *pb.PostClearingRequest) (*pb.PostClearingResponse, error) {
	amount, _ := s.cs.CalcCommission()
	return &pb.PostClearingResponse{Commission: &pb.Commission{Amount: int32(amount)}}, nil
}
