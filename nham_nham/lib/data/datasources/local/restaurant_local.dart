import "package:flutter/services.dart";
import "package:nham_nham/models/restaurant.dart";
import 'package:logger/logger.dart';
import "dart:convert";

var logger = Logger();

class RestaurantLocalDatasources {
  List<Restaurant> restaurantData = [];

  Future<void> loadRestaurants() async {
    try {
      String data = await rootBundle.loadString(
        "lib/data/datasources/mocks/restaurant.mock.json",
      );
      
      Map<String, dynamic> jsonMap = json.decode(data); 
      List jsonList = jsonMap['restaurants'];    
      restaurantData = jsonList
          .map((json) => Restaurant.fromJson(json))
          .toList();
    } catch (error) {
      logger.e("Failed To load Restaurant From Json : $error");
    }
  }
}