import 'package:mealapp/model/category.dart';
import 'package:flutter/material.dart';
// import 'package:mealapp/model/meal.dart';
// import 'package:mealapp/screen/meals.dart';
// import 'package:mealapp/screen/meals.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.fn, required this.category});
  final Category category;
  final void Function() fn;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).primaryColor,
      onTap: () {
        fn();
      }, //meal
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9)
              // category.color.withOpacity(1),
              // category.color.withOpacity(1)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
