import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/domain/enums/recipe_type.dart';
import 'package:recetas_vivas/presentation/widgets/video/gradient_video_background.dart';

class VideoThumbnailMasonry extends StatelessWidget {
  const VideoThumbnailMasonry({
    super.key,
    required this.filteredRecipes,
    this.filterType,
    this.category,
    this.type,
    required this.styleText,
  });

  final List<HealthyRecipe> filteredRecipes;
  final RecipeFilterType? filterType;
  final IngredientCategory? category;
  final RecipeType? type;
  final TextTheme styleText;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //columnas
      ),
      //crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: filteredRecipes.length,
      itemBuilder: (context, index) {
        final currentRecipe = filteredRecipes[index];
        return InkWell(
          onTap: () {
            if (category == null) {
              context.pushNamed('video_player_all', extra: currentRecipe);
            } else {
              context.pushNamed(
                'video_player',
                pathParameters: {
                  'filterType': filterType!.name, //category o type
                  'value':
                      category?.name ?? type!.name, //avena...n/ desayuno...
                },
                extra: currentRecipe,
              );
            }
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(currentRecipe.imageUrl, fit: BoxFit.cover),
              ),
              GradientVideoBackground(),
              _TitleVideoBackground(
                styleText: styleText,
                name: currentRecipe.name,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TitleVideoBackground extends StatelessWidget {
  const _TitleVideoBackground({required this.styleText, required this.name});

  final TextTheme styleText;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: 5,
      right: 3,
      child: Text(
        name,
        style: styleText.bodyMedium!.copyWith(color: Colors.white),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
