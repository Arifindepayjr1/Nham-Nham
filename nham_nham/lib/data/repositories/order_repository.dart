import "package:nham_nham/data/datasources/local/order_local.dart";
import "package:nham_nham/models/order.dart";

class OrderRepository {
  final OrderLocalDatasources _localDatasources;

  OrderRepository({
    required OrderLocalDatasources orderLocalDatasources,
  }) : _localDatasources = orderLocalDatasources;

  Future<List<Order>> loadOrder() async {
    await _localDatasources.loadOrder();
    return _localDatasources.orderData;
  }

  void addOrder(Order order) {
    _localDatasources.addOrder(order);
  }
}
