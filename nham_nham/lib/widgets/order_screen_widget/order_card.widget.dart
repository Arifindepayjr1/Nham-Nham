import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/food_local.dart";
import "package:nham_nham/data/datasources/local/restaurant_local.dart";
import "package:nham_nham/data/repositories/food_repository.dart";
import "package:nham_nham/data/repositories/restaurant_repository.dart";
import "package:nham_nham/models/order.dart";
import "package:nham_nham/models/order_item.dart";
import "package:nham_nham/models/restaurant.dart";
import "package:nham_nham/services/restaurant.service.dart";
import "package:nham_nham/services/foods.service.dart";


class OrderCard extends StatefulWidget {
  final Order orderInfo;
  final VoidCallback? triggerOrder;

  const OrderCard({super.key, required this.orderInfo, this.triggerOrder});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Restaurant? _restaurant;
  RestaurantService? _restaurantService;
  late FoodsService _foodsService;
  late Future<String> _itemsNameAndQuantity;

  @override
  void initState() {
    super.initState();
    _loadService();
  }

  Future<void> _loadService() async {
    RestaurantService restaurantService = RestaurantService(
      restaurantRepository: RestaurantRepository(
        restaurantLocalDatasources: RestaurantLocalDatasources(),
      ),
    );

    Restaurant data = await restaurantService.getRestaurantById(
      widget.orderInfo.restaurantId,
    );

    FoodsService foodsService = FoodsService(
      foodRepository: FoodRepository(
        foodLocalDatasources: FoodLocalDatasources(),
      ),
    );

    _foodsService = foodsService;

    Future<String> itemsData = _joinItems(widget.orderInfo.items);

    setState(() {
      _restaurantService = restaurantService;
      _restaurant = data;
      _itemsNameAndQuantity = itemsData;
      widget.triggerOrder?.call();
    });
  }

  Future<String> _joinItems(List<OrderItem> items) async {
    List<String> itemsName = [];

    for (int i = 0; i < items.length; i++) {
      String name = await _foodsService.getSpecificFoodNameById(
        items[i].foodId,
      );
      itemsName.add(name);
    }

    List<String> foodQuantity = [];

    for (int i = 0; i < items.length; i++) {
      int quantity = items[i].quantity;
      foodQuantity.add(quantity.toString());
    }

    String resultJoinItem = "";

    for (int i = 0; i < items.length; i++) {
      resultJoinItem =
          resultJoinItem + "${foodQuantity[i]} x ${itemsName[i]} ,";
    }

    return resultJoinItem;
  }

  String _formatDate(DateTime date) {
    String amPm = date.hour < 12 ? 'AM' : 'PM';
    return "${date.day}/${date.month}/${date.year} : ${date.hour}:${date.minute} $amPm";
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (_restaurant == null || _restaurantService == null) {
      return Center(
        child: SizedBox(
          child: Text(
            "Order Is Empty",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    }

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: Image.asset(
                    _restaurant!.iconUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _restaurant!.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        FutureBuilder(
                          future: _itemsNameAndQuantity,
                          builder: (_, asyncSnapshot) {
                            if (asyncSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            }
                            if (asyncSnapshot.hasError) {
                              return Text(
                                "Failed to load items",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              );
                            }
                            if (asyncSnapshot.hasData) {
                              return Text(
                                asyncSnapshot.data!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              );
                            }
                            return SizedBox();
                          },
                        ),
                        SizedBox(height: 4),

                        Text(
                          _formatDate(widget.orderInfo.createdAt),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Colors.pink),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Rate",
                        style: TextStyle(
                          color: Colors.pink[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[600],
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Colors.pink),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Re-Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
