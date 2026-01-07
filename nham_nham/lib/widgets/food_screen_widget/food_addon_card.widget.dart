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
  final VoidCallback triggerSetState;
  Map? existing;

  FoodAddonCard({
    required this.triggerSetState,
    required this.foodId,
    required this.optionId,
    required this.name,
    required this.price,
    this.existing,
    super.key,
  });
  
  @override
  State<FoodAddonCard> createState() {
    return _FoodAddonCardState();
  }
}

class _FoodAddonCardState extends State<FoodAddonCard> {
  late final CartService _cartService;

  bool get isEditingExisting =>
      widget.existing != null && widget.existing!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    UserLocalDatasources userLocalDatasources = UserLocalDatasources();
    UserRepository userRepository = UserRepository(
      userLocalDatasources: userLocalDatasources,
    );
    UserService userService = UserService(userRepository: userRepository);
    _cartService = CartService(userService: userService);
  }

  void _toggleAddOn() {
    final isCurrentlySelected = _checkSelectAddOn(widget.optionId);
    
    if (isCurrentlySelected) {
      _removeSelectAddOn(widget.optionId);
    } else {
      _addSelectAddOn();
    }
  }

  void _addSelectAddOn() {
    SelectedAddOn selectedAddOn = SelectedAddOn(
      optionId: widget.optionId,
      name: widget.name,
      price: widget.price,
    );

    if (isEditingExisting) {

      final index = widget.existing!["index"];
      _cartService.addAddOnToCartItem(index, selectedAddOn);
    } else {
      _cartService.addSelectedAddOn(selectedAddOn);
    }


    setState(() {});
    widget.triggerSetState();
  }

  bool _checkSelectAddOn(String optionId) {
    if (isEditingExisting) {
      return _cartService.checkCurrentAddOnCartItem(
        widget.existing!["index"],
        optionId,
      );
    }

    return _cartService.userSelectedAddOn.any(
      (item) => item.optionId == optionId,
    );
  }

  void _removeSelectAddOn(String optionId) {
    if (isEditingExisting) {
      _cartService.removeCurrentAddOnCartItem(
        widget.existing!["index"],
        optionId,
      );
    } else {
      _cartService.removeSelectedAdd(optionId);
    }
    
    setState(() {});
    widget.triggerSetState();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = _checkSelectAddOn(widget.optionId);
    
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
                onPressed: _toggleAddOn,
                icon: isSelected
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