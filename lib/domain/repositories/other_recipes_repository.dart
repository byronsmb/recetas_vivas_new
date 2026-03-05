import 'package:recetas_vivas/domain/entities/other_healthy_recipes.dart';

abstract class OtherRecipesRepository {
  Future<List<OtherHealthyRecipes>> getOtherRecipes();
}
