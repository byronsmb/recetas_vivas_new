import 'package:recetas_vivas/domain/entities/other_healthy_recipes.dart';

abstract class OtherRecipesDatasource {
  Future<List<OtherHealthyRecipes>> getOtherRecipes();
}
