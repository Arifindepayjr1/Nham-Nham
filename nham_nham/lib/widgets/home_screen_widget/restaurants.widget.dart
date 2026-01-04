import "package:flutter/material.dart";
import "package:nham_nham/widgets/home_screen_widget/restaurants_list.widget.dart";

class Restaurants extends StatelessWidget {
  const Restaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Restaurants",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Icon(Icons.arrow_right_sharp),
            ],
          ),
          RestaurantsList(),
        ],
      ),
    );
  }
}
