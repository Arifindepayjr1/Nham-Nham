import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/food_local.dart";
import "package:nham_nham/data/datasources/local/order_local.dart";
import "package:nham_nham/data/datasources/local/restaurant_local.dart";
import "package:nham_nham/data/repositories/food_repository.dart";
import "package:nham_nham/data/repositories/order_repository.dart";
import "package:nham_nham/data/repositories/restaurant_repository.dart";
import "package:nham_nham/models/order.dart";
import "package:nham_nham/models/restaurant.dart";
import "package:nham_nham/services/foods.service.dart";
import "package:nham_nham/services/order.service.dart";
import "package:nham_nham/services/restaurant.service.dart";
import "package:nham_nham/widgets/order_screen_widget/order_total_amount.widget.dart";
import "package:nham_nham/widgets/previous_page_icon.widget.dart";
import "package:nham_nham/models/user.dart";
import "package:nham_nham/widgets/order_screen_widget/order_item_card_detail.widget.dart";

class OrderDetail extends StatefulWidget {
  final Order order;
  final User user;

  const OrderDetail({super.key, required this.order, required this.user});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Restaurant? restaurant;

  final RestaurantService _restaurantService = RestaurantService(
    restaurantRepository: RestaurantRepository(
      restaurantLocalDatasources: RestaurantLocalDatasources(),
    ),
  );
  final OrderService _orderService = OrderService(
    orderRepository: OrderRepository(
      orderLocalDatasources: OrderLocalDatasources(),
    ),
  );

  final FoodsService _foodService = FoodsService(
    foodRepository: FoodRepository(
      foodLocalDatasources: FoodLocalDatasources(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    Restaurant data = await _restaurantService.getRestaurantById(
      widget.order.restaurantId,
    );

    setState(() {
      restaurant = data;
    });
  }

  String _formatDate(DateTime date) {
    String amPm = date.hour < 12 ? 'AM' : 'PM';

    return "${date.day}/${date.month}/${date.year} : ${date.hour}:${date.minute} $amPm";
  }

  Future<List<dynamic>> _getFoodDetailsAndCurrentPrice(int itemIndex) async {
    final result = await Future.wait([
      _orderService.currentTotalPriceForEachOrderItem(
        orderItem: widget.order.items[itemIndex],
        foodService: _foodService,
      ),
      _foodService.getSpecificFoodById(widget.order.items[itemIndex].foodId),
    ]);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(leading: PreviousPageIcon()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            restaurant == null
                ? SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Image.asset(restaurant!.coverUrl, fit: BoxFit.cover),
                  ),
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.all(3.0),
                            child: Text(
                              "Order #${widget.order.id}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.all(3.0),
                            child: Text(
                              "Delivered on ${_formatDate(widget.order.createdAt)}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.pink[500],
                              size: 24,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order from",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    "${restaurant!.name} ( ${restaurant!.location.address!} )",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.pink[500],
                              size: 24,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivered to",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    widget.user.location.address!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.order.items.length,
              itemBuilder: (_, index) {
                return FutureBuilder(
                  future: _getFoodDetailsAndCurrentPrice(index),
                  builder: (_, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (asyncSnapshot.hasError) {
                      return Center(
                        child: Text(
                          "Fail To Compute Current Price Item",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      );
                    }

                    return OrderItemCardDetail(
                      orderItem: widget.order.items[index],
                      currentItemPrice: asyncSnapshot.data![0],
                      food: asyncSnapshot.data![1],
                    );
                  },
                );
              },
            ),
            OrderTotalAmount(totalAmount: widget.order.totalAmount , paymentMethod: widget.order.paymentMethod, ),
          ],
        ),
      ),
    );
  }
}
