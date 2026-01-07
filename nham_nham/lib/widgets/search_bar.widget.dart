import "package:flutter/material.dart";

class Search extends StatelessWidget {
  final String hintText;
  const Search({required this.hintText , super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 8.0 , left: 8.0 , right: 8.0 , bottom: 5.0),
      child: TextField(
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: EdgeInsetsGeometry.all(15.0),
            child: Icon(Icons.search , size: 32),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
