import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/food_local.dart";
import "package:nham_nham/data/datasources/local/order_local.dart";
import "package:nham_nham/data/datasources/local/restaurant_local.dart";
import "package:nham_nham/data/datasources/local/user_local.dart";
import "package:nham_nham/data/repositories/food_repository.dart";
import "package:nham_nham/data/repositories/order_repository.dart";
import "package:nham_nham/data/repositories/restaurant_repository.dart";
import "package:nham_nham/data/repositories/user_repository.dart";
import "package:nham_nham/models/cart.dart";
import "package:nham_nham/services/cart.service.dart";
import "package:nham_nham/services/foods.service.dart";
import "package:nham_nham/services/order.service.dart";
import "package:nham_nham/services/restaurant.service.dart";
import "package:nham_nham/services/user.service.dart";
import "package:nham_nham/models/user.dart";

class PlaceOrderCard extends StatefulWidget {
  final double totalPrice;
  final Cart cart;
  final VoidCallback? onOrderPlaced;

  const PlaceOrderCard({
    required this.totalPrice,
    required this.cart,
    this.onOrderPlaced,
    super.key,
  });

  @override
  State<PlaceOrderCard> createState() => _PlaceOrderCardState();
}

class _PlaceOrderCardState extends State<PlaceOrderCard> {
  final OrderService _orderService = OrderService(
    orderRepository: OrderRepository(
      orderLocalDatasources: OrderLocalDatasources(),
    ),
  );
  final FoodsService _foodsService = FoodsService(
    foodRepository: FoodRepository(
      foodLocalDatasources: FoodLocalDatasources(),
    ),
  );
  final CartService _cartService = CartService(
    userService: UserService(
      userRepository: UserRepository(
        userLocalDatasources: UserLocalDatasources(),
      ),
    ),
  );
  final RestaurantService _restaurantService = RestaurantService(
    restaurantRepository: RestaurantRepository(
      restaurantLocalDatasources: RestaurantLocalDatasources(),
    ),
  );

  Future<void> _addOrders() async {
    User user = await _cartService.userService.getUserInfo();
    _orderService.addOrderList(
      widget.cart,
      _foodsService,
      user,
      _cartService.paymentMethod,
      _restaurantService,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void triggerOrder() {
    setState(() {});
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
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Price",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "\$${widget.totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.pink.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade600,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await _addOrders();

                    _cartService.userCartItem.clear();

                    Navigator.of(context).popUntil((route) => route.isFirst);
                    widget.onOrderPlaced?.call();
                  },
                  child: const Text(
                    "Place Order",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
