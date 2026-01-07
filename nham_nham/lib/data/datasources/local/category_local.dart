import "package:flutter/services.dart";
import "package:logger/logger.dart";
import "package:nham_nham/models/category.dart";
import "dart:convert";

var logger = Logger();

class CategoryLocalDatasources {
  List<Category> categoryLocalData = [];

  Future<void> loadCategory() async {
    try {
      String data = await rootBundle.loadString(
        "lib/data/datasources/mocks/category.mock.json",
      );
      Map<String, dynamic> jsonMap = json.decode(data);  
      List jsonList = jsonMap['categories']; 
      categoryLocalData = jsonList.map((json) => Category.fromJson(json)).toList();
    } catch (error) {
      logger.e("Failed to Load Category From Json : $error");
    }
  }
}
