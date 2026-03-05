import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:recetas_vivas/domain/entities/other_healthy_recipes.dart';
import 'package:recetas_vivas/presentation/providers/other_recipe_provider.dart';

class ListImagesScreen extends StatelessWidget {
  const ListImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final otherRecipeProvider = context.watch<OtherRecipeProvider>();
    final List<OtherHealthyRecipes> imageRecipes = otherRecipeProvider.recipes;

    return Scaffold(
      appBar: AppBar(),
      body: otherRecipeProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //columnas
              ),
              //crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemCount: imageRecipes.length,
              itemBuilder: (context, index) {
                final currentImage = imageRecipes[index];
                return InkWell(
                  onTap: () {
                    _gotoImageViewPage(context, currentImage);
                  },
                  child: Hero(
                    tag: currentImage.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        currentImage.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _gotoImageViewPage(
    BuildContext context,
    OtherHealthyRecipes currentImage,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(title: const Text('Second Page')),
          body: Center(
            child: Hero(
              tag: currentImage.id,
              child: Image.asset(currentImage.imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
