import "package:nham_nham/models/location.dart";

class DeliveryPerson {
  final String id;
  final String name;
  final String phoneNumber;
  final Location currentLocation;

  const DeliveryPerson({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.currentLocation,
  });
}
