import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/screens/meal_details_screen.dart';
import 'package:flutter_meals_app/widgets/meals/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void _onMealTap(BuildContext context, Meal meal) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return MealDetailsScreen(meal: meal);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final isFavorites = title == null;
    final theme = Theme.of(context);

    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Text(
            'Well... Nothing here!',
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            isFavorites
                ? 'Add some meals to your favorites!'
                : 'Try selecting another category!',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.separated(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onMealTap: () => _onMealTap(context, meals[index]),
        ),
        separatorBuilder: (ctx, index) => const SizedBox(height: 16),
      );
    }

    if (isFavorites) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: content,
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: content,
        ),
      );
    }
  }
}
