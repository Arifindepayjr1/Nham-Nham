import 'package:flutter_test/flutter_test.dart';
import 'package:nham_nham/data/datasources/local/food_local.dart';

void main() {
  late FoodLocalDatasources foodLocalDatasources;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    foodLocalDatasources = FoodLocalDatasources();
    await foodLocalDatasources.loadFoods();
  });

  test("should load food successfully", () {
    final foods = foodLocalDatasources.foodData;

    expect(foods, isNotNull);
    expect(foods.isNotEmpty, true);
  });
}
