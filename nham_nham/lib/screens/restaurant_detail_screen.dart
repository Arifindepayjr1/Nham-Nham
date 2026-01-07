import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/restaurant_local.dart";
import "package:nham_nham/data/datasources/local/user_local.dart";
import "package:nham_nham/data/repositories/restaurant_repository.dart";
import "package:nham_nham/data/repositories/user_repository.dart";
import "package:nham_nham/models/restaurant.dart";
import "package:nham_nham/services/restaurant.service.dart";
import "package:nham_nham/widgets/restaurant_detail_screen_widget/restaurant_details_header.widget.dart";
import "package:nham_nham/widgets/search_bar.widget.dart";
import "package:nham_nham/widgets/restaurant_detail_screen_widget/delivery_card.widget.dart";
import "package:nham_nham/widgets/restaurant_detail_screen_widget/restaurants_food.widget.dart";
import "package:nham_nham/services/cart.service.dart";
import "package:nham_nham/services/user.service.dart";
import "package:nham_nham/widgets/restaurant_detail_screen_widget/restaurant_detail_add_to_cart_display.widget.dart";
import "package:logger/logger.dart";

var logger = Logger();

class RestaurantDetailScreen extends StatefulWidget {
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  Restaurant? restaurantDetails;
  CartService? _userCartService;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _getRestaurantById(widget.id);
    _getCartService();
  }

  void getCartService() {
    setState(() {
      _getCartService();
    });
  }

  void _triggerBack() {
    setState(() {
      _userCartService!.currentTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: _userCartService == null ? 0 : 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                restaurantDetails == null
                    ? Text(" This Restaurant ${widget.id} is Not Found")
                    : RestaurantDetailsHeader(
                        iconImgPath: restaurantDetails!.iconUrl,
                        coverImgPath: restaurantDetails!.coverUrl,
                        name: restaurantDetails!.name,
                        description: restaurantDetails!.description,
                        rating: restaurantDetails!.rating,
                      ),
                DeliveryCard(),
                Search(hintText: "Search menu"),
                SizedBox(height: 12),
                RestaurantsFood(
                  restaurantsId: widget.id,
                  clickOnCart: getCartService,
                  triggerBack: _triggerBack,
                ),
              ],
            ),
          ),
          _userCartService == null
              ? Container()
              : _userCartService!.currentCartQuantity() > 0
              ? AddToCardDisplay(
                  quantity: _userCartService!.currentCartQuantity(),
                  totalPrice: _userCartService!.currentTotalPrice(),
                  triggerBack: _triggerBack,
                )
              : Container(),
        ],
      ),
    );
  }

  Future<void> _getRestaurantById(String id) async {
    try {
      RestaurantLocalDatasources restaurantLocalDatasources =
          RestaurantLocalDatasources();
      RestaurantRepository restaurantRepository = RestaurantRepository(
        restaurantLocalDatasources: restaurantLocalDatasources,
      );
      RestaurantService restaurantService = RestaurantService(
        restaurantRepository: restaurantRepository,
      );
      final Restaurant restaurantDetailsData = await restaurantService
          .getRestaurantById(id);
      setState(() {
        restaurantDetails = restaurantDetailsData;
      });
    } catch (error) {
      logger.e("Error Occur When Trying to Find Restaurant By $id : $error");
    }
  }

  void _getCartService() {
    UserLocalDatasources userLocalDatasources = UserLocalDatasources();
    UserRepository userRepository = UserRepository(
      userLocalDatasources: userLocalDatasources,
    );
    UserService userService = UserService(userRepository: userRepository);
    CartService cartService = CartService(userService: userService);
    setState(() {
      _userCartService = cartService;
    });
  }
}
