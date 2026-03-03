import 'package:go_router/go_router.dart';
import 'package:recetas_vivas/presentation/screens/screens.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/', //la 1ra pagina que se carga
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/recipes-list',

      builder: (context, state) => RecipesListScreen(),
    ),
  ],
);
