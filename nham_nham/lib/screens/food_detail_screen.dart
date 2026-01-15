import "package:flutter/material.dart";
import "package:nham_nham/widgets/food_screen_widget/food_details_header.widget.dart";
import "package:nham_nham/widgets/food_screen_widget/food_addon.widget.dart";
import "package:nham_nham/widgets/food_screen_widget/food_detail_add_to_cart.widget.dart";
import "package:nham_nham/widgets/previous_page_icon.widget.dart";

class FoodDetailScreen extends StatefulWidget {
  final String foodId;
  final VoidCallback addToCart;
  final VoidCallback? triggerBack;
  Map? existing;

  FoodDetailScreen({
    super.key,
    this.triggerBack,
    required this.foodId,
    required this.addToCart,
    this.existing,
  });

  @override
  State<FoodDetailScreen> createState() {
    return _FoodDetailsScreenState();
  }
}

class _FoodDetailsScreenState extends State<FoodDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Customize",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          leading: PreviousPageIcon(triggerBack: widget.triggerBack , triggerSetState: widget.addToCart,),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 200,
              ), 
              child: Column(
                children: [
                  FoodsDetailsHeader(foodId: widget.foodId),
                  Divider(
                    height: 50,
                    thickness: 2,
                    color: Colors.grey.shade400,
                  ),
                  FoodAddOn(triggerSetState: widget.addToCart, existing: widget.existing, foodId: widget.foodId),
                ],
              ),
            ),
            FoodDetailAddToCart(
              existing: widget.existing,
              foodId: widget.foodId,
              clickToAddToCart: widget.addToCart
            ),
          ],
        ),
      ),
    );
  }
}
