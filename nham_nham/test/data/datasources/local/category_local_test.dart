import 'package:flutter_test/flutter_test.dart';
import 'package:nham_nham/data/datasources/local/category_local.dart';

void main() {
  late CategoryLocalDatasources categoryLocalDatasources;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    categoryLocalDatasources = CategoryLocalDatasources();
    await categoryLocalDatasources.loadCategory();
  });

  test("should load Categories successfully", () {
    final foods = categoryLocalDatasources.categoryLocalData;

    expect(foods, isNotNull);
    expect(foods.isNotEmpty, true);
  });
}
