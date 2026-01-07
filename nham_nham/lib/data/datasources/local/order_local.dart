import "package:flutter/services.dart";
import "package:nham_nham/models/order.dart";
import 'package:logger/logger.dart';
import "dart:convert";

var logger = Logger();

class OrderLocalDatasources {
  List<Order> orderData = [];

  Future<void> loadOrder() async {
    try {
      String data = await rootBundle.loadString(
        "lib/data/datasources/mocks/order.mock.json",
      );

      Map<String, dynamic> jsonMap = json.decode(data);
      List jsonList = jsonMap['orders'];
      orderData = jsonList
          .map((json) => Order.fromJson(json))
          .toList();
    } catch (error) {
      logger.e("Failed To load Order From Json : $error");
    }
  }

  void addOrder(Order order) {
    orderData.add(order);
  }
}
