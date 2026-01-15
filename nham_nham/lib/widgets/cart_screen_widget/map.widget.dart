import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nham_nham/data/datasources/local/user_local.dart';
import 'package:nham_nham/data/repositories/user_repository.dart';
import 'package:nham_nham/models/user.dart';
import 'package:nham_nham/screens/map_screen.dart';
import 'package:nham_nham/services/user.service.dart';

class MapDisplay extends StatefulWidget {
  const MapDisplay({super.key});

  @override
  State<MapDisplay> createState() {
    return _MapDisplayState();
  }
}

class _MapDisplayState extends State<MapDisplay> {
  User? user;
  LatLng? _center;
  double? latitude;
  double? longitude;

  final UserService _userService = UserService(
    userRepository: UserRepository(
      userLocalDatasources: UserLocalDatasources(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    User data = await _userService.getUserInfo();
    latitude = data.location.latitude;
    longitude = data.location.longitude;
    setState(() {
      user = data;
      _center = LatLng(latitude!, longitude!);
    });
  }

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return MapScreen(
                longitude: longitude!,
                latitude: latitude!,
              );
            },
          ),
        );
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 4),
              spreadRadius: 2,
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center!, zoom: 11.0),
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
        ),
      ),
    );
  }
}
