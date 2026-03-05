import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/domain/enums/recipe_type.dart';

class RecipesType extends StatelessWidget {
  const RecipesType({super.key});

  @override
  Widget build(BuildContext context) {
    final type = RecipeType.values;

    return SizedBox(
      height: 40,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: type.length,
        itemBuilder: (context, index) {
          //print('AAAAAAAAAAAA ${RecipeType.values.length}');
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(
                  'recipes_list',
                  pathParameters: {
                    'filterType': '${RecipeFilterType.type.name}',
                    'value': type[index].name,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                type[index].name[0].toUpperCase() +
                    type[index].name.substring(1),
              ), // Text(types[index].name),
            ),
          );
        },
      ),
    );
  }
}
