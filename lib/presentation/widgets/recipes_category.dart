import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';

class RecipesCategory extends StatelessWidget {
  final FocusNode focusNode;
  const RecipesCategory({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    final categories =
        IngredientCategory.values
            .toList() //ordenar categorias por nombre
          ..sort((a, b) => a.label.compareTo(b.label));

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: IngredientCategory.values.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return InkWell(
            onTap: () {
              focusNode.unfocus();
              context.pushNamed(
                'recipes_list',
                pathParameters: {
                  'filterType': RecipeFilterType.category.name,
                  'value': category.name,
                },
              );
              //context.push('/recipes-list/category/${category.name}');
            },
            child: Container(
              width: 65,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                      child: Image.asset(
                        category.imagePath,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover, // puedes cambiar esto
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    category.label,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
