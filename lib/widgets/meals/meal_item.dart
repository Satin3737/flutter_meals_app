import 'package:flutter/material.dart';
import 'package:flutter_meals_app/helpers/text_helper.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/widgets/meals/meal_favorites_btn.dart';
import 'package:flutter_meals_app/widgets/meals/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onMealTap});

  final Meal meal;
  final void Function() onMealTap;

  @override
  Widget build(BuildContext context) {
    final List<({IconData icon, String text})> traits = [
      (icon: Icons.schedule, text: '${meal.duration} min'),
      (icon: Icons.work, text: TextHelper.capitalize(meal.complexity.name)),
      (icon: Icons.money, text: TextHelper.capitalize(meal.affordability.name)),
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: InkWell(
        onTap: onMealTap,
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: Stack(
            children: [
              Hero(
                tag: meal.id,
                child: FadeInImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: MealFavoritesBtn(meal: meal),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: Colors.black54,
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Row(
                        spacing: 16,
                        children: traits.map((trait) {
                          return MealItemTrait(
                            icon: trait.icon,
                            text: trait.text,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
