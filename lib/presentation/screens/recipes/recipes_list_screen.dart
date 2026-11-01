import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/domain/enums/recipe_type.dart';
import 'package:recetas_vivas/presentation/providers/recipe_provider.dart';

import 'package:recetas_vivas/presentation/widgets/video/video_thumbnail_masonry.dart';

class RecipesListScreen extends StatefulWidget {
  final RecipeFilterType filterType;
  final String filterValue;

  const RecipesListScreen({
    super.key,
    required this.filterType, //(tipo, categoria)
    required this.filterValue, // (atun, brocoli, ....)
  });

  @override
  State<RecipesListScreen> createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  List<HealthyRecipe> _filteredRecipes = [];
  List<HealthyRecipe>?
  _lastRecipesRef; // referencia a la última lista de "recipes" ya procesada
  IngredientCategory? _category;
  RecipeType? _type;

  void _computeFilteredRecipes(List<HealthyRecipe> recipes) {
    // Si "recipes" sigue siendo la misma instancia que la última vez, no recalculamos nada.
    // Esto evita generar una lista nueva en cada rebuild y perder el scroll del masonry.
    if (identical(_lastRecipesRef, recipes)) return;

    _lastRecipesRef = recipes;

    //seccion categoria
    if (widget.filterType == RecipeFilterType.category) {
      //si es categoria
      _category = IngredientCategory.values.firstWhere(
        (e) => e.name == widget.filterValue,
      ); //filtra tipo de categoria

      _filteredRecipes = recipes
          .where(
            (recipe) => recipe.ingredientCategories.contains(_category),
          ) //guarda todos los elementos del tipo de categoria en una lista
          .toList()
          .reversed //videos mas nuevos primero
          .toList();
      ;
    }

    //seccion tipo
    if (widget.filterType == RecipeFilterType.type) {
      //si es tipo
      //print(filterValue.runtimeType); //tipo de datos
      //print(RecipeType.values.first.runtimeType); //tipo de datos
      _type = RecipeType.values.firstWhere(
        (t) => t.name == widget.filterValue,
      ); //filtra tipo de comida (desayuno..)

      _filteredRecipes = recipes
          .where(
            (recipe) => recipe.recipeTypes.contains(_type),
          ) //guarda todos los elementos del tipo de categoria en una lista
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final styleText = Theme.of(context).textTheme;

    final recipeProvider = context.watch<RecipeProvider>();
    final List<HealthyRecipe> recipes = recipeProvider.recipes;

    _computeFilteredRecipes(recipes);

    return Scaffold(
      appBar: AppBar(
        title: Text(_category?.label ?? _type!.name),
        backgroundColor: Colors.blueGrey[100],
      ), //category.label
      body: recipeProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : _filteredRecipes.isEmpty
          ? _NoRecipesFound(filterValue: widget.filterValue)
          : VideoThumbnailMasonry(
              filteredRecipes: _filteredRecipes,
              filterType: widget.filterType,
              category: _category,
              type: _type,
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
