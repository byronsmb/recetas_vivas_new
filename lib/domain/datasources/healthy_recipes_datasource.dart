import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';

abstract class HealthyRecipesDatasource {
  Future<List<HealthyRecipe>> getRecipesbyCategory();
}
