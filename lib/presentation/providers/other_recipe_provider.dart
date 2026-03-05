import 'package:flutter/material.dart';
import 'package:recetas_vivas/domain/entities/other_healthy_recipes.dart';
import 'package:recetas_vivas/domain/repositories/other_recipes_repository.dart';

class OtherRecipeProvider extends ChangeNotifier {
  final OtherRecipesRepository otherRecipesRepository;

  OtherRecipeProvider({required this.otherRecipesRepository});

  List<OtherHealthyRecipes> recipes = [];

  bool isLoading = true;

  Future<void> loadOtherRecipes() async {
    final newRecipes = await otherRecipesRepository.getOtherRecipes();

    recipes.addAll(newRecipes);
    isLoading = false;
    notifyListeners();
  }
}
