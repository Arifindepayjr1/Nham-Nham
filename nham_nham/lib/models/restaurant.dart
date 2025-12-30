import 'package:flutter/foundation.dart';
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
}
