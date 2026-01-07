import 'package:flutter/material.dart';
import 'package:nham_nham/widgets/previous_page_icon.widget.dart';

class OrderScreen extends StatelessWidget {
  final VoidCallback? gotoHome;
  const OrderScreen({super.key , this.gotoHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PreviousPageIcon(goToHomePage: gotoHome,),
        title: Text(
          "Order",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
