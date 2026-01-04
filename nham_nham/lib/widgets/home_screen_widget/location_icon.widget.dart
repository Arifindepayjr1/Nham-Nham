import 'package:flutter/material.dart';


class LocationIcon extends StatelessWidget {
  const LocationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey, 
        ),
        child: Center(
          child: Image.asset(
            "assets/icons/location.png",
            width: 18,
            height: 18,
          ),
        ),
      ),
    );
  }
}
