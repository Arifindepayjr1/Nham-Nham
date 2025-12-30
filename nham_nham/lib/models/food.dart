import "package:flutter/foundation.dart";
import "package:nham_nham/models/addon.dart";

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
    required this.addOnGroups
  });
}
