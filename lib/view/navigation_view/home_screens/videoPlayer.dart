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
  final PageController _pageController = PageController();
  int currentPage = 0;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse('${widget.data[widget.index].reel?[currentPage].videoUrl}'))
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
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.data[widget.index].reel?.length,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (value) {
                          currentPage = value;
                          setState(() {});
                        },
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return VideoPlayer(_videoPlayerController);
                        },
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomIcon(
                        name: widget.data[widget.index].user?.name,
                        rating: widget.data[widget.index].rating,
                        experianceId: widget.data[widget.index].id,
                        description: widget.data[widget.index].description,
                        reelsId: widget.data[widget.index].reel?[0].id,
                        videoUrl: widget.data[widget.index].reel?[0].videoUrl,
                        videoImage:
                            widget.data[widget.index].reel?[0].videoThumbnailUrl,
                        likeCount: widget.data[widget.index].reel?[0].likeCount,
                        isLike: widget.data[widget.index].reel?[0].liked,
                        index: widget.index,
                        commentCount:
                            widget.data[widget.index].reel?[0].commentCount,
                        commentAdd: () {
                          setState(() {
                            widget.data[widget.index].reel?[0].commentCount =
                                (widget.data[widget.index].reel?[0].commentCount ??
                                        0) +
                                    1;
                          });
                        },
                        price: widget.data[widget.index].price,
                        onLikeTap: () {
                          setState(() {
                            if (widget.data[widget.index].reel?[0].liked == true) {
                              widget.data[widget.index].reel?[0].likeCount =
                                  (widget.data[widget.index].reel?[0].likeCount ??
                                          0) -
                                      1;
                            } else {
                              widget.data[widget.index].reel?[0].likeCount =
                                  (widget.data[widget.index].reel?[0].likeCount ??
                                          0) +
                                      1;
                            }
                            widget.data[widget.index].reel?[0].liked =
                                !(widget.data[widget.index].reel?[0].liked ??
                                    true);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buildPageIndicator(),
                      const SizedBox(
                        height: 10,
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
                        role: widget.data[widget.index].user?.role,
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

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.data[widget.index].reel!.length, // +1 for the initial image
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.5,
          height: 8.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index
                ? AppColors.whiteColor
                : AppColors.whiteColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
