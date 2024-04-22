import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/view/navigation_view/ExitBar.dart';
import 'package:airjood/view/navigation_view/home_screens/component/read_more_text.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/video_player.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/experience_screens/upload_experience_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../model/get_experiance_model.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/delete_experiance_view_model.dart';
import '../../../../view_model/get_experiance_list_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import '../sub_home_screens/book_now/book_now_main_screen.dart';

class ExperienceListWidget extends StatefulWidget {
  final List<Datum>? list;
  final String? screen;
  const ExperienceListWidget({super.key, this.list, this.screen});

  @override
  State<ExperienceListWidget> createState() => _ExperienceListWidgetState();
}

class _ExperienceListWidgetState extends State<ExperienceListWidget> {
  @override
  Widget build(BuildContext context) {
    final experianceProvider = Provider.of<GetExperianceListViewModel>(context);

    return experianceProvider.data2.isEmpty || experianceProvider.data2 == []
        ? SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/noData.png'),
                height: 200,
                width: 300,
                fit: BoxFit.fill,
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experianceProvider.data2.length,
            itemBuilder: (context, index) {
              final data = experianceProvider.data2[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textFildBorderColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerWidget(
                                      name: data.reel?.user?[0].name,
                                      description: data.description,
                                      commentCount: data.reel?.commentCount,
                                      about: data.reel?.user?[0].about,
                                      dateTime: data.reel?.user?[0].createdAt,
                                      userId: data.reel?.user?[0].id,
                                      email: data.reel?.user?[0].email,
                                      guide: data.reel?.user?[0].isUpgrade,
                                      number: data.reel?.user?[0].contactNo,
                                      createdAt: data.reel?.user?[0].createdAt,
                                      image:
                                          data.reel?.user?[0].profileImageUrl,
                                      language: data.reel?.user?[0].languages,
                                      videoUrl: '${data.reel?.videoUrl}',
                                      isLike: data.reel?.liked,
                                      likeCount: data.reel?.likeCount,
                                      reelsId: data.reel?.id,
                                      screen : 'Laqta',
                                      videoImage:
                                          '${data.reel?.videoThumbnailUrl}',
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: '${data.reel?.videoThumbnailUrl}',
                                  height: 100,
                                  width: 80,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return Container(
                                        height: 100,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color:
                                                  AppColors.textFildHintColor),
                                        ),
                                        child: const Icon(Icons.error));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.6,
                                  child: Text(
                                    "${data.name}",
                                    maxLines: 2,
                                    softWrap: true,
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blackTextColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.6,
                                  child: CustomText(
                                    data: "${data.location}",
                                    fweight: FontWeight.w500,
                                    fSize: 14,
                                    fontColor: AppColors.secondTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBar(
                                  initialRating: 4,
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
                                      color: AppColors.secondTextColor,
                                    ),
                                  ),
                                  itemSize: 25.0,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  onRatingUpdate: (double value) {},
                                ),
                                CustomText(
                                  data: "\$${data.price}",
                                  fweight: FontWeight.w800,
                                  fSize: 19,
                                  fontColor: AppColors.mainColor,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomReadMoreText(
                                content: data.description ??
                                    'Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur Id sit letus morbi null a Tristique',
                                color: AppColors.secondTextColor,
                                mColor: AppColors.mainColor,
                                rColor: AppColors.mainColor,
                                trimLines: 3),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: AppColors.mainColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      constraints: BoxConstraints.expand(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.90,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width),
                                      isScrollControlled: true,
                                      builder: (_) =>
                                          UploadExperienceDetails(id: data.id,screen: widget.screen,),
                                    );
                                  },
                                  child: Text(
                                    'More Details',
                                    style: GoogleFonts.nunitoSans(
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.mainColor,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                if (widget.screen == 'UserDetails')
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        enableDrag: false,
                                        isDismissible: false,
                                        constraints: BoxConstraints.expand(
                                            height: MediaQuery.of(context).size.height * 0.90,
                                            width: MediaQuery.of(context).size.width),
                                        isScrollControlled: true,
                                        builder: (_) => BookNowMainScreen(
                                          experienceId: data.id!,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: AppColors.blueBGShadeColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: CustomText(
                                          data: 'Book Now',
                                          fontColor: AppColors.blueColor,
                                          fSize: 15,
                                          fweight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (_) => CustomExitCard(
                                          icon: CupertinoIcons.delete_solid,
                                          title: 'Delete',
                                          subTitle:
                                              'Are you sure want to Delete Experiences ?',
                                          positiveButton: 'Delete',
                                          negativeButton: 'Cancel',
                                          onPressed: () {
                                            UserViewModel()
                                                .getToken()
                                                .then((value) {
                                              Provider.of<DeleteExperianceViewModel>(
                                                      context,
                                                      listen: false)
                                                  .deleteExperianceApi(value!,
                                                      data.id!, context);
                                            });
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: CustomText(
                                          data: 'Remove',
                                          fontColor: Color(0xFFD43672),
                                          fSize: 16,
                                          fweight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
