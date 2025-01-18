import 'package:flutter/material.dart';
import 'package:flutter_meals_app/widgets/filters/filter_item.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.selectedFilters});

  final Map<Filter, bool> selectedFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  @override
  void initState() {
    super.initState();
    final filters = widget.selectedFilters;

    _glutenFree = filters[Filter.glutenFree]!;
    _lactoseFree = filters[Filter.lactoseFree]!;
    _vegetarian = filters[Filter.vegetarian]!;
    _vegan = filters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        Navigator.of(context).pop({
          Filter.glutenFree: _glutenFree,
          Filter.lactoseFree: _lactoseFree,
          Filter.vegetarian: _vegetarian,
          Filter.vegan: _vegan,
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Filters'),
          actions: [
            IconButton(
              icon: const Icon(Icons.cleaning_services_rounded),
              onPressed: () {
                setState(() {
                  _glutenFree = false;
                  _lactoseFree = false;
                  _vegetarian = false;
                  _vegan = false;
                });
              },
            ),
          ],
        ),
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
      ),
    );
  }
}
