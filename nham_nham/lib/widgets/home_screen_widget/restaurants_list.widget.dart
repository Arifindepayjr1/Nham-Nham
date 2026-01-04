import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/restaurant_local.dart";
import "package:nham_nham/data/repositories/restaurant_repository.dart";
import "package:nham_nham/models/restaurant.dart";
import "package:nham_nham/widgets/home_screen_widget/restaurants_card.widget.dart";
import "package:nham_nham/services/restaurant.service.dart";
import "package:nham_nham/screens/restaurant_detail_screen.dart";
import "package:logger/logger.dart";

var logger = Logger();

class RestaurantsList extends StatefulWidget {
  @override
  State<RestaurantsList> createState() {
    return _RestaurantsListState();
  }
}

class _RestaurantsListState extends State<RestaurantsList> {
  late List<Restaurant> restaurantList = [];
  @override
  void initState() {
    super.initState();
    _getListOfRestaurants();
  }

  Future<void> _getListOfRestaurants() async {
    try {
      RestaurantLocalDatasources restaurantLocalDatasources =
          RestaurantLocalDatasources();
      RestaurantRepository restaurantRepository = RestaurantRepository(
        restaurantLocalDatasources: restaurantLocalDatasources,
      );
      RestaurantService restaurantService = RestaurantService(
        restaurantRepository: restaurantRepository,
      );
      restaurantList = await restaurantService.getAllRestaurant();
    } catch (error) {
      logger.e("Error Occur When Trying to Fetch Restaurants : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return restaurantList.isEmpty
        ? Text("Restaurant Is Empty")
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: restaurantList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsGeometry.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return RestaurantDetailScreen(
                            id: restaurantList[index].id,
                          );
                        },
                      ),
                    );
                  },
                  child: RestaurantsCard(
                    name: restaurantList[index].name,
                    category: restaurantList[index].categorys,
                    rating: restaurantList[index].rating,
                  ),
                ),
              );
            },
          );
  }
}
