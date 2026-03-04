import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/domain/enums/recipe_type.dart';
import 'package:recetas_vivas/presentation/providers/recipe_provider.dart';
import 'package:recetas_vivas/presentation/widgets/video/gradient_video_background.dart';

class RecipesListScreen extends StatelessWidget {
  final RecipeFilterType filterType;
  final String filterValue;

  const RecipesListScreen({
    super.key,
    required this.filterType, //(tipo, categoria)
    required this.filterValue, // (atun, brocoli, ....)
  });

  @override
  Widget build(BuildContext context) {
    final styleText = Theme.of(context).textTheme;

    final recipeProvider = context.watch<RecipeProvider>();
    final List<HealthyRecipe> recipes = recipeProvider.recipes;

    IngredientCategory? category;
    RecipeType? type;
    List<HealthyRecipe> filteredRecipes = [];

    //seccion categoria
    if (filterType == RecipeFilterType.category) {
      //si es categoria
      category = IngredientCategory.values.firstWhere(
        (e) => e.name == filterValue,
      ); //filtra tipo de categoria

      filteredRecipes = recipes
          .where(
            (recipe) => recipe.ingredientCategories.contains(category),
          ) //guarda todos los elementos del tipo de categoria en una lista
          .toList();
    }

    //seccion tipo
    if (filterType == RecipeFilterType.type) {
      //si es categoria
      type = RecipeType.values.firstWhere(
        (e) => e.name == filterValue,
      ); //filtra tipo de comida (desayuno..)

      filteredRecipes = recipes
          .where(
            (recipe) => recipe.recipeTypes.contains(type),
          ) //guarda todos los elementos del tipo de categoria en una lista
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category?.label ?? type?.name ?? 'Not found'),
      ), //category.label
      body: MasonryGridView.builder(
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //columnas
        ),
        //crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: filteredRecipes.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  filteredRecipes[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              GradientVideoBackground(),
              _TitleVideoBackground(
                styleText: styleText,
                name: filteredRecipes[index].name,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TitleVideoBackground extends StatelessWidget {
  const _TitleVideoBackground({
    super.key,
    required this.styleText,
    required this.name,
  });

  final TextTheme styleText;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: 5,
      right: 3,
      child: Text(
        name,
        style: styleText.bodyMedium!.copyWith(color: Colors.white),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
