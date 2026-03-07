import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/infraestructure/datasources/other_local_recipes_datasource_impl.dart';
import 'package:recetas_vivas/infraestructure/repositories/other_recipes_repository_impl.dart';
import 'package:recetas_vivas/presentation/providers/other_recipe_provider.dart';
import 'package:recetas_vivas/presentation/screens/image/list_images_screen.dart';
import 'package:recetas_vivas/presentation/screens/screens.dart';
import 'package:recetas_vivas/presentation/screens/video/fullscreen_player_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  //initialLocation: '/',
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('La ruta ${state.uri.path} no existe.')),
  ),
  routes: [
    GoRoute(
      path: '/',
      name: 'home', // <--- Nombre de la ruta
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/recipes-list/:filterType/:value',
      name: 'recipes_list', // <--- Nombre de la ruta
      builder: (context, state) {
        final filterTypeString =
            state.pathParameters['filterType']!; //category o type
        final value =
            state.pathParameters['value']!; // atun, avena... desayuno...

        final filterType = RecipeFilterType.values.firstWhere(
          //type o category
          (e) => e.name == filterTypeString,
          //orElse: () => RecipeFilterType.category,
        );

        return RecipesListScreen(filterType: filterType, filterValue: value);

        ///recipes-list/category/avena
      },
      //ruta hija
      routes: [
        GoRoute(
          path: 'video',
          name: 'video_player', // <--- Nombre de la ruta hija
          builder: (context, state) {
            final HealthyRecipe recipe =
                (state.extra as HealthyRecipe); // (state.extra as String);
            return FullscreenPlayerScreen(currentRecipe: recipe);
          },
        ),
      ],
    ),

    GoRoute(
      //ruta directa sin categorias ni tipo (para busqueda)
      path: '/recipes-list/video',
      name: 'video_player_all',
      builder: (context, state) {
        final recipe = state.extra as HealthyRecipe;
        return FullscreenPlayerScreen(currentRecipe: recipe);
      },
    ),

    GoRoute(
      path: '/images-list',
      name: 'images_list', // <--- Nombre de la ruta
      builder: (context, state) {
        //Inyección de Dependencias (Service Locator)
        //Se recomienda usar un "Service Locator" como GetIt. Esto permite que el router solo "pida" la instancia que ya existe, en lugar de fabricarla ahí mismo.
        final healthyRecipesRepository = OtherRecipesRepositoryImpl(
          otherRecipesDatasource: OtherLocalRecipesDatasource(),
        );

        return ChangeNotifierProvider(
          create: (_) => OtherRecipeProvider(
            otherRecipesRepository: healthyRecipesRepository,
          )..loadOtherRecipes(),
          child: const ListImagesScreen(),
        );
      },
    ),
  ],
);
