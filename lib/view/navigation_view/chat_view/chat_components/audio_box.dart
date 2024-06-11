import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import '../../../../res/components/color.dart';

class AudioBox extends StatefulWidget {
  final String audioUrl;
  final int num;

  const AudioBox({super.key, required this.audioUrl, required this.num});

  @override
  State<AudioBox> createState() => _AudioBoxState();
}

class _AudioBoxState extends State<AudioBox> {
  AudioPlayer? _audioPlayer;
  bool _isPlaying = false;
  int _seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer?.setSourceUrl(widget.audioUrl);
    _audioPlayer?.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _seconds = 0;
      });
      _stopTimer();
      _audioPlayer?.seek(Duration.zero);
    });
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer?.pause();
      _stopTimer();
    } else {
      _audioPlayer?.resume();
      _startTimer();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.num == 0 ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(
          right: widget.num == 0 ? 5 : 50,
          left: widget.num == 0 ? 50 : 5,
          top: 5,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          color:
              widget.num == 0 ? AppColors.mainColor : AppColors.textFildBGColor,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(15),
            topLeft: Radius.circular(widget.num == 0 ? 15 : 0),
            bottomLeft: const Radius.circular(15),
            bottomRight: Radius.circular(widget.num == 0 ? 0 : 15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _togglePlayPause,
              child: Icon(
                _isPlaying ? Icons.stop : Icons.play_arrow,
                color: _isPlaying ? Colors.red : Colors.blue,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '$_seconds s',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }
}
