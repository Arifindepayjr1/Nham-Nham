class SelectedAddOn {
  final String optionId;
  final String name;
  final double price;

  const SelectedAddOn({
    required this.optionId,
    required this.name,
    required this.price,
  });
}

class CartItem {
  final String foodId;
  final double price;
  final int quantity;
  final List<SelectedAddOn> selectedAddOns;

  const CartItem({
    required this.foodId,
    required this.price,
    required this.quantity,
    required this.selectedAddOns,
  });
}
