class SelectedAddOn {
  final String optionId;
  final String name;
  final double price;

  const SelectedAddOn({
    required this.optionId,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'optionId': optionId,
      'name': name,
      'price': price,
    };
  }

  factory SelectedAddOn.fromJson(Map<String, dynamic> json) {
    return SelectedAddOn(
      optionId: json['optionId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }
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

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'price': price,
      'quantity': quantity,
      'selectedAddOns': selectedAddOns.map((addon) => addon.toJson()).toList(),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      foodId: json['foodId'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      selectedAddOns: (json['selectedAddOns'] as List<dynamic>)
          .map((addon) => SelectedAddOn.fromJson(addon as Map<String, dynamic>))
          .toList(),
    );
  }
}
