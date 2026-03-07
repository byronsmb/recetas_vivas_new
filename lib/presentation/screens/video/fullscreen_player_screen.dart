import 'package:flutter/material.dart';
import 'package:recetas_vivas/domain/entities/healthy_recipe.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayerScreen extends StatefulWidget {
  final HealthyRecipe currentRecipe;

  const FullscreenPlayerScreen({super.key, required this.currentRecipe});

  @override
  State<FullscreenPlayerScreen> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.currentRecipe.videoUrl)
      //..setVolume(0)
      ..setLooping(true);

    _initializeVideoFuture = _controller.initialize().then((_) {
      _controller.play();
    });
  }

  //dispose para evitar que el video se siga reproduciendo
  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.currentRecipe.name),
        backgroundColor: const Color.fromARGB(255, 141, 161, 139),
        //foregroundColor: color.secondary,
      ),
      body: FutureBuilder(
        future: _initializeVideoFuture, //_controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }

          return GestureDetector(
            // Al mantener presionado, subimos la velocidad
            onLongPressStart: (_) {
              _controller.setPlaybackSpeed(2.0);
              // Opcional: Podrías mostrar un pequeño texto en pantalla que diga "2x"
              setState(() {});
            },

            // 2. Al soltar el dedo, volvemos a la velocidad normal
            onLongPressEnd: (_) {
              _controller.setPlaybackSpeed(1.0);
              setState(() {});
            },
            //gesture detector para pause y play
            onTap: () {
              //si esta en play se pausa y viceversa
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }

              setState(() {});
            },
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,

                child: Stack(
                  children: [
                    VideoPlayer(_controller),

                    //play/pause
                    if (!_controller.value.isPlaying)
                      _VideoIcon(icon: Icons.play_arrow),

                    // --- INDICADOR DE VELOCIDAD X2 ---
                    // Si la velocidad es mayor a 1.0 (normal), mostramos el icono
                    if (_controller.value.playbackSpeed > 1.0)
                      _VideoIcon(icon: Icons.double_arrow_rounded),

                    // --- BARRA DE PROGRESO ---
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true, // Permite arrastrar la barra
                        colors: VideoProgressColors(
                          playedColor: Colors
                              .lightGreenAccent, // Color de lo reproducido
                          bufferedColor:
                              Colors.grey, // Color de lo cargado (buffer)
                          backgroundColor: Colors.black26, // Fondo de la barra
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VideoIcon extends StatelessWidget {
  final IconData icon;
  const _VideoIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 30,
        backgroundColor: const Color.fromARGB(103, 0, 0, 0),
        child: Icon(icon, color: Colors.lightGreenAccent, size: 35),
      ),
    );
  }
}
