import 'package:airjood/res/components/color.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/show_upload_reels.dart';
import 'package:airjood/view_model/home_reels_view_model.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import '../../../../model/reels_model.dart';

class ShowUploadReels extends StatefulWidget {
  final List<ReelsData> data;
  final int index;
  final String? screen;
  const ShowUploadReels({super.key, required this.data, required this.index, this.screen});

  @override
  State<ShowUploadReels> createState() => _ShowUploadReelsState();
}

class _ShowUploadReelsState extends State<ShowUploadReels> {
  int currentPage = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final homeReelsProvider = Provider.of<HomeReelsViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PreloadPageView.builder(
            controller: PreloadPageController(initialPage: widget.index),
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            physics: const BouncingScrollPhysics(),
            preloadPagesCount: 3,
            itemCount: widget.data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return ShowUploadReelsData(
                image: widget.data[index].user?[0].profileImageUrl,
                about: widget.data[index].user?[0].about,
                screen: widget.screen,
                dateTime: widget.data[index].user?[0].createdAt,
                userId: widget.data[index].user?[0].id,
                email: widget.data[index].user?[0].email,
                guide: widget.data[index].user?[0].isUpgrade,
                language: widget.data[index].user?[0].languages,
                name: widget.data[index].user?[0].name,
                number: widget.data[index].user?[0].contactNo,
                createdAt: widget.data[index].user?[0].createdAt,
                videoUrl: '${widget.data[index].videoUrl}',
                reelsId: widget.data[index].id,
                likeCount: widget.data[index].likeCount,
                videoImage: widget.data[index].videoThumbnailUrl,
                index: index,
                like: widget.data[index].liked,
                commentCount: widget.data[index].commentCount,
                commentAdd: () {
                  setState(() {
                    homeReelsProvider
                        .commentUpdates(widget.data[index].id!);
                    widget.data[index].commentCount =
                        (widget.data[index].commentCount ?? 0) + 1;
                  });
                },
                onLikeTap: () {
                  setState(() {
                    homeReelsProvider.likeUpdates(
                        widget.data[index].liked!, widget.data[index].id!);
                    if (widget.data[index].liked == true) {
                      widget.data[index].likeCount =
                          (widget.data[index].likeCount ?? 0) - 1;
                    } else {
                      widget.data[index].likeCount =
                          (widget.data[index].likeCount ?? 0) + 1;
                    }
                    widget.data[index].liked =
                    !(widget.data[index].liked ?? true);
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
