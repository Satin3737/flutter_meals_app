import 'package:flutter_meals_app/data/meals_data.dart';
import 'package:flutter_meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredMealsProvider = Provider((ref) {
  final filters = ref.watch(filtersProvider);

  return dummyMeals.where((meal) {
    if (filters[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filters[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filters[Filters.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});

final categoryMealsProvider = Provider.family((ref, String categoryId) {
  final meals = ref.watch(filteredMealsProvider);

  return meals.where((meal) {
    return meal.categories.contains(categoryId);
  }).toList();
});
