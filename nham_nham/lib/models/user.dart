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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'location': location.toJson(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );
  }
}
