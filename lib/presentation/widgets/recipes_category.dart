import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/presentation/screens/recipes/providers/recipe_provider.dart';

class RecipesCategory extends StatelessWidget {
  const RecipesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeProvider>();
    final List<HealthyRecipe> recipes = recipeProvider.recipes;
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

          return Container(
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
          );
        },
      ),
    );
  }
}
