import 'package:nham_nham/models/category.dart';
import 'package:nham_nham/models/location.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final Location location;
  final List<Category> categorys;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.categorys,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location.toJson(),
      'categorys': categorys.map((cat) => cat.toJson()).toList(),
      'rating': rating,
    };
  }


  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      categorys: (json['categorys'] as List<dynamic>)
        .map((catJson) => Category.fromJson(catJson as Map<String, dynamic>))
        .toList(),
      rating: (json['rating'] as num).toDouble(),
    );
  }

}
