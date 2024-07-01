import 'dart:io';

import 'package:airjood/res/components/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../model/home_reels_model.dart';
import '../../../res/components/color.dart';
import 'component/custom_icon.dart';
import 'component/read_more_text.dart';
import 'component/reels_user.dart';

class VideoPlayerData extends StatefulWidget {
  final int currentPage;
  final int index;
  final List<Datum> data;

  const VideoPlayerData(
      {super.key,
      required this.currentPage,
      required this.index,
      required this.data});

  @override
  State<VideoPlayerData> createState() => _VideoPlayerDataState();
}

class _VideoPlayerDataState extends State<VideoPlayerData> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse('${widget.data[widget.index].reel?.videoUrl}'))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _videoPlayerController.setLooping(true);
          });
        }
      });
    super.initState();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.index.toString()),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction == 1) {
          _videoPlayerController.play();
        } else {
          _videoPlayerController.pause();
          _videoPlayerController.seekTo(const Duration(milliseconds: 0));
        }
      },
      child: GestureDetector(
        onTap: _togglePlayPause,
        child: _videoPlayerController.value.isInitialized
            ? Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      // aspectRatio: MediaQuery.of(context).size.width /
                      //     MediaQuery.of(context).size.height,
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomIcon(
                        name: widget.data[widget.index].user?.name,
                        experianceId: widget.data[widget.index].id,
                        description: widget.data[widget.index].description,
                        reelsId: widget.data[widget.index].reelId,
                        videoUrl: widget.data[widget.index].reel?.videoUrl,
                        videoImage:
                            widget.data[widget.index].reel?.videoThumbnailUrl,
                        likeCount: widget.data[widget.index].reel?.likeCount,
                        isLike: widget.data[widget.index].reel?.liked,
                        index: widget.index,
                        commentCount:
                            widget.data[widget.index].reel?.commentCount,
                        commentAdd: () {
                          setState(() {
                            widget.data[widget.index].reel?.commentCount =
                                (widget.data[widget.index].reel?.commentCount ??
                                        0) +
                                    1;
                          });
                        },
                        price: widget.data[widget.index].price,
                        onLikeTap: () {
                          setState(() {
                            if (widget.data[widget.index].reel?.liked == true) {
                              widget.data[widget.index].reel?.likeCount =
                                  (widget.data[widget.index].reel?.likeCount ??
                                          0) -
                                      1;
                            } else {
                              widget.data[widget.index].reel?.likeCount =
                                  (widget.data[widget.index].reel?.likeCount ??
                                          0) +
                                      1;
                            }
                            widget.data[widget.index].reel?.liked =
                                !(widget.data[widget.index].reel?.liked ??
                                    true);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ReelsUser(
                        dateTime: widget.data[widget.index].createdAt,
                        userId: widget.data[widget.index].user?.id,
                        language: widget.data[widget.index].user?.languages,
                        createdAt: widget.data[widget.index].user?.createdAt,
                        guide: widget.data[widget.index].user?.isUpgrade,
                        name: widget.data[widget.index].user?.name,
                        number: widget.data[widget.index].user?.contactNo,
                        email: widget.data[widget.index].user?.email,
                        image: widget.data[widget.index].user?.profileImageUrl,
                        discription: widget.data[widget.index].description,
                        about: widget.data[widget.index].user?.about,
                        experienceId: widget.data[widget.index].id,
                        isFollow: widget.data[widget.index].user?.isFollower,
                        gender: widget.data[widget.index].user?.gender,
                        dob: widget.data[widget.index].user?.dob,
                        role:widget.data[widget.index].user?.role,
                        screen: 'UserDetails',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: CustomReadMoreText(
                          color: AppColors.whiteTextColor,
                          mColor: AppColors.whiteTextColor,
                          rColor: AppColors.whiteTextColor,
                          trimLines: 1,
                          content: widget.data[widget.index].description ??
                              "Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur. Id sit lectus morbi nulla Tristique.",
                        ),
                      ),
                      SizedBox(
                        height: Platform.isIOS
                            ? 80 + MediaQuery.of(context).padding.bottom
                            : 90,
                      ),
                    ],
                  ),
                ],
              )
            : const ReelsShimmer(),
      ),
    );
  }
}
