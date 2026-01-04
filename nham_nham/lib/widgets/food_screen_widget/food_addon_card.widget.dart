import 'package:flutter/material.dart';
import 'package:nham_nham/data/datasources/local/user_local.dart';
import 'package:nham_nham/data/repositories/user_repository.dart';
import 'package:nham_nham/models/cart_item.dart';
import 'package:nham_nham/services/cart.service.dart';
import 'package:nham_nham/services/user.service.dart';

class FoodAddonCard extends StatefulWidget {
  final String foodId;
  final String optionId;
  final String name;
  final double price;

  const FoodAddonCard({
    required this.foodId,
    required this.optionId,
    required this.name,
    required this.price,
    super.key,
  });
  @override
  State<FoodAddonCard> createState() {
    return _FoodAddonCardState();
  }
}

class _FoodAddonCardState extends State<FoodAddonCard> {
  CartService? _cartService;

  @override
  void initState() {
    super.initState();
    UserLocalDatasources userLocalDatasources = UserLocalDatasources();
    UserRepository userRepository = UserRepository(
      userLocalDatasources: userLocalDatasources,
    );
    UserService userService = UserService(userRepository: userRepository);
    CartService cartService = CartService(userService: userService);
    _cartService = cartService;
  }

  bool _checkSelectAddOn(String optionId) {
    bool inTemp = _cartService!.userSelectedAddOn.any((item) {
      return item.optionId == optionId;
    });

    if (inTemp) return true;

    return false;
  }

  void _removeSelectAddOn(String optionId) {
    setState(() {
      bool inTemp = _cartService!.userSelectedAddOn.any((item) {
        return item.optionId == optionId;
      });

      if (inTemp) {
        _cartService!.removeSelectedAdd(optionId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              "+\$ ${widget.price.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.pink,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: _checkSelectAddOn(widget.optionId)
                    ? () {
                        _removeSelectAddOn(widget.optionId);
                      }
                    : () {
                        SelectedAddOn selectedAddOn = SelectedAddOn(
                          optionId: widget.optionId,
                          name: widget.name,
                          price: widget.price,
                        );
                        setState(() {
                          _cartService!.addSelectedAddOn(selectedAddOn);
                        });
                      },
                icon: _checkSelectAddOn(widget.optionId)
                    ? Icon(Icons.check, size: 16, color: Colors.red)
                    : Icon(Icons.add, size: 16, color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
