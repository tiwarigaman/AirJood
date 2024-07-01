import 'package:airjood/res/components/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/get_experiance_list_view_model.dart';
import '../../../../view_model/get_reels_view_model.dart';
import '../../../../view_model/home_reels_view_model.dart';
import '../component/custom_icon.dart';
import '../component/reels_user.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  int? likeCount;
  bool? isLike;
  final int? index;
  final int? reelsId;
  final String? videoImage;
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
  int? commentCount;
  final String? screen;
  final String? description;
  final String? commentOpen;
  final int? experienceId;
  VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.likeCount,
    this.isLike,
    this.index,
    this.reelsId,
    this.videoImage,
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
    this.commentCount,
    this.description,
    this.screen, this.commentOpen, this.experienceId,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        if (mounted) {
          setState(() {
            _videoPlayerController!.play();
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
    // aspectRatio: _videoPlayerController!.value.aspectRatio,
    final homeReelsProvider = Provider.of<HomeReelsViewModel>(context);
    final reelViewProvider = Provider.of<ReelsViewModel>(context);
    final experianceProvider = Provider.of<GetExperianceListViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: GestureDetector(
        onTap: _togglePlayPause,
        child: Center(
          child: _videoPlayerController!.value.isInitialized
              ? Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController!),
                      ),
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
                          name: widget.name,
                          description: widget.description,
                          likeCount: widget.likeCount,
                          isLike: widget.isLike,
                          index: widget.index,
                          reelsId: widget.reelsId,
                          videoUrl: widget.videoImage,
                          videoImage: widget.videoUrl,
                          commentCount: widget.commentCount,
                          screen: widget.screen,
                          commentAdd: () {
                            setState(() {
                              homeReelsProvider.commentUpdates(widget.reelsId!);
                              widget.commentCount =
                                  (widget.commentCount ?? 0) + 1;
                            });
                          },
                          onLikeTap: () {
                            setState(() {
                              homeReelsProvider.likeUpdates(
                                  widget.isLike!, widget.reelsId!);
                              reelViewProvider.likeUpdates(
                                  widget.isLike!, widget.reelsId!);
                              experianceProvider.likeUpdates(
                                  widget.isLike!, widget.reelsId!);
                              if (widget.isLike == true) {
                                widget.likeCount = (widget.likeCount ?? 0) - 1;
                              } else {
                                widget.likeCount = (widget.likeCount ?? 0) + 1;
                              }
                              widget.isLike = !(widget.isLike ?? true);
                            });
                          },
                          commentOpen: widget.commentOpen,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ReelsUser(
                          name: widget.name,
                          createdAt: widget.createdAt,
                          number: widget.name,
                          guide: widget.guide,
                          email: widget.email,
                          userId: widget.userId,
                          dateTime: widget.dateTime,
                          about: widget.about,
                          language: widget.language,
                          image: widget.image,
                          screen: widget.screen,
                          experienceId: widget.experienceId,
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
