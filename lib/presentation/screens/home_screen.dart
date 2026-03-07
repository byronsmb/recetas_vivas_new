import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/presentation/providers/recipe_provider.dart';
import 'package:recetas_vivas/presentation/widgets/bar_search/search_food.dart';
import 'package:recetas_vivas/presentation/widgets/home_large_video.dart';
import 'package:recetas_vivas/presentation/widgets/recipes_category.dart';
import 'package:recetas_vivas/presentation/widgets/recipes_type.dart';
import 'package:recetas_vivas/presentation/widgets/video/video_thumbnail_masonry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();
  String searchText = "";

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void updateState(String text) {
    setState(() {
      searchText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final styleText = Theme.of(context).textTheme;
    final recipeProvider = context.watch<RecipeProvider>();
    final List<HealthyRecipe> recipes = recipeProvider.recipes;

    final filteredRecipes = recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: SearchFood(
            focusNode: _focusNode,
            onPressed: (value) => updateState(value),
          ),
          actions: [
            IconButton(
              iconSize: 40, // Ajusta el tamaño del botón
              icon: Image.asset(
                'assets/icons/button_img_icon.png',
              ), // Tu imagen desde assets
              onPressed: () {
                context.pushNamed('images_list');
              },
            ),
          ],
        ),
        body: searchText.isEmpty
            ? MainSection(
                recipeProvider: recipeProvider,
                styleText: styleText,
                recipes: recipes,
                size: size,
                focusNode: _focusNode,
              )
            : VideoThumbnailMasonry(
                filteredRecipes: filteredRecipes,
                filterType: RecipeFilterType.category,
                styleText: styleText,
              ),
      ),
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({
    super.key,
    required this.recipeProvider,
    required this.styleText,
    required this.recipes,
    required this.size,
    required FocusNode focusNode,
  }) : _focusNode = focusNode;

  final RecipeProvider recipeProvider;
  final TextTheme styleText;
  final List<HealthyRecipe> recipes;
  final Size size;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                elevation: 8,
                child: recipeProvider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeCap: StrokeCap.round,
                        ),
                      )
                    : HomeLargeVideo(
                        styleText: styleText,
                        recipes: recipes,
                        recipeProvider: recipeProvider,
                        size: size,
                      ),
              ),
              SizedBox(height: 20),
              Text('Explorar por ingrediente', style: styleText.titleMedium),
              RecipesCategory(focusNode: _focusNode),
              SizedBox(height: 15),
              Text('Categorias populares', style: styleText.titleMedium),
              RecipesType(),
            ],
          ),
        ),
      ),
    );
  }
}
