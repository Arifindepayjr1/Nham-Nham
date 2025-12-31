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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'currentLocation': currentLocation.toJson(),
    };
  }

  factory DeliveryPerson.fromJson(Map<String, dynamic> json) {
    return DeliveryPerson(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      currentLocation: Location.fromJson(json['currentLocation'] as Map<String, dynamic>),
    );
  }
}
