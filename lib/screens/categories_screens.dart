import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';

import '../dummy_data.dart';
import '../widget/category_items.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: Provider.of<MealProvider>(context).availableCategory
          .map(
            (catData) => CategoryItem(
          catData.id,
          catData.title,
          catData.color,
        ),
      )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
