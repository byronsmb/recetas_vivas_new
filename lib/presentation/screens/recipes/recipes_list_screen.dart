import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/domain/enums/recipe_type.dart';
import 'package:recetas_vivas/presentation/providers/recipe_provider.dart';

import 'package:recetas_vivas/presentation/widgets/video/video_thumbnail_masonry.dart';

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
      //si es tipo
      //print(filterValue.runtimeType); //tipo de datos
      //print(RecipeType.values.first.runtimeType); //tipo de datos
      type = RecipeType.values.firstWhere(
        (t) => t.name == filterValue,
      ); //filtra tipo de comida (desayuno..)

      filteredRecipes = recipes
          .where(
            (recipe) => recipe.recipeTypes.contains(type),
          ) //guarda todos los elementos del tipo de categoria en una lista
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category?.label ?? type!.name),
        backgroundColor: Colors.blueGrey[100],
      ), //category.label
      body: recipeProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredRecipes.isEmpty
          ? _NoRecipesFound(filterValue: filterValue)
          : VideoThumbnailMasonry(
              filteredRecipes: filteredRecipes,
              filterType: filterType,
              category: category,
              type: type,
              styleText: styleText,
            ),
    );
  }
}

class _NoRecipesFound extends StatelessWidget {
  final String filterValue;
  const _NoRecipesFound({required this.filterValue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay recetas para "$filterValue"',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text('Prueba con otra categoría o ingrediente'),
          ],
        ),
      ),
    );
  }
}
