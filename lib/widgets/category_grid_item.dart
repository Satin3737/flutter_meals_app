import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onCategoryTap,
  });

  final Category category;
  final void Function() onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16),
        onTap: onCategoryTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                category.color.withValues(alpha: 0.4),
                category.color.withValues(alpha: 0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ),
    );
  }
}
