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
}