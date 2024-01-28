package main

import (
	"go-grpc/order"
	orderserver "go-grpc/order_server"
	"log"
	"net"

	"google.golang.org/grpc"
)

func main() {

	listner, err := net.Listen("tcp", ":8011")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	svcRegistrar := grpc.NewServer()
	orderServer := &orderserver.MyOrderServer{}
	order.RegisterOrderServer(svcRegistrar, orderServer)

	if err := svcRegistrar.Serve(listner); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}

}
