import "package:nham_nham/models/restaurant.dart";
import "package:nham_nham/data/datasources/local/restaurant_local.dart";

class RestaurantRepository {
  final RestaurantLocalDatasources _localDatasources;

  RestaurantRepository({
    required RestaurantLocalDatasources restaurantLocalDatasources,
  }) : _localDatasources = restaurantLocalDatasources;

  Future<List<Restaurant>> getAllRestaurant() async {
    await _localDatasources.loadRestaurants();
    return _localDatasources.restaurantData;
  }

  Future<Restaurant> getRestaurantById(String id) async {
    await _localDatasources.loadRestaurants();
    return _localDatasources.restaurantData.firstWhere(
      (res) => res.id == id,
      orElse: () => throw Exception('Restaurant with id $id not found'),
    );
  }
}
