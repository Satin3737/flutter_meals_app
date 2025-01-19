import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/providers/favorites_provider.dart';
import 'package:flutter_meals_app/widgets/meals/meal_properties_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, ref) {
    void showMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    final isFavorite = ref.watch(favoritesProvider).contains(meal);

    void toggleFavorite() {
      final isAdd = ref.read(favoritesProvider.notifier).toggleFavorite(meal);
      showMessage(isAdd ? 'Added to favorites!' : 'Removed from favorites!');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFavorite),
              ),
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 21 / 9,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
              child: Column(
                spacing: 24,
                children: [
                  MealPropertiesList(
                    title: 'Ingredients:',
                    properties: meal.ingredients,
                  ),
                  MealPropertiesList(
                    title: 'How to cook:',
                    properties: meal.steps,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
