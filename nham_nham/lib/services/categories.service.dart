import "package:nham_nham/data/repositories/category_repository.dart";
import "package:nham_nham/models/category.dart";

class CategoriesService {
  final CategoryRepository categoryRepository;

  const CategoriesService({required this.categoryRepository});

  Future<List<Category>> loadCategory() async {
    List<Category> categories = await categoryRepository.loadCategory();
    if (categories.isEmpty) {
      throw Exception("Categories is Empty");
    }
    return categories;
  }
}