import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/food_local.dart";
import "package:nham_nham/data/repositories/food_repository.dart";
import "package:nham_nham/models/addon.dart";
import "package:logger/logger.dart";
import "package:nham_nham/services/foods.service.dart";
import "package:nham_nham/models/food.dart";
import "package:nham_nham/widgets/food_screen_widget/food_addon_card.widget.dart";

var logger = Logger();

class FoodAddOn extends StatefulWidget {
  final String foodId;
  final VoidCallback triggerSetState;
  final Map? existing;

  const FoodAddOn({required this.triggerSetState , super.key, required this.foodId, this.existing});

  @override
  State<FoodAddOn> createState() {
    return _FoodAddOnState();
  }
}

class _FoodAddOnState extends State<FoodAddOn> {
  List<AddOnGroup>? foodAddOnGroup;

  @override
  void initState() {
    super.initState();
    _getFoodAddOn(widget.foodId);
  }

   void _handleAddOnChange() {
    setState(() {});
    widget.triggerSetState();
  }

  Future<void> _getFoodAddOn(String foodId) async {
    try {
      FoodLocalDatasources foodLocalDatasources = FoodLocalDatasources();
      FoodRepository foodRepository = FoodRepository(
        foodLocalDatasources: foodLocalDatasources,
      );
      FoodsService foodsService = FoodsService(foodRepository: foodRepository);
      Food data = await foodsService.getSpecificFoodById(foodId);
      setState(() {
        foodAddOnGroup = data.addOnGroups;
      });
    } catch (error) {
      logger.e(
        "Error When Trying To Fetch Add On Group From Food Id : $foodId : $error",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (foodAddOnGroup == null) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: foodAddOnGroup?.length,
      itemBuilder: (context, index0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                foodAddOnGroup![index0].name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: foodAddOnGroup![index0].options.length,
              itemBuilder: (context, index) {
                return FoodAddonCard(
                  triggerSetState: _handleAddOnChange,
                  existing: widget.existing,
                  foodId: widget.foodId,
                  optionId: foodAddOnGroup![index0].options[index].id,
                  name: foodAddOnGroup![index0].options[index].name,
                  price: foodAddOnGroup![index0].options[index].price,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
