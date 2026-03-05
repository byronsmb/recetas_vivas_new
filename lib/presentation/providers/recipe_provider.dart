import 'package:flutter/widgets.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/repositories/healthy_recipes_repository.dart';

class RecipeProvider extends ChangeNotifier {
  // TODO: Repository, DataSource
  // Del domain
  final HealthyRecipesRepository healthyRecipesRepository;

  //bool initialLoading = true; // al inicio cuando no hay ingun video
  List<HealthyRecipe> recipes = [];

  bool isLoading = true;
  RecipeProvider({required this.healthyRecipesRepository});

  Future<void> loadRecipes() async {
    final newRecipes = await healthyRecipesRepository.getRecipes();

    recipes.addAll(newRecipes);
    //initialLoading = false;
    isLoading = false;
    notifyListeners();
  }
}
