enum IngredientCategory {
  airFryer(label: 'Air Fryer', imagePath: 'assets/icons/airFryer_icon.png'),
  avena(label: 'Avena', imagePath: 'assets/icons/oatmeal_icon.png'),
  espinaca(label: 'Espinaca', imagePath: 'assets/icons/spinach_icon.png'),
  lentejas(label: 'Lentejas', imagePath: 'assets/icons/lentils_icon.png'),
  mayonesa(label: 'Mayonesa', imagePath: 'assets/icons/mayonnaise_icon.png'),
  manzana(label: 'Manzana', imagePath: 'assets/icons/apple_icon.png'),
  mostaza(label: 'Mostaza', imagePath: 'assets/icons/mustard_icon.png'),
  burrito(label: 'Burrito', imagePath: 'assets/icons/burrito_icon.png'),
  atun(label: 'Atún', imagePath: 'assets/icons/tuna_icon.png'),
  huevo(label: 'Huevo', imagePath: 'assets/icons/egg_icon.png'),
  tortitas(label: 'Tortitas', imagePath: 'assets/icons/tortita_icon.png'),
  aguacate(label: 'Aguacate', imagePath: 'assets/icons/avocado_icon.png'),
  yogurGriego(
    label: 'Yogurt Griego',
    imagePath: 'assets/icons/greekYogurt_icon.png',
  ),
  pasta(label: 'Pasta', imagePath: 'assets/icons/pasta_icon.png'),
  pescado(label: 'Pescado', imagePath: 'assets/icons/avocado_icon.png'),
  platano(label: 'Plátano', imagePath: 'assets/icons/plantain_icon.png'),
  pollo(label: 'Pollo', imagePath: 'assets/icons/chicken_icon.png'),
  quesoCrema(
    label: 'Queso Crema',
    imagePath: 'assets/icons/cream_cheese_icon.png',
  ),
  quinua(label: 'Quinoa', imagePath: 'assets/icons/quinoa_icon.png'),
  tostada(label: 'Tostada', imagePath: 'assets/icons/avocado_icon.png'),
  pepino(label: 'Pepino', imagePath: 'assets/icons/cucumber_icon.png'),
  brocoli(label: 'Brócoli', imagePath: 'assets/icons/broccoli_icon.png'),
  zanahoria(label: 'Zanahoria', imagePath: 'assets/icons/carrot_icon.png'),
  calabacin(label: 'Calabacin', imagePath: 'assets/icons/zucchini_icon.png'),
  garbanzo(label: 'Garbanzo', imagePath: 'assets/icons/chickpea_icon.png'),
  linaza(label: 'Linaza', imagePath: 'assets/icons/linseed_icon.png'),
  remolacha(label: 'Remolacha', imagePath: 'assets/icons/beet_icon.png'),

  frejol(label: 'Fréjol', imagePath: 'assets/icons/bean_icon.png');

  final String label;
  final String imagePath;

  const IngredientCategory({required this.label, required this.imagePath});
}
