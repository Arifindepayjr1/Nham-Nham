import "package:nham_nham/data/repositories/order_repository.dart";
import "package:nham_nham/models/order.dart";

class OrderService {
  final OrderRepository orderRepository;

  OrderService({required this.orderRepository});

  Future<List<Order>> getAllOrder() async {
    final List<Order> orderList = await orderRepository.loadOrder();
    if (orderList.isEmpty) {
      throw Exception("Order is Empty");
    }
    return orderList;
  }

  void addNewOrder(Order newOrder) async {
    await orderRepository.loadOrder();
    orderRepository.addOrder(newOrder);
  }
}
