import 'package:flutter/material.dart';
import 'package:flutter_meals_app/data/categories_data.dart';
import 'package:flutter_meals_app/models/category.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/screens/meals_screen.dart';
import 'package:flutter_meals_app/widgets/categories/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.filteredMeals,
    required this.onToggleFavorite,
  });

  final List<Meal> filteredMeals;
  final void Function(Meal meal) onToggleFavorite;

  void _onCategoryTap(BuildContext context, Category category) {
    final meals = filteredMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return MealsScreen(
        title: category.title,
        meals: meals,
        onToggleFavorite: onToggleFavorite,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      children: dummyCategories.map((category) {
        return CategoryGridItem(
          category: category,
          onCategoryTap: () => _onCategoryTap(context, category),
        );
      }).toList(),
    );
  }
}
