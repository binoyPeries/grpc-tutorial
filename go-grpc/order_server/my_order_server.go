package orderserver

import (
	"context"
	"go-grpc/order"
)

type MyOrderServer struct {
	order.UnimplementedOrderServer
}

func (s *MyOrderServer) CreateOrder(ctx context.Context, orderRequest *order.CreateOrderRequest) (*order.CreateOrderResponse, error) {
	return &order.CreateOrderResponse{
		Id:           1,
		OrderDetails: orderRequest.OrderDetails,
	}, nil
}
