import 'package:flutter/material.dart';
import 'package:flutter_meals_app/data/categories_data.dart';
import 'package:flutter_meals_app/models/category.dart';
import 'package:flutter_meals_app/providers/meals_provider.dart';
import 'package:flutter_meals_app/screens/meals_screen.dart';
import 'package:flutter_meals_app/widgets/categories/category_grid_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    void onCategoryTap(Category category) {
      final meals = ref.read(categoryMealsProvider(category.id));

      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return MealsScreen(
          title: category.title,
          meals: meals,
        );
      }));
    }

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
          onCategoryTap: () => onCategoryTap(category),
        );
      }).toList(),
    );
  }
}
