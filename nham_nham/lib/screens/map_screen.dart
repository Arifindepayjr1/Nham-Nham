import "package:flutter/material.dart";
import "package:nham_nham/widgets/previous_page_icon.widget.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  final double longitude;
  final double latitude;
  const MapScreen({super.key, required this.latitude, required this.longitude});

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  double? longitude;
  double? latitude;

  LatLng? _center;

  @override
  void initState() {
    super.initState();
    setState(() {
      longitude = widget.longitude;
      latitude = widget.latitude;
      _center = LatLng(latitude!, longitude!);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    if (_center == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(leading: PreviousPageIcon()),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center!, zoom: 11.0),
      ),
    );
  }
}
