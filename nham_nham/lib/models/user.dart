import "package:nham_nham/models/location.dart";

class User {
  final String id;
  final String userName;
  final String email;
  final String password;
  final String phoneNumber;
  final Location location;

  const User({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.location,
  });
}
