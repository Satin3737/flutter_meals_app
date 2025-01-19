import 'package:flutter/material.dart';
import 'package:flutter_meals_app/providers/filters_provider.dart';
import 'package:flutter_meals_app/widgets/filters/filter_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final filters = ref.watch(filtersProvider);
    final notifier = ref.read(filtersProvider.notifier);
    final setFilter = notifier.setFilter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_rounded),
            onPressed: () => notifier.dropFilters(),
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
              value: filters[Filters.glutenFree] ?? false,
              onChanged: (value) => setFilter(Filters.glutenFree, value),
            ),
            FilterItem(
              value: filters[Filters.lactoseFree] ?? false,
              onChanged: (value) => setFilter(Filters.lactoseFree, value),
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
            ),
            FilterItem(
              value: filters[Filters.vegetarian] ?? false,
              onChanged: (value) => setFilter(Filters.vegetarian, value),
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
            ),
            FilterItem(
              value: filters[Filters.vegan] ?? false,
              onChanged: (value) => setFilter(Filters.vegan, value),
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
            ),
          ],
        ),
      ),
    );
  }
}
