import 'package:flutter/material.dart';
import 'package:flutter_meals_app/data/meals_data.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/screens/categories_screen.dart';
import 'package:flutter_meals_app/screens/filters_screen.dart';
import 'package:flutter_meals_app/screens/meals_screen.dart';
import 'package:flutter_meals_app/widgets/layout/burger_menu/main_drawer.dart';

enum Screens { meals, filters }

const kDefaultFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class ScreenTabs extends StatefulWidget {
  const ScreenTabs({super.key});

  @override
  State<ScreenTabs> createState() => _ScreenTabsState();
}

class _ScreenTabsState extends State<ScreenTabs> {
  final List<Meal> _favoriteMeals = [];
  int _selectedTabIndex = 0;
  Map<Filter, bool> _selectedFilters = kDefaultFilters;

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

  void _selectScreen(Screens screenName) async {
    Navigator.pop(context);

    if (screenName == Screens.filters) {
      final filters = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
            builder: (ctx) => FiltersScreen(selectedFilters: _selectedFilters)),
      );
      setState(() => _selectedFilters = filters ?? kDefaultFilters);
    }
  }

  void _onTabTap(int index) => setState(() => _selectedTabIndex = index);

  @override
  Widget build(BuildContext context) {
    final filteredMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    final List<({Widget screen, String title})> screens = [
      (
        screen: CategoriesScreen(
          filteredMeals: filteredMeals,
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
