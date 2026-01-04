import "package:flutter/material.dart";
import "package:geocoding/geocoding.dart" as geo;
import "package:logger/logger.dart";
import "package:nham_nham/services/user.service.dart";
import "package:nham_nham/data/repositories/user_repository.dart";
import "package:nham_nham/models/location.dart";
import "package:nham_nham/data/datasources/local/user_local.dart";

var logger = Logger();

class UserLocation extends StatefulWidget {
  const UserLocation({super.key});

  @override
  State<UserLocation> createState() {
    return _UserLocationState();
  }
}

class _UserLocationState extends State<UserLocation> {
  late double longitude;
  late double latitude;
  String locality = "";
  String subLocality = "";
  String postalCode = "";
  String address = "Fetching address ... ";

  @override
  void initState() {
    super.initState();
    _getAddressFromLatitudeLongtitude();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locality, style: TextStyle(fontSize: 10 , color: Colors.black)),
        Text("$subLocality , $postalCode" ,style: TextStyle(fontSize: 14 , color: Colors.black))
      ],
    );
  }

  Future<void> _getAddressFromLatitudeLongtitude() async {
    try {
      UserLocalDatasources userLocalDatasources = UserLocalDatasources();
      UserRepository userRepository = UserRepository(
        userLocalDatasources: userLocalDatasources,
      );
      UserService userService = UserService(userRepository: userRepository);
      Location userLocation = await userService.getUserLocation();

      longitude = userLocation.longitude;
      latitude = userLocation.latitude;

      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        geo.Placemark place = placemarks[0];
        setState(() {
          postalCode = (place.postalCode == null || place.postalCode!.isEmpty)
              ? "N/A"
              : place.postalCode!;

          locality = (place.locality == null || place.postalCode!.isEmpty)
              ? "Unknown Locality"
              : place.locality!;

          subLocality =
              (place.subLocality == null || place.subLocality!.isEmpty)
              ? "N/A"
              : place.subLocality!;

          address =
          "${place.street} , $subLocality , $locality , $postalCode , ${place.country}";
        });
      }
    } catch (error) {
      logger.e("Error Occur When Trying to Fetch Address : $error");
      setState(() {
        address = "Unknown Location";
        postalCode = "N/A";
        locality = "Unknown Location";
        subLocality = "N/A";
      });
    }
  }
}
