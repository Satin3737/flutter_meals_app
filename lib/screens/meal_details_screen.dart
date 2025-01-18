import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/widgets/meals/meal_properties_list.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () => onToggleFavorite(meal),
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
