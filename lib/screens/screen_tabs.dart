import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/screens/categories_screen.dart';
import 'package:flutter_meals_app/screens/filters_screen.dart';
import 'package:flutter_meals_app/screens/meals_screen.dart';
import 'package:flutter_meals_app/widgets/layout/burger_menu/main_drawer.dart';

enum Screens { meals, filters }

class ScreenTabs extends StatefulWidget {
  const ScreenTabs({super.key});

  @override
  State<ScreenTabs> createState() => _ScreenTabsState();
}

class _ScreenTabsState extends State<ScreenTabs> {
  int _selectedTabIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _toggleFavorite(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      _favoriteMeals.remove(meal);
      showInfoMessage('Removed from favorites!');
    } else {
      _favoriteMeals.add(meal);
      showInfoMessage('Added to favorites!');
    }
  }

  void _selectScreen(Screens screenName) {
    Navigator.pop(context);

    if (screenName == Screens.filters) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return FiltersScreen();
      }));
    }
  }

  void _onTabTap(int index) => setState(() => _selectedTabIndex = index);

  @override
  Widget build(BuildContext context) {
    final List<({Widget screen, String title})> screens = [
      (
        screen: CategoriesScreen(
          onToggleFavorite: _toggleFavorite,
        ),
        title: 'Meals Categories',
      ),
      (
        screen: MealsScreen(
          meals: _favoriteMeals,
          onToggleFavorite: _toggleFavorite,
        ),
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
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
