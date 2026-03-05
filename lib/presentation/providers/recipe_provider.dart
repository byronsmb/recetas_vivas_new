import 'package:flutter/widgets.dart';
import 'package:recetas_vivas/config/helpers/random_number.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/repositories/healthy_recipes_repository.dart';

class RecipeProvider extends ChangeNotifier {
  // TODO: Repository, DataSource
  // Del domain
  final HealthyRecipesRepository healthyRecipesRepository;

  List<HealthyRecipe> recipes = [];

  bool isLoading = true;
  int randomNumber = 1;

  RecipeProvider({required this.healthyRecipesRepository});

  Future<void> loadRecipes() async {
    final newRecipes = await healthyRecipesRepository.getRecipes();

    recipes.addAll(newRecipes);

    randomNumber = RandomNumber.getNumber(recipes.length - 1);
    isLoading = false;
    notifyListeners();
  }
}
