import 'package:flutter/material.dart';
import 'package:flutter_meals_app/providers/favorites_provider.dart';
import 'package:flutter_meals_app/providers/filters_provider.dart';
import 'package:flutter_meals_app/screens/categories_screen.dart';
import 'package:flutter_meals_app/screens/filters_screen.dart';
import 'package:flutter_meals_app/screens/meals_screen.dart';
import 'package:flutter_meals_app/widgets/drawer/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Screens { meals, filters }

class ScreenTabs extends ConsumerStatefulWidget {
  const ScreenTabs({super.key});

  @override
  ConsumerState<ScreenTabs> createState() => _ScreenTabsState();
}

class _ScreenTabsState extends ConsumerState<ScreenTabs> {
  int _selectedTabIndex = 0;

  void _selectScreen(Screens screenName) async {
    Navigator.pop(context);

    if (screenName == Screens.filters) {
      await Navigator.push<Map<Filters, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }

  void _onTabTap(int index) => setState(() => _selectedTabIndex = index);

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoritesProvider);

    final List<({Widget screen, String title})> screens = [
      (
        screen: CategoriesScreen(),
        title: 'Meals Categories',
      ),
      (
        screen: MealsScreen(meals: favoriteMeals),
        title: 'Favorites',
      ),
    ];

    final currentScreen = screens[_selectedTabIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentScreen.title),
      ),
      drawer: MainDrawer(onSelectScreen: _selectScreen),
      body: Center(
        child: currentScreen.screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTabTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
