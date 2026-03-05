import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/presentation/screens/screens.dart';
import 'package:recetas_vivas/presentation/screens/video/fullscreen_player_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
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
        final filterTypeString = state.pathParameters['filterType']!;
        final value = state.pathParameters['value']!;

        final filterType = RecipeFilterType.values.firstWhere(
          (e) => e.name == filterTypeString,
          //orElse: () => RecipeFilterType.category,
        );

        return RecipesListScreen(filterType: filterType, filterValue: value);
      },
      //ruta hija
      routes: [
        GoRoute(
          path: 'video',
          name: 'video_player', // <--- Nombre de la ruta hija
          builder: (context, state) {
            final url = (state.extra as String?) ?? '';
            return FullscreenPlayerScreen(videoUrl: url);
          },
        ),
      ],
    ),
  ],
);
