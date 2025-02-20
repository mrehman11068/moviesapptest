import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class TrailerScreen extends StatefulWidget {
  @override
  _TrailerScreenState createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  late String trailerUrl;

  @override
  void initState() {
    super.initState();
    trailerUrl = Get.arguments ?? '';
    _controller = VideoPlayerController.network(trailerUrl)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.play();
      });
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        // Trailer finished; automatically return to the detail screen
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isInitialized
          ? Stack(
        children: [
          Center(child: VideoPlayer(_controller)),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.done, color: Colors.white, size: 30),
              onPressed: () {
                // Cancel playback and return
                Get.back();
              },
            ),
          ),
        ],
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
