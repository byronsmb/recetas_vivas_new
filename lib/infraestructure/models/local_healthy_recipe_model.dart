import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/domain/enums/recipe_type.dart';

class LocalHealthyRecipeModel {
  final String name;
  final String videoUrl;
  final String imageUrl;
  final List<IngredientCategory> ingredientCategories;
  final List<RecipeType> recipeTypes;

  LocalHealthyRecipeModel({
    required this.name,
    required this.videoUrl,
    required this.imageUrl,
    this.ingredientCategories = const [],
    this.recipeTypes = const [],
  });

  factory LocalHealthyRecipeModel.fromJson(Map<String, dynamic> json) {
    return LocalHealthyRecipeModel(
      name: json['name'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',

      ingredientCategories: (json['ingredientCategory'] as List<dynamic>? ?? [])
          .map(
            (e) => IngredientCategory.values.firstWhere(
              (c) => c.name == e,
              orElse: () => IngredientCategory.values.first,
            ),
          )
          .toList(),

      recipeTypes: (json['recipeType'] as List<dynamic>? ?? [])
          .map(
            (e) => RecipeType.values.firstWhere(
              (t) => t.name == e,
              orElse: () => RecipeType.values.first,
            ),
          )
          .toList(),
    );
  }

  //convertir a tipo HealthyRecipe
  HealthyRecipe toHealthyRecipeEntity() => HealthyRecipe(
    imageUrl: imageUrl,
    name: name,
    videoUrl: videoUrl,
    ingredientCategories: ingredientCategories,
    recipeTypes: recipeTypes,
  );
}
