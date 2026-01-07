import "package:nham_nham/data/repositories/food_repository.dart";
import "package:nham_nham/models/food.dart";

class FoodsService {
  final FoodRepository foodRepository;

  const FoodsService({required this.foodRepository});

  Future<List<Food>> getAllFoods() async {
    List<Food> foodsList = await foodRepository.getAllFoods();
    if (foodsList.isEmpty) {
      throw Exception("Foods is Empty");
    }
    return foodsList;
  }

  Future<List<Food>> getAllFoodsByRestaurantsId(String restaurantsId) async {
    List<Food> filterFoodsList = await foodRepository.getFoodsByRestaurants(
      restaurantsId,
    );
    return filterFoodsList;
  }

  Future<Food> getSpecificFoodById(String foodId) async {
    Food food = await foodRepository.getSpecificFoodById(foodId);
    return food;
  }
}