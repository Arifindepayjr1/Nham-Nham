import "package:flutter/material.dart";
import "package:nham_nham/data/datasources/local/category_local.dart";
import "package:nham_nham/data/repositories/category_repository.dart";
import "package:nham_nham/models/category.dart";
import "package:nham_nham/services/categories.service.dart";
import "package:logger/logger.dart";
import "package:nham_nham/widgets/home_screen_widget/category_card.widget.dart";

enum CategoriesColor {
  pizza(Colors.red),
  burgers(Colors.blueGrey),
  khmer(Colors.blue),
  desserts(Colors.green),
  beverages(Colors.purple);

  final Color color;

  const CategoriesColor(this.color);
}

Logger logger = Logger();

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryList> {
  late List<Category> categoriesList = [];

  @override
  void initState() {
    super.initState();
    _getListOfCategory();
  }

  @override
  Widget build(BuildContext context) {
    return categoriesList.isEmpty
        ? Text("Categories is empty")
        : SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                List categoriesColor = CategoriesColor.values;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryCard(
                    color: categoriesColor[index].color,
                    categoryName: categoriesList[index].name,
                    iconUrl: categoriesList[index].iconUrl,
                  ),
                );
              },
            ),
          );
  }

  Future<void> _getListOfCategory() async {
    try {
      CategoryLocalDatasources categoryLocalDatasources =
          CategoryLocalDatasources();
      CategoryRepository categoryRepository = CategoryRepository(
        categoryLocalDatasources: categoryLocalDatasources,
      );
      CategoriesService categoriesService = CategoriesService(
        categoryRepository: categoryRepository,
      );
      List<Category> data = await categoriesService.loadCategory();
      setState(() {
        categoriesList = data;
      });
    } catch (error) {
      logger.e("Error Occur When Trying to Fetch Categories : $error");
    }
  }
}
