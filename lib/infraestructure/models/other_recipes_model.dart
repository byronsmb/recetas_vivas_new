import 'package:recetas_vivas/domain/entities/other_healthy_recipes.dart';
import 'package:uuid/uuid.dart';

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
  OtherHealthyRecipes toOtherRecipeEntity() => OtherHealthyRecipes(
    id: const Uuid().v4(),
    name: name,
    imageUrl: imageUrl,
  );
}
