import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/res/components/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../component/custom_icon.dart';
import '../component/reels_user.dart';

class ShowUploadReelsData extends StatefulWidget {
  final String videoUrl;
  final int? reelsId;
  final int? index;
  final String? videoImage;
  int? likeCount;
  bool? like;
  final Function? onLikeTap;
  final String? image;
  final String? name;
  final DateTime? createdAt;
  final String? number;
  final String? about;
  final String? email;
  final List? language;
  final bool? guide;
  final int? userId;
  final DateTime? dateTime;
  final String? discription;
  final String? screen;
  int? commentCount;
  final Function? commentAdd;
  ShowUploadReelsData(
      {super.key,
      required this.videoUrl,
      this.reelsId,
      this.index,
      this.videoImage,
      this.likeCount,
      this.like,
      this.onLikeTap,
      this.image,
      this.name,
      this.createdAt,
      this.number,
      this.about,
      this.email,
      this.language,
      this.guide,
      this.userId,
      this.dateTime,
      this.discription,
      this.screen,
      this.commentCount,
      this.commentAdd});

  @override
  State<ShowUploadReelsData> createState() => _ShowUploadReelsDataState();
}

class _ShowUploadReelsDataState extends State<ShowUploadReelsData> {
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        if (mounted) {
          setState(() {
            _videoPlayerController!.setLooping(true);
          });
        }
      });
    super.initState();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
      } else {
        _videoPlayerController!.play();
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.index.toString()),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction == 1) {
          _videoPlayerController?.play();
        } else {
          _videoPlayerController?.pause();
          _videoPlayerController?.seekTo(const Duration(milliseconds: 0));
        }
      },
      child: GestureDetector(
        onTap: _togglePlayPause,
        child: Center(
          child: _videoPlayerController!.value.isInitialized
              ? Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: MediaQuery.of(context).size.width /
                          MediaQuery.of(context).size.height,
                      child: VideoPlayer(_videoPlayerController!),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.whiteTextColor),
                              CustomText(
                                data: 'Previous',
                                fweight: FontWeight.w700,
                                fSize: 18,
                                fontColor: AppColors.whiteTextColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomIcon(
                          reelsId: widget.reelsId,
                          index: widget.index,
                          videoImage: widget.videoImage,
                          videoUrl: widget.videoUrl,
                          likeCount: widget.likeCount,
                          isLike: widget.like,
                          onLikeTap: widget.onLikeTap,
                          commentCount: widget.commentCount,
                          name: widget.name,
                          description: widget.discription,
                          commentAdd: widget.commentAdd,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ReelsUser(
                          name: widget.name,
                          language: widget.language,
                          email: widget.email,
                          discription: widget.discription,
                          number: widget.number,
                          guide: widget.guide,
                          createdAt: widget.createdAt,
                          userId: widget.userId,
                          dateTime: widget.dateTime,
                          screen: widget.screen,
                          about: widget.about,
                          image: widget.image,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                )
              : const ReelShimmer(),
        ),
      ),
    );
  }
}
