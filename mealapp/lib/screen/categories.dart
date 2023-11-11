import 'package:flutter/material.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/model/category.dart';
import 'package:mealapp/model/meal.dart';
import 'package:mealapp/screen/meals.dart';
import 'package:mealapp/widgets/category_grid_item.dart';

class Categories extends StatelessWidget {
  const Categories({required this.filtermeal,required this.fav, super.key});
  final void Function(Meal) fav;

  final List<Meal> filtermeal;

  void _selectcatagory(BuildContext context, Category category) {
    final List<Meal> reviseddata = filtermeal
        .where((element) => element.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealScreen(
              title: category.title,
              meal: reviseddata,
              fav: fav,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // Gridvie.builder -> To build grid viw dynamically
        body: GridView(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 3 / 2) // Number of layou t
            ,
            children: [
          for (final i in availableCategories)
            // CategoryGridItem(category: i, fn : _selectcatagory(context))
            CategoryGridItem(
                fn: () {
                  _selectcatagory(context, i);
                },
                category: i)
        ]));
  }
}
