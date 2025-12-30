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
}
