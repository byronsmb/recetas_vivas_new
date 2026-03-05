import 'package:recetas_vivas/domain/datasources/other_recipes_datasource.dart';
import 'package:recetas_vivas/domain/entities/other_healthy_recipes.dart';
import 'package:recetas_vivas/infraestructure/models/other_recipes_model.dart';
import 'package:recetas_vivas/shared/local_recipes_images.dart';

class OtherLocalRecipesDatasource implements OtherRecipesDatasource {
  @override
  Future<List<OtherHealthyRecipes>> getOtherRecipes() async {
    //simulamos una duracion de 1 segundo
    await Future.delayed(Duration(seconds: 1));

    final List<OtherHealthyRecipes> newOtherRecipes =
        otherImageRecipes //.map recorre cada elemento de la lista y lo transforma.
            .map(
              (recipe) =>
                  OtherRecipesModel.fromJson(recipe).toOtherRecipeEntity(),
            )
            .toList();

    return newOtherRecipes;
  }
}
