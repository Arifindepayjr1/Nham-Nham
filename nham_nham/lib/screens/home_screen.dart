import "package:flutter/material.dart";
import "package:nham_nham/widgets/home_screen_widget/drop_down_language.widget.dart";
import "package:nham_nham/widgets/search_bar.widget.dart";
import "package:nham_nham/widgets/home_screen_widget/notification_icon.widget.dart";
import "package:nham_nham/widgets/home_screen_widget/user_location_picker.widget.dart";
import "package:nham_nham/widgets/home_screen_widget/discount_card.widget.dart";
import "package:nham_nham/widgets/home_screen_widget/restaurant_discount_card.widget.dart";
import "package:nham_nham/widgets/home_screen_widget/categories.widget.dart";
import "package:nham_nham/widgets/home_screen_widget/restaurants.widget.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [DropDownLanguage(), NotificationIcon()],
          title: Text(
            "Nham Nham",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              UserLocationPicker(),
              Search(hintText: "Search Anything...",),
              RestaurantDiscountCard(
                discountCardList: [
                  DiscountCard(
                    cardImagePath: "assets/discount_card/discount_card_1.png",
                  ),
                  DiscountCard(
                    cardImagePath: "assets/discount_card/discount_card_2.png",
                  ),
                  DiscountCard(
                    cardImagePath: "assets/discount_card/discount_card_3.png",
                  ),
                ],
              ),
              Categories(),
              Restaurants(),
            ],
          ),
        ),
      ),
    );
  }
}
