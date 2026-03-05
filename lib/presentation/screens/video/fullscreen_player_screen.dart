import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const FullscreenPlayerScreen({super.key, required this.videoUrl});

  @override
  State<FullscreenPlayerScreen> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoFuture;

  @override
  void initState() {
    super.initState();
    print('LINK DEL VIDEO ${widget.videoUrl}');
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(0)
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
      appBar: AppBar(title: Text('data')),
      body: FutureBuilder(
        future: _initializeVideoFuture, //_controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }

          return GestureDetector(
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
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: Stack(
                children: [
                  VideoPlayer(_controller),

                  //play/pause
                  if (!_controller.value.isPlaying)
                    Center(
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(103, 0, 0, 0),
                        child: Icon(Icons.play_arrow),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
