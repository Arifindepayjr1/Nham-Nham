import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/user_local.dart";
import "package:nham_nham/data/repositories/user_repository.dart";
import "package:nham_nham/screens/food_detail_screen.dart";
import "package:nham_nham/services/cart.service.dart";
import "package:nham_nham/services/user.service.dart";
import "package:nham_nham/widgets/cart_screen_widget/cart_display_card.widget.dart";

class CartDisplay extends StatefulWidget {
  final VoidCallback onChangedCard;
  const CartDisplay({required this.onChangedCard, super.key});

  @override
  State<CartDisplay> createState() {
    return _CartDisplayState();
  }
}

class _CartDisplayState extends State<CartDisplay> {
  CartService? _cartService;

  @override
  void initState() {
    super.initState();
    _initCartService();
  }

  void triggerSetState() {
    widget.onChangedCard();
  }

  void _decreaseQuantity(int index) {
    if (_cartService!.userCartItem[index].quantity == 1) {
      _cartService!.removeCartItemQuantityOne(index);
    } else {
      _cartService!.userCartItem[index].quantity--;
    }
    setState(() {});
    widget.onChangedCard();
  }

  void _increaseQuantity(int index) {
    _cartService!.userCartItem[index].quantity++;
    setState(() {});
    widget.onChangedCard();
  }

  @override
  Widget build(BuildContext context) {
    return _cartService == null
        ? Text("Cart Is Empty")
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    spreadRadius: 2,
                  ),
                ],
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cart",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _cartService!.userCartItem.length,
                    itemBuilder: (context, index) {
                      final currentTotal = _cartService!.currentTotalPriceForEachCart(
                        cartItem: _cartService!.userCartItem[index],
                      );
                      return GestureDetector(
                        onTap: () async {

                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return FoodDetailScreen(
                                  existing: {"index": index, "exist": true},
                                  foodId:
                                      _cartService!.userCartItem[index].foodId,
                                  addToCart: triggerSetState,
                                );
                              },
                            ),
                          );
                          setState(() {});
                          widget.onChangedCard();
                        },
                        child: CartDisplayCard(
                          increaseQuantity: () => {_increaseQuantity(index)},
                          decreaseQuantity: () => {_decreaseQuantity(index)},
                          foodId: _cartService!.userCartItem[index].foodId,
                          selectedAddOn:
                              _cartService!.userCartItem[index].selectedAddOns,
                          quantity: _cartService!.userCartItem[index].quantity,
                          totalPrice: currentTotal,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> _initCartService() async {
    UserLocalDatasources userLocalDatasources = UserLocalDatasources();
    UserRepository userRepository = UserRepository(
      userLocalDatasources: userLocalDatasources,
    );
    UserService userService = UserService(userRepository: userRepository);
    CartService data = CartService(userService: userService);

    setState(() {
      _cartService = data;
    });
  }
}
