import 'package:flutter/material.dart';
import 'package:nham_nham/data/datasources/local/food_local.dart';
import 'package:nham_nham/data/datasources/local/user_local.dart';
import 'package:nham_nham/data/repositories/food_repository.dart';
import 'package:nham_nham/data/repositories/user_repository.dart';
import 'package:nham_nham/models/food.dart';
import 'package:nham_nham/services/cart.service.dart';
import 'package:nham_nham/services/foods.service.dart';
import 'package:nham_nham/services/user.service.dart';

import 'package:logger/logger.dart';

var logger = Logger();

class FoodDetailAddToCart extends StatefulWidget {
  final String foodId;
  final VoidCallback clickToAddToCart;
  Map? existing;
  FoodDetailAddToCart({
    this.existing,
    required this.foodId,
    super.key,
    required this.clickToAddToCart,
  });

  @override
  State<FoodDetailAddToCart> createState() {
    return _FoodDetailAddToCartState();
  }
}

class _FoodDetailAddToCartState extends State<FoodDetailAddToCart> {
  bool get isEditingExisting =>
      widget.existing != null && widget.existing!.isNotEmpty;

  int quantity = 1;
  Food? food;
  CartService? _cartService;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });

    if (isEditingExisting) {
      final index = widget.existing!["index"];
      _cartService!.userCartItem[index].quantity = quantity;
      widget.clickToAddToCart();
    }
  }

  void _decrementQuantity() {
    if (!isEditingExisting) {
      setState(() {
        if (quantity > 1) quantity--;
      });
      return;
    }

    final index = widget.existing!["index"];

    if (quantity <= 1) {
      _cartService!.removeCartItemQuantityOne(index);
      widget.clickToAddToCart();
      Navigator.of(context).pop();
    } else {
      setState(() {
        quantity--;
        _cartService!.userCartItem[index].quantity = quantity;
      });

      widget.clickToAddToCart();
    }
  }

  @override
  void initState() {
    super.initState();
    _getFoodDetail(widget.foodId);
    _initCartService();

    if (isEditingExisting) {
      final index = widget.existing!["index"];
      quantity = _cartService!.userCartItem[index].quantity;
    }
  }

  @override
  void dispose() {
    if (!isEditingExisting) {
      _cartService!.clearSelectedAddOn();
    }
    super.dispose();
  }

  void _initCartService() {
    UserLocalDatasources userLocalDatasources = UserLocalDatasources();
    UserRepository userRepository = UserRepository(
      userLocalDatasources: userLocalDatasources,
    );
    UserService userService = UserService(userRepository: userRepository);
    CartService cartService = CartService(userService: userService);
    _cartService = cartService;

    _cartService!.clearSelectedAddOn();
  }

  void _addToCart(int quantity, Food food) {
    _cartService!.addToCart(food, quantity);
    widget.clickToAddToCart();
  }

  Future<void> _getFoodDetail(String foodId) async {
    try {
      FoodLocalDatasources foodLocalDatasources = FoodLocalDatasources();
      FoodRepository foodRepository = FoodRepository(
        foodLocalDatasources: foodLocalDatasources,
      );
      FoodsService foodsService = FoodsService(foodRepository: foodRepository);
      Food data = await foodsService.getSpecificFoodById(foodId);
      setState(() {
        food = data;
      });
    } catch (error) {
      logger.e("Error When Trying To Get Food Id : $foodId  : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _decrementQuantity,
                    icon: const Icon(Icons.remove, size: 20),
                    color: Colors.black87,
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: _incrementQuantity,
                    icon: const Icon(Icons.add, size: 20),
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _addToCart(quantity, food!);
                  });
                  widget.clickToAddToCart();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
