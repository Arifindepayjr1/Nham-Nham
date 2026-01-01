import 'package:flutter_test/flutter_test.dart';
import 'package:nham_nham/data/datasources/local/delivery_local.dart';


void main() {
  late DeliveryLocalDatasources deliveryLocalDatasources;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    deliveryLocalDatasources = DeliveryLocalDatasources();
    await deliveryLocalDatasources.loadDeliveryPerson();
  });


  test("should load Delivery Person successfully", () {
    final deliveryPerson = deliveryLocalDatasources.deliveryPersonData;

    expect(deliveryPerson, isNotNull);
    expect(deliveryPerson.isNotEmpty, true);
  });
}
