import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/model/meal.dart';
import 'package:mealapp/provider/favourite_provider.dart';
import 'package:mealapp/provider/filterprovider.dart';
import 'package:mealapp/screen/categories.dart';
import 'package:mealapp/screen/filters.dart';
import 'package:mealapp/screen/meals.dart';
import 'package:mealapp/widgets/main_drawer.dart';

final intial = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabScreenState extends ConsumerStatefulWidget {
  const TabScreenState({super.key});

  @override
  ConsumerState<TabScreenState> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreenState> {
  int _selectedpageindex = 0;
  var _title = "Categories";
  List<Meal> favmeal = [];

  //  Snak bar to show added or remove from fav
  void showsnakebar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  void _selectpage(int i) {
    setState(() {
      _selectedpageindex = i;
      if (i == 0) {
        _title = "Categories";
      }
    });
  }

  void _favourite(Meal meal) {
    var a = favmeal.contains(meal);
    if (a) {
      setState(() {
        print(favmeal);
        favmeal.remove(meal);
        showsnakebar("Removed from fav");
      });
    } else {
      setState(() {
        favmeal.add(meal);
        showsnakebar("Add in fav");
      });
    }
  }

  void _closescreen(String screen) async {
    if (screen == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final activefilter = ref.watch(filterprovider);
    final filterdata = dummyMeals.where((meal) {
      print("working");
      if (activefilter[Filter.glutenfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activefilter[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activefilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (activefilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList(); // as it return an itterable

    Widget _Activepage = Categories(
      filtermeal: filterdata,
      fav: _favourite,
    );

    if (_selectedpageindex == 1) {
      final favmealbyprovider = ref.watch(favouritemealprovider);
      _Activepage = MealScreen(
        meal: favmealbyprovider,
        fav: _favourite,
      );
      _title = "Your Favourite";
    }

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      drawer: MainDrawer(
        screen: _closescreen,
      ),
      body: _Activepage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedpageindex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
        ],
        onTap: _selectpage,
      ),
    );
  }
}
