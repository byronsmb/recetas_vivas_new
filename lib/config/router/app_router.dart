import 'package:go_router/go_router.dart';
import 'package:recetas_vivas/domain/enums/ingredient_category.dart';
import 'package:recetas_vivas/domain/enums/recipe_filter_type.dart';
import 'package:recetas_vivas/presentation/screens/screens.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/', //la 1ra pagina que se carga
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/recipes-list/:filterType/:value',

      builder: (context, state) {
        /*
        final categoryName = state.pathParameters['category']!;
        final category = IngredientCategory.values.firstWhere(
          (e) => e.name == categoryName,
        );

        return RecipesListScreen(category: category);
        */
        final filterTypeString = state.pathParameters['filterType']!;
        final value = state.pathParameters['value']!;

        final filterType = RecipeFilterType.values.firstWhere(
          (e) => e.name == filterTypeString,
        );

        return RecipesListScreen(filterType: filterType, filterValue: value);
      },
    ),
  ],
);
