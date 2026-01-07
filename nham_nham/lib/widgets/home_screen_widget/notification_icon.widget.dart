import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

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
          child: SvgPicture.asset(
            "assets/feature/red_notification_icon.svg",
            width: 18,
            height: 18,
          ),
        ),
      ),
    );
  }
}
