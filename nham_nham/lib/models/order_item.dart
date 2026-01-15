import "package:nham_nham/models/cart_item.dart";

class OrderItem {
  final String foodId;
  final int quantity;
  final List<SelectedAddOn> selectedAddOns;

  OrderItem({
    required this.foodId,
    required this.quantity,
    required this.selectedAddOns,
  });

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'quantity': quantity,
      'selectedAddOns': selectedAddOns.map((addon) => addon.toJson()).toList(),
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      foodId: json['foodId'] as String,
      quantity: json['quantity'] as int,
      selectedAddOns: (json['selectedAddOns'] as List<dynamic>)
          .map((addon) => SelectedAddOn.fromJson(addon as Map<String, dynamic>))
          .toList(),
    );
  }
}
