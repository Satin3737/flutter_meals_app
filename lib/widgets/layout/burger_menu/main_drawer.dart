import 'package:flutter/material.dart';
import 'package:flutter_meals_app/screens/screen_tabs.dart';
import 'package:flutter_meals_app/widgets/layout/burger_menu/menu_item.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(Screens screenName) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        spacing: 8,
        children: [
          DrawerHeader(
            margin: EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primaryContainer,
                  theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              spacing: 16,
              children: [
                Icon(
                  Icons.fastfood,
                  size: 32,
                  color: theme.colorScheme.primary,
                ),
                Text(
                  'Cooking Up!',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          MenuItem(
            title: 'Meals',
            icon: Icons.restaurant,
            onTap: () => onSelectScreen(Screens.meals),
          ),
          MenuItem(
            title: 'Filters',
            icon: Icons.settings,
            onTap: () => onSelectScreen(Screens.filters),
          )
        ],
      ),
    );
  }
}
