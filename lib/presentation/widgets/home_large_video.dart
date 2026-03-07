import 'package:flutter/material.dart';

import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/presentation/providers/recipe_provider.dart';
import 'package:recetas_vivas/presentation/screens/video/fullscreen_player_screen.dart';

class HomeLargeVideo extends StatelessWidget {
  const HomeLargeVideo({
    super.key,
    required this.styleText,
    required this.recipes,
    required this.recipeProvider,
    required this.size,
  });

  final TextTheme styleText;
  final List<HealthyRecipe> recipes;
  final RecipeProvider recipeProvider;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              'Receta destacada del dia',
              style: styleText.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.asset(
                recipes[recipeProvider.randomNumber].imageUrl,
                height: size.height * 0.25,
                width: size.width,

                fit: BoxFit.cover,
              ),
            ),
            Text(
              recipes[recipeProvider.randomNumber].name,
              style: styleText.titleLarge,
            ),

            Text(
              'Fácil y Nutritivo para cualquier día',
              style: styleText.titleSmall,
            ),
            SizedBox(height: 5),
          ],
        ),
        Positioned(
          bottom: 5,
          right: 10,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullscreenPlayerScreen(
                    currentRecipe: recipes[recipeProvider.randomNumber],
                  ),
                ),
              );
            },
            icon: Icon(Icons.play_circle_outline, size: 30),
          ),
        ),
      ],
    );
  }
}
