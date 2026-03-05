import 'package:recetas_vivas/domain/datasources/other_recipes_datasource.dart';
import 'package:recetas_vivas/domain/entities/other_healthy_recipes.dart';
import 'package:recetas_vivas/domain/repositories/other_recipes_repository.dart';

class OtherRecipesRepositoryImpl implements OtherRecipesRepository {
  final OtherRecipesDatasource otherRecipesDatasource;

  OtherRecipesRepositoryImpl({required this.otherRecipesDatasource});
  @override
  Future<List<OtherHealthyRecipes>> getOtherRecipes() {
    return otherRecipesDatasource.getOtherRecipes();
  }
}
