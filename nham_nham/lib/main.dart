import "package:flutter/material.dart";
import "package:nham_nham/screens/main_screen.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          surface: Colors.white,
          onSurface: Colors.black,
          error: Colors.red,
          onError: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 6, 64, 43),
          secondary: Color.fromARGB(255, 46, 111, 64),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
      home: MainScreen(),
    );
  }
}
