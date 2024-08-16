import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/view_model/get_user_review_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../data/response/status.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/user_view_model.dart';

class ReviewWidget extends StatefulWidget {
  final int? userId;
  const ReviewWidget({super.key, this.userId});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  void initState() {
    super.initState();
    _refreshPlanningList();
  }

  Future<void> _refreshPlanningList() async {
    UserViewModel().getToken().then((value) {
      Provider.of<GetUserReviewViewModel>(context, listen: false)
          .userReviewGetApi(value!, widget.userId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserReviewViewModel>(
      builder: (context, value, child) {
        switch (value.userReviewData.status) {
          case Status.LOADING:
            return const PlanningShimmer();
          case Status.ERROR:
            return Container();
          case Status.COMPLETED:
            return value.userReviewData.data == null || value.userReviewData.data!.data!.data!.isEmpty
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
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            data:
                                '${value.userReviewData.data?.data?.data?.length} Reviews',
                            fSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.blackTextColor,
                          ),
                          const CustomText(
                            data: ' (',
                            fSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.tileTextColor,
                          ),
                          const Icon(
                            Icons.star_rounded,
                            size: 15,
                            color: AppColors.amberColor,
                          ),
                          CustomText(
                            data:
                                '${value.userReviewData.data?.data?.rating} )',
                            fSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.tileTextColor,
                          ),
                          // const Spacer(),
                          // const CustomText(
                          //   data: 'See all',
                          //   fSize: 15,
                          //   fontWeight: FontWeight.w800,
                          //   color: AppColors.mainColor,
                          //   decorationColor: AppColors.mainColor,
                          //   decoration: TextDecoration.underline,
                          // ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        itemCount:
                            value.userReviewData.data?.data?.data?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var ratingData =
                              value.userReviewData.data?.data?.data?[index];
                          DateTime utcDateTime =
                              DateTime.parse('${ratingData?.createdAt}')
                                  .toUtc();
                          DateTime localDateTime = utcDateTime.toLocal();
                          String formattedDate =
                              DateFormat('d MMMM yyyy   @hh:mma')
                                  .format(localDateTime);
                          formattedDate = formattedDate.replaceFirst(
                              '${localDateTime.day}', '${localDateTime.day}');
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                  height: 15,
                                  thickness: 1,
                                  color: AppColors.deviderColor),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${ratingData?.user?.profileImageUrl}',
                                      height: 42,
                                      width: 42,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              data: ratingData?.user?.name ??
                                                  'Selina Gomez',
                                              fSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.tileTextColor,
                                            ),
                                            RatingBar(
                                              initialRating: ratingData?.rating
                                                      ?.toDouble() ??
                                                  0.0,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              ignoreGestures: true,
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
                                                  color:
                                                      AppColors.greyTextColor,
                                                ),
                                              ),
                                              itemSize: 18.0,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              onRatingUpdate: (double value) {},
                                            ),
                                          ],
                                        ),
                                        CustomText(
                                          data: formattedDate,
                                          fSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.tileTextColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              CustomText(
                                data: '${ratingData?.comment}',
                                fSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.tileTextColor,
                              ),
                              const SizedBox(height: 5),
                              const Divider(
                                  height: 15,
                                  thickness: 1,
                                  color: AppColors.deviderColor),
                            ],
                          );
                        },
                      ),
                    ],
                  );
          default:
            return Container();
        }
      },
    );
  }
}
