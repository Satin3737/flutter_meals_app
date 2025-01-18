import 'package:flutter/material.dart';
import 'package:flutter_meals_app/screens/categories_screen.dart';
import 'package:flutter_meals_app/screens/meals_screen.dart';

class ScreenTabs extends StatefulWidget {
  const ScreenTabs({super.key});

  @override
  State<ScreenTabs> createState() => _ScreenTabsState();
}

class _ScreenTabsState extends State<ScreenTabs> {
  int _selectedTabIndex = 0;

  final List<({Widget screen, String title})> _screens = const [
    (screen: CategoriesScreen(), title: 'Meals Categories'),
    (screen: MealsScreen(meals: []), title: 'Favorites'),
  ];

  void _onTabTap(int index) => setState(() => _selectedTabIndex = index);

  @override
  Widget build(BuildContext context) {
    final currentScreen = _screens[_selectedTabIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentScreen.title),
      ),
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
