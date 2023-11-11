import 'package:flutter/material.dart';
import 'package:mealapp/model/meal.dart';
import 'package:mealapp/widgets/mealitem.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({this.title, required this.fav,required this.meal, super.key});
  final void Function(Meal) fav;


  final String? title;
  final List<Meal> meal;
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meal.length, itemBuilder: (c, i) => MealItem(meal: meal[i] , fav: fav,));

    if (meal.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Uh oh ... nothing here !",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try Selecting a different Category !",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
