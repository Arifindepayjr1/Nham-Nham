import "package:flutter/material.dart";
import "package:nham_nham/screens/order_screen.dart";
import "package:nham_nham/screens/cart_screen.dart";
import "package:nham_nham/screens/home_screen.dart";
import "package:nham_nham/screens/profile_screen.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return CartScreen(goToHomePage: _onTappedDefaultScreen,);
      case 2:
        return OrderScreen(gotoHome: _onTappedDefaultScreen,);
      case 3:
        return ProfileScreen();
    }
    return HomeScreen();
  }

  void _onTappedScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTappedDefaultScreen() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTappedScreen,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.home_outlined, size: 24, color: Colors.black),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.home, size: 24, color: Colors.black),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 24,
                color: Colors.black,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.shopping_cart, size: 24, color: Colors.black),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 24,
                color: Colors.black,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.receipt_long, size: 24, color: Colors.black),
            ),
            label: "Order",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.person_outline, size: 24, color: Colors.black),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.person, size: 24, color: Colors.black),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
