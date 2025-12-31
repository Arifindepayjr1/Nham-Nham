import "package:nham_nham/models/cart_item.dart";

class Cart {
  final String userId;
  final List<CartItem> items;

  const Cart({
    required this.userId,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
