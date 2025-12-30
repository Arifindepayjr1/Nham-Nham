import "package:nham_nham/models/cart_item.dart";

class Cart {
  final String userId;
  final List<CartItem> items;

  const Cart({
    required this.userId,
    required this.items,
  });
}
