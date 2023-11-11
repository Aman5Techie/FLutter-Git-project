import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/provider/filterprovider.dart';


class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({  super.key});

  @override
  ConsumerState<FilterScreen> createState() {
    return _FilterScreen();
  }
}

class _FilterScreen extends ConsumerState<FilterScreen> {
  var _glutenfree = false;
  var _lactose = false;
  var _veg = false;
  var _vegan = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final activefilte = ref.read(filterprovider);
    _glutenfree = activefilte[Filter.glutenfree]!;
    _lactose = activefilte[Filter.lactosefree]!;
    _veg = activefilte[Filter.vegetarian]!;
    _vegan = activefilte[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filters")),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filterprovider.notifier).setfilters({
            Filter.glutenfree: _glutenfree,
            Filter.lactosefree: _lactose,
            Filter.vegan: _vegan,
            Filter.vegetarian: _veg
          });

          // Navigator.of(context).pop();
          return true;
        },
        child: Column(
          children: [
            SwitchListTile(
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                title: Text(
                  "Gluten-Free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text("Only include Gluten Free meal",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                value: _glutenfree,
                onChanged: (a) {
                  setState(() {
                    _glutenfree = a;
                  });
                }),
            SwitchListTile(
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                title: Text(
                  "Lactose-Free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text("Only include Lactose Free meal",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                value: _lactose,
                onChanged: (a) {
                  setState(() {
                    _lactose = a;
                  });
                }),
            SwitchListTile(
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                title: Text(
                  "Vegetarian",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text("Only include Vegetarian Free meal",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                value: _veg,
                onChanged: (a) {
                  setState(() {
                    _veg = a;
                  });
                }),
            SwitchListTile(
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                title: Text(
                  "Vegan",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text("Only include Vegan meal",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                value: _vegan,
                onChanged: (a) {
                  setState(() {
                    _vegan = a;
                  });
                })
          ],
        ),
      ),
    );
  }
}
