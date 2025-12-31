import 'package:nham_nham/models/location.dart';
import 'package:nham_nham/models/order_item.dart';

enum OrderStatus { pending, confirmed, preparing, onTheWay, delivered }
enum PaymentMethod { cash, creditCard }

class Order {
  final String id;
  final String userId;
  final String restaurantId;
  final List<OrderItem> items;
  final double totalAmount;

  OrderStatus status;

  final Location pickupLocation;
  final Location dropOffLocation;
  final String? deliveryPersonId;
  final DateTime createdAt;

  final PaymentMethod paymentMethod;

  Order({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.deliveryPersonId,
    required this.createdAt,
    required this.paymentMethod
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status.name,
      'pickupLocation': pickupLocation.toJson(),
      'dropOffLocation': dropOffLocation.toJson(),
      'deliveryPersonId': deliveryPersonId,
      'createdAt': createdAt.toIso8601String(),
      'paymentMethod': paymentMethod.name,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      userId: json['userId'] as String,
      restaurantId: json['restaurantId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      pickupLocation: Location.fromJson(json['pickupLocation'] as Map<String, dynamic>),
      dropOffLocation: Location.fromJson(json['dropOffLocation'] as Map<String, dynamic>),
      deliveryPersonId: json['deliveryPersonId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == json['paymentMethod'],
      ),
    );
  }
}
