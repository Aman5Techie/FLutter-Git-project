import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutenfree, lactosefree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenfree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
          Filter.lactosefree: false,
        });

  void setfilters(Map<Filter, bool> choosenfilter) {
    state = choosenfilter;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterprovider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);
