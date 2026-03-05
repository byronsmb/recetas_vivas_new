import 'package:recetas_vivas/domain/datasources/healthy_recipes_datasource.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/infraestructure/models/local_healthy_recipe_model.dart';
import 'package:recetas_vivas/shared/local_recipes_data.dart';

class LocalHealthyRecipesDatasource implements HealthyRecipesDatasource {
  @override
  Future<List<HealthyRecipe>> getRecipes() async {
    //simulamos una duracion de 1 segundo
    await Future.delayed(Duration(seconds: 1));

    //copiado del provider
    // cuando tenemos peticiones web, aqui es donde vamos a poder camiar esto
    final List<HealthyRecipe> newRecipes =
        healthyRecipes //.map recorre cada elemento de la lista y lo transforma.
            .map(
              (recipe) => LocalHealthyRecipeModel.fromJson(
                recipe,
              ).toHealthyRecipeEntity(),
            )
            .toList();
    //print('RECETAS .. ${newRecipes.length}');
    return newRecipes; //retronamos los videos
  }
}
