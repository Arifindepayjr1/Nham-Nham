import "package:flutter/services.dart";
import "package:nham_nham/models/user.dart";
import "package:logger/logger.dart";
import "dart:convert";

var logger = Logger();

class UserLocalDatasources{
  late final User userData;

  Future<void> loadUser() async {
    try {
      String data = await rootBundle.loadString(
        "lib/data/datasources/mocks/user.mock.json",
      );
      Map<String, dynamic> jsonMap = json.decode(data);
      userData = User.fromJson(jsonMap["user"] as Map<String ,dynamic>);
    } catch (error) {
      logger.e("Failed To load User From Json : $error");
    }
  }
}
