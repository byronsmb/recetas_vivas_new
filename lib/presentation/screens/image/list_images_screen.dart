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
          : imageRecipes.isEmpty
          ? _NoRecipesFound()
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
                    _dialogBuilder(context, currentImage);
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

  Future<void> _dialogBuilder(
    BuildContext context,
    OtherHealthyRecipes currentImage,
  ) {
    return showDialog(
      context: context,

      builder: (context) => Dialog(
        //margen tendrá el diálogo respecto a los bordes de la pantalla
        insetPadding: EdgeInsets.all(10),
        backgroundColor: Colors.transparent, // Fondo transparente
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: InteractiveViewer(
            panEnabled: true, // Permite mover la imagen
            boundaryMargin: EdgeInsets.all(
              100,
            ), // Permite "estirar" el borde al hacer zoom
            minScale: 1, // Zoom mínimo
            maxScale: 4.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(currentImage.imageUrl, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}

class _NoRecipesFound extends StatelessWidget {
  //const _NoRecipesFound({});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay recetas disponibles',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
