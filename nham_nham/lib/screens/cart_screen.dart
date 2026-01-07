import 'package:flutter/material.dart';
import 'package:nham_nham/data/datasources/local/user_local.dart';
import 'package:nham_nham/data/repositories/user_repository.dart';
import 'package:nham_nham/models/cart.dart';
import 'package:nham_nham/services/cart.service.dart';
import 'package:nham_nham/services/user.service.dart';
import 'package:nham_nham/widgets/previous_page_icon.widget.dart';
import 'package:nham_nham/widgets/cart_screen_widget/map.widget.dart';
import 'package:nham_nham/widgets/cart_screen_widget/delivery_cart.widget_timer.dart';
import 'package:nham_nham/widgets/cart_screen_widget/cart_display.widget.dart';
import 'package:nham_nham/widgets/cart_screen_widget/place_order_card.widget.dart';
import 'package:nham_nham/widgets/cart_screen_widget/payment_selection.widget.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback? goToHomePage;

  CartScreen({this.goToHomePage, super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService(
    userService: UserService(
      userRepository: UserRepository(
        userLocalDatasources: UserLocalDatasources(),
      ),
    ),
  );

  void _updateCart() {
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          leading: PreviousPageIcon(goToHomePage: widget.goToHomePage),
        ),
        body: _cartService.userCartItem.isEmpty
            ? Center(child: Text("Cart is Empty" , style: TextStyle(
              color: Colors.black87, 
            )),)
            : Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        MapDisplay(),
                        SizedBox(height: 4),
                        DeliveryCartTimer(),
                        SizedBox(height: 4),
                        CartDisplay(onChangedCard: _updateCart),
                        SizedBox(height: 10),
                        PaymentSelection(cartService: _cartService),
                      ],
                    ),
                  ),
                  PlaceOrderCard(
                    totalPrice: _cartService.currentTotalPrice(),
                    
                  ),
                ],
              ),
      ),
    );
  }
}
