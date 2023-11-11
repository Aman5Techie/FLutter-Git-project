import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/model/meal.dart';

class FavMealNotifier extends StateNotifier<List<Meal>> {
  // State Notifier
  FavMealNotifier() : super([]); // Initalize the list

  bool togglefavmeal(Meal meal) {
    // state  is provided by the statenotofir class and can be used to set the value as add and delete are not permitted
    final mealfav = state.contains(meal);

    if (mealfav) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouritemealprovider =
    StateNotifierProvider<FavMealNotifier, List<Meal>>((ref) {
  return FavMealNotifier();
});
