import 'package:nham_nham/models/cart_item.dart';
import 'package:nham_nham/models/food.dart';
import 'package:nham_nham/services/user.service.dart';
import 'package:logger/logger.dart';

var logger = Logger();

enum PaymentMethod { cash, creditCard }

class CartService {
  final UserService userService;
  final List<CartItem> _userCartItem = [];
  final List<SelectedAddOn> _selectedAddOn = [];
  PaymentMethod paymentMethod = PaymentMethod.cash;

  CartService._internal({required this.userService});

  static CartService? _instance;

  factory CartService({required UserService userService}) {
    _instance ??= CartService._internal(userService: userService);
    return _instance!;
  }

  List<CartItem> get userCartItem => _userCartItem;
  List<SelectedAddOn> get userSelectedAddOn => _selectedAddOn;

  void clearSelectedAddOn() {
    _selectedAddOn.clear();
  }

  void addToCart(Food food, int quantity) {
    List<SelectedAddOn> temp = List.from(_selectedAddOn);

    _userCartItem.add(
      CartItem(
        foodId: food.id,
        price: food.price,
        quantity: quantity,
        selectedAddOns: temp,
      ),
    );

    _selectedAddOn.clear();
  }

  void removeSelectedAdd(String optionId) {
    _selectedAddOn.removeWhere((item) => item.optionId == optionId);
  }

  void removeCartItemQuantityOne(int index) {
    _userCartItem.removeAt(index);
  }

  void addSelectedAddOn(SelectedAddOn selectAddOn) {
    _selectedAddOn.add(
      SelectedAddOn(
        optionId: selectAddOn.optionId,
        name: selectAddOn.name,
        price: selectAddOn.price,
      ),
    );
  }

  double currentTotalPriceForEachCart({required CartItem cartItem}) {
    double total = cartItem.price * cartItem.quantity;
    for (int i = 0; i < cartItem.selectedAddOns.length; i++) {
      total = total + cartItem.selectedAddOns[i].price;
    }
    return total;
  }

  double currentTotalPrice() {
    double total = 0.0;

    for (var cartItem in _userCartItem) {
      // Sum up all add-on prices
      double addOnsTotal = 0.0;
      for (var addon in cartItem.selectedAddOns) {
        addOnsTotal += addon.price;
      }

      // Calculate item total: (base + addons) * quantity
      double itemTotal = (cartItem.price + addOnsTotal) * cartItem.quantity;
      total += itemTotal;
    }
    logger.i(total);

    return total;
  }

  int currentCartQuantity() {
    int totalQuantity = 0;
    for (var cartItem in _userCartItem) {
      totalQuantity = totalQuantity + cartItem.quantity;
    }
    return totalQuantity;
  }

  bool checkCurrentAddOnCartItem(int index, String optionId) {
    if (index >= 0 && index < _userCartItem.length) {
      CartItem cartItem = _userCartItem[index];
      return cartItem.selectedAddOns.any((item) {
        return optionId == item.optionId;
      });
    }
    return false;
  }

  void removeCurrentAddOnCartItem(int index, String optionId) {
    if (index >= 0 && index < _userCartItem.length) {
      CartItem cartItem = _userCartItem[index];
      cartItem.selectedAddOns.removeWhere((item) => item.optionId == optionId);
    }
  }

  void addAddOnToCartItem(int index, SelectedAddOn selectedAddOn) {
    if (index >= 0 && index < _userCartItem.length) {
      bool alreadyExists = _userCartItem[index].selectedAddOns.any(
        (item) => item.optionId == selectedAddOn.optionId,
      );

      if (!alreadyExists) {
        _userCartItem[index].selectedAddOns.add(
          SelectedAddOn(
            optionId: selectedAddOn.optionId,
            name: selectedAddOn.name,
            price: selectedAddOn.price,
          ),
        );
      }
    }
  }
}
