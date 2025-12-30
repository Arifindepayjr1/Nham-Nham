import "package:nham_nham/models/cart_item.dart";

class OrderItem {
  final String foodId;
  final double price;
  final int quantity;
  final List<SelectedAddOn> selectedAddOns;

  OrderItem({
    required this.foodId,
    required this.price,
    required this.quantity,
    required this.selectedAddOns,
  });
}
