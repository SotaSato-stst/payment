package main

import (
	c "merpay/settlement/adapter/http"
	rp "merpay/settlement/adapter/repository"
	pb "merpay/settlement/proto/settlement"
	cs "merpay/settlement/service"

	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func RegistService(s *grpc.Server) {
	db, _ := rp.NewDB()
	pr := rp.NewPaymentRepository(db)
	pb.RegisterClearingServer(s, c.NewServer(cs.NewClearingService(pr)))
	reflection.Register(s)

}
