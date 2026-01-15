import "package:flutter/material.dart";
import "package:nham_nham/models/order.dart";

class OrderTotalAmount extends StatelessWidget {
  final double totalAmount;
  final PaymentMethod paymentMethod;
  OrderTotalAmount({
    super.key,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.grey[800],
            thickness: 1,
            indent: 1,
            endIndent: 1,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              Text(
                "\$ ${totalAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[800],
            thickness: 1,
            indent: 1,
            endIndent: 1,
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Paid With",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 20,
                  children: [
                    paymentMethod.name == PaymentMethod.cash.name
                        ? Icon(Icons.monetization_on_outlined, size: 24)
                        : Icon(Icons.credit_card_outlined, size: 24),

                    paymentMethod.name == PaymentMethod.cash.name
                        ? Text(
                            "Offline Payment",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          )
                        : Text(
                            "Online payment",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                  ],
                ),
                Text(
                  "\$ ${totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontSize: 14,
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
