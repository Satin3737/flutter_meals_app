import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  bool checkIsFavorite(Meal meal) => state.contains(meal);

  bool toggleFavorite(Meal meal) {
    if (checkIsFavorite(meal)) {
      state = [...state]..remove(meal);
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Meal>>((ref) {
  return FavoritesNotifier();
});
