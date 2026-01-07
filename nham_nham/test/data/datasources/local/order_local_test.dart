import 'package:flutter_test/flutter_test.dart';
import 'package:nham_nham/data/datasources/local/order_local.dart';

void main() {
  late OrderLocalDatasources orderLocalDatasources;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    orderLocalDatasources = OrderLocalDatasources();
    await orderLocalDatasources.loadOrder();
  });

  test("Should Load Restaurant Successfully", () {
    final orders = orderLocalDatasources.orderData;

    expect(orders, isNotNull);
    expect(orders.isNotEmpty, true);
  });
}
