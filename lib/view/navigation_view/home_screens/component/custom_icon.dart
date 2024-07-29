import 'package:airjood/view/navigation_view/home_screens/screen_widget/planning_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/add_remove_like_view_model.dart';
import '../../../../view_model/comment_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import '../screen_widget/comment_widget.dart';

class CustomIcon extends StatefulWidget {
  final int? reelsId;
  final int? experianceId;
  final String? videoUrl;
  final String? videoImage;
  int? likeCount;
  bool? isLike;
  final int? index;
  final String? name;
  final String? description;
  final Function? onLikeTap;
  final Function? commentAdd;
  int? commentCount;
  final String? screen;
  final String? commentOpen;
  final int? price;
  final int? rating;
  CustomIcon(
      {super.key,
      this.reelsId,
      this.videoUrl,
      this.videoImage,
      this.likeCount,
      this.isLike,
      this.index,
      this.name,
      this.description,
      this.onLikeTap,
      this.commentCount,
      this.commentAdd,
      this.screen,
      this.experianceId,
      this.commentOpen,
      this.price,
      this.rating});

  @override
  State<CustomIcon> createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  late String _linkMessage;
  bool _isCreatingLink = false;

  late FirebaseDynamicLinks dynamicLinks;

  @override
  void initState() {
    super.initState();
    dynamicLinks = FirebaseDynamicLinks.instance;
    if (widget.commentOpen == 'Open') {
      commentSheet();
    }
  }

  void commentSheet() {
    UserViewModel().getToken().then((value) {
      Provider.of<CommentViewModel>(context, listen: false)
          .commentGetApi(value!, widget.reelsId!);
    }).then((value) {
      showModalBottomSheet(
        backgroundColor: Colors.white,
        elevation: 0,
        context: context,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.84,
          minWidth: MediaQuery.of(context).size.width,
        ),
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => CommentWidget(
            reelsId: widget.reelsId, commentAdd: widget.commentAdd),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://airjood.page.link',
      link: Uri.parse('https://airjood.page.link/reels/${widget.reelsId}'),
      androidParameters: const AndroidParameters(
        packageName: 'com.airjood',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.airjood',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: '${widget.name} on Airjood',
        description: widget.description ??
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
        imageUrl: Uri.parse(widget.videoImage!),
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  void _shareContent() async {
    await _createDynamicLink(true);
    if (_linkMessage.isNotEmpty) {
      Share.share(_linkMessage);
    } else {
      Share.share('');
    }
  }

  void handleLike() {
    widget.onLikeTap!();
    Map<String, dynamic> data = {"is_like": !(widget.isLike ?? true)};
    UserViewModel().getToken().then((token) async {
      await Provider.of<AddRemoveLikeViewModel>(context, listen: false)
          .addReelsRemoveLikeApi(
        token!,
        widget.index!,
        data,
        widget.reelsId!,
        context,
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.screen == 'Laqta'
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        context: context,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.85,
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        isScrollControlled: true,
                        // showDragHandle: true,
                        builder: (_) => PlanningWidget(
                          experianceId: widget.experianceId,
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/svg/planning.svg',
                      height: 25,
                    ),
                  ),
            const SizedBox(height: 5),
            widget.screen == 'Laqta'
                ? const SizedBox()
                : const CustomText(
                    data: 'Planning',
                    fSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteTextColor,
                  ),
            const SizedBox(height: 5),
            InkWell(
              onTap: handleLike,
              child: widget.isLike == true
                  ? Image.asset(
                      'assets/icons/heart.png',
                      height: 25,
                      width: 25,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      'assets/svg/heart.svg',
                      height: 25,
                      width: 25,
                    ),
            ),
            const SizedBox(height: 5),
            CustomText(
              data: '${widget.likeCount ?? 0}',
              fSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteTextColor,
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                UserViewModel().getToken().then((value) {
                  Provider.of<CommentViewModel>(context, listen: false)
                      .commentGetApi(value!, widget.reelsId!);
                }).then((value) {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    context: context,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.84,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (_) => CommentWidget(
                        reelsId: widget.reelsId, commentAdd: widget.commentAdd),
                  );
                });
              },
              child: SvgPicture.asset(
                'assets/svg/comment.svg',
                height: 25,
              ),
            ),
            const SizedBox(height: 5),
            CustomText(
              data: '${widget.commentCount ?? 0}',
              fSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteTextColor,
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                _shareContent();
              },
              child: SvgPicture.asset(
                'assets/svg/share.svg',
                height: 25,
              ),
            ),
            const SizedBox(height: 5),
            const CustomText(
              data: 'Share',
              fSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteTextColor,
            ),
            const SizedBox(height: 5),
            widget.screen == 'Laqta'
                ? const SizedBox()
                : CustomPopup(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                    content: CustomText(
                      data: '\$${widget.price}',
                      fSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainColor,
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/pricing.svg',
                      height: 25,
                    ),
                  ),
            const SizedBox(height: 5),
            widget.screen == 'Laqta'
                ? const SizedBox()
                : const CustomText(
                    data: 'Pricing',
                    fSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteTextColor,
                  ),
            const SizedBox(height: 5),
            widget.screen == 'Laqta'
                ? const SizedBox()
                : CustomPopup(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 18,
                          color: AppColors.amberColor,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          data: '${widget.rating}',
                          fSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/rating.svg',
                      height: 25,
                    ),
                  ),
            widget.screen == 'Laqta'
                ? const SizedBox()
                : const SizedBox(height: 5),
            widget.screen == 'Laqta'
                ? const SizedBox()
                : const CustomText(
                    data: 'Reviews',
                    fSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteTextColor,
                  ),
          ],
        ),
      ),
    );
  }
}
