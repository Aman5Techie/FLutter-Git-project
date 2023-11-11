import 'package:flutter/material.dart';
import 'package:mealapp/model/meal.dart';
import 'package:mealapp/screen/mealdetailscreen.dart';
import 'package:mealapp/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({required this.fav,required this.meal, super.key});
  final void Function(Meal) fav;


  final Meal meal;
  String get name {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealDetailScreen(meal: meal,fav: fav,)));
            
          },
          child: Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Positioned(
                  // top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 100,
                  child: Container(
                    color: Colors.black54,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                    child: Column(children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card_below_icons(
                              icon: (Icons.schedule),
                              info: "${meal.duration} min"),
                          const SizedBox(
                            width: 12,
                          ),
                          Card_below_icons(icon: Icons.work, info: name),
                          const SizedBox(
                            width: 12,
                          ),
                          Card_below_icons(
                              icon: Icons.attach_money, info: affordability)
                          // Card_below_icons(icon: icon, info: info)
                        ],
                      )
                    ]),
                  ))
            ],
          ),
        ));
  }
}
