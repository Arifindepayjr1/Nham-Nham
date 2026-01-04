import "package:flutter/material.dart";
import "package:nham_nham/widgets/home_screen_widget/user_location.widget.dart";
import "package:nham_nham/widgets/home_screen_widget/location_icon.widget.dart";

class UserLocationPicker extends StatelessWidget {
  const UserLocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              LocationIcon(),
              UserLocation(),
            ],
          ),
          Icon(Icons.arrow_right_sharp),
        ],
      ),
    );
  }
}
