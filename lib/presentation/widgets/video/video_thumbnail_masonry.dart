import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/domain/enums/recipe_type.dart';
import 'package:recetas_vivas/presentation/widgets/video/gradient_video_background.dart';

class VideoThumbnailMasonry extends StatefulWidget {
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
  State<VideoThumbnailMasonry> createState() => _VideoThumbnailMasonryState();
}

class _VideoThumbnailMasonryState extends State<VideoThumbnailMasonry> {
  // Mapa: imageUrl -> Size
  final Map<String, Size> _imageSizes = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _preloadImageSizes();
  }

  @override
  void didUpdateWidget(VideoThumbnailMasonry oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si cambia la lista de recetas, recarga tamaños
    if (oldWidget.filteredRecipes != widget.filteredRecipes) {
      _preloadImageSizes();
    }
  }

  Future<void> _preloadImageSizes() async {
    setState(() => _isLoading = true);

    final Map<String, Size> sizes = {};

    await Future.wait(
      widget.filteredRecipes.map((recipe) async {
        if (_imageSizes.containsKey(recipe.imageUrl)) {
          sizes[recipe.imageUrl] = _imageSizes[recipe.imageUrl]!;
          return;
        }
        final size = await _getAssetImageSize(recipe.imageUrl);
        sizes[recipe.imageUrl] = size;
      }),
    );

    if (mounted) {
      setState(() {
        _imageSizes.addAll(sizes);
        _isLoading = false;
      });
    }
  }

  Future<Size> _getAssetImageSize(String assetPath) async {
    final completer = Completer<Size>();
    final image = AssetImage(assetPath);
    image
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((info, _) {
            completer.complete(
              Size(info.image.width.toDouble(), info.image.height.toDouble()),
            );
          }),
        );
    return completer.future;
  }

  void _onTap(BuildContext context, HealthyRecipe currentRecipe) {
    if (widget.category == null) {
      context.pushNamed('video_player_all', extra: currentRecipe);
    } else {
      context.pushNamed(
        'video_player',
        pathParameters: {
          'filterType': widget.filterType!.name,
          'value': widget.category?.name ?? widget.type!.name,
        },
        extra: currentRecipe,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      cacheExtent: 1500,
      itemCount: widget.filteredRecipes.length,
      itemBuilder: (context, index) {
        final currentRecipe = widget.filteredRecipes[index];
        final size = _imageSizes[currentRecipe.imageUrl];

        return InkWell(
          onTap: () => _onTap(context, currentRecipe),
          child: AspectRatio(
            // Si por alguna razón no se cargó el tamaño, usa ratio 3/4 como fallback
            aspectRatio: size != null ? size.width / size.height : 3 / 4,
            child: Stack(
              fit: StackFit.expand, // ← importante para que Stack ocupe todo
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    currentRecipe.imageUrl,
                    fit: BoxFit.cover,
                    // Limita la resolución de decodificación al tamaño real en pantalla (evitar saltos en scroll)
                    cacheWidth: 400,
                  ),
                ),
                GradientVideoBackground(),
                _TitleVideoBackground(
                  styleText: widget.styleText,
                  name: currentRecipe.name,
                ),
              ],
            ),
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
