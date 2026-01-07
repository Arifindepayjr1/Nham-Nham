import "package:flutter_test/flutter_test.dart";
import "package:nham_nham/data/datasources/local/user_local.dart";

void main() {
  late UserLocalDatasources userLocalDatasources;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    userLocalDatasources = UserLocalDatasources();
    userLocalDatasources.loadUser();
  });

  test("Should Load User Successfully", () {
    final user = userLocalDatasources.userData;
    expect(user, isNotNull);
  });
}
