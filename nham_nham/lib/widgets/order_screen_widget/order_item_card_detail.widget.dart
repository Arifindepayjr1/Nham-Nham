import "package:flutter/material.dart";
import "package:nham_nham/models/cart_item.dart";
import "package:nham_nham/models/food.dart";
import "package:nham_nham/models/order_item.dart";

class OrderItemCardDetail extends StatelessWidget {
  final OrderItem orderItem;
  final double currentItemPrice;
  final Food food;
  const OrderItemCardDetail({
    super.key,
    required this.orderItem,
    required this.currentItemPrice,
    required this.food,
  });

  String _joinItem(List<SelectedAddOn> selectedAddOnList) {
    List<String> selectedAddOnName = selectedAddOnList.map((e) {
      return e.name;
    }).toList();

    return selectedAddOnName.join(",");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              spacing: 14,
              children: [
                Text(
                  "${orderItem.quantity.toString()}x",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      orderItem.selectedAddOns.isEmpty
                          ? Container()
                          : Text(
                              _joinItem(orderItem.selectedAddOns),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$ ${currentItemPrice.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
