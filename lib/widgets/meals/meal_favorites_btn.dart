import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealFavoritesBtn extends ConsumerWidget {
  const MealFavoritesBtn({super.key, required this.meal});

  final Meal meal;

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(meal);

    void toggleFavorite() {
      final isAdd = ref.read(favoritesProvider.notifier).toggleFavorite(meal);
      showMessage(
        context,
        isAdd ? 'Added to favorites!' : 'Removed from favorites!',
      );
    }

    return IconButton(
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
    );
  }
}
