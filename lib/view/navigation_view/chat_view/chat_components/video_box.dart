import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'full_screen_video_player.dart';

class VideoBox extends StatefulWidget {
  final String videoUrl;
  final int num;

  const VideoBox({super.key, required this.videoUrl, required this.num});

  @override
  State<VideoBox> createState() => _VideoBoxState();
}

class _VideoBoxState extends State<VideoBox> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {}); // Ensure the first frame is shown.
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FullScreenVideoPlayer(videoUrl: widget.videoUrl),
          ),
        );
      },
      child: Align(
        alignment:
            widget.num == 0 ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(
            right: widget.num == 0 ? 5 : 50,
            left: widget.num == 0 ? 50 : 5,
            top: 5,
            bottom: 5,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(15),
              topLeft: Radius.circular(widget.num == 0 ? 15 : 0),
              bottomLeft: const Radius.circular(15),
              bottomRight: Radius.circular(widget.num == 0 ? 0 : 15),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                const Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 64.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
