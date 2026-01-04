import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/food_local.dart";
import "package:nham_nham/data/repositories/food_repository.dart";
import "package:nham_nham/models/food.dart";
import "package:nham_nham/services/foods.service.dart";

class FoodsDetailsHeader extends StatelessWidget {
  final String foodId;
  const FoodsDetailsHeader({super.key, required this.foodId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFoodDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text("Failed to Load Foods Details");
        }

        final food = snapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.asset(food!.imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                food.name,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Text(
                '\$${food.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.pink,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Text(
                food.description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<Food> _getFoodDetails() async {
    FoodLocalDatasources foodLocalDatasources = FoodLocalDatasources();
    FoodRepository foodRepository = FoodRepository(
      foodLocalDatasources: foodLocalDatasources,
    );
    FoodsService foodsService = FoodsService(foodRepository: foodRepository);
    return await foodsService.getSpecificFoodById(foodId);
  }
}
