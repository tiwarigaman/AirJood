import 'dart:io';
import 'package:airjood/res/components/custom_shimmer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/add_reels_view_model.dart';
import '../../../../view_model/user_view_model.dart';

class PreviewReelsScreen extends StatefulWidget {
  final String? postVideo;
  final String? thumbnail;
  final String? caption;
  final DateTime? date;
  final int? songId;
  final String? location;
  final String? artName;
  final String? screen;
  const PreviewReelsScreen({
    super.key,
    this.postVideo,
    this.thumbnail,
    this.caption,
    this.date,
    this.location,
    this.songId,
    this.artName,
    this.screen,
  });

  @override
  State<PreviewReelsScreen> createState() => _PreviewReelsScreenState();
}

class _PreviewReelsScreenState extends State<PreviewReelsScreen> {
  VideoPlayerController? _videoPlayerController;

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    getVideoSize(widget.postVideo);
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
    });
    _videoPlayerController = VideoPlayerController.file(
      File(widget.postVideo!),
    )..initialize().then((_) {
        setState(() {
          _videoPlayerController!.play();
          _videoPlayerController!.setLooping(true);
        });
      });
  }

  Future<void> getVideoSize(videoPath) async {
    try {
      File videoFile = File(videoPath);
      final info = await videoFile.length();
      double fileSizeInMB = info / (1024 * 1024);
    } catch (e) {
      if (kDebugMode) {
        print("Error getting video information");
      }
    }
  }

  String? token;

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Center(
            child: _videoPlayerController!.value.isInitialized
                ? Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        ),
                      ),
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const ReelShimmer()
                // : Image.asset(
                //     'assets/images/reels_bg_image.png',
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.height,
                //     fit: BoxFit.fill,
                //   ),
          ),
          _buildPerview(context),
          _buildContaint(context),
        ],
      ),
    );
  }

  Widget _buildPerview(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10 + padding.top),
        child: const Align(
          alignment: AlignmentDirectional.topCenter,
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.whiteTextColor,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              CustomText(
                data: 'Preview',
                color: AppColors.whiteTextColor,
                fSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContaint(BuildContext context) {
    final authViewModel = Provider.of<AddReelViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.location == null || widget.location == ''
              ? const SizedBox()
              : CustomText(
                  data: '${widget.location}',
                  fontWeight: FontWeight.w600,
                  fSize: 16,
                  color: AppColors.whiteTextColor,
                ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle,
                size: 5,
                color: AppColors.whiteTextColor,
              ),
              const SizedBox(
                width: 5,
              ),
              widget.artName == null || widget.artName == ''
                  ? const SizedBox()
                  : CustomText(
                      data: '${widget.artName}',
                      fSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.whiteTextColor,
                    ),
              widget.artName == null || widget.artName == ''
                  ? const SizedBox()
                  : const SizedBox(
                      width: 10,
                    ),
              CustomText(
                data:
                    '${widget.date?.year} . ${widget.date?.month} . ${widget.date?.day}',
                fSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteTextColor,
              ),
    // ${widget.date?.hour} : ${widget.date?.minute}
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          widget.caption == null || widget.caption == ''
              ? const SizedBox()
              : CustomText(
                  data: '${widget.caption}',
                  fontWeight: FontWeight.w400,
                  fSize: 14,
                  color: AppColors.whiteTextColor,
                ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Map<String, String> data = {
                "caption": widget.caption.toString(),
                "location": widget.location.toString(),
                "song_id": '${widget.songId ?? 1}',
                "date_of_shoot":
                    '${widget.date?.year}.${widget.date?.month}.${widget.date?.day} ${widget.date?.hour}:${widget.date?.minute}',
              };
              File file1 = File('${widget.postVideo}');
              File file2 = File('${widget.thumbnail}');
              authViewModel.addReelApi(
                  '${widget.screen}', token!, data, file1, file2, context);
            },
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0x3314C7FF),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: authViewModel.addReelsLoading == true
                    ? const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : const CustomText(
                        data: 'Publish',
                        fontWeight: FontWeight.w500,
                        fSize: 16,
                        color: Color(0xFF14C6FF),
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
