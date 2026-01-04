import "package:flutter/material.dart";

class DiscountCard extends StatelessWidget {
  final String cardImagePath;
  const DiscountCard({super.key , required this.cardImagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 250,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Transform.scale(
          scaleX: 1.75,
          scaleY: 1.8,
          child: Image.asset(cardImagePath),
        ),
      ),
    );
  }
}
