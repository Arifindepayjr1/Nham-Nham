import "package:flutter/material.dart";
import "dart:async";
import "package:nham_nham/widgets/home_screen_widget/discount_card.widget.dart";

class RestaurantDiscountCard extends StatefulWidget {
  final List<DiscountCard> discountCardList;

  const RestaurantDiscountCard({super.key, required this.discountCardList});

  @override
  State<RestaurantDiscountCard> createState() {
    return _RestaurantDiscountCardState();
  }
}

class _RestaurantDiscountCardState extends State<RestaurantDiscountCard> {
  int _currentPage = 0;
  PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0, viewportFraction: 1);

    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      if (_currentPage < widget.discountCardList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 150,
        child: PageView.builder(
          onPageChanged: (index) {
            _currentPage = index;
          },
          itemCount: widget.discountCardList.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: widget.discountCardList[index],
            );
          },
        ),
      ),
    );
  }
}
