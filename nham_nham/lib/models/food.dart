import "package:nham_nham/models/addon.dart";
import "package:nham_nham/models/category.dart";

class Food {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String restaurantId;
  final Category category;
  final List<AddOnGroup> addOnGroups;

  const Food({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.restaurantId,
    required this.category,
    required this.addOnGroups,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'restaurantId': restaurantId,
      'category': category.toJson(),
      'addOnGroups': addOnGroups.map((group) => group.toJson()).toList(),
    };
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      restaurantId: json['restaurantId'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      addOnGroups: (json['addOnGroups'] as List<dynamic>)
          .map((group) => AddOnGroup.fromJson(group as Map<String, dynamic>))
          .toList(),
    );
  }
}
