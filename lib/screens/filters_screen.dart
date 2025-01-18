import 'package:flutter/material.dart';
import 'package:flutter_meals_app/screens/screen_tabs.dart';
import 'package:flutter_meals_app/widgets/filters/filter_item.dart';
import 'package:flutter_meals_app/widgets/layout/burger_menu/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  void _selectScreen(Screens screenName) {
    Navigator.pop(context);

    if (screenName == Screens.meals) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return ScreenTabs();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      drawer: MainDrawer(onSelectScreen: _selectScreen),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FilterItem(
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              value: _glutenFree,
              onChanged: (value) => setState(() => _glutenFree = value),
            ),
            FilterItem(
              value: _lactoseFree,
              onChanged: (value) => setState(() => _lactoseFree = value),
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
            ),
            FilterItem(
              value: _vegetarian,
              onChanged: (value) => setState(() => _vegetarian = value),
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
            ),
            FilterItem(
              value: _vegan,
              onChanged: (value) => setState(() => _vegan = value),
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
            ),
          ],
        ),
      ),
    );
  }
}
