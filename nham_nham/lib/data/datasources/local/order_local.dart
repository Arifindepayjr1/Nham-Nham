import "package:flutter/services.dart";
import "package:nham_nham/models/order.dart";
import 'package:logger/logger.dart';
import "dart:convert";
import 'dart:io';
import 'package:path_provider/path_provider.dart';

var logger = Logger();

class OrderLocalDatasources {
  List<Order> orderData = [];
  final String fileName = 'order.mock.json';
  final String assetPath = "lib/data/datasources/mocks/order.mock.json";


  Future<void> loadOrder() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');


      if (await file.exists()) {
        logger.i("Loading orders from local storage: ${file.path}");
        String data = await file.readAsString();
        Map<String, dynamic> jsonMap = json.decode(data);
        List jsonList = jsonMap['orders'];
        orderData = jsonList.map((json) => Order.fromJson(json)).toList();
        logger.i("Loaded ${orderData.length} orders from local storage");
        return;
      }


      logger.i("No local file found, loading from assets");
      String data = await rootBundle.loadString(assetPath);
      Map<String, dynamic> jsonMap = json.decode(data);
      List jsonList = jsonMap['orders'];
      orderData = jsonList.map((json) => Order.fromJson(json)).toList();
      

      await saveOrders();
      logger.i("Loaded ${orderData.length} orders from assets and saved to local storage");
      
    } catch (error) {
      logger.e("Failed to load orders: $error");
      orderData = []; 
    }
  }


  Future<void> saveOrders() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');

      Map<String, dynamic> jsonMap = {
        'orders': orderData.map((order) => order.toJson()).toList(),
      };

      String jsonString = JsonEncoder.withIndent('  ').convert(jsonMap);
      await file.writeAsString(jsonString);

      logger.i("${orderData.length} orders saved to: ${file.path}");
    } catch (error) {
      logger.e("Failed to save orders: $error");
      throw Exception('Failed to save orders');
    }
  }


  Future<void> addOrder(Order order) async {
    orderData.add(order);
    await saveOrders();
    logger.i("Order ${order.id} added successfully");
  }

}
