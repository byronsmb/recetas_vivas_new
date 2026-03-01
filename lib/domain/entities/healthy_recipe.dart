import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/domain/enums/recipe_type.dart';

class HealthyRecipe {
  final String name;
  final String videoUrl;
  final String imageUrl;
  final List<IngredientCategory> ingredientCategories;
  final List<RecipeType> recipeTypes;

  HealthyRecipe({
    required this.name,
    required this.videoUrl,
    required this.imageUrl,
    required this.ingredientCategories,
    required this.recipeTypes,
  });
}
