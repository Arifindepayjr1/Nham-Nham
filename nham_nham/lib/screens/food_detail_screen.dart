import "package:flutter/material.dart";
import "package:nham_nham/widgets/food_screen_widget/food_details_header.widget.dart";
import "package:nham_nham/widgets/food_screen_widget/food_addon.widget.dart";
import "package:nham_nham/widgets/food_screen_widget/food_detail_add_to_cart.widget.dart";

class FoodDetailScreen extends StatefulWidget {
  final String foodId;
  final VoidCallback addToCart;
  const FoodDetailScreen({
    super.key,
    required this.foodId,
    required this.addToCart,
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
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                    spreadRadius: 1,
                  ),
                ],
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () {
                  widget.addToCart();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, size: 24, color: Colors.black),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 100,
              ), // Space for bottom bar
              child: Column(
                children: [
                  FoodsDetailsHeader(foodId: widget.foodId),
                  Divider(
                    height: 50,
                    thickness: 2,
                    color: Colors.grey.shade400,
                  ),
                  FoodAddOn(foodId: widget.foodId),
                ],
              ),
            ),
            FoodDetailAddToCart(
              foodId: widget.foodId,
              clickToAddToCart: widget.addToCart,
            ),
          ],
        ),
      ),
    );
  }
}