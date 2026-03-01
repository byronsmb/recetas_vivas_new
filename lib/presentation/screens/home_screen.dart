import 'package:flutter/material.dart';
import 'package:recetas_vivas/presentation/widgets/recipes_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final styleText = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SearchFood(),
              Card(
                elevation: 8,
                child: Column(
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
                        height: size.height * 0.25,
                        width: size.width,
                        'assets/images/arrozColiflor.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Bowl de Pollo Mediterráneo',
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
              RecipesCategory(),
              SizedBox(height: 20),
              Text('Categorias populares', style: styleText.titleMedium),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Postres'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Salsas'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchFood extends StatefulWidget {
  const SearchFood({super.key});

  @override
  State<SearchFood> createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // Add padding around the search bar
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // Use a Material design search bar
        child: TextField(
          controller: _searchController,
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
      ),
    );
  }
}
/*

Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.red,
            ),
          ),
          Text('Explorar por ingrediente'),
          ListView(children: [CircleAvatar()]),
        ],
      )
      */