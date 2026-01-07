import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/food_local.dart";
import "package:nham_nham/data/repositories/food_repository.dart";
import "package:nham_nham/models/food.dart";
import "package:logger/logger.dart";
import "package:nham_nham/services/foods.service.dart";
import "package:nham_nham/widgets/restaurant_detail_screen_widget/food_card.widget.dart";
import "package:nham_nham/screens/food_detail_screen.dart";

var logger = Logger();

class RestaurantsFood extends StatefulWidget {
  final String restaurantsId;
  final VoidCallback clickOnCart;
  final VoidCallback triggerBack;
  const RestaurantsFood({
    required this.triggerBack,
    required this.clickOnCart,
    required this.restaurantsId,
    super.key,
  });

  @override
  State<RestaurantsFood> createState() {
    return _RestaurantsFoodState();
  }
}

class _RestaurantsFoodState extends State<RestaurantsFood> {
  List<Food> foodsList = [];

  @override
  void initState() {
    super.initState();
    _getFoodsBySpecificRestaurants(widget.restaurantsId);
  }

  @override
  Widget build(BuildContext context) {
    return foodsList.isEmpty
        ? Text("No foods found for restaurant: ${widget.restaurantsId}")
        : GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            padding: EdgeInsets.all(5),
            itemCount: foodsList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return FoodDetailScreen(
                          triggerBack: widget.triggerBack,
                          foodId: foodsList[index].id,
                          addToCart: widget.clickOnCart,
                        );
                      },
                    ),
                  );
                },
                child: FoodCard(
                  name: foodsList[index].name,
                  price: foodsList[index].price,
                  imageUrlPath: foodsList[index].imageUrl,
                ),
              );
            },
          );
  }

  Future<void> _getFoodsBySpecificRestaurants(String restaurantId) async {
    try {
      FoodLocalDatasources foodLocalDatasources = FoodLocalDatasources();
      FoodRepository foodRepository = FoodRepository(
        foodLocalDatasources: foodLocalDatasources,
      );
      FoodsService foodsService = FoodsService(foodRepository: foodRepository);
      List<Food> foodsData = await foodsService.getAllFoodsByRestaurantsId(
        restaurantId,
      );
      setState(() {
        foodsList = foodsData;
      });
    } catch (error) {
      logger.e(
        "Error When Trying to Fetch Foods By Specific Restaurants : $error",
      );
    }
  }
}
