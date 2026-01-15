import 'package:flutter/material.dart';
import "package:nham_nham/data/datasources/local/order_local.dart";
import "package:nham_nham/data/datasources/local/user_local.dart";
import "package:nham_nham/data/repositories/order_repository.dart";
import "package:nham_nham/data/repositories/user_repository.dart";
import "package:nham_nham/models/user.dart";
import "package:nham_nham/screens/order_detail_screen.dart";
import "package:nham_nham/services/order.service.dart";
import "package:nham_nham/models/order.dart";
import "package:nham_nham/services/user.service.dart";
import "package:nham_nham/widgets/order_screen_widget/order_card.widget.dart";
import "package:nham_nham/models/food.dart";

class OrderScreen extends StatefulWidget {
  final VoidCallback? gotoHome;
  final VoidCallback? triggerOrder;
  final VoidCallback? onOrderPlaced;
  final Function(int)? setScreenIndex;

  OrderScreen({
    this.setScreenIndex,
    super.key,
    this.gotoHome,
    this.triggerOrder,
    this.onOrderPlaced,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> orderList = [];
  User? user;
  Food? food;
  final OrderService _orderService = OrderService(
    orderRepository: OrderRepository(
      orderLocalDatasources: OrderLocalDatasources(),
    ),
  );
  final UserService _userService = UserService(
    userRepository: UserRepository(
      userLocalDatasources: UserLocalDatasources(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  Future<void> _loadOrder() async {
    List<Order> data = await _orderService.getAllOrder();
    User userData = await _userService.getUserInfo();
    widget.triggerOrder?.call();
    setState(() {
      orderList = data;
      user = userData;
    });
  }

  void triggerOrder() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (orderList.isEmpty) {
      return Center(child: Text(
        "Order is Empty",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
        ),
        
      ));
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyActions: false,
        title: Text(
          "My Order",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return OrderDetail(order: orderList[index], user: user!);
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: OrderCard(
                  triggerOrder: triggerOrder,
                  orderInfo: orderList[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
