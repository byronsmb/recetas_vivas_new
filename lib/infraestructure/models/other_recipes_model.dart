import 'package:recetas_vivas/domain/entities/other_healthy_recipes.dart';

class OtherRecipesModel {
  final String name;
  final String imageUrl;

  OtherRecipesModel({required this.name, required this.imageUrl});

  factory OtherRecipesModel.fromJson(Map<String, dynamic> json) {
    return OtherRecipesModel(
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // Tu método de conversión a Entidad
  OtherHealthyRecipes toOtherRecipeEntity() =>
      OtherHealthyRecipes(name: name, imageUrl: imageUrl);
}
