import "package:flutter/services.dart";
import "package:nham_nham/models/delivery_person.dart";
import "package:logger/logger.dart";
import "dart:convert";

var logger = Logger();

class DeliveryLocalDatasources {
  List<DeliveryPerson> deliveryPersonData = [];

  Future<void> loadDeliveryPerson() async {
    try {
      String data = await rootBundle.loadString(
        "lib/data/datasources/mocks/delivery_person.mock.json",
      );
      Map<String, dynamic> jsonMap = json.decode(data); 
      List jsonList = jsonMap['deliveryPersons'];      
      deliveryPersonData = jsonList
          .map((json) => DeliveryPerson.fromJson(json))
          .toList();
    } catch (error) {
      logger.e("Failed to load DeliveryPerson from Json : $error");
    }
  }
}