import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';

abstract class HealthyRecipesRepository {
  Future<List<HealthyRecipe>> getRecipes();
}
