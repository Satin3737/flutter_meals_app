import 'package:flutter/material.dart';
import 'package:flutter_meals_app/data/categories_data.dart';
import 'package:flutter_meals_app/models/category.dart';
import 'package:flutter_meals_app/providers/meals_provider.dart';
import 'package:flutter_meals_app/screens/meals_screen.dart';
import 'package:flutter_meals_app/widgets/categories/category_grid_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onCategoryTap(Category category) {
    final meals = ref.read(categoryMealsProvider(category.id));
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return MealsScreen(
        title: category.title,
        meals: meals,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (ctx, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: GridView(
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
      ),
    );
  }
}
