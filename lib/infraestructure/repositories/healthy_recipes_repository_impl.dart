import 'package:recetas_vivas/domain/datasources/healthy_recipes_datasource.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/repositories/healthy_recipes_repository.dart';

class HealthyRecipesRepositoryImpl implements HealthyRecipesRepository {
  final HealthyRecipesDatasource recipesDatasource;

  HealthyRecipesRepositoryImpl({required this.recipesDatasource});
  @override
  Future<List<HealthyRecipe>> getRecipes() {
    return recipesDatasource.getRecipes();
  }
}
