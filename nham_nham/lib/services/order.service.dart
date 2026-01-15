import "package:nham_nham/data/repositories/order_repository.dart";
import "package:nham_nham/models/location.dart";
import "package:nham_nham/models/order.dart";
import "package:nham_nham/models/cart.dart";
import "package:nham_nham/models/order_item.dart";
import "package:nham_nham/models/restaurant.dart";
import "package:nham_nham/services/foods.service.dart";
import "package:nham_nham/models/food.dart";
import "package:nham_nham/models/cart_item.dart";
import "package:nham_nham/models/user.dart";
import "package:logger/logger.dart";
import "package:nham_nham/services/restaurant.service.dart";
import 'package:uuid/uuid.dart';

var uuid = Uuid();
var logger = Logger();

class OrderService {
  final OrderRepository orderRepository;

  OrderService({required this.orderRepository});

  Future<List<Order>> getAllOrder() async {
    final List<Order> orderList = await orderRepository.loadOrder();
    if (orderList.isEmpty) {
      throw Exception("Order is Empty");
    }
    return orderList;
  }

  Future<void> _addNewOrder(Order newOrder) async {
    await orderRepository.addOrder(newOrder);
  }

  Future<double> currentTotalPriceForEachOrderItem({
    required OrderItem orderItem,
    required FoodsService foodService,
  }) async {
    Food food = await foodService.getSpecificFoodById(orderItem.foodId);
    double total = food.price * orderItem.quantity;

    for (var addon in orderItem.selectedAddOns) {
      total += addon.price * orderItem.quantity;
    }

    return total;
  }

  Future<double> computeTotalFromCartItems(
    List<CartItem> items,
    FoodsService foodService,
  ) async {
    double total = 0.0;

    for (var item in items) {
      Food food = await foodService.getSpecificFoodById(item.foodId);
      double itemTotal = food.price * item.quantity;

      for (var addon in item.selectedAddOns) {
        itemTotal += addon.price * item.quantity;
      }

      total += itemTotal;
    }

    return total;
  }

  Future<void> addOrderList(
    Cart cart,
    FoodsService foodService,
    User userInfo,
    PaymentMethod paymentMethod,
    RestaurantService restaurantService,
  ) async {
    List<String> restauntsId = [];
    final List<CartItem> cartItems = List<CartItem>.from(cart.items);

    for (var item in cartItems) {
      Food food = await foodService.getSpecificFoodById(item.foodId);
      if (restauntsId.isEmpty) {
        restauntsId.add(food.restaurantId);
        continue;
      }

      bool isExist = restauntsId.any((id) => id == food.restaurantId);

      if (!isExist) {
        restauntsId.add(food.restaurantId);
      }
    }

    for (int i = 0; i < restauntsId.length; i++) {
      List<CartItem> filteredItems = [];

      for (var ele in cartItems) {
        Food food = await foodService.getSpecificFoodById(ele.foodId);
        if (food.restaurantId == restauntsId[i]) {
          filteredItems.add(ele);
        }
      }

      Restaurant restaurant = await restaurantService.getRestaurantById(
        restauntsId[i],
      );

      double totalAmount = await computeTotalFromCartItems(
        filteredItems,
        foodService,
      );

      Order order = Order(
        id: uuid.v4(),
        userId: userInfo.id,
        restaurantId: restauntsId[i],
        items: [
          ...filteredItems.map((ele) {
            return OrderItem(
              foodId: ele.foodId,
              quantity: ele.quantity,
              selectedAddOns: ele.selectedAddOns,
            );
          }),
        ],
        totalAmount: totalAmount,
        status: OrderStatus.delivered,
        pickupLocation: Location(
          latitude: restaurant.location.latitude,
          longitude: restaurant.location.longitude,
        ),
        dropOffLocation: Location(
          latitude: userInfo.location.latitude,
          longitude: userInfo.location.longitude,
        ),
        deliveryPersonId: "driver_002",
        createdAt: DateTime.now(),
        paymentMethod: paymentMethod,
      );

      logger.i(order);

      await _addNewOrder(order);
    }
  }
}
