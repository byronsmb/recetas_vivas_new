import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/presentation/providers/recipe_provider.dart';
import 'package:recetas_vivas/presentation/widgets/recipes_category.dart';
import 'package:recetas_vivas/presentation/widgets/recipes_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final styleText = Theme.of(context).textTheme;
    final recipeProvider = context.watch<RecipeProvider>();
    final List<HealthyRecipe> recipes = recipeProvider.recipes;

    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SearchFood(focusNode: _focusNode),
                      const SizedBox(width: 10),
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
                ),
                Card(
                  elevation: 8,
                  child: recipeProvider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeCap: StrokeCap.round,
                          ),
                        )
                      : Column(
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
                            SizedBox(height: 10),
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
      ),
    );
  }
}

class SearchFood extends StatefulWidget {
  final FocusNode focusNode;
  const SearchFood({super.key, required this.focusNode});

  @override
  State<SearchFood> createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // 2. Limpiamos AMBOS para evitar fugas de memoria
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _searchController,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Buscar comida saludable',

          // Add a search icon or button to the search bar
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform the search here
            },
          ),
          // Borde cuando NO está enfocado
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.transparent, // 👈 color normal
              //width: 2,
            ),
          ),
          // Borde cuando está enfocado
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.green, // 👈 color al hacer click
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
