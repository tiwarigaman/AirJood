import 'dart:ui';

import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/res/components/custom_shimmer.dart';
import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/addones_list_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/content_details_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/facilities_list_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/tabbar_widget.dart';
import 'package:airjood/view_model/get_experience_review_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../data/response/status.dart';
import '../../../../../res/components/customiconbutton.dart';
import '../../../../../view_model/upload_experiance_view_model.dart';
import '../../../../../view_model/user_view_model.dart';
import '../../screen_widget/video_player.dart';
import '../book_now/book_now_main_screen.dart';

class UploadExperienceDetails extends StatefulWidget {
  final int? id;
  final String? screen;
  const UploadExperienceDetails({super.key, this.id, this.screen});

  @override
  State<UploadExperienceDetails> createState() =>
      _UploadExperienceDetailsState();
}

class _UploadExperienceDetailsState extends State<UploadExperienceDetails> {
  @override
  void initState() {
    super.initState();
    fetchExperianceData();
  }

  Future<void> fetchExperianceData() async {
    UserViewModel().getToken().then((value) async {
      final experianceProvider =
          Provider.of<UploadExperianceViewModel>(context, listen: false);
      await experianceProvider.getUploadExperianceListApi(value!, widget.id!);
      Provider.of<GetExperienceReviewViewModel>(context, listen: false)
          .experienceReviewGetApi(value, widget.id!);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F1F8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  data: 'Details',
                  color: AppColors.blackTextColor,
                  fontWeight: FontWeight.w700,
                  fSize: 22,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(CupertinoIcons.xmark),
                ),
              ],
            ),
          ),
          Consumer<UploadExperianceViewModel>(
            builder: (context, value, child) {
              switch (value.getUploadExperianceData.status) {
                case Status.LOADING:
                  return const ShimmerScreen();
                case Status.ERROR:
                  return Container();
                case Status.COMPLETED:
                  DateTime? createdAt =
                      value.getUploadExperianceData.data?.startDate;
                  String formattedTime =
                      DateFormat('h:mm a').format(createdAt ?? DateTime.now());
                  DateTime? createdAt2 =
                      value.getUploadExperianceData.data?.endDate;
                  String formattedTime2 =
                      DateFormat('h:mm a').format(createdAt2 ?? DateTime.now());
                  return Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerWidget(
                                        name: value.getUploadExperianceData.data
                                            ?.reel?.user?[0].name,
                                        language: value.getUploadExperianceData
                                            .data?.reel?.user?[0].languages,
                                        about: value.getUploadExperianceData
                                            .data?.reel?.user?[0].about,
                                        dateTime: value.getUploadExperianceData
                                            .data?.reel?.user?[0].createdAt,
                                        userId: value.getUploadExperianceData
                                            .data?.reel?.user?[0].id,
                                        email: value.getUploadExperianceData
                                            .data?.reel?.user?[0].email,
                                        guide: value.getUploadExperianceData
                                            .data?.reel?.user?[0].isUpgrade,
                                        number: value.getUploadExperianceData
                                            .data?.reel?.user?[0].contactNo,
                                        createdAt: value.getUploadExperianceData
                                            .data?.reel?.user?[0].createdAt,
                                        screen: 'Laqta',
                                        image: value
                                            .getUploadExperianceData
                                            .data
                                            ?.reel
                                            ?.user?[0]
                                            .profileImageUrl,
                                        commentCount: value
                                            .getUploadExperianceData
                                            .data
                                            ?.reel
                                            ?.commentCount,
                                        videoUrl:
                                            '${value.getUploadExperianceData.data?.reel?.videoUrl}',
                                        index: 0,
                                        reelsId: value.getUploadExperianceData
                                            .data?.reelId,
                                        isLike: value.getUploadExperianceData
                                            .data?.reel?.liked,
                                        videoImage: value
                                            .getUploadExperianceData
                                            .data
                                            ?.reel
                                            ?.videoThumbnailUrl,
                                        likeCount: value.getUploadExperianceData
                                            .data?.reel?.likeCount,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${value.getUploadExperianceData.data?.reel?.videoThumbnailUrl}',
                                        fit: BoxFit.cover,
                                        height: 300,
                                        width: double.infinity,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: BackdropFilter(
                                        blendMode: BlendMode.srcOver,
                                        filter: ImageFilter.blur(
                                            sigmaX: 120.0, sigmaY: 20.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 300,
                                          color: Colors
                                              .transparent, // Make the container transparent
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.center,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SizedBox(
                                          height: 250,
                                          width: 200,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${value.getUploadExperianceData.data?.reel?.videoThumbnailUrl}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    data:
                                        '\$${value.getUploadExperianceData.data?.price}',
                                    color: AppColors.mainColor,
                                    fSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const CustomText(
                                    data: '/ Experience',
                                    color: AppColors.secondTextColor,
                                    fSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const Spacer(),
                                  RatingBar(
                                    initialRating: value.getUploadExperianceData.data?.rating?.toDouble() ?? 0.0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ratingWidget: RatingWidget(
                                      full: const Icon(
                                        Icons.star_rounded,
                                        color: AppColors.amberColor,
                                      ),
                                      half: const Icon(
                                        Icons.star_half_rounded,
                                        color: AppColors.amberColor,
                                      ),
                                      empty: const Icon(
                                        Icons.star_rounded,
                                        color: AppColors.deviderColor,
                                      ),
                                    ),
                                    ignoreGestures: true,
                                    itemSize: 25.0,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    onRatingUpdate: (double value) {},
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ContentDetailsWidget(
                                name:
                                    '${value.getUploadExperianceData.data?.name}',
                                discription:
                                    '${value.getUploadExperianceData.data?.description}',
                                location:
                                    '${value.getUploadExperianceData.data?.location}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const CustomText(
                                    data: "Availability for persons : ",
                                    fontWeight: FontWeight.w600,
                                    fSize: 14,
                                    color: AppColors.greyTextColor,
                                  ),
                                  CustomText(
                                    data:
                                        "${value.getUploadExperianceData.data?.minPerson}-${value.getUploadExperianceData.data?.maxPerson}",
                                    fontWeight: FontWeight.w800,
                                    fSize: 15,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const CustomText(
                                    data: "Start Time : ",
                                    fontWeight: FontWeight.w600,
                                    fSize: 14,
                                    color: AppColors.greyTextColor,
                                  ),
                                  CustomText(
                                    data: formattedTime,
                                    fontWeight: FontWeight.w800,
                                    fSize: 15,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const CustomText(
                                    data: "End Time : ",
                                    fontWeight: FontWeight.w600,
                                    fSize: 14,
                                    color: AppColors.greyTextColor,
                                  ),
                                  CustomText(
                                    data: formattedTime2,
                                    fontWeight: FontWeight.w800,
                                    fSize: 15,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const CustomText(
                                data: 'Mood : ',
                                fontWeight: FontWeight.w600,
                                fSize: 15,
                                color: AppColors.greyTextColor,
                              ),
                              SizedBox(
                                height: 40,
                                child: ListView.builder(
                                  itemCount: value.getUploadExperianceData.data
                                      ?.mood?.length,
                                  //shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var data = value.getUploadExperianceData
                                        .data?.mood?[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.textFildBGColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 3,
                                              bottom: 3),
                                          child: Center(
                                            child: CustomText(
                                              data: '${data?.mood}',
                                              color: AppColors.greyTextColor,
                                              fSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              value.getUploadExperianceData.data!.facility!
                                      .isEmpty
                                  ? const SizedBox()
                                  : const CustomText(
                                      data: 'Facilities : ',
                                      fontWeight: FontWeight.w600,
                                      fSize: 15,
                                      color: AppColors.greyTextColor,
                                    ),
                              value.getUploadExperianceData.data!.facility!
                                      .isEmpty
                                  ? const SizedBox()
                                  : FacilitiesListWidget(
                                      count: value.getUploadExperianceData.data
                                          ?.facility?.length,
                                      data: value.getUploadExperianceData.data
                                          ?.facility,
                                    ),
                              AddonesListWidget(
                                data:
                                    value.getUploadExperianceData.data?.addons,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Consumer<GetExperienceReviewViewModel>(
                                builder: (context, val, child) {
                                  switch (val.experienceReviewData.status) {
                                    case Status.LOADING:
                                      return const ShimmerScreen();
                                    case Status.ERROR:
                                      return Container();
                                    case Status.COMPLETED:
                                      return TabBarWidget(
                                        late: double.tryParse(value
                                            .getUploadExperianceData
                                            .data
                                            ?.latitude ??
                                            '') ??
                                            0.0,
                                        lang: double.tryParse(value
                                            .getUploadExperianceData
                                            .data
                                            ?.longitude ??
                                            '') ??
                                            0.0,
                                        data: val.experienceReviewData.data?.data?.data,
                                      );
                                    default:
                                  }
                                  return Container();
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const CustomIconButton(
                                data: 'Terms & Conditions',
                                assetName: 'assets/svg/terms.svg',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  if (widget.screen == 'UserDetails') {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      enableDrag: false,
                                      isDismissible: false,
                                      constraints: BoxConstraints.expand(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.90,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width),
                                      isScrollControlled: true,
                                      builder: (_) => BookNowMainScreen(
                                        experienceId: widget.id,
                                      ),
                                    );
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: MainButton(
                                  data: widget.screen == 'UserDetails'
                                      ? 'Book Now'
                                      : 'Close',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                default:
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
