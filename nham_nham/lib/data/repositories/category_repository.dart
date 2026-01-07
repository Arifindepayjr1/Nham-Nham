import "package:nham_nham/data/datasources/local/category_local.dart";
import "package:nham_nham/models/category.dart";

class CategoryRepository {
  final CategoryLocalDatasources _localDatasources;

  CategoryRepository({
    required CategoryLocalDatasources categoryLocalDatasources,
  }) : _localDatasources = categoryLocalDatasources;

  Future<List<Category>> loadCategory() async {
    await _localDatasources.loadCategory();
    return _localDatasources.categoryLocalData;
  }
}
