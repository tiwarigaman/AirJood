import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const FullScreenVideoPlayer({super.key, required this.videoUrl});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = true;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isPlaying = true;
        });
        _controller.play();
        _startHideControlsTimer();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
      _startHideControlsTimer();
    });
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  void _onScreenTap() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _startHideControlsTimer();
      } else {
        _hideControlsTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onTap: _onScreenTap,
        child: Center(
          child: _controller.value.isInitialized
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    if (_showControls)
                      GestureDetector(
                        onTap: _togglePlayPause,
                        child: Icon(
                          _isPlaying
                              ? Icons.pause_circle_outline
                              : Icons.play_circle_outline,
                          color: Colors.white,
                          size: 64.0,
                        ),
                      ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
    );
  }
}
