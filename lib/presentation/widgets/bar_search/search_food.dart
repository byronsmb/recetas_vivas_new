import 'package:flutter/material.dart';

class SearchFood extends StatefulWidget {
  final FocusNode focusNode;
  final ValueChanged<String> onPressed;
  const SearchFood({
    super.key,
    required this.focusNode,
    required this.onPressed,
  });

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
    return TextField(
      controller: _searchController,
      focusNode: widget.focusNode,
      onChanged: (value) {
        //widget.searchText = value;
        widget.onPressed(value);
        setState(() {});
      },
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
    );
  }
}
