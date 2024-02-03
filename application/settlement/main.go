package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"
	pb "settlement/proto/settlement"

	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

var (
	port = flag.Int("port", 50051, "The server port")
)

type server struct {
	pb.UnimplementedClearingServer
}

func (s *server) PostClearing(ctx context.Context, in *pb.PostClearingRequest) (*pb.PostClearingResponse, error) {
	return &pb.PostClearingResponse{Commission: 333}, nil
}

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", *port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	// gRPCサーバーの生成
	s := grpc.NewServer()
	// 自動生成された関数に、サーバと実際に処理を行うメソッドを実装したハンドラを設定
	pb.RegisterClearingServer(s, &server{})
	// gRPCサーバーにリフレクションサービスを登録
	reflection.Register(s)
	log.Printf("server listening at %v", lis.Addr())
	// サーバーを起動し、エラー発生時にはエラーメッセージを出力
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}

}
