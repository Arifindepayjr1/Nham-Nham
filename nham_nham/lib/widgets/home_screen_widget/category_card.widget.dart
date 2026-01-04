import "package:flutter/material.dart";

class CategoryCard extends StatelessWidget {
  final Color color;
  final String categoryName;
  final String iconUrl;

  const CategoryCard({
    required this.color,
    required this.categoryName,
    required this.iconUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconUrl,
              scale: 10,
              width: 140,
              height: 50,
            ),
            Padding(padding: EdgeInsets.all(16), child: Text(categoryName , style: TextStyle(fontSize: 16 , color: Colors.white))),
          ],
        ),
    );
  }
}
