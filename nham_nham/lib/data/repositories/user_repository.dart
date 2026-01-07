import "package:nham_nham/models/user.dart";
import "package:nham_nham/data/datasources/local/user_local.dart";
import "package:nham_nham/models/location.dart";

class UserRepository {
  final UserLocalDatasources _localDatasources;
  User? _userData;

  UserRepository({required UserLocalDatasources userLocalDatasources})
    : _localDatasources = userLocalDatasources;

  Future<User> getUserInfo() async {
    await _localDatasources.loadUser();
    _userData = _localDatasources.userData;
    return _localDatasources.userData;
  }

  Future<Location> getUserLocation() async {
    if (_userData == null) {
      await _localDatasources.loadUser();
      _userData = _localDatasources.userData;
    }
    
    if (_userData?.location == null) {
      throw Exception("User Location is null");
    }

    return _userData!.location;
  }
}
