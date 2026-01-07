import 'package:nham_nham/data/repositories/restaurant_repository.dart';
import 'package:nham_nham/models/restaurant.dart';

class RestaurantService {
  RestaurantRepository restaurantRepository;

  RestaurantService({required this.restaurantRepository});

  Future<List<Restaurant>> getAllRestaurant() async {
    final List<Restaurant> restaurantList = await restaurantRepository
        .getAllRestaurant();
    if (restaurantList.isEmpty) {
      throw Exception("Restaurant is Empty");
    }
    return restaurantList;
  }

  Future<Restaurant> getRestaurantById(String id) async {
    final Restaurant restaurant = await restaurantRepository.getRestaurantById(
      id,
    );
    return restaurant;
  }
}
