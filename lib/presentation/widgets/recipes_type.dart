import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas_vivas/domain/enums/recipe_type.dart';

class RecipesType extends StatelessWidget {
  const RecipesType({super.key});

  @override
  Widget build(BuildContext context) {
    final types = RecipeType.values;

    return SizedBox(
      height: 40,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: types.length,
        itemBuilder: (context, index) {
          //print('AAAAAAAAAAAA ${RecipeType.values.length}');
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: ElevatedButton(
              onPressed: () {
                context.push('/recipes-list');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                types[index].name[0].toUpperCase() +
                    types[index].name.substring(1),
              ), // Text(types[index].name),
            ),
          );
        },
      ),
    );
    /*Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('Postres'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('Salsas'),
        ),
      ],
    );*/
  }
}
