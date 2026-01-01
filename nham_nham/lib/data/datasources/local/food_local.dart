import 'package:flutter/services.dart';
import 'package:nham_nham/models/food.dart';
import "package:logger/logger.dart";
import "dart:convert";

var logger = Logger();

class FoodLocalDatasources {
  List<Food> foodData = [];

  Future<void> loadFoods() async {
    try {
      String data = await rootBundle.loadString(
        "lib/data/datasources/mocks/food.mock.json",
      );

      Map<String, dynamic> jsonMap = json.decode(data);  
      List jsonList = jsonMap['foods']; 
      foodData = jsonList.map((json) => Food.fromJson(json)).toList();
    } catch (error) {
      logger.e("Failed to load Food From Json : $error");
    }
  }
}