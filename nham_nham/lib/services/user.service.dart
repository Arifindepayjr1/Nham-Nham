import "package:nham_nham/data/repositories/user_repository.dart";
import "package:nham_nham/models/location.dart";
import "package:nham_nham/models/user.dart";

class UserService {
  UserRepository userRepository;

  UserService({required this.userRepository});

  Future<User> getUserInfo() async {
    final User user = await userRepository.getUserInfo();
    return user;
  }

  Future<Location> getUserLocation() async {
    final Location userLocation = await userRepository.getUserLocation();
    if (userLocation.latitude == 0 && userLocation.longitude == 0) {
      throw Exception("Invalid User Location");
    }
    return userLocation;
  }
}
