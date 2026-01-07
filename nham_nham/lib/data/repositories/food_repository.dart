import "package:nham_nham/data/datasources/local/food_local.dart";
import "package:nham_nham/models/food.dart";

class FoodRepository {
  final FoodLocalDatasources _localDatasources;

  FoodRepository({required FoodLocalDatasources foodLocalDatasources})
    : _localDatasources = foodLocalDatasources;

  Future<List<Food>> getAllFoods() async {
    await _localDatasources.loadFoods();
    return _localDatasources.foodData;
  }

  Future<List<Food>> getFoodsByRestaurants(String restaurantId) async {
    await _localDatasources.loadFoods();
    List<Food> foodsList = _localDatasources.foodData;
    List<Food> filterFood = foodsList.where((food) {
      return food.restaurantId == restaurantId;
    }).toList();
    if (filterFood.isEmpty) {
      throw Exception("No foods found for restaurant: $restaurantId");
    }
    return filterFood;
  }

  Future<Food> getSpecificFoodById(String foodId) async {
    await _localDatasources.loadFoods();
    Food food = _localDatasources.foodData.firstWhere((food) {
      return food.id == foodId;
    }, orElse: () => throw Exception("food id $foodId is not found"));

    return food;
  }
}
