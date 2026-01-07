import 'package:flutter/material.dart';
import 'package:nham_nham/services/cart.service.dart';

class PaymentSelection extends StatefulWidget {
  final CartService cartService;

  const PaymentSelection({super.key, required this.cartService});

  @override
  State<PaymentSelection> createState() => _PaymentSelectionState();
}

class _PaymentSelectionState extends State<PaymentSelection> {
  PaymentMethod selected = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0), 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Payment Method : ",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 10),

          SegmentedButton<PaymentMethod>(
            segments: const [
              ButtonSegment(value: PaymentMethod.cash, label: Text('Cash')),
              ButtonSegment(
                value: PaymentMethod.creditCard,
                label: Text('Credit Card'),
              ),
            ],
            selected: {selected},
            onSelectionChanged: (Set<PaymentMethod> newSelection) {
              setState(() {
                selected = newSelection.first;
                widget.cartService.paymentMethod = newSelection.first;
              });
            },
          ),
        ],
      ),
    );
  }
}
