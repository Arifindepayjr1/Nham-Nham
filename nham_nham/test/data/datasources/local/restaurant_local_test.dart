import 'package:flutter_test/flutter_test.dart';
import 'package:nham_nham/data/datasources/local/restaurant_local.dart';

void main() {
  late RestaurantLocalDatasources restaurantLocalDatasources;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    restaurantLocalDatasources = RestaurantLocalDatasources();
    await restaurantLocalDatasources.loadRestaurants();
  });

  test("Should Load Restaurant Successfully", () {
    final restaurants = restaurantLocalDatasources.restaurantData;

    expect(restaurants, isNotNull);
    expect(restaurants.isNotEmpty, true);
  });
}
