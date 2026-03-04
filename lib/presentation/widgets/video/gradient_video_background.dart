import 'package:flutter/material.dart';

class GradientVideoBackground extends StatelessWidget {
  const GradientVideoBackground({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          //los stops tiene que ser misma cantidad que los colores
          gradient: LinearGradient(
            colors: const [Colors.transparent, Colors.black87],
            stops: const [0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
