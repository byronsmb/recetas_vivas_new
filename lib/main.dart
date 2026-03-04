import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas_vivas/config/router/app_router.dart';
import 'package:recetas_vivas/infraestructure/datasources/local_healthy_recipes_datasource_impl.dart';
import 'package:recetas_vivas/infraestructure/repositories/healthy_recipes_repository_impl.dart';
import 'package:recetas_vivas/presentation/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:recetas_vivas/presentation/providers/recipe_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Solo vertical normal
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //llama a la repositorio y le mandamos el parametro de la fuente de datos
    final healthyRecipesRepository = HealthyRecipesRepositoryImpl(
      recipesDatasource: LocalHealthyRecipesDatasource(),
      // videosDataSource: LocalVideoDatasource(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              RecipeProvider(healthyRecipesRepository: healthyRecipesRepository)
                ..loadRecipes(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      ),
    );
  }
}
